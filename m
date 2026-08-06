Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5B933C192
	for <git@vger.kernel.org>; Thu,  6 Aug 2026 18:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786039782; cv=none; b=vE9Y+PN5HaL40PSo1e5n/fC3KeFYY7zAuLryD+cJRJgG39Jc/czFjsWeIb9SoZ+RRdApFs8ABz8SIbuRVv2Sei3VwhuEdzG7dzwW5a+TF7thh4rP6hdaO9yXl4T4XgeKRlyAh2OxXaXsjmVqOIKlLs9PoSjI1CBYCcgMFQfIaEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786039782; c=relaxed/simple;
	bh=+2aCkU23EDNFeIeTsNlkMDx4x7FiIKFj7XYKwL3wUPQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kzBuQ+AQWZzoGEwdPIxVnlk+ny5JIDDb66xAS+QTvbiMRL2+qZVOe3/75yGGWEhKt/XlEzicErUTepJteAauYo91n+pZDJ02lRa0FAuHAn3msSgI5ZszvO9O7uoelDoEyMfxWwNJ4LANXnyotty7Vvjb0MmyEUXfAEPwjGf02Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=AxvQNAj2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SySrX6mg; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="AxvQNAj2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SySrX6mg"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B6B1E7A00E0;
	Thu,  6 Aug 2026 14:09:39 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Thu, 06 Aug 2026 14:09:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1786039779; x=1786126179; bh=+2aCkU23ED
	NFeIeTsNlkMDx4x7FiIKFj7XYKwL3wUPQ=; b=AxvQNAj250tEyL3sFLWza/Zx3G
	IS6grtEu4yM3ZVL/iT21px2jk+z9931t7EI9hbVvVGDZ+d+nGUPpBNmCv4hsx/iP
	1s1J710OvqEtJ5iaRw/UQEjOQImJw3ZRScqWfWTX0blTULRjbfYyEMaxEXrykDJ6
	LbO955LZbUODetCbge5OaflOyCxYkntZut6iekmdyryOHNrlrHoXXuPRlGRCfJQF
	puASaDwUQar8zWcAcfbGRDIYtpXwmyT58Be0H46GIv5VgynkpLiq1SgtJxBCYrcr
	2IT1lJIbypYiTV7Br8c1zIWLGWsdrEilSxx8Sk8qR6p76Ulb8A2XHwMJAqnw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786039779; x=1786126179; bh=+2aCkU23EDNFeIeTsNlkMDx4x7FiIKFj7XY
	KwL3wUPQ=; b=SySrX6mgfUnj3JrCaMJIoOWlQYEb+0f3TIrsr6z/GCsmP/KipVH
	by26Cszi2AsvhZRhxZA3uilv4dUID6vcywhc/hyxkHe0ewk1LMitQRi1LD/vTfUn
	lwX/b5vd439IPZHs2nD6nRg9QnJJcrqYMxTbF9oGAOMxwIEOf5eupZzFhqcIzEiG
	fmp5W6QSEtUROApuhxrc2ImVqoFPIELYxV55ltwbIl6As/kdSp3/TyL7YkRBaUtt
	9sL26fmEatGQEFqrD49k6Y79KrM1CFxHlGHOd6kcXtu/7Z6kl/68ayL7nD6sJly6
	mzxpdPK6rsCcd+8NrNJojUl78md7Wkn5diA==
X-ME-Sender: <xms:4810ajdGuISNhCikGyaRHL2L9l2mA1OWOD96szuSgjv9Nyg1SG5TJA>
    <xme:4810agpHETAAepbCkvWfn2qFEoIbLgjMgCHZz2JPCLdQ9yfCr5MNuQvXMFNwFlqVE
    8tahwccBbBZjD26OEXMR-qfUeND6k3i2-fweFCsAA8Smd2rGn5hOg>
X-ME-Received: <xmr:4810ap5D5FrDSUwuzpEGVPRtXUc7PqmzdJwxG33IseRXJHZ_YlX7lJIMbdlN9VEPbILJd4ecKQqJWJWJIbexiUBF__3v7XAkGA>
X-ME-Proxy-Cause: dmFkZTFVqfHmoL2f5fCAPpvueklHmxQrbfs4ZUidmSo0A2sAgFEX8yvX3f+lDwbyWCjNQF
    S35/56f1Vrnr4o67e0blO8jU+XIccxh+GG6neguPzvKYQ4izUotrEMNS1DwFZ8oSrvqOZf
    pMgtIeWh5B3Fs4/hDQHqA7UP/sQvNzLYmp9p9V34exW2y6xdJ5OeStP6Qxa7wS1Wvj82zw
    gTU5CzJkJ8twEQ8bONI8ITme30BqvrARJamZ9hGUWFkFkFlZexBzG4OdpTU80DRQV+lOqC
    Rpccgg6G8GYDpibBAQ5iN+z9WOYTZjNlkyRoGFE9bYE06+n3QSbGwCtqRg6bonR7KZeNh0
    VfP8Y7JXsWz5aiYn41x1cr9bdms3vpGvYKBDyivvTaSVVaexCG6FqzlVUhtZU+e3owexeJ
    uipLFD/pf9ocaTsFiAlNTczx2WC0j/xqfVIzwQFuBLcNEfyJhoHa/OmNXxYIuNLP8fmI20
    Yrvons0WnFT/2+uf8O9uQXQ8JLiJNMZQDWCxJj/LyE2sTduGAoWuLzLaAa6dVrGOpbyyJT
    F7I7qjOP41EXod6bhP4nd0VdYRDcbBMJXIkfBKcjLMnMnFCiLnwech2WuQE9TXfz6/Mjqh
    MD6bdCjbBfHXFcdbcf/o1WuZCxLQro7fGGH5t31kou8slBmECF6WgeqM1yYA
X-ME-Proxy: <xmx:4810aupBYwqPAlaWlpURIsbf88gdsFXF2VFj1K5cyq9ijMlWnT7pgQ>
    <xmx:4810ajjIlLOcIS2VNdzlSqk6khlDcdBQW3prmOyTtOVfm2BZPE3wwA>
    <xmx:4810agIRbVCCYxsC5lrMiq7PazFFxm52Q--DkjCw41utC3LZLOqjNA>
    <xmx:4810arATYxN5o2kZ8zeYmOZA8jKBF4Hup7KNWKZYikH8zql1itR55A>
    <xmx:4810asphsMgd2wCk_cob2WAqzgp_iKs0DndPy5zPOvnbTOqiL40AbZ6z>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Aug 2026 14:09:39 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Itamar Perdomo <itamarperdomo@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: i am still using whatchanged
In-Reply-To: <CAAqPR-3F3sKCJ6P3pfYoGpw1d4zXGmoFsTm0m_xnX5Gg+pFogg@mail.gmail.com>
	(Itamar Perdomo's message of "Thu, 6 Aug 2026 13:30:00 -0400")
References: <CAAqPR-3F3sKCJ6P3pfYoGpw1d4zXGmoFsTm0m_xnX5Gg+pFogg@mail.gmail.com>
Date: Thu, 06 Aug 2026 11:09:37 -0700
Message-ID: <xmqq8q6jjf32.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Itamar Perdomo <itamarperdomo@gmail.com> writes:

> I read the changes in git when used such command and i send the
> respective mail to report that "i am still used this command"

I think that the instruction tells users to send an email if they
still use it and are unable to determine a suitable replacement,
after doing two other things.

