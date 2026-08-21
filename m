Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9171E25CC57
	for <git@vger.kernel.org>; Fri, 21 Aug 2026 03:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787283237; cv=none; b=orAd0PRUsN0KCq231E6yIRZN10zPStnAa+BM1F01RLdXLVY2cn5sMYS4juSuJSfW6mv1l8BIsfaLUVRfS/Jcvrt3T5a8J5EegJROv/+fUAPiaZ56PhYttf76jf592hkiWw9y9UbZb3rC2olrcHCg+7TCnFJUrHndelEqwvgzpFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787283237; c=relaxed/simple;
	bh=zFbegZdrYr/FQ33SX+6IbjMRJdyLIaziwd9QMOBD4FQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=F7NrE0UAfsPWwC9JCczXw1b7iNyvFCEeodQF3mEm51ZlBfO7pCl3FANk8NuhOO+ENm+clyd59nYYkI+kv2E9ZgUwrxbHqW9FVAGFBc3rjE3u4cjc1n9sjRBmicGplzmYVN3JLKSQQa1bxFUxU7v2PsHfz73Q+TURMX7c8HyWQmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=sklx3/j+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=H/VqqvZi; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="sklx3/j+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="H/VqqvZi"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id B5933EC000C;
	Thu, 20 Aug 2026 23:33:54 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Thu, 20 Aug 2026 23:33:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1787283234; x=1787369634; bh=kAXtU7gB/V
	hCnllUuFqJHsfT8B4e9MPwDyJeju7khWU=; b=sklx3/j+ElsjZQwKVcJDsRRW/Z
	N4hU5/2hX9fP9j8x9Rqz/++P8qTNiW44jFpvK7Q/w+0GVIQk7h6XIlVWoH9mkazh
	nBGGPBfGqIq9oqCPu+AW+gg6DgJcyx8LYOyp0IKLDUJWSoCtMNpLf+0Tbcn3DYJ/
	vjVIAIiR9ym/zxy3I6a7wE+vf9pRmnXbs5ZfbdwcLogP6UylhJ2PodFFrPrf0djH
	qSl/+6gfGMMS206uYBCKeJwashhMS9ZgTpOBXh/wmk14yOgMtGcZhbcnKvqysE0E
	H088SzssQK51ANaW+Hfmje7h/e9kPkQtWGKlntOddgq3VHxtXGcvAIQjtgcA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787283234; x=1787369634; bh=kAXtU7gB/VhCnllUuFqJHsfT8B4e9MPwDyJ
	eju7khWU=; b=H/VqqvZidDj525WAFijM+4cKMXGEyhM4oru8lZbZ1WYi3lorEcc
	Q3S2Rlul5yKZ98PpKXYrjaua2a/UR4UGFPxjvVd8tKdKGAM6PdC9vj/B7YkvhjdI
	kGZpZ7KPIGdLli3PIfYU5jRrhWAbFykYwyCeFYC0nHsm2+MYevVemIaUaiDXqoGB
	lbdAN7rh11lBsiHy4kbqqRxx5UWUCxxEVDDlKXdShzklRS3WGGBbQ2tu/FBaRkHX
	J1m0cgvtrXCjOrJe8MsHpa8nehiG/4D+K/OEf51I8rC+Vd4ga/CB2uqyb+2RYPDp
	L8DAMM1ygMvZgzlGdDLxb1SJF/Dh4OZvSCw==
X-ME-Sender: <xms:IseHav5BoIowPE-CjqEptj-D2cUVvXRCr6W-Y8011wy0LhG1K3JNbQ>
    <xme:IseHar4N3X5R9-qCF6Ay42NE7V-zCs4v45WrjrYa9CWw3nVkPe4_2ArrvuRNk5Af-
    V1a0EqlpVbL66XOJnG7DQyP9is7m3XVrQqTwTEz7NXbB2q42GV_EOg>
