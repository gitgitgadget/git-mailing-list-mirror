Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96EC11FAF4
	for <e@80x24.org>; Sat, 11 Feb 2017 19:31:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751155AbdBKTbU (ORCPT <rfc822;e@80x24.org>);
        Sat, 11 Feb 2017 14:31:20 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:36348 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751143AbdBKTbT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Feb 2017 14:31:19 -0500
Received: by mail-wr0-f194.google.com with SMTP id k90so18560899wrc.3
        for <git@vger.kernel.org>; Sat, 11 Feb 2017 11:31:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=D8ihOomQ5iD/TFXXx2UHfNuchtDa1SfoHg0oF63oj+k=;
        b=RAhodRCtxPt1xL11bOAydNVqhF5dRp6zQu/RmXtgTOKKKpEyGEwtNkADMMSdkr/ER5
         BAdO9LFe2hDeLwzKAvtiJUjFDAu3y4HxodahHhjcfMxzYuhwrmJbNxdPLpeqv7eC3fuE
         8UhFHoqWRIddLjj94ozWmuOTpuD+J3mfz3S87tkBo2KrGZZ4DsKbYgjqPUtmeKUwlZVX
         uH2H/lRxTK2LRI2uZ2E5x0MOLOtm3ZvO/uidTd69JJh6dJ4VqRxBEseaCBovvgqH0hHm
         Nbo/jPOjhQqxtyrJt9PlEawxD28CE/vKCny3R6b+7jx/ED/9BUKA+cuprZSedP0/NkZ/
         NXow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=D8ihOomQ5iD/TFXXx2UHfNuchtDa1SfoHg0oF63oj+k=;
        b=eRAlH70MzzpBADYNvSMeY0M0KYBJTsZ0Xa8YgOyQs5SmZqJ+kNT7XsYQjdlq0Vg4P3
         UYY7EFdDhMyI2lRRuFWigierIvUEllLRg7hbVcPhtBn3lGSnkhkg5l4PER2Oay8JG9Hj
         AQdp3Fy5DsxWFpfCvpOpm87F/kP5Jfrudo+YFBq8z57C4CL3oU4yW+yZrUQ65Q54lA7t
         8D1c6ZTdVxLlxDGm7dj+Jk7+FFNCkPKYu9X2V73TUtUtxsgmxzbhvd8KK33jB2xpv8xT
         iyubDwmLeVu7YN2LLRuKiWT1FFeRXWf2oKFfPWSDDN29R4yqLysohuGCUOtl0/hWCfob
         sN9Q==
X-Gm-Message-State: AMke39lmVvVGeZV0F/QP+ysGAmxqxnDWEGBenF5lVUnJiP4ywkEc2/cU21FmSu1z+wXNRw==
X-Received: by 10.223.178.243 with SMTP id g106mr14601428wrd.32.1486841478156;
        Sat, 11 Feb 2017 11:31:18 -0800 (PST)
Received: from [10.32.249.155] (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id g5sm7385032wrd.0.2017.02.11.11.31.16
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 11 Feb 2017 11:31:17 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH] cocci: detect useless free(3) calls
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <7e10f934-f084-ceb4-00eb-b75cdb01886b@web.de>
Date:   Sat, 11 Feb 2017 20:31:15 +0100
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Pranit Bauva <pranit.bauva@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <5DF3AA3E-90C6-443C-A22C-489CE2C89A51@gmail.com>
References: <7e10f934-f084-ceb4-00eb-b75cdb01886b@web.de>
To:     =?utf-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 11 Feb 2017, at 14:58, Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
>=20
> Add a semantic patch for removing checks that cause free(3) to only be
> called with a NULL pointer, as that must be a programming mistake.
>=20
> Signed-off-by: Rene Scharfe <l.s.r@web.de>
> ---
> No cases are found in master or next, but 1d263b93 (bisect--helper:
> `bisect_next_check` & bisect_voc shell function in C) introduced four
> of them to pu.

Hi Rene,

how do you run these checks on the entire Git source?
Do you run each semantic patch file on the source like this?

spatch --sp-file contrib/coccinelle/qsort.cocci --dir /path/to/git/git
...
spatch --sp-file contrib/coccinelle/free.cocci --dir /path/to/git/git

How stable do you consider these checks? Would it make sense to run them
as part of the Travis-CI build [1]?=20

Thanks,
Lars

[1] https://travis-ci.org/git/git/branches=
