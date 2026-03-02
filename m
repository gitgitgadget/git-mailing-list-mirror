Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16452877C3
	for <git@vger.kernel.org>; Mon,  2 Mar 2026 18:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772474565; cv=pass; b=fJMtRoX71szazBx8v5/JtqLzHJxcEBBLLPQvo6f/NgdEev/kaRX2KjJ1vBmQFyArLx+GYq3ZqmWImC4LRrXuhVpGBYSqOKAIy41r4s9e0RG22g5bdXrR3tMw0UgfK65WSvj1pS1Ho8kWoo9nANvRJDHJxF1qUZisjkR3CKm22dI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772474565; c=relaxed/simple;
	bh=AwEVLKt7BNikP1VvLGDFzAsBpswApdRWshH3CULE3Cs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pt2mQAvyOOPU9l3fQw26QvhyD7rwZ7FnMkvv9NyDBAi23RCpjyNMrdSzsGhuL9/Qn1NR4KthWpGkxpANLUMPZwcRVowEHk8vdoIx6nGxehZcQ+Q3kZcyXtdmIxSiadc+a+FQW97MATVHVIDbwc+E8ig4nupOhhrMJoYfG4TZmSw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=Mvl9mZEJ; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="Mvl9mZEJ"
ARC-Seal: i=1; a=rsa-sha256; t=1772474556; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=gebU6PKDXOl2Dnf6sJjy86EO4mG4YczKycQlzjfEPTnP/0pIiSBFANZZBia85YMwjZqjKCTmLSYHLlGADcE0v8OhZnym/qfDcJe78uVhhUZIeF5B73/u0PoeQKmIw1uObiRshNJSQCCbMLAff8kGYcFy1CIi9rxnewmmuGfkkpI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1772474556; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=97bHlU+UJl5b6VHD35KS5GbSCdGZGoXAKdHp4TR9mGw=; 
	b=MTDT9NCSzGSwKjQWCK9uAji+0vG0BjWL7n6iKY5G+KV+CJUYqm526DPpqR9BqEPfyLqx2FrKOEi3T4r/HU/oYwYorHBRM2i/12IfEHYcBSVW6PxXg+m0zNDQNOpsyw3cYIR9xyByEVgiVLRLHe4gbUJxwgInTrAVfgOq7K40r3k=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1772474556;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=97bHlU+UJl5b6VHD35KS5GbSCdGZGoXAKdHp4TR9mGw=;
	b=Mvl9mZEJRLQxcplTLteiLUOdr0LXDW+XEGE/Tbf+4IayXOMM788BWOWvvPL4+ZTr
	0WDPwHN0psFLfTLSZIH179mlFTQ0bOmyPDZ/x8PGjhry1TGN3GqnX3rxjdvLbdkkz+/
	39UvMCEWlOvKsgVV/JTEQGMEQRp97mWyFHw0nKis=
Received: by mx.zohomail.com with SMTPS id 1772474554846746.6820625080604;
	Mon, 2 Mar 2026 10:02:34 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: Performance regression in "update" hooks
In-Reply-To: <20260302175052.GA28275@coredump.intra.peff.net>
References: <aaU5lZwEuR4OrxCl@pks.im>
 <87bjh673o0.fsf@gentoo.mail-host-address-is-not-set>
 <874imy7220.fsf@collabora.com> <aaWeSu-d1FMz_sW8@pks.im>
 <20260302175052.GA28275@coredump.intra.peff.net>
Date: Mon, 02 Mar 2026 20:02:31 +0200
Message-ID: <87wlzu5cug.fsf@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ZohoMailClient: External

On Mon, 02 Mar 2026, Jeff King <peff@peff.net> wrote:
> On Mon, Mar 02, 2026 at 03:27:22PM +0100, Patrick Steinhardt wrote:
>
>> > > I don't have the benchmark setup and it might be easier for you to
>> > > confirm?
>> 
>> All you need is a normal development infra and hyperfine. The
>> benchmarking scripts in the repo I linked should then "just work" with
>> the above invocation.
>
> Thanks, these were very cool and easy to use.
>
> Looking at the patch, my guess was that the problem is that we are now
> setting up and tearing down the sideband muxer for each hook invocation.
> This is expensive for the "update" hook, since it fires once per ref.

I independently root caused it and came up with (mostly) the same fix,
so this is a very good confirmation, thanks!

Please wait for my patch because it needs fixing it 3 places, for 3
hooks which spin up/down no-op async threads. :)