X-ME-Received: <xmr:IseHarebiXu3bNlpIMTjV8c0VG52JeKGGOx9FZ8hoF64l67H6W5dvosFgAT6pbQvtb0-lj5efwngobmqxp4rE7lx_IwNT60KDw>
X-ME-Proxy-Cause: dmFkZTFZ4VOPRYAGPpUjIsEXPA201LXcLpSuyUrzoM385tK6gjkNvR0jgr87TS7+Tb8cDK
    ryAPcDqY9Z/oXzCdolShvgP1B5hLFPtKr6Lf9Q/IFwNdOQ0t04pssXx5r05Vj5NB9WxQlB
    MLGo15OwFa3JLrzgFIvM5N5JjIPp3GOjnaX3IM0m2b+g1khDvhQgS2hi7w52Te/mvDnAMO
    pqnX/SeW+toiOgEj8uC9KQKmLaIHDi/WCOgeWytiJ94aIsxd8p6114T13nUZSxW5Ul0C9j
    tSqED8U2+24YQ2lutnqiN+fjGEtsZ/kwSIV63lozWAfrurOWJYhIQu1RBCLyhGZ3cGNbZq
    Jhaiz9Ntvxq7VQUKseGGSjhh2r3/HKW3Qta10Tu4b+GL1JwG4Mmx3fuiozS1RGha8iHhKQ
    GIeZVDb8kVL1m8C4VyMVtaGcE7fOAtpjlQM/Ra10+YYBaRcfmJ9lIzCUzQxHFHCfPR0lKg
    HvTrrBslZC3vz9UP07NhSza/nHOzzUuAtpgT6rwJc7VpXcJS6pPApKrxQSUTItKUqO9NCt
    NZG90txhtzDEwtEveJNE7TrkHAhz6kP957kf9ueYEKGVE0Df3x+2+3hCNvFfAnLMEHUt/9
    E684g4Lc3mVl1fEBJqQPv2S48TBwnJ4cjUapmtpXSJmKMyM0Oyd+gKwcxh3g
X-ME-Proxy: <xmx:IseHavDEUVO2S-9KI4shgcSKmTd1Yk53St0shWAp6Y_EKuYQTH7MvQ>
    <xmx:IseHau-vQUvDUXWAAxE7APuXbXTNHJJfFwqEoM6JLuvS9dgw_HzGhA>
    <xmx:IseHaqLw8s8KW8jtrwaK4zBjqcUF29S0u7AglQ-wSWcHpcOPlnkICw>
    <xmx:IseHangU5adJRf8HZlNXkzFhEpDpZj3sdGcFcsIEbn9gW96Y6M5Hsw>
    <xmx:IseHapLgy2gtGq3FARxKKBHW2ej-7j3cdlyt9IkWcbL8Pr3mMQ0Lu0X5>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Aug 2026 23:33:54 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: friel@openai.com,  git@vger.kernel.org
Subject: Re: [PATCH v2] pack-objects: trace pack bytes written
In-Reply-To: <20260821004739.GA297273@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 20 Aug 2026 20:47:39 -0400")
References: <20260817233914.8740-2-friel@openai.com>
	<xmqqo6f02q2f.fsf@gitster.g>
	<c6a8cdac36d2202055d637ebcc97e484122cdcd4.1787158152.git.friel@openai.com>
	<20260821004739.GA297273@coredump.intra.peff.net>
Date: Thu, 20 Aug 2026 20:33:53 -0700
Message-ID: <xmqqlda0rvtq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> On Wed, Aug 19, 2026 at 04:28:10PM -0700, friel@openai.com wrote:
>
>> From: Friel <friel@openai.com>
>> 
>> We want to measure how compression settings affect push performance on
>> the client. Different settings can produce different-sized packs from
>> the same objects. Trace2 records the object count, but we also need the
>> pack size to compare those settings.
>> 
>> Add a write_pack_file/wrote_bytes Trace2 datum alongside
>> write_pack_file/wrote. Count packs written to stdout or disk, including
>> each pack's header and trailing checksum. When pack.packSizeLimit splits
>> the output, report the sum of the pack sizes.
>> 
>> Signed-off-by: Friel <friel@openai.com>
>> ---
>> Junio, you're right. Updating bytes_written before finalization is
>> equivalent. I've dropped pack_bytes; everything else is unchanged.
>> Thanks.
>
> The downthread discussion went pretty far off-topic, so for those who do
> not want to read it, the summary is: this patch looks good to me. ;)

It looks good to me, too.  Thanks, all.
