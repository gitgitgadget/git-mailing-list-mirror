Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E8C13DDAE
	for <git@vger.kernel.org>; Wed,  4 Mar 2026 18:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772647605; cv=none; b=jqa4xbqp05mcTUBnxJvw4+yI0xTXfNUMSTJ/8L14ieHaByvsf/Hkr42kdl9P0zsHpRjP5l2ML69UGvNLwCYT7shsKq2+EMgmKZWhJB+I+gJJFBBYQeMRNy/wXXIZzQIBmjE4ZIQR1WB1g+G2QklnWCLmtTrJp2uDafPkqEe0sAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772647605; c=relaxed/simple;
	bh=eAZ49GO9b6q+j2rdG9kc5ob2v7R+xKl/YuidHVVi1J4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pL+fqMYLXIY8xcKcgli8sDhMbCOIxrd02WyU2ZIMYKPsDHe7L0oHtKyE6Cp/w+o2lwydKswI+Y9g53V8dJMwnkzn+q03YIqCC9p6uBiD8cryN60JU0MRCkUKlAjM0GNlmWrjhh8CI1m9GEcO9Qwmhz2Oo+5ucMKraTE7sJdDAMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=CZDyDEHW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HixFczXW; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="CZDyDEHW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HixFczXW"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A73CF7A01E2;
	Wed,  4 Mar 2026 13:06:42 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Wed, 04 Mar 2026 13:06:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1772647602;
	 x=1772734002; bh=/nKVJrVYiqOgdxlCgHt7MzACG/AXuhn9/qJhfGBO2tk=; b=
	CZDyDEHWFfYM+KhoBytgcjYW7Tt08qspxp/bd9OxJgrjf1WrViobMgJ61G8nV6vx
	M3oD3hbnBN6ULG8tRfIC+RMWVXHx5onqy8lLEKe0gZ9js96YxcwV5fUNSOHkEYbF
	MEAv1o0LTAn2uUY+OTWsSzYA6/j+ol3IqXS6ymY9H0YPeezqruRi5dp2xl1O+Bqb
	Eeh14jm88ALY0Za9dSX4338iho8e5cwKAdTBMmb5hQ66nVVx/4svCTx4xQ37OYkf
	JQpy1Zy4DtC6fhEbr5Kar0zU8TEg763czlTMFjYLIMX+Z6TL0CXTvq08PZ089ybs
	CFvt0lIOgYbvwBQY6rEtBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1772647602; x=
	1772734002; bh=/nKVJrVYiqOgdxlCgHt7MzACG/AXuhn9/qJhfGBO2tk=; b=H
	ixFczXWHVT1kAUlLM9cdRcBO/si0Fk12aTCQHKNh6KnOjNbmxSGROFUwjU202Bf/
	q5CPv7is4Z165Xm352oLQEv3TXr3n3T1Ys518mkR00D20cJqhncZh4rx0QD0VIzP
	/hU8qfmL8XPC9wSLGjxqS9EuyeCqg8zkYAhBkjZ5j9ZB9bbUVJTqD4bsaL9Fh9eT
	Voe3TWfCqq14Bdv+80Y0rtIogLpz7CNOG6wggzWWzKGk3E4egeUjrjp6Y9zX4uM5
	uoLCAB5V/U39jlSS9OcC1DZ00k4zrI98mboHbwWSqZRpyz5hr7u4aECORCkK1BhI
	PKBDxxMPvGe13SN0fV0CQ==
X-ME-Sender: <xms:snSoaeZl9O5n1hKtuD9KeZiaezteSzbCmhjGKeAaCqxk6_MIblEaeg>
    <xme:snSoaVFIFa2c-Nb_wjJ2-H8zZyo3YQLh1fO1fAVUkOe058TLGQSvuZJ0lh0DQKNqh
    oeXNACjrg8L9Ko8d_Io0Usmvi-c4qNbRlm9v6daEUXcz7pqP3gv8A>
X-ME-Received: <xmr:snSoaSzrdwJOfdyer5ByAXA8_K8EgUOGZ3J7ovrWJQSteb3QY9NEisiasEswrzH7yg38UkSSMkSgxNpChLxisALIkutzCeDL8Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieegudekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegrfedvtdehudehfeegudeisehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkh
    grrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehjohhhrghnnhgv
    shdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhm
