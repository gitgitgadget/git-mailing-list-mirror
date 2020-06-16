Return-Path: <SRS0=RX4d=75=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C9CBC433DF
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 15:56:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DDE521532
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 15:56:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fTbZurOt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733007AbgFPP4o (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Jun 2020 11:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733173AbgFPP4j (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jun 2020 11:56:39 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F337C061573
        for <git@vger.kernel.org>; Tue, 16 Jun 2020 08:56:38 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id l11so21341750wru.0
        for <git@vger.kernel.org>; Tue, 16 Jun 2020 08:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gN2NOwJn4HnMbtaBnWN7jdx6IowTO+BvI9ECyb6iUvg=;
        b=fTbZurOtTD0+E3Z21WiBs20uPYe2thh5NYOz1MZZYA9o5rNstSscWNL+6cb1oCOafB
         mPTFpU/2acvJKLuqqI76LirvR3+RTqf9cpFFjKQWnaq1AoFjbKnzeSnfYpW5dydOtnMX
         XGtUsfCh1eNjglliN3tbDcOKOWeGdPUDQ9OvbwLFWzoTObuz36U4NxCwhhJSjIVFmb/5
         Dt3nrNB081fAd/Mm5xtRZuvn21XSSjjjVVvkPk+LE/DvSPehIoTThkBh/4SRfd1Nm1LM
         TyxZqCI+NBOqe7bUeTA4l6azsMBvVFMFfotpTWa1Sk/M8nQGAoBbExQLhjO7Det3VSLh
         K/gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gN2NOwJn4HnMbtaBnWN7jdx6IowTO+BvI9ECyb6iUvg=;
        b=avf8swEZ7JEQNnnrTtmc9i2QJd0v8cABPGhnMYxR4YgHCJY7QJr+UM499wW8sseQEb
         xXaCN36wXVWoUKc5UR5J7uRwEUIM2ZtT0v+eCRCN5OSwK5K4rj3BRXgmVbJlkAhbBTb7
         RxfX4dsI29ybBa2OOLBI0WkKVafxZpsOF4lmkU0+bvk8VcjkXsF2dMLBeDIBNd3m+27J
         OVKah3NWi/xdFGn8Sam5hze7N7/NQ8dFN4d4RJ7nfkCfXd0o+CMkeDEo01PwH9W6SrTH
         XOezC8T6eyoLfDFCdbn4YmhWFJJfl+GrAdkVqSrlm+eGqzzQNjaLuceHJRrJVgGCytI4
         2Pow==
X-Gm-Message-State: AOAM533rPybZn+xomzTMVsXATczfLTUnHI77sqDfmgJvew1q98FUVfLw
        /zG4mq57gHyoM5bL8684Y6PV7/s2f2sq/9uo+qg=
X-Google-Smtp-Source: ABdhPJzLjOdwsrigtNuNSi29CtxJXvozrwbUBC5Yu1ZfrUEMYctSNc0HI+f5bJ2oWRZav+G4gANQy2k7nYfR2OyMWH0=
X-Received: by 2002:a5d:514b:: with SMTP id u11mr1172484wrt.50.1592322997024;
 Tue, 16 Jun 2020 08:56:37 -0700 (PDT)
MIME-Version: 1.0
References: <BY5PR19MB3400EB9AD87DFE612AFD5CC390810@BY5PR19MB3400.namprd19.prod.outlook.com>
 <CAP8UFD3m9ANt6UOyOoMDy2haTJjhzL5ctFiki46ktgH3RLPqjA@mail.gmail.com>
 <BY5PR19MB3400AE170C9F5FF501D27B18909E0@BY5PR19MB3400.namprd19.prod.outlook.com>
 <CAP8UFD0aoNQNcNJytJBazoKj0jvWwykntHHgnYoCBXr6OmGOnQ@mail.gmail.com>
 <xmqqa716zs7w.fsf@gitster.c.googlers.com> <30661592138737@mail.yandex.ru>
 <BY5PR19MB34007DEED68D13003C614F5F909C0@BY5PR19MB3400.namprd19.prod.outlook.com>
 <c4ebf430-a69d-3d46-bfb9-37c9ece9f519@iee.email> <xmqq1rmgxo67.fsf@gitster.c.googlers.com>
 <CAPx1GvdT6sZRtu8q1R9=fA-mE9pi1Ag-gKEzQfwbGap+KqSoSg@mail.gmail.com>
In-Reply-To: <CAPx1GvdT6sZRtu8q1R9=fA-mE9pi1Ag-gKEzQfwbGap+KqSoSg@mail.gmail.com>
From:   Chris Torek <chris.torek@gmail.com>
Date:   Tue, 16 Jun 2020 08:56:26 -0700
Message-ID: <CAPx1Gvf5R6b1NoUWHkaqLMaj6dr51hERVvuVe1X9k3NEafnBhg@mail.gmail.com>
Subject: Re: Collaborative conflict resolution feature request
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Philip Oakley <philipoakley@iee.email>,
        "Curtin, Eric" <Eric.Curtin@dell.com>,
        Konstantin Tokarev <annulen@yandex.ru>,
        Christian Couder <christian.couder@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "Geary, Niall" <Niall.Geary@dell.com>,
        "rowlands, scott" <Scott.Rowlands@dell.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        "Coveney, Stephen" <Stephen.Coveney@dell.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 15, 2020 at 10:32 AM Chris Torek <chris.torek@gmail.com> wrote:
> I've thought about this (some) myself in the past.  It seems to me that w=
hat
> is needed is the ability to pass the complete unmerged state on.

A few further thoughts:

 * Given one or more saved merges and either a clean state or an
   ongoing merge, we need a tool to combine these.  There are a lot of
   corner cases here but in general, if merge X has file F in conflict and
   merge Y has file F resolved, we can take the resolution from Y.

 * Partial merges (in the work-tree copy of a file) that are not yet added
   may be the trickiest.  A simple heuristic would be to look for the
   conflict markers and see if one work-tree copy has a resolution
   where another work-tree copy has a conflict.  Or, though this is
   harder, use the ours/theirs copies in the saved index trees to find
   actual conflicted regions and compare this to the work-tree copy
   to find resolved regions.

 * There is also an obvious question about what to do when combining
   two different proposed resolutions where the stage-zero and/or
   work-tree copies of the files don't match.

None of these preclude the basic ability to save and restore=E2=80=94and of
course transport, through fetch/push=E2=80=94the unmerged state, which I th=
ink
is the required enabling technology.  The ideas above are more for
combining parallel merge efforts.  If it's acceptable for dev A to merge
his/her part and pass the result to dev B, who merges theirs, and so
on, the above is not required.

Chris
