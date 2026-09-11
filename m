Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F79E4A49B7
	for <git@vger.kernel.org>; Fri, 11 Sep 2026 16:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789145724; cv=none; b=Mf9BTn5sx09c4ed0mWwUcYAWUXJDsuMR/lHi92CFeZOnoMIgGCt18Vjc5A+j7LlX2G4GLFxsT0r+Y4vYBUR5yZIFN+3O3GQqcbqdlyi73FTcunZGPpuMSy2m0rCbyTjzIgoiAyFVFKzr4fDuBQWKsyddMGsXM66fP4JtuDkmUhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789145724; c=relaxed/simple;
	bh=thQKXyM8B4KqM6D/YWSngXVqG3KrGbm1Qlg8d0v6C+M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DA/MJgpHVRkUzTKhTrouqL9OumnM88JgzthNG4+BVj7J31c5gtYJqklh67WF5U4lMSdhAg+LCz/Wl0CeA2EOOTMajm6+XbTzVxpA/ThsKxVPagwlqDLE2kUwJfd8A2xn6CiO7gcSyi72G6JkNmgQO9EPxmBgAlQwxFZNLCUytTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=jVvtUTdc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wbMkodbz; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="jVvtUTdc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wbMkodbz"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 7CABBEC01DF;
	Fri, 11 Sep 2026 12:55:21 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Fri, 11 Sep 2026 12:55:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1789145721; x=1789232121; bh=02wBPa5iyS
	PVzTZ6JvXjWHFxLTq8I9qrYJfiBdCXacM=; b=jVvtUTdcecXH6TtqfGpRn680IW
	HxphFUQXNBYNxYyHFPzXvxnVKmzCjIO9cx5hTO5az871QXmYvA5L3RGezj1aQFfb
	wewKlhhejjmehJu1QV88fot+IkMwOfZEaC4TpRqG56OSF5uJICCI9mHkIDb/TaSj
	DJ5XRYUPEC5XSEEYXIWxfPM+8M4dv3E8DoOdcvqP7O94H82Z4SQSsNKdkXoVmpgt
	/fEp2a4mg3PVN6+X3IIrMZNxDEQGIjjugEQd9Nbk5apAN/LYmO36ZMkoa1WF6pv/
	g+e0ePRTOlgitKE8MNgHXbMYFhCLzYHEVMH+resUkvrn6SaMnIbPONQK/3YA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1789145721; x=1789232121; bh=02wBPa5iySPVzTZ6JvXjWHFxLTq8I9qrYJf
	iBdCXacM=; b=wbMkodbzLApTwOnpDOhWZ35QHHhj6V9uZJ1LHGbtkQZu+m1PPa6
	VQSZlR2MV6gwK53QkrjtQ0/QQ3A2jnxmHG5nZRIC8BjqhCCmnuWjEFXIY6b66CsF
	b3fSGy5falnR23K2tSNu+gWGOtTuqlfqFd4ErD/6zJsap9iRhoWXT96/4PcbmVSe
	lVs78nSbiWREuNfeqnMnMcQrOMuUs2IAaG/n5JJDd7UBaLrGk7jzaoPlOjGFgY44
	pLGRAqs49hjJTI+F6OKlZGfqkHTfKCigGGCSTmSVIkgp9qldERnchH9DzO+8Lp89
	ytji3NyctBfCt/ZZwd2Uy83xy0DhjS3p76Q==
X-ME-Sender: <xms:eTKkagi-xEjn8SbCRiyll__WxepTa45Nlj7vDLw7pizgFHhv57lPow>
    <xme:eTKkav7_DPnjDhVPTQaTFZCAnqe3xDG7IUY2N63lQmt2a9coJIhu_c2sBeyjcG8Ff
    WGRQNz3jsPJVNsaTJFoZadPJ0PssK_iPhOuPBP_s-xM26PVJ2aXovA>
