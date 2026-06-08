Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33EF36680F
	for <git@vger.kernel.org>; Mon,  8 Jun 2026 11:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780919797; cv=none; b=BwLVeAuGePknuhcs3nAs4NTQC3Dyh4N+YLS+4EXwGV5tG8CtQbdc8BbsVOumwkCpuYUbOAKpVwiVFsCeLhrcWDVoI51DZAntZGl1cytd+BAr0XRn3TPIf/3z3gSVk+/Ctg+nDbqhJsFABUH4HWoXl7EM5Usuo2VwGuEHZ/lKfe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780919797; c=relaxed/simple;
	bh=9fOomeN9BFTLbpsUl0U2/nf3zl0+y8bGYI+86QPmZ28=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Y2WLhWB+NYpUiLkHOOyuuye3abPmuMmlBPIp4oxIWl+lr8XxHzpEZdfA/27AqpNRjZQas0g1eBQyj3G11m3JujeGLB9DgCzXms2gbRdqkw5J4aVEtagCBe7ESKdQjw8w5qhMcBqqwwohd2JnTmfVOe4UD4TfAD1bJzw6D3gxN4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=oUOudK4l; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=K9NNoX63; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="oUOudK4l";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="K9NNoX63"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 0CF2BEC01F1;
	Mon,  8 Jun 2026 07:56:35 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Mon, 08 Jun 2026 07:56:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1780919795;
	 x=1781006195; bh=0BUhBQm4u3Ew5GBR1X+wbVaNey8vsMcLitNwamMgJSQ=; b=
	oUOudK4lhuaLiJYQDFkybPWCXME+JQI2El8O7SS1SXSvpyV0SwcXHRDvsuMT0K8p
	492riyIlt1ny7Ho8XmoMxf23WPkDMppl0C0JfF6lp8reA43I1ZlyIbHzIUmodF0c
	9x64T+BcOFNCpgYdBA7xcPA5CBp7HIn5tPLqC5e13hoigAbKO+FgQs/9lR1noQnh
	U7xyhrzl+S/dpXYMJ+91vR8W56+9ear0fkxY1BgA3vKSmcNd28ZLJu6vaywlVzyP
	OlxUqQf4D4/5pBQu++w1j7EbKLlTWq96cYY7Fr6YKZtboiDj60FL32hUyS6rYOzJ
	3ht0hUZ2rmZzbsxdgjflUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780919795; x=
	1781006195; bh=0BUhBQm4u3Ew5GBR1X+wbVaNey8vsMcLitNwamMgJSQ=; b=K
	9NNoX63Cxi/8MDzexqLBDQiaQYQNp9oc+YtYltjGOAVqgYypEbdQeXgBcUmlEf2T
	LAXGIzpfZKPr/dprvk4+VwXI5uuhUy2v/Q8d6rgsYh8mFewbpkYVFmCMdx6isGnn
	L1KKvXgOqDp8PhiYPXeNQ2k/x3iEL7mBK283eOyOEshjYDrtwwBbvjB+2MzSsGqR
	2jjhTgLT3uc4S3f7txzeAvnw0L8NjRVZF6Ff+yKXBgVZgx4HSIxwcONmYJdk4D04
	32sMhqWDLBGju/TDk0nCY4H8aQvRhaXWIv4mPY7NwebM3WPbxSFYZLzqWPQJHMO2
	hC0sSiI5rE1GUUy4IejjA==
X-ME-Sender: <xms:8q0mal2erW0ujovu-4PCYH8wHY04wUS0cP5ZNpCO6T4tZhFrlYPs8g>
    <xme:8q0mai_iHG4nsqe0W72J8wBDOhb_8zrhEvCBkjgxTirgbppRincSfZHovTgYzizM1
    uXI0s81X6I7f7egzvkqjUiuE295Qp6ViiGapTwMc9LnbgWpKnlQlg>
