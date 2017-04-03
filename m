Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D5E41FAFB
	for <e@80x24.org>; Mon,  3 Apr 2017 18:00:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752055AbdDCSAN (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Apr 2017 14:00:13 -0400
Received: from mail-pg0-f54.google.com ([74.125.83.54]:33680 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751838AbdDCSAM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Apr 2017 14:00:12 -0400
Received: by mail-pg0-f54.google.com with SMTP id x125so127475257pgb.0
        for <git@vger.kernel.org>; Mon, 03 Apr 2017 11:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=YryvF8KJhNuwBdc53pxELcKX1iDpakfsYwyi3QKb6xI=;
        b=XGDHg9CBm2NeURj3D40WOryf30L8M/5jYAybKk9OZr6Udr80hrPhoSjHcj7mIw53/Q
         Hk2hsmsz0bJzm0mQvl+Ht4iwSVsfMDpY1+Ja7gFYjJjVEghPV7hmacOp9HTX7h7YVjV7
         FNt32eanXfQfqOI+uony1EqgJnxGEaTYUMAGvmX95mQgtGLXGM8Teq3W6//3LTpwhCjR
         da/577eL64oEBNqmvvMJLrI5vS8kvUwsIpIsBs3XStEt4gOXUbuxDKLxj4mx3q+hHNH6
         QeWtp83hoMKLiFViLHsjAd0k3WRo1Lhq52s5z03+egyIOzHLlC6TmJ/TFPVOoSe8ub8z
         OGKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=YryvF8KJhNuwBdc53pxELcKX1iDpakfsYwyi3QKb6xI=;
        b=hLzGxpSI8KkNj0qlvMTbiNuOlxjr2hTooN1RxVAu6ZCi5REBCldw3geuD6TIU52sT1
         UPjGYutF+3iDrvEfkFi0X79MlYlxdP5gY70SfY++Q46OG4buv9ymnvpEucxF6n4GITK6
         Y6hvHUNJGcgBSZ7KScRKEN8WvOz2XY2tDoayK8U+r3LLxSqDDM2ENfnA35GHgta9P9fQ
         UmfA0GnMbRlKT0BV9gmqSyJcMqLxlTbx5/MuW1vqeDH0pDbS7jDmW6gZPETrpOzRHFKk
         PUHmNm15bNlaYoV1MKg6JNEBUROrDUyN2pPoxthC/ryV1UNKFHfNash6h2AEETNo5ELL
         95ew==
X-Gm-Message-State: AFeK/H0Hv32sLlX3mNW01iQT5VTI167pf/z0GIdGaGULwXQVYefcFSFPFId7QKogEbOsRIuT
X-Received: by 10.84.171.195 with SMTP id l61mr6228749plb.75.1491242411500;
        Mon, 03 Apr 2017 11:00:11 -0700 (PDT)
Received: from twelve2.mtv.corp.google.com ([2620:0:1000:5b10:c0e5:4562:356a:dc16])
        by smtp.gmail.com with ESMTPSA id 129sm27096365pgj.59.2017.04.03.11.00.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Apr 2017 11:00:10 -0700 (PDT)
Subject: Re: [PATCH] Fix 'git am' in-body header continuations
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Junio C Hamano <gitster@pobox.com>
References: <alpine.LFD.2.20.1704021746180.22832@i7.lan>
Cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
From:   Jonathan Tan <jonathantanmy@google.com>
Message-ID: <f5763dab-b829-f216-a377-8a71fc4f0c1e@google.com>
Date:   Mon, 3 Apr 2017 11:00:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.LFD.2.20.1704021746180.22832@i7.lan>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This looks good to me.

On 04/02/2017 05:49 PM, Linus Torvalds wrote:
>
> From: Linus Torvalds <torvalds@linux-foundation.org>
> Date: Sat, 1 Apr 2017 12:14:39 -0700
> Subject: [PATCH] Fix 'git am' in-body header continuations
>
> An empty line should stop any pending in-body headers, and start the
> actual body parsing.
>
> This also modifies the original test for the in-body headers to actually
> have a real commit body that starts with spaces, and changes the test to
> check that the long line matches _exactly_, and doesn't get extra data
> from the body.
>
> Fixes:6b4b013f1884 ("mailinfo: handle in-body header continuations")
> Cc: Jonathan Tan <jonathantanmy@google.com>
> Cc: Jeff King <peff@peff.net>
> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> ---
> diff --git a/t/t4150-am.sh b/t/t4150-am.sh
> index 89a5bacac..44807e218 100755
> --- a/t/t4150-am.sh
> +++ b/t/t4150-am.sh
> @@ -983,7 +983,9 @@ test_expect_success 'am works with multi-line in-body headers' '
>  	rm -fr .git/rebase-apply &&
>  	git checkout -f first &&
>  	echo one >> file &&
> -	git commit -am "$LONG" --author="$LONG <long@example.com>" &&
> +	git commit -am "$LONG
> +
> +    Body test" --author="$LONG <long@example.com>" &&

Instead of "Body test", I would write something more descriptive like 
"Not a continuation line because of blank line above", but I'm fine with 
either.

>  	git format-patch --stdout -1 >patch &&
>  	# bump from, date, and subject down to in-body header
>  	perl -lpe "
> @@ -997,7 +999,7 @@ test_expect_success 'am works with multi-line in-body headers' '
>  	git am msg &&
>  	# Ensure that the author and full message are present
>  	git cat-file commit HEAD | grep "^author.*long@example.com" &&
> -	git cat-file commit HEAD | grep "^$LONG"
> +	git cat-file commit HEAD | grep "^$LONG$"
>  '
>
>  test_done
>
