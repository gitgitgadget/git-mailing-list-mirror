Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B86C49362B
	for <git@vger.kernel.org>; Thu, 27 Aug 2026 06:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787810820; cv=none; b=mNE+z/TF6gGP2dcW14qDpKKMStRYYFXawkeomPp9ZETd0mmT0DijFSwAdan89/cd9nGsulrT7C6I8Ku6r3LYxRFGmxw3Hw2F1IfZY+c1MPGDVgg4XgBUannX8blGpM8qcwDUKf8RTH5AbFzizO4k2joOmPI8NpCCXvBf2LEeStE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787810820; c=relaxed/simple;
	bh=BM/cczbHb9Fbc7dTqG9A27alI74sMnC+cd23wVZs0WM=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=nEFn5cVlBMCG1+7d0FWZrwsGR0PDJIsdATCzXMLKfOyYZGSCsEF1j77l5b5yBaKP8Cv4SurcLp8PGv0aX6h73K5yvN+ZLbN9dqq3s+ELTzaxeUhz3gyNmnCp7zOQjPUXNyvlMw8LABap5fLOT3ayd2C2uBDFzTH4DIvCDyUzd5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=M/CvqDNj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PXjNNUkN; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="M/CvqDNj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PXjNNUkN"
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfout.stl.internal (Postfix) with ESMTP id 261071D000C6;
	Thu, 27 Aug 2026 02:06:57 -0400 (EDT)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Thu, 27 Aug 2026 02:06:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1787810816;
	 x=1787897216; bh=QlKbiDYqVyoDVPHlH0+TZB9KkDImQHA5yP8duVz8j1E=; b=
	M/CvqDNj6PSRCKaIFPFor3IvGycDLU3oj5skmbyvYzq1Ww7uNgV5YyjLcpz4h2jg
	KiwJZCFs1fl6w5cYXi1SV5Wgd95tb3uCfWiQhPHUMmKKKVK13MN/U6KanrJ2+CsH
	cecbAs3OXv5GQO0qYvBrCK1VYFykLObqhcop5OAr1SjoAMaJVPc9OJfmNCdw36Ta
	6Ed+SKoEqLoksjpKQH0O+8RaFiJjBn9kHAGqH4PA44dHXOwbRjoejeN2ksylfNPF
	uRGr/1BdQoTTI2ypokOTdyCNi1bkvRCCNgnEReEpwaqGWyZVNmVTZvX47hAlXCZn
	JphArySgrZeANQ2ks9bT/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1787810816; x=1787897216; bh=Q
	lKbiDYqVyoDVPHlH0+TZB9KkDImQHA5yP8duVz8j1E=; b=PXjNNUkNFwQcCo9ty
	+Aqfs11b+MOC4FXd0qLCg7EWsy56Wrstbr3vTaOjtAqjW7arwKXAB7W3Cs89wo8W
	+RY9pgdfV6YLrOobS0NSv5qDg/VxjYEVO8OV8AsHoul14Q/oIianpb+WOYlDkORW
	BBSkFE71ZZSGJoF9EecyDVJfl4txTz8s/9f7rd1GsLnaqVSukIdTVdhSWmkTxDI8
	9UcLcWKVw51hNrOPdDSxP9+j+OfXsOatqOsxkcQgDrGW7wi8J2b+R3UxzHmUI5h1
	TSIiBDVvBkO1qeWJrsAuvI2qnHNqJ8mHp7aViUeFw9vKzSe+gtOb//p5BmMHOuuc
	VwA/w==
X-ME-Sender: <xms:_dOPahJ2flBAdPxBEIIAXfxnPD5erkefMtSIm557B2ojwniWG392i3k>
    <xme:_dOPan9FEzSUhBb68BKjxRK1PsS2N_PyDCCjXPVwh4CZxwhKld9eHesfuLM3hH9v0
    U0kM3azlkYfhyDEnqBYVTN366a3XDzjVqVd5Nq3LMii1F6H8fwOL5c>
X-ME-Proxy-Cause: dmFkZTESnE7DZt9BBdDKnNdVS4h8+JWDk05fYVFidx1Wf3Lp+xQm9SPubDGbiXi0mX7EY3
    98jFIR+ViDy7At87gZlcSnO1rBj+qtZWJuNSg9DNQR7tEZcgdDpEiME7Fq64dLOrDDFTyE
    s+YvYLyJPVyJ0UM8TY185sXh2RRRVf8++3t0E9e4bl+sUx6k/IB2bU+XhbY+5hF6mQ4Mfd
    xBb/AFLkkgj9SFbrT7IyI7SRSMPgCPKEbT4PBi/218cT5ZOSshl+r/QpHT5YQZu8x551aV
    M3v1mx8nmG5x3JjmkFRCrhP6IOadYRVjitz4uv2Yzp7qr12W/tmGHe6y7Jv9hpEG94Pwg7
    x21tPkRjjE+wlBsSkbYsYtpQHIbbE0vwSp2Atf/Q4/NlJs/gJVFZczK3EgAJcIejZWW/Vv
    4WC4yIZlomLe10c0bnpXCuXKj6WappUzFc6GuAjqr942GMvIEsZubeGFesEgh1AUFikgP0
    nX13Rmsxisyds+UqYf1tBvVtnf7DlrztEpV4MzdJIHwR0oK+/Dv/jh7asWbNI/If8+b0Gp
    GY9OLcjslgIjexo3UkCMufMkRXZ+2Sx6rW1SPUXBd+SgYai8m6hg0Ys0XMYq+Ll+KTP7Cx
    zO0ZhopS6a5ugRFpl/+6dPTLHRh8azkrqW9rm2Wm0AbnBJr3aQHat7DjUaxA
X-ME-Proxy: <xmx:_tOPar2FeqhkWAT1DPbRpPOibktTUt_QxFrFCA-ggdFLSLM_h-joHQ>
    <xmx:_tOPaoAIaSh_mX80R7B6QziM2u_-0Bfq0LmMLf1SlA_-H0S0kP-QLQ>
    <xmx:_tOPajccIlLPYeb_606U0Z79b3AdPaHGR1smsDoCYYvA70OBGYZHlA>
    <xmx:_tOPathYK_ATAnRyfMuawYou9CZAR-2Alp5cJUDHZ7qXBRcO_wrvNQ>
    <xmx:ANSPaitTHcN-1lksbnl4oupXrFMqhtpia3gyuSOqOpmuUyMXAK4wPdEo>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id BC9C822C007C; Thu, 27 Aug 2026 02:06:53 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 27 Aug 2026 08:06:00 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
Message-Id: <b73090a1-b508-4dbd-aca3-9ab83413413c@app.fastmail.com>
In-Reply-To: <xmqqh5kgcvtl.fsf@gitster.g>
References: <xmqqh5kgcvtl.fsf@gitster.g>
Subject: kh/format-patch-range-diff-notes
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Aug 27, 2026, at 01:21, Junio C Hamano wrote:
> * kh/format-patch-range-diff-notes (2026-08-24) 3 commits
>  - format-patch: learn --[no-]range-diff-notes
>  - revision.h: rename struct member to reflect notes role
>  - format-patch: simplify get_notes_arg parameters
>
>  The 'format-patch' command has been updated with options to
>  configure notes specifically for range-diff output, allowing them to
>  differ from the notes displayed on the patches themselves.
>
>  Waiting for response.
>  cf. <xmqqjypfp2vl.fsf@gitster.g>
>  source: <CV_format-patch_learn_--range-diff-notes.c57@msgid.xyz>

I posted a response.

<16315616-097a-4fe2-8665-010e424afd8b@app.fastmail.com>
