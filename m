Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A62C1428F8
	for <git@vger.kernel.org>; Wed,  3 Jul 2024 20:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720039018; cv=none; b=b+twsFVVxoYMF4C2jBb6X7j186oj7KMpPqGWBXB1/wrMPeg8BgSb4av7iHkh/B/22P5EFoD9rq0/nzgI8gTuiVGIu/GNPs0zh4qPtbhD0E7uemnQcr3paYu2tq4ioY8DOazDzg39Kbf+fbagld+RpBi5G6h1rtwns3r6Jm35lY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720039018; c=relaxed/simple;
	bh=xpW8xntFOU5BrAUydJ8pfXzcbDrpcYm7FMc2gYaQvw0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ljYmyCk2WtmCT977c3uaB1Z3277PfJq6quERDuLvkwoWMYv1/RG0ZIdhkS9CKXsDnJUzGB7yjm5DUA/3zcgvvPbWeZ0b8iCziVOz1LRpTY6r34OA2CNYIxwRpJ1MbP6nXmVPmrx/lbvH0jlRWX7vwaV/3cffO2p6ApcgibaxqZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sej79U7A; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sej79U7A"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-362f62ae4c5so658214f8f.1
        for <git@vger.kernel.org>; Wed, 03 Jul 2024 13:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720039016; x=1720643816; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pMJTUSP6FHe/Dcfwko9SxhLUTuyg5XiAX9j2xipwjOM=;
        b=Sej79U7AifHluceTUGM3MkcHHWvfWhU7ALDsnfn5n5xliiyxyhncKTE/n6DlcbgnWn
         5b85bo7nPkPkCXkcDGoQ2WxEesGqrvlTxnpAPtN4FmOreDX9cMP6amKKk26vKX9zAFwE
         sa9UVv8gbpXSVsasKt9wnycx/q1StpFJ+TBA4aaktNakTaFxiL/6vKvBNCdFWqz7SwRT
         JMdW3Mowp1EAdqReRvlvXc/DD3FqqwO603BgXgTGl8TmWlkDfTPBpS6tlG+lgaLo2rX4
         kgfjvi6rz3ZLv1qeeJ7YNciM2K5g7a2scfP89beAXI9jowxsrPll6PFks6IvT/WAVBc9
         QhwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720039016; x=1720643816;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pMJTUSP6FHe/Dcfwko9SxhLUTuyg5XiAX9j2xipwjOM=;
        b=nUcnZZCrXDetyB+C+qYp5rZD821EBVIX9NlTH139kW7fJkyvlePb6IpLvZsWtXUi9O
         YK/2rStf7M+6QDxrFp/rlbEIy95dhoiNklLWaKWXV+JDopytpRZQBBb2PVTQy4k3L9sD
         v2DSTeNnQ9rNO1MBQocCNxiG7TS48BOfM+gcw5RACSriIWTDp+MgxmvzEqGJo+pSzyUz
         acYcLCGL8QHU7+bGanGjPbH7lh18RrkYZUPrn30zz4d4URky1LOthUYZ4esiPYjmzdsC
         bPpn1o2hmWM+sO00qFGwnbwK51u/SclHXXPIE9maO7mglOmpZfy/HwW7YBlvhfmNt+EJ
         7Ilw==
X-Forwarded-Encrypted: i=1; AJvYcCXzEK+K4MV/Z23l3psnq1A+mPkdaxXjK1XWhrD/jiu0AozZTuCFz7YkMQvUYiO9fUUksYa0uAaDH/ACSNnHM5vTuyB1
X-Gm-Message-State: AOJu0YwK36Esf5V3nD3VhFZkHdZHN07wkhvQZx0TVtPOMLbdrS6z7QE3
	wBivCE5FVuiIGS5FLsMF6JhG/IoXd4vUC56/N4aj64i6ToeAEiZm
X-Google-Smtp-Source: AGHT+IFVRsqap37sXGOKDkVGXMGnl7XSiCzIbcdxSHqyvHCtB+KLjDT41dMZXklkfbz+D+6AvBOwdQ==
X-Received: by 2002:adf:f652:0:b0:363:337a:3e0 with SMTP id ffacd0b85a97d-36794780b27mr2410214f8f.1.1720039015435;
        Wed, 03 Jul 2024 13:36:55 -0700 (PDT)
Received: from gmail.com (82.red-88-14-59.dynamicip.rima-tde.net. [88.14.59.82])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256af552a0sm248418975e9.14.2024.07.03.13.36.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jul 2024 13:36:54 -0700 (PDT)
Message-ID: <57ef4a0b-f67a-42e8-83bf-6e4b6ad0faac@gmail.com>
Date: Wed, 3 Jul 2024 22:36:53 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] advice: warn when sparse index expands
Content-Language: en-US
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: gitster@pobox.com, newren@gmail.com, vdye@github.com,
 Derrick Stolee <stolee@gmail.com>
References: <pull.1756.git.1720019679517.gitgitgadget@gmail.com>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
In-Reply-To: <pull.1756.git.1720019679517.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Wed, Jul 03, 2024 at 03:14:39PM +0000, Derrick Stolee via GitGitGadget wrote:

>  	[ADVICE_SET_UPSTREAM_FAILURE]			= { "setUpstreamFailure" },

> +	[ADVICE_SPARSE_INDEX_EXPANDED]			= { "sparseIndexExpanded" },
>  	[ADVICE_SKIPPED_CHERRY_PICKS]			= { "skippedCherryPicks" },

Maybe this change will disappear in a possible v2, but if it remains
you'll probably want to swap these two lines. 

>  	ADVICE_SET_UPSTREAM_FAILURE,

> +	ADVICE_SPARSE_INDEX_EXPANDED,
>  	ADVICE_SKIPPED_CHERRY_PICKS,

Ditto.
