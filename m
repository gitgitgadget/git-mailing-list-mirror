Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09C96C2D0E4
	for <git@archiver.kernel.org>; Sun, 15 Nov 2020 04:27:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4643222D5
	for <git@archiver.kernel.org>; Sun, 15 Nov 2020 04:27:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gTJL9X1u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726301AbgKOE1b (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 Nov 2020 23:27:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726136AbgKOE1a (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Nov 2020 23:27:30 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0220EC0613D1
        for <git@vger.kernel.org>; Sat, 14 Nov 2020 20:27:29 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id j7so14680967wrp.3
        for <git@vger.kernel.org>; Sat, 14 Nov 2020 20:27:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3RAhlf92elE5M7hSCVtrksUfvU2CpfmgOzixG5yVgmU=;
        b=gTJL9X1ugNMKCcPQqAih+sCpyG7OhvDcwwos5ifmMyOxL5eF5sEA9PmluwmLg6aTyw
         HsN00jeS1+TfzGm5Hq/SFocQtF2IJH0ikmZJ41Xx9Jk0/dd70I6/lm9TW3Q33787lVky
         Hd9dDRjjlizyo73AEtZkXJBAw57T3ia0KUP4juUqt8kkW5m3hY/v40wFDFtFHGupNkw4
         +ZAL/IGdtiGxWoHD2dOWb/iEBHKkWHF7nywHsJZdszQl4lvAvY6pJ8pCcmOoI/Ji/nug
         OlyLdmr2kFNp5l3vA5QpYlfzfuArJPSv9M+CyPD6AA7/qZFGC6UL8Rfk4J0+M3RPc0LL
         yO+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3RAhlf92elE5M7hSCVtrksUfvU2CpfmgOzixG5yVgmU=;
        b=WhNb1/rhTRi7o3/U0iDZt5lJBG2/TQOdj2zCj3DLboBHME4yu7h0zOdx5OO/gCEwNB
         zQdQ4V/YmcNx9Cs1UmqGL38gN23BALishPJHTz89ycc1KncUH96Gle3LQWd+KuhOT46S
         ZRPderCs3LgGLCaAAS3qSatdnB5BEMzIRedFwvIKkxkHKbncuF+qlvCFif6BizpMrhe5
         eBoVUXZ8yVnBjNiwosIf1X8RY0WoRXcHwGtGdkFvLAhpkGOs/afty9M11k7bRIiIEQbI
         kKgBFVgooqJFD8QhgmnYbznT9zQsqpT4sPho+LzKldO5vml2RY57VN4MrXVrzgVvero1
         AYQA==
X-Gm-Message-State: AOAM532ELCfQ49fuTxgbytqvdHicWoS5QuT2KLY1fpfo2zMG9c4JWoQG
        HX10OdASrhG6MtXZOLzX99A5wCiPnxAL/wV3Z4CM9KgmINo=
X-Google-Smtp-Source: ABdhPJyd9EsS7GOIblX8nZOir2f7Ru4UlaHizXGHeJG6QqpMDbssdX0VmwtJylzmUiq/U7A3Zm/7tidOxgzaJTqLl+o=
X-Received: by 2002:adf:de91:: with SMTP id w17mr11986981wrl.84.1605414447804;
 Sat, 14 Nov 2020 20:27:27 -0800 (PST)
MIME-Version: 1.0
References: <CAMP44s3BJ3dGsLJ-6yA-Po459=+m826KD9an4+P3qOY1vkbxZg@mail.gmail.com>
 <20201113010107.GL6252@camp.crustytoothpaste.net> <CAMP44s1U1FevS7NrAYxvgVyzfR5tnD9-+BbPdw5bKnaNHkyD+A@mail.gmail.com>
 <20201113051408.GA3985404@mit.edu> <CAMP44s3AeESm7VBKbar0ir_Py35g99ZW6bNX_=AK4N=OFkcrdA@mail.gmail.com>
 <20201113145802.GB3985404@mit.edu> <CBC2DBAA-A409-49CD-B932-AC82D3C20D55@kobil.com>
 <20201115034649.GC3985404@mit.edu>
In-Reply-To: <20201115034649.GC3985404@mit.edu>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Sat, 14 Nov 2020 22:27:16 -0600
Message-ID: <CAMP44s0-yEQQtwFPyEFN0wxPofVLGv13My=6P5pS+jQaHH+JiQ@mail.gmail.com>
Subject: Re: The master branch rename, and avoiding another v1.6.0 git-foo fiasco
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Lukasz Niemier <Lukasz.Niemier@kobil.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Don Goodman-Wilson <don@goodman-wilson.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 14, 2020 at 9:47 PM Theodore Y. Ts'o <tytso@mit.edu> wrote:
> On Sat, Nov 14, 2020 at 02:19:59PM +0000, Lukasz Niemier wrote:

> > I am pretty much **existing** Git user where I am maintaining few repos
> > yet I am constantly creating new ones for another projects of mine. Such
> > abrupt change in the default branch name, without any warning, would be
> > very confusing for me. Not every user is working on a single Git repo
> > for their whole life.
>
> So we need to make sure existing users know that they can add:
>
> [init]
>     defaultBranch = master
>
> to their ~/.gitconfig if they want the legacy behavior.  This could be
> done by, in addition to mentioning it in the release notes, or by
> adding a comment printed out when "git init" is run and there is not
> init.defaultBranch defined in ~/.gitconfig.

Which is precisely my suggestion: add a warning.

> We do something similar if merge.ff is not in ~/.gitconfig, and people
> run "git merge" without --no-ff or --ff-only specified on the command
> line.   So there is precedence for this sort of thing.

And we did precisely the same thing with push.default.

> This *really* is not hard; which is why I am starting to suspect
> people are really kvetching because their objections are really more
> about the woke/anti-woke aspect of the "master" -> "main" migration
> --- and they are using *think* the children^H^H^H^H^H^H^H users as a
> rhetorical device.

Exactly.

There's literally no other reason to change the default branch name
(other than woke reasons), and the people against adding such a
warning would be doing so purely due to their personal agenda, because
they are in a hurry to get the change in, regardless of the
implications towards users.

Putting personal agendas aside... we need to add a warning so that
users get notified of the impending change, and let the chips fall
where they may.

Cheers.

-- 
Felipe Contreras
