Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64FB41E0B87
	for <git@vger.kernel.org>; Mon, 28 Oct 2024 21:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730150356; cv=none; b=k2T03VNlO6NyMXUFfL8jCwzOAI9TYRDzFZNP4fxXxMlOnJzoNQj3GAxRWbXUFk4wv5UUmfFpHMQFh3xPtL6k1os3K6a+IOQjoyPRfxi3mCOktA8ZZgvcu2z1Vzccde+68+Cw3NiLENXKL6e+Rqu93nTAL2hv09xgPhPVfVwSFCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730150356; c=relaxed/simple;
	bh=T0nJE9r1St+c0QjZMMxvd9IQNSquJzonPYlP4MxOB44=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=aavQzXVCC31+ld8Y/rBS0jkJzd3tPr2Y7ltlwS15TVCh41WVsJ/C132afz0c8uDaVxd1B+eqQupKIwqju2buj36aMIH1t9XMRZ5c3BaytozbPVySaxabM6H8zLgItDxCmAsTv6rnluaNc7WgD/tRwh9VAlQY4/8/3JULAPBMZgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=N8t5otKa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WKoTEwac; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="N8t5otKa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WKoTEwac"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7B6A21140196;
	Mon, 28 Oct 2024 17:19:12 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Mon, 28 Oct 2024 17:19:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1730150352;
	 x=1730236752; bh=0YJ4v2JlaacAL47mfZ77DVkLxbGeb4jrZAYOTjotyg4=; b=
	N8t5otKaeZKTkcB6p6QuQQdwsUWqd3duOaMhCc7kkw+L8P64AY9lHdL5avdWGtca
	Fm/+EzO5s7txJ0ssw+t08ya10UsXldFoZqrtQrv0DNA5aTJO54d/I6M0EQflhnbJ
	h9HpSBw4eDMj8uPqRrPcZIIQrL7ciyuRbelWO7VNLl1VDlkqa0+aUkEXT73iYs2Q
	IxrNgb5iCO9FRhnc+7O+evYSfHKxTXxGFS9DXMtBpXcOfRdRjN3a5lILZfrMB8Eh
	4qWmgzM6fQpdMOdViXjfyQxnarsOys3z3lVTQwIdv4q+K4lpFibnj9xfNeUEqubh
	zr/kb6mEOVQH5ZELrRgFxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1730150352; x=
	1730236752; bh=0YJ4v2JlaacAL47mfZ77DVkLxbGeb4jrZAYOTjotyg4=; b=W
	KoTEwac0uKzmXTDlrKbHd71p7T+DFgTnNO+G6jKGZeq7CAUgmnqsOOUvMHlOJ68T
	kmBnvQrVg6uWeCi+jni4oEs587SxUmaZW3amvpDRZavQ+BViQpUxo/4O2B73+/EW
	twnTdnKG3x4wZE/cyRhL5+6sJ6C2oO4rlJH2mFE/DImqkCgwwzZ2QzEUwEa0g6AV
	K/o+9KhsSznKrZBQEqd3+f4Kdu8LEZwhBKMJIAfwUPBr2gU4DimxkROET82vly10
	JbjjKMTnQkunwt7IeFAxUblC9BRsQbwRIf1lkH01H3MIyeVYWiTNzb5zwo0xdBHm
	gs7b5BUH5BsbqcpfKZxng==
