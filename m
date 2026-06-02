Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023FD3C7DF0
	for <git@vger.kernel.org>; Tue,  2 Jun 2026 08:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780389849; cv=none; b=Sfdry8enarXMtP4AtLgkhwES6oGex8JdgPo7PVPYgfgfULtt/d0v26gQZNcvVRGyFRTnHovsDoguNqaPyHKovXZb12DlX6+oqzvvsrGInZsO+CMJrbmwJlfA5y2P8eTABE+HiwNWpeuBhlqGkWrqwYD2i8TyGFIrIx3K1w4+RwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780389849; c=relaxed/simple;
	bh=Vm9FV3K6yVYK2MxeG4x5662hAgxYmX39L+iZ1UmLkFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Af0B8Hurjs9wB8xIbk3NQQtt51V2G9yYEy5MeRqCtgjE/NsHjWDzs8cp6iTSpFdbknVp1wZysv/wOv1Nk6kbTlxXR4Hsi7Ax9dfxi0BmXCJir4dYvtgLlJl6tN9OuocXeHdt2M7piUe19rv7t5Lfl0c5huWomes/YHAh4zjbSYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YuQFsenb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=D3GtwK3n; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YuQFsenb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="D3GtwK3n"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 0E4101D00091;
	Tue,  2 Jun 2026 04:44:06 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 02 Jun 2026 04:44:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1780389845; x=1780476245; bh=8vbfXa4CjW
	nEh/HvbFjihNkEditnB/+pRr3Ufo/J0jE=; b=YuQFsenbywxygapx801FlJueFA
	OYvz310BvP7Y7/LvuPN+tjviGsjwx8atp8mYfmGNrdRfD/ghfUEzB/rfTXofU9EB
	ej2lw4L1GpDd15juXnlIPEfKhvs56pOcvUTUCuWJyfsfLpy6Inq/ZT7TnRG2YYEP
	QKxxuqgHWZBbf0Z8TDWOyF+VygSk6B3ZndcqpQzX9tS1V+vM6jPLSyzbRTQmkiNz
	/gZkdH6mGj9ySzWzah2JkuERVzzw5k81EMS216FHKe3kSdssLMuJMNUvd/NeaFbt
	Sxnj9ZlQJLgSfbauwVOl4MwYYJ2zQKOggzzrNU7n4CCBT1RYhs2Vf1qkRDcw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780389845; x=1780476245; bh=8vbfXa4CjWnEh/HvbFjihNkEditnB/+pRr3
	Ufo/J0jE=; b=D3GtwK3n91dHq+mQmvvmPSkXYwxi2TDJ3fZDhau1DgojOuaR+XF
	VFcLYh13IVthzoazNq6KpVkruVEzdeZkocBGIplbvV2ZSfhFqyguoytr9Oe6SL3/
	ej3EiRZj5AI4iKNd2ecw7/S0vJqZ7d390rIBzqKDrXiuh4igu5MW3FRYVuU4pFy1
	awvqe9T57zNXagy7d/9nqvooAFBRWsdxtzbnhfhFqeiqD4MKkQGbDJ5IvBvll2/z
	vtZjoUQykKZI5w9tR1rB/HsShRYoSIwHVZOFonXoK4/Qe2Eq2nQFFJhT3xbQGQlu
	UUXnFL/Qbd9WPRpXa7jVBUV7cCiz2mtL94Q==
X-ME-Sender: <xms:1ZceapTZJzfpNban6T9msJWTRWEg5nAw4U556G-HmepdelUrP-W12g>
    <xme:1ZceaqOTtOeVcqOCneWIIqjBBD9Qy_MHsz4R_HGhT5k7jvTpbHjVIgG6y1gTP-oIZ
    F6d2vNOq2Z5RVWTXKQCFZfh9tOOZJJstGShsmM41NGzfsCM1UKHLQ>
