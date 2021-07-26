Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CCB3C4338F
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 19:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13F6060F93
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 19:02:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233704AbhGZSVo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jul 2021 14:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233770AbhGZSVl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jul 2021 14:21:41 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86531C0613D5
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 12:02:07 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id w6so12103416oiv.11
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 12:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=atW22xDfXXs27veOQ216R0jJaml8K89bUUFKEBePu+o=;
        b=anI+n5cE1GptT8m+tT+WfwmH3K3tnntosis8vZRCmh1gMKij1Z2OSwZUpRxNKP7jsL
         frfq6F1FYig/P5aGx1IVVTQpsbHSPEL8uCcwIQdDiFzdFoXjEbIbZ4r52cgg96HU4qi5
         dPFkIb3ZHECPuN7ROc9Pr2mGpjdJUwQAWsCAZoRq2kCU9TkFpFZC3TP6nwu7UhpsRlv1
         TvfYP6YUOcbkbQDV7qa4atZwh7U4++iJRCFwx4HIWXFTI15tFkF9pTHx0UmMjU3da3gT
         x7zTRqITtuPr5VKpcpDhV1VAUMSwJsru1y5L5srRane9lQkfAnN5iN3aW5GlQoUw4cbO
         CKsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=atW22xDfXXs27veOQ216R0jJaml8K89bUUFKEBePu+o=;
        b=TPii/8IpNffPnm52IDyhiunIat+NcL/732OzzWAk7wgl4qtU1+cqxbgzGLZTf6OlSl
         u+ywI1NsAqxcpe405srkXeAJXvD2oepeM1iPcCRJjvt2JjpjLn26WYC8UC0zuaKRH8Kv
         yXdWshGT820rqFN2V2h+q5zoTWryMl/ibFZwvZZu6IiKvnBCP2g4thAd5kww557PwqJv
         JFUIhMtVJAUW5nksrMjMDByezcsI865pH9FRVuLyVJlW1rTMGZ9eFIGW6aiwDKiy66P6
         wNCqB7O2Q0ZEvJGdX7up4Jmu8Lp3rnU496JHNmD1byZIFu6mfOPHfaJiCvHchOFFJAGZ
         bzTA==
X-Gm-Message-State: AOAM5300ppjYfZ/cgE3ADhichpSQO6ZODhSDE2njsxRMWZTLfbL6if1B
        VfT1HVWQt5CfjEO6wKMJbGw=
X-Google-Smtp-Source: ABdhPJxam/LkiWfNzpj9J5COXNtTEjd7n6s04NymZrCYteP3IKh33ISjobkd0TgmUusU6U7NKM2TCw==
X-Received: by 2002:aca:3085:: with SMTP id w127mr316549oiw.101.1627326126959;
        Mon, 26 Jul 2021 12:02:06 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id x73sm145326oif.44.2021.07.26.12.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 12:02:06 -0700 (PDT)
Date:   Mon, 26 Jul 2021 14:02:05 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Atharva Raykar <raykar.ath@gmail.com>, git@vger.kernel.org
Cc:     Christian Couder <christian.couder@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        avarab@gmail.com, Emily Shaffer <emilyshaffer@google.com>
Message-ID: <60ff06ad2b298_31bb20891@natae.notmuch>
In-Reply-To: <90b6bd2d-71e1-b8af-e027-8023f8d4f14c@gmail.com>
References: <90b6bd2d-71e1-b8af-e027-8023f8d4f14c@gmail.com>
Subject: RE: [GSoC] A small survey + My Git Blog, week 10
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Atharva Raykar wrote:
> As for the "survey part", jump to the section here:
> https://atharvaraykar.me/gitnotes/week10#the-mailing-list-developer-wor=
kflow
> =

> ...feel free to reply in this thread.

It would have been nice to copy the survey on the email.

> What tools, systems and workflows do you find valuable in your
> day-to-day work? In particular I=E2=80=99d be happy getting insights li=
ke:
> =

> * Any strategy or approach to work, kind of like the example I quoted
>   above
> * Any scripts and tools that assist you
> * Opinionated handling of multiple in-flight series and methods to
>   approaching reviews
> * Atharva, you are overthinking this! I just use a straightforward {
>   editor + MUA + git } stack and go with the flow!

Personally I use mbsync + notmuch + notmuch-vim + vim + msmtp. You can
watch an example session in asciinema.org [1].

This deals with the filtering issue that you talked about in your blog
post, for example one of the latest queries I ran is
"from:felipe subject:mergetool", plus there's tags so I can mark
messages with "inbox", "git", or "to-do".

Of course you can use emacs instead of vim, but I use vim.

Haveing all the feedback readily available helps me address it easily.

For me notmuch is like git for mail.

Cheers.

[1] https://asciinema.org/a/oo4yUOQDDF2CrWZbzhZURFtTW

-- =

Felipe Contreras=
