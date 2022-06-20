Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F29C433EF
	for <git@archiver.kernel.org>; Mon, 20 Jun 2022 22:18:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241907AbiFTWSk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jun 2022 18:18:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245562AbiFTWSh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Jun 2022 18:18:37 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCAC01B794
        for <git@vger.kernel.org>; Mon, 20 Jun 2022 15:18:36 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id 88so14338866qva.9
        for <git@vger.kernel.org>; Mon, 20 Jun 2022 15:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2sB9oID9ufkm6I59O6sF31+HfakJdKm4Etuagl1ckF4=;
        b=Hfo33A+ZCZ9HR6c+79Cc6v/bujOHv6kb7PGNGI2grmPAHBsmRW2GOudWQgxBzq1mON
         aPUi+yigfoIVOauSAWEpWCL5Rtuy6NqMh7lvhoIX/58HAgvyiHqPDsBQ4h0CAB/le4RG
         lB/Ehh8j+DLs2VHhubiUu0IQNME+kaL3ZgpsG9TxDAGepbFuuh1k5DqYtHySQMg5qxx1
         MmbDrfNWS0cvp87Ur0W+ZBe1ICpIEIWyxqZyjPwk09ai7KjynN5pqRCs5HVUEhKtjmsU
         60VujFtV6T9h0W/eKB6UGQeCp64iXpGF1fc47pDVLF7mo/l83ZnAssotBSG7k3XDEjoj
         11bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2sB9oID9ufkm6I59O6sF31+HfakJdKm4Etuagl1ckF4=;
        b=WR2sbHH/xMryb5ErcfvzYtvY3ENk/0NAZA/qyV1IQ9hxi9chUVaKwWw7DPEkN8wRiH
         3ouoFd2QetMLYKhKOPCbmP6Z3/ecGVhMY+CpkQ6x1fV7TK+2Ow6hxaHY9KJGiVV6Gpe8
         I2wHtz6bsrNSVaWLp5sQdUvxMERAVBluNgNGUvUrn3MfFX5o3lU23VjS1gkFnfDUaMuT
         Rf001Yl6mxjvYK5CA8py3+fu+uXz6TyDTYyw5HsoNAJbFphmwST75ps5iEf07E90HMJe
         ZKwwIcW1dn7/tUa2qTXGa3nJ/nxRzUUWk3rkHysSezSfc524opkeJXjr4FcvWIGfvXHf
         +Vqg==
X-Gm-Message-State: AJIora9CF8f2wq5ebWjCqqtzM4AJjNWsQgxCDwVNP4gJnWAGcjaZ0J4u
        sMSgtDjIEm0nTYLJmI5O3G3odg==
X-Google-Smtp-Source: AGRyM1sBjGXWGJ0plXB5tvRPFDQfM8NyHHJtjDkkxdwSAMRh9H8BkFCzDzlTyqkLTuwsApPRIJVCug==
X-Received: by 2002:ac8:5b0d:0:b0:305:2025:c687 with SMTP id m13-20020ac85b0d000000b003052025c687mr21992426qtw.535.1655763515846;
        Mon, 20 Jun 2022 15:18:35 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id ay31-20020a05620a179f00b006a7137330e2sm11911677qkb.132.2022.06.20.15.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 15:18:35 -0700 (PDT)
Date:   Mon, 20 Jun 2022 18:18:34 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Taylor Blau via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Kaartic Sivaram <kaartic.sivaraam@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Taylor Blau <ttaylorr@github.com>
Subject: Re: [PATCH 4/6] builtin/pack-objects.c: learn
 pack.writeBitmapLookupTable
Message-ID: <YrDyOivHcnA1qirF@nand.local>
References: <pull.1266.git.1655728395.gitgitgadget@gmail.com>
 <661c1137e1c918619f6624d2e331bafd9c3281dc.1655728395.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <661c1137e1c918619f6624d2e331bafd9c3281dc.1655728395.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 20, 2022 at 12:33:12PM +0000, Taylor Blau via GitGitGadget wrote:
> From: Taylor Blau <ttaylorr@github.com>
>
> Teach git to provide a way for users to enable/disable bitmap lookup
> table extension by providing a config option named 'writeBitmapLookupTable'.
>
> Signed-off-by: Taylor Blau <ttaylorr@github.com>
> Signed-off-by: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
> ---
>  Documentation/config/pack.txt | 7 +++++++
>  builtin/pack-objects.c        | 8 ++++++++
>  2 files changed, 15 insertions(+)
>
> diff --git a/Documentation/config/pack.txt b/Documentation/config/pack.txt
> index ad7f73a1ead..e12008d2415 100644
> --- a/Documentation/config/pack.txt
> +++ b/Documentation/config/pack.txt
> @@ -164,6 +164,13 @@ When writing a multi-pack reachability bitmap, no new namehashes are
>  computed; instead, any namehashes stored in an existing bitmap are
>  permuted into their appropriate location when writing a new bitmap.
>
> +pack.writeBitmapLookupTable::
> +	When true, git will include a "lookup table" section in the

s/git/Git (I typically use "git" when talking about the command-line
tool, and Git when talking about the project as a proper noun).

> +	bitmap index (if one is written). This table is used to defer
> +	loading individual bitmaps as late as possible. This can be
> +	beneficial in repositories which have relatively large bitmap
> +	indexes. Defaults to false.

Is there a reason that we would want to default to "false" here? Perhaps
in the first version of two we would want this to be an opt-in (since
there is no publicly documented way to opt-out of reading the extension
once it is written).

We should make sure to enable this by default at some point in the
future.

>  pack.writeReverseIndex::

...since it's easy to forget ;-).

Thanks,
Taylor
