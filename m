Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249A1369985
	for <git@vger.kernel.org>; Tue,  4 Aug 2026 22:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785881633; cv=none; b=nhnfCuYyIpsiAmGabClvblSX9Jx0i/imTMwxJ0Wvhq7sqURrglSPRI6wJXzT/Ss19S17zLQGiNJyAac25CWSG3frf7h5EVvXp+p2j1wQORtWJnx8qi6PcB7sAQQXtwvGAkZFpNkRz+p7cLFk57VRUwUA2oNVtmDX0x3pvJhgYxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785881633; c=relaxed/simple;
	bh=+NNbZysyPdkMuo40g09iKf3ehG5ihN8bDwBA+4SiTzs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KdHHbRbzMEagZRR8rMucffK0r4j33mnsVbqmwHs7zNcQEBHJk1U07WtCHG0sumLjljqq0EIfgHFBOJ9XcH8JRWWC3WXDmd9GQ2pf9FLaVKADcXATKqsR11FIfUBKSghk22BHLNIDsC2qFngZZs9YIjkIzR5sxcmjxMtbepl92oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=fJncKpfR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TghmW5qa; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="fJncKpfR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TghmW5qa"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 48C04EC01E5;
	Tue,  4 Aug 2026 18:13:50 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Tue, 04 Aug 2026 18:13:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1785881630;
	 x=1785968030; bh=zbYi+h3+o/QohlEjATgPf+jEOcYr2bSyxVNYbkB31ic=; b=
	fJncKpfRw9uPnxw3wE8P9NRaGL0tlt9Dj9IitB8/ObbPPBmYNhRdotBgWTBThjSd
	Y8PUEszq9d/bKsdiCZVIqvz8wV8VDXV3F/H77tjCz5e0n+5ZV4ffMvkO/tlbA5xz
	RALBfjdpog53vkTMFmFdKDZqs+ehgB3LlJp30/hSk4dkXyU8V3LDn5JhUl/aVJRj
	6NZl3JNUcORQMQIvwd43vjZDhz37FS9VWREEoSPmAC7Gd2CaUWOVXmcSe3pf40ZX
	njsQZCcSHETQ6JzNzbHjiOzqRROCDYGTrZpyeDfGOkC9IHXfyuXxLlynCArjJe+R
	WqzDIMCw9k5eoawivFiWWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1785881630; x=
	1785968030; bh=zbYi+h3+o/QohlEjATgPf+jEOcYr2bSyxVNYbkB31ic=; b=T
	ghmW5qaQEw/TjUusj8za3W1gNbfRYnf2grBUH58aWLKPDYYDQffK6hBk80cK3JIc
	j8/jnXzOVD7uKREiNXguQbxCnvJttRV4rSvs3aVe+vN5W8D1LrtkKuf6aZXEtua9
	skkZVEcAw30eKYBkxgH+3Um/m31OnBdt5zgafeH4036pLM/POVK41aiY0Q72wlhA
	5h3Xu9ZktWQjYFU6fN8KRfBb7KOkdGJCKaj5isImqG24nZQFGiV/zdvk/KTGV4Ye
	eeKngDt3ne4/2aU8ZBepSCczC9XzUET6rflXyDTHjVUWH0qrRqbQ6cO1vOc2exUn
	WYZr+s06fd3Lkrs8467lw==
X-ME-Sender: <xms:HWRyasm20MrgaDYtcrzJNb3F1DxX7QT3ky4cP_1om5SZkCU4UW1pmQ>
    <xme:HWRyauZJFuF5m4yq5fe4aUYPqCqucFfTOsH0hrs3yvvViwp5z58nrJw0jzAezF4J0
    B34gqH5SgzLEb8HKtnrui9WIUOFUbEkzcsUbErRQCY95Avs00-VDDE>
