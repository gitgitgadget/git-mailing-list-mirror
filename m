Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E956A38886D
	for <git@vger.kernel.org>; Sat, 27 Jun 2026 14:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782570452; cv=none; b=JtZ+w1mNYBqjBJZN6HM+UwEporV4aNtMLEGuuA+lmEBAuTub6KHllNdIh9//0mUeKbZSEhVyhQo+Re9hxd7nhzMe4oFI+vobF3dtSzTSOfd2c1sMin0b9/M9n4GTotr58ZOv+0GWusg2O5o9aSzztdyjP3+klqnDMNukst9kvMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782570452; c=relaxed/simple;
	bh=2WW3XT3GiNOJq71R5XW1dHL9eKY6VazH1yDMvTFW048=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nmOTA7hShEUw4Mg8/0+/O89oxoH8/CLqhrEtvLViA3kuAvD2SmE1sKomPsxsTTSiyTocqq75ycSbC2cgHNIm7uy71MPwJSp4IqSNfAfko9UZEofSHWnNmFBh1179t6rirBbqKvHmVT75VLfLUaFUwQt8qtwGkuCBVCaH6GxDRd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hQr1oDlJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XYQ8Msx3; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hQr1oDlJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XYQ8Msx3"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 30CFA140015E;
	Sat, 27 Jun 2026 10:27:30 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Sat, 27 Jun 2026 10:27:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1782570450;
	 x=1782656850; bh=3yMbqgYFREmIN2J7yRHEuRJvtPt6ZSrxdytO2wrJzj8=; b=
	hQr1oDlJFQ+7viZiY29P6dY7jVNdF26eavIv0A+jv2swPHhkrQ7WjlJG/0l09eRs
	c382vj/bahNqp4xIWGDF0XiXjWlGPX5rHwa5j+xcOvohHHwDVbw8p9NFJJQu2M8g
	1cUkPQH9GuRtSCnqA6gtuzRUUGy0YKX8OJlEv6gpYCBj2nJnRtFZW3TXmMcWaVGn
	tUFdgGzt6EeFTrv4FOHOJXKHc83pGgz86PqyiqXGH04WqwXnasrmBioCo+A/X7md
	hnThW264FX9jMj29M98MOuXR6oJS79/kOg8go4ZEtEmWLJ0rYNcvDix+R+KfHd7O
	DSOBfOzUTemdWZEtFyq8mg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782570450; x=
	1782656850; bh=3yMbqgYFREmIN2J7yRHEuRJvtPt6ZSrxdytO2wrJzj8=; b=X
	YQ8Msx3ox1A2xTe2NK7sUmGQ6/WbeLG+ULVIWsf12t/4EX8A+dwPvRJ6P1dweX02
	5/9rEcy+JxvaYD8aJQXlvszytlsn8+iTsEneF0KOqufBJqzsDoDlhxeaoCB2SdWV
	He4gr+Z07BHmuxD7ekDR/A+xASvBgrMT9AF57VdwuKauN6qfqGZrL8gmpMKPxpZ7
	xZ0bO6jxHj2uXgsBn1Mbt+RtgFIMASRw5BWRRPy1Xf+WQeFmI8QKi68Z0B9+srPv
	9P5Go4NPcWoc1na403faUDUyKoYvBhu6Da7B5Wyga9z2q9rGq3AjlNux1IcQTJkS
	rPMzMd54a6larabw2ihqA==
X-ME-Sender: <xms:0t0_ao0J7PeBNMjFz4nh_-IXJ7u40GEIE84XSKEa5iLzCoZGmDWTRA>
    <xme:0t0_ap-lPc9XZAwWwOcORJY1_8EqPBUR2kO-Lxw7m-hpvfLlYGa5B8bqz-1bbksxg
    -VDhE5FHsO7iEoTpd7KsHe7gLFStWHNDYNCvzZ_mWR0x6UDD2kO5Ek>
