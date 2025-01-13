Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A483D24022B
	for <git@vger.kernel.org>; Mon, 13 Jan 2025 17:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736790963; cv=none; b=V/2PdA41Pv3VnBk+46QcO0RQyS3sWGUsDzUGq/w8tdKLi/q5YSCRgepfBzQAvEanvYGoTHhI29OvNFZb5Jc04G7WoUvCHsIEuyEmrT6EPxETnKLrcuJdJbxGa2se/CPMszFT6sxvVYVAJGBUmaeRKWTul6BVePikZ+jtfJdzNEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736790963; c=relaxed/simple;
	bh=EMIwpgn3r6D0a/28FT/l6CqVjwgmtR9IfLxcg125Buk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cjy5/uy4vyLcPvd8mAWOhcJvFlfaM7sQxxwz7A/nDK31HeRJRG7XCZ0gSGBfEll/Yy+dKu7KUy1zmvyX80Jno8uf2/Q7C3a0ljQUb5zODekSNyxWPlkmjyvUBUMS30g1UkxtyJPM4cpPXMWzVu4huLh+Pn5Ze0z8LJjpCFrGwow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=0rR01c9T; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=o2nabz+A; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="0rR01c9T";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="o2nabz+A"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B102E25401B2;
	Mon, 13 Jan 2025 12:56:00 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Mon, 13 Jan 2025 12:56:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1736790960; x=1736877360; bh=9e43C3b9Xt
	RkUzleZvpnfq4Rdlzcex8EKL6sPssEG8c=; b=0rR01c9TdGhb5LvJ12U2LzEhBo
	3eaoAaL108Yd8h0xC9TsPUPiug2sf1s61/+gHE8HJKEp9tBs7QP9k/G2A0pnL/tr
	gMLmL8klaWW1DWRA4TpPG8qr+TjIBnWJmQscHuvn+BwJ2AGkP2xNsIHnYVcEthYt
	6VXHJHag+5w/ppdtfaqorkyu1f+6oiK3FmAvg1ETrv2KURLtBUZ72t1ZKtaKQRrs
	rlN7+EMKYhpWNTpJ+A5qasD2Y10RrcRy/a7neQDitEvfHlaxar/YJqo+4viKkqMV
	zKrB1u4F0UjvBD3uhIEsy20QuxhKdXFxdL5n9LVATdlANyPkX2hyocaBZ5nQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736790960; x=1736877360; bh=9e43C3b9XtRkUzleZvpnfq4Rdlzcex8EKL6
	sPssEG8c=; b=o2nabz+AyWxVIWBSNsPw+Pd8WpDl1oEK+cpn0JwMZxRcNIzrU34
	8aRxz79MXfHASMLtFFGYdgngaaX8UToqIVDV6+Ohnk8+ZDTZ+7+HNrz4dXfqvU1Y
	NTQdNsGfBlV49fbBX9L/8nRNgWDkXw9DjjkBktpk0o0i5KG8OeX8LzxxUhvYYLMl
	5VE9CvvO6nl/i7O3xwSSdHVxRJB48LgEocGVdTu+8sKarRRx9wCMvq7V2x6YhiPi
	7GmAaB6AsWfGCgzGTOFq9j7S1DdR5R8Zi6kgqjyxf3ZG/lZB3UvSdx0JLOcxNFrJ
	/rPflDCNzfAvfthQBpxMvSbgoePTY5h3GKw==
X-ME-Sender: <xms:sFOFZ0kg13QLjKFOZ98UrEkLX21jolloSBJQFp0DAzXE-jgclUK7fQ>
    <xme:sFOFZz1x3F9cCN6KbmvWmcMZm2_gK_QB1msEG1lbI0TB18gBvNyj60IPSZ0sggtcl
    Rat82NKSeKTPbTxZQ>
X-ME-Received: <xmr:sFOFZypdNSDMb_qiQSKEkZgyekClUDt4VE9ZTlpqhZwal46faJAO6gLnHxkHAsrJFahHiJjWWzV2wVLNo2AX3f2wd8tgxv9oFNPx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehgedguddthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrih
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pegvvhgrnhdrmhgrrhhtihhnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepvghstghhfi
    grrhhtiiesghgvnhhtohhordhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomh
X-ME-Proxy: <xmx:sFOFZwnTBzyHTbvJyt6docaTALMyDvWsg_gm60gTPCc1pSEm2qM_WA>
    <xmx:sFOFZy21fi3YNyta0ycPyqxPtrpMnbyNf4R89bGIm-xbsdAFq2Tumg>
    <xmx:sFOFZ3suHMIuZU_8Wdj3xfRbeIf6d9LdRRFi_g8VcQQAVngMxLrSeQ>
    <xmx:sFOFZ-Xdw-0DVpYo00NTZVYgnBpejfmi7nhhUBa1SZNw_pYhflaDpA>
    <xmx:sFOFZ-8lhvT9MdGehkEpz7ldj9ys2TLQbP1GOcS0pquGRF9xGGyo_wsT>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Jan 2025 12:55:59 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Evan Martin <evan.martin@gmail.com>,  Eli Schwartz
 <eschwartz@gentoo.org>
Subject: Re: [PATCH 5/9] meson: wire up generation of distribution archive
In-Reply-To: <20250113-b4-pks-meson-additions-v1-5-97f6a93f691d@pks.im>
	(Patrick Steinhardt's message of "Mon, 13 Jan 2025 09:33:38 +0100")
References: <20250113-b4-pks-meson-additions-v1-0-97f6a93f691d@pks.im>
	<20250113-b4-pks-meson-additions-v1-5-97f6a93f691d@pks.im>
Date: Mon, 13 Jan 2025 09:55:58 -0800
Message-ID: <xmqqv7ui8uoh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Meson knows to generate distribution archives via `meson dist`. Despite
> generating the archive itself, this target also knows to compile and
> execute tests from that archive, which helps to ensure that the result
> is an adequate drop-in replacement for the versioned project.

My reading hiccupped at "Despite" that does not seem to say anything
contradicting to what follows.  Did you mean the same thing as "In
addition to" there?

> diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
> index 95d7d41d233450774a6580c0de332e7b8f69eb4e..1f0fb4098da392511f02a34cdcc84f3889771001 100755
> --- a/GIT-VERSION-GEN
> +++ b/GIT-VERSION-GEN
> @@ -19,6 +19,11 @@ then
>  	exit 1
>  fi
>  
> +if test -n "$OUTPUT" && test -n "$MESON_DIST_ROOT"
> +then
> +    OUTPUT="$MESON_DIST_ROOT/$OUTPUT"
> +fi
> +
>  DEF_VER=$(cat "$SOURCE_DIR"/GIT-VERSION)
>  
>  # Protect us from reading Git version information outside of the Git directory
> @@ -33,7 +38,7 @@ then
>  	# then try git-describe, then default.
>  	if test -f "$SOURCE_DIR"/version
>  	then
> -		VN=$(cat "$SOURCE_DIR"/version) || VN="$DEF_VER"
> +		VN=$(cat "$SOURCE_DIR"/version) && VN=${VN#GIT_VERSION=} || VN="$DEF_VER"

It used to be that the contents in the "version" file was the
ultimate truth to be used as-is, but now somebody may write it with
or without GIT_VERSION= prefix, and this one place is now prepared
to strip the extra prefix, but everybody else who has been happily
reading the "version" file is now broken until it is adjusted in the
same way?

