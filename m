Return-Path: <SRS0=ku3G=DQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFABEC433E7
	for <git@archiver.kernel.org>; Fri,  9 Oct 2020 16:31:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B88432227F
	for <git@archiver.kernel.org>; Fri,  9 Oct 2020 16:31:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I9aihKus"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389694AbgJIQbj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Oct 2020 12:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388719AbgJIQbj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Oct 2020 12:31:39 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EC60C0613D2
        for <git@vger.kernel.org>; Fri,  9 Oct 2020 09:31:39 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id c13so10767305oiy.6
        for <git@vger.kernel.org>; Fri, 09 Oct 2020 09:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xf/tEjeE5gI7F1tzxCiHV1cf5toj5SK3/luNcEeH5gg=;
        b=I9aihKusCTbtxd9y4cpsBZpw7O8Hl8yTe+I7tsPoaFNHooa0qOfOngqF5cYSX2YVjp
         3bFvx6VmqP0M5jdw2KAnGy/OfNtvHzQRkBHoAkiqjBZYSRGUO9rq0mM/PURMDG12Q2Da
         2xENe1aaC5xRo+53fE2s6PdKI4t+mNkTmrxgRvp72BBX87PoozxRDAIl8ir84MWBODZW
         nA1yq+UyPRirrTqd5P0Cm2ZhFMbrU5aEsykY2oaLmLf+xXgMpPN0g8dXQGErO3HnhyNq
         ssDU3L1nuBPzX5fQN7obYsw7u3y7vi77piwnxWGSs9rBXtqk6V2ivfcR+z4QESHQAqUz
         3ZUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xf/tEjeE5gI7F1tzxCiHV1cf5toj5SK3/luNcEeH5gg=;
        b=qESw9CeG6HSyKaxKiMsLKcJFrVB+gRrIJrfE3xnLZIaW0lvqvm7ex8l9Vv5oJjrKbL
         hfnQb5g4Jit493VR52luSdipFdfztvq9wN7xs3i2Eods2SmQRw+4VVa0WQXa+0ZmYHgb
         oEtGUZ7z7VUjMUJ6wHshDe3Yq7iv941/FZ9M1edpBvF8RD8ZU+JzAzrqVFBJqUuPMy9O
         omJpDBwlX0kbAQ5kwKabSQF3kQkySRuKa1bRd9KfzZIRV3/1XqoxDJPaa3InNoiAKkdG
         Q1jGk+iY6sWfHmMNsE/y/3PYuv5HSyq5PJ6mOjImY4dYvQwJXvsU6Q6M0L0uuI8DgTe/
         OG5A==
X-Gm-Message-State: AOAM532FuvIVxaPcTfy0RbYLnr0jBC+m+k6tFsFr/lzkShtIVTeg1CND
        /QqaO8q7pR7lS0ARQXjxSOIANTXwgXNG4g==
X-Google-Smtp-Source: ABdhPJxJ3NnrH29BxKoizqUBggL3WAm4JoLTNoXXJBUCJnioaD4AJN9Mkh5PuiF3mnZv4WJgSEzsnw==
X-Received: by 2002:a54:4e94:: with SMTP id c20mr3013854oiy.17.1602261098501;
        Fri, 09 Oct 2020 09:31:38 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:859b:7143:ba12:a6eb? ([2600:1700:e72:80a0:859b:7143:ba12:a6eb])
        by smtp.gmail.com with UTF8SMTPSA id j21sm6456357otq.18.2020.10.09.09.31.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Oct 2020 09:31:38 -0700 (PDT)
Subject: Re: What's cooking in git.git (Oct 2020, #02; Fri, 9)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <xmqq362nv18o.fsf@gitster.c.googlers.com>
 <512a3dc5-4937-8679-c4c8-5144ac50450b@gmail.com>
 <xmqqpn5rtld1.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <0d8e4419-cf7c-360a-f676-1ded0c99bcf5@gmail.com>
Date:   Fri, 9 Oct 2020 12:31:37 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:82.0) Gecko/20100101
 Thunderbird/82.0
MIME-Version: 1.0
In-Reply-To: <xmqqpn5rtld1.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/9/2020 12:28 PM, Junio C Hamano wrote:
> Derrick Stolee <stolee@gmail.com> writes:
> 
>> As for discarding them all: we would need to add code to "reparse"
>> a commit from the object database. Perhaps that is doable, but we
>> have so far not removed data from a parsed 'struct commit'. This
>> is probably the easiest way forward to guarantee correct data here.
> 
> Oh, no, by "discarding" I just meant to blow away suspect on-disk
> files and recompute them from scratch.  I didn't have anything
> clever like correcting in-core data structure by parsing the commits
> and updating.

Naturally, I'm over-thinking this. Your "throw away the current
stack" idea has merit and I'll take a look at how that could be
accomplished. It certainly would be non-trivial to communicate
at the current layer, but there might be a clever way to do this.

>> Again, let's find a way to test this before committing.
> 
> Yes, that is sensible.  After all this is not a recent regression.

Thanks,
-Stolee

