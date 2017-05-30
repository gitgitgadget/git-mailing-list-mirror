Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C7EF2027C
	for <e@80x24.org>; Tue, 30 May 2017 18:58:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751070AbdE3S6g (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 May 2017 14:58:36 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:33332 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750922AbdE3S6g (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 May 2017 14:58:36 -0400
Received: by mail-pf0-f171.google.com with SMTP id e193so80395349pfh.0
        for <git@vger.kernel.org>; Tue, 30 May 2017 11:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kx/Y6o1E5M811C4cdhwfiD4ZpvmPG5AqFqTB2RzfyTg=;
        b=LUmUpBs8UC8YbeKeYG9t00UmGs8MUoqgbD33vquKX4S1w6nfJFEMMDBV1GCMtesp5L
         KM5/RUOXdDvkQ7Q2upByM0YQB45Kivr9GnkB0Mqm01w7RTFmyQAFGuNEDOX8k0WxNxjC
         OyZ3/EvbK8liJTk00H/kBN+y5EiTmt/aoaVODTwDNJ1ea1hv3yOcHr8YIMoEqfpN1EHL
         uCrl7PLYtm0i4K2UgEnZZayooWf4lo3IH46hc64IyTDm9UNAK1+xcSh4Xoy9JhgrC4ib
         ep4SEdDsx2VyLklaJs7WHoM9RS0Lsx/TVkqnR4nICgHp1uu8HmV3MJ0aIGRk14zoiT/0
         /x2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kx/Y6o1E5M811C4cdhwfiD4ZpvmPG5AqFqTB2RzfyTg=;
        b=dLnNydm0g7CyMWkP6jdQR62SwcH7zzWr1JLiKG1Akusg7pF9n5uK87khsTVyIilgWz
         obTvi6Nt1c6DFtLIcy0u60j08/1hDrIVFaYNjGkLivdbHpsn0I2KYPMnQuN8FcoCSI+y
         5jL6JpkKmugNGCLVq8fRegVUD0AfzLC2LChL+VA9HX53oVqLZE70ka2IeBF5c26kNeep
         vOp7igr+6DOpPwrWaQ8hXpmxmPGCMZuLC3a6ZWOcitxiMtOXP8uvDUTudUXVuNC9tuaw
         C6CU9NCRB5Ycwf7ZF7XpOO8pujQawSXCP/fRQj7viXnQapdTluRPnxi/YsoGzubMg/IW
         yFwg==
X-Gm-Message-State: AODbwcCaBkHscBVmDndWQfWtQSXV3+p2FL9Dmvq55/PUXlpih1H3ODC9
        /wMA+Cz49CSjWzf9MJL5QFXQGJHZbnoK
X-Received: by 10.84.228.207 with SMTP id y15mr84077822pli.172.1496170715278;
 Tue, 30 May 2017 11:58:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.170.200 with HTTP; Tue, 30 May 2017 11:58:34 -0700 (PDT)
In-Reply-To: <20170526033510.1793-11-gitster@pobox.com>
References: <CACsJy8CzgHc=qe5w=FGJJ=ZU0a+JiqBrjWHV7SH3rAPKmOOKoA@mail.gmail.com>
 <20170526033510.1793-1-gitster@pobox.com> <20170526033510.1793-11-gitster@pobox.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 30 May 2017 11:58:34 -0700
Message-ID: <CAGZ79kayr3QkdQaVe3cmPyWa2mJQmBxhe=XBMzaLWkJU6U+zsA@mail.gmail.com>
Subject: Re: [PATCH v3 10/13] rerere.c: move error_errno() closer to the
 source system call
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 25, 2017 at 8:35 PM, Junio C Hamano <gitster@pobox.com> wrote:
> From: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>
>
> We are supposed to report errno from fopen(). fclose() between fopen()
> and the report function could either change errno or reset it.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  rerere.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/rerere.c b/rerere.c
> index 1351b0c3fb..c26c29f87a 100644
> --- a/rerere.c
> +++ b/rerere.c
> @@ -489,8 +489,9 @@ static int handle_file(const char *path, unsigned cha=
r *sha1, const char *output
>         if (output) {
>                 io.io.output =3D fopen(output, "w");
>                 if (!io.io.output) {
> +                       error_errno("Could not write %s", output);
>                         fclose(io.input);
> -                       return error_errno("Could not write %s", output);
> +                       return -1;

and here we assume fclose doesn't error out.

This is ok as we are sure it cannot be EBADF as we just opened that
fd and as we did not read from io.input yet, any errno from close(2), fflus=
h(3)
are not expected?

close(2) may yield an EINTR, in which case we may want to

  while (fclose(io.input) && errno !=3D EINTR)
    ; /*do nothing*/

On the other hand this is already in the error path, so maybe we're ok
leaking an fd here in case of a signal?
