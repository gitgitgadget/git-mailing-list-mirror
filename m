Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7633B0AED
	for <git@vger.kernel.org>; Sun, 19 Jul 2026 18:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784484900; cv=none; b=K0mOUEjekCJpLnCsqwyfzeuN8FU+4XV9iRD/nqzOY3qDQSRFoMUvq4TBLSJz6sOv7sxnOtqocbMoEcu4jM9POkJQaebuLoA5K0E4PQ7DY7qN9jAQgzy8GjwDTSHWbxBvhDkNnIna4aPenMvgfPtv4Z325qtKCvBwGaI/G7NcHRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784484900; c=relaxed/simple;
	bh=XjwQVk5isZmtA8ZBTY30BGgAGz0B6sOYtHYRypopeIc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sP6oNC4kGowlYpfIjc11pY0eTZ42jWRQ5Q2xv3UNwS8kNd/6LROt6UKKpK6CFrSmxrMDkYVTM6frqh7JKoNWZ09aiMorQDmsZJvkSK5h6mQE/GGxtlDXkctV9W/Fs+w8NpAKcr3JIVTjM9VXIDXRYHe32wwvLE/DRobCMNwYiQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=VH5/VOr4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Y4CM4Gpn; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="VH5/VOr4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Y4CM4Gpn"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 611CDEC006C;
	Sun, 19 Jul 2026 14:14:54 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Sun, 19 Jul 2026 14:14:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784484894; x=1784571294; bh=Yimx0KOJ9B
	XOANf+qHfTC267rT4TXVJeeqfgD4DhT2Q=; b=VH5/VOr4UrfJj3zoPRkhI6Q6ch
	HQENw3GGpe8/NVZDJ5hEXjkOzw58o6TKI+eWF76H7I/hnid1Wg2ZHCc+1l22i3Zo
	DlpPi+5rAlGcBBtgBIdkcaIwqHGKjQ9/JuJQOau5spjbj8W4ip0k6ym6EV6HfAvi
	9s0b5789yN+uxdXPq4LHStSqM8oKtvPrp2wXzI6wTJioG/7N+Koj9aI09izdY439
	xtsA58aPSdw1wbQ5Dqn0BdY6/H+nQawyJ39DM0xxC7vCG4ZAQ7ynsHu/E14pwqU0
	iHxdOY2MsGdHnq8Llx57MoWPk7jwCq2I1C1ux6FaEkmZVwoct02F1Hl8IBNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784484894; x=1784571294; bh=Yimx0KOJ9BXOANf+qHfTC267rT4TXVJeeqf
	gD4DhT2Q=; b=Y4CM4Gpn+4iTyR6U4DNMHmMzktPtCZatWauWxcrMO9DnO8RwLFo
	apZe6haITJ9rr2roS4k3qHWiWLY2U2l3Rj58tk6EcPl4Lqo47xVNx/v7Pq/CpE9B
	IyXzQ/jDDg8qZh43XDX6Y+VbBNIFJCQqnEU7D0QLVYx3JcNU/e0TsKalzfF0WsW/
	ojtTMDxsBHAPqfRrttCAsD3TGVXRPSbPlDvTLllR5DIADOH+O/DBgi65m32qbUQy
	XNGt91FiIpltd8yV9uk9psWHEI22TMzz2LTb89F75WHmKoTkrjMGmCv0k+GwyVLt
	f+dzqHAiIEn5FWum8dzJSw6KlSJ2s9/vKpA==
X-ME-Sender: <xms:HhRdasESRDP1yGeUojoXwupmZGIMd8OQZ3hxmrKY0O_LVf3R7HqZ3g>
    <xme:HhRdakZdKjPsXzSCav_Je2-K-BwogTAJkZ8VuoQkBAvkQ3UMmDfDppEf3Uq9M-caz
    tZsnaMxjYKXz539y8IIlggDRcDFX9KMG-Pp2Wx6ceYVVKVmehj_>
