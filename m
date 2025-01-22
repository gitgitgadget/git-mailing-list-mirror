Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2B91BBBFE
	for <git@vger.kernel.org>; Wed, 22 Jan 2025 22:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737584451; cv=none; b=n9cRfCevi1aNN0/5ed+OZAtyR1H74U81SfG76o/xDc88yUdoDuR6/XoHGHUdbBexfFiRR7ekPDpDwg3k8p4HopJsSLsH1QwLKwovqWlaPXMPc6hB/QEacKGUbLP5Bctxrukvwb5Us/DfHcVLZ0Iy6YuJ+cnvcSUsz/hYz+0mTKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737584451; c=relaxed/simple;
	bh=qTEyx6DNi8WKk97RccaBJOEhoLsZ+sIidjHnXkj9fdc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sCIZFpNEfbMH2yh6zDeuCoKxo+NYuG5D2Yns/tIFGvODd1TtCvcqMylzg17wLCFuSUM7jKOhZ57o8maxZkneKr9i8eULSCn7DmDLC4DUgYmsOgDKhxnbGFLfxZT7Vvz6jaY73SA8U4hKj0xXrRJ8nnPFb0YhjEgZX6RVHPbKzaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=xX3U38Eq; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="xX3U38Eq"
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e5372a2fbddso408009276.3
        for <git@vger.kernel.org>; Wed, 22 Jan 2025 14:20:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1737584449; x=1738189249; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UqIIlqOeAKfNyK4/7PfTe1rO/D2RYtDpNKs0XvMZydc=;
        b=xX3U38EqCfdBpdSRnnJsFA164GLbwYEZmvJA86v7lfwVgNj7owlFnz3spW9Wli9cY9
         MFkxcOEHeT/JRTEGTQkRZReOx85/UOQM4nkwR1ppBT7XyGDxFZtUBfD8tRbJxXOxaNrW
         46GHcmXZBcCIH5zpPb4D7Ao6rGpL9HOek7q/e0khG39Bxq7ql6fK4Kb4CZVHT+GE4eYo
         7WVHv+tZ7F1tw19BWzvWqTt/GNZApx/9nnI1MqiKHUbHajgr9NGcqcDUAuQcOJCL6Sze
         gHibLTICwy+PFoWU7qwGoSEmRy4iPZbYLIvWykJ+SiKYZ0tCG9Lts5WadSFeLQDSDxhV
         NC7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737584449; x=1738189249;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UqIIlqOeAKfNyK4/7PfTe1rO/D2RYtDpNKs0XvMZydc=;
        b=APKoRoIsqI+zBRASPZ9mcLGVQ1R6hI9Xff09vV3uxLcV5dX++YbIFB+NHw0HHKsfwC
         jlOvIYxAWdiNA2aUdZyAmIQY4PKQwPM1DGU5GAOfrKCxwwl9sYd9g3ESByV++MQNSbg7
         J5A6j18eovEp6ClaxG5AS3E+Bgc3vjkyQepBS8wlnaDd03dwbRuSmsBQb4yPeGwdqn4j
         IkeD5sZ7Eh4uG93sNh/ROUWXR7risqKXWVT3iXQUaDLA0hhCPjM0AsIfpcXEuhXHWdKA
         d+Qdf9dic/BCEbSrzVzBHOCMeHfrAYb+b1RKcZj1Osyyb0XoH/WBZzVnb33tMQlDoDfn
         LSdQ==
X-Gm-Message-State: AOJu0YwWmjeen9rTd/6tlzQP/wFRpmYRsNn6muOA7+5/aT6/FYCWzCwv
	fXDB6W7vHmKuS1anFZaet+0eA98WlVNiWhfTXC9BuAAxVvLCmH1/sLWa7Xy0Sa0=
X-Gm-Gg: ASbGncvrQO/Q7yZMlubBNKUDVJVUn4cE/Lcx2GXswgNGsquu1NZ6c6VvWR+D0011N/P
	BMmppUWvBGK3WJbzKCxK+JKJSlN/Rtad9S+SCw3I1qxmBTIfEmy9uXqqhLIRvaZOI5FcS8kOWv0
	i6E0fUojExV9UErToYL51zWXvDU9IWNMyTKWZ3UA278quqKibMbEjfKO41g8mAwPzpC0ByR1RbV
	sP0agx63Uz6OsiZMTn41hMPd8gndzvrihobQih57bKl2Sv/m4FJbhyaPpM6r/CpxtCONgfWeCYU
	oQBNXzj2mZoHpMOY5o55RfOxkc4/QFWkw/H1Ii3QtA==
X-Google-Smtp-Source: AGHT+IHEKiMWFyheFaHMJ9HIdquYCYOG++EO6u6Ns1bt++TtpZM+WH0WRthqidS4izFNywH8Gw7F/A==
X-Received: by 2002:a05:690c:9a0a:b0:6f6:7b8a:6e62 with SMTP id 00721157ae682-6f6eb93d346mr184028597b3.35.1737584448916;
        Wed, 22 Jan 2025 14:20:48 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f6e643bb0dsm21746687b3.49.2025.01.22.14.20.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 14:20:48 -0800 (PST)
Date: Wed, 22 Jan 2025 17:20:47 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de,
	peff@peff.net, ps@pks.im, johncai86@gmail.com, newren@gmail.com,
	jonathantanmy@google.com, karthik nayak <karthik.188@gmail.com>,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v3 4/8] pack-objects: add GIT_TEST_NAME_HASH_VERSION
Message-ID: <Z5FvP4KL+POd64hh@nand.local>
References: <pull.1823.v2.git.1733181682.gitgitgadget@gmail.com>
 <pull.1823.v3.git.1734715194.gitgitgadget@gmail.com>
 <86ff0d0a15e4263ccd541a9b8dcdb99438784a70.1734715194.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <86ff0d0a15e4263ccd541a9b8dcdb99438784a70.1734715194.git.gitgitgadget@gmail.com>

On Fri, Dec 20, 2024 at 05:19:50PM +0000, Derrick Stolee via GitGitGadget wrote:
> @@ -209,6 +209,10 @@ test_expect_success 'bitmapPseudoMerge.stableThreshold creates stable groups' '
>  '
>
>  test_expect_success 'out of order thresholds are rejected' '
> +	# Disable this option to avoid stderr message
> +	GIT_TEST_NAME_HASH_VERSION=1 &&
> +	export GIT_TEST_NAME_HASH_VERSION &&
> +
>  	test_must_fail git \
>  		-c bitmapPseudoMerge.test.pattern="refs/*" \
>  		-c bitmapPseudoMerge.test.threshold=1.month.ago \

This is the only one that sets GIT_TEST_NAME_HASH_VERSION via an export.
I suspect that this is to get around calling the shell function with a
single-shot environment variable. But I think our convention for this is

    test_must_fail env GIT_TEST_NAME_HASH_VERSION=1 git ...

Probably not a big deal, but I figured I'd mention it regardless in case
you happen to reroll.

Thanks,
Taylor