X-ME-Received: <xmr:eTKkagbGwZ3lJZx099mTHmpgTL36uh4KE6XfDMm6zrL7j443eIYfHMZmI9qJ3PI9Kua4fnlyG_rbtI3IpnhEXHE4e2nV9DB8j2BD>
X-ME-Proxy-Cause: dmFkZTGpiHERcTlPJPpj69uI7rchwwCinkP4EU0ZcUomUIo6OcrvMtUO6ZJi2bCZX1E38g
    87v/mA481pm0chxXF0TK9QhBG9wKedIcCMgBJjyX3UHA8y35y6KxOUXa+CcgraxPdOGVrE
    b8C28xq3ZhLb8CWMn6Yz8Awo/kuI+QvGeP6PEyIF9uERUqHT3dYbxoS8TY4NksPjhy/OXX
    zjdBu+YQG5IMIqhPO6WKxbbpw+H42penyRoaGcE4zSVHe+sODfXDfYczCEZt0RMVQSstmU
    bMx9URCvv2cPZ9iE/KhntHepL5T3/tHGs8blayxp1rAl2Yphfzo4yxSZAiLLIP/cwcGeOM
    oDTmfKw0tnw7Vr/wNII8hiLnhRnFvr20QWio4Q0+rL0cFPSWcQUzlt04fSspZ0s3cFHrKg
    SzBtnYPZb+xrSxLwxoaNALc+krrz93k0viidW2NyAYkceoJmV+21+atZNNUIyjh/GEd4Kk
    I3vJW57PwjqZR16JnCmyAXMdo3Y0DnaLNWjzvZX9H3RPKadNnw6Wjrgau8+wM3xe2w2FdJ
    IhiSrF5nVpWFi64wv27GJRoU8DTANowsG9+LXe3iFF/9+5su5Ppt/dETMd/7FuUVovkn80
    n+x+LAbHslhxWnfPG6I19OIWkeqtMV/ijoncFvvTnuZM5Alu/Up9Hmj3bdfw
X-ME-Proxy: <xmx:eTKkas7ek4p1ePvqWXNPtOIEXDs7G7GxTXApaPHhvIjUGICzI7bNmQ>
    <xmx:eTKkarCuIBqy6OSMTch6y0LRnGtuKRGxyFl1t3FQWyufWzE65V2jNQ>
    <xmx:eTKkaqfaGCuD478AhG7v1Jff_doiMtBbzFs0XIgDKN2ZWdSc45s7xQ>
    <xmx:eTKkaiJrNGjv_l506YWv_UR7ynY_a5vSqStOZOb2l7fhmAgsQ3khrg>
    <xmx:eTKkaoKOIdZUXNdsX2Qj5ZzPmyLX84R0xr4OCknymPSdg6pDiRrO1T0f>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Sep 2026 12:55:21 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Cc: git@vger.kernel.org,  jltobler@gmail.com,  lucasseikioshiro@gmail.com
Subject: Re: [GSoC Patch v6 4/7] repo: add path.index with absolute and
 relative suffixes
In-Reply-To: <20260911144519.1011780-5-jayatheerthkulkarni2005@gmail.com>
	(K. Jayatheerth's message of "Fri, 11 Sep 2026 20:15:16 +0530")
References: <20260716012138.6714-1-jayatheerthkulkarni2005@gmail.com>
	<20260911144519.1011780-1-jayatheerthkulkarni2005@gmail.com>
	<20260911144519.1011780-5-jayatheerthkulkarni2005@gmail.com>
Date: Fri, 11 Sep 2026 09:55:19 -0700
Message-ID: <xmqqse3fbudk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

K Jayatheerth <jayatheerthkulkarni2005@gmail.com> writes:

> +static int get_path_index_absolute(struct repository *repo, struct strbuf *buf)
> +{
> +	const char *index_file = repo_get_index_file(repo);
> +
> +	if (!index_file)
> +		return error(_("unable to get index file"));

This is a dead code, as repo_get_index_file() calls BUG("") when it
finds that the repo instance is not ready to return this information.

Hence I am debating myself if this is a better alternative:

	const char *index_file = repo->index_file;

	if (!index_file)
		return error(...);

I dunno.

> +static int get_path_index_relative(struct repository *repo, struct strbuf *buf)
> +{
> +	const char *index_file = repo_get_index_file(repo);
> +
> +	if (!index_file)
> +		return error(_("unable to get index file"));
> +
> +	format_path(buf, index_file, repo->prefix, PATH_FORMAT_RELATIVE);
> +	return 0;
> +}

Ditto.