X-ME-Received: <xmr:8q0mauMa6b2kCZH1KxO0Xcxhbx7PlJW8Fyi-n7OcOl0NeLOHDaOrjX5HALriZVLK9OL9BF6cFsHGVC5rgyQdBUEyaR8TlH4UT-On>
X-ME-Proxy-Cause: dmFkZTFw2qB97aQ0GsxtnccuzTfOaaC37KDSSKCZNbxB83kpKjh/Ik6Dq5gr8yUM/4NGhA
    29lZ6wMQOzfm0bwuXipd4UgM7K6eCrzGmB1p5V1B6QX2lu4YOlWrdK0Fb0BWEuv/VlMF0k
    /Hyl4POrZM1ANdEp5ty02Zpf7qNeZXc3LltG0eYDgYfsQNC6yGQSqmXI2xO084chhZVY+0
    zBAz5CiX00VrN8NxeTUhATcqd9e6RHCJKfIoq8r3v/VQn76qAjg0ceqV9szvnN9NdmtSk6
    x5gp6iokRT93pHKfETpXOy79uYp98SWAW5Tsq9F5fWC8kxJN6mPNQqtIaj3j7xf0ojICQF
    NhUNFIO2CPy7TXAn8+reVFa8DF44rf6HcYUOFvFzrClErNO+UfLdcQrxFeJO+joaohfEmh
    2DA5KlcGx6IAI5Qqhp8wUGOun+YN4DSDv7CeDsUcPvcKO6gDAAV89S0YiP9dbDXHcjdH6Q
    5PPBirOmKsQN69dWgG7EYty/PPvTA7uqWycsgHM+isOcRSY1RNjd2xdzur32S9q3ttv73j
    SIX6Akuv2SKyGOtdOADQ8KT62kR+QqZ7uS0eYDhXz/LZRbbIUagmC4d6G+j0PffHclBs91
    G8SDkhfoQj2/OP5wZZapCxJ1m0sCLF2wvdMiAIvdr56dUKgZ3IUpfw+qudGQ
X-ME-Proxy: <xmx:8q0maueOTXMirH1jT_xO9iq4p8lSGokm_yPlnsuZXzMCS26AF73Lug>
    <xmx:8q0malUfcwpxpui4eEudzRfJf1YjdH2c3iFHrFfWgPGKupOCyRe93w>
    <xmx:8q0maugOg30fBZyVaPurxJzE2i8wLZM1xTj6tANaxOnh8gyJ7OgKug>
    <xmx:8q0mas8QS3Q4VLbD9-wjR80dNE9xAu-xUphne9OLF1mlenqoi3HH6Q>
    <xmx:860masAdPopY4XDGt4ePnF8JlDwXbt5Wio4egcS6dgu2CXo6I5Uyztm_>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Jun 2026 07:56:34 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc: Kristofer Karlsson <krka@spotify.com>,  Kristofer Karlsson via
 GitGitGadget <gitgitgadget@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH v2] prio-queue: use cascade-down for faster extract-min
In-Reply-To: <1aa5b755-0f74-46d5-bd6e-a9cb7f3fbb12@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
	message of "Sun, 7 Jun 2026 09:30:39 +0200")
References: <pull.2132.git.1780250236304.gitgitgadget@gmail.com>
	<pull.2132.v2.git.1780301856444.gitgitgadget@gmail.com>
	<90270818-c52b-4611-8da2-6cee20628fc2@web.de>
	<CAL71e4Ob-B5MJ5DPY+_tzpj6nyrbQ5WutxED2T93SWJV6kJGPA@mail.gmail.com>
	<CAL71e4PV-1aDvn1JnweMa3OR1xxB75fWjzJOBvM54KOWqC0stw@mail.gmail.com>
	<1aa5b755-0f74-46d5-bd6e-a9cb7f3fbb12@web.de>
Date: Mon, 08 Jun 2026 04:56:33 -0700
Message-ID: <xmqq4ijd1c0e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

René Scharfe <l.s.r@web.de> writes:

> I think I mostly understand it now: cascade is better in prio_queue_get()
> because the sift-down item is from the bottom and will likely end up back
> at the bottom, just of a different branch of the heap.  Thus a sift-down
> costs 3 compares times the number of levels, while a cascade costs just
> 2 compares times the number of levels and there is likely little to no
> need to sift it back up.
>
> For prio_queue_replace() we sift down a random item, though; we don't
> know where it will end up.  If it belongs at the very top then sift-down
> just needs 3 compares, while cascade needs 2 compares times the number
> of levels to bring the hole down and the same to bring the item up.

An excellent observation, showing clear and analytic mind.  This is
one of the reasons why I love reading review messages from you (and
also explanation in the proposed commit log messages in your
patches).

Thanks.
