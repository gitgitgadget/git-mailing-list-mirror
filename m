Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DACA346ADD
	for <git@vger.kernel.org>; Sun, 11 Jan 2026 14:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768141253; cv=pass; b=Zw/UgedlS5rzb2s949B4dMyYNltz3v7whP3btAgcgemBmhGc+BPugCcLpbBbLFe6KbQ6iIxKkOqdYg2QVZKqVvLZ+lYzLA1CmjN3yXJhGFS/ZdcfR53XOPtnsyUSxQ6sSZghsho12nUiLDuLzr+q0ZjgtExee227rquVR67rH1U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768141253; c=relaxed/simple;
	bh=rWlW/6355Fj4EZXyEvw8/JDZ4TGWiDYuj66hCQvBWx0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TIUbYa5JEruC3Q616lLQSpqaJA1erk5hPMr77bzy6dmIrT6VYTDEdFZ5OzzwOkdmHiUqk6oCzi7B4aKXAULwzMWRjC0M9u1uWlFxcG3Wi+livtyk62eo9/f8Env/csd7R9CjJfTtSs1oeovtzSEzLFnzKr8fM7vGLZv/3rDlN+I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=D1W+eVlc; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="D1W+eVlc"
ARC-Seal: i=1; a=rsa-sha256; t=1768141242; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ax6Gnv5croJ0pau3PrKS3wdIKmdTz4QK+sOFDBG6JzInUhTR1qFAh9IPhNixoAbmW1KX7fTvHwCcGe/pFejKRL6ZH08zrgGphuuhQ9pHgyHMV7vSO2D3cI+kylJ1FwqSUBBqbGRUto0jILCfivwpeT/t+E6jv8TSY873+gkj9pw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1768141242; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=iFOWdhX+qaICIR2vWjU4Y7+1FlnVcGd6yJZTw9rJbwM=; 
	b=EflrSMdkhl7fZ9/7RbIypNYwANtIGFCEUrQm1Qn1fA0ewo6q48sXdjecvMXPqgFHnUe2F2bstdmB+Tcko61HDZByuWos2uzMLAbyxMUAApGYzVgA472d9ruRzCwaePtLbAsz7smTd1zKzl0iO4137PHNH0+sobkClERwNCydta4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1768141242;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=iFOWdhX+qaICIR2vWjU4Y7+1FlnVcGd6yJZTw9rJbwM=;
	b=D1W+eVlcGhR7e0F4+ES7e26h2fc2qc/TteI56zq+ExdHCskBWBKcPug//QkthWys
	sK/P/xO8YsHssCoOvbd3kWIKZWvsq203z1/JD1SKs8hjGRTLmLjvggOJXbRsPMYOAcB
	qNFrPZuboJMrSvGh/EqRg8UvaGmnvHru16cPCMAY=
Received: by mx.zohomail.com with SMTPS id 1768141239984730.9123917600238;
	Sun, 11 Jan 2026 06:20:39 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>, Patrick Steinhardt
 <ps@pks.im>
Cc: correctmost <cmlists@sent.com>, git@vger.kernel.org
Subject: Re: [Bug] hook: -Wanalyzer-deref-before-check warning in run_hooks_opt
In-Reply-To: <aWF-nZ9MXp31QzXs@fruit.crustytoothpaste.net>
References: <72d123b8-b75e-4b1d-8506-95eb9ad350da@app.fastmail.com>
 <aWDm_n2YgjvaRmpV@pks.im> <aWF-nZ9MXp31QzXs@fruit.crustytoothpaste.net>
Date: Sun, 11 Jan 2026 16:20:36 +0200
Message-ID: <87bjj0s023.fsf@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ZohoMailClient: External

On Fri, 09 Jan 2026, "brian m. carlson" <sandals@crustytoothpaste.net> wrote:
> On 2026-01-09 at 11:31:10, Patrick Steinhardt wrote:
>> It's not a real bug. If you take a look at the the `if (!options)`
>> check, you'll see:
>> 
>> 	if (!options)
>> 		BUG("a struct run_hooks_opt must be provided to run_hooks");
>> 
>> So we'd abort immediatly with an error message in case the pointer was
>> `NULL`. Which clarifies that this is a case that shouldn't ever happen
>> in the first place.
>
> You might think that we'd abort, but that's not what modern compilers
> do. Dereferencing `options` if it is NULL is undefined behaviour.
> Compilers are free to assume that undefined behaviour never happens, so
> what most modern compilers do is say, "Oh, we've dereferenced `options`,
> so it can never be NULL," and then use that to omit the check
> altogether.
>
> This sounds bizarre and like it might actually lead to security bugs,
> and you're right.  However, compilers keep wanting to make code go
> faster, so they keep relying on eliminating undefined behaviour to make
> more assumptions about the code to optimize it, even if that results in
> code that doesn't do what the programmer intended.
>
> This is one of the reasons why I'm in favour of writing more Rust, since
> safe Rust doesn't have undefined behaviour and therefore doesn't suffer
> from these problems.
>
> In any event, this is almost certainly a bug because it almost certainly
> does not do what it looks like it does and the compiler is right to warn
> about it.

Ack and thanks for the feedback. 100% agreed on writing more Rust. :)

See the below link for the fix. I've ensured the NULL check happens before
dereferencing (many thanks to Patrick as well).

https://lore.kernel.org/git/87ecnws0fx.fsf@gentoo.mail-host-address-is-not-set/T/#ma8343d1b5393d4efc0c1103357a6e684fc8b1017
