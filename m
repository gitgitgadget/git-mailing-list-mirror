Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B23871F576
	for <e@80x24.org>; Tue, 30 Jan 2018 11:23:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751405AbeA3LXv (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jan 2018 06:23:51 -0500
Received: from mail-wr0-f176.google.com ([209.85.128.176]:33584 "EHLO
        mail-wr0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751434AbeA3LXu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jan 2018 06:23:50 -0500
Received: by mail-wr0-f176.google.com with SMTP id s5so10742288wra.0
        for <git@vger.kernel.org>; Tue, 30 Jan 2018 03:23:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=2DpjEILTk0daqnT3HzP+xHnGn63RYtvLqOy7KC95BJ8=;
        b=nJ81sVybnRnMqbnCFK340dEVMjUIy69oQC6tagcljayGP/OR80dMhIeBq9BLKBNVWI
         FIqwungo7DASwMpjtcdCpdOkinwqZ+KxRb/3GmSYPDUl3LpfYOV1iHMsYLtS0OWROTZs
         wrnO4KYgXt2vPyBd79/QTzG5F+u4FshI9pSTUw6xYWtGgLZKCpQNN8I5rtEVtesTAWsh
         /lxjSfYHSYc0pxXvqPUrn4Fc6Y3kdBhJUQokZ6lG5B/SwKZxy214JUBEwkD3oksgyIU7
         istAfVhWuEula15YiwuuizwoxnMXwDlMLjsl3Ae+IuL4B/FoFNz+9fnEn15GgpIPbrvd
         4deQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=2DpjEILTk0daqnT3HzP+xHnGn63RYtvLqOy7KC95BJ8=;
        b=Be6Qt1YyFPUHGOvy/qHMToYcqZl0x60G1HSPKPg4D8Url8vb+HPhZsBgDTOV2yHxKJ
         UFIlcjQ1ZG3NunW+aeWHcCWNSd6mjTl/Gkd1mmWZHn+XtCnTxqDq66kEmOZJjq1QkvbE
         T6cGRFSmrmZ253z3MocHGrNj3ZIunxt8UcFvkQacJ1qHGECfkuEUeqH63laX2UCwc2uN
         c3Ju+RUFDqL7UBmNjeZbGe3V8PQritobhBVuHQdYTYW7GzUoL69hik0+JBrbb3dhKmNS
         UGVfc8wRR4kMREDuP3tiYM895km3qW2afd/QQ7kqy6TTk7XFKWsmJDe1ONBNAlUph1Ln
         Y5jQ==
X-Gm-Message-State: AKwxytffkgsJ4xsKhnqsEMot20fapGTJa7pqg64oUtpMWNtXeZnsy51h
        Pw9/UTiFPupA88jBE4wS0p4=
X-Google-Smtp-Source: AH8x226Mmpko9JvioBI5aT9FzspOZikZbX5sNY/EIvPkPbqNgu/smyI18zCdR9eiuqN8mUYXIKkxSw==
X-Received: by 10.223.160.172 with SMTP id m41mr7121209wrm.32.1517311429168;
        Tue, 30 Jan 2018 03:23:49 -0800 (PST)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id 44sm23282920wrt.46.2018.01.30.03.23.47
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 30 Jan 2018 03:23:48 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH/RFC v5 7/7] Careful with CRLF when using e.g. UTF-16 for working-tree-encoding
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20180129201911.9484-1-tboegi@web.de>
Date:   Tue, 30 Jan 2018 12:23:47 +0100
Cc:     Git List <git@vger.kernel.org>, Johannes Sixt <j6t@kdbg.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes.Schindelin@gmx.de
Content-Transfer-Encoding: quoted-printable
Message-Id: <55B6C3D5-4131-4636-AD0E-20759EDBE8CD@gmail.com>
References: <xmqqshawfgaa.fsf@gitster.mtv.corp.google.com> <20180129201911.9484-1-tboegi@web.de>
To:     tboegi@web.de
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 29 Jan 2018, at 21:19, tboegi@web.de wrote:
>=20
> From: Torsten B=C3=B6gershausen <tboegi@web.de>
>=20
> UTF-16 encoded files are treated as "binary" by Git, and no CRLF
> conversion is done.
> When the UTF-16 encoded files are converted into UF-8 using the new
s/UF-8/UTF-8/


> "working-tree-encoding", the CRLF are converted if core.autocrlf is =
true.
>=20
> This may lead to confusion:
> A tool writes an UTF-16 encoded file with CRLF.
> The file is commited with core.autocrlf=3Dtrue, the CLRF are converted =
into LF.
> The repo is pushed somewhere and cloned by a different user, who has
> decided to use core.autocrlf=3Dfalse.
> He uses the same tool, and now the CRLF are not there as expected, but =
LF,
> make the file useless for the tool.
>=20
> Avoid this (possible) confusion by ignoring core.autocrlf for all =
files
> which have "working-tree-encoding" defined.

Maybe I don't understand your use case but I think this will generate =
even=20
more confusion because that's not what I would expect as a user. I think =
Git=20
should behave consistently independent of the used encoding. Here are my =
arguments:

  (1) Legacy users are *not* affected. If you don't use the =
"working-tree-encoding"
      attribute then nothing changes for you.

  (2) If you use the "working-tree-encoding" attribute *and* you want to =
ensure=20
      your file keeps CRLF then you can define that in the attributes =
too. E.g.:
     =20
      *.proj textworking-tree-encoding=3DUTF-16 eol=3Dcrlf

- Lars



> The user can still use a .gitattributes file and specify the line =
endings
> like "text=3Dauto", "text", or "text eol=3Dcrlf" and let that =
.gitattribute
> file travel together with push and clone.
>=20
> Change convert.c to e more careful, simplify the initialization when
> attributes are retrived (and none are specified) and update the =
documentation.
>=20
> Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
> ---
> Documentation/gitattributes.txt |  9 ++++++---
> convert.c                       | 15 ++++++++++++---
> 2 files changed, 18 insertions(+), 6 deletions(-)
>=20
> diff --git a/Documentation/gitattributes.txt =
b/Documentation/gitattributes.txt
> index a8dbf4be3..3665c4677 100644
> --- a/Documentation/gitattributes.txt
> +++ b/Documentation/gitattributes.txt
> @@ -308,12 +308,15 @@ Use the `working-tree-encoding` attribute only =
if you cannot store a file in
> UTF-8 encoding and if you want Git to be able to process the content =
as
> text.
>=20
> +Note that when `working-tree-encoding` is defined, core.autocrlf is =
ignored.
> +Set the `text` attribute (or `text=3Dauto`) to enable CRLF =
conversions.
> +
> Use the following attributes if your '*.txt' files are UTF-16 encoded
> -with byte order mark (BOM) and you want Git to perform automatic line
> -ending conversion based on your platform.
> +with byte order mark (BOM) and you want Git to perform line
> +ending conversion based on core.eol.
>=20
> ------------------------
> -*.txt		text working-tree-encoding=3DUTF-16
> +*.txt		working-tree-encoding=3DUTF-16 text
> ------------------------
>=20
> Use the following attributes if your '*.txt' files are UTF-16 little
> diff --git a/convert.c b/convert.c
> index 13fad490c..e7f11d1db 100644
> --- a/convert.c
> +++ b/convert.c
> @@ -1264,15 +1264,24 @@ static void convert_attrs(struct conv_attrs =
*ca, const char *path)
> 		}
> 		ca->checkout_encoding =3D git_path_check_encoding(ccheck =
+ 5);
> 	} else {
> -		ca->drv =3D NULL;
> -		ca->crlf_action =3D CRLF_UNDEFINED;
> -		ca->ident =3D 0;
> +		memset(ca, 0, sizeof(*ca));
> 	}
>=20
> 	/* Save attr and make a decision for action */
> 	ca->attr_action =3D ca->crlf_action;
> 	if (ca->crlf_action =3D=3D CRLF_TEXT)
> 		ca->crlf_action =3D text_eol_is_crlf() ? CRLF_TEXT_CRLF =
: CRLF_TEXT_INPUT;
> +	/*
> +	 * Often UTF-16 encoded files are read and written by programs =
which
> +	 * really need CRLF, and it is important to keep the CRLF "as =
is" when
> +	 * files are committed with core.autocrlf=3Dtrue and the repo is =
pushed.
> +	 * The CRLF would be converted into LF when the repo is cloned =
to
> +	 * a machine with core.autocrlf=3Dfalse.
> +	 * Obey the "text" and "eol" attributes and be independent on =
the
> +	 * local core.autocrlf for all "encoded" files.
> +	 */
> +	if ((ca->crlf_action =3D=3D CRLF_UNDEFINED) && =
ca->checkout_encoding)
> +		ca->crlf_action =3D CRLF_BINARY;
> 	if (ca->crlf_action =3D=3D CRLF_UNDEFINED && auto_crlf =3D=3D =
AUTO_CRLF_FALSE)
> 		ca->crlf_action =3D CRLF_BINARY;
> 	if (ca->crlf_action =3D=3D CRLF_UNDEFINED && auto_crlf =3D=3D =
AUTO_CRLF_TRUE)
> --=20
> 2.16.0.rc0.2.g64d3e4d0cc.dirty
>=20

