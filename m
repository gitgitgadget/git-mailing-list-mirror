Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C673D13E898
	for <git@vger.kernel.org>; Fri, 14 Feb 2025 20:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739565360; cv=none; b=UFClc2fJyzCcengisVMg7+fwaqkJ9OyvLhpZ5DvF2MjZK3FJklRVnCHd+P2fU21OqutLS3vBAgo8HjoiLM978RpJh3VYk+GrDap5kTlN5PjJkeihaXENwH28wOiTz/zISlVvtCY982yCGJXRGU4tg0DCcXrVzo5unCgJ1k5OQnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739565360; c=relaxed/simple;
	bh=Uew16E+U53KrmQBO/Yf2+TqVESinMfXFlhnkea2UDDU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eA+vMhbKM5rL/gNhS4Lda0XDLjqA/E3AQvUuUltjb6w9SM65mtBKiz92FDxmT8NWpaZiuF4tP7/LNCQ5IXf8xctIwpfnD2FkFYTZ1R81nFRzjHfXM9dqDnXjIYibBh8xJL8qHdKtsvpyjxGpiBPU/VPGwktsqfS4McHm8kPQsgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=EUx4aO1y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZtP/t0tt; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="EUx4aO1y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZtP/t0tt"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id B195813801A3;
	Fri, 14 Feb 2025 15:35:56 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Fri, 14 Feb 2025 15:35:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1739565356; x=1739651756; bh=Uew16E+U53
	KrmQBO/Yf2+TqVESinMfXFlhnkea2UDDU=; b=EUx4aO1yg/4+5X5PJawGivPb4k
	o8lUQIWdQ7OuhHAl3Volp8QoHKTh7YnD54jmtArI3hzRGxgfLFL7tVFIG7cS1kWQ
	9FJsIG2dWBWfKizndFU4UJzzJgucoqGyiMfP21KmEqiag5TLvOUaV+Sr7ZqYIWEO
	xLJp+LwvdgOwmqix7k9SH2CCUaGwsuswmdacl95Ywwambt+dmhuKcwUoHhoED0jZ
	5hpY9Qks6BDTXB6Huasz6yc2ifALg+Fsgf9qCRQ6wyB8b0OL7r+CDYPTom+Dwk0B
	jza4/w/MYuTyOA9EqRzE4XC1Wljuq/0s8rwVaJCWaO5BGB7+heCer4aYpqIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739565356; x=1739651756; bh=Uew16E+U53KrmQBO/Yf2+TqVESinMfXFlhn
	kea2UDDU=; b=ZtP/t0ttimyNVRD/BNjFGtcEk0O8cLe3Q45aCPkPuUdQ9vN48RD
	hXZ1jVt58PHR62PnWw+uJQ4jFVohaE9VLPs+GwLDaBgJu544ycGCEhg0S6R1/i7w
	TVfLsNnluHFwefZleF+m00dIW1SkSY1yI4JzSi78VShT94CJAitwhgn1Vr+Zsal5
	zTz3Lkz2viHVGeNlaDLjtVAsaT8qmRf5VeRBHIrkgxm0KonCU7vkQahDhZhUI+NV
	UAFRG1FfENcA0jRK7R24k5ykBmZjLf/UveR/+vJyoyYMuCw1u+5txUZnxOvxreZI
	CeAtkyaMMmS9B4tKqTC8I/ZnmwsFh3p4Pxg==
X-ME-Sender: <xms:LKmvZxatZjxhY82d6GSUQsXXr1MJ7ItyUtuDuLxlnPHZ2uCnDRIDqQ>
    <xme:LKmvZ4aSd-M66GYNp-q0u10S46TxzxJ51bmdA0yvz4AqWmAVW2WDQULexGSraaimW
    GZeyVLU1MvKa76ZaA>
X-ME-Received: <xmr:LKmvZz8fdob85USHM6utsy7Cl-uqtywL_M-XFKUjQ2Fw19hFJLrUzp9brkM4xcxnm7YLuE9tVxcSJSSDQ_KEwjsqcpN5N3R-LKQwPfs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdehtdeivdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrnhhtohhnihhnrd
    hgohgurghrugessghoohhtlhhinhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgvsehplhhuvhgrnhhordgtohhmpdhrtg
    hpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopegrvhgrrhgrsgesghhmrghilhdr
    tghomhdprhgtphhtthhopegurghnsegurghnihgvlhihlhhirdgtohhmpdhrtghpthhtoh
    epghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:LKmvZ_pTVRVAUbZAOPczCDi5lJT_7ABPpMGLffxmT_2DdT_ZIUm1HA>
    <xmx:LKmvZ8ohgzFKnEd5xv4UaoYpk4QuWeLr67nkPdOI8WFixAMwghstDg>
    <xmx:LKmvZ1R7T7hJfvNgZCm0DYJKGfyXkvUAMb72x89GCumWCk9QePd66w>
    <xmx:LKmvZ0qMst5mdpQmXb2dFGWXhSloC2MelR4yTwHll9N8D8Q5-oQoxw>
    <xmx:LKmvZ0LKokcbHG2n4bqrvHfJRjwkgH9WRXtoXDcudbaIUF9C4EKGHw3t>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Feb 2025 15:35:55 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Antonin Godard <antonin.godard@bootlin.com>
Cc: git@vger.kernel.org,  Emma Brooks <me@pluvano.com>,  Patrick Steinhardt
 <ps@pks.im>,  =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason
 <avarab@gmail.com>,  Daniel Li
 <dan@danielyli.com>
Subject: Re: [PATCH RFC] builtin/log: include From in git show --format=email
In-Reply-To: <20250214-git-show-from-email-v1-1-df6469635454@bootlin.com>
	(Antonin Godard's message of "Fri, 14 Feb 2025 17:31:13 +0100")
References: <20250214-git-show-from-email-v1-1-df6469635454@bootlin.com>
Date: Fri, 14 Feb 2025 12:35:54 -0800
Message-ID: <xmqqh64wl0wl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Antonin Godard <antonin.godard@bootlin.com> writes:

> Currently, when the format.from and format.forceInBodyFrom options are
> configured, the command `git show --format=email <commit>` command does
> not include "From: user <email>" in the body, even though I believe it
> is expected when using this format.

Aren't "format.*" configuration variables for "git format-patch",
and not "git show" or "git log"?

I do not see there is anything that needs fixing, but I may be
missing something.
