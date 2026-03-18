Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8032EF660
	for <git@vger.kernel.org>; Wed, 18 Mar 2026 18:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773859275; cv=pass; b=qAiyHVTVe+3XeQ41ksolB+vjBxWz66KWV0BCail9e68djBiMT326twGkYdKdxf46cXG+ldkf7JcxovsjNCfFEzkQoK0EmnOtLwl54xvvL28YWAQph4fU2ddGReioc9L6d1itDVvP1PPLJ89i6c59abKUjJMXjgTQN8rjIhhdIOg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773859275; c=relaxed/simple;
	bh=OOSwEfkuhzzqQ5vwzIv82YzdMn+UQrXXmQA7Jda6US0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sRUGPvNd99g9YRc/X2T+ZPtGeyKPyw7bzUeRht32n5/R3JtTDFiUqret39vH1Pst2WgyeCJo223eNr8++RJZt+qt6XxzG0wqRPO9TYSD/nyrfrJTlRr94UpGYA8TLNQwBIAWgtXyBwcQmCwcPgl6t6O1IAoEnPEzi2IvJ7NtlaU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=WeYuzj8q; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="WeYuzj8q"
ARC-Seal: i=1; a=rsa-sha256; t=1773859252; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=NLJ9bbVMOGyWZhAQJPUopTHByA4+Hfg36/h/DIe0MirfcZ+NE0liC1iWbXPjS68ohM+yTw/FeIKDuAmH+Nukup+uRZUj84gVxPthy1EN7H6DNVl3Rs4x485Frx8Ltd9j/P4FxXAUqMcg4JGb5BHtCd+GRaRMT9RjD3l8IbaTpXo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1773859252; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Gv0cm68BWdNZmFvDKNVeAOeXMU4Wcrihp+vQ6ILWgHk=; 
	b=Ocxs87reeoPi4ODBpVHPJt89JOKyav/3qOkly9p3gPsCyCmIYnFO24dplBRzfp7rDvQcF182O4Q7jTJZjvdwKx8teVeTMglDvBViNtK1KU8RFEr1qjKCRFSNEGVPfjX5mdnOm59/o+eUEFLjNJIDBIhZeDoG+5rAQ3kj6bjzTu0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773859252;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=Gv0cm68BWdNZmFvDKNVeAOeXMU4Wcrihp+vQ6ILWgHk=;
	b=WeYuzj8qZ2UQ95K53A4sQai3mn4xTvAQfBn5Dku7UGyDoct4sHgSCtKy/o/PjUII
	VpRFYuJOHhxJwc93z9g3KmiYYx9w3tXnAasqYna41A69TtUeop3PFxzMMFBtfnHjtYM
	GKL/DwA2GAplNX92TnRTbC2N8Yn09OvROzLZAAhc=
Received: by mx.zohomail.com with SMTPS id 1773859250921183.7918311571873;
	Wed, 18 Mar 2026 11:40:50 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, Emily Shaffer
 <emilyshaffer@google.com>, Patrick Steinhardt <ps@pks.im>, Josh Steadmon
 <steadmon@google.com>, Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>, "brian m . carlson"
 <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v3 5/9] hook: mark non-parallelizable hooks
In-Reply-To: <xmqqcy14stf7.fsf@gitster.g>
References: <20260204173328.1601807-1-adrian.ratiu@collabora.com>
 <20260309133739.294555-1-adrian.ratiu@collabora.com>
 <20260309133739.294555-6-adrian.ratiu@collabora.com>
 <xmqqcy14stf7.fsf@gitster.g>
Date: Wed, 18 Mar 2026 20:40:46 +0200
Message-ID: <87y0jp0ymp.fsf@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ZohoMailClient: External

On Sun, 15 Mar 2026, Junio C Hamano <gitster@pobox.com> wrote:
> Adrian Ratiu <adrian.ratiu@collabora.com> writes:
>
>>  hook.jobs::
>>  	Specifies how many hooks can be run simultaneously during parallelized
>>  	hook execution. If unspecified, defaults to 1 (serial execution).
>> +	Some hooks always run sequentially regardless of this setting because
>> +	git knows they cannot safely be parallelized: `applypatch-msg`,
>> +	`pre-commit`, `prepare-commit-msg`, `commit-msg`, `post-commit`,
>> +	`post-checkout`, and `push-to-checkout`.
>
> If there is a simple rule that can be used to decide hooks with what
> characteristics can and cannot be run in parallel, near the "because
> git knows" sentence is where we want to write it down.  It would
> help new developers decide if their newly invented hook should be
> forced serial execution.
>
> For example, applypatch-msg is given a file and is allowed to modify
> the file (perhaps reformat or typofix), so two of them competing to
> edit that single file would be a nonsense.  Letting them edit the
> file one after the other would make much more sense.  So one of the
> rules may be "a hook that is given a file and expected to edit it".
> other two hooks with -msg suffix may fall into the same category.
> What are the rules behind the decision for others?  Are they also
> explained with simple rules?

The simplest and highest level rule I can think of is that these hooks
operate on shared data, so they cannot be safely parallelized.

I'll make this rule clearer in the re-roll.

For the *-msg hooks, as you mentioned, it's a file.
For *-commit and *-checkout hooks, it's the worktree or index.

post-commit is a bit special because it typically invokes git commands
that contend on lock files. Happy to drop this from the list if I've
been too conservative on it (it's a 1 liner change + this doc) and allow
it to be parallelized.

Suggestions are welcome, as always.
