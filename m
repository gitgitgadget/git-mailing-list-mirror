Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88E70C74A5B
	for <git@archiver.kernel.org>; Thu, 23 Mar 2023 19:46:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbjCWTqt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Mar 2023 15:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjCWTqp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2023 15:46:45 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D614C0D
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 12:46:33 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id u11-20020a05600c19cb00b003edcc414997so1796683wmq.3
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 12:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679600792;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oajf+kR6jEMpzg1ZTu7IWlOQ1kADcN1jle0NB1m8PUg=;
        b=NYsjHTpsWQawnRJoj7apkYOmdu0ICZYqddarPSGeRNi/T5/vXJKnkNwPnFzzn+HU0e
         nO/i/ZNMSB8GXuVkbc2IAzUCUfBfBQRjBHxj6HNy1nk75R43m0vl6PLrfWKODdJUtM7A
         OTzKtPsm2N9lpVACvnhMSzWlwfkamS12yIjEmi7dX4jaKitglXhpHTUr5ZctotE6ZVJW
         ofY7jcMKrNQkEWttruARiSqHINhws3QnSBxHeyYbTjSF47OhX+3qpM6AaPscAwRoJPP7
         FBKocGhmfxEDuFsVXYKR6XduJez13s77QyTBqru+akVtayJuMetPyaSy66fyZ6LwXi3S
         yZEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679600792;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oajf+kR6jEMpzg1ZTu7IWlOQ1kADcN1jle0NB1m8PUg=;
        b=3OmP5jHQWPKNAvwH2uWGNthF0AE4o6jFEhYd9DAeR7/TNEseXNzdFQb00eb9oVSO5+
         RLhasN1ZCu86YTrjKGaNZ+/nLGzL5Afa09P5utR7rZEqsLvDXl62mo0Xm9uu8IJGH/KB
         Q189yArL/11hr9yyQUbG49QDzN/RzP2VdSAkPopG2JYoC9a8U0lRykchUVb6Db5V7VoR
         UgPq4HKw/5Hu0dOXcHoxgKyI3gitAI2PrBuAcEujEklTM0ahz41Qs06gDsLXtqWCILmr
         wtcxafeEashfpHopHv5Wy8YBPSmoMfasA/QIsjsa2dgvifV0m0i1nlJVUU3SdMd/Q+sx
         AEnw==
X-Gm-Message-State: AO0yUKWGv/3d/10I8Fg5ovlEWzm8wtsUN1ssKGHqIOmJuGm8dDQCE9SC
        inIAURewWwkT5GGjQP7Utho=
X-Google-Smtp-Source: AK7set+Zt0qdrhFfscPhWpXSbLSDMAXmqXr4jbAL8cwKUNlFphzovS4n2magnOUqT+z4XxLrftAGIg==
X-Received: by 2002:a1c:7c11:0:b0:3eb:399f:6b70 with SMTP id x17-20020a1c7c11000000b003eb399f6b70mr576362wmc.31.1679600792114;
        Thu, 23 Mar 2023 12:46:32 -0700 (PDT)
Received: from [192.168.1.212] ([90.253.29.198])
        by smtp.gmail.com with ESMTPSA id g19-20020a05600c311300b003eddf30bab6sm2867360wmo.27.2023.03.23.12.46.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Mar 2023 12:46:31 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <d1fb77a0-9ed8-4f3d-5bad-bc443b5522d2@dunelm.org.uk>
Date:   Thu, 23 Mar 2023 19:46:28 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 6/8] sequencer: simplify allocation of result array in
 todo_list_rearrange_squash()
Content-Language: en-US
To:     Oswald Buddenhagen <oswald.buddenhagen@gmx.de>, git@vger.kernel.org
References: <20230323162235.995574-1-oswald.buddenhagen@gmx.de>
 <20230323162235.995574-7-oswald.buddenhagen@gmx.de>
In-Reply-To: <20230323162235.995574-7-oswald.buddenhagen@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Oswald

On 23/03/2023 16:22, Oswald Buddenhagen wrote:
> The operation doesn't change the number of elements in the array, so we do
> not need to allocate the result piecewise.

I think the reasoning behind this patch is sound.

> Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
> ---
>   sequencer.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/sequencer.c b/sequencer.c
> index f8a7f4e721..fb224445fa 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -6225,7 +6225,7 @@ static int skip_fixupish(const char *subject, const char **p) {
>   int todo_list_rearrange_squash(struct todo_list *todo_list)
>   {
>   	struct hashmap subject2item;
> -	int rearranged = 0, *next, *tail, i, nr = 0, alloc = 0;
> +	int rearranged = 0, *next, *tail, i, nr = 0;
>   	char **subjects;
>   	struct commit_todo_item commit_todo;
>   	struct todo_item *items = NULL;
> @@ -6334,6 +6334,8 @@ int todo_list_rearrange_squash(struct todo_list *todo_list)
>   	}
>   
>   	if (rearranged) {
> +		items = ALLOC_ARRAY(items, todo_list->nr);
> +
>   		for (i = 0; i < todo_list->nr; i++) {
>   			enum todo_command command = todo_list->items[i].command;
>   			int cur = i;
> @@ -6346,16 +6348,15 @@ int todo_list_rearrange_squash(struct todo_list *todo_list)
>   				continue;
>   
>   			while (cur >= 0) {
> -				ALLOC_GROW(items, nr + 1, alloc);
>   				items[nr++] = todo_list->items[cur];
>   				cur = next[cur];
>   			}
>   		}
>   
> +		assert(nr == todo_list->nr);

If this assert fails we may have already had some out of bounds memory 
accesses.

> +		todo_list->alloc = nr;
>   		FREE_AND_NULL(todo_list->items);

I think it would be cleaner to keep the original ordering and free the 
old list before assigning todo_list->alloc

>   		todo_list->items = items;
> -		todo_list->nr = nr;
> -		todo_list->alloc = alloc;
>   	}

Best Wishes

Phillip

>   	free(next);
