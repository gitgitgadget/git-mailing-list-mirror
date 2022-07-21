Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF65DC43334
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 14:04:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbiGUOED (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 10:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbiGUOEB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 10:04:01 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C3C53FA05
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 07:04:00 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id m17so2138941wrw.7
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 07:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=bftgLOlaFn54ODgUSlDFzjL04rVY3cvk+aze2G1MG0E=;
        b=ZV+G8QtuGbmdhkVIG469s2T78SWd8wCaSHKUpBI0yI4Gq4nURYQvNUEn4uZtO1VQxp
         IiTTK+z7UBbPQ85oQanNTrH03i5By23aWVgkl1tukdZiJi8UwuZz8UGK9CQOOYh0muyF
         vVteeb1x7/YycUMV2RUOz3GIGdwG8XvanOvpsu10w7H+wbvKIKS16wzMGZaGOaR6mZBh
         PJdLsBNBm+JP+S6Eg36lpMYO6hNOYW+sxfhw5XOKXOXoyKzXgBrSc6lOR1i0KYf1C7yt
         NujddGSaA/UWpcLAfOoDbeLh5ocYjG9knJ9zxq9DpDsz6ZyBJ+vWbZc+dGfa7SVgrM0E
         4WMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=bftgLOlaFn54ODgUSlDFzjL04rVY3cvk+aze2G1MG0E=;
        b=liGZJoWsXuoykhZQVaSRjAMZkjOPVfFclSWD8rxNmSMUMCydRp8yeK+lGemVSh98vk
         HMTO+Flo+BMzYsYY4gdYA25kke5hn00S49AEGDK6eHNPhX0Kpb0k0opGR0JMQp0KyAHD
         rQKGaiojiO8WCWhQfDBdnnutIW5qC9pPdD3vm0T2V8qNhUUJzErRyhBGJ+tZ8cQTEd5g
         9Eh7l8aA7rwtmCmyCnQDkpYyAN3pyEwT13SprsdF5jA+9iSXpigW40a5K5EaNaN58rSd
         ma//4M/1uqFMEknDpyEzKtUPXnOB3qo4NDjM/nBSuChKd4dmdXazy1mHdpw6Zprjvuwp
         LetQ==
X-Gm-Message-State: AJIora+x+MUd3frZm6ehLGNMw/n8TMC5kiDb6iraeJv7E23rwRcp8hAf
        eMXiO8hCpC1i/jCcpTy//zI=
X-Google-Smtp-Source: AGRyM1u9KoXs/xNpWxxS+SHssVZY++a5iJvrHqnxhGa/p7yOWogphb6SoT4zMVAwly9JnQnyzZSSIw==
X-Received: by 2002:a5d:6906:0:b0:21e:4da4:1516 with SMTP id t6-20020a5d6906000000b0021e4da41516mr5543184wru.470.1658412238826;
        Thu, 21 Jul 2022 07:03:58 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.192])
        by smtp.gmail.com with ESMTPSA id l35-20020a05600c1d2300b003a2fc754313sm2057997wms.10.2022.07.21.07.03.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jul 2022 07:03:58 -0700 (PDT)
Message-ID: <3ae0c41e-2d18-d496-9b99-a672bf274faa@gmail.com>
Date:   Thu, 21 Jul 2022 15:03:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v5 08/12] rebase: update refs from 'update-ref' commands
Content-Language: en-GB-large
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, johannes.schindelin@gmx.de, me@ttaylorr.com,
        Jeff Hostetler <git@jeffhostetler.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
References: <pull.1247.v4.git.1657631225.gitgitgadget@gmail.com>
 <pull.1247.v5.git.1658255624.gitgitgadget@gmail.com>
 <e7a91bdffbd9a1fe0eda9a5a264f7734aadbf688.1658255624.git.gitgitgadget@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <e7a91bdffbd9a1fe0eda9a5a264f7734aadbf688.1658255624.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stolee

On 19/07/2022 19:33, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <derrickstolee@github.com>
> 
> +static int do_update_ref(struct repository *r, const char *refname)
>   {
> +	struct string_list_item *item;
> +	struct string_list list = STRING_LIST_INIT_DUP;
> +
> +	if (sequencer_get_update_refs_state(r->gitdir, &list))
> +		return -1;

This is good, we now return an error if we cannot read the update-refs file.

> +	for_each_string_list_item(item, &list) {
> +		if (!strcmp(item->string, refname)) {
> +			struct update_ref_record *rec = item->util;
> +			if (read_ref("HEAD", &rec->after))
> +				return -1;
> +			break;
> +		}
> +	}
> +
> +	write_update_refs_state(&list);

The return value of write_update_refs_state() should be propagated to 
the caller.

> +	string_list_clear(&list, 1);
>   	return 0;
>   }

Best Wishes

Phillip
