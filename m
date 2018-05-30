Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C5AF1F42D
	for <e@80x24.org>; Wed, 30 May 2018 19:00:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753641AbeE3TAf (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 May 2018 15:00:35 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:46937 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753442AbeE3TAe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 May 2018 15:00:34 -0400
Received: by mail-qt0-f194.google.com with SMTP id h5-v6so16641502qtm.13
        for <git@vger.kernel.org>; Wed, 30 May 2018 12:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=OfBeqb/Sm6aa2m98CMjuFLAyp2eKWOZkjhv3aueigT8=;
        b=tMDYVz+VNInRS3+Ggb/rtM2pKrnkYo8ec8Lu6p+bemmRYX1orwiaNdInsEsiVEPvrB
         8Dv8JkseqIbfrzZOysCHHP0HQ1n9guOUBu4W4/0yXTCrOpmH5Sz+VuIlWJeqOfmvHYWt
         zHspQlcwn0Ra96iJMzMISCm0q8sZmsIYTM6AEydOe85Plc0j0AEpX2PvIuFmcvYRInJe
         yv0TO375x77tE/XfuN2Sr3xnHlbE/ByUW38sOZ4TsO3YmCX3V+FnQ33IwE/xjNWmzxPq
         u2JQ6k8bATKgMgx0rDKSoEUVLlvJk3mPVEeK4fbsqsyrxZYo6XrmSbAOtCvoddy2rYIE
         UdtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=OfBeqb/Sm6aa2m98CMjuFLAyp2eKWOZkjhv3aueigT8=;
        b=Q2df+5lWclGnNeHvNotntuQHNb8acSVvbklvlTPA0gsJ0LaGXdbWumAkZEpC7NGbGc
         kueSskNRCjKdMlqsLTceGQVTGDMRnflYNYXYLBNCMePuBiVCEudIoO9aicURx6jWnba3
         P7TqUisjPEGYaIyI4bTTK0vpKCpkyNxsX8FsOMW9Dgto8r5Y7Xldf3cjp2xM+uQJMCCV
         9H1Acn15CxgjeTCCRim//owu9eGtX8X3lVLK91tHCJVEw/aIvlApkAXlESelZB2iggxD
         E6fDRzBC37P8FbkTrKDcyx2A8ZRpA1vWfVXGuIACy/Tv1Is8T2jvByz6giwrU4TxulLh
         WXUA==
X-Gm-Message-State: APt69E3K+3LJNVY97ZoCPWcbHwxJx3N/rdGQkxPsriWfP++Hv/UcSEEf
        GRkEev4R+zIEG27K6ytA0pLoAOYtJCo=
X-Google-Smtp-Source: ADUXVKLPMY3SiULjuFfthB3rj2/NoNDxUPhDyEVizXGKjHPAuK5/knAA1wZM9Spkk5ATJXkPP9W1Aw==
X-Received: by 2002:a0c:9781:: with SMTP id l1-v6mr3713501qvd.64.1527706833974;
        Wed, 30 May 2018 12:00:33 -0700 (PDT)
Received: from [10.0.1.20] ([98.122.163.216])
        by smtp.gmail.com with ESMTPSA id t15-v6sm5150359qtc.66.2018.05.30.12.00.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 May 2018 12:00:33 -0700 (PDT)
Subject: Re: [PATCH 27/35] commit-slabs: remove realloc counter outside of
 slab struct
To:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
References: <20180530004810.30076-1-sbeller@google.com>
 <20180530004810.30076-28-sbeller@google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <45386849-9a42-a639-06de-78d7e127407b@gmail.com>
Date:   Wed, 30 May 2018 15:00:32 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180530004810.30076-28-sbeller@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/29/2018 8:48 PM, Stefan Beller wrote:
> The realloc counter is declared outside the struct for the given slabname,
> which makes it harder for a follow up patch to move the declaration of the
> struct around as then the counter variable would need special treatment.
>
> As the reallocation counter is currently unused we can just remove it.
> If we ever need to count the reallocations again, we can reintroduce
> the counter as part of 'struct slabname' in commit-slab-decl.h.

It's worth noting that this patch is different from the other mechanical 
patches. I do agree that we should remove this unused portion of the 
slab API. Likely this was built for testing purposes.

CC'ing Junio, who I found introduced this in a84b794ad "commit-slab: 
introduce a macro to define a slab for new type". Looking at that diff, 
the realloc portion did not appear to exist in the previous 
in-degree-specific version of slabs.

>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>   commit-slab-impl.h | 3 ---
>   1 file changed, 3 deletions(-)
>
> diff --git a/commit-slab-impl.h b/commit-slab-impl.h
> index 87a9cadfcca..ac1e6d409ad 100644
> --- a/commit-slab-impl.h
> +++ b/commit-slab-impl.h
> @@ -11,8 +11,6 @@
>   
>   #define implement_commit_slab(slabname, elemtype, scope)		\
>   									\
> -static int stat_ ##slabname## realloc;					\
> -									\
>   scope void init_ ##slabname## _with_stride(struct slabname *s,		\
>   						   unsigned stride)	\
>   {									\
> @@ -54,7 +52,6 @@ scope elemtype *slabname## _at_peek(struct slabname *s,			\
>   		if (!add_if_missing)					\
>   			return NULL;					\
>   		REALLOC_ARRAY(s->slab, nth_slab + 1);			\
> -		stat_ ##slabname## realloc++;				\
>   		for (i = s->slab_count; i <= nth_slab; i++)		\
>   			s->slab[i] = NULL;				\
>   		s->slab_count = nth_slab + 1;				\
