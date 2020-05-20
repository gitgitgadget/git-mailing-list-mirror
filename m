Return-Path: <SRS0=RPsp=7C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E217C433DF
	for <git@archiver.kernel.org>; Wed, 20 May 2020 12:38:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 594AF2083E
	for <git@archiver.kernel.org>; Wed, 20 May 2020 12:38:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JaUK6qI4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbgETMik (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 May 2020 08:38:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbgETMij (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 May 2020 08:38:39 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3576FC061A0E
        for <git@vger.kernel.org>; Wed, 20 May 2020 05:38:39 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id l11so3022354wru.0
        for <git@vger.kernel.org>; Wed, 20 May 2020 05:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/qm75h5zdBQmjVNvx3635wK2rtQ9zM+QpAK4JLX2xZs=;
        b=JaUK6qI4/+Dmw8qcjsEQvE4pn6Sdt5WxOdii/Hj/8JQuyIi6jepdmZVCz0GnRdBBKJ
         FutyPCN+XJ6BEGHBtaqX7WqhkF3xGIg9Eoj6K+ufjHqMIskRedvuTBeJLjNNd4TR3DCL
         oBMx0Rw7/3vhwJriwDlClF7Fr70c6qnmCAtR0fCDGX/A9bYxz5+NCCQqhTJYYJ5X9r3N
         +HVZKpIP9oCt0NIv69Y6M2+xOAzH6yOnUNdLR3XZYVwO/bwejOP4AAdLVCdL+HSE1pHJ
         N0Z9KAU0fFq+KA+JSRN1ZzoiKNMfd/fjx14a4xnbNmErfxFGfJBS/t9xPzoemJu8TdT5
         27Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/qm75h5zdBQmjVNvx3635wK2rtQ9zM+QpAK4JLX2xZs=;
        b=e4OrvDnKN8EnipzTod8I/8wtzp0coOcjrRnjO4kT9U5xoQQrUSV0PFVqzpaT12mubE
         W0Gpi1aY5InXadJ5XKQONgwoPLMVivdYJFavriRytwdXCIgOAqCkPP4nz2+i+SERC/o2
         Plgj6mFYfdLoeSvPl+vfB88flVaeoSpKJUW3fBWWF3Z/+zlzEMR70nJn4/sUrcSPUYUu
         Hq4dMVbKQhcYIcIU6UPOtskZGDfbM4/GJTBKYBZKnCyuTHBSy+3MWcOXJobdMhXMHZcx
         SaF55EaWiasLmRDyDvp580dBmc/Ei95FILkOifkNZ7oSPdSRS4YvyFT+J/KXa7lhRQ7k
         pb3Q==
X-Gm-Message-State: AOAM530IEriXchu+LVkMXO7puGv4SC0KDT97epGfjA3szuWq8J8+Rv6x
        2zbKIrI4xi/cJwqiqBY6k4MGdsDZC/hVj6AQI2gbpw==
X-Google-Smtp-Source: ABdhPJx1jeOcPCU3TsvTpidqLBbg1cy/no3iYerYo9Q7I5kmhdW4UBEaRMo3W3jeG9sMQfHG9zVvTciJrXsNEUYJ8zQ=
X-Received: by 2002:a5d:6584:: with SMTP id q4mr4307655wru.12.1589978317635;
 Wed, 20 May 2020 05:38:37 -0700 (PDT)
MIME-Version: 1.0
References: <pull.539.v12.git.1588845585.gitgitgadget@gmail.com>
 <pull.539.v13.git.1589226388.gitgitgadget@gmail.com> <1e3c8f2d3e8c6c6db8460f29115d2fe898f85012.1589226388.git.gitgitgadget@gmail.com>
 <xmqq5zcrzhc7.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq5zcrzhc7.fsf@gitster.c.googlers.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Wed, 20 May 2020 14:38:24 +0200
Message-ID: <CAFQ2z_PqiziTt-M+hCP4XOwgRMr2m4WEBTjwi6EPkyK6MbBoYg@mail.gmail.com>
Subject: Re: [PATCH v13 06/13] reftable: define version 2 of the spec to
 accomodate SHA256
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 20, 2020 at 12:32 AM Junio C Hamano <gitster@pobox.com> wrote:
> > -* Near constant time verification if a SHA-1 is referred to by at leas=
t
> > +* Near constant time verification if an object ID is referred to by at=
 least
> >  one reference (for allow-tip-sha1-in-want).
>
> Good.  These are called "object names", though.
>

Fixed throughout.

All of the source code (libgit2, Jgit, git itself) calls this object
ID (git_oid, ObjectId, struct object_id respectively), so it's a bit
surprising.


> >  * `0x3`: symbolic reference: `varint( target_len ) target`
>
> > @@ -434,7 +455,7 @@ works the same as in reference blocks.
> >
> >  Because object identifiers are abbreviated by writers to the shortest
> >  unique abbreviation within the reftable, obj key lengths are variable
> > -between 2 and 20 bytes. Readers must compare only for common prefix
> > +between 2 and 32 bytes. Readers must compare only for common prefix
>
> Is it allowed for a reftable file whose hash_id field says "sha1" to
> use more than 20 bytes of obj key?  Phrasing it like "unique prefix
> of object name, no shorter than 2 bytes" would avoid the problem, I
> would think.

rephrased.

> This version also adds more
>
>
>         =E2=80=99

curious. I have no idea where they came from. Fixed now.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
