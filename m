Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B46851F51C
	for <e@80x24.org>; Thu, 24 May 2018 10:21:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031275AbeEXKVt (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 May 2018 06:21:49 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:43890 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031190AbeEXKVr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 May 2018 06:21:47 -0400
Received: by mail-wr0-f195.google.com with SMTP id r13-v6so2076524wrj.10
        for <git@vger.kernel.org>; Thu, 24 May 2018 03:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Tse4EcKumRsJrvedbxz66MXKraAlJOrHj+qsH1RqcTA=;
        b=kYSrcFSD11ryPheN1HTIqLe+oOEpDuLSkNJ4yx74mlFJfNmMgZfjxTcw6eF3q2ZLRr
         vCGJBi5VAVDKAlP9VmWJ0t5ZX4Egs+JCx6ltQSgovI8pc9ckvagloFqE+QK4UBvLL1Oe
         Muq0Fdop41PQHjW1GszY2ppsgw8CFpI2OkxJalv80K1sif4JCxYqUr/fP+vBvcA3CV7D
         YJLUfJAHXRdHaWjRG3IJM8eO49u956TowokIyvuE6trhvkcXXAYe50971s8JaENLXDZr
         JN59BzoZfG11axEb196dpAnFKdkh1BBwyfzACPPl1TSsGkVSmnGkSNGIzzrdGNo+vu+K
         mS4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Tse4EcKumRsJrvedbxz66MXKraAlJOrHj+qsH1RqcTA=;
        b=PgL+wSIWuokV80Kq3tWHTVIAXbu1SbFPFNdx8jrr5ng7Kw1lmSkUpPi27KLwgh3St+
         CwpvFcSWKx/gsOYHsSwStf7tp+X9ZtggInxOyEVGnQWCxMYmxGsufH3RN2x/oE7T+6gN
         af/cdeEfIQQTCbzosdhSbboA21MiuAXgKP964HGu51qNRTanDt/IVL5MZw54DH+pr5T8
         iha7qit/cDwNEWkN8SiAixffMPF6HZW49Non+zJMY75l+OO47vVXkJ75cU2LhFwv/VjQ
         zYZmqBukNO2eHJUCRjTdHqA4VGYQMak6Zjwa5eucVz9yGKncf+28j+I01k8IznezxE0K
         JYmw==
X-Gm-Message-State: ALKqPweMTZyaDrubpj/G4EuqqhFpDHoTFZGo+iTHUt6hRvyVe5FfKlAX
        VwX8Agskp1vX6W38FoqD2g8=
X-Google-Smtp-Source: AB8JxZpZriBU5cvgzP8HFE35vBLSqUSfyAWfTXGzIcM/pCpV8l69OUC2xIc9wPilgGGsdlHYab/jyw==
X-Received: by 2002:adf:a9aa:: with SMTP id b39-v6mr6046988wrd.36.1527157305852;
        Thu, 24 May 2018 03:21:45 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id x16-v6sm5668843wrp.94.2018.05.24.03.21.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 May 2018 03:21:45 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC/PATCH 7/7] rerere: teach rerere to handle nested conflicts
References: <20180520211210.1248-1-t.gummerer@gmail.com>
        <20180520211210.1248-8-t.gummerer@gmail.com>
Date:   Thu, 24 May 2018 19:21:44 +0900
In-Reply-To: <20180520211210.1248-8-t.gummerer@gmail.com> (Thomas Gummerer's
        message of "Sun, 20 May 2018 22:12:10 +0100")
Message-ID: <xmqqefi1qrpj.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

> No automated test for this yet.  As mentioned in the cover letter as
> well, I'm not sure if this is common enough for us to actually
> consider this use case.  I don't know how nested conflicts could
> actually be created apart from committing a file with conflict
> markers,

Recursive merge whose inner merge leaves conflict markers?

One thing that makes me wonder is that the conflict markers may not
"nest" so nicely.  For example, if inner merges had two conflicts
like these:

<<<
 <<<<<
 A
 =====
 B
 >>>>>
===
 <<<<<
 A
 =====
 C
 >>>>>
>>>

where one side made something to A or B, while the other side made
something (or something else) to A or C, I would imagine that the
outer conflict could be "optimized" to produce this instead:


 <<<<<
 A
 =====
<<<
 B
===
 C
>>>
 >>>>>

