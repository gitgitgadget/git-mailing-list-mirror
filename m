Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CB5EC433F5
	for <git@archiver.kernel.org>; Tue,  4 Jan 2022 14:55:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234362AbiADOzH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Jan 2022 09:55:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234278AbiADOzG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jan 2022 09:55:06 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38E2BC061761
        for <git@vger.kernel.org>; Tue,  4 Jan 2022 06:55:06 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id f9so34314925qtk.4
        for <git@vger.kernel.org>; Tue, 04 Jan 2022 06:55:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Tx0WVpmwl6EbKvjyvuShtp+oH7pZZC0nMuloCz3mO4U=;
        b=SzsJRXEBqp7gNufFDVKuDXk3GsyhPL6eYXrtWZFt/F/saTdUDRpZHs2iqMjXXN5qok
         t5kw99KS2zo1hLnGQIbvF8ccpgmu9HB25TKvWRBaw3rmfINFwMnAtrs1YBTF+b7UhWmE
         Ky2CsXVc+FfrgYq4wtFLnv7V3ME2a5axoAXqyhCUVZdVMrwaaL9Cz5Q+ltwjWFVchUDp
         WVM5b4rYzkoDKbDVUJnZeuLpvp7B6CR5iga/N6a/eXsFPXymLBKjPbGN2g2XnqeS6A7U
         kQezFrfwPppkgvAaHi12fMj7U89DHD23jRrL/DlYf30cAKCUiYcZhDWXZa6s0cxCX0lD
         p7sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Tx0WVpmwl6EbKvjyvuShtp+oH7pZZC0nMuloCz3mO4U=;
        b=eTYkg6SFBzlfp3FkczwZeMaBXDYAPnrpvooRKQACZqn3+R3e16AwqIOvpXyS6riR6+
         3jIDMdM/wSJOqTuqpkaU69Egcxf/lDqXaxqzIoWfq98rVLDgnmr8w7dkEe8cx+bMSSUS
         Of97NrY31m1/Y8HX8/fE8OKrK3U25koK/5JIuvAo7P/y4lBqgUf1aUob7fBu6eLRB/1B
         xMdiE9OdZRdoekm4f92uqmHM28TJaPidMqqWLOJ4H64zIN3CwbojX0Xfs6FbcVY+n2ka
         VmuEa8ErgrN3Sd9TbXbNgzyU4wvpmgAhypap/ZrszI0S4/jiDqvHKitL0RjuLCBLEpMS
         mV/g==
X-Gm-Message-State: AOAM5323De2Aj5gnh8AP1JNN5AOmzg3ziRBIuu0mYqpoIhDBsrcvohWN
        Wa25Ff4CtlrL1cl0MG7Qv+1iE2vWsqpyqw==
X-Google-Smtp-Source: ABdhPJyNwYHTphMP/7dWRuy969Bt1C3pX3lsYr7s6wwN7aPJtvV6mRKbL5a/5FK18lghLUzt57Rydg==
X-Received: by 2002:ac8:7f55:: with SMTP id g21mr45301560qtk.461.1641308105327;
        Tue, 04 Jan 2022 06:55:05 -0800 (PST)
Received: from smtpclient.apple (pool-108-35-55-112.nwrknj.fios.verizon.net. [108.35.55.112])
        by smtp.gmail.com with ESMTPSA id x1sm31438948qtj.9.2022.01.04.06.55.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Jan 2022 06:55:04 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.40.0.1.81\))
Subject: Re: [PATCH v4 2/2] name-rev.c: use strbuf_getline instead of limited
 size buffer
From:   John Cai <johncai86@gmail.com>
In-Reply-To: <18f77ab9dde121ca16cc52c624322bda10e2d2bd.1641307776.git.gitgitgadget@gmail.com>
Date:   Tue, 4 Jan 2022 09:54:50 -0500
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-Mailbutler-Message-Id: 4DE776C3-40DA-4DE9-B44D-48BC40D595BC
Content-Transfer-Encoding: quoted-printable
Message-Id: <795F5A80-96B5-4963-8F0C-709A49DBF152@gmail.com>
References: <pull.1171.v3.git.git.1641221261.gitgitgadget@gmail.com>
 <pull.1171.v4.git.git.1641307776.gitgitgadget@gmail.com>
 <18f77ab9dde121ca16cc52c624322bda10e2d2bd.1641307776.git.gitgitgadget@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3693.40.0.1.81)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



> On Jan 4, 2022, at 9:49 AM, John Cai via GitGitGadget =
<gitgitgadget@gmail.com> wrote:
>=20
> From: John Cai <johncai86@gmail.com>
>=20
> Using a buffer limited to 2048 is unnecessarily limiting. Switch to
> using a string buffer to read in stdin for annotation.
>=20
> Signed-off-by: "John Cai" <johncai86@gmail.com>
> ---
> builtin/name-rev.c | 9 ++++-----
> 1 file changed, 4 insertions(+), 5 deletions(-)
>=20
> diff --git a/builtin/name-rev.c b/builtin/name-rev.c
> index 21370afdaf9..d16b4ca0b66 100644
> --- a/builtin/name-rev.c
> +++ b/builtin/name-rev.c
> @@ -625,12 +625,11 @@ int cmd_name_rev(int argc, const char **argv, =
const char *prefix)
> 	if (annotate_stdin) {
> 		struct strbuf sb =3D STRBUF_INIT;
>=20
> -		while (!feof(stdin)) {
> -			char *p =3D fgets(buffer, sizeof(buffer), =
stdin);
> -			if (!p)
> -				break;
> -			name_rev_line(p, &data);
> +		while (strbuf_getline(&sb, stdin) !=3D EOF) {
> +			strbuf_addch(&sb, '\n');

I agree strbuf_getline is better since it handles EOF across platforms. =
However, one trouble I ran
into is that it does not retain the line terminator, so I had to add it =
back in this fashion. It looks
a little ugly, but let me know if you think this is preferable to using =
strbuf_getwholeline.

> +			name_rev_line(sb.buf, &data);
> 		}
> +		strbuf_release(&sb);
> 	} else if (all) {
> 		int i, max;
>=20
> --=20
> gitgitgadget

