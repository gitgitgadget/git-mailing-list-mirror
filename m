Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDA1AC4361B
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 03:08:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A88F23BE5
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 03:08:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728183AbgLJDIM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 22:08:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbgLJDH6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Dec 2020 22:07:58 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34469C0613D6
        for <git@vger.kernel.org>; Wed,  9 Dec 2020 19:07:18 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id d3so3298779wmb.4
        for <git@vger.kernel.org>; Wed, 09 Dec 2020 19:07:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xF3jA9Kj2M8pj03BhmEglpE6VClR7plkbk8SAbYJ2yk=;
        b=LsmzallyDhIEmD/FyLu6SAZOqSdBzg3RWCeMltWwfpxZ8MBubL0J/CvoFHgt+FL9VW
         nQs0tjLtDtrrfidLeabfFa+0stjM1V0adCELP6TuH+ghZRkb256IZlr65hxhXsq5jU09
         9xbij0HYW4dNeZqIr6buqEoIzX3RdXAoT0Z7zfDelRIyxckKF/gYUJQpbmgR4o3AH77p
         gRvmamSK43rVi7/Jb09Q4XKnphwInOX/Pw5L0DhK/PsER/NvbUbbKjIYQryuKVocEJDO
         3ShS3jvzVWeY7ifIbLUHzZIIgk90HBbOAwjSx85wem+CXCtc22g0YMuzruPEyLmTsFMD
         +Hnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xF3jA9Kj2M8pj03BhmEglpE6VClR7plkbk8SAbYJ2yk=;
        b=HdWc3cGXdcAW34f3LYZB+bTOip0qVmNtSZ/LvCefXE5hfRowNR2+6jedliZ0LqW7Lu
         BI71YYm45Qd6VVVII2/b516sD6yrSjC++U/1cP9oSf1An1jahg3BGcr2oiBB79wtPpz+
         a2n+f1+xI7aieSBv6E8W4W6L/n7nJGfZTdxQZkQFPy5jcWysVYWAzkpJpoWeSTzU9QIZ
         iu0QiEz421xBXKfXz6zPzDcJcYpRxUY2bXa7ZIXIKzTxWbnjFozwwif4iFn5NzNwCpDu
         Rfy4d2H054TLv/9wgKxnGCBFBKKfZsQl+a1WFvUCeMZjFOupH+4Wy9wwYKcoN+nRmKyl
         wAnA==
X-Gm-Message-State: AOAM532HZ88A3dKGFGCIA3q8elb11IasOBo0DgwCANo3XvjGjUY+oMzB
        8nQXewomvMusGJeTcQ0K/sZRh1sybXTzaODeyv0raFEEJuc=
X-Google-Smtp-Source: ABdhPJyPY2FmLZEohLglREKstOPzkZs/N/tEYF0KDRWrm4LPh/1EzIjcQW86b3eHdKaKMHPrzaRtwSIvAd6KBwdmN/o=
X-Received: by 2002:a1c:6008:: with SMTP id u8mr5540850wmb.173.1607569637005;
 Wed, 09 Dec 2020 19:07:17 -0800 (PST)
MIME-Version: 1.0
References: <878sa7xujm.fsf@evledraar.gmail.com>
In-Reply-To: <878sa7xujm.fsf@evledraar.gmail.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Wed, 9 Dec 2020 21:07:06 -0600
Message-ID: <CAMP44s1bemXUC2wR-2X2-Pp+=OU-=UrMsSroCwqu5jZ0krAy0A@mail.gmail.com>
Subject: Re: RFC: Modernizing the contept of plumbing v.s. porcelain
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 9, 2020 at 5:02 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:
>
> A lot of external guides and people's mental models of /usr/bin/git as a
> scriptable client reference the concept of plumbing & porcelain. Just
> one such example [1] prompted me to write this E-Mail.
>
> I've wondered if we shouldn't be updating this concept to reflect the
> reality on the ground in the git command ecosystem.
>
> I.e. if you look at "git help git"'s list of plumbing v.s. porcelain it
> makes no mention or distinction between those commands & functionalities
> that are truly transitory "porcelain". E.g. the specific error message a
> command might return, and those that are effectively plumbing. E.g. some
> "git config" functionality, "git init", the pretty formats in "git log"
> etc.
>
> I'm not quite sure what I'm proposing if anything, just putting out
> feelers to see if others think this documentary status quo has drifted
> from reality.

One option would be to split git into two binaries: "git" and
"git-tool". Obviously the latter would be plumbing.

We could slowly move the documentation to git-tool and by doing so we
could see that if a porcelain man page has too many links to git-tool
documentation, that's some area of opportunity.

Every time you access a git-tool command inside git, it still would
work, but you will get a warning: "you are using a plumbing command,
use git-tool instead". Scripts could enable GIT_TOOL_MODE=3D1 if they
are going to access many of these commands and don't want to
s/git/git-tool/.

I would be a ton of work, but it's something I see value in doing.

Cheers.

--=20
Felipe Contreras
