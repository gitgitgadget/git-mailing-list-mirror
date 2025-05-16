Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B21C1ACEDA
	for <git@vger.kernel.org>; Fri, 16 May 2025 09:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747389158; cv=none; b=Vh4Dwlq0CBacahWiRBJL++Pmwnd3e78jXpetRAbZswuHvbE0LVJxJqZzYPSaD4NHEmJfx48D38xTxi994okgDjQT0gL7CD9iwc/z5Lzf0OakNBvzUkGJCi7GX5hcMj8wk55S/MUgEdXq1vg2/GaqZOIMKp6uL/LUH0BbRRHANCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747389158; c=relaxed/simple;
	bh=grWYKy1E2sjG+UQtCtnbKg61Jdd+0HTKvV1URcozgD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N6l6pDy1h6K5lmy7F+RCtFK+DiPnuuMJfoWwrqGABoCp6+19zEjv2VXgLWR4TZtdzJgeD9GGYvtSdEPZ9AjImfXXt4ppqOtJVfEGe12DHmFuXHSCSInnEyZDuqjdeCUTxF3yHEr3yeC0QhYUm79IQAunGdxMynsBbEQYW/HwzJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=UXmsciNn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iMf1f8MV; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UXmsciNn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iMf1f8MV"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 3125513803E8;
	Fri, 16 May 2025 05:52:36 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 16 May 2025 05:52:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1747389156; x=1747475556; bh=rD/b4b2M/5
	zDistOB5qCX1draS6GFAcQbYd1f24jiV0=; b=UXmsciNntpjrRCXd8VP7uFxvJK
	owu0WjCnTF3DztsOg3sRW86m2Z3ieM7Lsf8eKQ/lK7mP7VDPH7iQ/P/Yl7ZuAXsx
	gOAkpbgV/I6/bm9j+KemyYoG/41JtdQVsBVtRiH2yqjP1w1r7HuXZYaZm/CBDkTV
	jYHa+mJXULf22dznVvcS98hwa/0MdS4SGBVKDcSFB6+TW1mTPaVFGev6YIMU2bs2
	AVncc8vO9aO+Qn/Agx3dB0VuiKQB2svA0ZrmA+rWCDQvfIE4C3UWo8mBOB1K0lSd
	L+twiI+whcIu6duWOqvQMjiKmnuViQg0uxthU7Bqe3NA/9wZ9M6YTkpLKszw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747389156; x=1747475556; bh=rD/b4b2M/5zDistOB5qCX1draS6GFAcQbYd
	1f24jiV0=; b=iMf1f8MV5GPs9VdUKMaVaiJTk5dBNDX6C/o9YWoPJL3mYQ3DSjB
	BuTFQq34c1FUjN72zHsZBEgRfquSuZ+uuDADLbORPQYrqLuvKxIvqwI8Zp/oy+UI
	NWuwkq/w8tjrSm16HN4PhfjdIHz89NVjELdLLvvx5nZ9t4fJvNyc3iQ9JUl9jwLn
	FMctjT7DriMGur19Ki4HMnYZa/jQL+hnFKkEES9SRFJQq/nAUdZxc3/siYSO3QX2
	ntmjooc6J5qE7gtkV0+dvvy2YFAdT40LrZYoe0PNrre3wQiU2p2YvutM3u0c1A97
	ZTQipxlGBtOylLVOII02LiR04OD7b6JuU9Q==
X-ME-Sender: <xms:4wonaGWARQV8sZ1jFqmDpZpFP6JTgIAVNA2lbMOAGUTdK5rAdCHOrQ>
    <xme:4wonaCmFBOutz3LQDwDpwogzr3lQw3tUfDrenJhcbpvNrr42UJOZ9yf7g1HUdQtpM
    Zgj7oXVt7rPW3zy8w>
