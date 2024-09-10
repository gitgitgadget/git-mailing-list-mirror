Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6812FB6
	for <git@vger.kernel.org>; Tue, 10 Sep 2024 02:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725934979; cv=none; b=T7zYrB71fQjYCGruVEzzYXk620gFlvWw446eQJeLIo6JSm5mbgeNCKFLBVTYIGCi7RCrx8bp08AkyfqVq+yfv4/hVXLNd3qa0hSSktLhyt7ic8YJLOzSTR/KfZncYLdGyIwYIYOQpoPk6m/CTTPQiSfgaSce+gskto1atN1IOng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725934979; c=relaxed/simple;
	bh=E5ZAXcIEPwDBENYkpQT7Ns96gDl/6NgzjiAcS4N5WGs=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=kWnlCBZC7mMKrS3LuHzJXeWEzruIHU1oxrJiQ1kbIXLcr8XI2ZQZQgB+IXEqpOwIshl5FcGVfQ4sj8Vbq9DGKytjWcclyfDRLzXVfIMcv3eh5FO6fZ5BzLSAqAlPbSDFbUFLjQI5AL6zfPJIieaMQ2PyAkL1EPxRpZNvQqT5Vfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alchemists.io; spf=pass smtp.mailfrom=alchemists.io; dkim=pass (2048-bit key) header.d=alchemists.io header.i=@alchemists.io header.b=1hoiU5Rl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pv+7jzZv; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alchemists.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alchemists.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alchemists.io header.i=@alchemists.io header.b="1hoiU5Rl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pv+7jzZv"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id DE0521380142;
	Mon,  9 Sep 2024 22:22:54 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 09 Sep 2024 22:22:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alchemists.io;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1725934974; x=1726021374; bh=YvCi3jB3x0hyv2fRx10Ri6cDkQbFQe+I
	94Kpl6EdrPw=; b=1hoiU5RlVF1pswBKJj/xtX/5DN3j05EZ3mvJVeKlRQoqlIEO
	FJXkSrKOELPB2Qh6Jbj7hLZngO0dLRvm36YCFzyPWNQTIHSiJ/4LbFdaXckc0nSn
	4k8QU16ItSwOMF1/fx6U0YpV88fVzoCxQL5msBCSuW7oP72rWfoTTK9jg+ByqjVD
	DmDBGlScTsYRFJV6tv0DnNW4TVGeWhcH/2pep8nuq5C9mLmvVGwGlDFCJZ6NqNhc
	QZoWFJhomX2/eG/be1xTpw2+mDMRjIcd5pCkzbCYIEniFa/5bHrn6dQB9yv28YEw
	MXm3g9GCi6KADkhPY63EMkQdaOgU17o2ZmAKkA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1725934974; x=
	1726021374; bh=YvCi3jB3x0hyv2fRx10Ri6cDkQbFQe+I94Kpl6EdrPw=; b=p
	v+7jzZvCtBC0Vi46xQg9cXtPgDUjlDgn/iZwJ6qh7KiQv9YMgcmP/14O+92Vh4C2
	4fM+a7A6q0CgDhZ7CSV4oNziIhU+Iyq6XWF6czL0lwOak3rWv82/gZjqyPyt9wvw
	o+AaYKnRzRDmb3i16YdBOlpgoLs0IyzKsLQ2BL/z5XB5eFnEhcsgLS13CAgtmAya
	B1bDyBpUAyeGrzGlGcJWT1VHlnT5INgGohPRCuU4aKNdTURUflLinvmNx9Dn6klV
	hdRQffKyEevayuZ1k61A3U/zUqI+KUXMZZE//piBo4d1Grk0Unn9/D3JVZQ7haOD
	gYmkWx9vpTD+A+nV+Zdlw==
X-ME-Sender: <xms:fq3fZu3ngfk_Yu-rT6mrKR0eBU07QLbyxEiDuRThD2NfcAP7cZnnSg>
    <xme:fq3fZhHKII8qEIGpxDNL6qyr7jKyJ7KKggBz4shzifry1XD9-kP-DTPdxTxKhoJom
    pQi1zy10WqtBAYf>
