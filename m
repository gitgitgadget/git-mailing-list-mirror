Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253A03BB23
	for <git@vger.kernel.org>; Tue, 16 Apr 2024 16:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713283699; cv=none; b=Jhm/jKZP2gC//fhdDAzC0twv4Mqsp1iVpNSv5uwdnGPKBfcKq2vawu+KwSG8qjCZVki5CLudWkB+WgEjQFH5a6zsRb7LjToCCd+93FOPYAQy0IWn7f9yxEWnYoGrp85ivjFzFOy6WLnMiGDJaAws1EGIHGRfb7zZn6mqTJB/lhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713283699; c=relaxed/simple;
	bh=lv+KoRHZ4qI0gzKPdR3nCNypr0kgleQXCQgbgdoYzWw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Oyyw5Lza+W3FFyind1yVjxJxtnHQhDdpaFFJmFC7JnESixd/WGohVCYRA7nLuFZ1+Row+SgP9HbPoXYn6o+pzfEd/MJMO51N6JyK3ghDESs6x6OwIm+ZuiWh/6biPjE8bC3Yo7F+30l4crupgo65CoT2slR/hVEQnMc2wQtFM5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=jIiIFiw6; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="jIiIFiw6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1713283686; x=1713888486; i=l.s.r@web.de;
	bh=YYFY1kKlcjc1PjsLxOAgviZcCfusluH8/Naaw8D/4kc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=jIiIFiw61QNYMFb4veWi+Cg2ayhS+j+AV6geGwglm+gZrL7SiuBOGk8BSQzYwtO4
	 ca/g7IazOifqmDh3Gu0iNQOrE7Y4pjJgePFBQ5U++IZhO4ETZexV80hSYyVFkxzJF
	 nz5+0NEFjOhNWACpWVZZOzoTFd10hsjY68evXWL5S/rwGccVN+XU8JgT3HRIllKkO
	 L/clQqit3c8z44GgtZCokx6ukqnXCKfcmroyCqN37J3Hwphh3L3MbgzJYmUPI8VRC
	 2kD+W6NspyIGKXOF3A+TAXAZ+naR8Jgq3Kma69//orHLAdzsuAT7kQ/AZiztgnwfO
	 wDMEpOdGuMtQjXkPuQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.153.5]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MFJjZ-1rzEK71h2P-00FgsU; Tue, 16
 Apr 2024 18:08:06 +0200
Message-ID: <85047e64-044f-4bf8-8de9-33b082255f3e@web.de>
Date: Tue, 16 Apr 2024 18:08:05 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] imap-send: increase command size limit
To: Jeff King <peff@peff.net>
Cc: Git List <git@vger.kernel.org>
References: <7026075c-db4e-4d43-bbd1-d2edb52da9b7@web.de>
 <20240415185530.GB1709228@coredump.intra.peff.net>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <20240415185530.GB1709228@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dExiE0lm8yR2/R9fY2R3GQcCsbsBk1jLO7C6g0l2attvjFugzaE
 +vHsrnoHwLCfW7vg7I6z2/VeBfXTsw9XqZ0yWHOyfjhW1F7GEvQ8REaOfRbaTwIeM+tOpgM
 jlJQG9qtCAb5dN1H9dvarrL9bwpjQ5D3vy6yr5wdtCo6Q0ibcJfBAEC+6xfhsYYA7J8/rWD
 BqcrlLg5HE5lI3IRdYAGw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:zt/XDec+jdw=;d4ydMCgEA+5VYKE/Ni05FLc4pTS
 gM4up8vN529pG9yzV1tIMM+KQBXqvgMHXso/jtjLBiGWYT1UKUQi/r+HwxmZ7ckVOS7ztx1jV
 Kw9j/7xUwicK+O+ZOUfUsIUUuCKwPEUYzba6mDByvPmPWAjYqynWBFkkIuGfBt7T4vcCWlJbw
 k4ajgpD8mJ6+C9znIoy69VpUcsOJ5Uvdoo/d46EnPdqwR9cSExEF2N6ZOg2syJELnYU8LGPGG
 fx5GrL0crzUv5aozaFfOWj1kHFBfaGMgRwdY+DdQ2yODIQwLg5MCvqmUDEaP2M18lCKyd1tCq
 MXi6xOhb8dAO087FVqPlhXypn85HFhe7F18UXwWSjJ03gVfAe/TUv6Fh9zKQ7zAjjN4jWPrLq
 bFgs1bSuJ1dkfJQcj7glLt3uRN4t/5CVd+0TsPqhsPPkIqmY+Is1YsCwfv0dd6bDJBSmfRs38
 AIpTPyYK9PFSckrckpX5NzbsldhDifubntI3qtfpIRSU6wSAc+EEAmn5Ncc1x4+onWgvLZDux
 ixQ7rw3d/sCyXL//7cWZWjmBa5CbRuRKNbHw/isCn7dWyd1qjLOG6Nw6x6Ol4XpaqEBe39LB3
 v0r3nW+VPb7giP5F4tRt+fy9VZ/kmxC0l7L2+0IDYnn6p1vvwO+caVTQQuHbtlvdooc/8PTdX
 fHqb7p82jv5VVmW67STxpditfeMePNRwuDui1UsTklNGynoOAtyahZruIxXGENhxTnd7goT2y
 k03ZD4is4C8Qu1MFL1+HkUCwLEfsv4Hq3xvjf7xTKYbuqjIqgbgFrBFAhSFFUc3W0C/aLM6WJ
 VeSNgkIO2WMZL9RYKXrDUDWmDToLGpZlqbFgJewzt58TA=

