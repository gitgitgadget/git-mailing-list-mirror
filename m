Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E003375D5
	for <git@vger.kernel.org>; Fri,  9 Jan 2026 15:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767972223; cv=none; b=LfF+TiNVmsTU3uJE0M9T5/VtjD0dGn1YbFHvPhmgYL2NwMAv/zl/ortO+BMNAcU0x52CGiXdoKi6amrlM9GIXoOnX4AKOU80IYvgFPF0U9ByhUqTn0Uz1y280PHkxMCZ8dAuMAnCVxsnwqzpmXnXnubjLaH0lSm1IjhVOYfka30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767972223; c=relaxed/simple;
	bh=i24ox3svhTvf5u17wSY2bxmolkUZc3IjaIZxTyd8NGw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oJIMDa7NrDNz2mxR4/m7Lj/YNlOXZsLvAV/KVk8PFGVHoCPh6nkX2YCyMOnWnE7lnsM9f5XJcvZZXS4QJMlsDW/IUm/CZPbhZTgm4xBwMsc9N+/D/0qhhiGS0Gy6FeVnw3FvgMGOcECOHIeFPGDsT+f2qkbBbi9bfM5MUH6y+xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fMq65y2t; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fMq65y2t"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-59b6c89d302so3407302e87.1
        for <git@vger.kernel.org>; Fri, 09 Jan 2026 07:23:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767972220; x=1768577020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hOn/EySal3xXOrCGgJFX644LBZqr+by7bm9RJPgpnJk=;
        b=fMq65y2tkEqGDUX2kzzeytucjlc92DdpqTzvRjqI7D7XdJBtXC8nqap7Itqt2NQeY8
         +SIQhRbbIzErMWy2hrN93YBTRSe83FGKsYuK5/pzZNV5aQZTA6ZaqhNSPFSA1/GwhRNG
         cqjYnmYuL0uTCOG4yhFB+hgVOXZx8kCzl6Wcw0jKxNQSp9OJYR0xpIJOo4jI5tKto7Tp
         op2LtpjOY7v6AHi/rk1NASCXsrDmRlLjoQo2h8nOg5TsuSq1UHNIav82ORdUyK+q8BFi
         XnI1qq1GsdmbZGoMwiA6F6Ml5qumjql9xC03svL4S0jg3lhO7EplnHLPJj9pBxcDinKD
         nw2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767972220; x=1768577020;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hOn/EySal3xXOrCGgJFX644LBZqr+by7bm9RJPgpnJk=;
        b=SLqdSHv3qEezUEBfyqovqgTSJAygBgVlowf1AkUgbuvSxPPWP0oz4p8oJDJmtt3Y9o
         sS+4FLYznyIkNk2F1pol7dwXXKaszmHqD3yUJ0DjDc9Gcb80IMhuhfwcaphv0acwoOOX
         7sVh5BQly7obuvu0b+hHh+3ef+6lXM/zEnHGYxY33xI5uxQraWU5fQO1I4Ei4rbP4sEc
         l6h3iDayL+01D3xHu8Wcser8LUb2YNvYLwWfIis8CWMTanHgVaWL18y3Y9W7QyFVpAay
         Mehklrg1FNdgVn5z7sjYM+AdY8rKClWNIiYb+akss/MQVLTVbypr1sI05yV05qoum6p5
         3CGw==
X-Gm-Message-State: AOJu0Yz8WwxFmCRYwd273lWn06HUCiFv5ihnd8qkP9V7zLPj2aqSyMZw
	EJN4ZnMHDSOv8k26gtaKsKhmItDNzFKzwtWdaIWVcVuNxaT2mzydLccH
X-Gm-Gg: AY/fxX4fJAAIGVZfsA1gigrJxKPVJA/wZnN3V4AYe3kkggBTxiIi0MZsoi4XufgqSXL
	E85CqazBMtw/fNFy8wk0W9kxg8s5skBUj+lHmr4LYSJTiHm5bBLkzmDEWqQussKU8RUPkGdCzgF
	+LP0FEprhW/BzEH3ttMO3TwmeN19UHCJUDHqDkQltXZxWadrj/aFvPJ+87c3msZjX+SNWciv4rF
	N8jD/FRXwyfC/C5ptLrnq1AYOv6RXqz14V90noJGAQt9Ts+rNLTmMBk5gaAXOz1XgeWQgv9I4v4
	7J/IrVZrRe9odyu8vjsRyBt9HphTbW6RI1qxwrRduwsxAzz/7pNkIbOz2o1shv/Kntgeux15XsB
	EEXaXjWMyx7logHqWet4z5sokZCsA3bs0ikqaA26G6rEnG2qqgcrpanfh+5J7UJMEu6zwiA+osN
	RIB1gi5R5VVX4111rHrxIS/enYuTuz2o1Jb3398XZvMQ32AxHrUWlYRV+OATzn/DwMF28krlk=
X-Google-Smtp-Source: AGHT+IFcM+XwuapO7nC+S/9g6KflkEIGACsW0GvTRRc9Uildsx93d5ApjK7k1SIJshfOPTt3uKRrKQ==
X-Received: by 2002:a05:6512:2201:b0:59b:6dbe:d09c with SMTP id 2adb3069b0e04-59b6f022ecdmr3900584e87.19.1767972220191;
        Fri, 09 Jan 2026 07:23:40 -0800 (PST)
Received: from Mac.localdomain (h-85-24-230-197.A753.priv.bahnhof.se. [85.24.230.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59b792cf38bsm1234812e87.63.2026.01.09.07.23.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 09 Jan 2026 07:23:39 -0800 (PST)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: phillip.wood123@gmail.com
Cc: git@vger.kernel.org,
	gitgitgadget@gmail.com,
	gitster@pobox.com,
	haraldnordgren@gmail.com
Subject: Re: [PATCH v17 1/2] refactor format_branch_comparison in preparation
Date: Fri,  9 Jan 2026 16:23:39 +0100
Message-Id: <20260109152339.70643-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <daab4e8f-cd9e-40af-bdfd-c5884d15d852@gmail.com>
References: <daab4e8f-cd9e-40af-bdfd-c5884d15d852@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> I wondered why we needed to pass sti as well as ours and theirs but it 
> is because when we're using AHEAD_BEHIND_QUICK our and theirs are always 
> zero and so we need to check sti to see if the branch is up to date. 
> Perhaps we could make this a boolean called 'up_to_date' ?

Yes, this is the reason. And I tried a lot of things to get around it. But
yes, let's pass this boolean instead.

> This could be 'bool' not 'int'
> 
> Everything else looks fine - it is a faithful conversion from the 
> original and it makes sense to check if the upstream is gone in the caller.

Done, will be in the next patch.

I didn't update the signature of 'format_tracking_info' to have a bool
there too, because it makes the surface area bigger of also updating the .h
file there.


Harald
