Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1634217723
	for <git@vger.kernel.org>; Tue, 14 Apr 2026 13:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776174102; cv=none; b=VjcM8zBbWj6YhlLmdz/np2Vkt9zcmV7ESBYIjTbQ6T/KYjxkPERv0sTB9hcR3cdjnMivuN+1/pzAN7Iz6nw0itb8tskxYYJisDoWyyjZyq+aoFq6iNNTDX2Yvty/Q0jVG0ZNBOwCbPH08OrQMJdU4Uxgy09ysq8lw5ldO3GAWEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776174102; c=relaxed/simple;
	bh=ofY0iaUMyuZUTHd+ITetJWJELEr5ErZnZ81fb6nU7yM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FIDadweSHhVO76zUsz9TefL+wiXLTukuM/6JK8lpA/v2qdlCV9JiHA1vF8XXvMLwb5e9siizxyV2tRZt/nqV7f1Qj3SfGHXxkWcBPtv6QHdpRMTeIlKGkFlpbA5yYLKnShB/69sr3nEk9GvnbKc+PSo2k47Qll/8TrjTs/EqArQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=cEIW11Nh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TkAqz/oz; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="cEIW11Nh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TkAqz/oz"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2E9F57A0067;
	Tue, 14 Apr 2026 09:41:41 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Tue, 14 Apr 2026 09:41:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1776174101; x=1776260501; bh=fD2zatYke1
	jn6pM6dKo/j8D0JWfzFUoVF/O8WgQ+JbY=; b=cEIW11NhUP63xH5K1cnQ/ya9+j
	y+LXeXGi3pWb7+t84PfUNDC8Vn5IOxHxGpIcsYkK3XKANZFofr6ugvArnd9ZM4Uq
	vtaGMWm5cJUaKrUR/qi07QQIZM5RyiY2iTZgs9e83LNTG/XQTCI804/o6N3fbftM
	iKNEHl3T5v5tQUw2uq00Kf3GSA3fvTNuh2JBf/f5tj6LUxTb+0G/sAhFVNqty9S9
	IlfjB/bliFQT7DD13kEPRs/Ene5WyMCJ20oyaMRzgGROO8BEsTre5Mb8ngV7+EMW
	IKxMQH5q3Wje7W+1ipkI05c78Hu9qTaJ1jord3t1MS90FcS46qAZsq9O4cgQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776174101; x=1776260501; bh=fD2zatYke1jn6pM6dKo/j8D0JWfzFUoVF/O
	8WgQ+JbY=; b=TkAqz/oz36PSlyUIOlKaSfdQmfn7mywLluUfvdocbt1EOQmXtDP
	iDg4CGP/TUR1wSeEIyU2O6V/fD2y87z1NInNqgRc3T2hMr/zCQxngU1ZWS0omYkK
	U+qn6n5nDDt50z/P4pQyHV0Xogule1hqE25BDHO2nMOx6+OoWWB9elB6lVe34Kh4
	UrZUzGAA71eWSx0JZD6fv0IqPfosvVRYV/cavIeV3qQN397c3OGirnjUBgXGhql6
	FZPEkhJtT8Je/gqTHOEnAvp7updI5NOQVDLHiB7vwDHl3ovf7w6R/h/Ln48rZCOO
	5mBAFHNylu269HApJk2aB8ISVGWnA/vzoKg==
X-ME-Sender: <xms:FETeaQiBGe75aSLcMYecRazmCFbO9g6_9GvUMn1_8rHmqbntmnIk4A>
    <xme:FETeaQcY-99jOLkIIHD66gjHcvw6ACXsfxNQhdTla9zEmWUNZN70KBG_AM7Om9fKa
    AI8H8Nz6V89r1KjvHu8TtNsm0cX6SFtOrlE3PDSfJjlm-MKIAy7og>
X-ME-Received: <xmr:FETeaVeNcWKyh7DF2411CKwjqVo969ytslC0O3z8_SmPIB0ULoXgU7Ruxlp-Ic4QZWoCqJCP8lvD7ck3M5j2xQGqyfc3w8T7CA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdegudeftdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohig
    rdgtohhm
X-ME-Proxy: <xmx:FETeaa_bU5ZfEwCU3jSYGaAaLc4LFklTqZmBNud4_GYdFmWn0Z71gQ>
    <xmx:FETeaRk_yQpOK2FmvY_bPS55bEu6NTsEGoH5rbFBcnoHDo3xncNg_g>
    <xmx:FETeac_U_Um04BzKKHBdlMNAuRAvvidFht94ZY7_2LymW4vi614p9Q>
    <xmx:FETeafmf7KwipJoijY2AamHrIT7rPsXz42VsUbWJ_gG5bHlkcjWbwA>
    <xmx:FUTeaYkVHuTbZK0-jsX-9g1KeLIh1uvfgiTmxAyFEtI9mTcsymSpUqAF>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Apr 2026 09:41:40 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 06/12] t: prepare execution of potentially failing
 commands for `set -e`
In-Reply-To: <ad3riiF5QWuMmUeT@pks.im> (Patrick Steinhardt's message of "Tue,
	14 Apr 2026 09:23:54 +0200")
References: <20260413-b4-pks-tests-with-set-e-v1-0-5b83763a0e84@pks.im>
	<20260413-b4-pks-tests-with-set-e-v1-6-5b83763a0e84@pks.im>
	<xmqqtsteiy7s.fsf@gitster.g> <ad3riiF5QWuMmUeT@pks.im>
Date: Tue, 14 Apr 2026 06:41:39 -0700
Message-ID: <xmqqeckhek18.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> I'm a bit confused. We do exactly that in "test-lib.sh" now, see the
> below hunk that is part of this patch. Am I missing something?

No, I was misreading the patch and "$GIT_BINARY" >/dev/null in *preimage*
was pulling my attention away from the fixed one with "version".

Thanks for correcting me.

>
> Patrick
>
>> > diff --git a/t/test-lib.sh b/t/test-lib.sh
>> > index 70fd3e9baf..81380fe978 100644
>> > --- a/t/test-lib.sh
>> > +++ b/t/test-lib.sh
>> > @@ -143,8 +143,8 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
>> >  ################################################################
>> >  # It appears that people try to run tests without building...
>> >  GIT_BINARY="${GIT_TEST_INSTALLED:-$GIT_BUILD_DIR}/git$X"
>> > -"$GIT_BINARY" >/dev/null
>> > -if test $? != 1
>> > +
>> > +if ! "$GIT_BINARY" version >/dev/null
>> >  then
>> >  	if test -n "$GIT_TEST_INSTALLED"
>> >  	then