X-ME-Received: <xmr:1ZceasNWSY1yb7-vr0PTV90x6aqB_Jx-WdvZ4qc9yxM236VcIJmjmgbncApvDCeXowchfj2zQfptbxh-SAnvatZm19CNdaPb3Y3g4uFnkw>
X-ME-Proxy-Cause: dmFkZTElgCJOAM5+OubETbitT00UZwzNJYWeePzgMDwGnNmQGZ36t7rI14BpgXV/CH/6yC
    u8jDZdejoSbPEjmeFzZ+4zLWUahoNn//FL9b4BzLDN12fKE3phmPdYLkBp5exX1bnVWxet
    z0EDyUIUxU0D3KDY8lE1faTxR1TIKHkkDL12Aac5uGVxOBRY1uDxyqe92Xu3r+X9zaBeUk
    W+w6hfyoehr2+Sl1wmiZ2I8wjsL5WTYVtchZ1t9Ky1lgBx4rIRHTUUi9FfB6RJ81a/qM6B
    QeqT8OdIU1ny0kBAT6wwRSMOBkheIyAIkYCWKLlIUwlay3aXCbfHtI93zXzkKNLXZPK2qd
    gLbDAjmiQ9fK0ItI9xDumKsRoRt2RO1Ek9gDfSmQH1KyKJHIYgL9dH4+U+olBX+l8P8YAf
    X0d+MBaDMIO6+4eRA5dqhSHpUQbIHXD87ZEGY6HRb3D+3oi+9rVx67gqSuPI0CxtxgJlkb
    wMELpI9T8n3hI50v6M9l2mqZpNblABsOHk21U0mRx6fKKegEKr/tziXoZMECDjfTrlebOY
    VH7QX1UEweEpZRYKwpahcVgReLI6yJWiWwU/jCZdSogvusD+Kz7Qs3xsoITQOHO10POL69
    hvqVfsmTDfXLao12y2+PR5DBKUHC+MpI3bA771BF4NohkKeIKaPnGHpfgLxw
X-ME-Proxy: <xmx:1ZceaqumuwrkiXwiELt-dSI16wOrTGxDGsZxhclJ2K5JJ4jxXHsQYg>
    <xmx:1ZceamUUqYMw6boinXYaf6GhCmtmiDrbGxmfCsa7zxEwNNa8T-i1Ew>
    <xmx:1Zceaivu_WROQkKOTDiVQkjc0iIyrEGWAgiqHouBFWXH99kNnOaVGQ>
    <xmx:1ZceaiUUkGtSjvE4rGntl6o2yY-G2DlvZDwICmnALjPdmFTh7A5mxw>
    <xmx:1ZceasZfa5tm2H5d9YSrxuYxNrQQWz2CWlq2P4Nc4Z3KUNs2qf1pZwvE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Jun 2026 04:44:05 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4b992d4d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 2 Jun 2026 08:44:03 +0000 (UTC)
Date: Tue, 2 Jun 2026 10:44:01 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Luna Schwalbe <dev@luna.gl>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] doc: document and test `@` prefix for raw timestamps
Message-ID: <ah6X0X9EQdL6hn53@pks.im>
References: <20260602081924.673763-2-dev@luna.gl>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602081924.673763-2-dev@luna.gl>

On Tue, Jun 02, 2026 at 10:17:36AM +0200, Luna Schwalbe wrote:
> The Git internal date format `<unix-timestamp> <time-zone-offset>`
> fails to parse when the timestamp is less than 100,000,000 (fewer than
> 9 digits). This happens to avoid potential ambiguity with other date
> formats such as `YYYYMMDD`, especially when used with approxidate.
> 
> To force the parser to interpret the value as a raw timestamp, it must
> be prefixed with `@` (e.g., `@0 +0000`). This behavior was introduced
> in 2c733fb24c10a9d7aacc51f956bf9b7881980870 (parse_date(): '@' prefix
> forces git-timestamp, 2012-02-02) but was never documented.
> 
> Document the `@` prefix in `Documentation/date-formats.adoc` to make
> this behavior explicit. Also add test cases to `t/t0006-date.sh` to
> verify and demonstrate the difference between prefixed and unprefixed
> small timestamps (e.g., `@2000` vs `2000`).
> 
> Signed-off-by: Luna Schwalbe <dev@luna.gl>
> Co-authored-by: Junio C Hamano <gitster@pobox.com>

One nit: the order of trailers is wrong, as your Signed-off-by trailer
should always be the last line of the commit message.

It would also be great to send the new version of a series as a reply to
the previous version, so that it becomes easier for reviewers to connect
the two series.

You can use a tool like b4, which can nowadays be configured exactly
like this with `git config set b4.send-same-thread shallow`. b4 overall
makes all of the mailing list wrangling a ton easier. Makes me wonder
whether we should maybe highlight this tool more in our docs.

The patch itself looks good to me, thanks!

Patrick
