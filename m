Received: from taslin.fdn.fr (taslin.fdn.fr [80.67.169.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277271DAC9F
	for <git@vger.kernel.org>; Tue,  3 Dec 2024 15:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.67.169.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733241086; cv=none; b=acTSGoMDueH8nSCBQy+NN6gAOlqq3oY4Fc8hJUldiQW/9to0HZfIQEb2LJn/gL6BHuaBq4hj9ThMuFuX1wH8HwVLMFx7KTFkgrl1EboQL5uybbUBz27LF6Ugx6aFM6TakMs/wI24ZMn+x9Nmv70cCDf5TrrMiNj4clmbExOq7MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733241086; c=relaxed/simple;
	bh=WERvBqlOo5AJYUM5sHA3QrinApzdLh2msAqGBIxiHvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iM8jW1Tu2FcERNAPcQ1RbP5QpYF7FIeTrcIdQXagPkNdcY8YsOiDZn4gFUNqvwWQSWU0R6yPa+i2/8rXrSnHnXz70P6OVJOyLMxOzcLm4VmoegZS0eWYieVcQpwzP3Nfrc4oo6ICnIAJhxsdG0zDTO87tR7NeUzGzyjwsCDpoNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=max.gautier.name; spf=pass smtp.mailfrom=max.gautier.name; dkim=pass (2048-bit key) header.d=max.gautier.name header.i=@max.gautier.name header.b=ZQbtaYxX; arc=none smtp.client-ip=80.67.169.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=max.gautier.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=max.gautier.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=max.gautier.name header.i=@max.gautier.name header.b="ZQbtaYxX"
Received: from localhost (unknown [IPv6:2001:910:10ee:0:666:7ab6:84f4:fbbf])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by taslin.fdn.fr (Postfix) with ESMTPSA id 082E060A96;
	Tue,  3 Dec 2024 16:51:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=max.gautier.name;
	s=fdn; t=1733241081;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9lVOkn7qV40vDtEMTo4CikTyP1xloIBrGZfmldBXXUA=;
	b=ZQbtaYxXR1FbJECcMlGzA9d9v24eiCfnxmBkxZLpeC8IB6/TUAX9VANrdToml4DqleSha5
	+XCA8Oa28QT1a6Chvyih2adr7hrIqDgdoWSf8bxRccmg+mjtGvmxT9DnFHpdgxphTxqK27
	wHoY3ng/0k9wRqaGmBzoh3+ahaZpUkUd6AuH8M2Ld0LyXC/NvtKsMz5YdLBgJWlZWvgD5M
	sobGXJ8MpFW/cgalbSoVs05FG+cNYafkaz3jv11qGmc15/gaBRU0Xcw8nnNUfZI03JwWnR
	iHd5VhXbj6lHc+GgiU4FI5mOQYCREqJNckvKUZCoJixTjOSefpE75oxePn4XTw==
Date: Tue, 3 Dec 2024 16:51:20 +0100
From: Max Gautier <mg@max.gautier.name>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>
Subject: Re: Detecting squash-merged branches (and question about
 git-diff-tree)
Message-ID: <Z08o-O5eiu_ZsYrp@framework>
References: <Z08N4AlQKiNi-IOI@framework>
 <75269425-49ee-4a16-beef-614da392d528@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <75269425-49ee-4a16-beef-614da392d528@app.fastmail.com>

> I’m working on a program/script to detect merged/squashed/rebased (or
> cherry-picked) refs.  Is it okay if I contact you if I finish it? ;)

Feel free to, yes

> 
> There’s also this program which says it can do the same thing (not tried):
> 
> https://github.com/foriequal0/git-trim
> 
> My program tries to be like a for-each-ref for merged etc. refs.
> More focused on reporting first since that can then be used for
> deletion or whatever else.

Hum, I'm wondering why it didn't find this earlier, I did search though.
It apparently use git commit-tree to create a temporary commit, and git
cherry on that to check if it's in the target branch.
I wonder if this wouldn't cause problems in case of conflicts though,
during the git commit-tree process ?

-- 
Max Gautier
