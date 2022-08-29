Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC94ECAAD2
	for <git@archiver.kernel.org>; Mon, 29 Aug 2022 07:36:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbiH2Hg1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Aug 2022 03:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiH2HgZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2022 03:36:25 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3B1E4E62D
        for <git@vger.kernel.org>; Mon, 29 Aug 2022 00:36:24 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id z3-20020a17090abd8300b001fd803e34f1so5174982pjr.1
        for <git@vger.kernel.org>; Mon, 29 Aug 2022 00:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc;
        bh=PziCySbj1BVepycX+hmB/Ql8erUIJJThoFPPyoeCc2A=;
        b=migAvUmZFiUnw5hGBBgcvLKadonJpdGAeCrAB4KtmCvwzhQCrI3jgMGpsPma5uTQ5O
         qIr7nD56wdl5pb6cQa6ljcRdz9/sDHgVwuoqeEtTdbMdWm8cUJQ3Z/J3yvPQ28PhZYYa
         wsuFt3tSDJGgXAyuLHqu48lLQm7kvEIBANFzo8S/AWMNM8Ogf3w7DPi7eh5EL7FRGd3w
         BbfFzf1nUbuVSPUXOW1ISXEmQKuJeBxRIZy5OaV0KK5wyyEe1k++1Y5ckLH6bQLqp0pT
         ThVCfk2pquHdFwqPq8muiAn8nOfuABgSOeXMEDXYdOir5cHAmEjEaeTXfptxL/V+Pa4e
         WYUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc;
        bh=PziCySbj1BVepycX+hmB/Ql8erUIJJThoFPPyoeCc2A=;
        b=CofTvMqLko4QRzQpSMhK3czQfXXmap5SWYIDe27JWOmu8i98t6hDng9dpLkt4tu+SB
         qSYX2qleZiTamuRd+zAIcP4vuKpjaMzyaomBrPUjvju4l5wnx3U9Om78npmUXRG7oRUQ
         4uFs8ffPmbibKHFGczyDYRHsa2+mjJR9L+1ai4DIWFKpqBXkqC5nGQCWSHTjKyvSPqw1
         Fa86kcdwGgZ+9/uj3hka7V9iON17kPCGEuk/yHvwg9AYsE9Jr8IYOBqUWdtNrMmTlvhR
         W4SdTNb+l6JXgw54mWkLuIIcRFQVbz5CfDanIqA8JRROcM+Vs+rSmXjv4lNpfgtXwdKZ
         YdBQ==
X-Gm-Message-State: ACgBeo0xGp4XbVH6UyXtTUR/9i5aaMZBCFOxh9POSTxW/NfYvrvZNdCd
        640ABgExBbneKKXaJkYNjLJRKIdPVrU=
X-Google-Smtp-Source: AA6agR6qB6zTZxTS+fJxJwoURKO5KsoH/edQXeMvSofL7vYfpxgKF0Z277x9XA2hbs2BfK11SSWcuA==
X-Received: by 2002:a17:902:e80e:b0:173:23e:d5a6 with SMTP id u14-20020a170902e80e00b00173023ed5a6mr15010592plg.85.1661758584255;
        Mon, 29 Aug 2022 00:36:24 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id x18-20020aa78f12000000b0053788e9f865sm6433946pfr.21.2022.08.29.00.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 00:36:23 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        git@vger.kernel.org
Subject: Re: ac/bitmap-lookup-table, was Re: What's cooking in git.git (Aug
 2022, #09; Fri, 26)
References: <xmqqbks6ya5d.fsf@gitster.g>
        <YwtkqmPSEikWPLv5@coredump.intra.peff.net>
Date:   Mon, 29 Aug 2022 00:36:23 -0700
Message-ID: <xmqqh71vqz60.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> We may want this on top:

Obviously correct.  Thanks.  Will queue.

>
> -- >8 --
> Subject: pack-bitmap-write: drop unused pack_idx_entry parameters
>
> Our write_selected_commits_v1() function takes an array of
> pack_idx_entry structs. We used to need them for computing commit
> positions, but since aa30162559 (bitmap: move `get commit positions`
> code to `bitmap_writer_finish`, 2022-08-14), the caller passes in a
> separate array of positions for us. We can drop the unused array (and
> its matching length parameter).
>
> Likewise, when we added write_lookup_table() in 93eb41e240
> (pack-bitmap-write.c: write lookup table extension, 2022-08-14), it
> receives the same array of positions. So its "index" parameter was never
> used at all.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  pack-bitmap-write.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
> index 2cfc92f287..a213f5eddc 100644
> --- a/pack-bitmap-write.c
> +++ b/pack-bitmap-write.c
> @@ -649,8 +649,6 @@ static const struct object_id *oid_access(size_t pos, const void *table)
>  }
>  
>  static void write_selected_commits_v1(struct hashfile *f,
> -				      struct pack_idx_entry **index,
> -				      uint32_t index_nr,
>  				      uint32_t *commit_positions,
>  				      off_t *offsets)
>  {
> @@ -685,8 +683,6 @@ static int table_cmp(const void *_va, const void *_vb, void *_data)
>  }
>  
>  static void write_lookup_table(struct hashfile *f,
> -			       struct pack_idx_entry **index,
> -			       uint32_t index_nr,
>  			       uint32_t *commit_positions,
>  			       off_t *offsets)
>  {
> @@ -808,10 +804,10 @@ void bitmap_writer_finish(struct pack_idx_entry **index,
>  		commit_positions[i] = commit_pos;
>  	}
>  
> -	write_selected_commits_v1(f, index, index_nr, commit_positions, offsets);
> +	write_selected_commits_v1(f, commit_positions, offsets);
>  
>  	if (options & BITMAP_OPT_LOOKUP_TABLE)
> -		write_lookup_table(f, index, index_nr, commit_positions, offsets);
> +		write_lookup_table(f, commit_positions, offsets);
>  
>  	if (options & BITMAP_OPT_HASH_CACHE)
>  		write_hash_cache(f, index, index_nr);
