Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D66B6EB64DC
	for <git@archiver.kernel.org>; Tue, 18 Jul 2023 22:50:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbjGRWuj convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 18 Jul 2023 18:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbjGRWuh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jul 2023 18:50:37 -0400
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B59AED
        for <git@vger.kernel.org>; Tue, 18 Jul 2023 15:49:58 -0700 (PDT)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-1b03ec2015fso4404341fac.3
        for <git@vger.kernel.org>; Tue, 18 Jul 2023 15:49:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689720597; x=1690325397;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u1eJvr+yKrng9+GWA0j8Ompo+ci71okWQQ/MM8fFbyY=;
        b=iURWxLvys1aoegp5VSmvITyoYl6/o6h/6gwQOxnamlyhJYO+d4BsiTuRmSfEllgkk7
         h/vSKIb8fAwnB+xnp5ADsG/g9O0yzfsEAVzF5b4aZOcixT/8+t1WwvnPsAJrS0Lz9/i5
         uWuLDcYOTBa9dtpeqtC3NR1rmiNQ2ObOfzAii/IGeVDBk9wc4owBdruDPey9IKH97zet
         oJ2UFJ/3tg7BryW03GgD3V/m0SnXLhmOvS+t4oOfa9NtOQ4Y4mW2vFMgynjMRuDi0fPL
         5TjlB8sasMFVLFxzqZUJocKqHZ4d+1t9joXMpLRWMTRUK0LinlMwCZ9ZR9agSZvcc8tr
         IiUw==
X-Gm-Message-State: ABy/qLahgiu9PHXG74Nup/nUxgsvWAJyMhzlJNueJFxtWjdvRcl1bg/l
        i27Y7fUXLbj1es4rrwLmvX0S+952hr4lZQIgjBYhYZBjpFMWhrxW3Ld1ig==
X-Google-Smtp-Source: APBJJlE098SC/6wJ+VwXTF0H5pDqCxz5iJGiG5pKNSzevZ+L+NEcaMMV+WZZ2sqLLZbdb3zL00Fwe3q4CLWghAobyX8=
X-Received: by 2002:a05:6870:1f89:b0:1a6:b183:b0ab with SMTP id
 go9-20020a0568701f8900b001a6b183b0abmr639253oac.40.1689720597394; Tue, 18 Jul
 2023 15:49:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAGE71k3Ccm3hBrfNgXFqO9Zk0V9FkoskgD1ViJ6eSakxdBuqQQ@mail.gmail.com>
 <xmqqfs5mgs8v.fsf@gitster.g> <CAGE71k2bdy2aYy7speu=OOStopgjzVNOPQ_-V-63aCURLibFWw@mail.gmail.com>
 <CAGE71k3c+CGT=42cfkh+2Z-BcvefojNwpzWfc_XHPkBK8psJfA@mail.gmail.com>
 <CAGE71k3tMOtyFVrmGW33RuQ3GufJg8X6ORKCwHQgg6RmXbRCQA@mail.gmail.com> <xmqqa5vsg8gp.fsf@gitster.g>
In-Reply-To: <xmqqa5vsg8gp.fsf@gitster.g>
From:   =?UTF-8?Q?Adam_=22Sinus=22_Skawi=C5=84ski?= 
        <adam.skawinski@sinpi.net>
Date:   Wed, 19 Jul 2023 00:49:45 +0200
Message-ID: <CAGE71k28Gao4xuR565qsLmPH02tVAdoCZPeuCjo7r9YZXWs82Q@mail.gmail.com>
Subject: Re: receive.denyCurrentBranch=updateInstead won't update the repo
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Oh. Then it's different from the other hooks, which merely enhance or
abort the default behaviour by returning non-zero! I hadn't thought of
that. The documentation is phrased in a way that made me assume "This
hook is to be used to override the default behaviour" means overriding
the tree cleanliness checks, not replacing the whole deployment
routine, which - if a hook is in place - needs to be fully
reimplemented in the hook.

All in all, I'm glad it works now. Thank you for the explanation, I
shall bother you no more. :)

On Wed, 19 Jul 2023 at 00:29, Junio C Hamano <gitster@pobox.com> wrote:
>
> "Adam \"Sinus\" Skawiński"  <adam.skawinski@sinpi.net> writes:
>
> > Correct me if I'm wrong, but I'm looking at receive-pack.c and can't
> > grasp one thing.
> >
> > In receive-pack.c:1452-1453,
> >> if (!invoked_hook)
> >>   retval = push_to_deploy(sha1, &env, worktree->path);
> > ... push_to_deploy is reached only if... hook didn't get invoked?
>
> Correct.  The hook is responsible for both DECIDING if it wants to
> touch/update the working tree, AND ACTUALLY UPDATING the working
> tree itself.
>
> And the entire point of the "hook" is that its update does not have
> to be just "checkout the given commit's tree", for which using the
> default push-to-deply is sufficient.  It is for those who want to do
> more.



-- 
Adam "Sinus" Skawiński
