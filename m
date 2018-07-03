Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB55C1F6AC
	for <e@80x24.org>; Tue,  3 Jul 2018 18:41:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934464AbeGCSlt (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Jul 2018 14:41:49 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:39282 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934399AbeGCSlo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jul 2018 14:41:44 -0400
Received: by mail-wr0-f195.google.com with SMTP id b8-v6so2952547wro.6
        for <git@vger.kernel.org>; Tue, 03 Jul 2018 11:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=vxt6MIVZf10z5FqtQZQ5ZqwFpmviXddLmSzAEeL/nsY=;
        b=C5N5XLRx6zRPY5eLDRtDe2PkOzGy8P7TzsfGHM25iueQYi5jme0gjdcHKoTUTw3usL
         +Um6D96C4e7z8TXfi38DsnsWkKX0i8zxSr2ipp4oe0/L5JCtnrEBujshEnCDE3YqJO2u
         Zs+Ffu/WNLHS2cPsYwiaOAIhZ/yR7bt/o2myE9OmT/FCcjdoa2jg2M5SGA+oP4YldOto
         LkHdnaEAoQsfmbrBzthzyRYlB4V916y8qtR4tEVfV5ZI4qdLjMwltfLkdJfTq6mndqo9
         +pRo3NlYMPlUy+yBkAoH19re/6FZN0dUqwBAkjzOUWilHEPTyY7qkD2urrY67uGO5u93
         DXVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=vxt6MIVZf10z5FqtQZQ5ZqwFpmviXddLmSzAEeL/nsY=;
        b=R5eOVevHaR0zgUfOoIakOFuAY2blTgCCqibGntVG9oPSnHpk2zUjcsAhs0roHqy90K
         OGT0do3MkmE4AKPQyUn5S5RTv6syGIKY1lm4LX0opRjGgbJDalye+2VU8V65uqY0WH5/
         rek0i11tf7Ol04t4+KWj3Q95HWaPYU6IEj03nDX9ME+y+ks9Po4ptEv7f9NxX6ADA79j
         WfXBZfcET8ROXE1FLCFXjqwu6j+9LKmIx9WkY46gkW7jpiA+BfNpwQUA50bdVWjOT1lj
         OSelNfsRcSUUKP2pG/LBce/4GP3qsm0/hwd81qI6RJwEEJ2QgzdDePu4XYixqDhw4LRu
         KA9g==
X-Gm-Message-State: APt69E3YhPYwEjBRSlN0YpftqaLG+Sj0vDhevwya3pf208VESSbXQ9uC
        QcwefMvR2wTl6gynlyHUVtY=
X-Google-Smtp-Source: AAOMgpf64173gtDiKj213ycj/XRudsok+HhCFkUSdwsqntEifml/BJGVLdNl1sdU0YfVFEzX5L1F5Q==
X-Received: by 2002:adf:8e49:: with SMTP id n67-v6mr22946610wrb.131.1530643303195;
        Tue, 03 Jul 2018 11:41:43 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id i9-v6sm1208973wrs.92.2018.07.03.11.41.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 11:41:42 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Mike Hommey <mh@glandium.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] fast-import: Don't count delta attempts against an empty buffer
References: <20180630214106.19848-1-mh@glandium.org>
Date:   Tue, 03 Jul 2018 11:41:42 -0700
In-Reply-To: <20180630214106.19848-1-mh@glandium.org> (Mike Hommey's message
        of "Sun, 1 Jul 2018 06:41:06 +0900")
Message-ID: <xmqqmuv8qhzt.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mike Hommey <mh@glandium.org> writes:

> When the reference buffer is empty, diff_delta returns NULL without
> really attempting anything, yet fast-import counts that as a delta
> attempt.

But that is an attempt nevertheless, no?  Attempted and failed to
find anything useful, that is.  What problem are you trying to solve
and what issue are you trying to address, exactly?

... goes and reads the patch ...

> Signed-off-by: Mike Hommey <mh@glandium.org>
> ---
>  fast-import.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fast-import.c b/fast-import.c
> index 4d55910ab9..12195d54d7 100644
> --- a/fast-import.c
> +++ b/fast-import.c
> @@ -1076,7 +1076,7 @@ static int store_object(
>  		return 1;
>  	}
>  
> -	if (last && last->data.buf && last->depth < max_depth
> +	if (last && last->data.len && last->data.buf && last->depth < max_depth
>  		&& dat->len > the_hash_algo->rawsz) {
>  
>  		delta_count_attempts_by_type[type]++;

This is a misleading patch as the title and the proposed log message
both talk about "attempts are counted but we didn't actually do
anything", implying that the only problem is that the counter is not
aligned with reality.  The fact that the post-context we see here
only shows the "counting" part does not help us, either.

But the next line in the post-context is actually code that does
something important, which is ...

		delta = diff_delta(last->data.buf, last->data.len,
			dat->buf, dat->len,
			&deltalen, dat->len - the_hash_algo->rawsz);
	} else
		delta = NULL;


... and makes the reader realize that the change itself is much
better than the patch with 3-line context, the title, and the
proposed log message advertises it as ;-)

How about selling it this way instead?

	fast-import: do not call diff_delta() with empty buffer

	We know diff_delta() returns NULL, saying "no good delta
	exists for it", when fed an empty data.  Check the length of
	the data in the caller to avoid such a call.  

	This incidentally reduces the number of attempted deltification
	we see in the final statistics.

or something like that?
