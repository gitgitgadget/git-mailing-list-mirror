Return-Path: <SRS0=JCNZ=6S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E38FC3A5A9
	for <git@archiver.kernel.org>; Mon,  4 May 2020 12:11:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 584F3206A5
	for <git@archiver.kernel.org>; Mon,  4 May 2020 12:11:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oR/FwEge"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728615AbgEDML2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 08:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726445AbgEDML2 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 4 May 2020 08:11:28 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A31C061A0E
        for <git@vger.kernel.org>; Mon,  4 May 2020 05:11:26 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id k18so12021009ion.0
        for <git@vger.kernel.org>; Mon, 04 May 2020 05:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RBYW4Bgq5i0vCQG7wk2QOsV3qE/6pM2jpdv4Om5rfXs=;
        b=oR/FwEge/U1XrnHdJNbm2pNJMsA3/dV22tG+zlSn7aN8nwmeUYqQHvmf+0Wzm1cNM1
         OIDP8YmDsj88TzJjswPcbHrd8yizZUX5nTDtmlwZR2xSW0s63sF0t7Sh/h30X7x7sw0C
         pUxWHx/qS3A+Eq/MxDFH7ujvoUZ3MKwvHzUQYdltjgOEpjK5qohAwehmvKVVfEGzsm7j
         JXGPFt5vrTByWJCr3ORtyP6cZdT6Kn2LegwTPJraBIONAogp+vBmbA3sN/dl7qzrJkrz
         FvtlBJnObGf6wkVS4p5uNU9Huwfa7R48osQ35oITyxzuxv2AwvZYMjwLtpGAcci0UBLa
         mvSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RBYW4Bgq5i0vCQG7wk2QOsV3qE/6pM2jpdv4Om5rfXs=;
        b=Rq+LO/XPRm2un8cW9PpcsPNHTvNugV37DNJeRzOJsa4cpdnGOjLDp+4J2aPiMy9b2o
         8Xa4vkAAST/7Hze6TkXCipCisGtsoQANipbDCnYJvTE6ZupacQ2bGpg6YK6801oS7f9F
         a0milvp97sl9c670zH55f+gg5QpVfCTd8aPEwTjhYo/jgxsmJTsLx2zT+PzP2ugKibm7
         BKDkNOrYyl55E2rSaG5XrYwqcWcEtdXdn2cxDS9KI+Eb6C+4Z4vg3mU51SGzey9yRDIb
         PZq6LiAcPIkec0owV01mzK9MSel6EvcGM3U3ch59ixvLbmMenPbZPj0XeDrIq95S2SUs
         pKlw==
X-Gm-Message-State: AGi0PuZCFQtjY6+QNxKEiN2Vs6q7Zan524X27qUrxguHr47NJhaQDTpC
        gH+I/pk5z3x/I1mgH1m6FAD0uJPNwxSuABIZ7g==
X-Google-Smtp-Source: APiQypKDc5apg2zyNBc2zagF4NH0vGADX84foIhKPI77ngxEcGXnIDeCOHKpx9/Uba6dUONg7pVOS5cxNP9AKHrBPdE=
X-Received: by 2002:a05:6602:1651:: with SMTP id y17mr15287777iow.24.1588594286357;
 Mon, 04 May 2020 05:11:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAEoQP9iY-0+=ETA0vrHL0HngccwtNA_3KX4WSSokJpOgJDGUeA@mail.gmail.com>
 <20200504055530.GA13290@konoha> <CAEoQP9hyMi=oj18atTJo+dR3ve_zzrLQoOja0CKAAVHei6rA0g@mail.gmail.com>
 <20200504120024.GA3372@konoha>
In-Reply-To: <20200504120024.GA3372@konoha>
From:   =?UTF-8?B?RXdhIMWabGl3acWEc2th?= <kreska07@gmail.com>
Date:   Mon, 4 May 2020 14:11:15 +0200
Message-ID: <CAEoQP9gs-a1NanNpYiFQgTs0C+CeYhbD8rMjoFVat1ZSijNA2A@mail.gmail.com>
Subject: Re: file is showing as modified even that it was never commited
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> That actually was a solution to your problem, not a workaround.
Not really, because I would like to investigate what happened, not
just fix it. In that case I could as well recreate repository I
guess...

I agree that I could add those files accidentally. But I'm really
disappointed in fact that you seem to ignore all the part where I
described in details how I checked this and why I think this is not
the case.
Could you please answer if there was something wrong with my checking?
I'm asking second time.

Or could you guide me step by step through investigation which would
confirm your theory?

On Mon, 4 May 2020 at 14:00, Shourya Shukla <shouryashukla.oo@gmail.com> wr=
ote:
>
> On 04/05 10:11, Ewa =C5=9Aliwi=C5=84ska wrote:
> > Hi,
> >
> > thanks for your response.
> > I consider what you propose rather a workaround, while it is really
> > important for me to get to know what happened here.
> > Could you help me investigate this?
>
> That actually was a solution to your problem, not a workaround.
>
> > I though that I might add those files accidentally before. That's why I
> > checked it, I wrote about this in the original email.
> > Did I check in a wrong way?
>
> If we go into detail of what might have actually happened, the `.idea`
> folder must've been tracked before getting a mention in the
> `.gitignore`. Now, the thing is that `.gitignore` ignores only those
> patterns/files which were not tracked since their addition in it. So
> most probably, this would have been the case with `.idea` as well.
>
> And yes, you might have added those files before accidentally, maybe
> when you did a `git add .` or something alike.
>
> Regards,
> Shourya Shukla
Pozdrawiam
Ewa

On Mon, 4 May 2020 at 14:00, Shourya Shukla <shouryashukla.oo@gmail.com> wr=
ote:
>
> On 04/05 10:11, Ewa =C5=9Aliwi=C5=84ska wrote:
> > Hi,
> >
> > thanks for your response.
> > I consider what you propose rather a workaround, while it is really
> > important for me to get to know what happened here.
> > Could you help me investigate this?
>
> That actually was a solution to your problem, not a workaround.
>
> > I though that I might add those files accidentally before. That's why I
> > checked it, I wrote about this in the original email.
> > Did I check in a wrong way?
>
> If we go into detail of what might have actually happened, the `.idea`
> folder must've been tracked before getting a mention in the
> `.gitignore`. Now, the thing is that `.gitignore` ignores only those
> patterns/files which were not tracked since their addition in it. So
> most probably, this would have been the case with `.idea` as well.
>
> And yes, you might have added those files before accidentally, maybe
> when you did a `git add .` or something alike.
>
> Regards,
> Shourya Shukla
