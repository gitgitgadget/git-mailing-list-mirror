Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A406FC433E0
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 19:18:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 752DB64EC9
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 19:18:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233670AbhBWTRq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Feb 2021 14:17:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232155AbhBWTRk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Feb 2021 14:17:40 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00CB8C06178B
        for <git@vger.kernel.org>; Tue, 23 Feb 2021 11:16:59 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id 204so12391740qke.11
        for <git@vger.kernel.org>; Tue, 23 Feb 2021 11:16:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=iOVIgDOkxf/W0Gyoi14wYshIoZ65cU+tT42XKlCtkD0=;
        b=fFPk9UM7vT7hbiijIpLlDzqkUPKIKAhbW5N6epGNiJieg9YHu1IasCQ8WeRo5ILu3s
         gsXTPnbYEUrw21zKc5PWdMiuSC9ISrqnKENOeDprq/JVtsS+DRZ5CSbpRTWOia6+Fat+
         6k1jWgqOUBFDl4DpjKyz+BuG/nqzKXaoG72NtXMO8scn/z9ZABqB/lK39B7jBWSIPh2o
         Fr+MrkKJdUxRovGgIdMyNuAjpg+pc9sApq8dQVPGzR5KeZG7/UZKSJ2LDmROhyumUHIl
         mT8UCPSM4z0OXpxc3XUy0P5Qoe2lfUPpkcTSXY0PBwJCWetEi/Niwuv/vs7a67rWdwAS
         rnBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=iOVIgDOkxf/W0Gyoi14wYshIoZ65cU+tT42XKlCtkD0=;
        b=tVn8VI9W6sPgqQnIv53Y1K1gtZlrXsK8MNpHxR9H8oRWWEdV1z3zRlnML8r3JYleZH
         ec1IblXntQTa806iPekn3CC6APnBgJ5k4psQC0RSflZM/EMBVAjB07h6zfTqHc4HMESX
         eASt4Qjeb22JYeLqdlfblAO1F/YT7eZnzW0fnAYjYmSQ+0O1d29MHud0Z0XbRPgGXLVi
         8oChrJm5L6JcO4caqXwVvtIDiHFFyO2PV3cHmXhl1ESJdYaGU0pe98rEyv0keW75oKuH
         sl8fx0OjDsGYgPEspWm8zhjikM+m+ydDWaDqpOxbqmlMzaV0lJQNbo7y6/jEBqmYfRdy
         JzeQ==
X-Gm-Message-State: AOAM533tklCWXVBPUTT+TgvyzkSlzM7mOhREE2fH+HFU9jeCvpjExJeJ
        E/6pFoDH9w6sOoKFO50WDC0=
X-Google-Smtp-Source: ABdhPJwWiU4U8BxcxzpDlr3lyh91nub6rGdBWRLkfAQs32A1d/TcaIKbfe35TF06Hpodpbkk1WzRsw==
X-Received: by 2002:a37:688f:: with SMTP id d137mr2036241qkc.246.1614107819199;
        Tue, 23 Feb 2021 11:16:59 -0800 (PST)
Received: from [192.168.103.12] (cpe00fc8d50b7d3-cm00fc8d50b7d0.cpe.net.fido.ca. [72.141.221.184])
        by smtp.gmail.com with ESMTPSA id a9sm6999335qtx.96.2021.02.23.11.16.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Feb 2021 11:16:58 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH v2] doc: `--date` in `git-commit` accepts approxidates
From:   Utku <ugultopu@gmail.com>
In-Reply-To: <CAEeqB6kqZTft9NWtOvm3hk9bicBL7GU_WYuAGdMG1MHYMgNAxg@mail.gmail.com>
Date:   Tue, 23 Feb 2021 14:16:57 -0500
Cc:     Utku Gultopu via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <92F10D2F-839A-440E-AECD-99D383409785@gmail.com>
References: <pull.969.git.git.1614101746491.gitgitgadget@gmail.com>
 <pull.969.v2.git.git.1614106322760.gitgitgadget@gmail.com>
 <YDVSICgBwPLtDNu4@coredump.intra.peff.net>
 <CAEeqB6kqZTft9NWtOvm3hk9bicBL7GU_WYuAGdMG1MHYMgNAxg@mail.gmail.com>
To:     Jeff King <peff@peff.net>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I thought it is good to refer the reader to _somewhere_ for
completeness, since those two examples do not cover all cases. Since
there is no documentation for it, I referred the reader to the code.
