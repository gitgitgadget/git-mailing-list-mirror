Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B919920248
	for <e@80x24.org>; Tue, 26 Feb 2019 01:53:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725980AbfBZBxn (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Feb 2019 20:53:43 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:32878 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbfBZBxn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Feb 2019 20:53:43 -0500
Received: by mail-io1-f66.google.com with SMTP id e186so9285979ioa.0
        for <git@vger.kernel.org>; Mon, 25 Feb 2019 17:53:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6K+OIJq+02sn7gBIuf40fY40WfEzbNtm18vsO3wzN3Q=;
        b=0f/leNGOaXF6bKtMFcAFUekC/S5EbIzf2kmdsGY7a8rTVseull01rAnM2TZDUgGGOz
         cWKvDvQsx/ELv/44odUv+hV5D/mpP/jvS6l+SuFzNFw+PUYugYkJlU7Up3a+4nLLIIuJ
         HV/WugrWg1hTRI+AIEcRFId3WzYHk4sTVzI9EzgVtO+A5sRjq1s274RuA6iZI0qFiiUP
         g1GL3rceC9bOmsVOdZKNp4/LOOlNhK4O1bGD6AhAH3U0KctWZBxYEepwKfpxDOp4BoCS
         5hKGIuQ9eclDAwlCPFHQ6htsyySyNLywmHs+nLBJ1vqwH2MxEHid/XHtKS4rzHGTca55
         qHOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6K+OIJq+02sn7gBIuf40fY40WfEzbNtm18vsO3wzN3Q=;
        b=DqVqjQp4w89OZ2qah4TlaK/glCsHarqOnB7eOTQiXq5rAbnrvbgR96WNydLoGgpMsE
         C6adoERahd2fXw2SRDzMvWD0ig+MCNRofpHEeS4NdmNx5MCBpkS0PTYXkBUlXK5Khpur
         rChH8BwP2aFtYAMAVCGPG7L/UPbwmiz3oEIi23RP5DcvI6kzDqsSrTGpLc28TaqP/sPj
         fShLlHYhFGlSgI+Le/OKoAjmGNFcfg9A5C2EOYy1YLZYFIVsffrDfWzCeKYX1/cgk7uG
         z0lkzakLYaxL1yuN6BSwmYsGcprvBP+GCmC5WSiU6wK5bf9xaFiny5W7k73ybwlmpBEg
         WHiw==
X-Gm-Message-State: AHQUAuYanF0HsYbM0CCnqTYSm2ASsrbeKiuyv5vrMedx/YrwZa2elWWc
        bZ84D8cZrRkTDYAnQaNrhXkF1suROqTypc3rVDnN4Q==
X-Google-Smtp-Source: AHgI3IamikQn1i4UXzuFtjzMoMAxoyPMQyXTXJv6YfS+Ssyp197UCGG3EfAhLaZUbl51E78QXkfRhHqqrym3BhQQ7aM=
X-Received: by 2002:a6b:1447:: with SMTP id 68mr11177548iou.293.1551146022073;
 Mon, 25 Feb 2019 17:53:42 -0800 (PST)
MIME-Version: 1.0
References: <CACsJy8Bw-mXLyT7VaKBjYKLe6uSAQqyLG=_AzjDXykYzSQLkcg@mail.gmail.com>
 <20190226002625.13022-3-avarab@gmail.com>
In-Reply-To: <20190226002625.13022-3-avarab@gmail.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Mon, 25 Feb 2019 22:53:30 -0300
Message-ID: <CAHd-oW5=BoP6=Ti7y=_rugrRnQJ2yBrFqwq_-fjP7UfcNDoxzw@mail.gmail.com>
Subject: Re: [WIP RFC PATCH 2/7] dir-iterator: use stat() instead of lstat()
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Thomas Gummerer <t.gummerer@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 25, 2019 at 9:26 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> This is surely a horrible idea, but all tests pass with this (not that
> I trust them much). Doing this for later WIP use in clone.c.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  dir-iterator.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/dir-iterator.c b/dir-iterator.c
> index 070a656555..6a9c0c4d08 100644
> --- a/dir-iterator.c
> +++ b/dir-iterator.c
> @@ -149,7 +149,7 @@ int dir_iterator_advance(struct dir_iterator *dir_ite=
rator)
>                                 continue;
>
>                         strbuf_addstr(&iter->base.path, de->d_name);
> -                       if (lstat(iter->base.path.buf, &iter->base.st) < =
0) {
> +                       if (stat(iter->base.path.buf, &iter->base.st) < 0=
) {

I think this may have side-effects on other sections that uses the
dir-iterator API, because now it would follow symlinks, right?

>                                 if (errno !=3D ENOENT) {
>                                         if (iter->pedantic)
>                                                 goto error_out;
> --
> 2.21.0.rc2.1.g2d5e20a900.dirty
>
