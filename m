Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5DB72D1911
	for <git@vger.kernel.org>; Thu, 13 Aug 2026 17:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786642129; cv=none; b=X9h7cmMeniUFgX0yLdC2hdBU8IWk/opTT7aZeSNW9RNDXlfvK4ofx0Jrij7mbOEAPwduYr73l8FEOjfjOLLbiIu7QOJ+tKqnnSXH2NYL/GbH9skWLKT6NOT7xgswMD56vAI5V0GDqZRk0Ds2yRlOhJoTBzNR3Nl7xSeE7RTm+jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786642129; c=relaxed/simple;
	bh=Tz8jDlQGQQknaCGcr2yoOEIr1hQ071zleHovy2d+MaE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Qsre5gIbanSSLpm5PVn/guztTfq2MuMVyG5MMeU7gM3dNO8EW09/0NR5HGDncYdirfUN4Sc2DHzKwnIli9Y0JyCPiKMKwxmesyORkcVjgaa0Wn6XGmvvgSIITbKjzLSIWXdz/yEy6t1v8k5icyMFk8VbZrqIEzoAfalDlPozwuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=eTTGIhca; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JYBW0jGN; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="eTTGIhca";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JYBW0jGN"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 715BEEC02B6;
	Thu, 13 Aug 2026 13:28:46 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Thu, 13 Aug 2026 13:28:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1786642126; x=1786728526; bh=sNMY3OTBMu
	JwPFJtNT8SHJzi3J8OPQbRnGK3/F5nSoI=; b=eTTGIhcaKtKQxv26f5kUhKQDpy
	ljI1lLn5X5CS+9xrTGBPs9ZUbZiavT9bmkLyWby4TwHJeLGoI+r4iUwBuVDSytY/
	ixniR4QOo3+nsld6yZtlVywKrVEPqyTR98+WZVUwBQFFPST9Aas0A+oULYFRRxK8
	AIkGLiFhHUJO3ZZVMdJDSGSHJHISthaspHS9jOImM0DvBtdD9Q29nTRL2l1nQBLR
	luHpWBhiF74ShIUqlUpkHuAfLjkOZ+vPf0YufWKLmSzfkcyVVPmnKpVNcMiihy4H
	rpIIGRxSdfm3pFXRPWL697uuT6S8xMsFPzruaYV/SBlPVpAYcjtAx+JFmQDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786642126; x=1786728526; bh=sNMY3OTBMuJwPFJtNT8SHJzi3J8OPQbRnGK
	3/F5nSoI=; b=JYBW0jGNGAhUWmYVZX9ULkZlP43UTY89lHX9/ZHgvoecB7b/PvF
	hDvZx4Zug3buc833powHMoMx7xD2iSFMkRXK9pcMCw4xo3dcs8W+g6Gw/UtYmFIw
	qUlq87QpgkD2eW6WK69Ts79yZo5GrReV2DhhRYgEJp8IV0MMhLmWZIP7D8ZBi0SW
	ivrvBAY5qq9+KSKcW5fOfbHkE0dE2M+u/Poak1Ch8n4wCP40DjsKZ9q6vRtYOsEE
	LVDRxtSTB7sBq/NaTqQkuajaivuqQNWDFfrN/2f3fWc1SgcjjLGaKiH2+C522t3d
	Mh/Sn2q5jSyw2LEXcvICecFqtvrjh4cyGtg==
X-ME-Sender: <xms:zv59atbRlvIaBMpweBGOzhyOYPghI7TiMmeWL3k4iRd5Uv0wgaLpag>
    <xme:zv59am98uQJOrmawTN-jIzk7YQn6yTU2xKQo_dlpqAdmj_proTR2I6wjA1EWdp36k
    MYAvklJeZP9FwP5s7dMJSf7FhVqeJ2_GQVGPZxqFz2IDBmo0NMGzg>
