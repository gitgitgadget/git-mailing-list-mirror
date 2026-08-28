Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B403DA7DB
	for <git@vger.kernel.org>; Fri, 28 Aug 2026 20:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787950800; cv=none; b=XD68amWICDY9bF5geI9+/981OVX0VsITigUxrgmX2/BrICegZMNyKNUHbMVyaAIepz72GSseW7qNyPMC3XR8157OH1Wxw1My4bFJuKwX1Y4h+AHHnUlviAYh2wI0gg6+8UcAiObElzvyOGXjCEfBGD3dbN3k7FtF/ZyhZdlBJGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787950800; c=relaxed/simple;
	bh=h2aB1RgvwokHqH0ETk2g7GF7QLrvJIbiTZhIpfFM39U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=K5ryaqS9C3g3y9jd9c6P70BvEvD0OSbi1nUX9R3Kof9DPtVedVxqZ3Rr4R44FwpSAbUDoGdPPbTfpUwOh7qDISKvpYuykHt3WKoWRXQOmvZU9LQJsB9tiEwHdau3wO7mht7O2gt8Fk9RXS57FfEjVqm+x56Vcr1PeEokusbMJnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Ud56IHgl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IR5JO1bV; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ud56IHgl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IR5JO1bV"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 0ED411D00124;
	Fri, 28 Aug 2026 16:59:58 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Fri, 28 Aug 2026 16:59:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1787950797; x=1788037197; bh=MONItSSTBa
	av2Kn5t6ME6ltfQR7Q/IIGNuMr6u+Lz2Y=; b=Ud56IHglZQAkapJiZNNEwQFrzD
	N8q1T/3zEZcZxK0JGEBqsjdQlgl22HjSBLLQUSlkuKZMXn43/DEzXner3z7Ft2c1
	wL+8PUhIt/4KV1+xvqIU/XEdT6Dz73fIS+qz9jZvr4yErsqmXef/NZmLiuIh6xcg
	UAyGl19aL3uQbh1S2xbs+uNapP03GrvxLFeVGzWVVEpx3Bgmcx0o0vvaSQYJnXFv
	fu8L5pHwYxbViWkzSxQWmwRhkEzVt+U+SftLsZDdO6mug96Iv+WwhddpuAkwKsMn
	X+7TWBeXejgVhqITJWQRXB9B/Mtrtxys77BN3P9s/JcellWr/v/xmE0FVDPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787950797; x=1788037197; bh=MONItSSTBaav2Kn5t6ME6ltfQR7Q/IIGNuM
	r6u+Lz2Y=; b=IR5JO1bV/G7FPUg6sgiYltZKjaxkI9lt6EnXzKgA4kYULO6PrdT
	791BZpf91xM7aUVlyNMUXUjRpVZ3obAjffEJT74Pai2Mdcdiizhm0jtaq2yzo9j5
	X/k/MpS6h56ude4cvo88IHK3og+Bz/we3A5GlvcpTAODJKfa7YFIU47JrCCq/k1u
	IwHrXI/cURxip8OcN+BBsk1beQ6jHZXHmP3anUXE5FoN5n+EOIuH3bLICwgU0nof
	oh0gy6J3OAuXtlhg+QIhq91FLHzZxY83rDj8DcnRu7fgyToqt5yMfXYOocIXZcF0
	9EdSFKMdQupyJRPcucVN9DzfeF4xQZWbbRQ==
X-ME-Sender: <xms:zfaRaibf9fCw3igtlQluW1mt0ipeikBmXFkX1taGf0VnSToGB_3ozw>
    <xme:zfaRas0eBtzoAxcojUpwqsB2uOso_RwMGHAhgeG0khF6TgUUAn_k3G3CeIRXS2ZHm
    pQWwzA-g8H-TODgd67hsCfcb0r1T1YCmfWOyMoyle0T0OWdO2R1Vg>
