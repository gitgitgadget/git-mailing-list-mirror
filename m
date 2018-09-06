Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B401F1F404
	for <e@80x24.org>; Thu,  6 Sep 2018 17:31:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728232AbeIFWH4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Sep 2018 18:07:56 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36534 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728018AbeIFWHz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Sep 2018 18:07:55 -0400
Received: by mail-wm0-f66.google.com with SMTP id j192-v6so12162221wmj.1
        for <git@vger.kernel.org>; Thu, 06 Sep 2018 10:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=DnbAQpTkFxrzH5dmX5sk9QOc1VS8QVtrHHfHlkJji6M=;
        b=KUzdxTEiHnYS5ztDRGowc+4BuYuV8kz6rGnLE/7YfRcHz882QBjADQ3OW3Db019OQ1
         zpkZ0JHlTVUmtih4Ays1spgEhKh13uovEZdX5h9zKzmu9RDEW3NJmD6t3hC7rFzIxmfh
         FHVsZEWyRSNQhwRV/g8ue1Zi7gHFVepzDSBrSbC7L5vOtgwhQJC4gNIH2P3jCzW5x7Ch
         eEXMQxu/H2bGHl8pksKTwcsNM5d5aKjGki3z98x0tnNdWQyREWeKlVH58DF4b38uTt1c
         4crgKYG1F0EwCf57miTar6CqlxcvC3gvduRfFf9BoCK+KHmXqRFAOglxMJf2CXmynEx0
         U3dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=DnbAQpTkFxrzH5dmX5sk9QOc1VS8QVtrHHfHlkJji6M=;
        b=eZ7OU9s2toYXIdBvXHttN001qXoa/zEsEvweyGh7WPwgpSqEt0WYx+OMDoWjZ0rgYM
         L/r0KTRSRG2qcidDkCuvJ9At8GzuTk1RL3ldxI60cUYid4sKFBbVo/vLn7vZ2KYgrOSy
         31wXeiunhwY7ctrEBUALNmWdL4R5TqajtGUX2PnEvASynm1+/Mr0YjtkDN//v5AKkx3C
         jiMhxTlI/lQ7n7+CpXXOJdcRj0z4G5eqlj3eua8/zOtsg7Mst8M/gzPFRfdW7A6NJNg5
         s2aUYvwZxtXAumIRSnA/VaSWpG4k88xVskrGX2rvQ+ioM9YKNhopZ7wmX5g0vKxmLrvi
         5AzA==
X-Gm-Message-State: APzg51DiPFtt2C1ZX/SB0STXzHvxacq6uvwP4o6Rpn4ajR7HkF9hi1uL
        jnb/bwtMXTULMYILNWljQmk=
X-Google-Smtp-Source: ANB0VdZ6IMljMBb1ZxP5EMPTTsWPMDetFRSaRKca1AUq/oOvaPPUyBjbA5HeL9091NxWIPJJQ6F5Bg==
X-Received: by 2002:a1c:bc86:: with SMTP id m128-v6mr2659162wmf.147.1536255083553;
        Thu, 06 Sep 2018 10:31:23 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id c10-v6sm11577855wrb.17.2018.09.06.10.31.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Sep 2018 10:31:22 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 04/11] submodule.c: convert submodule_move_head new argument to object id
References: <20180904230149.180332-1-sbeller@google.com>
        <20180904230149.180332-5-sbeller@google.com>
Date:   Thu, 06 Sep 2018 10:31:22 -0700
In-Reply-To: <20180904230149.180332-5-sbeller@google.com> (Stefan Beller's
        message of "Tue, 4 Sep 2018 16:01:42 -0700")
Message-ID: <xmqqmusu1qj9.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> All callers use oid_to_hex to convert the desired oid to a string before
> calling submodule_move_head. Defer the conversion to the
> submodule_move_head as it will turn out to be useful in a bit.

I would think this is a good change even without "as it will turn
out..." which readers do not have enough information to judge for
themselves at this point.

> diff --git a/submodule.c b/submodule.c
> index 50cbf5f13ed..da2ed8696f5 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -1597,9 +1597,9 @@ static void submodule_reset_index(const char *path)
>   * pass NULL for old or new respectively.
>   */
>  int submodule_move_head(const char *path,
> -			 const char *old_head,
> -			 const char *new_head,
> -			 unsigned flags)
> +			const char *old_head,
> +			const struct object_id *new_oid,
> +			unsigned flags)

The new calling convention feels somewhat uneven, though, that "new"
(does it mean "switching to this commit object"?) takes an object
id, but "old" ("switching from this commit object"?) still wants a
textual representation.

So, I no longer am sure that this is a good change by itself.  It
would be a good change by itself if we deferred _both_ to keep them
in sync (otherwise those who write (or read) callers will be forced
to wonder which one takes the object id and which one takes the
textual representation and why they need to remember the
difference).

Perhaps not all callers use oid_to_hex() to come up with old_head,
and some may even use branch names, etc., which is passed through
from this function to its callee, to convey more information than
mere object names?  If that is the case, then converting old_head to
old_oid would be a bad move as it can lose information and we'd need
to reconsider the strategy used here (e.g. perhaps we may be better
off sending both textual name and object id down the callchain, and
a caller without a meaningful textual name may indicate that by
passing NULL, or something like that).

> @@ -1865,8 +1863,7 @@ static int merged_entry(const struct cache_entry *ce,
>  
>  		if (submodule_from_ce(ce)) {
>  			int ret = check_submodule_move_head(ce, oid_to_hex(&old->oid),
> -							    oid_to_hex(&ce->oid),
> -							    o);
> +							    &ce->oid, o);
>  			if (ret)
>  				return ret;
>  		}
