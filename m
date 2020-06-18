Return-Path: <SRS0=1Nmv=77=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAA42C433E0
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 10:14:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DC7C21D6C
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 10:14:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fO1Knyag"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728377AbgFRKOv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Jun 2020 06:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728231AbgFRKOr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jun 2020 06:14:47 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D08F3C06174E
        for <git@vger.kernel.org>; Thu, 18 Jun 2020 03:14:46 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id z1so3968821qtn.2
        for <git@vger.kernel.org>; Thu, 18 Jun 2020 03:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VVkgXQKYF30BnW/0ZNlY0omnqktdbH6w5r/2YIlZLAQ=;
        b=fO1KnyagkdldkjMko7JV6BrgG/I1AcYCDdQvnqYiNu5YSj6IABmM5I4LkV+bs+0SBw
         i5LxuCSQRbxyPT8ff5YO9BO3Zab6k9pf2RcQRT4v/1eGt+rBbFEPtpCoOHP+gbceG0ys
         wLXJEXFYYDUyayj/zvfNMfCO5ytg0h0JyiZzjyS9n4/ZN8yMFX/chLPa0tpsmwToYI8m
         vVPJ6ovlMtCl7owf9PRVWv7HfTmGgdsXig7JTHuCc6OMkk4Lqu9yBAx+O0Rn/41IAju8
         VNmZClJqgyTxCYgGdehWKKsb8Zf9J/yV5Q/t5IY6sv8q+r8UmH4WnWCemNAE6K7CrWaw
         LIEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VVkgXQKYF30BnW/0ZNlY0omnqktdbH6w5r/2YIlZLAQ=;
        b=OiYpQoaL5xMEfKmL4NAc88FAdtrsnDxFfZSxsXoCu4RG+4Gia+g/FBAe1EKjQOxwdJ
         t2+HAlbW+xNJkAWvAewdjX+liBX7y9f5M47qJ4hWSdhpAzDrlX6BaS2TxfZssI8FFJYc
         7YJDKXYvpijiN4AeQ6QGGSQ3zMkHZjBBJVzbZcs7Pt3safCeoJAgkHQjL0MLDymLL1HP
         6Ovp2iOfenodyOHtQz/CuYvRAyeRDyWL0RCVlzRFqVfbpMSMb5zsXcHih/qoV4KwbcQm
         eUB6Up6KQCNXK9J2STj2QCmsGTbjUEA2xUzOM7FWUKXEbpiap3Py0+qD3s/CMxdqrbdz
         zVbQ==
X-Gm-Message-State: AOAM530LyBw5DUcooDi31TLPpRkNzdKb70BktCdjSv6N1nimjJqe7WRO
        0OkCe7BV6INFB9NPatdc6K/3rViinQb51KXN1O8=
X-Google-Smtp-Source: ABdhPJwArOb8F+ohCoWmLvyje/DJUA5kBPtc02eHWbVRMIUouuJBjkUeooA1B9IE3D13169+wubVZliPPINfieVwiSw=
X-Received: by 2002:ac8:31f3:: with SMTP id i48mr3627341qte.128.1592475284367;
 Thu, 18 Jun 2020 03:14:44 -0700 (PDT)
MIME-Version: 1.0
References: <BY5PR19MB3400EB9AD87DFE612AFD5CC390810@BY5PR19MB3400.namprd19.prod.outlook.com>
 <CAP8UFD3m9ANt6UOyOoMDy2haTJjhzL5ctFiki46ktgH3RLPqjA@mail.gmail.com>
 <BY5PR19MB3400AE170C9F5FF501D27B18909E0@BY5PR19MB3400.namprd19.prod.outlook.com>
 <CAP8UFD0aoNQNcNJytJBazoKj0jvWwykntHHgnYoCBXr6OmGOnQ@mail.gmail.com>
 <xmqqa716zs7w.fsf@gitster.c.googlers.com> <30661592138737@mail.yandex.ru>
 <BY5PR19MB34007DEED68D13003C614F5F909C0@BY5PR19MB3400.namprd19.prod.outlook.com>
 <CANgJU+WfW4mKotMwFS+2Kaq1pDysgJutJ2NhUvyvGgowk8JXsg@mail.gmail.com>
 <BY5PR19MB3400CD5482C8837E41DFEAF2909B0@BY5PR19MB3400.namprd19.prod.outlook.com>
 <BY5PR19MB34004D9F72F6B66376F8E986909B0@BY5PR19MB3400.namprd19.prod.outlook.com>
In-Reply-To: <BY5PR19MB34004D9F72F6B66376F8E986909B0@BY5PR19MB3400.namprd19.prod.outlook.com>
From:   demerphq <demerphq@gmail.com>
Date:   Thu, 18 Jun 2020 12:14:33 +0200
Message-ID: <CANgJU+V7MUC85n-=_yQG05w6MOmSG_ZvmQBJVTk2qRyk=7giZQ@mail.gmail.com>
Subject: Re: Collaborative conflict resolution feature request
To:     "Curtin, Eric" <Eric.Curtin@dell.com>
Cc:     Konstantin Tokarev <annulen@yandex.ru>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "Geary, Niall" <Niall.Geary@dell.com>,
        "rowlands, scott" <Scott.Rowlands@dell.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        "Coveney, Stephen" <Stephen.Coveney@dell.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 18 Jun 2020 at 11:28, Curtin, Eric <Eric.Curtin@dell.com> wrote:
>
> > What I'd like to stress though is that there is a pitfall here: is it
> > feasible to try to support concurrent conflict resolution, or is it to
> > be sequential (even if in multiple turns)? I incline to the latter.
>
> > Concurrent conflict resolution would lead to conflicts in conflict
> > resolutions, that already sounds too complex to be useful for my taste,
> > and we already are in recursion that must be stopped somewhere, so it's
> > tempting to stop it one level up.
>
> I think concurrent doesn't make sense, only sequential.
>
> > I find that the solution in these cases is to first use interactive
> > rebase to squash and reorganize the commits in the branches so you
> > have a nice clean patch sequence. Once you have the branches cleaned
> > up and squashed into a sequence of reasonable topic based chunks you
> > then merge, sometimes it even means you dont get conflicts at all, git
> > merge is pretty smart.
>
> Again, as said in the initial email, anything that rewrites history,
> recreates SHA's (such as rebase, squash, etc.) on a remote
> branch is not allowed in our repo. Of course with unpushed
> commits you can do some of these things as the remote end
> knows no different.

Ah I see, I missed that detail. We have a similar rule at work but
only for the "trunk" branch (what most people call "master"), topic
branches are allowed to change before the merge to trunk.

I guess there is no way to convince your policy makers that if commit
A and B are different but have the same tree hash they refer to the
same state on the disk? I have had audit conversations like that.

Anyway, sorry my reply wasn't helpful. Good luck.

cheers,
Yves
