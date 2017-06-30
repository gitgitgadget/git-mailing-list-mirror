Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 71E54201A0
	for <e@80x24.org>; Fri, 30 Jun 2017 19:50:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752880AbdF3Tuu (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Jun 2017 15:50:50 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33103 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1752875AbdF3Tus (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jun 2017 15:50:48 -0400
Received: by mail-pg0-f67.google.com with SMTP id u62so16317165pgb.0
        for <git@vger.kernel.org>; Fri, 30 Jun 2017 12:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=WfdklIuXpIl5bc94kLJIZqO8ks0ayWcE+hCgNHHs00Q=;
        b=Q2bI7bn0qXHkZ/aV921TtL14Ol/iYlvtjBe9znNd40hzK6cW1pcOxQFPR5T6+xdjek
         fXcl7SFP1tGKmY/rY+chDuzLtIhC7d/SQhyAtanhqh6ayDnGa5hIB54Pe8dtAglkzjxe
         1xJ6j9CVduHp9t1lbbcYgdbkIDUvJXc5LOpsXRfGGEb2qxCAGz9lDCwEbKHmGwyNQWH9
         evyu7Zl4NbBFDPJxZ6ZGjUf2lPuw8qFYF2QjRoOlqa1isZDhS7MIQsk5Z9V7ZhV2jwXX
         z8ksGOwYs6i28L5+HsGhQ61RIJsdVvlHAoKNWMB1ngD8nGvEgVqd48LrwewMFqfJTy0u
         4Exg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=WfdklIuXpIl5bc94kLJIZqO8ks0ayWcE+hCgNHHs00Q=;
        b=t0rbztybxwQbREMVnMvcTUrXQ5irxkyuD+LT2YGXBk1WfVxy+x7StMDE9VLriMIrBL
         811Cyw0mzF6vj8sbO0ri+TS72kbu6mDy6Xyfi4KMtx9ocMfxuTIJ2OUrtL2HOgqBvtJ5
         /1gevU/FsE1e1ZgAM3e8mYz5SVZdbNs+ZGxmiZ/ZIwfAJN1N0F3Lyh0SpAc3Z/edvkpj
         4CDOBJ9jpeT7jfqjs59mXGPvJDwjWMT4bAc27MdykeZVmsoKfNIIAlF3CXXYB0Q32Moa
         BEqRxl73Z1uT2vCvtQw51gbPCPSlpUiwOzejDVV1zfIfZMaSiywjYqdzKLy9bvQw3OPx
         +O3g==
X-Gm-Message-State: AKS2vOwt05FinV65tE2B7P575JQyQimo9tnKkJVaCD2glc048eqxrJj+
        crBux/ictsp6fw==
X-Received: by 10.84.198.129 with SMTP id p1mr26185115pld.120.1498852219598;
        Fri, 30 Jun 2017 12:50:19 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:54f:b41d:dd9d:3de0])
        by smtp.gmail.com with ESMTPSA id x85sm19897020pff.92.2017.06.30.12.50.18
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 30 Jun 2017 12:50:18 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@jeffhostetler.com, git@vger.kernel.org, jrnieder@gmail.com
Subject: Re: [PATCHv3 2/3] patch-ids.c: use hashmap correctly
References: <20170629235336.28460-1-sbeller@google.com>
        <20170630191407.5381-1-sbeller@google.com>
        <20170630191407.5381-3-sbeller@google.com>
Date:   Fri, 30 Jun 2017 12:50:17 -0700
In-Reply-To: <20170630191407.5381-3-sbeller@google.com> (Stefan Beller's
        message of "Fri, 30 Jun 2017 12:14:06 -0700")
Message-ID: <xmqqefu1qmpy.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> As eluded to in the previous patch, the code in patch-ids.c is using
> the hashmaps API wrong.
>
> Luckily we do not have a bug, as all hashmap functionality that we use
> here (hashmap_get) passes through the keydata.  If hashmap_get_next were
> to be used, a bug would occur as that passes NULL for the key_data.
>
> So instead use the hashmap API correctly and provide the caller required
> data in the compare function via the first argument that always gets
> passed and was setup via the hashmap_init function.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  patch-ids.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Nicely explained.  Thanks for polishing the series.

>
> diff --git a/patch-ids.c b/patch-ids.c
> index 815c115811..b4166b0f38 100644
> --- a/patch-ids.c
> +++ b/patch-ids.c
> @@ -35,10 +35,10 @@ int commit_patch_id(struct commit *commit, struct diff_options *options,
>   * the side of safety.  The actual value being negative does not have
>   * any significance; only that it is non-zero matters.
>   */
> -static int patch_id_cmp(const void *unused_cmp_data,
> +static int patch_id_cmp(struct diff_options *opt,
>  			struct patch_id *a,
>  			struct patch_id *b,
> -			struct diff_options *opt)
> +			const void *unused_keydata)
>  {
>  	if (is_null_oid(&a->patch_id) &&
>  	    commit_patch_id(a->commit, opt, &a->patch_id, 0))
> @@ -59,7 +59,7 @@ int init_patch_ids(struct patch_ids *ids)
>  	DIFF_OPT_SET(&ids->diffopts, RECURSIVE);
>  	diff_setup_done(&ids->diffopts);
>  	hashmap_init(&ids->patches, (hashmap_cmp_fn)patch_id_cmp,
> -		     NULL, 256);
> +		     &ids->diffopts, 256);
>  	return 0;
>  }
>  
> @@ -95,7 +95,7 @@ struct patch_id *has_commit_patch_id(struct commit *commit,
>  	if (init_patch_id_entry(&patch, commit, ids))
>  		return NULL;
>  
> -	return hashmap_get(&ids->patches, &patch, &ids->diffopts);
> +	return hashmap_get(&ids->patches, &patch, NULL);
>  }
>  
>  struct patch_id *add_commit_patch_id(struct commit *commit,
