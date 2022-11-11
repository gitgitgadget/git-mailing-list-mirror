Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A13FC4167B
	for <git@archiver.kernel.org>; Fri, 11 Nov 2022 15:14:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234952AbiKKPOk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Nov 2022 10:14:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234950AbiKKPOM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Nov 2022 10:14:12 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C833B787BD
        for <git@vger.kernel.org>; Fri, 11 Nov 2022 07:12:20 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id r14so8013158edc.7
        for <git@vger.kernel.org>; Fri, 11 Nov 2022 07:12:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kharv0dr7eGmnDcIycMZlcBTuR/deNZgHHmaLub0W0Y=;
        b=Q9CA0mrWtVJj0qqSqVUbxCers3do86PZejesb9bqjtePeWqPvdIdK5eFF1V+QYQRRv
         osm/MsAfbrlStba+I3nFTQw1oGnmdPwoD2OU5W02WWlW4PGzQUIzLdDTCvO/QIZ1gi//
         SwS+hJFs1iIWMByI7hiQRGmbuuWwnXmGxGV8dCMEEieK4YsTAG4gLR3B9ca15egxwbpV
         dRR9gHWS/VTzZH2o1TIdRELrP4EO3RTTejIYiqPe2uF7snwNeKM/D18JgxG8PFvgjurZ
         LOrtjdwd0nkHVNppLH5ePrqEfox6N/jcJErFCHir1J3GeIOG2cb8iEk3gxPTuFea4LlM
         TTow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kharv0dr7eGmnDcIycMZlcBTuR/deNZgHHmaLub0W0Y=;
        b=x42YVKiCa5oVjdr3VikmC5TrrW9AlaVNjXwHpFbdPsYnDKNId4uoCKX1WiNyg3EFZ9
         V9FxKjmPVTrcOSCY5yQm55Pw2vuzbBbftcfKEXsrqkOj7J8Fv08drGFGEd2z+iKhikr7
         3UcBZXK2/TzxMtRJ4xZ2PtdAdnZy6FdEKZs+aI6mPAIALJcW8j3hSUR0H6J6m9+TKtRF
         nf9urw6e/JnGvbcxrA9+oitSEKgW4FcQ7uoh70eyiFcCq7TP+KsfAt+xW02dJ6kRTRF/
         SvbmbmLVyVo+F2cs7KWqbzH56iwYNGnzsYIyommYVXvOrnbLiIb5AaNTtYrrjlYVUafw
         EbEA==
X-Gm-Message-State: ANoB5pm60HdJBsroZ4NzjpKWjLbD2nW+gxA1trLeAN6Lkj4lHfPgDAUw
        iQtXtCpONqdqsfgGEVIIZI5ldKJJIXgncA==
X-Google-Smtp-Source: AA0mqf6wS4yj31Lco1ptZrw2XkW14K/3wU9z2BuG6yNfJ7BQPCfJpbjJsecuDZKF+AnOwbTh/BFNag==
X-Received: by 2002:a05:6402:b63:b0:460:6194:d293 with SMTP id cb3-20020a0564020b6300b004606194d293mr1854875edb.331.1668179538837;
        Fri, 11 Nov 2022 07:12:18 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id c20-20020a17090603d400b007417041fb2bsm965627eja.116.2022.11.11.07.12.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 07:12:18 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1otVha-001wzE-01;
        Fri, 11 Nov 2022 16:12:18 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "Strawbridge, Michael" <Michael.Strawbridge@amd.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "Tuikov, Luben" <Luben.Tuikov@amd.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 2/2] Update sendemail-validate hook docs to add header
 file parameter
Date:   Fri, 11 Nov 2022 16:10:29 +0100
References: <20221111021502.449662-1-michael.strawbridge@amd.com>
 <20221111021502.449662-3-michael.strawbridge@amd.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <20221111021502.449662-3-michael.strawbridge@amd.com>
Message-ID: <221111.86sfipmsoe.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Nov 11 2022, Strawbridge, Michael wrote:

> Add documentation for the new smtp header file parameter used by the
> sendemail-validate git-send-email hook.
>
> sendemail-validate accepts the patch file as the first parameter (same as
> before) and now also adds the smtp header information as the second parameter.
>
> Cc: Luben Tuikov <luben.tuikov@amd.com>
> Cc: brian m. carlson <sandals@crustytoothpaste.net>
> Signed-off-by: Michael Strawbridge <michael.strawbridge@amd.com>
> ---
>  Documentation/githooks.txt | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
> index a16e62bc8c..c1baf34454 100644
> --- a/Documentation/githooks.txt
> +++ b/Documentation/githooks.txt
> @@ -583,10 +583,10 @@ processed by rebase.
>  sendemail-validate
>  ~~~~~~~~~~~~~~~~~~
>  
> -This hook is invoked by linkgit:git-send-email[1].  It takes a single parameter,
> -the name of the file that holds the e-mail to be sent.  Exiting with a
> -non-zero status causes `git send-email` to abort before sending any
> -e-mails.
> +This hook is invoked by linkgit:git-send-email[1].  It takes two parameters,
> +the name of a file that holds the patch and the name of a file that holds the
> +smtp headers.  Exiting with a non-zero status causes `git send-email` to abort
> +before sending any e-mails.
>  
>  fsmonitor-watchman
>  ~~~~~~~~~~~~~~~~~~

As this is just documenting the change in 1/2 after-the-fact, we really
should squash it into that.

If you are doing another commit, the better thing to do would be to
first change the docs to say e.g.:
	
	This hook is invoked by linkgit:git-send-email[1]. It's provided with
	these parameters, in order:
	
	* A file that holds the....
	
Then instead of your "actual" change being a reword change etc. you can
just add another bullet-point.

Or you could just squash this as-is...
