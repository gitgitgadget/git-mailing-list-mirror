Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00478C433EF
	for <git@archiver.kernel.org>; Wed,  2 Feb 2022 08:57:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237225AbiBBI5K (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Feb 2022 03:57:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231239AbiBBI5J (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Feb 2022 03:57:09 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 437D3C061714
        for <git@vger.kernel.org>; Wed,  2 Feb 2022 00:57:09 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id i4so16829809qtr.0
        for <git@vger.kernel.org>; Wed, 02 Feb 2022 00:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=45/ZCKAshAl63dZ/F4nF6hl5YYOiOtGxSyJDzUBPdu8=;
        b=pZIevPSQffy/C+GvUusZUEA5EL5HvxJ1swfcRYoL+Av4GcT9duM8yy8FN32Zl5Ymuw
         k2GC8DoidrT7DxKIwTVK9nodQq5RM+Fcz922mt2gvZypPwcPTkRdG1tp6Taj1VnoEgL1
         k9OLyR566AM9uzuYwM5FyQT+r6zympesB9w7952dLmUGQSSKOrnOflqNpL19qhd96ao0
         yt/PeGYX6EznImMF5QdhakO0U+lgxNaSy2J0YDJKehOPqLmRPHTdjnVU1PBVueS/Qyxc
         qc0L7KYe6vOvWXSLSSDiEDQm0ztR0TtJz95m411Z1wBZE8DxiqVP7C3cgKwOJzZe0lV4
         /ntw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=45/ZCKAshAl63dZ/F4nF6hl5YYOiOtGxSyJDzUBPdu8=;
        b=3UOVTmQqSdxqIdlzie4itWJWql7t6ZyJ9IxMnuy9P337184VGlNr9OsoMMFLJgu1P5
         BylAymqsx2F+iU4fYkRo5aq7NDwmDs8qnvgFNcuG/S+XvqDN1RVYh6EWj5jh//NiVz9A
         cyNHgwsxmrckIJ0kmgLfJtGhjrGqsz2M2xBUoL21rCpKJ+QA6WRr1eZEdAWpmULY5LFS
         5khZHXaf1rJ8ODldtVdkPw0gEv+JdPWTnlW2TifLrjba9Qe/vHPfjzA0ZEFjB83sNA5J
         Hy1I+V0yAC93pLJQJ+K9Ich7JvPiLUctG8sRkb/uU93JbBTuuzwrUMCcXEufj9lD2Xk7
         aQow==
X-Gm-Message-State: AOAM532ArYI3I89M++oJawIGAjmTYDkcJDNw2eua/uj3lEglofDc6LCG
        N61ZZyP1zw+5X4a8rVy26xYCq3Kv22jYYujdf6Mi2kft6Hc=
X-Google-Smtp-Source: ABdhPJz1nkClpQdJYdyIZ8gmUSS52yYIUxH4kIWUDdhT8DgyNDjrGX6hlrKKvr+IrE5MfOrXdvtbqodlR3aJVpGib+Y=
X-Received: by 2002:a05:622a:48b:: with SMTP id p11mr4958653qtx.542.1643792228214;
 Wed, 02 Feb 2022 00:57:08 -0800 (PST)
MIME-Version: 1.0
From:   =?UTF-8?B?zqPPhM6xz43Pgc6/z4Igzp3PhM6tzr3PhM6/z4I=?= 
        <stdedos@gmail.com>
Date:   Wed, 2 Feb 2022 10:56:31 +0200
Message-ID: <CAHMHMxUZpR8MBj+9mSb1Cr3PBCsAx=6zLo9mKpeD_ehqDP4nvQ@mail.gmail.com>
Subject: New `--reapply-cherry-picks` warning
To:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello there,

I have noticed the new warning that's coming in the
https://github.com/git/git/commit/767a4ca648f8791c1fb623bd9f79fd8d7f026499

I am currently using the `[pull] rebase = true` option; and basically
that warning is also coming every time I am pulling.
I have tried doing `git pull --reapply-cherry-picks`; however, it
seems that the `git pull` cannot pass options to the underlying `git
rebase` invocation.

I noticed that there is no way to "set" the `--reapply-cherry-picks`
in the gitconfig options.

I prefer the rebase backend for the `git pull`; however, I see no way
of doing "what I want", with the exception of:
git fetch --all ; git rebase --reapply-cherry-picks

Which is two steps, technically.

Also with every rebase I am doing, I'd have to remember that.
And it is probably not possible (by design) to do `alias.rebase =
rebase --reapply-cherry-picks` - which I understand.
(however, allowing aliases like `alias.x = x --cmd-opts` does not
sound "so bad" with me)

Would you consider adding a configuration option for the
`--reapply-cherry-picks`?

With regards,
Ntentos Stavros
