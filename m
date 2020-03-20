Return-Path: <SRS0=v+yc=5F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4474C4332D
	for <git@archiver.kernel.org>; Fri, 20 Mar 2020 15:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72BDB20724
	for <git@archiver.kernel.org>; Fri, 20 Mar 2020 15:56:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dbJR+jxQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727243AbgCTP4M (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Mar 2020 11:56:12 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43474 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727002AbgCTP4M (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Mar 2020 11:56:12 -0400
Received: by mail-pl1-f196.google.com with SMTP id f8so2650246plt.10
        for <git@vger.kernel.org>; Fri, 20 Mar 2020 08:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fVzsW+g5u980mjBeawwYdJuJ2qrhvgO04zcAW9QpzaM=;
        b=dbJR+jxQOB8h0rhW7eVpgWPkZtc/bEOqdgZ82XGCpA2NgwUcAjaqnPF6cClDIXhMBr
         CEfrRzlgi2FgYn37GWF/sbc/EV44HKEKtrlWS/RAEMB5QkQTa6xKHD58T/Q8t5rpqiQS
         e9Q0TE0GVlJY9MQhgp1I7QiSUkfFR5M4liJ8fkd2Y7RXfpNCf4S8oyHjxoedTyeW6YlU
         9CdN6Pufp9z+HCNEr03q/vEJ3tN6XoN/G1RcRMN82Pn49m8E6xMVCyMdwJqjRrYYe1oa
         qRjElepINgUqzH0SrrH2+CO0gQ37eE/yWmkxXMSaBvWL+tu+LLUqLX9kIMkut5c4afrC
         awsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fVzsW+g5u980mjBeawwYdJuJ2qrhvgO04zcAW9QpzaM=;
        b=iCN/0p2ICGLd6N9JZX0kYGAY4tHQ4EGHY8PMaVXaqiz4f/Q359E6R3hZwA1SVX3IZA
         fgCCyrb8CDKR5igsvgS1B5mU3kMkq2DCmCq9+zyA5DMJAT2OC7pF+Pgp5tZBtoIdcTTa
         VTKKZQlmJE2jfLPnDEhfMsMNJgHa2F4gzCP/VtsuOsbMJXw12EvDK6VoqnxBHbbbfeRd
         5WAm1JkeRzvxtkiwH6qUmmyOXXywIijnjhP2Mqk0JeX/dXx3tziKPUDBeGGVfU0jDVXt
         GK83VJKi6Bxz7dlf5U+ffMpP23AoqPW7yAsJMj+6lzqzfO8/AGRff6OrFtvpYCoVMIwA
         pOog==
X-Gm-Message-State: ANhLgQ1Kgi7ERyowyF5bgVQ/P6QKVuWJMEHHwQUIynkyrYTwaEP01Q7j
        FhWPpmlFi3JvTUTVDbJtF+0x4f23I230z6CN
X-Google-Smtp-Source: ADFU+vvSuNeVCgd2a68ZXgy04ky/+0pAiMzB2GyP6ZaxMK/edUcgqVFp8FHu9eSZ9kb+OD6OZP6T+g==
X-Received: by 2002:a17:90b:3683:: with SMTP id mj3mr9990232pjb.153.1584719770860;
        Fri, 20 Mar 2020 08:56:10 -0700 (PDT)
Received: from konoha.iitr.ac.in ([103.37.201.171])
        by smtp.gmail.com with ESMTPSA id g10sm6055838pfk.90.2020.03.20.08.56.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 08:56:09 -0700 (PDT)
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     harshitjain1371999@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com,
        Shourya Shukla <shouryashukla.oo@gmail.com>
Subject: Re: Re: [GSoC][Patch]
Date:   Fri, 20 Mar 2020 21:26:04 +0530
Message-Id: <20200320155604.7854-1-shouryashukla.oo@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200320130845.23257-2-harshitjain1371999@gmail.com>
References: <20200320130845.23257-2-harshitjain1371999@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Harshit,

> The tests in t4131 leave a space character between the redirection operator
> and the file i.e. the redirection target which does not conform to the
> modern coding style.

> Fix them.

I think something like,

The tests in t4131 were written a long time ago and hence contain style violations
such as an extra space between the redirection operator(>) and the redirection target.
Update it to match the latest CodingGuidelines.

may be better.

Also, when you deliver a newer version of the patch, i.e., version 2 in your case,
you have a [PATCH v2 1/n] as the subject, so that people know that it is the v2 and
hence avoid confusion.

If you are using 'git format-patch' to formulate your mails, you can do:

'git format-patch -v2 <..>' to get a v2 based mail.

Regards,
Shourya Shukla

