Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D222FAD24
	for <git@vger.kernel.org>; Tue,  4 Mar 2025 07:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741073586; cv=none; b=LHFJGbB9W8aS9OxsR/m87qppQr+P4tia2Fx9z2TmkwlmA6UbvqSQ9m7VRy24cJ9t0WcmZxgU31iWeGteEhNqr12eJS6v2hylelMKbYQEQ5TmnlyVtgm+Y93A0VMAnb4vXYQt7uZVp9TVttMFQ+AlKmVzXIWEMSJXObpwVrTCjq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741073586; c=relaxed/simple;
	bh=/J9pQXZbxjPcGa0d4PamGxfE4zReYhivVLdC/w7Bg2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mQ2Ho5ksseA6BP5PIQyr9etMtQHg3Lxn6amTrfbyTkVUG5gTnt4FFk3b4rLUztbOiaQzm3MXYKu4P1dkqodj9jW4si9dmHECkhGQ+h5anVYba6NylLr6e0PgictXjYLBV+g93RNzh2MwtjztDOqy9kZgpI/wgXiFb3WCEFDbkdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Hmjsl9XK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UYQi26Y9; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Hmjsl9XK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UYQi26Y9"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EAFBE11401EC;
	Tue,  4 Mar 2025 02:33:03 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Tue, 04 Mar 2025 02:33:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1741073583;
	 x=1741159983; bh=KTBP5oiCTJG/joE0ZTcg+Y4/0BJiP6R7NVa9WpyYNkc=; b=
	Hmjsl9XKdklO20biN3RHpVr3j6wwatcmW/O6nigsB0r6yD5+WVY+V5NGRcHcg9LH
	Vcb/7HDYeWgeMPuEv5/DuAD/dIG/7T1vGrWvdsp+4gRYfASi54FnlfKIo9xbJRid
	ZCtDJsx66RFhMEk5G2+r1UhPJzQ9WZrGhums9M6sokPw/Q9FGaVa6DwcINKKOAqG
	/ksRXhnkyTsAhIWgj95EBfs9oLhJ8nizmbQS6gHqcsm9iea77TOLjJoIVxWHyQZR
	IMqa5HdQpILRfZ9+O86Gf2CIErMT7uAzXDJJE8oS+aV4Rznj7ZCeTgonwgC+tTL6
	NXE3EwEaLLfJnJsadBa6PQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741073583; x=
	1741159983; bh=KTBP5oiCTJG/joE0ZTcg+Y4/0BJiP6R7NVa9WpyYNkc=; b=U
	YQi26Y9mx5RDD+rKdKoTqY5k3quCy/U3WSKZbRhrPNbkX6tdFCqf6+ONFj2WKca0
	OOyGQE24FSWrvPjl8YrEa89RScE01OiEftqc+T4+WPsgDqFFxKKsh3V0WZadnhAz
	EXjPito5rbVlJhOQ67uLsTN4XOwTgnvhMqdpmic/IgKWWEQYEEfmB57FJ8HypuGp
	Ib7O9rTT1xjiqDd69MBPId2xFnHF7dG46gvCxkEGwd+pHVIid8GBWZrkcHG0Yo5M
	CIeFeD6hH5EA65YmL+GQvEeMxyxgcZFSnRM8vV0A9vXc4sKRTyllO69OuvtuhEgH
	NKTUHJ2mjlvpmV5+xS3Sg==
X-ME-Sender: <xms:r6zGZ7-cJGywUTN37mZ_doAQjyV5qI3WksWyGQ3Ti1DaAN-AwXpeJA>
    <xme:r6zGZ3tzdFrcOI1XxjPAKhWXg9VehwbCtULKkYbbwRJYzuMzIeP5LN-Ve75G5tuX1
    ByJASiOubamUaIzYw>
X-ME-Received: <xmr:r6zGZ5AFGjpllY81Rsyei8pr22Tonsfk7wub0jy4378veo3Q5HhOrGIzzEXqwy3sWEeGn-GNX-GNi3iEijt3T2eAxTe7MEAo30uVeLh4lThOqbc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutddugeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddt
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpedvfeejiedtteelheeiteekveeftdefvdehkedv
    veetffdvveevjeejleegtedvgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehl
    uhgtrghsshgvihhkihhoshhhihhrohesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:r6zGZ3cqt2MgjLlc2b0-LaMxW35QYhnLv8Sl3oLOeDaJPY4aew7UMw>
    <xmx:r6zGZwPDG5nyuP8muepml8XjkxsKjAizPSx2VO285g3Y6VqkNGCd8w>
    <xmx:r6zGZ5lWsQPBIwL67WpRfZEdd85R96ObJa8cKQl5xTMx6XijguxC2g>
    <xmx:r6zGZ6vm-NtWEzGjS603GETNfHdahIPeRcbjmiapn4j46t3TX4usIw>
    <xmx:r6zGZ1qWag-wkiaFqODeMuipQWi1cZ38jO9ljLPOY5zD_9kAM0IE1Tyf>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Mar 2025 02:33:02 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c0202fb1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 4 Mar 2025 07:33:00 +0000 (UTC)
Date: Tue, 4 Mar 2025 08:32:55 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>, git@vger.kernel.org
Subject: Re: [GSoC][RFC PATCH 0/6] Add --subject-extra-prefix flag to
 format-patch
Message-ID: <Z8aspywaD0mAyHwd@pks.im>
References: <20250303220029.10716-1-lucasseikioshiro@gmail.com>
 <xmqq7c55vhj8.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqq7c55vhj8.fsf@gitster.g>

On Mon, Mar 03, 2025 at 03:08:43PM -0800, Junio C Hamano wrote:
> Lucas Seiki Oshiro <lucasseikioshiro@gmail.com> writes:
> 
> > Subject: Re: [GSoC][RFC PATCH 0/6] Add --subject-extra-prefix flag to format-patch
> 
> Hmph, instead use "--rfc=GSoC" to do [GSoC PATCH n/m] and please do
> not pile more "extra" on top?

I do understand though that `--rfc=GSoC` is not exactly discoverable for
a newcomer. Maybe a simpler fix would be to introduce an alias for that
option that is more discoverable? I don't have a great idea for how to
name it -- the best that comes to mind is `--patch-prefix`, which
mirrors `--subject-prefix`.

    --patch-prefix=<prefix>
    --rfc
        Prepends the string `<prefix>` to the subject prefix. As the
        subject prefix defaults to "PATCH", you’ll get "<prefix> PATCH"
        by default.

        When `--rfc` is given, the prefix will be set to "RFC" . RFC
        means "Request For Comments"; use this when sending an
        experimental patch for discussion rather than application.
        "--rfc=WIP" may also be a useful way to indicate that a patch is
        not complete yet ("WIP" stands for "Work In Progress").

        If the convention of the receiving community for a particular
        extra string is to have it after the subject prefix, the string
        <prefix> can be prefixed with a dash ("-") to signal that the rest
        of the <prefix> string should be appended to the subject prefix
        instead, e.g., --patch-prefix='-(WIP)' results in "PATCH (WIP)".

We would hide away the optional value `[=<rfc>]` of the `--rfc` option
and instead advertise `--patch-prefix=<prefix>`. This would of course
only be a cosmetic change, we'd still accept the optional argument so
that we don't break backwards compatibility.

Patrick
