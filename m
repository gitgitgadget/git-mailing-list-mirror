Return-Path: <SRS0=ZKiS=2H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E42BC43603
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 15:31:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F1B22465E
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 15:31:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dOy7Ni/H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728601AbfLQPbF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Dec 2019 10:31:05 -0500
Received: from mail-io1-f45.google.com ([209.85.166.45]:36787 "EHLO
        mail-io1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728118AbfLQPbE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Dec 2019 10:31:04 -0500
Received: by mail-io1-f45.google.com with SMTP id r13so1195341ioa.3
        for <git@vger.kernel.org>; Tue, 17 Dec 2019 07:31:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=35VguoY1oj2ks00Ji8jxxtlVvhdU5xX+hzQWlUS8v3g=;
        b=dOy7Ni/HK/rUKBfu91BZNDKJgeBxa2gzLbG9aZGmKg37LGZgYqrvBOEktjVxgazbEI
         isn7S39CIww2B7s/fGqt+AkbIgyC6I5vRCK7S+lkG6Uw64tucIKeCyYn+hjCIXzChoyr
         c5nnTy1UemWunGmoy/gkkyGujuZmm854KB6LY46dj5uC5wKr/bbXM9FadUpTBM6u6mcu
         t8teHXfPQgj/Hv+hmCE52zGkyJIQVZTDg7L/gUpUe8l1owktelpfIdECRPx41q4ZYV5D
         UIpRGn+ILpzd988fpwxkhI161qH4VKsP4bzqNXmP5u629MBHE803fQSClHMJw01Pqitf
         NfjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=35VguoY1oj2ks00Ji8jxxtlVvhdU5xX+hzQWlUS8v3g=;
        b=YZ177BDuooHX2AUPifRv5goLVCRmFJoCMydxtpOltRPyz0U2ckX/eZSuzBBPBECOBW
         HsHf8PsydtwELi6/4GU0h3UdNkxT0x6GklBwCK44t3FdzC76Xc1HE1P9mlTt4hlChKco
         dBPRUJf8T+osTGhvhy0c+RqLUQ4Lj1Bak/NL5GDOpN1WJDhtDXnVuiWLQyz+uZUyjTS5
         spYylXQ4vuEWc5UIQNyRsRsDy538GHR/vhFfiFtT5VgQo/CvIiQscoznb0Zzx5d1O3Fc
         5sdFziG024tNAtfOn3lM4vFU+ld99LcLpvlnQyib2YKeQD1+x2TTVMdlo+n3gFhHag18
         74IA==
X-Gm-Message-State: APjAAAVAK1G4dMdgIRXwVMv4xbaBzfnt6J/dYMJnIeIWCECz+r5JcgRs
        rBqIJ6SndAkZuZhSgiDBxzIIw9fTxXaos5WG3qQu42jN
X-Google-Smtp-Source: APXvYqy9w4oxi6+oJsGo6BiA8+GY31111lh8lCGdPBduUErrNIOGWN1P5std5BOa1f9zftF+2MOLt3lfDIKrbLrbMi0=
X-Received: by 2002:a02:82ce:: with SMTP id u14mr18197911jag.63.1576596663983;
 Tue, 17 Dec 2019 07:31:03 -0800 (PST)
MIME-Version: 1.0
References: <CAN7CjDAu8-q6BR7sT4w_AccciGyk81AON+wyMjce+YJ_nc3WgA@mail.gmail.com>
In-Reply-To: <CAN7CjDAu8-q6BR7sT4w_AccciGyk81AON+wyMjce+YJ_nc3WgA@mail.gmail.com>
From:   "Miriam R." <mirucam@gmail.com>
Date:   Tue, 17 Dec 2019 16:30:53 +0100
Message-ID: <CAN7CjDD5RGXvLC5DJH-f_+JkiPTjVQ_ghq_cVB-P7E_2nDEj8w@mail.gmail.com>
Subject: Re: [Outreachy] New Outreachy post.
To:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear all,
this is my new entry for this week:
https://mirucam.gitlab.io/outreachy_blog/post/my-week2-post/

I hope you find it interesting!

Kind regards,
Miriam.

El mar., 10 dic. 2019 a las 10:46, Miriam R. (<mirucam@gmail.com>) escribi=
=C3=B3:
>
> Dear all,
> as an Outreachy intern I have to post on an experience blog during my
> internship. This is my new entry with the first week in Git project:
>
> https://mirucam.gitlab.io/outreachy_blog/post/week1/
>
> in case you find it interesting for reading.
> Comments, advice or insight about the topics I am writing are always welc=
ome:).
>
> Thank you,
> Miriam.
