Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399751F192E
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 19:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791316665; cv=none; b=ERWXbOHz8h+gX6kVRPqeco/BQdeztK2Y4rja18Kl/lYDrgA2Vfwk2B5o/Dpz37tK92i0WhlpmB5pENHo5/wkRTdjYilOZ59a58iygWGq3Ue/5GYeogZ0a8HCIS3oovsK45EyJtpmSa4iXTpvIUGYGZWFkw4gpEXnVHCxTuiJC1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791316665; c=relaxed/simple;
	bh=DCSELAmPAKlOc0vaptQO4eNYiOZ4xbw0aCtnpU6uWg4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Rrd2bmR/2jZp/sgE2YMEEi/wEblLtvADa7wLWHYp/eClVKCRl12PIFyozRqZbGR/BziwyjGL791cm/6VZoEbJBuaysf3PkPY7BvNXEFOTsUDv3POGCYYhq7ylrNcLvHbz9zkQYwP1Zz2zSPGVfq69mykZAz33XUz8iJcozSP9PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=FOU/bIAh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ti+HqG8n; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="FOU/bIAh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ti+HqG8n"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 7FD851D000C5
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 15:57:43 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Tue, 06 Oct 2026 15:57:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791316663; x=1791403063; bh=utj+yXqe/w
	MiAgBRLrMy4Tc2pI3lUeUGsLHFxyJEInE=; b=FOU/bIAh9RNcEACJYcH146hPfw
	5qo4O9JuvHm3wavIkOE9lLqiTEMiOjKC6WOEKQeYUnlol0hPFObhh1X9cgPxpAUv
	RccU0GUWNqmz7btcWU52D7+zRiw2JPEjgjnURg9AScQXJ9xyeUtDXPk8lzN/+N9n
	u2R74NdJISehIWKtDjSEh8HC8yHP9tEU3DUZJ9iNoe7gsU5LonkMa8jrJXoT+A+y
	OUjii4fTPcxjSZTHxdtkdFHT9lX75DUfPFt0fq/8ATqX1Ak6swIXInzCAmgr2fcd
	kOE1xDSsGACEaFSLH2rGNat39pt/gJv+0R8+P/jtWBu9coNDiwoQDBaJsBcQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791316663; x=1791403063; bh=utj+yXqe/wMiAgBRLrMy4Tc2pI3lUeUGsLH
	FxyJEInE=; b=ti+HqG8nrOifQW/0BszKt92DgVGiGQ1wHwhXDfm6z2kluOHY3be
	eMPLllKhSUckSyBNakxLa7lzFZQOkUdkPubJFHoSLjY/aDTh2e4WxWZNGYfFfB81
	dZlM1nB/+a7DyYgF/L4aZHX1Rdz+ExgS8f920FTo3uJBSNfcbe9UWa2CpaVSE/mt
	07ZTHmJjy7CUr2xqsMrKfMjZzQn3L5uecArUx4F+lJ+hky8aqMCHYzKj5xzgVYuk
	DAbc3jIedSneiJV+iDFYjASEA5ah/jrtc4hlbSdwX988+OawiK41WrihOIaQD4td
	7hhxUSJnF1hHBlu47b12YhKuBD4N2WUTD3Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791316663; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:hAH1rjkxbXdcw7hEp72l2rjhOhedBRxZTNCy41UJdEV5RxT
	Sz09IT90ydK5V2QcEFjI+62ipJ87A/HyrjZRJKPDjJJ1YpqsIBGevgXPnAE67Zzr
	owvLt2Q3nMw7PmLPP3F/p35TZ2oRW1A4VUeb0Fk1VVA4FE4Vk7ppwmw338Qkh5X6
	mr4Jgi//zpyrNWW2G3DixF3yoLaGlTQtuTKM+zqyhILb5W5PPci/OFFJ1psVBN+d
	3po/Xgg166lLHh9b3rlyL8oPkwfsTT9FGdvuo90nNKS6Bs6feZZMyE6+tt7a3KD0
	P89vFf/+ckIQkJQrolliqNodlzaDGCOCRIkpDhg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:Fkt/60ePtgL53xgTGht47oX800OliZDt28v5AR7f+/Q=:DCSELAmPAKlOc0vaptQO4eNYiOZ4xbw0aCtnpU6uWg4=;
X-ME-Sender: <xms:t1LFajZ34ktvNX8W1JZL_wa_tvB-cPPj4OKS2z_Qd47yfmv3KpBGzw>
    <xme:t1LFakpKHX9piPQo5cpo6n_ecLzkbEhwNPXEqxe9ug4nKaTb5QoNLXfiQM_egfjEe
    WqyYRi_vzk6f6KIYXcBNb4yT6YqOGexFn6xyIgat9VwFrIBro645g>
