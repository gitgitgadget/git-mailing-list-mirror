Return-Path: <SRS0=IlH6=24=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89ABBC33C8C
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 15:28:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4876320715
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 15:28:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bwEfVji4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728335AbgAGP22 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jan 2020 10:28:28 -0500
Received: from mail-wm1-f51.google.com ([209.85.128.51]:37806 "EHLO
        mail-wm1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728103AbgAGP21 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jan 2020 10:28:27 -0500
Received: by mail-wm1-f51.google.com with SMTP id f129so19870026wmf.2
        for <git@vger.kernel.org>; Tue, 07 Jan 2020 07:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:reply-to:to:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lP7C6v8Bcb6nRW98Q7nW7jCuK3SrInsOKNHidB6D2n0=;
        b=bwEfVji4NxrEynAQG+8wE+OOJ3R9i7M1UIbUyUNcfkR8En4R06OxFY9AxVAsd/k+BF
         bFp1b8IR4tkB0/2qHurnGFcy26+DG09HbRCiEzMP4oH4dbaUq0CODEspXfruw+wXLESO
         yiRldnG1W4+jGqzUDm/GTt77ou0m3endaYdhfwgPB5EPYN2Cw90sj9qABilj9kVMTFCP
         tGJuV4SXlvqzIa3XH6Zx8HTgKzyBBoxdS7jr1O8gj3jfxjIj0OLWuKiZNkb+GPdHO2uA
         ZJn21gW31bQpNh8knLw77nrPI3NhfUZxhssW3HlCjNqcMlIX7kV4oWy0/kEpZEbVldC8
         wIDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:reply-to:to:date
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=lP7C6v8Bcb6nRW98Q7nW7jCuK3SrInsOKNHidB6D2n0=;
        b=hamwXRicBHX7z6r9ODN8AwPIzM3nb4k+Shue34MPxSQMNPXQkV+cNssoSlnbSxKt5N
         RjtqNy5vXgYEPJgua8VGMS7HPCJ4bcBmUwbjAYpwcZd+miqdADekuOga/4/3DOfVP+og
         4q9e/WEzrxpK7Gv1ZXPGq7hFkdpVU3HE6oFY7RsIxUFDnOAOdcxQOmUT+nBwMDoWWryJ
         l+CB2/NR7/IkDjjTDVZ00DeTMB+nrukiNdBvqNny9mVKTUo3lMO9wtuFPBPFrr4M//fS
         Lo9sVKaBmH2EIGvzNMLL+hEZVPs1p0URKiBCB48nkmfiBL+2zHYAzqAyX80WkF9CciA9
         wwQg==
X-Gm-Message-State: APjAAAVGQszAiMl3OisjsU4EHTOMmFrmuXTQmDHgByfHTXjTjzFeNwRF
        XXe+DKHk9h7Awj7qcNRS4Ea5pDfU
X-Google-Smtp-Source: APXvYqxRkjXbKc+JekOtKNCQDpffBwirCoV+9xTlrsjEgqL7ZIRds53TwzU7d3ISNIuhSZEHLMOOlA==
X-Received: by 2002:a1c:4454:: with SMTP id r81mr40047915wma.117.1578410905749;
        Tue, 07 Jan 2020 07:28:25 -0800 (PST)
Received: from torstenknbl.mgm-edv.de ([185.40.248.10])
        by smtp.googlemail.com with ESMTPSA id y6sm212298wrl.17.2020.01.07.07.28.24
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Jan 2020 07:28:24 -0800 (PST)
Message-ID: <f0638fc0d09c213b661d2b244d3457f362daebe0.camel@gmail.com>
Subject: Re: Broken branch after git commit - tracked files in staging area
 can't be removed with restore --staged, or commit or stash
From:   Torsten Krah <krah.tm@gmail.com>
Reply-To: krah.tm@gmail.com
To:     git@vger.kernel.org
Date:   Tue, 07 Jan 2020 16:28:24 +0100
In-Reply-To: <234df85965f8a685be5e563fe795ed477f359d7c.camel@gmail.com>
References: <07c84224bb0b093ab3770be9b5ab2ec23ce2d31a.camel@gmail.com>
         <234df85965f8a685be5e563fe795ed477f359d7c.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am Dienstag, den 07.01.2020, 14:43 +0100 schrieb Torsten Krah:
> Although restore --staged moved my unwanted files away from the
> staging
> area and "git status" told me that they are not "in" the commit the
> commit itself did still include them.

I can reproduce that (locally) at least:

What does *not* work for me:

   git clone XX main
   cd main
   git fetch XX && git checkout FETCH_HEAD
   git checkout -b TEST
   git reset --soft HEAD~1
   git restore --staged $FILES

git status now lists $FILES as unstaged and they are not included in
the staging area.

   git commit

-> now $FILES are included in the commit (I would expect them not to be
included - right?) and git status does list those still in the working
area.

What does work:

   git clone XX main
   cd main
   git fetch XX && git checkout FETCH_HEAD
   git checkout -b TEST
   git reset --soft HEAD~1
   git reset HEAD $FILES

git status now lists $FILES as unstaged and they are not included in
the staging area.

   git commit

produces a commit where $FILES are not included and they are still in
the working area, unstaged - like expected.



git status tells me this in the staging area part:

Changes to be committed:
  (use "git restore --staged <file>..." to unstage)

I did that and its not working (for me) - looks at least like a bug or
I am doing something wrong and I am just too dumb at the moment to see
my failure.

Cheers

Torsten

PS: $FILES are files which are all "new" and first time added in the
commit I want to modify with restore.

PPS: The second problem with those staged deleted, unstageable,
uncomittable files still persists in my copy of those branch (I can't
reproduce that - still I have the repository in that state).


