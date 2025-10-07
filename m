Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712A6E55A
	for <git@vger.kernel.org>; Tue,  7 Oct 2025 11:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759835614; cv=pass; b=rVFaq7SrHrlHVy/xsfMz3pD0xnKPmLoFcmA85BwJtmCqm/kqDAUhwoTNBbB51l01QNzW/kAV9xFtptaKllDLYOtikjA7cjxKtbeomJIevK5DSV9zQnQfJbLl1U0hRZoSdnpA4FEbvvmRC+EYbTqOv9MAEfLBCFoC9DE4vLBEoIc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759835614; c=relaxed/simple;
	bh=kw85vHn/2ud/UQs/t76BVB/7Pvhrx3o/aKgTlgolBU4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VRBGgbhcq7RW0eQo7c7Z64WXFpPhqzymqEuNt6tpTrrcrkFGbRkELaWUTD9hDF8uxJMd1Tn9XNHnuI+18NwPKwW4/a1tvZ8ry7tPu1zWZfRvk87yv+T/rESuKZvzPFJVyJQ4Jlqzh4n72hrxg2ZeuxZiEnzeXOdXxsXCaY6Dr1Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=itoaWNS/; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="itoaWNS/"
ARC-Seal: i=1; a=rsa-sha256; t=1759835589; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=e1FknFomDcAT3fK0wBQbdSMZMkAQkWV8raiOYI/NiJC5AFp4mF+x0vI4Pb2wtikSjXUoLqxwhCqJQUyUMy6VXEO2rQAlkUR5zkiGQklJqAOiCwt5jDRZZzap+QvkJVnxzSzMHcpRa9hx92GcQ7WhSU89YM4LkdwAsTeISSkQbA0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1759835589; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=RvZTX+ZVGMQlhjippMngUetV24QW81IPjTqHg2mGaTk=; 
	b=a7xmE+IM5+UQJyjmOmXxH3fSevvPCeYubLkvPplpqRtwjEXmYXF2j6xmWRs4N8kr/WbPNwXYZlE0GU0UlFcg5WNWcKfY8ZhDVuarN/sHF6RUQQeXMbLnW0WcyDKi+NsvxVBp19e5b1VHAvm0ohH5xO0g7xemQAfJ1j62V7sOIpc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1759835589;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=RvZTX+ZVGMQlhjippMngUetV24QW81IPjTqHg2mGaTk=;
	b=itoaWNS/aF9MIUXfzwFR/KQwK3dQnj86walXpMUELBh+L6IEHx52RL3WeW7cex3f
	EsMO0lzgU/ccxZjrqcI+DQhdtUu43RXUznce+ideyO9g6UIFSi4G39A9jiedcW2/Wyu
	DFvbLm6ny909vG6htKg+Seezh4KbJymoSvZ3yZB8=
Received: by mx.zohomail.com with SMTPS id 1759835587444982.1804024734927;
	Tue, 7 Oct 2025 04:13:07 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>, Rodrigo
 Damazio Bovendorp <rdamazio@google.com>, Jeff King <peff@peff.net>, Aaron
 Schrab <aaron@schrab.com>, Jonathan Nieder <jrnieder@gmail.com>, Patrick
 Steinhardt <ps@pks.im>, Josh Steadmon <steadmon@google.com>, Ben Knoble
 <ben.knoble@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v3 0/5] Encode submodule gitdir names to avoid conflicts
In-Reply-To: <xmqqo6qkq9vm.fsf@gitster.g>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
 <20251006112518.3764240-1-adrian.ratiu@collabora.com>
 <xmqqo6qkq9vm.fsf@gitster.g>
Date: Tue, 07 Oct 2025 14:13:00 +0300
Message-ID: <87frbv3qyr.fsf@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-ZohoMailClient: External

On Mon, 06 Oct 2025, Junio C Hamano <gitster@pobox.com> wrote:
> Adrian Ratiu <adrian.ratiu@collabora.com> writes: 
> 
>> Hello everyone, 
>> 
>> v3 is much simplified from v2, starting from the design idea 
>> that submodule gitdir name encoding is to be put behind an 
>> extensions.submoduleEncoding. 
> 
> This design decision to make it an extension makes a repository 
> with a new-style submodule incompatible with older Git, which 
> may not matter all that much unless you use third-party tools 
> that come with their own version of Git embedded (which by 
> definition can become stale). 
> 
> If you already have submodules creted under the original scheme, 
> then add a new submodule that needs this extension, do you 
> enable this new extension and write the new submodule under 
> encoded name, and move the existing submodules under their 
> encoded names? 

Excellent observation! We could do that (it's not being done in 
v3).

Currently any existing submodule gitdir names are left untouched 
and are used as-is (unencoded) after the extension is enabled.

It's been done like this for backwards compatibility, to eliminate 
any potential risk of breakage by having to move/update gitdirs, 
however maybe we've been overly cautious and we can attempt a 
"migration" once the extension is enabled, to move the submodule 
gitdirs.

> 
>> This allowed removal of the modules vs submodules directories 
>> split and simplified our logic quite a lot. Tests have been 
>> been squashed in the smaller commits as well. 
> 
> By this statement, I am guessing that the answer is yes?  That 
> would make it consistent.  The last thing we want here is the 
> code that needs to guess which ones are encoded and which ones 
> are not. 

No, not yet, though you do raise a fair point.

We could do a migration of existing gitdirs to the new encoding to 
ensure consistency when the extension is enabled.

This will simplify our logic and assumptions a lot, at the cost of 
the initial up-front migration.

Will do this in v4 if nobody has any objections.
