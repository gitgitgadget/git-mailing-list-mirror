Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A040813B284
	for <git@vger.kernel.org>; Thu, 18 Dec 2025 00:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766017982; cv=none; b=tEAJs+0EfizMfcTHL2gK3BXJ7NKgrB7VwAsNCoSOyqIhU4ERKsibALVBdy6DJron3yRZtW8OUCyBcsvuFWDIY/BRLyAkrifU3zgwIWXOBD/Ds4nUmzhw8JPNNfX9mRLT0Bt92FOH1qIdk02OrafawgQErcvAqWk5nw6s3BUxTso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766017982; c=relaxed/simple;
	bh=i2OqAlfRZyAlQDqKUtmtDPNQEbC0a8DiGzZxqO/XvDo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LKFgdqgk/huWKGCFv8nNadSrqkFLWt/w9Z+ibBD7lQx/lwEeXoLTO50skoJLwGw7nL+E0CD0k+Ve/D+Jtem6ZUHgKtsKsr1yc0Przt0aEnvBxPuORp7QZ0lBUhNxN6iuIcv4N0OZtmRKUG/BYPoa+8Iv6belPbTop0eXkrIj2hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=OX0Sgxgo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=t8WtvlnM; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="OX0Sgxgo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="t8WtvlnM"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id D1972EC00CA;
	Wed, 17 Dec 2025 19:32:59 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Wed, 17 Dec 2025 19:32:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1766017979; x=1766104379; bh=rVCEdVsTRI
	5/JEmHFmMr5U7fRhhv+Zznn+cfP/Fo1GY=; b=OX0SgxgolL3wbobbUuuKgJH82K
	+LfaTHiuOtM/3+yofRlVepWqalL+YFpbXB5Gfh2zVyDbc61LYZ16qdSKtgwchnMf
	W7CNzMDoOnfdbD3l9MD9rBQbzpVHR5MLOK8W7xSR0RRRmbb9bMxKI10GrO1AbFFn
	gx7uDPr2GVRS/E9jwq0QNa1x0++MX8RQtw0Lr6w5nxUrw5bSooLtyxO+Kf37iMgB
	lrGvqLebXnKEAG+T0XUyPFpbC5/nCTcxJU7Y+7lmYFIo3Eqa1JzDN9gzxRuPbs8U
	Vz29fpJZJfExHiLXxWB8Z0UlHP5APN79zqLhuVGHckfZxmeZuRKVYQPH/LAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1766017979; x=1766104379; bh=rVCEdVsTRI5/JEmHFmMr5U7fRhhv+Zznn+c
	fP/Fo1GY=; b=t8WtvlnMnHfkpP19obUVAly+k4z9TosWdCuwipJWwud8qoU+wkh
	pG74XmyavtdX77r01vPpaF4MX9b8PX+KFRAdUhieAXu8nmh6RDF7FJw72P3HBJt6
	doNzhbDJAqt4MPt2jXynJVexMnxp3aMeDS9Y2pN1jQd9+FPTe/RDlta+iWksZ+/o
	ukKFv4buO0xc32SMzPv4DH/XOdkkdgswEIjLMKLNnFT3QZ5mSvNHkk3tYpMieZdI
	Um9DFCwiVAFMrick/0offNioUb6WOBI6Es+JTX+gWG11Z5vdKrvckGeZF0Eh3qO6
	d3ZTQIxymaoF3h8tD9oc5+FlcTnaCobl7bw==
X-ME-Sender: <xms:u0tDaUhbGCTCbXZQCmlNB1mjQjJBoTxnFEq-AzZn0ttKz5i5HjPWQg>
    <xme:u0tDafltdQkIPkoBgJrrCtafYNXCwlASXSRo7e3dKkYmktIUPPWYQv2QNDaPdSoJO
    QBF15BZ_aDLToE67sJy9hOTG4_Sv3_mBvspWIwqV980-00Pzf2ujg>
