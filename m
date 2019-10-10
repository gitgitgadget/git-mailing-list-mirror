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
	by dcvr.yhbt.net (Postfix) with ESMTP id 95F091F4C0
	for <e@80x24.org>; Thu, 10 Oct 2019 23:40:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727259AbfJJXkp (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Oct 2019 19:40:45 -0400
Received: from mail-yw1-f74.google.com ([209.85.161.74]:47912 "EHLO
        mail-yw1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726458AbfJJXkp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Oct 2019 19:40:45 -0400
Received: by mail-yw1-f74.google.com with SMTP id p205so6032953ywc.14
        for <git@vger.kernel.org>; Thu, 10 Oct 2019 16:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=alJhCfB1xGR8CmzccYGQg9nKORNSvV2OeMzpgrgN4zE=;
        b=KOmphjyjfEnfL0Cg4gLiGfwDrhqWmldIISzsrEtlKUAEQ9N3hk4u7JsAK6LYAs5QOZ
         3TJkkUEn2lJY+bF32cyQuE7riMnggMt4AMnOTzUr7lmY/9/nowHQp+2fKqHHR2kkc1ck
         qGXGA55BV+VLIPB/PnXCebdK3MidhJ/MS3UXw087oLhDkQ49y+MjSJVk8wlcv1F6ibwm
         uagx5UGWqlYlJyT/XpgEaUllV7KGvK08Y9bMMmPYbQ1/Wva76YiZ5CYrjL974tBHCf4C
         au619g+NZU1pWs5FE6kv13AiR7UFfxghyFC28f/WctRFhkkpe9D5zb56x4rxjs6Wsb2S
         AbsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=alJhCfB1xGR8CmzccYGQg9nKORNSvV2OeMzpgrgN4zE=;
        b=grNl0T1rCjnYKiGjk4Ktkk95b0qbtAxsPw9780YMucX1YovPxWGjoUGsG3jX2SO8ue
         aPl8Sho7Jy0SUw1ktMeW2LeQvFgZNGJNKLF/iUZD1XcSInelcyTqNoAZhJteYFRIG1S9
         tbLxlCRKfHWgQdudqvJckTuXgCNbymlsfIAaLdy8cSFNuywsWCRVArZx31U+ssGRyT8v
         tb0CD3ySiG85Vv3Ii5B4oV+XqK1o+IqXg9Y4kZHtgZDaWFfBt5PWeFiXgeLlvJvG8oja
         jDsuzbLhhReHymZprAwfdp2FmBaFORRbs7MG+o+WGIF/3uGj/Sh2Yk7hUn+8tc9xdiVT
         9ppw==
X-Gm-Message-State: APjAAAUh/qhLVZ/HicF+I8b5ls1lxG9HcZXs7GhI0sbxxmER9Qp37sAv
        l/19N+k6t8FrYOymsQ0EP85jgKUj+56QG9mHFFoR
X-Google-Smtp-Source: APXvYqw3Ozn/vAJ9mX05dwpACGG1i5HpaRFEPhXI9ANupFO040iryb23HOYoP22XpA9pkuIJ/ixWcBlRlYUW/XEdfAR2
X-Received: by 2002:a0d:f8c6:: with SMTP id i189mr275456ywf.491.1570750843844;
 Thu, 10 Oct 2019 16:40:43 -0700 (PDT)
Date:   Thu, 10 Oct 2019 16:40:40 -0700
In-Reply-To: <20190913130226.7449-5-chriscool@tuxfamily.org>
Message-Id: <20191010234040.168894-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20190913130226.7449-5-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.23.0.581.g78d2f28ef7-goog
Subject: Re: [RFC PATCH 04/10] ewah/bitmap: always allocate 2 more words
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

> From: Jeff King <peff@peff.net>
> 
> In a following patch we will allocate a variable number
> of words in some bitmaps. When iterating over the words we
> will need a mark to tell us when to stop iterating. Let's
> always allocate 2 more words, that will always contain 0,
> as that mark.

[snip]

>  	if (block >= self->word_alloc) {
>  		size_t old_size = self->word_alloc;
> -		self->word_alloc = block * 2;
> +		self->word_alloc = (block + 1) * 2;
>  		REALLOC_ARRAY(self->words, self->word_alloc);
>  		memset(self->words + old_size, 0x0,
>  			(self->word_alloc - old_size) * sizeof(eword_t));

This patch set was mentioned as needing more thorough review in "What's
Cooking" [1], so I thought I'd give it a try. As Peff said [2], the
justification in the commit message looks incorrect. He suggests that it
is most likely because "block" might be 0 (which is possible because a
previous patch eliminated the minimum of 32), which makes sense to me.

In any case, the next patch does not use 0 as a sentinel mark. Iteration
stops when word_alloc is reached anyway, and since this is a regular
bitmap, 0 is a valid word and cannot be used as a sentinel. (Maybe 0 is
a valid word in a compressed EWAH bitmap too...not sure about that.)

I think this should be squashed with patch 3, adding to that commit
message "since word_alloc might be 0, we need to change the growth
function". (Or just make the minimum word_alloc be 1 or 32 or something
positive, if that's possible.)

[1] https://public-inbox.org/git/xmqq36g5444k.fsf@gitster-ct.c.googlers.com/
[2] https://public-inbox.org/git/20191002155721.GD6116@sigill.intra.peff.net/
