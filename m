Return-Path: <SRS0=nPiP=6T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3933EC47254
	for <git@archiver.kernel.org>; Tue,  5 May 2020 08:19:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CF8A2068E
	for <git@archiver.kernel.org>; Tue,  5 May 2020 08:19:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NUqIZRtp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728370AbgEEIT0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 May 2020 04:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725766AbgEEITZ (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 5 May 2020 04:19:25 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE459C061A0F
        for <git@vger.kernel.org>; Tue,  5 May 2020 01:19:24 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id w4so1059817ioc.6
        for <git@vger.kernel.org>; Tue, 05 May 2020 01:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7Fx1HF1C3zAk7eOY2HzEMcOgdB1I21q+C27AZ0qVFsY=;
        b=NUqIZRtp+UHCI8WjS0xl5f/aL4s3MM3NtWNp9tmGN4cA9Z9kG0SNFZDlO/bSBSIn4H
         FgFphFkBTZ2+H1OguX4pn9Lqm4eeCLZDXwjQ73HeoZ3VyIr7IrCvlfU+AMpTu88CbNg1
         UcepQWbHd0v2Jn/fV7oOBAz4bytaxq7PptzN3qjadjmJO/BElwwATrhVwTZ0TpLdYyKB
         lXCiPtY/CmntejulAk2wdv5w3TNU0tRRmdQQl9ZmmisK01c9KzxSEgpy2Sy19tZwp0TJ
         nexYPOtnDFqEG2ki/CEPeAfBqZgLjQkhop4VLofZi5HqYwQiffDrpnmh+hekU8CAQc8U
         62AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7Fx1HF1C3zAk7eOY2HzEMcOgdB1I21q+C27AZ0qVFsY=;
        b=Vz2Ie5RPJk0UFz0kmlBwEmVrmzSGnNaQt8osY5z+W6veZv5oXKSGPHjZXnkYqWUhUx
         UwYV2/p8FC2sV36/JWBEnD13dWVuU/kwp7hFbqccuE7aldaBRGfxZqqsfFf2tNdowpUa
         QMU9I9QlMh8ZiKGMz8WWX62CwVt6L0vh3rtX8CUhBzUiFR+pG1us1SSk3kn6uHMcrwdh
         WF7GsReZEvAodRXGXRO99pawlH7oUtOJtZctRRraF0VaC7GPFO+y/YljcnpHSD3G4KEL
         9Ls7aBNkmJr+65gunXB2HO+YtQhWqC6hhz08IctazRB7mAru4yr92T/rShXIjsNpf6Kx
         56RQ==
X-Gm-Message-State: AGi0PuaqeipyBam9bmYbJmaYn6wBIpERN9CibFqIMW4lfziIoEEwf+wL
        Ve5PmIzIv3EkPdy6MRE6MNAq/674LipIPAVdag==
X-Google-Smtp-Source: APiQypJGUqEnTUcrf+2Vi5mW7V2mKStJHLvkJWJNSspISy0yIBMONHHKN3zke5VQQpM4FJnWIdfyEnEBEF4IKNFHwOo=
X-Received: by 2002:a5e:8e44:: with SMTP id r4mr2200316ioo.47.1588666764166;
 Tue, 05 May 2020 01:19:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAEoQP9iY-0+=ETA0vrHL0HngccwtNA_3KX4WSSokJpOgJDGUeA@mail.gmail.com>
 <20200504055530.GA13290@konoha> <CAEoQP9hyMi=oj18atTJo+dR3ve_zzrLQoOja0CKAAVHei6rA0g@mail.gmail.com>
 <20200504120024.GA3372@konoha> <CAEoQP9gs-a1NanNpYiFQgTs0C+CeYhbD8rMjoFVat1ZSijNA2A@mail.gmail.com>
 <874ksvei1r.fsf@osv.gnss.ru> <CAEoQP9guAWg8E95Pi4MOih7z5rPg7OCB+_jZ6EMhJxpFsM3A1A@mail.gmail.com>
 <871rnz4eln.fsf@igel.home> <CAEoQP9jkP6KinqOM41zbJhV7+MbA742Xgit2ztK1OcJ78+YbdQ@mail.gmail.com>
 <87zhamiz3r.fsf@igel.home> <CAEoQP9jvpCnC0Ag=xZVSpCE_CgyddLooSGi35NcMQf=0se3BEw@mail.gmail.com>
 <87v9laiysb.fsf@igel.home>
In-Reply-To: <87v9laiysb.fsf@igel.home>
From:   =?UTF-8?B?RXdhIMWabGl3acWEc2th?= <kreska07@gmail.com>
Date:   Tue, 5 May 2020 10:19:13 +0200
Message-ID: <CAEoQP9iqSDRd27os1YDBmZ-YHGNcgDwztzmuOi3aSzK7DD9kFA@mail.gmail.com>
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

I didn't, not explicitly. Maybe my IDE, but I don't know how that happened.
And first of all, I don't want to talk about those files at all. Just
about the modified ones below.
Don't get me wrong, I can answer your questions, I just don't see how
this is relevant.

On Tue, 5 May 2020 at 10:14, Andreas Schwab <schwab@linux-m68k.org> wrote:
>
> On Mai 05 2020, Ewa =C5=9Aliwi=C5=84ska wrote:
>
> > I don't know what you think I want with them, but it's definitely not a=
dding.
>
> Then why did you stage them in the first place?
>
> Andreas.
>
> --
> Andreas Schwab, schwab@linux-m68k.org
> GPG Key fingerprint =3D 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC=
1
> "And now for something completely different."