X-ME-Received: <xmr:HhRdasVY6xx8cZ6cP6_vqgg6Bxmbk7nQiRpUvTlTqf-grzCe-wL-W80TOx3vH-GzA4F31RFl-5bEmKz9JRT3Bmy30fJUcFaotw>
X-ME-Proxy-Cause: dmFkZTGITYsXgC1GEn97xyVfuSprFLNCuUCSwOwX8FPUfGJUez7432otpZ03aAQAB3XD3l
    bec6fJNKhX/BCgZTs9YrrPaJXOrAoLctrw98X+X6aWWj5vinyXjGcCTUa1P/U/NRLi0KT9
    O+TePKwHkghPDw8hutQI1GlFlt6z3vqynqGKD2Fq8UaHG35ZnqWrM2nzlo/+E/RqQTI7oh
    O93SL8iHrDtrZPtrsLsU8K9eD/5Rpsn/BQ+rNGBKPi2KR7PP8UuuTqHddK/UkehquzLQH5
    o+cxmAeVx1sWtyhwaRihfnUYQiXCl9lS4IoZiUaouaBOqc62ypmh9PZtgdqjQvDJiq6CRx
    fLzor59oLpLHZ4JJybOY7Ary3R6gQqoMEmoggN682UaIbJ9vSv5YrazkNTSpjPKOttwMA0
    BGFUeKxcp2zhV7wOe8UixmLHL7sZHC7IfhhdK9y8wc9poq4bHWG81WIQGmk1PIzN4JKdcV
    oUyvzg0mwczbr9oNE4OqYQnajo9QfqiIQBTB+NleHh5Tc9jue6cmd1uHifWatgZisN9SM5
    e1o0tuqysuszFGc4kc1udmawwuE8qCxj/M8baONrXpGTSXDd4evqp8RZDoQeswvv/WkpZb
    BtmpDMz2uZmii/GwaIJPQEAZ66CqKNAh6Acc6QZArGFNyWGdf2iXx8s4+tcQ
X-ME-Proxy: <xmx:HhRdaqnneuJ7KKKEyMtlsl2K7RcgDa4QPVCOPVoQzUHi5Ja4V9JvzQ>
    <xmx:HhRdanAHgSDYcx4Qy7ycpy-25YZxb9uvb-805Q0YpkarG4sfUAQZ-A>
    <xmx:HhRdapjIlp9WXuZHLo4idwOTpc-5i8s6w-0LBc-7xfM4lI_PZJkagg>
    <xmx:HhRdakxJT6pqZP5p7hgJtB_nzaDGZoZjN6ax67OMq3cbwllNJBpfSw>
    <xmx:HhRdauuq90qWY-0InlF7VpSxmvQpcu5CEXcPyVBmdmS03SF9bSLFRvYI>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 19 Jul 2026 14:14:53 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Kristofer Karlsson <krka@spotify.com>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Derrick Stolee <stolee@gmail.com>,  Elijah Newren
 <newren@gmail.com>,  =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,  SZEDER
 =?utf-8?Q?G=C3=A1bor?=
 <szeder.dev@gmail.com>
Subject: Re: [PATCH v6 00/10] commit-reach: terminate merge-base walk when
 one side is exhausted
In-Reply-To: <CAL71e4O5=ZJoPD4dnPmh8mjsTKtugx05-8d83VeQdBNOjp=bFw@mail.gmail.com>
	(Kristofer Karlsson's message of "Sat, 11 Jul 2026 23:41:00 +0200")
References: <pull.2149.v5.git.1782923832.gitgitgadget@gmail.com>
	<pull.2149.v6.git.1783776466.gitgitgadget@gmail.com>
	<xmqqv7al9rbj.fsf@gitster.g>
	<CAL71e4O5=ZJoPD4dnPmh8mjsTKtugx05-8d83VeQdBNOjp=bFw@mail.gmail.com>
Date: Sun, 19 Jul 2026 11:14:52 -0700
Message-ID: <xmqqse5en8wz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kristofer Karlsson <krka@spotify.com> writes:

> ...
> After that, all ten patches apply cleanly with git am -3.
>
> I should have stated this more clearly in the cover letter
> instead of mentioning next at all.

Well that is how I wiggled the series in my tree after all ;-)

In any case, we really need to get somebody take a look at these
patches to move them forward.  Any takers?

Thanks.
