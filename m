Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9EA820CCCA
	for <git@vger.kernel.org>; Thu, 25 Sep 2025 21:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758837234; cv=none; b=gPYQqtoTTGSL89GhRQvbljghzU5l1+dSQM4Rh1EhYb4iD2T4zAYtVtOgBvzn5EhCvaIuk2V8p1fTi6KesTAsAuMuFpEtIgteLIqtTY/1G9DEaAszwgpD1Yb6COGfVNQ/8zEDWT0S8a6cPz9LRagMBhc6Us1QaBkPVuF8YImJ8C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758837234; c=relaxed/simple;
	bh=PcmrqfyFRwGiis+5EKdl59nvP41TicAp7DDJAp8JNy8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DcGn8ZilJxGqS+ESg5nawumWgYtm72UEp5VuZb6OIhamBEb1Dr5bEeGBrjMc0domtulnGzXp703h2qAOJP9vkxhc+gcXYzJfhyQWxLx0cMe5tlIVZ67wnHs6/uF4tTHHINIxWVQsJOvI5xXUmUbnk8SJ1D2t5QlB5O0P1YMLdac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=rjos6FRQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=obzMkI6I; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="rjos6FRQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="obzMkI6I"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AC137140008D;
	Thu, 25 Sep 2025 17:53:51 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-08.internal (MEProxy); Thu, 25 Sep 2025 17:53:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1758837231; x=1758923631; bh=PcmrqfyFRw
	Giis+5EKdl59nvP41TicAp7DDJAp8JNy8=; b=rjos6FRQUH0DbYi0UXRhZKLy/q
	sgSQw0TrQk4rP92Flixx/C6Yq7vRourqPFTzP6Fijb7h5w/jalKiy1W+48mgfFHX
	8Ji4Hwn4EDLYSzPnSw3nABZBl9rySa7jRASphxKmBGjm0pHjnTo4Y3Kfk1iUb71m
	wA7dUpPbdMHyqEcOx4aQtgAZu0nNNfaYuTnjzyiDil3r9uRfCXEpbiMm3cM1j7Yv
	KC6Ux04cJQ82Y1x94GzMSLrPoiiBxOBHdCvMvRypzcMkOXT0Rezd89yvNzoWsP4z
	awmwvLXiM7MQqHClKn2m6IwlRMiAv34eYTyB7aLGn0MCwkb/cEcP7bBg4K2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758837231; x=1758923631; bh=PcmrqfyFRwGiis+5EKdl59nvP41TicAp7DD
	JAp8JNy8=; b=obzMkI6I8Rf0bjc7VKLcPw4VbuERR6UuA0lT8OGvkEHI+M+iR7h
	GBhvwXhIFmAoeCi36/ehpzflGnGa7hZdk+x0ju4LLzCopX9l3jqvAf2eV9T3F/f4
	HkchDWTN0B7etyK2o9G/xCEOP5QtFNk6YjUqWnthj8IRpHljPUVbOsvXZCzt49EX
	VUfieFDdm4xpReCjmHgt2Q3hjbx9TSXCd2WOFDiYnoP3RU5cW/92IMZZUSeOTl5/
	n8VsgrCLrcJCbUkr1cmUIT591672BifbbYHA9nYy81lbNfLd2dOEfXqyWzbWwktj
	g0i8GnhbeRRbCWyqIekY1egjH99WIfHgeDw==
X-ME-Sender: <xms:77nVaL3mKN2Uo1BLu3cxljkbocfdxxiyj4wcWicSW0qwTdAVAZ3ZJA>
    <xme:77nVaJIHXRQSHFmne5gL_zvXCZb4btLC_1zi4L9Vfd3pg9WfsBrtkPemCMGTAeItZ
    C0FruubhYlRZWaw9bOf8iUeJ-Z8fxCeoaCgPvxy8J_xjnQSpZ1GoA>
X-ME-Received: <xmr:77nVaCEjjmrYJv3LBWmF-tDz1Amq0RjOnCcdjTJbxAKzPrfhKIaa2B2RYrfZXuxrosbZJb2bCV_f6ApY0v6jap8SXRSG-QHUpthL>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeijeeivdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopegrughrihgrnhdrrhgrthhiuhestgholhhlrggsohhrrg
    drtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepvghmihhlhihshhgrfhhfvghrsehgohhoghhlvgdrtghomhdprhgtphhtthhope
    hruggrmhgriihiohesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhi
    mhdprhgtphhtthhopehsthgvrggumhhonhesghhoohhglhgvrdgtohhmpdhrtghpthhtoh
    eprghvrghrrggssehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphho
    sghogidrtghomh
X-ME-Proxy: <xmx:77nVaNW4aYe9EydncuvV7Q_Xl-kEid6wX6pEwm6EJXJJywOfLF_RWA>
    <xmx:77nVaCyfrebp63GKZxGl6l7oAYUuOKJMzOXxoWcyTo4WHLnmIwrTvg>
    <xmx:77nVaKRLNvpFO_Fp2T0B1gX6xB66jZgYJ9UlIZsf-yHaLQOS_sFkfQ>
    <xmx:77nVaGjdBsf6uRTWQcwkg4nZW-zpsVufNpCjlGi-KZxq63Q32wDxUA>
    <xmx:77nVaGh-j97vqhPbnGmyAWhXss3VYqBN1AE5wsrN5CEDbc1l3-nwWs4z>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Sep 2025 17:53:50 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org,  Emily Shaffer <emilyshaffer@google.com>,  Rodrigo
 Damazio Bovendorp <rdamazio@google.com>,  Patrick Steinhardt <ps@pks.im>,
  Josh Steadmon <steadmon@google.com>,  =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?=
 Bjarmason
 <avarab@gmail.com>
Subject: Re: [PATCH 08/10] receive-pack: convert 'update' hook to hook.h
In-Reply-To: <20250925125352.1728840-9-adrian.ratiu@collabora.com> (Adrian
	Ratiu's message of "Thu, 25 Sep 2025 15:53:51 +0300")
References: <20250925125352.1728840-1-adrian.ratiu@collabora.com>
	<20250925125352.1728840-9-adrian.ratiu@collabora.com>
Date: Thu, 25 Sep 2025 14:53:49 -0700
Message-ID: <xmqqldm2dwr6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Adrian Ratiu <adrian.ratiu@collabora.com> writes:

> From: Emily Shaffer <emilyshaffer@google.com>
>
> This makes use of the new sideband API in hook.h added in the
> preceding commit.

... to achieve what?

