Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 930101F404
	for <e@80x24.org>; Tue,  4 Sep 2018 20:32:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbeIEA6y (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Sep 2018 20:58:54 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:51979 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbeIEA6y (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Sep 2018 20:58:54 -0400
Received: by mail-wm0-f65.google.com with SMTP id y2-v6so5763889wma.1
        for <git@vger.kernel.org>; Tue, 04 Sep 2018 13:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=6fOo3iIB4olsCVBvUGmLx4xG7AfJx3xm5JB0PXi2+xo=;
        b=ZN3kPkC6DXwWuvUyS8DQoX72Q4s3Kq/s9aOmF7G1jkFwNFuh+gVcC735PCOQTgvidh
         ZyAwCDOf5oq80OXX6qid2qDSCR7YoRCjJ6iNj7YqLjAf8F4fJMkRGdcFKiF7N6PVLd/z
         UdXld3GPP3XwrIkQefCOwgzp0X8Ubq2P0ENUJ3Z8XJ4eR0ST2ci2oGtKPTwwFDjHv0h5
         LNLuGpNdWMFWzCEy7xKF3wb/y5FUNhk5BSfnHBozviI0cEJ+e8r9z5COzA1PFtfUtQSI
         Xc4oFgxR1dWMmDZUIgAId+uxVgEA9YhEJhn8KqODMcQe4HSiy1cWS/WUputNlWLmMwpN
         KGUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=6fOo3iIB4olsCVBvUGmLx4xG7AfJx3xm5JB0PXi2+xo=;
        b=kaJICAu+QCi55md4JHWLCXf2lQnWXRPMfVMc1UUUa9weMaB689xWj+vE5mQre2c6lV
         jnGg0g3TeRYRQV/9A8jaPcJ7ai3oIgPHie42nEV2lSNaH7eWXeUpLNRqWaHpGsYQ/R1L
         /1DRg3nbBJunw9jUMrv9+OUXXWA1ChsetARbKQQZPe3Il71xkVFdNrlKUDORpZ0gNx72
         JBg/RSyfR1l8i0w8rDlJdcz1b++RJyuKqIE7V+Hq5GEhh2T8aMoem04VZrU8/pgSbQiP
         Umd4tlqdjiPMbPqAZshnK/awOZ59TmBSYSGCJQlhtx8bxND1xcelYbtggm5GEUstysLV
         dGjA==
X-Gm-Message-State: APzg51DD95xYSwyWs2Kh1ApedBWl+npACfl+l0w8z/NqQF6QX3m+k0l9
        phGec4V2xv97Y5Jks9I5rHc=
X-Google-Smtp-Source: ANB0VdbUEcu0onXA8n3MIMRU5toY/Npootu6FH3BDFBPJJF4ENmYvvXIhFXiJKhDaTEiDd8M9jYdkw==
X-Received: by 2002:a1c:578a:: with SMTP id l132-v6mr3772238wmb.16.1536093127742;
        Tue, 04 Sep 2018 13:32:07 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 200-v6sm309922wmv.6.2018.09.04.13.32.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Sep 2018 13:32:07 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matthew DeVore <matvore@google.com>
Cc:     sbeller@google.com, git@vger.kernel.org, git@jeffhostetler.com,
        jeffhost@microsoft.com, peff@peff.net, stefanbeller@gmail.com,
        jonathantanmy@google.com, pclouds@gmail.com
Subject: Re: [PATCH v7 6/7] list-objects-filter: use BUG rather than die
References: <cover.1533854545.git.matvore@google.com>
        <cover.1536081438.git.matvore@google.com>
        <602ab6c3fa1e83139bd3131dc7e44c2a7e172d26.1536081438.git.matvore@google.com>
Date:   Tue, 04 Sep 2018 13:32:06 -0700
In-Reply-To: <602ab6c3fa1e83139bd3131dc7e44c2a7e172d26.1536081438.git.matvore@google.com>
        (Matthew DeVore's message of "Tue, 4 Sep 2018 11:05:49 -0700")
Message-ID: <xmqq1sa980mx.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matthew DeVore <matvore@google.com> writes:

> In some cases in this file, BUG makes more sense than die. In such
> cases, a we get there from a coding error rather than a user error.
>
> 'return' has been removed following some instances of BUG since BUG does
> not return.
>
> Signed-off-by: Matthew DeVore <matvore@google.com>
> ---

Makes sense.

>  list-objects-filter.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
>
> diff --git a/list-objects-filter.c b/list-objects-filter.c
> index a0ba78b20..5f8b1a002 100644
> --- a/list-objects-filter.c
> +++ b/list-objects-filter.c
> @@ -44,8 +44,7 @@ static enum list_objects_filter_result filter_blobs_none(
>  
>  	switch (filter_situation) {
>  	default:
> -		die("unknown filter_situation");
> -		return LOFR_ZERO;
> +		BUG("unknown filter_situation: %d", filter_situation);
>  
>  	case LOFS_BEGIN_TREE:
>  		assert(obj->type == OBJ_TREE);
> @@ -102,8 +101,7 @@ static enum list_objects_filter_result filter_blobs_limit(
>  
>  	switch (filter_situation) {
>  	default:
> -		die("unknown filter_situation");
> -		return LOFR_ZERO;
> +		BUG("unknown filter_situation: %d", filter_situation);
>  
>  	case LOFS_BEGIN_TREE:
>  		assert(obj->type == OBJ_TREE);
> @@ -208,8 +206,7 @@ static enum list_objects_filter_result filter_sparse(
>  
>  	switch (filter_situation) {
>  	default:
> -		die("unknown filter_situation");
> -		return LOFR_ZERO;
> +		BUG("unknown filter_situation: %d", filter_situation);
>  
>  	case LOFS_BEGIN_TREE:
>  		assert(obj->type == OBJ_TREE);
> @@ -389,7 +386,7 @@ void *list_objects_filter__init(
>  	assert((sizeof(s_filters) / sizeof(s_filters[0])) == LOFC__COUNT);
>  
>  	if (filter_options->choice >= LOFC__COUNT)
> -		die("invalid list-objects filter choice: %d",
> +		BUG("invalid list-objects filter choice: %d",
>  		    filter_options->choice);
>  
>  	init_fn = s_filters[filter_options->choice];
