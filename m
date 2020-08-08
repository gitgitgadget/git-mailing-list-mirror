Return-Path: <SRS0=OIeF=BS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EAF6C433E0
	for <git@archiver.kernel.org>; Sat,  8 Aug 2020 13:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 793C120747
	for <git@archiver.kernel.org>; Sat,  8 Aug 2020 13:47:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gJjBu0En"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbgHHNrl (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 Aug 2020 09:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726233AbgHHNrk (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Aug 2020 09:47:40 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5474C061756
        for <git@vger.kernel.org>; Sat,  8 Aug 2020 06:47:38 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id f18so10451295wmc.0
        for <git@vger.kernel.org>; Sat, 08 Aug 2020 06:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=57UwoMRKgAxjnPYgIn7ufJZZ8CJxDqUSXsb548WzLJM=;
        b=gJjBu0EnC+DWMq8U8FaXuD7zXlzrGypgvtRAf5iauBh/wsF/Lf1XIK3Zstg+imqSX+
         bgKpsi7F1l3bG4jF5aFktmKspQ33lBwoSFFaArBsO2r49d6eHx7u4VJgvCYKFeaYK234
         d81DfzXKHc9Otg4fEnykyTp/OkimCY7hWIvwfhrqz+Cp3CoztEEDY0gx0i2Ao86lgRGh
         C88viK/8ceQaWQij+s/iGzUwFw4oi1UcrtAWy9dZlHEf2yUNtAcRKDfgZEFSF1Q7xdZm
         4P+s0r4IhBtoSj/c9QKHcPpty4Aho7TRiY+0lVH+HGFvvdusCadJRCW7FACwyZuAbWK2
         DUeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=57UwoMRKgAxjnPYgIn7ufJZZ8CJxDqUSXsb548WzLJM=;
        b=mPYCbX/OcILu32LKnuUm3EzyntbtT+cnCIBjG1ip/lcgouD/wFMTyEAqxJ5U3O59Sb
         BVRD+CM9x4F1i/opnRIFhu1IUb2w3b5t9PvN4NkLZb9BsYtME0HXyoqOFt6GStrYRj4+
         31iilKCAfXY+14d4//ZjQjVwWxHFlbmjcoFtMfgNKng6eDSaJQu/QL69ZmHjXJX5CYmI
         ynjHYvQJ+SJme1gXZ2IwwxX6lOGbMKIYaIo7U/oAOCSgOUx2tY4AnDg5X36k2JVoPaBE
         7K1oC0WRdbG/PVF1B8tvHoNPpNkMAvNX0y1MEj8dZAGCof9pkuvhoAsLGyMln8omL4ai
         TQgA==
X-Gm-Message-State: AOAM533xpsZ9UKitmGmcK6OLO2xtywI0HXYmf1tHZgbFIC4B22G1srft
        IZNaBYqFxX/e/+4bsA4Bk5RlG/w2
X-Google-Smtp-Source: ABdhPJwxVEL7iO1cnBTdTuJqxR89MJhNEOFhH/peFenbkS25rpDXmN7eEf+vtnGAAT8peSrgqZlZ8g==
X-Received: by 2002:a1c:bc0b:: with SMTP id m11mr17579017wmf.83.1596894455368;
        Sat, 08 Aug 2020 06:47:35 -0700 (PDT)
Received: from [192.168.1.240] (161.252.189.80.dyn.plus.net. [80.189.252.161])
        by smtp.gmail.com with ESMTPSA id f16sm12917033wro.34.2020.08.08.06.47.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Aug 2020 06:47:34 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v5 1/3] apply: allow "new file" patches on i-t-a entries
To:     "Raymond E. Pasco" <ray@ameretat.dev>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <20200806060119.74587-1-ray@ameretat.dev>
 <20200808074959.35943-1-ray@ameretat.dev>
 <20200808074959.35943-2-ray@ameretat.dev>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <ce8ba994-2b0c-ecb6-51f0-44b5058bb0b1@gmail.com>
Date:   Sat, 8 Aug 2020 14:47:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200808074959.35943-2-ray@ameretat.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Raymond

On 08/08/2020 08:49, Raymond E. Pasco wrote:
> diff-files recently changed to treat changes to paths marked "intent to
> add" in the index as new file diffs rather than diffs from the empty
> blob.  However, apply refuses to apply new file diffs on top of existing
> index entries, except in the case of renames. This causes "git add -p",
> which uses apply, to fail when attempting to stage hunks from a file
> when intent to add has been recorded.
> 
> This changes the logic in check_to_create() which checks if an entry
> already exists in an index in two ways: first, we only search for an
> index entry at all if ok_if_exists is false; second, we check for the
> CE_INTENT_TO_ADD flag on any index entries we find and allow the apply
> to proceed if it is set.

Thanks for working on this, I got stung by not being able to apply a 
patch because the path was marked i-t-a recently

Best Wishes

Phillip

> 
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Raymond E. Pasco <ray@ameretat.dev>
> ---
>   apply.c | 11 +++++++----
>   1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/apply.c b/apply.c
> index 8bff604dbe..4cba4ce71a 100644
> --- a/apply.c
> +++ b/apply.c
> @@ -3747,10 +3747,13 @@ static int check_to_create(struct apply_state *state,
>   {
>   	struct stat nst;
>   
> -	if (state->check_index &&
> -	    index_name_pos(state->repo->index, new_name, strlen(new_name)) >= 0 &&
> -	    !ok_if_exists)
> -		return EXISTS_IN_INDEX;
> +	if (state->check_index && !ok_if_exists) {
> +		int pos = index_name_pos(state->repo->index, new_name, strlen(new_name));
> +		if (pos >= 0 &&
> +		    !(state->repo->index->cache[pos]->ce_flags & CE_INTENT_TO_ADD))
> +			return EXISTS_IN_INDEX;
> +	}
> +
>   	if (state->cached)
>   		return 0;
>   
> 