X-ME-Received: <xmr:zv59ajmKN043UBvoQnWu22-7ASBRuDgj3779LIEdec7cBFJWerMhaU8Gd0Ve1fpJIu4XzHfLL1Z90UxqfzDYqEqrlNOym5CHbg>
X-ME-Proxy-Cause: dmFkZTF3rBorPcTuB22Ez6LoZu0dA7900bsqvJA4X1uBsIfVhYxktQTsscTmBg1WNbU2ms
    vo1h9nA9/s8gtQhuKdL2yI1hp+ulU5owvqFcgcxCRtDoGF3rZLKdT7xpFYz+8OC0dChkS4
    MM960xjMzFEWB9q7Vyio+nKNQaPXHkzP0H8D/l5FuyCt6mNRH+lVQ1ukXvhghkTiXcYqNZ
    n+wOKVR+i5uekdTPuT0v4IQBs3KUKIl/Ap1kq27WzzNlW+OZzMNRvYhSFZKSePPDTKPEdp
    LgEk18ZJgIwzGyD+IJ8iM7rwUXm0LjA/ZJzhNx7S3D35KJlamYIJMuM3bYiM29dI/e1YAv
    qktB04f2RWtlS2LuQfVs3MRtJkoOB6Fe7Z9ox/qsSdSZ96w+0FyyHPXDsYJZBie7WtSl/f
    4kP/+nC1y8D3yN0LAuyCnhKzSpO655IbE4+9pqxTbmMarGa9BVi+C7yL1Mw9T1Y4S07BRT
    NPmW36Gj9CQ3Eks3nHkRhdzZhfEWhKyEtZRJR0rKrubqbZDB3SIdLpLo4kWOK/dBqbKMe+
    NHTqVNRAI4EoVy3xrH2ZobnSBzJ/aLeX1ZwU9CAmJvjbMRpTkMwKlJsOZp9NB5Zm2CL+im
    KnBTnH54cfasDq2RwNQOzPoThRZGHQyEB3ydqInPsAng56VGOOcZLojSOcpg
X-ME-Proxy: <xmx:zv59arzF7RvtnBIFIMsW10BfwjuQt3YfRXCUNIRkXYJsRFd49AsomQ>
    <xmx:zv59at5ItFZnLslYFEKw74GGdtZv7vr0JLDkiMIDMqB9-aXU5Ys3hw>
    <xmx:zv59arUwhKbr8MXfWFRQURC-jEd6qU2nj_dHBJZ1jiTWTFAnOfaunA>
    <xmx:zv59alJX7k9QJNPY39xMAMbzLy30fVdVPbxUrUIh7Sd9L86hxSGGFw>
    <xmx:zv59apiDZyjK2FHWZLwHkL-p0Fnt9u0gxcvxCmAAlTDPSVLOy4nwZx6X>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Aug 2026 13:28:45 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Phillip Wood <phillip.wood123@gmail.com>,  "D. Ben
 Knoble" <ben.knoble@gmail.com>,  Patrick Steinhardt <ps@pks.im>,  Matt
 Hunter <m@lfurio.us>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Harald Nordgren
 <haraldnordgren@gmail.com>
Subject: Re: [PATCH v13 7/8] history: create squashed commits without editing
In-Reply-To: <8b3551d0d4ecb360775ea29507ee262c7bf9cd42.1786088371.git.gitgitgadget@gmail.com>
	(Harald Nordgren via GitGitGadget's message of "Fri, 07 Aug 2026
	07:39:30 +0000")
References: <pull.2337.git.git.1781465141.gitgitgadget@gmail.com>
	<pull.2337.v13.git.git.1786088371.gitgitgadget@gmail.com>
	<8b3551d0d4ecb360775ea29507ee262c7bf9cd42.1786088371.git.gitgitgadget@gmail.com>
Date: Thu, 13 Aug 2026 10:28:44 -0700
Message-ID: <xmqq4igyszeb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +test_expect_success '--no-edit uses last "amend!" message without an editor' '
> +	git reset --hard three &&
> +	write_script editor <<-\EOF &&
> +	exit 1
> +	EOF
> +	test_set_editor "$(pwd)/editor" &&
> +	echo fix >file &&
> +	git commit --author="Fix Me <fix.me@example.com>" --fixup=HEAD -a &&
> +	git commit --allow-empty -F - <<-EOF &&
> +	amend! $(git rev-parse --short HEAD)
> +
> +	The first reword
> +
> +	More detail
> +	EOF
> +
> +	git commit --allow-empty -F - <<-\EOF &&
> +	amend! three
> +
> +	The second reword
> +
> +	Extra detail
> +	EOF
> +
> +	test_commit WIP &&
> +
> +	cat >msg <<-EOF &&
> +	amend! $(git rev-parse HEAD^ | tr a-f A-F)
> +
> +	The third reword
> +
> +	Excruciating detail
> +	EOF

Care to explain why you need to (1) eat the exit status of the 'git
rev-parse' command and (2) munge the commit object name by piping it
into "tr"?

When another in-flight topic is in effect, this test will break due
to "amend!" followed by a string that is *not* an object name, as
the other topic declares that uppercase letters are not valid in a
hexadecimal string.

Thanks.
