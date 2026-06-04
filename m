Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB74231A41
	for <git@vger.kernel.org>; Thu,  4 Jun 2026 01:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780535501; cv=none; b=SZM596bU8nhNj38REpSw093YScL3fD0f5vamJmB9EwlKYgzElMH2dNKodvBA5V5gJPJ/MxKQ6W2wNAImx64HMwa1JQXjs1SB0X9OTjDl1GHDcIF6c1RkoHgOK69cMJ9OnVrieTLl/tFRF1hdypHyUgNtZBXhUmPwt1SqNqylm24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780535501; c=relaxed/simple;
	bh=JprT60Y9tPh/noQDhvdaEJbqrZ7utj2ZTTEyjCL9yCE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fIBk4bj2Ytx9AATq6CBaTt/zJElQcdMTMCbvOqWDxD8irJuKE5LASvwRj514U7XY2CGN1IagSqodIcnUiA1nyREYMpqKSDf8irxiV6la1T7lOsOu7yt2Yq5qLDbDmxbcTZtjxmlPM86gehmjMbXT7SYepyR5AXK0/wMTTIVyQcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=OKaQZfb7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=G0PK5FjQ; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="OKaQZfb7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="G0PK5FjQ"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AF5501400057;
	Wed,  3 Jun 2026 21:11:39 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Wed, 03 Jun 2026 21:11:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1780535499;
	 x=1780621899; bh=5VndDb/DM07Iv/WfqbARZaRlH3oXum2O/FrG1QxL8f4=; b=
	OKaQZfb7eozcJS1GFhDpWY+I2HrF+hEqQ3pw4EbS+29Rx/mCqIPk1fBnjG0McDt4
	rhJEQfYESBaPO3dvRc9acIcR3iRPam/Yd1IHR7OH7/hWmEj833WLAWrr843MfGV8
	2UWj4SGXewbEXj9S3AWArjVNuyjj4DDMwNV56FqKKSfE7ZuMB2LCkCIKMfvl3bM0
	d1xieqDgLICtakEdn+Y3SgWrtn3jl6JGjQeJWxPhp8FzyoEqFiDmS6MDuS5QtPX0
	y6NNrxUGCCg5+f3sgjJRcuzzvZYOSYTjYlVnAOa3n+JZ7ML9Kw9XsmOgeqMD4wp5
	pZnhD5pDMtSQFf30YfLq9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780535499; x=
	1780621899; bh=5VndDb/DM07Iv/WfqbARZaRlH3oXum2O/FrG1QxL8f4=; b=G
	0PK5FjQk5CbgLxd7SUcy5iV03mDFglxOErVe4NPuB6yUuhhMOIIZMHa9GxNJXr4I
	87TsjweNTmCsDdNzrG/uvO4flK0eeInuiFmQd9vmaxuoi3voemKq0LbZgJWfZRFf
	Fuk2RSG3FEwzBFCHErQepQkfT8pxnZXv/WPPlYPZsz4TXOktA/8iMt1Tz56SZ9sk
	TGPtQRPwHeW2o6K5nfauDsnFgtkny7aCqbwo8bkXKzuTPns6kC8oNmkVRzCqPQHp
	VUXTiFPx4UOhiQeoRCn1jkSblWjyayt8cHjKrqmK/uHEYyC87PrErvSm+ptquFAl
	tBvHRyJNhVEfxr1rvBMbA==
X-ME-Sender: <xms:y9Agaj5NZlxuMnrZXsudP5bfvygiJDX5ii2RtVaucg9ff_iss18n4Q>
    <xme:y9AgasnYjTHzg68UE-uWjTtsAci1MGrziXkPYNj3AS0dh2fIiACDZd59BErkw4WQM
    pGhMi1koL9tn8Pb-4JgIdog1X3Zn8kqH5SfQwbZ_O2uwKpCAphVsg>