X-ME-Received: <xmr:u0tDaftdd14A0w9Dz7_ACW23P02MU4sRvv4Xtq33tHpVO18V020Zz3XqK9NYEHc3xo4Ig7HygHtSwKR610zYDZebaCghIxQofw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeggedtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeelpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    mhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopegsvghnrdhknhhosghlvgesgh
    hmrghilhdrtghomhdprhgtphhtthhopehtsghovghgihesfigvsgdruggvpdhrtghpthht
    ohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehprghulhhordgtrghsrghrvg
    htthhosehshhhophhifhihrdgtohhmpdhrtghpthhtohepphgtrghsrghrvghtthhosehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:u0tDaVY7M9K2-Q2mODVyVRH93YGnaThgaNtqqsg2NkpPdlF4qLa5_w>
    <xmx:u0tDaXC3508Ag7DL4ADf_LNd-cAqnQQbdp1eY2TfbpRAwErwZWLuCw>
    <xmx:u0tDad9wWYHJ1RsVpbi810JKzN-PNeI3VTfy0GroO2qzyaadNhU6bQ>
    <xmx:u0tDaTRlGKeKgmGysoAyUs2DPBPoPM821Dj_8kC8kILa0XD6wi-0OQ>
    <xmx:u0tDaWGDMot_FYe1aLmf_AdkL6aUF4ukI1q50hnLE87E58hjW6UblsFu>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Dec 2025 19:32:59 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Paulo Casaretto via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Taylor Blau <me@ttaylorr.com>,  "D. Ben Knoble"
 <ben.knoble@gmail.com>,  Torsten =?utf-8?Q?B=C3=B6gershausen?=
 <tboegi@web.de>,  Jeff King
 <peff@peff.net>,  "Paulo Casaretto (Shopify)"
 <paulo.casaretto@shopify.com>,  Paulo Casaretto <pcasaretto@gmail.com>
Subject: Re: [PATCH v2] lockfile: add PID file for debugging stale locks
In-Reply-To: <pull.2011.v2.git.1765997966593.gitgitgadget@gmail.com> (Paulo
	Casaretto via GitGitGadget's message of "Wed, 17 Dec 2025 18:59:26
	+0000")
References: <pull.2011.git.1764688047077.gitgitgadget@gmail.com>
	<pull.2011.v2.git.1765997966593.gitgitgadget@gmail.com>
Date: Thu, 18 Dec 2025 09:32:57 +0900
Message-ID: <xmqqh5tozl1i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Paulo Casaretto via GitGitGadget" <gitgitgadget@gmail.com> writes:

>  /* Make sure errno contains a meaningful value on error */
>  static int lock_file(struct lock_file *lk, const char *path, int flags,
> -		     int mode)
> +		     int mode, enum lockfile_pid_component component)
> ...
>  }
>  
> @@ -102,7 +203,8 @@ static int lock_file(struct lock_file *lk, const char *path, int flags,
>   * exactly once. If timeout_ms is -1, try indefinitely.
>   */
>  static int lock_file_timeout(struct lock_file *lk, const char *path,
> -			     int flags, long timeout_ms, int mode)
> +			     int flags, long timeout_ms, int mode,
> +			     enum lockfile_pid_component component)
>  {
> ...
>  	if (timeout_ms == 0)
> -		return lock_file(lk, path, flags, mode);
> +		return lock_file(lk, path, flags, mode, component);
> -		fd = lock_file(lk, path, flags, mode);
> +		fd = lock_file(lk, path, flags, mode, component);

These are OK, but I expected these are rolled into an "unsigned
flags" word, so that ...

>  int hold_lock_file_for_update_timeout_mode(
> -		struct lock_file *lk, const char *path,
> -		int flags, long timeout_ms, int mode);
> +	struct lock_file *lk, const char *path,
> +	int flags, long timeout_ms, int mode,
> +	enum lockfile_pid_component component);

... things like this can be done without adding an extra parameter.
Compared to "what should we do when we see an error?", ...

> -	fd = hold_lock_file_for_update_timeout(&lock, path.buf, LOCK_DIE_ON_ERROR, -1);
> +	fd = hold_lock_file_for_update_timeout(&lock, path.buf, LOCK_DIE_ON_ERROR, -1,
> +					       LOCKFILE_PID_OTHER);

... "how would we name the lockfile for this action?" is *not* all
that special and should not occupy a separate parameter on its own.

Existing "flags" argument being "int" not "unsigned int" is a
historical mistake, by the way.

But maybe it is just me?  I dunno.