X-ME-Sender: <xms:0P8fZ3Pd5D5gelzA5fN4PNXP7Nlx038Aqr2b2TZDLcCbJqtsPcybvTM>
    <xme:0P8fZx-4YY77xPf9ziLwpeyShErZYJVQlnUlEph35ugX1sKheRp-et3uDFhkaeLsh
    rrXgVE0q7L8D3PU-A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdejledguddvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepofggff
    fhvffkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishhtohhffhgvrhcu
    jfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrsh
    htmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpeffieeftefgheekgeeitedujefg
    veehvdevieelfeeiiedttedtgfduhfejiefggfenucffohhmrghinhepkhgvrhhnvghlrd
    horhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    khhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsg
    gprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehvghgvrhdo
    ghhithesohhpvghnshhouhhrtggvrdhnshhlihgtkhdrtghomhdprhgtphhtthhopehgih
    htsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:0P8fZ2SX-wBhwS-LhOk-G-OCzJTbkvq6Ryg71PFIJoyo7wxHS0uZsQ>
    <xmx:0P8fZ7u5NgLXY-tJQpleBVNOMGvBWeulkXqXfRMvPy0yVKA_PwaMeA>
    <xmx:0P8fZ_fa0rp4yrn6q2OKNgKxU1WxuNJwAD21ZehyXg5FW5FbC_KZrA>
    <xmx:0P8fZ33BG4vVQaLUfePlxtHt6Pc5D1Tj72VQmXZW_odqxPKFPdGGJg>
    <xmx:0P8fZ3Ehx16cUWpbHZlUkxUvleHkgClc_MpgOKFDyERl5azA941HUnxI>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 384CD780068; Mon, 28 Oct 2024 17:19:12 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 28 Oct 2024 22:18:44 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Nicholas Sielicki" <vger+git@opensource.nslick.com>, git@vger.kernel.org
Message-Id: <c6f58024-45f5-4012-87a4-6b86ab2cd31b@app.fastmail.com>
In-Reply-To: <ab71a27d-728e-425a-8729-8699c9369bca@app.fastmail.com>
References: <ab71a27d-728e-425a-8729-8699c9369bca@app.fastmail.com>
Subject: Re: `cherry-pick -x' and git-interpret-trailers
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 28, 2024, at 19:43, Nicholas Sielicki wrote:
> If one uses `git cherry-pick -x' to apply a commit to a stable branch
> from elsewhere, git appends something like:
>
>> Tested-by: Some Teammate <some.teammate@somedomain.com>
>> Signed-off-by: Some User <some.user@somedomain.com>
>> (cherry picked from commit 2efe13923d0ff714b1b0f3b7175e714f0e295727) =
<--- this
>
> IMO this is inconsistent in two ways:
>
> 1. it's unclear to me why the cherry-pick metadata isn't emitted in
> trailer form, ie: `Cherry-Picked-From-Commit: <...>', making it work
> with `git-interpret-trailers'.

I agree that would be better.  Modulo history and backwards
compatibility concerns.

> 2. I'm not sure if any tooling (external or otherwise) breaks because
> of this, but the existing trailers now have non-trailer content
> following them, so it's ambiguous whether they still qualify as
> trailers at first glance. (possibly, this is intentional?)

They still qualify.  See git-interpret-trailers(1)

  =E2=80=9C Existing trailers are extracted from the input by looking fo=
r a
    group of one or more lines that (i) is all trailers, or (ii)
    contains at least one Git-generated or user-configured trailer and
    consists of at least 25% trailers.

That example would work even if you only had one existing trailer (50%
at the end).

I don=E2=80=99t know what the significance of =E2=80=9Cuser-configured=E2=
=80=9D is here.  I
deleted all my configuration and tested with something made up and `git
interpret-trailers --parse`.  Those novel-looking trailers still got
output as trailers when placed before a cherry-pick line.

> Realistically, the only thing worse than this^ would be to have a
> mixture of two formats in the same repository, which is to say,
> without a surefire way to to share repository config defaults, I can't
> imagine there's a backwards-compatible solution to changing the `-x'
> default behavior and git is stuck with it.

Make a new option?  Like `--trailer`?

> It could be possible to extend the existing behavior with git-notes?
> Added benefit of that would be that you could mark both commits
> involved with `Cherry-Picked-By' and `Cherry-Picked-From'.

Why Notes?  A trailer (a proper one) seems more straightforward.

There was a =E2=80=9Ccrossreference=E2=80=9D patch series from 2018:

https://lore.kernel.org/git/20181211234909.2855638-1-tj@kernel.org/

=E2=9D=A6

You could emulate something like `git cherry-pick --trailer`:

```
#!/bin/sh
# arg 1: commit
set -u
$ git config trailer.cherry.key Cherry-picked-from
$ cat script
#!/bin/sh

git showref "$1"
$ git config trailer.cherry.cmd ./script
$ git cherry-pick "$1" &&
$ git commit --trailer=3D"cherry: $1" \
    --amend --no-edit
```
