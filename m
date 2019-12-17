Return-Path: <SRS0=ZKiS=2H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 196E3C43603
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 13:32:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D78D4218AC
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 13:32:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MMbcw0IC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728388AbfLQNc4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Dec 2019 08:32:56 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:33532 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728337AbfLQNcp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Dec 2019 08:32:45 -0500
Received: by mail-io1-f65.google.com with SMTP id z8so9153831ioh.0
        for <git@vger.kernel.org>; Tue, 17 Dec 2019 05:32:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bqeTK1iusbby7MaLgN84DpMt8JUoLmrfIeQYBHCk9nk=;
        b=MMbcw0IC9NsdoPUS9JShw5udp3aQSDSngyWeXc9WcdkdtrAMs0/EZXewGm0wUU91zL
         Z3JUNpwvrcOUUNGY7wp6jwLG5bhBWY4v1hi6VoRTGXtmt4B0Rd/gXNjNMe15bThYveiE
         hpE2BSHwO6zi3XtR9zlPznNHFZ/b5yGxuZsy+DoKfZmKnV/iPnBXzU12l9g6RHIcQFtk
         eKofSQt0rxbwEAC1S93oMuDptJh7QI7/tJYKNgrX4l/rmNuk3m4JeMTX5bns8+zEscfA
         9g+OTCkMSRM852CIkhWy30alVbifjyDfXwQ/iiLURAiLdy7DMXE9nPsDgf6VMTFDbV4J
         f6DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bqeTK1iusbby7MaLgN84DpMt8JUoLmrfIeQYBHCk9nk=;
        b=SoousuBnoHUd6yWuGDAh46ZlSycUOthFXvxWO1JihQ/h+UhAz9rFqokwKPrPEgWWiX
         Zc7vndx4fWaEOuhtXMBqxg/b1nYeCi1ge50FksV6dAJS0bmFcsGeBpE0EMfDeH7biGlC
         EMNtc/M49hNWbOz3qAZZhTHDlbahzHYN7pw5UqHnA4bb1nRcOltDA6vKYoRPCtQCMX/O
         BBsWFCPglZyBSA9L23TPKA72r/GWQH3JPgEBlobE0n8Fp+2hQ2BYIRpjg52jiZRBJBlx
         MD7TftsGvBP7BQrm8uty+w28ypdMnjwq1C15cg/WNEpI9XdZoGTE1r0tgynSgj7+VXN8
         zSWg==
X-Gm-Message-State: APjAAAUiCAiNQaNnSvmxEAK/GZ3EqVylueOaq8GZTuHIkyCmGhA+z5O5
        i2UzGfSIzBFLhjAk/iHuCo7/zIQUVCUrslXaAxXZTLm/
X-Google-Smtp-Source: APXvYqww82WdbYR2t5iKNIdRmjkaQcsxe9BPN30w774eGHBsuClcpRk3kfb710dkUolDV24hZM6KWwyytmJC0xzegNk=
X-Received: by 2002:a02:bb02:: with SMTP id y2mr16743617jan.99.1576589564155;
 Tue, 17 Dec 2019 05:32:44 -0800 (PST)
MIME-Version: 1.0
References: <CA+0NiBEFssPJsQ8UV6vRNBxzUEsJddF4Q-=-xVq-xgNUtFbHUA@mail.gmail.com>
 <CA+0NiBGcYwu1Gyyv3AQEbfQCMiE0rrurzgkQzwsjHgi9cEj4wQ@mail.gmail.com>
 <CA+0NiBFU46YRBFEbngK+Rc0e4uE_nSqQkYak9a-_UoTaCCb1Jg@mail.gmail.com>
 <CA+0NiBEifgam1xVJw7F=mO_DtLgfqK9g7eHJMK5dt3yc1JpaAQ@mail.gmail.com> <xmqqd0cojd7r.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqd0cojd7r.fsf@gitster-ct.c.googlers.com>
From:   Marce Romagnoli <marce.romagnoli@gmail.com>
Date:   Tue, 17 Dec 2019 14:32:08 +0100
Message-ID: <CA+0NiBGQHK_bVdH11zRErxNTjvyU-SqJYj=CHZy3afm47+reYA@mail.gmail.com>
Subject: Re: Fwd: `git stash pop -q` is deleting files.
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

But it seems is still happening to me in 2.24.1 -latest-


Marcelo Romagnoli

El lun., 16 dic. 2019 a las 20:13, Junio C Hamano
(<gitster@pobox.com>) escribi=C3=B3:
>
> I think this has already been fixed with
>
> http://lore.kernel.org/git/20191113150136.GB3047@cat
>
> at the tip of 'master' a few weeks ago.
>
