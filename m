Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6FA72E0B64
	for <git@vger.kernel.org>; Tue,  7 Oct 2025 14:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759846268; cv=pass; b=DseZNFZ5kR7P6KtrQ/5Vcd3xq71pK6vRU7efD2y2RyoiZ+gX62o/Gqd/JP2zDNv/Z2Xi2L9QK6lJeB3ryUX7M80Bvlcxxdt8k7kXc+Ncy20g7qoKcuh4WK6EKBjqED925N7qCKTA7Rz8720T9+Ben5KLosZBEPPGfwMv+fmdDF4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759846268; c=relaxed/simple;
	bh=IrVApObphi8IGWDW1Sxbm97d5XeViqHo5LnXnWCyZiY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=m8EBnp5mxinGE+KHDb+pw/QDmcti//mcFv4oyxeCWmarLiGUu0V5AQZWlELs9H8Bem2xwh5dsr8O9rWdoU1eCY5DqkQZQMSDuYATG8yrWDddF3gVZ6EbmgoXCBHZfGHOAlnK+EOMphACD30I/7OxQvpM4E9s/JNmksOVTkxqnI0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=YmA42P4m; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="YmA42P4m"
ARC-Seal: i=1; a=rsa-sha256; t=1759846248; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=W/c6aa6H6drhKBUPbkaITClfT0iswbMselRHttK0ND+KCfYZle0XnfNczPOvk4ooxftVZ/K6wQl1siUk4i2ikcetOaH4GtjCpy64D3prC9DrTAqDLD1UCrPxZ1dnHiM5zwRzDT+Hnxp+0dKf5Vq/VFRABItcExel1+wkOEZrO0o=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1759846248; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=I/52MjzNpHNYjz9kcos+0owsOooWb+p2pmu9kMhzH6E=; 
	b=YjI7Mr/GvDvFwx9nG6MR8mM88ONawBfmmAjrFjTd5YumIAjBaCNuy1iW4fTFfT6qzsQPgXgIZrN9e9vT/1PXk+hu+xDotCYr7m71K1po0R7elOsmIy2eCpmJWF5qs+QMq6bq6TTrvkPvN/qz21ZqEAYNi8mlbi4K1R43MUIdMn8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1759846248;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=I/52MjzNpHNYjz9kcos+0owsOooWb+p2pmu9kMhzH6E=;
	b=YmA42P4m84114dE9KeYzTwGjixE7ChwfBwj5CQc+t8Hrf0iF3Kv3l9XASWhRMkha
	eCTzVVrJ+BtNNl7TEKLQw9AeJEsy0eiP/lTxZu3miEdNPNKJ+SvqmAC3UDqzTjur2pB
	oSFBPlEShkUaSkwwKQR+r/ESLu0xoW4bgx+o/jtY=
Received: by mx.zohomail.com with SMTPS id 1759846244319567.1119545118552;
	Tue, 7 Oct 2025 07:10:44 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>, Rodrigo
 Damazio Bovendorp <rdamazio@google.com>, Jeff King <peff@peff.net>, Aaron
 Schrab <aaron@schrab.com>, Jonathan Nieder <jrnieder@gmail.com>, Patrick
 Steinhardt <ps@pks.im>, Josh Steadmon <steadmon@google.com>, Ben Knoble
 <ben.knoble@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v3 4/5] submodule: encode gitdir paths to avoid conflicts
In-Reply-To: <xmqq347wq87s.fsf@gitster.g>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
 <20251006112518.3764240-1-adrian.ratiu@collabora.com>
 <20251006112518.3764240-5-adrian.ratiu@collabora.com>
 <xmqq347wq87s.fsf@gitster.g>
Date: Tue, 07 Oct 2025 17:10:39 +0300
Message-ID: <87cy6y4xb4.fsf@collabora.com>
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
>> A custom encoding can become unnecessarily complex, while 
>> url-encoding is relatively well-known, however it needs some 
>> extending to support case insensitive filesystems, hence why A 
>> is encoded as _a, B as _b and so on. 
> 
> Why 'A' cannot be encoded as %41 while encodign 'a' as %61?  Are 
> there case insensitive filesystems that cannot see the 
> difference between %41 and %61?  And they would not collide with 
> COM: and other anomalies, would they? 

That is correct.

The only reason I chose A -> _a and so on is because it was 
suggested in the initial thread from 8+ years ago when people 
discussed creating a custom encoding, but we can use anything 
else.

I will percent encode the upper case by modifying 
is_rfc3986_unreserved().
 
>> For now url-encoding is the only option, however in the future 
>> we may add alternatives (other encodings, hashes or even 
>> hash_name). 
> 
> Let's not say "For now". 
> 
> Choose a single encoding that we can use forever so that we do 
> not have to upgrade extensions.encodeSubmoduleName with suffixes 
> like extensions.encodeSubmoduleNamev2, 
> extensions.encodeSubmoduleNamev3, etc. to cover our earlier 
> mistakes and force renaming on users. 

Understood. Will drop that idea.