X-ME-Proxy: <xmx:snSoaXkZ1qI9T2ab3mUfM4fixCEghrtmDLywNyctiN0o08SmlCuL4A>
    <xmx:snSoabldDYBgGeeXxPZC45KiQ2enzStAScTFstAb-5xpHuzU9OUuyQ>
    <xmx:snSoaZw8oev8E-K9ILKlSmtDsu2vVMMRtJvZI5cwZwutEhgrnFhBgQ>
    <xmx:snSoaQpt82VjzUzpbTICxdGkIlye7ZN6zQkfK3Iuzu4O1JdygHKN0w>
    <xmx:snSoaS0i0rk25SxN3vo_SX-6oM1qlr1Ogw4vmFeHwf6IHtKqoshVrpzB>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Mar 2026 13:06:42 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Tian Yuchen <a3205153416@gmail.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>,  git@vger.kernel.org,
  karthik.188@gmail.com,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v11] setup: improve error diagnosis for invalid .git files
In-Reply-To: <fc2aaed9-ecc3-4efa-bdef-e6ac951c1d5b@gmail.com> (Tian Yuchen's
	message of "Thu, 5 Mar 2026 01:35:11 +0800")
References: <20260222102928.377519-1-a3205153416@gmail.com>
	<20260223074410.917523-1-a3205153416@gmail.com>
	<xmqqpl5rumy0.fsf@gitster.g> <xmqqjyvu42pw.fsf@gitster.g>
	<460f00d5-97b4-4a6c-be45-6f60a17cd33e@gmail.com>
	<xmqqo6l49mrt.fsf@gitster.g>
	<99c6a437-3fc3-4d9a-9465-4c47a9777776@gmail.com>
	<xmqqfr6fa63h.fsf@gitster.g>
	<fc2aaed9-ecc3-4efa-bdef-e6ac951c1d5b@gmail.com>
Date: Wed, 04 Mar 2026 10:06:40 -0800
Message-ID: <xmqqcy1j8o5r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Tian Yuchen <a3205153416@gmail.com> writes:

> Unfortunately, looking back now, my implementation barely qualifies as 
> “functional” and actually undermines the purpose of setup_git..() 
> itself. It's a mess — I rushed into it without properly reviewing the 
> context (like how other cases are handled) :(((

v12 does work differently from what we have been aiming for, but I
find that it arguably is a much safer approach.

Even though the updated read_gitfile_gently() returns finer-grained
READ_GITFILE_ERR_* codes than the original, read_gitfile_error_die()
does not change behaviour from the original.  Any caller that use
read_gitfile(path), which is read_gitfile_gently(path, NULL), like
the setup_explicit_git_dir() codepath we have been looking at lately,
lets read_gitfile_error_die() react to the error code, which is to
behave exactly as what the code did before this patch.

So, I dunno.  After all, these two NEEDSWORK comments have been with
us for quite some time, and reminded us that we may want to consider
if we need to do anything differently.  I do not think we mind if we
conclude negatively, taking "no, it is of dubious value to tighten
error checking in these code paths" as an answer to these NEEDSWORK
comments.  v12 is slightly less defeatest than that stance in that
we are only allowing the callers that care about what kind of errors
they are getting and and want to decide how to react to them, while
keeping the default error behaviour the same for those who do not
ask with &error_code what kind of errors we saw.

The patch makes the behaviour change for callers that pass an
&error_code pointer to read_gitfile_gently() and act on the returned
error code itself, like the discovery code path.  As long as these
callers are audited and adjusted as necessary, we have very little
risk of regression.

I won't be doing a full audit in this message, but just to give
taste of what is expected ...

$ git grep -n -e 'read_gitfile_gently('

builtin/init-db.c:212:		p = read_gitfile_gently(git_dir, &err);

This caller gives &err but it never looks at what is in it after the
call returns, so there shouldn't be any behaviour change.

setup.c:465:	if (read_gitfile_gently(path->buf, &gitfile_error) || is_git_directory(path->buf))

This is followed by 

		ret = 1;
        if (gitfile_error == READ_GITFILE_ERR_OPEN_FAILED ||
            gitfile_error == READ_GITFILE_ERR_READ_FAILED)
                ret = 1;

I do not offhand know if this list of "error codes that should
result in returning 1 from this function" needs to be tweaked to
adjust for the change in this patch.

worktree.c:390:	path = xstrdup_or_null(read_gitfile_gently(wt_path.buf, &err));

This is followed by code that reacts to path being NULL and shows
the contents of err in an error message.  Should be benign.

Thanks.

