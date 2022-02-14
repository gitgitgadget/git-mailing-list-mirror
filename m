Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3661EC433FE
	for <git@archiver.kernel.org>; Mon, 14 Feb 2022 08:46:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242533AbiBNIqK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Feb 2022 03:46:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242561AbiBNIqF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Feb 2022 03:46:05 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4562A606DC
        for <git@vger.kernel.org>; Mon, 14 Feb 2022 00:45:38 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id e7so31738417ejn.13
        for <git@vger.kernel.org>; Mon, 14 Feb 2022 00:45:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i4ObUrS1ao9CD4TBL4y4EZu1L/yq4wjFso+ob875d7U=;
        b=U/7u7rntSz+jjna/dqaUC6CB+alJ0KlUFJO5+n/DcpiZiyeZmDo+S6/xcs2I3L34vo
         c7mqQa/wxrOhBKpP69flx6K1z0FabprefLRGU+xksy3sqgboWG985a1oCWcrEsvnrZF7
         rtDtji2vAYM/jNyAkOYQ9bt8Gkx7/K9nCLpQ4ZPd2N28o5Ncej7Sf8+lf8P7wECf2DhM
         z6W6C6oAaqxW5tQej7CKz99qM+9EJbE/v14GzKUvE3N6df65MB3NjZlraHhOVimXQrnF
         9Fqxyo5Zzt9hN6lPUVlmsWf59U5Dh5h7xFZ9av14bcWKk8MplaoKZLi7/C7MAGLDPyCx
         563g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i4ObUrS1ao9CD4TBL4y4EZu1L/yq4wjFso+ob875d7U=;
        b=qcLASPixphwEapI4VlD9QxqyqOdz6reJnIrs1Uii/ydy/Cge+k/a/aPvrsEQ0WM3f3
         XCaVfi58ajmhysE1GZLzOYxtcKjy4p20LHcnVMftjX6hcJB5sfumnspm/XgUTYWXQVqa
         q3KdEpueFOl84uwXCGU8VC1jY/FlATh3CoQAdTtI157rkFHhcEvOJNx+TbjjaLBxM+Sk
         b8Bxn8YRTOn1W4CODDpFFHn7iMvp2KUrfgMc36A0zPf8Ly8Z1kViK+pe224nrjt0zVyS
         BPyuPHBBVCNPevmyT43xC17rAdkHOX6jfeaJgvT9mKY07MWraqAFIpa8/mlO8BXM7YEI
         vwRg==
X-Gm-Message-State: AOAM530yc8bKxv4C8IRgzj11kVry8CDhE+xLJ6d4l2d5j9W07AHjM5rK
        0bNfx2Qtlh18VjDD4zvDpYHu513hRROV/kxSRa0=
X-Google-Smtp-Source: ABdhPJxfIVIf720al34hCQWz49aOr+YmRj6TLGt5+fEQCPvleBg3168pW1EnFv+x+8sy7eB3Kegn7t8vlwbOUTrD0Bs=
X-Received: by 2002:a17:907:7e92:: with SMTP id qb18mr10904341ejc.555.1644828336605;
 Mon, 14 Feb 2022 00:45:36 -0800 (PST)
MIME-Version: 1.0
References: <20220121102109.433457-1-shaoxuan.yuan02@gmail.com>
 <20220121102109.433457-2-shaoxuan.yuan02@gmail.com> <Yer/oEZK6TBFSsde@nand.local>
 <xmqqr190g6gd.fsf@gitster.g> <CAJyCBORHE2+UMKYFfKArgK68fAT=pKVabVmfifzg--rHAFkaqg@mail.gmail.com>
 <xmqqo83fw5yc.fsf@gitster.g> <CAJyCBOTBcvgAcSaQ4xs-V=M-im_Umf3ymsWzCAGEmrj6b38pEA@mail.gmail.com>
 <xmqqv8xmvdoa.fsf@gitster.g> <CAJyCBOR7KbRxuXJUJ2TrffAjj=rwB3H-Ys9tVUuWGjUKf_LHsw@mail.gmail.com>
In-Reply-To: <CAJyCBOR7KbRxuXJUJ2TrffAjj=rwB3H-Ys9tVUuWGjUKf_LHsw@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 14 Feb 2022 09:45:25 +0100
Message-ID: <CAP8UFD3=kd8ACA8PPHyV7fCYLuJSb4Qj2OSdBFJ3RHtnwbGO2A@mail.gmail.com>
Subject: Re: [GSoC] [PATCH 1/1] t0001: replace "test [-d|-f]" with
 test_path_is_* functions
To:     Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 14, 2022 at 9:32 AM Shaoxuan Yuan <shaoxuan.yuan02@gmail.com> wrote:
> On Fri, Feb 11, 2022 at 1:23 AM Junio C Hamano <gitster@pobox.com> wrote:
> > FWIW, I have the posted patch plus the following SQUASH??? fix-up
>
> I'm not so sure what does "SQUASH???" mean especially the three
> question marks, i.e. is it just an incidental text or a commit message
> convention?

It means that you might want to squash the fix-up commit or a similar
commit into your commit (or one of your commits in case of a
commit/patch series), and then resubmit a new version.

> Is it for the convenience of grepping through the
> "git log" outputs (cause I found the commit 50d631c71c right away by
> grepping through the "git log" output)?

It is for convenience that it's named "SQUASH???" as everyone (who is
familiar with the mailing list) then knows what needs to be done on
the proposed commit(s).

> > parked in the 'seen' branch.  As the script is quiescent right now,
> > I do not mind merging it down, now we spent more time on it ;-)

Alternatively as Junio says he is ok with merging that down, you might
just accept his offer and he will squash the "SQUASH???" commit for
you before merging the result into the "next" branch.
