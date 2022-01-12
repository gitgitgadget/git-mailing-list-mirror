Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE921C433F5
	for <git@archiver.kernel.org>; Wed, 12 Jan 2022 19:32:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343985AbiALTcD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jan 2022 14:32:03 -0500
Received: from mail-pj1-f42.google.com ([209.85.216.42]:52967 "EHLO
        mail-pj1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345000AbiALTbw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jan 2022 14:31:52 -0500
Received: by mail-pj1-f42.google.com with SMTP id pj2so7197597pjb.2
        for <git@vger.kernel.org>; Wed, 12 Jan 2022 11:31:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZP8q83z24mkvKkF9xvx01eI02//BgsEeEYszMR4NB4s=;
        b=xHj2xxSLZoaX9v0Z+CtIVFh8oZOIO8l10teIsuY9A6oQiy6KkgBOb+Lb6tDlMDQuPS
         GAEDOOpMYZH1FXTQGv8dx29DXz1J/cinsuqz+QR1K/acuyPgv0/hSRALqAGvzxKWrQeF
         CNB+HCy0oAYBDXK4MsGEVrHESRV1O8V2ul+s8XuSuuQBZBMo9Dk01NZqFAR2pyVA1M7h
         h3SVtPu5V+QrZe0MQ+mD1rLrCQJWWubn85WZyg7w8/TFGJIbQSgxDl9qDL6vkWV4XiBT
         iq8XMvLZ+xbZvlfxqyaQNoiUWuLc2iNU8DgGwOPJlwIkskYVSlQ+0eVTwc6cKC9qn538
         Gr8w==
X-Gm-Message-State: AOAM532WQlfAwCR46uLM9nbggTaJLZeV1zU4Z1ITZ8O4mrZVf+AidjOy
        gLAkv96A6BNWTfelXUtYBfGiCF4ZLFMnK9XLOz0eXVMH+Ew=
X-Google-Smtp-Source: ABdhPJyTOSQI1KEa9C+Oj5tW1SFFRBSAjM0yffE1rW9Ckga3/BxurhuMBEHT/NQr8IM0N4evklO00Dk8ilFk9PRMgFk=
X-Received: by 2002:a63:8bca:: with SMTP id j193mr969987pge.227.1642015911611;
 Wed, 12 Jan 2022 11:31:51 -0800 (PST)
MIME-Version: 1.0
References: <20220112134635.177877-1-jholdsworth@nvidia.com> <20220112134635.177877-6-jholdsworth@nvidia.com>
In-Reply-To: <20220112134635.177877-6-jholdsworth@nvidia.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 12 Jan 2022 14:31:40 -0500
Message-ID: <CAPig+cRemRqk44csVJ+QRiZ0MPZpMwzNCSFLCz+qFdh-pcc5KQ@mail.gmail.com>
Subject: Re: [PATCH 05/20] git-p4: convert descriptive class and function
 comments into docstrings
To:     Joel Holdsworth <jholdsworth@nvidia.com>
Cc:     Git List <git@vger.kernel.org>, Luke Diamand <luke@diamand.org>,
        Junio C Hamano <gitster@pobox.com>,
        Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>,
        Dorgon Chang <dorgonman@hotmail.com>,
        Joachim Kuebart <joachim.kuebart@gmail.com>,
        Daniel Levin <dendy.ua@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Ben Keene <seraphire@gmail.com>,
        Andrew Oakley <andrew@adoakley.name>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 12, 2022 at 8:47 AM Joel Holdsworth <jholdsworth@nvidia.com> wrote:
> Previously, a small number of functions, methods and classes were
> documented using comments. This patch improves consistency by converting
> these into docstrings similar to those that already exist in the script.
>
> Signed-off-by: Joel Holdsworth <jholdsworth@nvidia.com>
> ---
> diff --git a/git-p4.py b/git-p4.py
> @@ -1332,13 +1333,15 @@ def getClientRoot():
> -# P4 wildcards are not allowed in filenames.  P4 complains
> -# if you simply add them, but you can force it with "-f", in
> -# which case it translates them into %xx encoding internally.
> -#
>  def wildcard_decode(path):
> -    # Search for and fix just these four characters.  Do % last so
> +    """Decode P4 wildcards into %xx encoding
> +
> +       P4 wildcards are not allowed in filenames.  P4 complains if you simply
> +       add them, but you can force it with "-f", in which case it translates
> +       them into %xx encoding internally.
> +       """
> +
> +    # Search for and fix just these four characters. Do % last so

The unnecessary whitespace change in the "Search for and fix..." line
makes for a noisier diff and wasted a little bit of review time. Don't
know if it's worth a re-roll, though.

> @@ -3006,9 +3020,9 @@ def encodeWithUTF8(self, path):
> -    # output one file from the P4 stream
> -    # - helper for streamP4Files
>      def streamOneP4File(self, file, contents):
> +        """Output one file from the P4 stream - helper for streamP4Files."""

The hyphen is slightly difficult to interpret. A double hyphen, or
even better a semicolon, would have helped set off the second phrase
from the first. Alternatively, writing it as:

    """Output one file from the P4 stream.

        This is a helper for streamP4Files().
        """

might be even clearer. Probably not worth a re-roll, though.