Am 15.04.24 um 20:55 schrieb Jeff King:
> On Sun, Apr 14, 2024 at 06:47:52PM +0200, Ren=C3=A9 Scharfe wrote:
>
>> While 1KB is plenty for user names, passwords and mailbox names,
>> there's no point in limiting our commands like that.  Call xstrvfmt()
>> instead of open-coding it and use strbuf to format the command to
>> send, as we need its length.  Fail hard if it exceeds INT_MAX, because
>> socket_write() can't take more than that.
>
> Hmm. I applaud your attention to detail, but this INT_MAX thing is ugly.=
 ;)

It is.  I thought about using cast_size_t_to_int() instead, but decided
to preserve the original error message.

> Shouldn't socket_write() just use size_t / ssize_t?

Probably size_t.

> In particular, this made me wonder what we would do for larger items.
> Like, say, the actual message to be uploaded. And indeed, we use a
> strbuf to read in the messages and pass the whole buffer for each to
> socket_write(). So we'd possibly quietly truncate such a message.

Hmm, perhaps we should at least sprinkle in some more overflow checks?

> Fixing it is a little more complicated than switching to size_t, because
> the underlying SSL_write() uses an int. So we'd probably need some
> looping, similar to xwrite().

Or SSL_write_ex(), which takes and returns size_t.  It was added in
OpenSSL 1.1.1, which reached its end of life half a year ago.

https://www.openssl.org/docs/man1.1.1/man3/SSL_write.html
https://www.openssl.org/blog/blog/2023/03/28/1.1.1-EOL/

> In practice I doubt this is ever an issue. 2GB emails are not likely to
> be usable in general.

Tough.  Who likes to get multi-GB patches in their inbox?  Heard of
people exchanging CD images by email decades ago, though, so I
wouldn't rule this out totally.  Perhaps that's the last puzzle piece
to convert game studios to perform email reviews of asset-heavy
binary diffs? ;-)

> And I kind of doubt that this is a reasonable
> vector for attacks, since the inputs to imap-send would generally come
> from the user themselves (and certainly truncating the attack message is
> probably not that interesting, though I imagine one could convince
> write_in_full() to do an out-of-bounds read as a size_t becomes a
> negative int which becomes a large size_t again).

Right.  If you can get a user to upload more than 2GB of hostile data to
their mail server then you don't need to bother crafting an integer
overflow exploit.

Still, checking for overflow instead of truncating silently seems like a
good idea even for half-dead low-impact code.  #leftoverbits

Ren=C3=A9
