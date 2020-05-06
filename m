Return-Path: <SRS0=4z2X=6U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8181DC28CBC
	for <git@archiver.kernel.org>; Wed,  6 May 2020 16:09:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A78020936
	for <git@archiver.kernel.org>; Wed,  6 May 2020 16:09:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730043AbgEFQJV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 May 2020 12:09:21 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53108 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729418AbgEFQJT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 May 2020 12:09:19 -0400
Received: by mail-wm1-f67.google.com with SMTP id 188so3195030wmc.2
        for <git@vger.kernel.org>; Wed, 06 May 2020 09:09:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ELvgZbNefMN5BbxWCH+YHTAKgMlwljK/eq8sqBSdn1c=;
        b=tLe8WL/QALyEnE8FGRPbjw2PEloxodorrVVq4y44VCL0Xqg4gp+E+CHO8doN4l+4Fz
         6F0iomOY1TIjhne54kVvW9Pw44v9yJDE5kxG8uoldrGSzicUQ3o5hRRuuokdzZvxcfDQ
         ZTUsVUuyKKlgpGcIp1tvB6zJsyV/Ym9C7CWXzzCgHaVBhJpySg/5E2R+pWVUp4japRcc
         JaMh4fZMKhA6IpLgXJp8OXm7eLbq5PoucQHZPvOzQ4Ptdn+kGolWsAxV4Z/wl/FhZtQz
         BVmNmyVHbu3w0zktDeIWW4nc6peAycxSDB3px/1UPZZ5Lu5WET73aIZE8J8mCaPIkR2Y
         e6mQ==
X-Gm-Message-State: AGi0PuYm9XgBxT9AYvVlzlpiuh8Nh24ik4Hiil8TBKNNfmaGXhhyA7vm
        RN2qCE4hySXjqZn1/cAbfuzWiqkXPuX36HJdzi/JYQ==
X-Google-Smtp-Source: APiQypJHzgQ4YPPu36ZpId7cvgcTc7+PmoKYxTec8utaSywm3Yim1mJOx8PtEi72/Wd2rJ/yy8QpPD73LVBBtaHFR3E=
X-Received: by 2002:a1c:64c5:: with SMTP id y188mr5204768wmb.130.1588781358209;
 Wed, 06 May 2020 09:09:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200506140138.650455-1-abhishekkumar8222@gmail.com>
In-Reply-To: <20200506140138.650455-1-abhishekkumar8222@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 6 May 2020 12:09:06 -0400
Message-ID: <CAPig+cSi5xe_FSzr7Z3D6+f1WxsbPthQnWcE1FrLyhrmi4TCGg@mail.gmail.com>
Subject: Re: [PATCH] commit: silence git-gc if --quiet is given
To:     Abhishek Kumar <abhishekkumar8222@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Pierrick Gaudry <pierrick.gaudry@loria.fr>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 6, 2020 at 10:03 AM Abhishek Kumar
<abhishekkumar8222@gmail.com> wrote:
> As reported by Perrick [1], commit does not propagate quiet behavior to
> gc if present. While we are at it, convert argv_gc_auto to struct argv_array.
>
> [1]: https://lore.kernel.org/git/20200506094327.GC31637@rillettes/

According to the source you cite, this sort of issue has come up
before in a different context (git-fetch). Do we know if there are
other commands which invoke git-gc which might also suffer the same
issue? It would be nice for the commit message to say something about
this... for instance, that git-commit is the final command which needs
this fix or, if not, which additional commands are likely to need the
same treatment.

> Reported-by: Pierrick Gaudry <pierrick.gaudry@loria.fr>
> Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