X-ME-Received: <xmr:y9AgakQ-Ofq14q1LqykDlP_yjpv6gCw2dqKBmqUQfQmW9mImr0G47e9gkQfqsDqEWr_W4MbrssP-iPsDikI8CuCkwJjAFAQsKi0W>
X-ME-Proxy-Cause: dmFkZTETFEaA7C/yFs0ET5Oi+qEKG0QTAwNYtb2sNMggIrLGhjyABHn/Po56sPqttu96jw
    7JPWUPO0r5wfx46iUo991q9plfhGPV8eeNVfgfxLH6XRDawB7IGpa96rpLbDBBg6FbLMwd
    AfwMn2b4XRdR8WTMzz9AajtysZ5I5kybwvHa6DIE58rPqNE9j1Vex+JHoCXUIyAH8urwSG
    ebu/M/OU51K1RWe1hC+YZesqedSLRhbnt9Gif48D/wQY5C1XXVVOE4VZh509N/Ibe22zYD
    dBI9K4pZrBrFZoNy5GkaMcIgh5yG90+fl8y0yEp/rrmG1ayEwLHdrZX3pU+j6bTJ25nii0
    081ADfO1fT09fkxvj7y4mttpj7a7I/a4C+RFe1VWSvugyJqSI54t6tItPpna5Cfk4AeVy5
    gWdHxcRBKj1rMRjYNSxML7JvYXz4LNB+aReQdUhl1ghLOkHC0Gt33t2776NtaRS2yY+wCW
    ed58lVs2qFAfkR8vP5sBYFtJwYHMAcoWLJ8za2BKXhJzeMFZClN7fGKA+4LOpYYGNPxvtu
    fiEEfZe6teq5/cdlrHwMlfQHVZg0xfgrFBkOHktkHlOdOy6TejYAQRaYTtiSPalAv7iNAo
    mqe82Cg0BEDuAARD5ghyS/71N+n/1Fme23ZSmqL0yrxNpicyBDBvzBzgQ8yg
X-ME-Proxy: <xmx:y9AgarEK7jqGm04kytQrwxcEJpHvuXxZ11gT6XmmOowj8zBnbykcdQ>
    <xmx:y9AgapFil7QJXgGZ7UuO8Qo9w31USPSwSh4QEtYP7YM8J_sLipuxBA>
    <xmx:y9AgapRc3xGFi3kW959GeO1QPEtKH9dYofZa8ZC2-MmNSOgp2nmYVA>
    <xmx:y9AgaqLZvwdXrLbnb86hXSdhqYZmiuqjpXLBBnyhSG-C00AFsD_x7g>
    <xmx:y9AgahWokx423_mb9l6OwH98xWstfSp325eoBgqTXBPo-ris6H8yEl6n>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Jun 2026 21:11:38 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  Weijie Yuan <wy@wyuan.org>,  Tuomas
 Ahola <taahol@utu.fi>,  git@vger.kernel.org
Subject: Re: [PATCH 1/2] b4: introduce configuration for the Git project
In-Reply-To: <aiAK9eLvew+mgWt+@szeder.dev> ("SZEDER =?utf-8?Q?G=C3=A1bor?=
 =?utf-8?Q?=22's?= message of "Wed,
	3 Jun 2026 13:07:33 +0200")
References: <20260602-pks-b4-v1-0-a7ae5a49e9cf@pks.im>
	<20260602-pks-b4-v1-1-a7ae5a49e9cf@pks.im>
	<20260602170955.Z4b7y%taahol@utu.fi> <ah-Nhr2PboWUq6eU@wyuan.org>
	<ah_PyDwO1Sffr5yq@pks.im> <aiAK9eLvew+mgWt+@szeder.dev>
Date: Thu, 04 Jun 2026 10:11:37 +0900
Message-ID: <xmqqmrxbp0s6.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

SZEDER Gábor <szeder.dev@gmail.com> writes:

> No, in Git shallow threading means that all patches are sent as a
> respose to the current cover letter, period.  It has nothing to do
> with whether the current cover letter is sent as a reply to the cover
> letter of the first or the previous version.
> ...
> Deep threading means that every mail is a reply to the previous one.
> Again, it has nothing to do with the relation of the current cover
> letter and the previous cover letters.
>
> Therefore, we do not recommend deep threading.

The above exactly matches my understanding of the current best
practice.  Inside an iteration of a series, we want a cover letter
with everybody else responding to it.  We do not have a word to
describe how the latest iteration refers to its previous iteration
via In-reply-to: or References: headers, but our preference is to
make the cover letter of iteration N+1 to be a response to the cover
letter of iteration N.

For a single-patch topic (without a cover letter) with multiple
iterations, each iteration would be response to its previous
iteration, which may make it look like "deep threading", but as you
pointed out, the "deep threading" concept does not go across
iterations.

Having said that, I've seen a cover letter of iteration N (for any
value of N > 1) that respondes to the cover letter of the initial
iteration.  While it seems not to break "br" and the lore archive
does not seem unhappy about it, I am not sure if tooling used by
other people are also happy with it.

Thanks.
