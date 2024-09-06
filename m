Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A213E1B85DC
	for <git@vger.kernel.org>; Fri,  6 Sep 2024 23:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725664163; cv=none; b=S9LmJpPPU7Do/lUlda3wwU9QUlTe+uUgHyNUFm3MFlrO6YuHRtIIGfMROzPa8awriVuSqJmGjS9xs+HxSQZAVQOaSkeeaHzTqNrU2wjPJrZgSwNK/wKUOnoNgMatk/VUu09m/QYULyNuPjLO/DNbUEulPqTjjjXXlowHAYQ78Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725664163; c=relaxed/simple;
	bh=iBywSuDSlh151ASiIYl5i5UjOaPh07bBaZem5Fz2UHc=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=d5r/xogaAo1Jjm5z1JmUQ4tRsjn/dkTmE0i7nOIFbhQeOsO34OppxdvtBPoPqvZJsmfJJ/AZbmv9fcjz2T1rWZjs3OgI4pc36pb8QF3ldATlPtWUcc5pzXXt7IqYVYV2a5x385YU3et1x7+l/4aNdXXnylVuMz34haKHjOMQ07A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alchemists.io; spf=pass smtp.mailfrom=alchemists.io; dkim=pass (2048-bit key) header.d=alchemists.io header.i=@alchemists.io header.b=Eb4oC5vp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ThYttmLx; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alchemists.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alchemists.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alchemists.io header.i=@alchemists.io header.b="Eb4oC5vp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ThYttmLx"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A192F11401D0;
	Fri,  6 Sep 2024 19:09:20 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Fri, 06 Sep 2024 19:09:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alchemists.io;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1725664160; x=1725750560; bh=+/TuIO3AnL8a918nAJ0maKbSuoYAh5b0
	w0Y51kuULJA=; b=Eb4oC5vp+vwsWxaofJiNsB+wr/2ZkCBFH1c9A+b988dPNist
	QJyobrIGaQFy2+3i5bhgQ6m0+gsM69pOvC/1UmxACpr2I0hZ/e57sK5oT46nBtyR
	Cwqtw202N7DyPiFukdSz1zF4OCkVsKmMv3rz7ovKM62r/VP9Cv6XIc01hharp+3K
	w/Err/x9+oupA811lqwGcf6CwAhUPQDYEqdy5QpDtMveO/+4xWLNChxeCckV9Vd3
	cQgCNeY2/cayAsiahWwjmago2+jf+x0RQSYKoc/gv63TLKTEqQunM79jaQo6WM2F
	lBkvLpBNe+djTIVORAwJG0Gq/ivnpr0mYR71xg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1725664160; x=
	1725750560; bh=+/TuIO3AnL8a918nAJ0maKbSuoYAh5b0w0Y51kuULJA=; b=T
	hYttmLxp/NinZr71aFHISqQp48bmtSICN2Yb0W8fAgldMDU4PuUQ79CCA9k8LA0t
	UMpDig4GZt6FbHrN6Hv9OnK8lT7CnQxFYRYVe9Qk66P8KqQytGOzow8+2+yOm5qa
	mEWdXB9KLDwAkVETRH0Khtc6kKrBwYd8IyGZfB4k/k+PcLoWWg4GyoW6heM6HbDv
	c5QwUaXqmqP+PL2YRfURL76vl84GZ9n3RnORZ6obMB8C5vy9Ii9BTxYxIe62+lbe
	zU6soaDNeMuRu/lJq/jbuIfj0i44m/uH1RW4lYTBuzrnWspgWVjAh0HCP0ucuSew
	wdAKLVlVu3UKSVYo70Osg==
X-ME-Sender: <xms:oIvbZpyOUGuxXdnHmJUS3LRzPQ_d3_Q8MQsRS8sE4Do4wjcWz16yrA>
    <xme:oIvbZpT8Mhla8D4OG1vW5VaoI3QFq0RNjzgB7ul8N67fYtGHhW5yh3GxTHXnPl3Fs
    nIYOagVX8PnREm_>