X-ME-Received: <xmr:fq3fZm6njWM--H_GRhLYp1L7VSfvOOOhomVn13kiqLzOYFuCIPrFJHKEPPwfgNaKeB-9>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudeikedgheejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpegtggfuhf
    gjffevgffkfhfvofesthhqmhdthhdtjeenucfhrhhomhepuehrohhokhgvucfmuhhhlhhm
    rghnnhcuoegsrhhoohhkvgesrghltghhvghmihhsthhsrdhioheqnecuggftrfgrthhtvg
    hrnhepleevieffgeevgfeileduveeuudekhffgteegvdefhfehhfevffdvffdugfehtedv
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghroh
    hokhgvsegrlhgthhgvmhhishhtshdrihhopdhnsggprhgtphhtthhopedvpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:fq3fZv2JCKr52GYVmmykRpBDPnyv84SAwushHKTTKINu3ejYZJom2Q>
    <xmx:fq3fZhHTG-kHYfykbil81BE4SsCyNLlTP6X8twdsv6FUqbr6Lm9tWw>
    <xmx:fq3fZo_ADBMPU5oe3BDvMbzsFwA4TBKad94Mpaq2jJRmmnNqvGc9Uw>
    <xmx:fq3fZmkI4Ilx4qE9nHPTTLyiG7hrwBl76nZZto2afKl6Qjrk3VIVVw>
    <xmx:fq3fZmTR7SGVlm7KW0xxiJAXBorvNfn8DnPRrtY0Ye5KR1uMtGXRiB8Z>
Feedback-ID: i78e840cc:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Sep 2024 22:22:54 -0400 (EDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: Fix issue with formatting multiple trailer keys
From: Brooke Kuhlmann <brooke@alchemists.io>
In-Reply-To: <20240909230331.GA921644@coredump.intra.peff.net>
Date: Mon, 9 Sep 2024 20:22:43 -0600
Cc: git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <EF941B20-86A7-44C9-846F-1B447D86B07E@alchemists.io>
References: <EF5AE27D-B7CE-4337-B928-6073837218CA@alchemists.io>
 <20240906223402.GA1221600@coredump.intra.peff.net>
 <5A3FD50B-46F1-4000-8AAD-895A4CB4F33F@alchemists.io>
 <20240909230331.GA921644@coredump.intra.peff.net>
To: Jeff King <peff@peff.net>
X-Mailer: Apple Mail (2.3776.700.51)

OK, thanks. Yeah, that backwards compatibility stipulation is a bit =
rough in this case but makes sense. Your patch does mean that you could =
potentially use different separators for each key which might be useful. =
The other nice thing about your patch is you'll be able to easily apply =
different colors to each key if desired so that's a nice win too.

For the moment, in case it helps, I ended up crafting a Bash function =
for local use that looks like this;

----- SNIPPET-----
# Label: Git Tag List
# Description: List tags in tabular form.
gtl() {
  local format=3D"\
%(color:yellow)%(refname:short)%(color:reset)|%(taggerdate:short)\
|%(color:blue)%(color:bold)%(taggername)%(color:reset)|%(subject)\
|%(color:green)%(trailers:key=3DCommits,key=3DFiles,key=3DDeletions,\
key=3DInsertions,key=3DDuration,separator=3D|)%(color:reset)"

  git tag --list --color --format=3D"$format" | column -s "|" -t
}
----- SNIPPET-----

This allows me to list all the keys I need and use a pipe as a separator =
for column formatting. I think that's quite nice while not making the =
format string anymore complex than it needs to be.


> On Sep 9, 2024, at 5:03=E2=80=AFPM, Jeff King <peff@peff.net> wrote:
>=20
> On Fri, Sep 06, 2024 at 05:09:08PM -0600, Brooke Kuhlmann wrote:
>=20
>> Use of a custom separator is a nifty trick. Thanks. A little
>> unintuitive but works. Definitely would be neat if you patch this to
>> work without the custom separator, though.
>=20
> The separator will always be required (even if you use multiple
> %(trailer) blocks), because it overrides the default of terminating =
with
> a newline. And we can't switch that default without breaking
> compatibility for existing users.
>=20
> So I think after my series you'll have:
>=20
>  %(trailers:key=3DFiles,separator=3D) =
%(trailers:key=3DDuration,separator=3D)
>=20
> or similar.
>=20
> -Peff