X-ME-Received: <xmr:t1LFaoP5sgPqaBR7fwNtPxHiG8uemv7-I2rVkYXD8XQh47bHevkXBFhc_5kPyITcC3JNyKJJk5bot0xVwvYHhcL-IAwDFhEXzqvx>
X-ME-Proxy-Cause: dmFkZTGjMyLeS6PT5m+o0rsqJcbF4HDYJdHVMVdlng68d6z8evKG/vpzsj16e4h36z8ygm
    HAxDZWPhgQ7FFFCSpomnChbXWtbXXSbeUI9KYCWb4Ks4LTZsF4kMb3hEVEbtHVvvN1gH7l
    FHV4HbnA+mj9qGNJ+LLancP+iXcIsifNSqVKTub2FwVkWrwt1L31ft8iMwOvzEDJVV+0o3
    KxgfUyxv1gGaqnQw1rlS3beYOo1yJNONSUJHo4B1fZToRm5mTtetlpEnHjDD8o7bpXIxtz
    N8fKlt/c8bonY4LHOh0SogVuAd6g3TlHQ+3gaDlGzwqHFogI4CRenuzyljSth6P+sNiVTS
    +g8qrnqv/w7MxGcsWBH7aquyUf4bzr5o1YZek/Q1AfZ/U2lxkK5HcX66UT0/ozgZxvtpKG
    jCxdH0QlsSGlFgI/uQU4kDHML7r3FjM+KdfsPFpHHzDkGE7bC9rw6AX6TDuxBgP2yK8y0j
    Lx4aOGy9boTl8n7UebwXuhV6BbndpoUGwzsiq+LKJeH7Yogtly91KjCJ5ku4grXbrxmm+1
    39UPqU7PVe/GYxgfts2KreUP0UjXjQ/mt+BxPjr5xIufntyROt1Gr9E5fFzGw0eyhqZSFb
    1/ba+pHaBRG54fw7sVh1pvR/Owq3+ZyiYIN0VaZ5QrzV0FjJfFJv+plj8kaA
X-ME-Proxy: <xmx:t1LFavpc04yJXjZv9K6ULgx0EqOjA6RRkn-jv-UvHsg6yAg4l0drBQ>
    <xmx:t1LFatcGtKUUjXwmJQKbc45STByUykI4R6MSjdQmuSFmtix4tMI_pw>
    <xmx:t1LFalRzTV5zugzQ9Xyph4oUhMZEuqXNnI6SdjS1zwi5qRQ1i-362Q>
    <xmx:t1LFambu4VnwwqvWv1L52urVF57DPyMq-F3Q3GR4Q07mWq4OT50BXA>
    <xmx:t1LFaksdkZHvIkY_F6ehym8fXuVHbcX9BvcBBowPbip4JoNGXyBQeEE->
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Oct 2026 15:57:42 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Guillaume Chauvel <guillaume.chauvel@gmail.com>,
  Philippe Blain <levraiphilippeblain@gmail.com>,  "Mark C. Chu-Carroll"
 <markchucarroll@fastmail.com>,  Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 2/2] packfile: fix corruption due to stale delta base
 cache entries
In-Reply-To: <20261006-pks-packfile-stale-delta-base-cache-v2-2-69669a2fc6ce@pks.im>
	(Patrick Steinhardt's message of "Tue, 06 Oct 2026 12:20:15 +0200")
References: <20261006-pks-packfile-stale-delta-base-cache-v2-0-69669a2fc6ce@pks.im>
	<20261006-pks-packfile-stale-delta-base-cache-v2-2-69669a2fc6ce@pks.im>
Date: Tue, 06 Oct 2026 12:57:41 -0700
Message-ID: <xmqqse2id2kq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Note that the added test reliably reproduces the above bug on my machine
> that uses NixOS at c59305bab206 (cosmic-applets: add missing runtime
> dependency (#566040), 2026-10-01) with glibc 2.44-25. But as we rely on
> specific allocation behaviour of glibc it is very likely that the test
> will not work on other platforms.

In other words, the test will not detect the bug, when the fix is
reverted, unless the glibc allocator is used?

Adding an unreliable reproducer for a bug that is already fixed may
be of dubious value.  However, even if the test is unreliable (since
other allocators might hide the bug when the fix is reverted), it
may be OK as long as it catches the bug on widely used
configurations and does not trigger false positives.  On the other
hand, the earlier suggestion to write custom low-level code to
simulate a colliding allocation address somehow smells like a
maintenance burden to me.

Thanks.