X-ME-Received: <xmr:oIvbZjXbcrHsN94UbfzGrKvvPLcu0Iwdt4KubSbsbAd4Er06Y7pDxEHIeqfrBo0Caw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudeivddgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpegtggfuhf
    gjffevgffkfhfvofesthhqmhdthhdtjeenucfhrhhomhepuehrohhokhgvucfmuhhhlhhm
    rghnnhcuoegsrhhoohhkvgesrghltghhvghmihhsthhsrdhioheqnecuggftrfgrthhtvg
    hrnhepleevieffgeevgfeileduveeuudekhffgteegvdefhfehhfevffdvffdugfehtedv
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghroh
    hokhgvsegrlhgthhgvmhhishhtshdrihhopdhnsggprhgtphhtthhopedvpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:oIvbZrhfmA4MUX50s-P6fBxxsyl6PzJaRunZabDhQfKGJSCI-AYqmQ>
    <xmx:oIvbZrDVwyYaEjvPoiIuok6It-hH7WpDZ6UCHz6-WHYjXeoH1ZGu4g>
    <xmx:oIvbZkK4hJL1u1JZ1wMJnoKKFau27yIIV2remEB25z2r67YREYHACQ>
    <xmx:oIvbZqBRgysH3ISHId-23XV6rAf_MeyqqV-prBpafuSlUVJFmRVDhA>
    <xmx:oIvbZuPoMZCpDyEbAVf2GeQeB3R1k5155hwOCHD0z0Y1_g2X8e35MPs8>
Feedback-ID: i78e840cc:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Sep 2024 19:09:19 -0400 (EDT)
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
In-Reply-To: <20240906223402.GA1221600@coredump.intra.peff.net>
Date: Fri, 6 Sep 2024 17:09:08 -0600
Cc: git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <5A3FD50B-46F1-4000-8AAD-895A4CB4F33F@alchemists.io>
References: <EF5AE27D-B7CE-4337-B928-6073837218CA@alchemists.io>
 <20240906223402.GA1221600@coredump.intra.peff.net>
To: Jeff King <peff@peff.net>
X-Mailer: Apple Mail (2.3776.700.51)

Use of a custom separator is a nifty trick. Thanks. A little unintuitive =
but works. Definitely would be neat if you patch this to work without =
the custom separator, though.

Thanks for the help. Will look forward to picking up the next patched =
version of Git.

> On Sep 6, 2024, at 4:34=E2=80=AFPM, Jeff King <peff@peff.net> wrote:
>=20
> On Fri, Sep 06, 2024 at 01:55:46PM -0600, Brooke Kuhlmann wrote:
>=20
>> ```=20
>> git tag --list \
>>        --format=3D"%(refname:short) %(taggerdate:short) %(taggername) =
%(subject) %(trailers:key=3DFiles) %(trailers:key=3DDuration)"
>> ```
>>=20
>> ...I get this output:
>>=20
>> 0.0.0 2024-09-06 Brooke Kuhlmann Version 0.0.0 Files: 1
>> Duration: 1
>> Files: 1
>> Duration: 1
>>=20
>> 0.0.1 2024-09-06 Brooke Kuhlmann Version 0.0.1 Files: 1
>> Duration: 1
>> Files: 1
>> Duration: 1
>>=20
>> Notice, when logging trailer information for commits and tags, I get
>> unexpected new line characters showing up in the output. I expect to
>> see all information printed on the same line without any new lines
>> showing up.
>>=20
>> Also, I want to point out that when listing tag trailers, I get the
>> "Duration" key showing up twice. I'm not sure if that's related or =
not
>> but seems like very weird behavior.
>=20
> There are two things going on here:
>=20
>  1. Some of the trailer options are stored in a global, rather than a
>     per-placeholder basis. This includes the list of keys to show. So
>     you basically end up with a filter list that includes _both_ keys,
>     and that list is used for both %(trailers) items.
>=20
>     IMHO this is a bug, and I have a patch (which I'll send along with
>     the one I mentioned in the other thread) to fix it.
>=20
>     In the meantime you can work around it by specifying both keys in
>     a single invocation, like:
>=20
>       %(trailers:key=3DFiles,key=3DDuration)
>=20
>     Obviously that doesn't work if you don't want them adjacent in the
>     final output.
>=20
>  2. By default, each trailer is terminated with a newline. But you can
>     specify your own separator, like so:
>=20
>       %(trailers:key=3DFiles,key=3DDuration,separator=3D )
>=20
>     See the documentation for the trailers placeholder in "git help
>     log". Depending on your trailers, "valueonly" might also be useful
>     for this kind of formatting.
>=20
> -Peff


