Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7671957E4
	for <git@vger.kernel.org>; Thu, 10 Oct 2024 16:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728578769; cv=none; b=HRTXfVlacPpx6sY+POBd8lqNctDi1ksLWMAlAA6ZKoKg0Z6Ea8baquuLBBe1dGHQxMeclW8NTkvgd9YOg3WzE2TV2PKt+icogz+wsLq2MVjF6kT751QGRzxAzfTKkt5SmCK6RA8ybICN1Ah+xPGg8T4NGiUt+WWYxxIJm+OjQkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728578769; c=relaxed/simple;
	bh=6jIIa7wRBmjS3RyxnScNmGSf5o/O3lbKimz/jdSI2N8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lV1vPryS9FHonZI7YpDf6V+nJDutc1TN5+FN6tW3d+k5WG3NRZhYs/DNgIlycDSkXGqxXlR6fM8lDntvK3SVB6FIgOOXhcTwz6+qhx/7K4W4SpVc/oYv+jMjZaAfxlACD4NM1LJvGcfpi1eA63dtDzXGHG4TDheV72k6F71BgjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=qePcLZDD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CNXPdYVm; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="qePcLZDD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CNXPdYVm"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CD33D114022D;
	Thu, 10 Oct 2024 12:46:02 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Thu, 10 Oct 2024 12:46:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1728578762; x=1728665162; bh=Q3QVsY9EH2
	XAs7tIy9eZZbGP8p3CvdYkIjY9rLbchuo=; b=qePcLZDDdFT5Ahbqx7w4AmBfCa
	A4pWkPMjAJN/1PQNYYbqQCnO1DKZbRKy+c2A+O8oJpmi+OMgemkR7TnFVHnOTz+7
	zx8m8nFndeDcD6BhUCNpf3QGYCBDDkXi2vn3yDNWVX2obH8GN5ycNe3UI2TnXwL2
	cxdEEMis/D3PClgK4E5c9437p4bmCk2kuM8OWQTMyzkLsEDElalakZMJOEKvS0se
	c4zkU285F38JcvF1Qxqfq3EdYRtIGOIIWvZOF2XSFzqVa6Ic/rvBks2Bku+8g4ii
	XzBcQDnw42Z8egDaskBXrLT7dEwSRPjzxKE2ta5FYtfYmORTGoN2ZVRvD9Pw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728578762; x=1728665162; bh=Q3QVsY9EH2XAs7tIy9eZZbGP8p3C
	vdYkIjY9rLbchuo=; b=CNXPdYVmpmqyxaQtMigv/Z3L68K66991qKIipKIcLxqT
	kXg9fJTlK5UfCYm+tkVfLtZ6URTgJX29Q2hqx6plWvix5vB/pgk7LnXbZZCaUKkt
	w+Pt7VebEMiVeNNzbI6XSumJL1FJhIt7rckMM9KegvnfPKfN07XJdtu/iqvao89r
	TXgDsGNXjrW/AH9SOZgBYJWIJyQZtjLyt88J8ARLlzQgX1g2HWrGeKdcwuCMbAo9
	GOBjvSGjTqa6M912sfgmt2shgGc8WAWN8bZJ2U4oKM8B5mVbS0z6BmTcFfqI+gx6
	xfdPyekxxHgWxs883LRG/qilMMsuR1UNbSCtTLnUXQ==
X-ME-Sender: <xms:ygQIZ-UjSRfNd5TiHg8BWcJ2aE3VkkNM2RaooR-13FlGlkXMrQ5LBA>
    <xme:ygQIZ6kidpUvVK_bNmJr4sEER5p35bkv8kK74hnWyDevo-1c3-tG4cZJuJ_mw3_4k
    Y1RwJ8dqgi5uuzveA>
