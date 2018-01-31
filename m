Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 432101F404
	for <e@80x24.org>; Wed, 31 Jan 2018 19:37:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751435AbeAaThe (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jan 2018 14:37:34 -0500
Received: from mail-wr0-f169.google.com ([209.85.128.169]:46897 "EHLO
        mail-wr0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751405AbeAaThd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jan 2018 14:37:33 -0500
Received: by mail-wr0-f169.google.com with SMTP id g21so16290374wrb.13
        for <git@vger.kernel.org>; Wed, 31 Jan 2018 11:37:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=bg/OvHvYD/b5/cNDdBYYp17yrjbdrjcOKJQ5zViNqpM=;
        b=ftAimJ9i+rSHBYdlf6YU/XAP126Lhg1t64dwk3g8lAl9eiwwUtPPu1Mu4TWqU8ao9D
         MerVXgp9CC9GpKCJ/ynec1IZJx6pmfxS3ZH+j95ELkiRlK1SL9ZIWPwToqou/J8YzEEQ
         IH7HStsqlwFltK+Pbo4XJAQDQYNWetViaQ5hUwDnAGsUsIrGMkN4ce8iESJsIhjDtW0U
         yvOy1GeHvi63KyBCz8UwDzKuEg43MJpz5ttpJiKvyL34amXmz41jPb7cN/qRZGPOFN7x
         xWZ8UDsjMYlZddPWOOs5VHPw0C38BcYrVRLOGdSfuc3iQqVkDiyBCaC74Var+TRyTljM
         X5sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=bg/OvHvYD/b5/cNDdBYYp17yrjbdrjcOKJQ5zViNqpM=;
        b=FgPn1Fuof5/h6dbUPHxmfkTxt1ExTh3/RVtQCXscdBF+3mH+x0qaj5ADkVjDnHkuIO
         kuckRBSkXlY7qaaCUFB7/TuDmG+dMthBR+/Rtg+j9Xpk96uRHFEEGFfCDTbEk3MHMYJg
         16KgU3XWe44lQnaYce+Vi0PANq1R770FOF8bL8iJFbMFGG3MB0vxz4VLTO4VBaONkHtr
         OM74UV/kYUxw6p+ACFJnvO2JtGDKZaX2o4GaQWz6TtOIyvySi/vchG4/6Uxru/WHy5F5
         GNfOzutbB3x35+X1DZbHnIza+TQXRFH4XAZa59LZDDA2hK4JHpaJRGMpaY6JKaiTwd57
         fzZA==
X-Gm-Message-State: AKwxyte/ej5BrOsP+D/tApezKPFaG7jKzbn1d/Ry+5YwfmgKR37wA0s8
        feHYj7ZKZVvMoy7mGAsoYVx0nRUe
X-Google-Smtp-Source: AH8x227z9w8E5jsaK3JMlUnLDwFy3pESMWeDvy4HkR6AQU13/HaV0j3giQGMMInkl+GKNXxIFkflKg==
X-Received: by 10.223.176.172 with SMTP id i41mr14122061wra.47.1517427452161;
        Wed, 31 Jan 2018 11:37:32 -0800 (PST)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id 44sm26611570wrt.46.2018.01.31.11.37.31
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 31 Jan 2018 11:37:31 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH/RFC v5 7/7] Careful with CRLF when using e.g. UTF-16 for working-tree-encoding
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20180131172837.GA32723@tor.lan>
Date:   Wed, 31 Jan 2018 20:37:30 +0100
Cc:     Git List <git@vger.kernel.org>, Johannes Sixt <j6t@kdbg.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes.Schindelin@gmx.de
Content-Transfer-Encoding: quoted-printable
Message-Id: <F3D39E4F-D467-4A6E-95A4-A76BFEDF14BF@gmail.com>
References: <xmqqshawfgaa.fsf@gitster.mtv.corp.google.com> <20180129201911.9484-1-tboegi@web.de> <55B6C3D5-4131-4636-AD0E-20759EDBE8CD@gmail.com> <20180130144002.GA30211@tor.lan> <10091BA4-1069-4A65-9057-CAAD87F9B55F@gmail.com> <20180131172837.GA32723@tor.lan>
To:     =?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 31 Jan 2018, at 18:28, Torsten B=C3=B6gershausen <tboegi@web.de> =
wrote:
>=20
> []
>>> That is a good one.
>>> If you ever plan a re-roll (I don't at the moment) the *.proj =
extemsion
>>> make much more sense in Documentation/gitattributes that *.tx
>>> There no text files encoded in UTF-16 wich are called xxx.txt, but =
those
>>> are non-ideal examples. *.proj makes good sense as an example.
>>=20
>> OK, I'll do that. Would that fix the problem which this patch tries =
to address for you?
>> (I would also explicitly add a paragraph to discuss line endings)
>=20
> Please let me see the patch first, before I can have a comment.

Sure! I'll have it ready tomorrow.


> But back to the more general question:
>=20
> How should Git handle the line endings of UTF-16 files in the =
woring-tree,
> which are UTF-8 in the index?
>=20
>=20
> There are 2 opposite opionions/user expectations here:
>=20
> a) They are binary in the working tree, so git should leave the line =
endings
>   as is. (Unless specified otherwise in the .attributes file)

Well, if you consider your UTF-16 files binary then you would not change
*anything*. You would not enable the new "working-tree-encoding" =
attribute.
As a consequence, Git's behavior would not change. Git would leave all =
line=20
endings as they are for the UTF-16 files.


> b) They are text files in the index. Git will convert line endings
>   if core.autocrlf is true (or the .gitattributes file specifies =
"-text")

This would *only* happen if you enable the new "working-tree-encoding"
attribute. In this case a user has already made the conscious decision =
to
treat these files as text files. Therefore, the user expects Git to =
handle
them in the same way other text files are handled.


> My feeling is that both arguments are valid, so let's ask for opinions
> and thoughts of others.
> Erik, Junio, Johannes, Johannes, Jeff, Ramsay, everybody:
> What do yo think ?

- Lars=
