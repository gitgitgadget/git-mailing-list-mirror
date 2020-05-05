Return-Path: <SRS0=nPiP=6T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C662EC47247
	for <git@archiver.kernel.org>; Tue,  5 May 2020 08:34:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A496E206E6
	for <git@archiver.kernel.org>; Tue,  5 May 2020 08:34:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uZ43WWc6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728524AbgEEIeQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 May 2020 04:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728341AbgEEIeQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 May 2020 04:34:16 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D718C061A0F
        for <git@vger.kernel.org>; Tue,  5 May 2020 01:34:16 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id i16so1461236ils.12
        for <git@vger.kernel.org>; Tue, 05 May 2020 01:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lCtaq8pYnhe055TOOg9b2h9bpvYrUvbzvtwcUoKR+88=;
        b=uZ43WWc6z9h2KoVG3xPWQRWpvADyuZSsRJGy+Fh5gL6xWXOtpA+f1y6egl9ysXBe3P
         pWFwuoARVFZRUY08vwy8qQ2GLKM5YcuvtCgL2GP4WSOBUEL+R3SaAmjij8yWLY9p/sxZ
         q0WgtA57mqZgNs4UjT2pRyVCGsfjgn46Rp07c+Tn/IxCcF77t2GH/+LTe7tn0SgF2fVz
         Xmat4zMib4yKt7YLaCoCTGa2ASwtsCECMTkpzFmfl53n9mqMuRbdScmb67scZxfo+gOq
         VekL5cyx1NOgt4yyUxK/D3ISu8KqMlyYztGHcU4Y3ZyckT8vEKsmU4LkyhiTgVXh9uy1
         ScqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lCtaq8pYnhe055TOOg9b2h9bpvYrUvbzvtwcUoKR+88=;
        b=aYtZh35dqTILc3/ZjanBu9Bzbi0GwI8wNrFBvMVQbgCV2VLvaoD2hClD2EO+k6K35i
         edjelcLZUf2cITFe84pw/2xj2KGeDmJAmjIJEKq203trjtdDaImORUW6IKOpvPK9zUKj
         LN+WuSK0PsHtXwyUDxNRlTVpg8OAIQ90M69AC7MFwawFkPD99m+21BynDYlMTU0HnZSn
         aTTdTNxMuxLG8Ky9J1mIZjS+jow1eEYyjJwqOu/W4TCfEvqQnSf5F9nnZYDdEiqZW8Gu
         quUUklrwEJKJ6LJNp0jMOnAke88FdOWW4rETf9Y46LBJMTlSAVxufNCYzO+aVolE3VuU
         /90g==
X-Gm-Message-State: AGi0PubafqM6EX/HIXLwLogSlkvkvG9ILirWSo1QoEvapNhWIdmdMB55
        r8ekzAJ07mWe+UFRpWUelmUUrdJ5wI+slS0ym1HPDtQ=
X-Google-Smtp-Source: APiQypJx8U7cxGKZFM80prkUNzlSayqIH2aTYqwMz9IkghdB9AN8JKXjqo/btpzenkjoEWyIhdybGjZZyF1SP6oBs28=
X-Received: by 2002:a92:6b04:: with SMTP id g4mr2692641ilc.82.1588667655062;
 Tue, 05 May 2020 01:34:15 -0700 (PDT)
MIME-Version: 1.0
References: <CAEoQP9iY-0+=ETA0vrHL0HngccwtNA_3KX4WSSokJpOgJDGUeA@mail.gmail.com>
 <20200504055530.GA13290@konoha> <CAEoQP9hyMi=oj18atTJo+dR3ve_zzrLQoOja0CKAAVHei6rA0g@mail.gmail.com>
 <20200504120024.GA3372@konoha> <CAEoQP9gs-a1NanNpYiFQgTs0C+CeYhbD8rMjoFVat1ZSijNA2A@mail.gmail.com>
 <874ksvei1r.fsf@osv.gnss.ru> <CAEoQP9guAWg8E95Pi4MOih7z5rPg7OCB+_jZ6EMhJxpFsM3A1A@mail.gmail.com>
 <871rnz4eln.fsf@igel.home> <CAEoQP9jkP6KinqOM41zbJhV7+MbA742Xgit2ztK1OcJ78+YbdQ@mail.gmail.com>
 <87zhamiz3r.fsf@igel.home> <CAEoQP9jvpCnC0Ag=xZVSpCE_CgyddLooSGi35NcMQf=0se3BEw@mail.gmail.com>
 <87v9laiysb.fsf@igel.home> <CAEoQP9iqSDRd27os1YDBmZ-YHGNcgDwztzmuOi3aSzK7DD9kFA@mail.gmail.com>
 <87r1vyiya4.fsf@igel.home>
In-Reply-To: <87r1vyiya4.fsf@igel.home>
From:   =?UTF-8?B?RXdhIMWabGl3acWEc2th?= <kreska07@gmail.com>
Date:   Tue, 5 May 2020 10:34:04 +0200
Message-ID: <CAEoQP9j=oRDchdd=NLwUFJ1sHWxHY6rn9vRTdpCLOVD08q7SRA@mail.gmail.com>
Subject: Re: file is showing as modified even that it was never commited
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     Sergey Organov <sorganov@gmail.com>,
        Shourya Shukla <shouryashukla.oo@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Wow, your completely right. Thanks a lot!
Now I see they must have been somehow staged, then changed and only
changes are not staged... That explains everything.

I don't know how I staged them now, and I guess you can't help me
answer this question, what is important is that they are in fact
staged.

Maybe that's a problem with IDE or I did it somehow accidentally...
Anyway, that seems explained now, not bug.
Thank you all a lot once again.

On Tue, 5 May 2020 at 10:25, Andreas Schwab <schwab@linux-m68k.org> wrote:
>
> On Mai 05 2020, Ewa =C5=9Aliwi=C5=84ska wrote:
>
> > And first of all, I don't want to talk about those files at all. Just
> > about the modified ones below.
>
> You cannot ignore the staged files, that's the key to your confusion.
>
> Andreas.
>
> --
> Andreas Schwab, schwab@linux-m68k.org
> GPG Key fingerprint =3D 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC=
1
> "And now for something completely different."
