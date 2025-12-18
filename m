Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E006230264
	for <git@vger.kernel.org>; Thu, 18 Dec 2025 00:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766019496; cv=none; b=q+nnQSYpSObLIUZZQJEpREeuFRa578EkVjdmNhJDK5pn6BUJmn8Geea4qJBL5desiDCsyvwbyYTKvFivMbtupHR7ulT9qGNYYduP90cjjsbpSyjRsYzaFkFr59hqaurdt7PvamS9zSWOYh1YdfC4RjJ1LXNI8yuLf/Mi2H7xIsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766019496; c=relaxed/simple;
	bh=D4HdZ2MwHkN/qnintAHPIoxOKk3HU8UC0axOdavHYO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aTFteDBJ/v6Xzvh4ss4BDG99jMww+pOfi1swZcVaXwv7T5mAT3EoWS3I/nQHdOyR/1rNxky+ja+X00074pqcnT5OlEpIZ1n6Uc/RmMqWWaCRIy6M1KfufRqlBVXvyRcGQdId7J38UoGwZHAHKMwiT0gADPvdW6hQrieC/Lx07/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CWL1LC5+; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CWL1LC5+"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-44ffed84cccso31656b6e.0
        for <git@vger.kernel.org>; Wed, 17 Dec 2025 16:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766019490; x=1766624290; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IsucCdcmwreRVXIdzwKIjGpGrf/6lHEBZREsDoES+OA=;
        b=CWL1LC5+mXrOsqhviEEnRd0hJcxo/PanazGIMGrq0197O19563ZHiyl7ixg25svbhu
         hvX7XZxkLXHod4eNldKryDueizNuxGR2U/fsGD31MzAoz2QkKOq8d15lm2gbKfEq62y7
         rO3o6pFkaIa90qFdt+erh9WeppQUsYicYLWZuJQKBa1KXIZ5KV2oUedE32rHAUd8ATjQ
         qakWH8YLJ/kF2T2Ytus8TG8i3nb8ht/vlSdUWvdX+VPTdIkyE0pQXM+QdbTky/Nn1qR4
         eN3/jmsMXMfORWQ4frIZRvL33Tm46JW6qk2BEUkvPMIhSYUJtrNoBj5OynmK10OqL64p
         EbkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766019490; x=1766624290;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IsucCdcmwreRVXIdzwKIjGpGrf/6lHEBZREsDoES+OA=;
        b=SObQFdhiK/VWAtPodCvSCAdK9PkulM14PtqOTdrztHgqtv2+jGyg8KzAHr7OnacWio
         2Dg1IuxBXHi9/ybDmlNU8HMVW973V9ruZ9GvdeAtZwePIXlxkss2N7rTJlRZLmyR57iH
         1zlRzcvYp6qWwfjqMG8s9PgmMNmjmAhHVwjFLZfJD+HeVO3tZJyyvaClAj/7WY82FUZI
         c4WBD6OaEWqPjN404Na2Wq2qB6k88IM3jzxV5j8FakMyCrSfCjdm99tBVjh4OqX2Dfmt
         U+pf5/Ory3mcUw/ByB56wHqnSBMYxuQE9X9IXAaf96JQ30BojB2fthoumg1us1ZUYAjd
         6lhw==
X-Gm-Message-State: AOJu0YyMDuoAMH9BQsSPfZeTuXvHxw1D9UPk3IWRtxo4158P9pL+6+/+
	DgWOVHykaWlYIUInB533g6dnryh7Kc8zVaGKEzLYdDCLd7rX8ZBS+Q7WCxGz3g==
X-Gm-Gg: AY/fxX677wgCBj5EB/nTZD/gKC3LTlHsoBoiYk+jr/lMERhjtzVl9cfa3k1wQh7Bf5m
	R/hxQvigPNwhojiRiqa9rVcKpnv9uYJ9m4GRrTw3D13FqNv7ZfLQlx5saiHIfvwDgFbgi4CK7KW
	+poY5lM2ihVzvEHfCGqkeYyJEAGXIwpidUrXuA6r/bfLJXHEjMZyIsfJwss9uMUaoy8yDVhvw6/
	Oq+8v7bZ5AAqzGhlRgQq9rgEXatHvnBw6w4qyJIMbc50s5taFhbHnSrFgIfUFu1+kJjEY+e72WS
	0VDEEg95WL/UBzntWAIEQDGUpEenC22tmpzIrOo5UgUq5lEJedJkdfqa260Ph9N/ADcanuDZCly
	phUgr5FcEh9ElSmR/gGxJa5VrR0kESn8BbXWdKw3NO3vNqcovPsEr20HsCQLqZH9q9o0QLUsaRa
	bseL5b
X-Google-Smtp-Source: AGHT+IEuadtCDRmI9AHYOpTcnrKADHheSlzdYlDEnCIcs8g+UJT3k7JrvjMJx9Vi9AXUeYfXAI2mLw==
X-Received: by 2002:a05:6808:384e:b0:44d:a531:456 with SMTP id 5614622812f47-455ac9f0dc3mr8725364b6e.52.1766019490225;
        Wed, 17 Dec 2025 16:58:10 -0800 (PST)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-457a42f8186sm441922b6e.5.2025.12.17.16.58.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 16:58:09 -0800 (PST)
Date: Wed, 17 Dec 2025 18:58:09 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 06/10] packfile: only prepare owning store in
 `packfile_store_get_packs()`
Message-ID: <kold36s4dcuvg5sdexbdvczd7x3kagqsz5zhlujw4a2zeuq3id@ngl3kqa3empe>
References: <20251215-b4-pks-pack-store-via-source-v1-0-433aac465295@pks.im>
 <20251215-b4-pks-pack-store-via-source-v1-6-433aac465295@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251215-b4-pks-pack-store-via-source-v1-6-433aac465295@pks.im>

On 25/12/15 08:36AM, Patrick Steinhardt wrote:
> When calling `packfile_store_get_packs()` we prepare not only the
> provided packfile store, but also all those of all other sources part of
> teh same object database. This was required when the store was still

s/teh/the/

> sitting on the object database level. But now that it sits on the source
> level it's not anymore.
> 
> Adapt the code so that we only prepare the MIDX of the provided store.
> All callers only work in the context of a single store or call the
> function in a loop over all sources, so this change shouldn't have any
> practical effects.

This patch looks good.

-Justin
