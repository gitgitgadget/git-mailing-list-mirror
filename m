Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C363859D3
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 20:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791319692; cv=none; b=jZt0kAc/nf/w+7ma7emZEswCWpbfqH3CbLraMJmvskCAMlLqsLiqqVMVEqR1paXOz4XGLtvFJtY01adcJPQ0D8X2aSpGMQXey2d3k4W7UYrOJefJeWGw6VRFmsdBSyhSYmAwCp5Uy6P3H1vc/t10VBf91QiCJDakkFQ2A3GWloE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791319692; c=relaxed/simple;
	bh=/ydGse2981jNEXxv+OimkPy8IIKtpSs1YNx4erV7BPA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=e73UrewU5N93MkbN9kiasd4stmkwIkGwhC4mlYH4VfZhz8mjStfgL7f8fcIDXk7uYrKQqB91UX3kXg26aslBqbXlOQt+0fuJ6YFbaeK7cHH8UzGL6NoyE2eM1KNpMa6oj1dvajBrE3NhbNPPKte0qlKgrIYWrhlx980Ohnx/d88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=QL0BJU4t; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QbOi1K/1; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="QL0BJU4t";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QbOi1K/1"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4046A7A019B
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 16:48:10 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Tue, 06 Oct 2026 16:48:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791319689; x=1791406089; bh=/ydGse2981
	jNEXxv+OimkPy8IIKtpSs1YNx4erV7BPA=; b=QL0BJU4tu0xOFjDDjMZQP7BCCf
	uRmk+VUI9awnk6dHxyzOAl7w2QaN3bVIJKAtHwsxaXElHt++Y/HE5xNrIPE8qqO9
	P1ks2lIwCDhinrFGd/iQwoMpONX5K8JrwhqVU6hTXIc+g4Y233QI0Nu7AvRDa+cb
	kcAJ+8Tk2E9kGW5tSGJWtVGpJQPIa6c2Gryf6BEa19bJCtZHjdNq26c2WuEvDnJK
	r0Gxfb+6hxoW/ZFig6cGQO6eQNAPY3LZY5fooBAN1R1YC42+vxxkC2w6shIiXP6L
	3ZWDJChoKSQxNGgKztrtBomdlj1O0ATQXXwsObpQVKUg/gA2zLzK394fmWsw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791319689; x=1791406089; bh=/ydGse2981jNEXxv+OimkPy8IIKtpSs1YNx
	4erV7BPA=; b=QbOi1K/1IeDVfzQDYk44FDKOEmaE/2S9Im2r1ht+zXuU28mbOlw
	KTHeK7jkMxedhUy1p+1PO9FCXdz0/nQ8J+An3cfsFDQTrHV72w1d/u8DA29Alczi
	sUF/r+cJMju4AsgW3ncuhtlOnIAU34Bo7kT2WUE2utWIWgDs15JGCQzQbuK1ojSG
	VLW8ZXhXOaiLN+TgYN408ag0VQ8aSC9qaFLi1li6Bok2K6JlcRxMRR6qsutfGHLN
	CcWFqFDuzaUHOnjeaNpTYobL2uFNdkXNYwAJIsLdfTT4H8mFzgeadYy1rYKO/cfZ
	WMC4Q56wkCPM+6zE34m3zzRf6ffAKki0K2Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791319689; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:oAJI9AMVgwTDkCZELt5cOCcW6eqjabaupNYZos9o1nOGWh7
	RBm2nIOSS6Uj+bNFTWZ/E6C5JRuiWsh6aN361pnnQbaT2+PIuF9LbCf/Mx74Vetb
	a1XezmyB58J0DbgsoRNM0Gum31/5jgkgM0O5/ciitMhYra/ztzkzRapf7m+UhG8z
	dVsfVREwdu3NiPmzQ/PaZLpCulbA1xUShQfUj+DsXS3ydS5QJv5+n6RM+uEV0hn4
	Nc5roCHr8I29Bf8s1Mu+EZGsn+Qgn86omPCf7vdX+g2w+cUFYxlvb/HIW/+Ad1Gm
	+AZaUpB8KwzADzM7V8PvwhvsmwPb4l1EkYWkXBA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:lpf/JfmiQsgERVW+2TYMAY9QeNXTUHueWD6Fm29syWE=:/ydGse2981jNEXxv+OimkPy8IIKtpSs1YNx4erV7BPA=;
