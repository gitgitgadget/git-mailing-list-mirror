Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25BC37998A
	for <git@vger.kernel.org>; Mon,  6 Jul 2026 14:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783347199; cv=none; b=iV0q95UsUvg7e7nDo6P4iW8qj6DdHpvX1NLcRyhL2YR6Apgc6NVy8NrYfn9kIVs9PebKUBd+A2LptNhw0HfgkTEdYFO6Zn3c8PbCEVUDhBBf8qXpM+1jXkNr6Ya0rhN5O3dhqVZC4dxZyiG3EuRrLoniP6k/eeDbSlY1svn6aKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783347199; c=relaxed/simple;
	bh=L9TUbhCyYCbx9gMVDTIYnMblJdltW2A2uNSA1Gmrahk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NsYf5iE0fT4FE9d0KszrooA9Ev7fKkESSdhDpi1H6VhQJqqaYEGVD0jzGugVXHnTL/P+SymwqAPSsSKTJ0jWAc0nopkP9O5RjOGOE6AYxyQj2eBMvrjGG0hKULFqrUfMWLuAO8PHhbdNF4RwE5WkPsi8Io73JzDGjKkVRlu35hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=MX/0rFc4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XIMIj9/7; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="MX/0rFc4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XIMIj9/7"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 460051D000AA;
	Mon,  6 Jul 2026 10:13:16 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Mon, 06 Jul 2026 10:13:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1783347196;
	 x=1783433596; bh=cQ4YYC3VImJFJ5hTzjUmE+eWDcFASAft1JXgiGjBYms=; b=
	MX/0rFc4HdWIXUb+c1MYZq/VrLefFznwIZlCqMU0FvTIDUrwdXtdjD4T/t1iXbne
	gGsTBY4C67RoQDVYePd3PoVFSeLb5hIeKj8CB7PXVmtf1rS06h/iAJd8or0jyrsi
	4O9LAz7jT1EHir5quBYK69R701ejyNMyKv9tHUGDwz9VUiM1JlE5sJ+23lXD0lkw
	nNTy6rdtrKtMlJ9B6kq0w58Bjrl6RnuFQEyMG3BB+6CLJaUsDJhuPdiddu7sEkU3
	jH6LZiivKmewt23JoNiYbR5duXS/3tQWauIIFvWNvj+T5XNepUu9hOX4FlxBK+N3
	p22+R5F/zvMR6uQkOzXMHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783347196; x=
	1783433596; bh=cQ4YYC3VImJFJ5hTzjUmE+eWDcFASAft1JXgiGjBYms=; b=X
	IMIj9/7wXei6ct39fxe8ebs7CRQFp5+mvx02nsURE8Iz569/Spifw2z59Sl8SgqR
	AlMLXx+uu2nFZe2oYZfNkgOAvtsyDrAh/XOXUehwFwWyXKFZ4B9becVQ3dvLShYv
	eDRvN93+u8MdwP1uI3W2rDYzVnzHG4A8DUY5haTjtYAUcZ7BxloQpsIrIWrAvQNN
	h0MZh7jK2ytbMNF0QEg3Da+/igHbBg92hAhgpLUy8Le9YohOm2z5rrx7yPH3vGpm
	/s9x7LsgGWfhv5v09l6SWvY5BbX9i3onMZ5RsEP2Fhr7DR9LTRB/UsH8Pirr8rhO
	hBSDzgZSB1AucSjxGHizw==
X-ME-Sender: <xms:-7dLavxU4D7ehSug_IiEqj4k0VY_xsKW6LclBr3dVnpH-24_4rnmbg>
    <xme:-7dLauRXXZV92RYBUG6h1H8ex3Jm9Ec-AYqmWZ0m2Bdi6puS2Zov9RoJ2S0OMKf-8
    z5g0UeYZTbDjAtQpvwrAMlLZCnFUDdnN_a68bRFs8q-7ar8YeAxe4g>
