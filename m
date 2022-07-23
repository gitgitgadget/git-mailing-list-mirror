Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CF1FC433EF
	for <git@archiver.kernel.org>; Sat, 23 Jul 2022 04:11:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232303AbiGWELj (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Jul 2022 00:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiGWELi (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Jul 2022 00:11:38 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F19641261B
        for <git@vger.kernel.org>; Fri, 22 Jul 2022 21:11:36 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id t3-20020a17090a3b4300b001f21eb7e8b0so9129881pjf.1
        for <git@vger.kernel.org>; Fri, 22 Jul 2022 21:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=gurhlXDU37JF47+vmOADKGoTUnm0b6D3tOcT66h9XC0=;
        b=gQIg+Q/ZDRl2wqx2vbi1iuIAl8MTLv/0cGnlYXBJJcuj0EwDY/QNePuR0WEYjY16nL
         hsiJ0aHZ1ADSEhdb93DD3bBryS2JEYPza12ez9lDV+g7iHbMiQxdNcW0ysp2GLCBjASv
         viWxXczYs3XHN0vbislYj4WUMd+1+HpZnIl4Ttga9zQzUoRxwYG5WwmQtymds7ppYPxI
         X0RNFr78nsHx01nU86qmEWIcshupjoiQdU2W5nmjh7iFqdFAper6aigKjVrDRAVh1pwo
         2VjDyEaiSJK1k7NnjLf7/bT/8z3c/cEqev2FgIJR9uUzZhpaYW6QroJT/sHZKfdNALlr
         hOYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=gurhlXDU37JF47+vmOADKGoTUnm0b6D3tOcT66h9XC0=;
        b=whXS81CbWJ+x3XIRqvns7jStptNYFQNu4m68Ifse9xuG+VX+FKmipj44HMguL9wgay
         aw0khXH/KQgv4ThRdP92kTxxzuy0MruzUl4WzRazisGSbr41R3zxShOcYY1EkR8ovfw6
         PirXdUvEdRwy2ApiRQgrf6udRRPzSuQDFFOtMxTufhCEkcWqrkwkGKrmFKfSNwRlZInn
         /yYfZBUJxJhUd2m1Zy+akPKuB/BvAWNfci24UEPUU71tMM4bSSz9YjF5CetdWRiN6ESb
         ziob6mWqIUT/hRriVGSD/HbtBn5NyZ6nsClxacdUYjmtboO/d79/P/lOLqaeyD8i5jV5
         7fVA==
X-Gm-Message-State: AJIora/5plpOJPc5AOWd2GTWi/g3TS6CuC/dKb6HrY+qIK+ATEr6NUJl
        IICtgNMhLuhlJiCv48XW9Nc+w7v7D60=
X-Google-Smtp-Source: AGRyM1vHFh9mr/FaUjHCXsSr8TYJAjZZBxsMBVjFKA1Hekinsu7PI9oIp+ImK9WI9Ww9IiRge8CokA==
X-Received: by 2002:a17:90b:48cf:b0:1f2:4568:1e65 with SMTP id li15-20020a17090b48cf00b001f245681e65mr3064567pjb.145.1658549496327;
        Fri, 22 Jul 2022 21:11:36 -0700 (PDT)
Received: from localhost ([113.173.163.90])
        by smtp.gmail.com with ESMTPSA id n1-20020a170902d2c100b0016a565f3f34sm4629651plc.168.2022.07.22.21.11.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 21:11:35 -0700 (PDT)
Date:   Sat, 23 Jul 2022 11:11:32 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     davidnchmelik@gmail.com
Cc:     git-l <git@vger.kernel.org>
Subject: Re: 'git clone,' build makes user non-writable files (should be
 option keep user-writable)
Message-ID: <Ytt09IrDyEQDc3Z3@danh.dev>
References: <822787da-bc26-0d72-a5c4-808a3d10126e@gmail.com>
 <YtPtQ6qsIviyTBF2@zbox.drbeat.li>
 <158251f2-9fa4-45b7-4c24-907c94602b6e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <158251f2-9fa4-45b7-4c24-907c94602b6e@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2022-07-22 06:23:05-0700, David Chmelik <dchmelik@gmail.com> wrote:
> On 7/17/22 4:06 AM, Beat Bolli wrote:
> > On Fri, Jul 15, 2022 at 03:35:49AM -0700, David Chmelik wrote:
> > > What did you do before the bug happened?
> > > 'git clone,' built various software (with gcc, BSD & GNU make, autotools,
> > > cmake, etc.)
> > > 
> > > What did you expect to happen?
> > > Option: keep cloned/built/etc. files user-writable.
> > > 
> > > What happened instead?
> > > Needed chmod or 'sudo rm -rf.'
> > > 
> > > What's different between what you expected and what actually happened?
> > > Option: keep cloned/built/etc. files user-writable, otherwise (has been said
> > > 15+ years) encourages 'sudo rm -rf.'
> > > 
> > > Anything else you want to add:
> > >          I try/test/debug (and report bugs) many software commits but don't
> > > commit so need cloned/built/etc. files writable as user & even system-wide
> > > options: who hasn't made 'rm -rf' mistakes? (unrelated but someone might
> > > claim is: I don't use non-UNIX-like OS that shell alias 'rm -rf' to confirm
> > > every file (potentially thousands) and though made my own alias (confirm
> > > once) it's longer, sometimes unavailable so don't always use (many people
> > > don't)... software should always have user-writable files option.)  Below
> > > indicates GNU/Linux but also have often used git on *BSD/Unix.  I'm not on
> > > git mailing list but you can CC me all replies.
> > When building software as the current user, the build artefacts are
> > owned by this user.
> Ownership, permissions are different: one can own files yet have zero
> permission to write/delete and be denied that.  After cloning, archiving,
> building most/all projects I tried from (hundreds/thousands) git commits I
> typically/always had zero permission to write/delete some files/directories
> within--despite owning--which led to more steps to delete and temptation to
> sudo 'rm -rf' (or preferably alias or script such as 'rm -RfI' (FreeBSD
> UNIX) or 'rm -rf --interactive=once' (GNU) but may not always be available).
> 
> > Are you building the software using Docker containers that run as root?
> I don't use containers.  I noticed some projects' cmake & 'sudo make
> install' put root-owned files in build directory but doesn't seem to happen

cmake & sudo make install

is your problem

cmake only generate a build system for your project.
After that, you need to run make to build its artifarts before running
(sudo) make install.

If you don't run `make` first, `make install` will trigger `make all`
implicitly, since `install` target depends on `all` target.
Thus, `sudo make install` will invoke some sort of equivalence of
`sudo make`, thus all build output will be owned by root.

So, there're nothing to do with git.


> with other build systems--especially not plain make (BSD nor GNU nor with
> autotools)--still-used by almost all projects I try commits from.
>         So, I don't think root is the problem; IIRC usually problem was
> cloned directories had one or more subdirectories (such as .git* or
> files/subdirectories further in those) that were/became user non-writeable
> so I ended up writing a bash function (on SlackWiki.com &
> docs.Slackware.com) to make git clones user-writable: should be by default
> (before & after building in .git*, etc.) and/or a well-documented
> beginner/easy option (is it even an option?) because surely many more people
> only test than commit.  Instructions say 'git clone URL' assuming someone
> will commit rather than only test and want to avoid user-non-writeable files
> (I doubt I even need .git* subdirectories until ever start committing (don't
> plan to: I only like decimal-numbered tarballs made manually rather than
> version control) so would rather opt-out).  I don't recall commits from
> three other/older major version control systems be(com)ing user
> non-writeable (though all less-used apart from on classic UNIX/*BSD I don't
> use much anymore besides servers but wish had more hardware support to be
> more desktop-useable).

-- 
Danh