X-ME-Sender: <xms:iV7FarHJ-lZG0AG3rjTxPwzDv0w5qXP4g4OZ-V6z66ezeZ8MmgATqw>
    <xme:iV7FasAnmr7U4O0m861dFe8ysOYOp8eO95OpZ25vDWswKiprcjYm8F3_9NRphJqYx
    zXdDVoLkWfWbBTXGQvxuuOI9eqysez21XsXCHq4r7XicYHkhsr4ALI>
X-ME-Received: <xmr:iV7Fam_HHBXElDh3iPSjnz6EnA2LSIkdOILqNnOckeg808YEQkDHg-IAWiyqqdDs-LGTcO4QmpTzbrdKqEXU80dSmFNp7nArku9G>
X-ME-Proxy-Cause: dmFkZTFPb7G5me4TE6rHX1Rjlvk+hnjOa8VWcNvsIXtcd0d9SGcNSMY1osI/uokrBML53a
    Rf+CglilKviSrPG3rIcG/IUeTYA1Qn5Jxi5Boksccq9lDOatUoiK1SXp4CmTsFZibcKf2e
    8suNVGzvHpYkdpYvOyKoYsPX00uAo/gebeV2hOvDGXCIOkLzch2oXrss7q0CvYX7HzmMk7
    aQ0CKTdjskeg1tq/59bnGQ5US0c96EZRmhvqHhvw532/dBpiEE9WeIN9zjrExp0Q/WEdMX
    JuK4/fqHBvL3AC8UQ09lbURll6PiqU6RhHyXMoazYtksZE6uKVga5+VYVH1zHe3NN7Gus+
    FMjH+5T7xOE/cQajTJGSsV5+cVyIrE4OicRc1RDdSpjy4HnLP8l9y2Y+GnxywQNHvgtY2I
    N0AVeod+j3ZUz4BH1mAx1vgptZk5OTPZOXk8qWm8KXwREBzbVYalgNqSBsym2gntoQUgnt
    q9WEqZ8mvUMDl6t30SulRxARmk3iVw7QcvgC3OQyGX1PiwYEtUSy6i5bIbRYMSqr4iVZxt
    R8EobpwgQpCqDf4qi2LNppktGhjnjYM992UqAneBcH0uhfB2NHh1BR9pJ4NybC+UjYGdgI
    CkWDDl5VrHpXtuVfGS+y94yfO9Uzx406lIJ8T/+k5UfRPiFDP/QNDxgBYiVg
X-ME-Proxy: <xmx:iV7FagAUsNjm0ngnQDAX9hZ38_UC0tbnhKzFgNtYOPpM9GnNNENyxA>
    <xmx:iV7FajRTZkuvWHLIkza0sAesXvQQS3i6C-yrTG6Rb7HEKfr95fvXlw>
    <xmx:iV7FavtDcmR5iBQHWWQm37wETYToauaeKhMaMmPP4emFDW9AaNjU5A>
    <xmx:iV7Fan3qJtGwjGUp7wxM2YLd0jYTwuf0NdvVYKNANdGm-UEyJspPVw>
    <xmx:iV7FakwhcKMbJ-GJ6FZ3jNpedIHdh6rHga-LEQPW1XX01l6KrRVIA8Ld>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Oct 2026 16:48:08 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Tuomas Ahola <taahol@utu.fi>
Cc: Julia Evans via GitGitGadget <gitgitgadget@gmail.com>,
  <git@vger.kernel.org>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH v2 0/2] [doc] Remove gittutorial-2
In-Reply-To: <20261006184542.V9Kze%taahol@utu.fi> (Tuomas Ahola's message of
	"Tue, 6 Oct 2026 21:45:42 +0300")
References: <pull.2241.git.1790627122.gitgitgadget@gmail.com>
	<pull.2241.v2.git.1791231610.gitgitgadget@gmail.com>
	<20261006055002.M9X9O%taahol@utu.fi> <xmqqfqyieokd.fsf@gitster.g>
	<20261006184542.V9Kze%taahol@utu.fi>
Date: Tue, 06 Oct 2026 13:48:07 -0700
Message-ID: <xmqqbj96d08o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tuomas Ahola <taahol@utu.fi> writes:

> With an evil merge, or by stacking my topic on top of Julia's---which I think
> is the cleaner solution because that way I can add gt-2 as a linter exemption
> in the patch itself and explain it in the commit message.

OK, then I'll use a synthetic base (i.e., not directly on 'master'
or 'maint', but topic(s) by others merged to a more natural base)
when queuing your rerolled patch.

Thanks.
