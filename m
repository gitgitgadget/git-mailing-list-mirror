Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B287533CCF
	for <git@vger.kernel.org>; Tue, 30 Jan 2024 00:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706575449; cv=none; b=t/hzPS8uX62bvOia92D49ij5oWBCTxbOM4jVOOwqsr6kRw0p8Y/ehOmtIWE5s9aGef4cJfZFM2CLQyhCmYd58ywLYzbB+/Tt/lHmmxkXqyv77HVBMDAuHfXaL9EIGTgMWIeotmi+xehpXjAel1dQUSvs0Ah/85kOn3tuhnW52lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706575449; c=relaxed/simple;
	bh=j/vZNYjRbgndIfO6+ce85Hd3DIYyCMBRtjkDzFF2QBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=prWwnxQrMj+wagvy/Ci2zUom+PiacDajPidv5PuAxCwr1EhESl0e6UWkFD/6Mtqk9ujAd7pAk6TX3iLlb69dwPZ5DjKS+LArm1h4fKlLfXbuQGbOZBPAwiWl6G+Lv37C35K95m3Ox/HKxWuZOpUaYvG5+teoxLqscxbTXzCQL+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A7A4sZ4v; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A7A4sZ4v"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5cfd95130c6so1855591a12.1
        for <git@vger.kernel.org>; Mon, 29 Jan 2024 16:44:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706575447; x=1707180247; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vfl/qcIWlOhv307WJ0kX44C8+eXsC0qFOpXRSDIW9To=;
        b=A7A4sZ4vTY4byP5vi7+B2C46UiJGhAI70817mf+Ny9WX6XJkQ9bsk0fk2N3nB6hzeh
         XyH0Ix1F6hlcizwNzDOMyYMshRWOfcH1WBkxS6CLrIR1sKu0uhIEk4Jdq36ngEntGNBv
         A5oRl4Ch3BWLiI87OgLSx2iI/PTRtuiOJNBcwmF0Z7Ao7M3ZRcEaVEKPCPGQ9PznJSsk
         SPiq/crCiGVomCn1mrSybgayCmWeDjCM7GMzGt4MCsAMIbz0/UzWRIPmiQh9Qjuw/J5o
         cQwsVgwChHRdCpJ99YUcG8Djs9H96olNsz5qkzLyCHs0hbY9+Z0In5oFVItRnxTgTw3p
         sLRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706575447; x=1707180247;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vfl/qcIWlOhv307WJ0kX44C8+eXsC0qFOpXRSDIW9To=;
        b=RQAiA3pY2DAeoMvKszURcVybxcsXl5a7mfAV15oypqo2R1tIhzZn9xgRW0A20/chzC
         uDDBpQttUH9i30YR85xVuMA4pNYmZaJfa4fyBtPj9b/4a8rG4GZzbiDAM5jzsTkNpSVq
         yfEYm/laPZJq1XCqr3wDp8rNz84t+le4raxkVHtpq8XNWIHc0VkbF78BI35xy+5Xar4g
         xmCBAQaqxcc8xvCVLXTS1LsSSr9V0MswRmYyBjKlDFJ2IRaKm4UxwKQ5mLi1f/XU4aKO
         TbXXHyRbJ5JxiPpiljvDM8Zz4UkTMeYy02lOT0kR2ehMc3Tx3UsHoAYettivHLPt2Ahj
         E2xw==
X-Gm-Message-State: AOJu0YxucUkbyAuck47EoBh0dkxVelNOlPprO1GpX0KnYKqaGup7QMSv
	blmIkFpxLWqz7Rx7VOZIdm4vCRO7HtHJifQVJ7CjNcWD/XFjqmxAO8wEbTwFoQ==
X-Google-Smtp-Source: AGHT+IGP2v5GvKhowtre3N7sSyVPoVBBs7ngEznN6bKUx5Vd0JGE8QiQKSmW+LgYLyTGykF4+59M3A==
X-Received: by 2002:a17:902:f542:b0:1d8:ffb2:8bcd with SMTP id h2-20020a170902f54200b001d8ffb28bcdmr1605447plf.66.1706575446834;
        Mon, 29 Jan 2024 16:44:06 -0800 (PST)
Received: from google.com ([2620:15c:2d3:204:4527:c1dd:9b37:d3a0])
        by smtp.gmail.com with ESMTPSA id ke15-20020a170903340f00b001d8e04de78asm2533793plb.132.2024.01.29.16.44.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 16:44:06 -0800 (PST)
Date: Mon, 29 Jan 2024 16:44:01 -0800
From: Josh Steadmon <steadmon@google.com>
To: Linus Arver via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Junio C Hamano <gitster@pobox.com>,
	Emily Shaffer <nasamuffin@google.com>,
	"Randall S. Becker" <rsbecker@nexbridge.com>,
	Linus Arver <linusa@google.com>
Subject: Re: [PATCH v2 01/10] trailer: prepare to expose functions as part of
 API
Message-ID: <ZbhGUYcxEaeOXPAi@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
	Linus Arver via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Junio C Hamano <gitster@pobox.com>,
	Emily Shaffer <nasamuffin@google.com>,
	"Randall S. Becker" <rsbecker@nexbridge.com>,
	Linus Arver <linusa@google.com>
References: <pull.1632.git.1704869487.gitgitgadget@gmail.com>
 <pull.1632.v2.git.1706308737.gitgitgadget@gmail.com>
 <e2d3ed9b5b6d67273c22671374daf7695c67709f.1706308737.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2d3ed9b5b6d67273c22671374daf7695c67709f.1706308737.git.gitgitgadget@gmail.com>

On 2024.01.26 22:38, Linus Arver via GitGitGadget wrote:
> From: Linus Arver <linusa@google.com>
> 
> In the next patch, we will move "process_trailers" from trailer.c to
> builtin/interpret-trailers.c. That move will necessitate the growth of
> the trailer.h API, forcing us to expose some additional functions in
> trailer.h.
> 
> Rename relevant functions so that they include the term "trailer" in
> their name, so that clients of the API will be able to easily identify
> them by their "trailer" moniker, just like all the other functions
> already exposed by trailer.h.
> 
> The the opportunity to start putting trailer processions options (opts)

Nitpick: typo in the commit message.
s/The the opportunity/Take the opportunity/ ?

> as the first parameter. This will be the pattern going forward in this
> series.
> 
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Linus Arver <linusa@google.com>
> ---
>  builtin/interpret-trailers.c |  4 ++--
>  trailer.c                    | 26 +++++++++++++-------------
>  trailer.h                    |  6 +++---
>  3 files changed, 18 insertions(+), 18 deletions(-)
