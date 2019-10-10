Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 300B61F4C0
	for <e@80x24.org>; Thu, 10 Oct 2019 23:44:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbfJJXoO (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Oct 2019 19:44:14 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:34876 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbfJJXoO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Oct 2019 19:44:14 -0400
Received: by mail-qt1-f201.google.com with SMTP id d6so7532675qtn.2
        for <git@vger.kernel.org>; Thu, 10 Oct 2019 16:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=KNUZhfbNQDFpOOxx1Wr5Cmgp0kRCOe8tRc2iReM0ik4=;
        b=qfEDVmvKG8HLobwBUZk4W5argZgzSzxdcrmD0WJCTo2o7DDODOXmwT3lXI0UJqBY3/
         Rw4rtPOfT423gLoxGKvnAA/OuRZuqQCMS/oMzdJkn5iECvfBdqdJ6kId454VOBeYxhQx
         TxUitLnhnDYiDHvjinUbVPR1hru/lxXWGOP7PtEh6cZLGXPlE3qP1XIO8fboWCBVvEwB
         JaV16kbNjwfA5PiDn/1cmMB45EEkv+pfiydE3Hv8xpOxFruEdprUoRDT0fREY+5IuMq0
         h6ILsfEJMoLiUBOWJ3TGGOj+yIINEMG9rx7Ah29PPd2IVA2wqvcbW+RHVtprzR59A9zm
         YxqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=KNUZhfbNQDFpOOxx1Wr5Cmgp0kRCOe8tRc2iReM0ik4=;
        b=Kprh5Wkr59GRNPQzGaO0r6gI3F12RIHNRXE3irpe+RjlBV1PecvlE8nEr2CijdBvR3
         csNWrFkETknmm236GLzLwv4LUDHHBHPCRVa5J97BTlBD7HIeA0oNqY9RXBQCncRujXaS
         gvmvVtOmnB/NHrBgMWtxJM2UaNu1lbsk5ONk4f7ClC7qoccXZhhh1u2iG+ycjm352eS0
         Az2MXWkHuXZrcX8Kq4BD3eC0rTjhyndMNW3Q/VyEmpGCJ5kIe8XBeumaOtM3Q9QxIjgr
         5lv3j19k4E6lGanUFW+yeLI07YkzIyrgW3CB+RhQ4cXcGr4IEL1GrlPvvrLNRUecQAOP
         ghBQ==
X-Gm-Message-State: APjAAAV1yF44K7R/NJ+oOZ9leCpPWIw+8EEO4vxUdCtRzfPEuYtVv+xG
        bF2OG58PUi9Ox7P1ZGb9vguiVR6sckdDU6IccO83
X-Google-Smtp-Source: APXvYqzd6lNEc9eLtmD6W9V2oEFm8UT5kT7fPJbsAGnaiCTpOL5qX9dkHabduAZ+mjz1IrpCc08YbB2aqXxAFmIiC0fE
X-Received: by 2002:a05:6214:851:: with SMTP id dg17mr7124987qvb.249.1570751051583;
 Thu, 10 Oct 2019 16:44:11 -0700 (PDT)
Date:   Thu, 10 Oct 2019 16:44:08 -0700
In-Reply-To: <20190913130226.7449-6-chriscool@tuxfamily.org>
Message-Id: <20191010234408.170356-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20190913130226.7449-6-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.23.0.581.g78d2f28ef7-goog
Subject: Re: [RFC PATCH 05/10] pack-bitmap: don't rely on bitmap_git->reuse_objects
From:   Jonathan Tan <jonathantanmy@google.com>
To:     christian.couder@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        chriscool@tuxfamily.org, ramsay@ramsayjones.plus.com,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> As we now allocate 2 more words than necessary for each
> bitmap to serve as marks telling us that we can stop
> iterating over the words, we don't need to rely on
> bitmap_git->reuse_objects to stop iterating over the words.

As Peff states [1], this justification is probably incorrect as well.
The actual justification seems to be that we will no longer compute
reuse_objects (in a future patch), so we cannot rely on it anymore to
terminate the loop early; we have to iterate to the end.

[1] https://public-inbox.org/git/20191002155721.GD6116@sigill.intra.peff.net/

> @@ -622,7 +622,7 @@ static void show_objects_for_type(
>  	enum object_type object_type,
>  	show_reachable_fn show_reach)
>  {
> -	size_t pos = 0, i = 0;
> +	size_t i = 0;
>  	uint32_t offset;
>  
>  	struct ewah_iterator it;
> @@ -630,13 +630,15 @@ static void show_objects_for_type(
>  
>  	struct bitmap *objects = bitmap_git->result;
>  
> -	if (bitmap_git->reuse_objects == bitmap_git->pack->num_objects)
> -		return;
> -
>  	ewah_iterator_init(&it, type_filter);
>  
> -	while (i < objects->word_alloc && ewah_iterator_next(&filter, &it)) {
> +	for (i = 0; i < objects->word_alloc &&
> +			ewah_iterator_next(&filter, &it); i++) {
>  		eword_t word = objects->words[i] & filter;
> +		size_t pos = (i * BITS_IN_EWORD);
> +
> +		if (!word)
> +			continue;

Here, iteration is not terminated when we see a 0. We just proceed to
the next one.