X-ME-Received: <xmr:ygQIZybwnD-xqIQNeXCeyroj2t245KpE6o8-QMtb9E0ViIFi5yvQp8l_nSytl85vohoRVrd0NXyDF9jZNE_GVCi34IBe1X_cw1b9Qgg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefhedguddtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdfotddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeeikeeufefhtedvffdtgeefkefhffeggfef
    iedvudegfffgffffveevvdeileffudenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmvgesthhtrgihlh
    horhhrrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehpvghffh
    esphgvfhhfrdhnvghtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehg
    ihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:ygQIZ1XQf7Hh2AySV7XNQXlb86YZ649vun0WNM8Gur_WehQII_9mbg>
    <xmx:ygQIZ4nWN2ntNQEfnDzg934_ZXljE2eOY1Zk1kWjVZ3CMCs-TBL_cw>
    <xmx:ygQIZ6cKuAy4uuR6W1Yc4DjEhWwCXqLOPj2MhE5RReOLQWNPwPqCCA>
    <xmx:ygQIZ6EkgNrCkgtZddlulo3RFaHnL0EKLHWcrtslbuVLeaugra44Cg>
    <xmx:ygQIZ2ZMC0u79UyKainKB_5LE7J1WxKByQ0uUkKxPfXvTOxBaNVAz8xZ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Oct 2024 12:46:01 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org,  Elijah Newren <newren@gmail.com>,  Jeff King
 <peff@peff.net>,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 00/11] pack-bitmap: convert offset to ref deltas where
 possible
In-Reply-To: <cover.1728505840.git.me@ttaylorr.com> (Taylor Blau's message of
	"Wed, 9 Oct 2024 16:30:52 -0400")
References: <cover.1728505840.git.me@ttaylorr.com>
Date: Thu, 10 Oct 2024 09:46:00 -0700
Message-ID: <xmqqzfnblxdj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Taylor Blau <me@ttaylorr.com> writes:

> This patch series enables more objects to be candidates for verbatim
> reuse when generating a pack with the aide of reachability bitmaps.
>
> By the end of this series, two new classes of objects are now reuse
> candidates which were not before. They are:
>
>   - Cross-pack deltas. In multi-pack bitmaps, if the delta and base
>     were selected from different packs, the delta was not reusable.

Hmph.  Suppose that you need to send object X, you happen to have X
as a ofs-delta against Y, but Y may appear in multiple packs.

Even if the copy of Y you are going to send together with X is from
the same packfile, you may not be sending all the objects between X
and Y in the original local packfile, so you would need to recompute
the offset to give ofs-delta X to the distance between X and Y in
the resulting packstream, no?

So when you pick the copy of Y out of another pack, what's so
different?  After emitting Y to the resulting pack stream (and
remembering where in the packstream you did so), when it is X's turn
to be emitted, shouldn't you be able to compute the distance in the
resulting packstream to represent X as an ofs-delta against Y, which
should already be happening when you had both X and Y in the same
original pack?

>   - Thin deltas. In both single- and multi-pack bitmaps, we did not
>     consider reusing deltas whose base object appears in the 'haves'
>     bitmap.

I hope this optimization does not kick in unless the receiving end
is prepared to do "index-pack --fix-thin".

I've never thought about this specifically, but it is interesting to
realize that by definition "thin" deltas cannot be ofs-deltas.

> Of course, REF_DELTAs have a less compact representation than
> OFS_DELTAs, so the resulting packs will trade off some CPU time for a
> slightly larger pack.

Is comparing ref- vs ofs- delta a meaningful thing to do in the
context of this series?

What does the current code without these patches do in the same
situation?  Give up on reusing the existing delta and then?  If we
send the base representation instead, the comparison is "we
currently do not use delta, but with this change we can reuse delta
(even though we do not bother recompute the offset and instead use
ref-delta)".

Do we recompute the delta on the fly and show it as an ofs-delta
with the current code?  Then the comparison would be "we spend time
doing diff-delta once right now but instead reuse an existing one
(even though we do not bother recompute the offset and instead use
ref-delta)".

