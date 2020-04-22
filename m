Return-Path: <SRS0=GtnF=6G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F605C54FCB
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 19:14:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB70820644
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 19:14:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VcDcGJSk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbgDVTOE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Apr 2020 15:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726765AbgDVTOD (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 22 Apr 2020 15:14:03 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91B05C03C1A9
        for <git@vger.kernel.org>; Wed, 22 Apr 2020 12:14:03 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id u11so3689763iow.4
        for <git@vger.kernel.org>; Wed, 22 Apr 2020 12:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5unMApRKy1y7tciZ0cgDBwitisTvS+dDzJKCpd/ApDQ=;
        b=VcDcGJSkqVz3SZIKEyeU438bBdYwkE9ueRK33LapVjLFBrC3ZNpPLn0nNgfQffgGjy
         1so4Gi+xyYl+abuw6ODf/nRaRBavELG9vamByvgtNwBNvd0LdT8cP0taLYa2NAq/BOcS
         RuBxzwIaaW+wEhwZkdj31q0nLTj4pp+7+SFAW66VEvmfU3+VfV3vMrwGikmGvEJKx8Z/
         PpB3YZmlVy3kFSTREijNqrtW7WICUIRbLApNUNeEozkOytlm9E4WKHrU8BnmYQjDDQ9a
         QAWihU4Tquxun5zxw8jiIPn1EdoCweyEw6C6/GeCn90KPNnQ23MjeDRSgoNvy3I3kTzH
         4Nnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5unMApRKy1y7tciZ0cgDBwitisTvS+dDzJKCpd/ApDQ=;
        b=Y/F4lc7o9FFUnn3s7wc1IRGEDu/NekWhhxFoznZywzj3fjMXpU75OiK3TCE3+v3z6s
         aWTgABBHvPloUWlmjPfhvxxxAd30mW/MIWTGwnuLf56dE65ggNEf1wf6+BvTYZ7zN3C9
         R9m8WsxbY9NbRbowwWurxkpWOFGTODTD/ESRaAIAoX5fiAp1nM05MiYg97za4Oi8hKqU
         hm9+7b9c6MRyySuNJj5X2dLzs4HEIs22s/YPEDcD0U92+EC179RmoH1kqN6LSR3jC/jP
         6X090Ymp/0uLcFgr7C/5s2dpkeNllEfRNdncXQq2i8ZVjaiakDKbN7MPMctVTGg5YxD9
         xWjA==
X-Gm-Message-State: AGi0PuY8HHK8S1uEAiG24ZMXuklOEPZ6xfQ9hpTUzves4xcpeRixDGWz
        xrC47/5cmUZanR6fKiADR4P+9xXBFS3Q3H7M5aHLKDW+
X-Google-Smtp-Source: APiQypLXJN7FfBuN98nnTwR2CpCfy0X39EO+YmrjsiDlX0RqzhdS34lE82/J98pAdnxLFJ9lmNVWSsoFBDTldgsa9YM=
X-Received: by 2002:a5d:9f15:: with SMTP id q21mr215970iot.111.1587582842808;
 Wed, 22 Apr 2020 12:14:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200422153347.40018-1-jrtc27@jrtc27.com> <20200422164150.GA140314@google.com>
 <CA+sFfMfre6W5GcPh1pWcroFD9S9OPj_uLp5CK11yh-UhqgDs2w@mail.gmail.com>
In-Reply-To: <CA+sFfMfre6W5GcPh1pWcroFD9S9OPj_uLp5CK11yh-UhqgDs2w@mail.gmail.com>
From:   Brandon Casey <drafnel@gmail.com>
Date:   Wed, 22 Apr 2020 12:13:50 -0700
Message-ID: <CA+sFfMf=NZOV41-4oJTLF34rvELr7EvfEHOr90X_h8pSFC3AJQ@mail.gmail.com>
Subject: Re: [PATCH] config.mak.uname: Define FREAD_READS_DIRECTORIES for GNU/Hurd
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Jessica Clarke <jrtc27@jrtc27.com>, git <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 22, 2020 at 11:48 AM Brandon Casey <drafnel@gmail.com> wrote:
>
> I just looked in config.mak.uname, and I'm surprised to see
> FREAD_READS_DIRECTORIES set for so many platforms. And it's set for
> Linux and Darwin?!?!? Junio added it for Darwin
> (8e178ec4d072da4cd8f4449e17aef3aff5b57f6a) and Nguy=E1=BB=85n Th=C3=A1i N=
g=E1=BB=8Dc Duy
> added it for Linux (e2d90fd1c33ae57e4a6da5729ae53876107b3463), but
> also seemed to mistake the intention of FREAD_FREADS_DIRECTORIES as
> being about the fopen(..., "r") of a directory rather than about an
> fread() of a directory.
>
> I just wrote a test program and tested on Linux, Darwin, and Windows.
> Linux and Darwin both succeed to fopen() a directory and fail to
> fread() it, as expected. Windows fails to fopen() a directory.
>
> I notice this earlier commit mentions a failure of t1308
> (4e3ecbd43958b1400d6cb85fe5529beda1630e3a). I wonder if this is the
> reason FREAD_READS_DIRECTORIES was added to so many platforms?

Whoops, I got the order of e2d90fd1c33ae57e4a6da5729ae53876107b3463
and 4e3ecbd43958b1400d6cb85fe5529beda1630e3a wrong. Looks like the
misunderstanding of FREAD_READS_DIRECTORIES in e2d90fd could have been
the cause of all of this. That commit introduced the test t1308 and
added FREAD_READS... to Linux, kFreeBSD, and FreeBSD, and the other
additions followed shortly after.

-Brandon