X-ME-Received: <xmr:HWRyauTvB_iFeU322F3PGzLEfXXoH90N2uvzgpo-XHK8Ut6J1bfcMxXI3BNsbIpyOb7cHa7JEWEAa0Jd4wrpIJFpdjXa717nLQ>
X-ME-Proxy-Cause: dmFkZTE+a2HXRQbMK043dJE6DJzR/p4Usn2/uHQpbSfcObl15NuA4etMR4O3SWHbup7BaD
    IMR52DNKX+YSP+ciE64IDXvHERww1HXWx/AoA4/oBBHyNue4ZDbYuojF6GXdIftwLEyC6z
    l0HgnqRQ9Oz1h6S+ckSePwL3NWUWB3k1Lb0xZgku7kppHsy6Yb4C6HA4gVrzY9317Erw3M
    v+tmbrtK1IynMMTRHinUZ+eSBCT8ZPWd0qbIvjifBQ5KlcsEK8eaFtqF4Hwlo5gJSKsRa9
    HzeuL6FmP4RNX/Ugo4amdH7Zo8yODajhB/5B3Da2k/BZ5YWCgXoHClXl5Kmyd8Xckea0Lr
    EyJz3AkgDdBtpxBaBNUZBYFH5uXCEtVl4edkQvJ/mygJPFu5B1qkvkAo9YyN3FfnYGA86V
    +vpMwiZdzWfndqDLFg1ziDuhLuNeo2Th07trHVvIhm96KKkARCYxGfB72JYXFtlCvoEMOm
    W/aMfaYK6ubh1mxn6Y9L8GcXWqBKLdLRZ+UxORbgztsK3mHIAnPLUB65LhntjJeHIZYsiF
    Nnwp2lJaN3H9964C/N5ye4DVfro+zWHTuQtJwV7n68AGGhjYl0PEA7QN20gOaWcdUL00Jz
    hZRx0MQskCEFcZv7cMZNwGzSdxoLWCi+76oxKcHZALNquDfC3Xo2Xr+XXoAA
X-ME-Proxy: <xmx:HWRyaouxpKg9uy6b5bzDmy6VuJOv1D_bvSpHSj97vlE3ptLzzX4akg>
    <xmx:HWRyagGqRn3u6NlQnADyhLC5FJ5lCLOwGIO2QZrOJUtxTe1D74E-1A>
    <xmx:HWRyapz-YHwOQOkuADLAxpuCytFXp0ag8jzZrjgZMnQyt-OrHNlphA>
    <xmx:HWRyaq2M4-Kf2oKf85blNVHUHmZ4BqzCwhjQXj2WrL3au9D2pbI2pg>
    <xmx:HmRyaqwyHT75Zj0CulEOwiPSnsglffF9QE2TPRzFMYkhGZwnOUODLKn1>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Aug 2026 18:13:48 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Tamir Duberstein <tamird@gmail.com>,
Cc: Koji Nakamaru <koji.nakamaru@gree.net>,  git@vger.kernel.org,
    Paul Tarjan <github@paulisageek.com>,  Patrick Steinhardt <ps@pks.im>,
  Jeff King <peff@peff.net>,  Taylor Blau <me@ttaylorr.com>,  Johannes
 Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] fsmonitor: flush pending FSEvents before cookie wait
In-Reply-To: <CAOTNsDy4pKbPHdK1T688Ax6Mgz15K-qfZR-8fAvTk48z3E43Rg@mail.gmail.com>
	(Koji Nakamaru's message of "Fri, 24 Jul 2026 11:41:08 +0900")
References: <20260721-fsmonitor-darwin-cookie-flush-v1-1-357dc5e32040@gmail.com>
	<CAOTNsDy4pKbPHdK1T688Ax6Mgz15K-qfZR-8fAvTk48z3E43Rg@mail.gmail.com>
Date: Tue, 04 Aug 2026 15:13:47 -0700
Message-ID: <xmqq4ih9ttyc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Koji Nakamaru <koji.nakamaru@gree.net> writes:

> On Wed, Jul 22, 2026 at 6:05 AM Tamir Duberstein <tamird@gmail.com> wrote:
>>
>> 56cef9cb1a (fsmonitor: use pthread_cond_timedwait for cookie wait,
>> 2026-04-15) limits the cookie wait to one second so that a filesystem
>> which never delivers events cannot hang fsmonitor clients. A client that
>> times out receives a trivial response and scans the entire index.
>>
>> FSEvents can defer delivery while it batches notifications and does not
>> guarantee that its queue is drained in one latency interval. A loaded
>> macOS system can therefore time out even though the event stream is
>> working.
>> ...
>
> This patch is carefully designed to minimize any risks. To drain events,
> we could also call FSEventStreamFlushSync before acquiring main_lock in
> do_handle_client(), but this patch should be sufficient if it mitigates
> the issue. The commit message would be much more convincing if you also
> included benchmark results showing how many timeouts were reduced.

Tamir, just to say that it is my understanding that the ball is in
your court.  It hasn't been _too_ long since the exchange happened,
but we expect people to respond review comments (either positively
or negatively) and without such discourse a topic would not move
forward, so ...

Thanks.
