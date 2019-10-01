Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4AE731F4BD
	for <e@80x24.org>; Tue,  1 Oct 2019 19:35:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbfJATfP (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Oct 2019 15:35:15 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33422 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbfJATfP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Oct 2019 15:35:15 -0400
Received: by mail-pl1-f195.google.com with SMTP id d22so6025475pls.0
        for <git@vger.kernel.org>; Tue, 01 Oct 2019 12:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LDqeyJ8TxUMWGOKJXhQdxUiiPBIYg31FJQgOdIA69z4=;
        b=rq43xAqZDIVdIhzGD+9k14X5pTTuD0zoyVIzTScY8NowlM6J9BvU+b/dtUknXLFySl
         tKm8qA2J9OyIzBV+Pvbqdr/UdcWLB8kuFSanNVa6EHodH5jS40xAIQO9zwN/jiSONGJQ
         ibzWhob7swZy+ZN48Aow8iO44VWPFFYJPTls9sO4g10jssqcVnahavUUGf42cP9UEQTt
         CFOySqY++Gv+Hgd4sH7bhq6qLtOe2kvVN3gINzWQoi0bZmr7B34sUt7eRFSD8eUEo/sy
         qcaQJmlvp3/v2Wm48YTeNJMjwG/FHXihdrQQm0AgHrByzAHkqKKzpNAV/FShIUTJHc8y
         EFoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LDqeyJ8TxUMWGOKJXhQdxUiiPBIYg31FJQgOdIA69z4=;
        b=n+fc2XSbbnoOxPHepgm4NbTXAhvHVHgYguRZ80dHyaXbWFDeAJsZ+McziFW3+I0XnM
         jDMuo7PZCj83D4PHFpDUJk/s8z8F1Wh4SifVjknRFnnfau1Y3Okdz4mAB037dExGbelQ
         d/ZArasVThysKJdb4B9sXOqfYOjqU1NR59Cp9KbHPSe6Cz2XRwodYQ9MnowxGc3W4vBu
         EcPzTfXNg/IHY12RFT4buquGFKaIK4a0Q/p9RmFv4DEGETJewXmwndqyW4lYonEvecyP
         PWhTNnIKszc84rQapoxkLOBgcKNhsVMzcr5g7cZAM2I73GLciHaslBMUFhIDbkl5xVkN
         bViQ==
X-Gm-Message-State: APjAAAVJr2Q9uLVG9+C7fbxcV60sBU0ZJR1JN8jtYqy6TE9XxQoLF1PU
        H85MjZPBc/zZjSbkmfUFi9Vh+/F1
X-Google-Smtp-Source: APXvYqwl0/dp2hB3TjEzx7kxkyMg19Jzg5qYC3RjdHM4NIe7a3yZwOkny1jfuzPEOThy+Q+aNOh+mg==
X-Received: by 2002:a17:902:b613:: with SMTP id b19mr27221397pls.225.1569958514270;
        Tue, 01 Oct 2019 12:35:14 -0700 (PDT)
Received: from generichostname ([204.14.239.53])
        by smtp.gmail.com with ESMTPSA id e21sm2587636pgk.57.2019.10.01.12.35.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 12:35:12 -0700 (PDT)
Date:   Tue, 1 Oct 2019 12:35:10 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v3] dir: special case check for the possibility that
 pathspec is NULL
Message-ID: <20191001193510.GA43899@generichostname>
References: <20191001184049.GA30113@generichostname>
 <20191001185524.18772-1-newren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191001185524.18772-1-newren@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

Sorry for dragging out this thread for so long...

On Tue, Oct 01, 2019 at 11:55:24AM -0700, Elijah Newren wrote:

[...]

> diff --git a/t/t0050-filesystem.sh b/t/t0050-filesystem.sh
> index 192c94eccd..a840919967 100755
> --- a/t/t0050-filesystem.sh
> +++ b/t/t0050-filesystem.sh
> @@ -131,4 +131,25 @@ $test_unicode 'merge (silent unicode normalization)' '

I had to change the 25 to a 24 for this to apply cleanly.

>  	git merge topic
>  '
>  
> +test_expect_success CASE_INSENSITIVE_FS 'checkout with no pathspec and a case insensitive fs' '
> +	git init repo &&
> +	(
> +		cd repo &&
> +
> +		>Gitweb &&
> +		git add Gitweb &&
> +		git commit -m "add Gitweb" &&
> +
> +		git checkout --orphan todo &&
> +		git reset --hard &&
> +		mkdir -p gitweb/subdir &&
> +		>gitweb/subdir/file &&
> +		git add gitweb &&
> +		git commit -m "add gitweb/subdir/file" &&
> +
> +		git checkout master
> +	)
> +'
> +
>  test_done

Just wondering, how did you generate this patch? Did you manually edit
the last patch and resend it or is this a bug in our diff machinery?

(Side note, I _hate_ how bad the feedback for git apply/am is. We should
probably give more information than "error: corrupt patch at line 62"
such as why patches are corrupt (unexpected characters, too many/few
lines, something else?).)

> -- 
> 2.23.0.25.g3f4444bfd7.dirty
> 