X-ME-Received: <xmr:zfaRaqVTwY3RvmSQx0yhQw4acuqgj3Fa_eSS6UCYC77CN94M54PK09UkDYRMoAVyvm64F0KtRZoCIvnzTS_nd0ezSC6iMkRymQ>
X-ME-Proxy-Cause: dmFkZTEXjjRnNEyX33kGNbWrWTlVzymgif2Fx57PbRejXljt89TZyNTXGaoXqhfhajVvzU
    C2UnS8QTowjN1Hq4sToywEOxK+P5iRexWijtEpvsa0RdQJ9eXRIOOuuQKterGKueF51IGv
    tYSKbvQbGVRRgfMjF4+YkPGTNylBQzFeyHE1RQjsrjbSbQtkM9idODuCtwqGtllTmQoMoL
    7CthXyt7Rd3PPjSJyR05ZRUiSssMQ95MysXr4Z0ZQtISVFZKEVqndZ2ixUWRjIqt72uaMb
    PQjtKPVFNSEvIKWcOnF+3o0rrKBR6qyEgi+0AYm6RrVoCd3PKZ6kEa8rp8Bp5oG8AoH+nX
    +BXgNi/iIAOkm89ks6r/wyNXE7s4u7ADLCQvZpP/kzk0gT8RWzBkdK6fKLF9shoZMR/C+K
    SulzvE8fFVxAGYuk7J3cYX9vd82tFXuxUBYIE7HJQpDD1CrmTg6b9i8iXtz08wA0VEAWsu
    8gBwQG6K+4CivC2nPrmYoLGfBJjD+sCANtQYfVmwkMWxTNY/Hf/oMA/GZaVjPvMKmgsbCO
    8j4ZwDcgcF/Mqi6YHmg4d4BFFT99kg6SFW2PAc/Lw3ZlRjwWrSTE0w8kid9gLgPR+Oqo27
    9z5FqE6u2MmJc9irOq5rOOV/AWQFcDp3t52nlKeO8DMo+7HTGWtbhEr3gZ2Q
X-ME-Proxy: <xmx:zfaRauVeXSf6LpBPRsBP7uwSOeO5LMDBTbCpIXQ3l2309xBKIsVIJg>
    <xmx:zfaRahehgCEc5c4eOL2a6yzs21yamYghTW8dOIA6A8Nwzk5MGDIStw>
    <xmx:zfaRavXBRFLrBe7COC9HJCKy5-ZWA5EMfKhrINVUnhNgD1eNhVy4RA>
    <xmx:zfaRaie9N38dDT7FuQTIcgZ3z-kEY3THHrOLhNGjXE9Ux04OzRZo1A>
    <xmx:zfaRak1rlM7Q6xlPJ8bpYHL2s0L9WF2MGK0h0qSrpMwwZORSkHNPQgAC>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Aug 2026 16:59:57 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Hardik Kumar" <hardikxk@gmail.com>
Cc: <git@vger.kernel.org>
Subject: Re: [PATCH] do not pass "repo" to builtin commmand implementations
In-Reply-To: <DL0GH05O36T1.1J4TSL2PU73TO@gmail.com> (Hardik Kumar's message of
	"Fri, 28 Aug 2026 14:35:47 +0530")
References: <20260827-env-is_bare_repo-v1-1-aa99600dc213@gmail.com>
	<xmqqo6en8jof.fsf@gitster.g> <xmqqh5kf8hqc.fsf@gitster.g>
	<DKZZYSTLY6TX.2TDQEBBOG5IAV@gmail.com> <xmqq7blb8g04.fsf@gitster.g>
	<xmqqmru76ybk.fsf_-_@gitster.g> <DL0GH05O36T1.1J4TSL2PU73TO@gmail.com>
Date: Fri, 28 Aug 2026 13:59:55 -0700
Message-ID: <xmqq5x0u3qr8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Hardik Kumar" <hardikxk@gmail.com> writes:

> This would certainly help make it more obvious as not use the pointer
> parameter. But would you not consider to eventually move towards
> something more efiicient in the future?

It is unclear what kind of more efficient alternative you have in
mind.

The primary motivation for this change is to make the implementation
of built-in commands less error-prone and harder to abuse.  The
implementation of 'git foo' in cmd_foo() in builtin/foo.c performs
one-time initialization (such as calling git_config()) and
finalization that cannot be repeated, making it an anti-pattern to
call cmd_foo() from within cmd_bar().  Refraining from pretending
these functions can operate on an arbitrary caller-supplied
repository instance is one step toward preventing such misuse.

However, another motivation for this change is to encourage
developers who want to aid the libification effort to refactor code
out of cmd_foo() into reusable helper functions.  Instead of keeping
those helpers within builtin/foo.c, they can be moved to library
files outside the builtin/ directory and take a pointer to 'struct
repository'.

The top-level cmd_foo() can still access 'the_repository' directly
and orchestrate the execution of 'git foo' by passing a pointer to
these helper functions.  That way, more code becomes reusable.
