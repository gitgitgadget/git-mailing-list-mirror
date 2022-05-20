Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82CF5C433F5
	for <git@archiver.kernel.org>; Fri, 20 May 2022 22:42:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235877AbiETWmL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 May 2022 18:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbiETWmJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 May 2022 18:42:09 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3961185408
        for <git@vger.kernel.org>; Fri, 20 May 2022 15:42:08 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id m1so8718434qkn.10
        for <git@vger.kernel.org>; Fri, 20 May 2022 15:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=K/dVQ69sbX9MT9/IiV6ZTU97psbFEtJIm7aMyGElRIM=;
        b=01JkK6t+4UBt+Q9+snusVenhVoWNa2IN2vcaPcXpxoV6IFArbrH7ztOcYA07UwLJLb
         ZPfEuUHTOaOKufrmmbCyGoat/4qVlcpSBEhmYmwB/5OnZNGQLYC+Hy3CDtf/+Uoja/a5
         kQJDr+3ZljoREIofkT+rtvoZur3r2jhsqy30XiECQI7T8DhwWiNFqrF5obGwEVuwlDPb
         kTMBoFDs9cYctaXDBvsgJrMe7fFKzf7enl4WsmWjUpSObiwbOwWa/cQyK9rK1KRKHlX2
         6P95paUbBPV69sabE0/UVjwtqUYsRKy96co0MOr1JLEVo5bdzG1bYO9TAAIp4Ru5iXlt
         hKnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=K/dVQ69sbX9MT9/IiV6ZTU97psbFEtJIm7aMyGElRIM=;
        b=h3mi5smlm7p03tOMiAIa0r7JWBPFEIwz7onhbn7dfnDIVs/TNTIqDqNHGXz9NgsDdI
         9Ue2Bru9nCyoW3b7s3H9F2PjkvkfRb9K8N+f+44UR/sSmMFTR+LPbLfdw6LtR8D1MPbW
         /+QfePHWrzy+/pazk86wGaJZvljhwsl1tUIwj7zo/vvDWg2oE1/DQ+ViOIxUKIVfbRmb
         lLtvp6AWSoWhjFDvF90IOAzyVEkcSQd1KsW5T/R3dLO0uoWIF1RQUkY1Rlpknc3bhTXO
         vEr6v+9+FoaDxtw990LeKgR6oH/CFY/RpcP7CDmclpBYNQpT5IwFijSU4pNvFeg/sFsS
         MC1Q==
X-Gm-Message-State: AOAM532C/oN7H3iE9sdoeE4DR4gbSYG9wfGbA98pdppwT32dIG8H/f2U
        bwRsZGJy0skeSKILReFyRAvTiA==
X-Google-Smtp-Source: ABdhPJw1RUrPIxQJsSQpXmrfW3X0E6g4gMEdCFuRWB55H2BBySX4rjxR/5QP8qmG8JVd8lDgnJsiSQ==
X-Received: by 2002:a37:ad6:0:b0:6a3:4c5c:df0f with SMTP id 205-20020a370ad6000000b006a34c5cdf0fmr3173255qkk.154.1653086527867;
        Fri, 20 May 2022 15:42:07 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id a5-20020ac86105000000b002f39b99f672sm472563qtm.12.2022.05.20.15.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 15:42:07 -0700 (PDT)
Date:   Fri, 20 May 2022 18:42:06 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, derrickstolee@github.com, gitster@pobox.com,
        jrnieder@gmail.com, larsxschneider@gmail.com, tytso@mit.edu
Subject: Re: [PATCH v4 15/17] builtin/repack.c: add cruft packs to MIDX
 during geometric repack
Message-ID: <YogZPpWAamW1qREE@nand.local>
References: <cover.1638224692.git.me@ttaylorr.com>
 <cover.1652915424.git.me@ttaylorr.com>
 <0743e373baaaaee2bc5f8664b1e64038e6dbf4c2.1652915424.git.me@ttaylorr.com>
 <220519.86r14p4v0q.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <220519.86r14p4v0q.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 19, 2022 at 01:32:26PM +0200, Ævar Arnfjörð Bjarmason wrote:
> > @@ -161,8 +162,11 @@ static void collect_pack_filenames(struct string_list *fname_nonkept_list,
> >  		if ((extra_keep->nr > 0 && i < extra_keep->nr) ||
> >  		    (file_exists(mkpath("%s/%s.keep", packdir, fname))))
> >  			string_list_append_nodup(fname_kept_list, fname);
> > -		else
> > -			string_list_append_nodup(fname_nonkept_list, fname);
> > +		else {
> > +			struct string_list_item *item = string_list_append_nodup(fname_nonkept_list, fname);
>
> Nit: very long line, and we end up with {} just on the else, not the if.

Thanks for spotting, I split this line up and added braces to the other
half of this conditional.

Thanks,
Taylor
