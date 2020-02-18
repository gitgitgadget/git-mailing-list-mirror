Return-Path: <SRS0=PlGQ=4G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7AA6C34048
	for <git@archiver.kernel.org>; Tue, 18 Feb 2020 17:08:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D4D820801
	for <git@archiver.kernel.org>; Tue, 18 Feb 2020 17:08:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YyzEd16n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727727AbgBRRIM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Feb 2020 12:08:12 -0500
Received: from mail-wm1-f42.google.com ([209.85.128.42]:37562 "EHLO
        mail-wm1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbgBRRIM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Feb 2020 12:08:12 -0500
Received: by mail-wm1-f42.google.com with SMTP id a6so3755879wme.2
        for <git@vger.kernel.org>; Tue, 18 Feb 2020 09:08:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=wV04z/nCytS2pH5kahTIobSb8Va01UnJmu1SQQ8Gd3I=;
        b=YyzEd16nPxbjwtjVYxljBJBMWTn/DlxMEObakqJvgjpNlg9uRgchUh2lUpl/NVCukO
         jqwDNWtngooaBqrGLTU7b55ouyIdQbUWeLLwXF3OOc9dTMGhoAviV3ctLkf+Dfkik29C
         JPyNJdH8LBGpFsOUGAOHUDT+F5iYn16NcbpOEz9QQNuab1Lp7UfE4PPWz87MljtnmuGj
         jXIaiRkIT4lLGCke0NzTCjHb59l7YAdOsaF6S5uXjg9pMWzq2Q1ErEhJpfcv4AWV69Fy
         mXU+swFOm8gaTr2qWnsZTc8rLmMXIjpgr2XKAUHAhdymd6lJdbdEbImTvpTro2hYy188
         PmdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=wV04z/nCytS2pH5kahTIobSb8Va01UnJmu1SQQ8Gd3I=;
        b=VviOaNnrBtAPyQR/Z+1VEjHreE7Fh/pKIbmklt+2d1Qzp/Hlze9aYtcYHFlm613dlS
         yNzi0GNOTI1UHb14bgjQTkcGX3xXb8hq6oHmfX3iAN7KzGM+7Px1oltjXbry/8RTGuVc
         eMLZsH86RLSWKhE5FO07cEjJp/9h7ZI7reBAIDp/VeJuC3aIzOZzR/q0rC8mWNNNKJN5
         iRNLbGSKo5mbBVdcx4VHZqJLTbOuah6ctbYC4aU/ZoRt1R0KLxXh0mEAW/D3L0/IjmrW
         6JNXjEwVMDuEtmnOBixbx8gn0T46HYhq6aPd27SLJo8b0ScKk4l+2QI0hOr6FSHtxLM8
         WD6w==
X-Gm-Message-State: APjAAAXahAsVJHyic8PF0+NDRhJ4t/vyde6fM0zfvwP6wErvuoKyDSfJ
        svTFgG2Ve1PxIBAUeQqlTJM=
X-Google-Smtp-Source: APXvYqxMQ0hFGBpYn6i5H4ae3YpTtUHUzVKnDHXiUZlUFUS86cLThEXygvNBEfEu4ml4nbd+VmBKqA==
X-Received: by 2002:a05:600c:230d:: with SMTP id 13mr4392148wmo.12.1582045690954;
        Tue, 18 Feb 2020 09:08:10 -0800 (PST)
Received: from mithrim ([147.210.21.27])
        by smtp.gmail.com with ESMTPSA id o4sm6943714wrx.25.2020.02.18.09.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 09:08:10 -0800 (PST)
Date:   Tue, 18 Feb 2020 18:08:08 +0100
From:   Damien Robert <damien.olivier.robert@gmail.com>
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Nested submodule checkout
Message-ID: <20200218170808.dh4s65b475yqs3oz@mithrim>
X-PGP-Key: http://www.normalesup.org/~robert/pro/files/Damien_Olivier_Robert.asc
X-Start-Date: Tue, 18 Feb 2020 17:49:44 +0100
References: <20200214224242.knmzkwx7ls4sote7@doriath>
 <0123F1ED-C421-4C1F-896B-E54C9D345A34@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0123F1ED-C421-4C1F-896B-E54C9D345A34@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Philippe,

From Philippe Blain, Sun 16 Feb 2020 at 23:51:43 (-0500) :
> I reported the same bug to the list back in September [1]

Meta question: is there an easy way I could have found your bug report?

> and I’m glad to say I just finished (today!) a patch series [2] that fixes this bug.

Great! Thanks for the patches!

> Here you just did ` git commit -am 'Add submodule plam’` so the next command according to your reproducer above would be `git checkout nosubmodules`
> 
> > Migrating git directory of 'plam' from
> > '/data/dams/var/tmp/ploum/plam/.git' to
> > '/data/dams/var/tmp/ploum/.git/modules/plam'
> > Migrating git directory of 'plam/plim' from
> > '/data/dams/var/tmp/ploum/plam/plim/.git' to
> > '/data/dams/var/tmp/ploum/.git/modules/plam/modules/plim'
> > Switched to branch 'nosubmodules'
> > Your branch is behind 'master' by 1 commit, and can be fast-forwarded.
> >  (use "git pull" to update your local branch)
> 
> Here, git is migrating the git directories of both submodules to the git directory of the superproject (ploum). This tells me you probably have the `submodule.recurse` config set somewhere, as this is the behaviour I get I if I do `git checkout --recurse-submodules nosubmodules`.

Yes, you are of course right. I should have specified it in my bug report,
I tried to specify the setting explicitely in the last checkout but as you
noticed I forgot to specify it in all other commands, sorry about the
noise.

> That’s another hint that you have `submodule.recurse` set. I don’t get this error doing `git reset --hard`, but I get it doing `git reset --hard --recurse-submodules` (or `git reset --hard --r`, which works and is quicker to type!). `git reset` populates the index, so now `git ls-files -s` would now show the correct content of ‘plam’.

Oh, I did not know git expand unambiguous long options!

By the way the fact that `git reset` also support `--recurse-submodules` is not
specified in the man page. (It is in the help text thought).

And it would be nice if the documentation of submodule.recurse in
git-config specify the list of all affected commands, rather than just "all
commands that have a --recurse-submodules options".

(I could send a patch for this if there is interest)

> > Note that I wasn't able to reproduce in this small examples, but when
> > trying to repair I also add some strange errors of the form
> > '.git is not a git directory' (where .git was a pseudo symlink
> > gitdir: ../.git/modules/plam).

-> This is explained by your Patch 5/6

> would have correctly checked out the submodules. I have a git alias ‘no-rs’ (for no recurse-submodules) that I use in these situations:
>     git config --global alias.no-rs ‘-c submodule.recurse=0’

Can you use alias to define option settings (rather than commands followed
by options) without using the 'f() {}' trick?

Using your alias, I get
fatal: empty alias for no-rs

> Then the `submodule update` call above could be shortened to 
>     git no-rs submodule update --recursive --force

> Note that using the `submodule.recurse` config also applies to internal calls to git commands (issued by other git commands), so using adding `--no-recurse-submodules` to the command line might not be enough to completely turn off the effect of that config, hence this handy alias.

Ohh, good to know!

-- 
Damien Robert
http://www.normalesup.org/~robert/pro