X-ME-Received: <xmr:0t0_apPxstMqNZcN5IK4MVujUOmEv8OGbDYkIefOgMwAV2C4N-bMSPGcqNHFnqrrgfPOuKL9PNd-bXmYM-zCq6gI2ROmQgz65jU-gAd_7pLPwXpsVwo6FVI>
X-ME-Proxy-Cause: dmFkZTF6jMacQbpz84b+B0ZAwAJs/bKjCTs5+pQ3Ubk08Kbo0qi+G3hpGU8IDmvDklPMB4
    ePFZNU16TSW5XcKoofiJ1AO34OvGKzX3pttl4qHWoITN4sxz+8tuxY6+hKJ2DrDoETTPn4
    Mqeclcldtwoyfr85Ym2q7Ua6Ng8gQnLmASpIVnkMt3R3ObwkxE4DWUsvuK70YPG4cjLfx5
    ka1G2AvOsTjZHA30FL5TpvJKHegvj3ZcNpwFioYFzDa9RGbPasn0Z1kJFoSzIpSuzaAdv0
    2wbeVxXUfQ92Af78Zlp5Xarc3BwH5oSF/ABJvvCu1hvzQ1G7w/bPt7fr0VMY1zeT4snBT/
    OAX5ZlkWCyLLe31dxJZaVTBApFENOVg9nGfO4vuY/RtC7Nis8OtcpjwLTbkZfJQCN5VzTg
    OQ5anNKCl/uPd4JVqmTtzbEqjF6yZO/YY+6I1IX5e72YrR20b/QS1sm90diePmdwv5TAoB
    EObYcI3/nufmrOsPbqyRov1fpmTPekgCIrODpKkoLLulXGiddqqJWKXZLG0scaShWrrjL2
    WpFEn4unUDZKt4DhTV0PjtTC9+rCi8WzZKhiWriMjlm8mTkVbK1H7j5hwRk//d545pbJWX
    FQbdjSl5wyYva2hFMI3zhK6zVL4WSWj/YN5eZtBMBLFD9AgFjGc0HhFwZ5Zg
X-ME-Proxy: <xmx:0t0_atcXYJv95zy3QcoAldvIo9DXWVeo3HxfWgwUKNYVAP3QLyI9zQ>
    <xmx:0t0_aoUNnx47eltfwzq5qPoLM2jui01jua4s-eQHhcMqdlCAvxq8-w>
    <xmx:0t0_aliZdsAbeYla7sHaeCydUi-B540khfIS7AkaJbji2QmTjUsImg>
    <xmx:0t0_an-inYNylk5FNcnCbe9QtVDiduKDDZNE5ysm4FpMT1NKg4dWCg>
    <xmx:0t0_assMY_qQGW4-XlDQETHhjntZKiFja7flYvH11OBusuQsNoIUmvoL>
Feedback-ID: ia13843cf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 27 Jun 2026 10:27:29 -0400 (EDT)
Date: Sat, 27 Jun 2026 10:27:28 -0400
From: Todd Zullinger <tmz@pobox.com>
To: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Michael Montalbo <mmontalbo@gmail.com>,
	Denton Liu <liu.denton@gmail.com>
Subject: Re: [PATCH] t3420-rebase-autostash: don't try to grep non-existing
 files
Message-ID: <20260627142728.0BU3FFok@teonanacatl.net>
References: <20211010172809.1472914-1-szeder.dev@gmail.com>
 <aj90x3DsER5HASUS@szeder.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aj90x3DsER5HASUS@szeder.dev>

SZEDER Gábor wrote:
> On Sun, Oct 10, 2021 at 07:28:09PM +0200, SZEDER Gábor wrote:
>> Several tests in 't3420-rebase-autostash.sh' start various rebase
>> processes that are expected to fail because of merge conflicts.  The
>> tests [1] checking that 'git rebase --quit' and autostash work
>> together as expected after such a failure then run '! grep ...' to
>> ensure that the dirty contents of the file is gone.  However, due to
>> the test repo's history and the choice of upstream branch that file
>> shouldn't exist in the conflicted state at all, and thus it shouldn't
>> exist after the subsequent 'git rebase --quit' either.  Consequently,
>> this 'grep' doesn't fail as expected, i.e. because it can't find the
>> dirty content, but instead it fails, because it can't open the file.
>> 
>> Thighten this check by using 'test_path_is_missing' instead, thereby
>> avoiding unexpected errors from 'grep' as well.

Thighten -> Tighten

-- 
Todd