X-ME-Received: <xmr:-7dLauVRz6Ftqf7wSLX3HU546GA0yK88pz25_glh26ypm_Hlj50_TCpaUuzYTcBgwW-arJGOMriuPvCwjuw7TruJotdFz5JaW2mJXxw>
X-ME-Proxy-Cause: dmFkZTFUe6j2YPIe+MtmyOmCztOTQKHq2gsiM7Qf0kiW0vXYTgagtNm8LJGV4r92P2FYV5
    teg0DN26XTcQafySw1P+1UGvMjRB2yILiYNoWR/H5Wvb40Hridac6Vn+DTSQi5dLajaciz
    iJqbBpE95fPiAUSR18JgIqtepiKm2s6pd1+RC8Vq+tM88kJ5qAbz/4KSa7/fhMGrXXlUmh
    fUmzzTjy8Ce9RD1726DBnG+S3YNwXMQQuGMLoHBmBJlnt48FX/h71J+ErkNOyj//RzyfxM
    9JhBIqnInqc/53Tx33dfYwBq1IVfDesp2un4Ms3ftQGDATXFR0POECv85RpKw/0cv2EIHb
    PrZQGdQ01huHv7Dybq4TaOz8+7P/KyEww3v2CQMInLYMV1yA42BqJrDw9kULP+q1eXBsIz
    Cv0s0FELJXjc5NwSr6kdUHaJ+LjP+31u6olGCvzEnrLspH1+5LFphLfDxtg5w5K37l1ZXn
    bkTSJYwuEJqy4j+qiRZrjXR372YVxfDLMaD3mXml954WBi6XtQE1pEeorw1aYCzpiUG1BE
    t+QmQz5LQdo7GFRWMQZoEb7oW69ChHe21OcEwArAIk6pV2b0QUDToFamiXVrJZ7AFnT19K
    jaWguOHUV4CUbcKa993GQzRTbxbh3EvWN9J9HG3jOCAU3QSdqtYukzTlDcdQ
X-ME-Proxy: <xmx:-7dLaoaqFRcLMryEuRgfBziZ9FYSOchtwz3_3u3R1mahcPolAc4SFA>
    <xmx:-7dLas00N2BeZuwI2f-HZPE8YCPwPaN5jvdw_PVmByV7FTvcXdBcwA>
    <xmx:-7dLaij3g1Lhxnl4PmfACAZsj02pLwixmUv4Z3pyZMLgPma3FI3DRw>
    <xmx:-7dLaoY_CcOLfAKQlyjAVgcfOFjv_nuP1XYLo2b6Q77BAwv3gNxQpw>
    <xmx:_LdLatXfr3MzduWsBN91A3EovS1OVn35zKm-_vKtW1Qy9pFcE6uWxihN>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jul 2026 10:13:15 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ben Knoble <ben.knoble@gmail.com>
Cc: Kurt Mielke <scr@lyn.dk>,  git@vger.kernel.org
Subject: Re* CARGO trouble appeared from 2.54.0 to 2.55.0
In-Reply-To: <81CE676D-CBBD-44E9-8DD6-B34068E35769@gmail.com> (Ben Knoble's
	message of "Sun, 5 Jul 2026 19:56:23 -0400")
References: <bb2a925e-0b01-4e12-88ed-44deea0c90a1@lyn.dk>
	<81CE676D-CBBD-44E9-8DD6-B34068E35769@gmail.com>
Date: Mon, 06 Jul 2026 07:13:13 -0700
Message-ID: <xmqq8q7ocikm.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Ben Knoble <ben.knoble@gmail.com> writes:

> Git’s source code has included some optional Rust components for
> a few releases now. Rust is planned to be a requirement for 3.0
> (IIUC), but I don’t have any recollection of the proposed
> timeline. [There was also some discussion of delaying the Rust
> mandate timeline for platforms which currently lack support?]
> ...
> 2.55 is the first version to flip the default to « build with Rust
> », but it remains optional as you’ve discovered.
> ...
> Searching the internet shows Alma has packages for Rust, which you
> should be able to install if you want to compile with the Rust
> components.

As you said above, what was reported is totally expected (I
understand that 2.55 built properly for the OP with "make
NO_RUST=NoThanks" set).

I do not know why nobody complained, but we have been carrying this
incomplete sentence in the release notes forever X-<.

 Documentation/RelNotes/2.55.0.adoc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git c/Documentation/RelNotes/2.55.0.adoc w/Documentation/RelNotes/2.55.0.adoc
index f5643534dc..696ad15c1e 100644
--- c/Documentation/RelNotes/2.55.0.adoc
+++ w/Documentation/RelNotes/2.55.0.adoc
@@ -85,8 +85,8 @@ Performance, Internal Implementation, Development Support etc.
  * Promisor remote handling has been refactored and fixed in
    preparation for auto-configuration of advertised remotes.
 
- * Rust support is enabled by default (but still allows opting out) in
-   some future version of Git.
+ * Rust support is enabled by default (but still allows opting out); in
+   some future version of Git, this will become mandatory.
 
  * Preparation of the xdiff/ codebase to work with Rust.
 
