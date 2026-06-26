Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2103E35292A
	for <git@vger.kernel.org>; Fri, 26 Jun 2026 18:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782499827; cv=none; b=sxJTyUj4wpnCc2Fw1Htg5xRORaQBfeG967DUaNCBD5s2dq2ffOZFZHwGYcGH7YlzU1vfzHHq6qzTJt1visAS2sUpv119XMXPYvm9Bs9uR1MXYFW3i4cAvXJpn3c+upDHdkkrTPVbOwCFgnuANNwT6OPC/ObNglPzhcGKL1PpKus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782499827; c=relaxed/simple;
	bh=Y3wI9djBKmVsDQAUJUhp+Hg9H0iCfsDpgeqckThax/Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mSncTT3k/VH+FcyhI3JCMCuy1HZ1qNkuUIbGa9Z7aN2Vkvzl4L/nihGMTBQjpUIpZ/no6+9hhstYnunFqlrTh2pUnkqzntiP1IEIxaUJopR4qWS9VaDNlPQgGdWLcOHYJERywVJUE0N4IqX1Pa1ysjrCEthz8PF4VZiVAeQ+UK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WDZpdDx3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=R6gvczWE; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WDZpdDx3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R6gvczWE"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 52CDC1D00165;
	Fri, 26 Jun 2026 14:50:25 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Fri, 26 Jun 2026 14:50:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1782499825; x=1782586225; bh=fEv9GHWG8C
	/ihNcrJmJeQxjLL/wH75Lxjh66zmUFNDw=; b=WDZpdDx3ppNutVWo+i5ydlhKSY
	UQ+pOeF7wyCniyYe6EKDE3lyz44yazLKfAVJ+OUm3zk+aRBj6V1r8MQuvSNr5rrC
	WjKX0Jsq7U1ueq0l/rIldrYJiedipdaJFoDeDgfOSAD+9EtyGqyA+QAvaLMNkh1Y
	YRjXapZiul5mdN4lRM7IfMX4Hcv3CwNxaS0tFkoI8WyUHSZ+c/j7/iFKgE/hempb
	Qqc4wc+JmkI/SvY59RYMGGg5T/n5ZcOBaWQ6SeN/BxN+WnkTdUshf33RxMatbK4F
	TntWDzabVNuXp+NAclScaNvPoLcKtdjsGC8ZJilCfRDD6Weer+C3gQgiUcTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782499825; x=1782586225; bh=fEv9GHWG8C/ihNcrJmJeQxjLL/wH75Lxjh6
	6zmUFNDw=; b=R6gvczWEWOJ0FL8Mjlg0fZ0eHZzga68WoUfbQKDOuZAhwqJgn3p
	Rf144POcXO8pE2ZRolnbhRJ1xwTtWGLtlPZgRP/VyKk071e4j6AbmUTkzTojcL3f
	Cg5WTLDGxX+sLNjaME0sY1I+uVyy2MQqu91lGKjCHjThIWXvzlHenZXFmVx5dx3I
	1MzFkNJqx1myVbj+6ijGgLPw2439cR/qI+UFHbkp8gZGxClp55DvecvRl17m9N6r
	63f5R+U8QpG4el7AoWArVf3aoUP+DxfCiVUtwRM1bB9CSaLkj9B2HLqN1sj5CmEs
	DoOx0TTVj9p8xyrcLr1yZzXtnSIpdQPHZuQ==
X-ME-Sender: <xms:8Mk-ai59LzJo7MJ_if8pqBX8ulgWy5sQJt00zj1AWP49SqKeTZKLkg>
    <xme:8Mk-al6-AMhzIIW4no15B1cVPhHEK4k2zplxtHaIdQit9NgH-n27GqncAokmrRyOB
    _704ZI_fLB2Q1sYOYc56C_A3s6P5PhfOH69LivclYkPUt_DXPEOnw>
