Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A852A1F453
	for <e@80x24.org>; Thu, 18 Oct 2018 05:16:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727396AbeJRNPh (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Oct 2018 09:15:37 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34742 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727331AbeJRNPg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Oct 2018 09:15:36 -0400
Received: by mail-wm1-f65.google.com with SMTP id z25-v6so992911wmf.1
        for <git@vger.kernel.org>; Wed, 17 Oct 2018 22:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=bX8nDbOJFpYwrS0nGXFpwB9IpFs98bN3qcpqNR8zQS4=;
        b=dWBUWFMMJ6x6mfTS6qjOgPEZiUFXbzQY0DO/W/SC6UcRlnABM9ayRt2RkC5apbgi/n
         aQMuKuA1fjO8/f4/jDVZU6ZCJrWyI1ICIYf2D//tjmSjd6nCVyEwusSuf94NAIZuhzOZ
         z7txU0dsax/DBolfYcr9hBLJDkStmp7c+ODGp9pIp8VtnM7zCU6ckJAWhwmd6mcPDjeK
         UU36m8n+Zz3PPeYfSbDUQsO4isxPdtzUZHFagFHQ08bM6O/kmBh2PK7ZMbmZtsdJj+bM
         twwBbrdo8/B5J51kYFp4XFwaJ0TMUvgCDDodYfk9fpAPvC5qb8DWl5wHxDvMrBJd1rTt
         73uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=bX8nDbOJFpYwrS0nGXFpwB9IpFs98bN3qcpqNR8zQS4=;
        b=DpfkQ1ULcJ79rCH5EZtuWSV7HU+pliOWWIbmVapZ8kFvqr2NQiNzpNjEbzf/VhResR
         hVhx1Jpd8KIdW3x7szhRLpWFL5r77jtxbdJWBukC5rMiAxVygMOelaseCteNIiBXxa+B
         k1ABHounSqMe6nSWhxvmrybntpquRgy2X9eo7S7reaXVJqjiISNpw9IZzjuMpD39Cly+
         VQIFtwqYXjfYRk3IpznGqBh5uQuBNd9vtLqEvb8z1Dinj1qmNsvzP+BpcovxU2l+07I7
         ++K8QGOUMWmxBJJ6shsNKmg5O6jT0X1XXm/u8dLAliBlsiGnyPlICiC3nv4b2zs2JZRA
         +x3w==
X-Gm-Message-State: ABuFfogDXrnoF7h3miYHODimuA3vqKRlTGyokfgq47ocFkeDqlUPRNk3
        QH8RvYSnxQyZmBHG6QhJKw0=
X-Google-Smtp-Source: ACcGV62R5mIPQ7auMT3RYC22DP94G7UmI/cqYZahUzB5BnRCZA3caf4EN4/LvM0uggxoGeyPVtKjzQ==
X-Received: by 2002:a1c:6504:: with SMTP id z4-v6mr5467493wmb.130.1539839783879;
        Wed, 17 Oct 2018 22:16:23 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id l38-v6sm16721238wre.38.2018.10.17.22.16.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Oct 2018 22:16:23 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, arturas@uber.com
Subject: Re: [PATCH] upload-pack: clear flags before each v2 request
References: <20181016215850.47821-1-jonathantanmy@google.com>
Date:   Thu, 18 Oct 2018 14:16:22 +0900
In-Reply-To: <20181016215850.47821-1-jonathantanmy@google.com> (Jonathan Tan's
        message of "Tue, 16 Oct 2018 14:58:50 -0700")
Message-ID: <xmqq5zxzvnq1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> Suppose a server has the following commit graph:
>
>  A   B
>   \ /
>    O
>
> We create a client by cloning A from the server with depth 1, and add
> many commits to it (so that future fetches span multiple requests due to
> lengthy negotiation). If it then fetches B using protocol v2, the fetch
> spanning multiple requests, the resulting packfile does not contain O
> even though the client did report that A is shallow.

Hmph, what if commit O had a long history behind it?  

Should fetching of B result in fetching the whole history?  Would we
notice that now all of A's parents are available locally and declare
that the repository is no longer shallow?

I am trying to figure out if "does not contain O when we fetch B,
even though we earlier fetched A shallowly, excluding its parents"
is unconditionally a bad thing.

The change to the code itself sort-of makes sense (I say sort-of
because I didn't carefully look at the callers to see if they mind
getting all these flags cleared, but the ones that are cleared are
the ones that are involved mostly in the negotiation and shold be
OK).

> diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
> index 88a886975d..70b88385ba 100755
> --- a/t/t5702-protocol-v2.sh
> +++ b/t/t5702-protocol-v2.sh
> @@ -429,6 +429,31 @@ test_expect_success 'fetch supports include-tag and tag following' '
>  	git -C client cat-file -e $(git -C client rev-parse annotated_tag)
>  '
>  
> +test_expect_success 'upload-pack respects client shallows' '
> +	rm -rf server client trace &&
> +
> +	git init server &&
> +	test_commit -C server base &&
> +	test_commit -C server client_has &&
> +
> +	git clone --depth=1 "file://$(pwd)/server" client &&
> +
> +	# Add extra commits to the client so that the whole fetch takes more
> +	# than 1 request (due to negotiation)
> +	for i in $(seq 1 32)

Use test_seq instead, or you'll get hit by test-lint?

Applied on 'master' or 'maint', this new test does not pass even
with s/seq/test_&/, so there may be something else wrong with it,
though.