X-ME-Received: <xmr:4wonaKbgu2erW38ZxHXjblzPMKKKe7zeMxz_WWTU9JGjQzV6K7tThAUXXG2XvPZjNQkerJeyh38TwWr1WlSOOqAOzXXnKGdxWA7RQOn9>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefuddvgeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhf
    fvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgv
    ihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekff
    fhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpd
    hnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghf
    fhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdroh
    hrgh
X-ME-Proxy: <xmx:5AonaNU2v0ivvkI4Xb9SCDdb01rifBRFVlpvoGBMvFOSnhnIGl2w2A>
    <xmx:5AonaAl7TUO0Zkz_JfHULqE5s4E5TcAmkALPVxcmGwZVBvNtgZv2Jg>
    <xmx:5AonaCcVuv-BIR5kdcW8kRz7gkXZn5UFDjwGqdLb037aiTPtAlMJXQ>
    <xmx:5AonaCGdzdUANI13thYebiFUD7K5OFV6sFpmc-ETroDdOjF0rwO8Gw>
    <xmx:5AonaPfObVptBP49NPo93SgNGV8O4G4niCXkMPCGUVoJDOim-ayRosJ->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 May 2025 05:52:35 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 64e230a5 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 16 May 2025 09:52:34 +0000 (UTC)
Date: Fri, 16 May 2025 11:52:33 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 09/13] t: add lib-loose.sh
Message-ID: <aCcK4bZVxuO2iTMS@pks.im>
References: <20250516044916.GA21985@coredump.intra.peff.net>
 <20250516045002.GI22242@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250516045002.GI22242@coredump.intra.peff.net>

On Fri, May 16, 2025 at 12:50:02AM -0400, Jeff King wrote:
> This commit adds a shell library for writing raw loose objects into the
> object database. Normally this is done with hash-object, but the
> specific intent here is to allow broken objects that hash-object may not
> support.
> 
> We'll convert several cases that use "hash-object --literally" to write
> objects with invalid types. That works currently, but dropping this
> dependency will allow us to remove that feature and simplify the
> object-writing code.
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  t/lib-loose.sh                      | 30 +++++++++++++++++++++++++++++
>  t/t1006-cat-file.sh                 |  5 +++--
>  t/t1450-fsck.sh                     |  3 ++-
>  t/t1512-rev-parse-disambiguation.sh |  5 +++--
>  4 files changed, 38 insertions(+), 5 deletions(-)
>  create mode 100644 t/lib-loose.sh
> 
> diff --git a/t/lib-loose.sh b/t/lib-loose.sh
> new file mode 100644
> index 0000000000..3613631eaf
> --- /dev/null
> +++ b/t/lib-loose.sh
> @@ -0,0 +1,30 @@
> +# Support routines for hand-crafting loose objects.
> +
> +# Write a loose object into the odb at $1, with object type $2 and contents
> +# from stdin. Writes the oid to stdout. Example:
> +#
> +#   oid=$(echo foo | loose_obj .git/objects blob)
> +#
> +loose_obj () {

Nit: I would have called this `write_loose_obj ()` to indicate that it's
writing an object. But ultimately doesn't matter too much, so please
feel free to ignore this comment.

> +	cat >tmp_loose.content &&
> +	size=$(wc -c <tmp_loose.content) &&
> +	{
> +		# Do not quote $size here; we want the shell
> +		# to strip whitespace that "wc" adds on some platforms.
> +		printf "%s %s\0" "$2" $size &&
> +		cat tmp_loose.content
> +	} >tmp_loose.raw &&
> +
> +	oid=$(test-tool $test_hash_algo <tmp_loose.raw) &&
> +	suffix=${oid#??} &&
> +	prefix=${oid%$suffix} &&
> +	dir=$1/$prefix &&
> +	file=$dir/$suffix &&
> +
> +	test-tool zlib deflate <tmp_loose.raw >tmp_loose.zlib &&
> +	mkdir -p "$dir" &&
> +	mv tmp_loose.zlib "$file" &&
> +
> +	rm tmp_loose.raw tmp_loose.content &&
> +	echo "$oid"
> +}

All of this look sensible to me.

Patrick