X-ME-Received: <xmr:8Mk-aoEQQP4-5dxaIuQ3zVY6JB-8sKJZsFANhkS_zrRxURX87Ito_JbZWM0grmAlALerHcKzdpcYkxhzJBALtucYIurriApE71XLbK0>
X-ME-Proxy-Cause: dmFkZTETRJuaHltPe0NRvf8ZmEHyvnJRNJAHkfq5mvE8xmXVCwOUKvEfXyOTo5opKTq0qK
    dSev8A9hmCJfuVCNg5+Gx5RUt+gJfL6nLRCrOfhuC395T0YKroonW4IYZmp7HHjHjXzwmO
    HqK1AzSY/YUQ20X9jpa73xqtENAAxcf/cvB7Qldl54vI5paLmZQnREE9FESnsy0K+oOt+S
    ipRxlnPIEDY2I9NOsB6KxDgQC+z1gLkbS7pwF36XxV1ijMTgC/fXg4Z/bLmX+Vkhv5kuzR
    9QivPTS5jlzzBmF7cjAw8QHUTr/LTIabLxTEBnuMFMr8sO5jbHR6XJCmo5GolssmbI91GY
    xP9Brjb/UWugyoW+AwyyTyz3L7gFtjDoAT/9P30u/yZ7+3vk8lmRaumlHwWQBV+gZojN0n
    fqLike07KMQHxx4dBqWdsdOJi/weyyquHbieKxRfAoZcRLF9wwssylm3c7fvIb/5RLtTHr
    5R7ANh2r5CvYy513auwBkdPNkM1Bn/+CM583pCqJD8FuFVt2sp/THMdidd8lzsggNrLaLh
    NHUyFNXZcFDnRRo8O1gsdNJNkTkGDEjaDpHvT707XMcsNeOcL82GbtWHPM+01aGnmFF7Gl
    pHaTy/lA1JU7stabF0SFVk5sVskHt6acY5Yiiu22k0ABwvY9Nk+e4Nhda0Bw
X-ME-Proxy: <xmx:8Mk-atXqvsUqUK7IinKo363MXdmnOvOWbDKWE2s0gMQnQa5o5M5GHg>
    <xmx:8Mk-akWrZG4pv0-oKn_c0wcQ_UR9ZIyRKSj1aDs5ThmcGn2EeYo6Aw>
    <xmx:8Mk-arLKDF-jU8TPyVwKv5OwsUCg26lVXjZBgbHR7PfjxheM6DQ65Q>
    <xmx:8Mk-asAOxLUYe9mB0Q136wJ2DqEe-riE9Uv2761dMxW90mRDmBpr1A>
    <xmx:8ck-aqOanPNVeE7cT7Cx0c2uVpgAq9G_S678yF-OVYpl5_WNcm4OZEjU>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 26 Jun 2026 14:50:23 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  "brian m.
 carlson" <sandals@crustytoothpaste.net>,  Elijah Newren
 <newren@gmail.com>,  Derrick Stolee <stolee@gmail.com>,  Phillip Wood
 <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH RFC v2 2/2] Move libgit.a sources into separate "lib/"
 directory
In-Reply-To: <32bb1cf6-1e37-dc0c-dfb2-e78a30763342@gmx.de> (Johannes
	Schindelin's message of "Fri, 26 Jun 2026 18:01:49 +0200 (CEST)")
References: <20260622-pks-libgit-in-subdir-v2-0-cb946c51ee7b@pks.im>
	<20260622-pks-libgit-in-subdir-v2-2-cb946c51ee7b@pks.im>
	<32bb1cf6-1e37-dc0c-dfb2-e78a30763342@gmx.de>
Date: Fri, 26 Jun 2026 11:50:22 -0700
Message-ID: <xmqqwlvl6sr5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> -        path: 'compat/vcbuild/vcpkg'
>> +        path: 'lib/compat/vcbuild/vcpkg'
>>      - name: download vcpkg artifacts
>>        uses: git-for-windows/get-azure-pipelines-artifact@v0
>>        with:
>
> Please also adopt:
>
> -- snip --
> From 1d09a51d426bd3592e4f4b0331f7715ab3b5d502 Mon Sep 17 00:00:00 2001
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> Date: Fri, 26 Jun 2026 14:39:19 +0200
> Subject: [PATCH] fixup??? Move libgit.a sources into separate "lib/" directory
>
> Turns out that there was one path that was forgotten to be adjusted.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  .github/workflows/main.yml | 1 +
>  1 file changed, 1 insertion(+)

Thanks.  Queued at the tip of the topic for now, but I trust Patrick
will include/squash it in the next iteration.

