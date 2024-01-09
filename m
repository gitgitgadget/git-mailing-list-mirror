Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9623B782
	for <git@vger.kernel.org>; Tue,  9 Jan 2024 19:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ih95WwWi"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 7F0C62846A;
	Tue,  9 Jan 2024 14:57:44 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=XbJsYyjVfMHJK9jq3nNRHikTWidLA5Rr/p21Wd
	m7GLI=; b=Ih95WwWiYLfGOyRggvnfdcLWXd7K0PoV7Z+/Ik5hh++KyMhFeW987Y
	5drt8ib0be6/TlSxWYVdahX7XraDOVPFx90Y8LGhCIA3hSzG1n+NAV4Tro0Bn/Zv
	jY3QwIM30OTndphb726juv+yvARAHfKVqK3Y+j3R/X8NNhNWTsoVo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 76C5328469;
	Tue,  9 Jan 2024 14:57:44 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2331828468;
	Tue,  9 Jan 2024 14:57:41 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>,  Git List
 <git@vger.kernel.org>
Subject: Re: [PATCH 3/3] advice: allow disabling the automatic hint in
 advise_if_enabled()
In-Reply-To: <ZZ2QGYBBmK8cSYBD@nand.local> (Taylor Blau's message of "Tue, 9
	Jan 2024 13:27:37 -0500")
References: <7c68392c-af2f-4999-ae64-63221bf7833a@gmail.com>
	<d6099d78-43c6-4709-9121-11f84228cf91@gmail.com>
	<ZZ2QGYBBmK8cSYBD@nand.local>
Date: Tue, 09 Jan 2024 11:57:39 -0800
Message-ID: <xmqqjzoigtzg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 58B154B0-AF29-11EE-8207-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Taylor Blau <me@ttaylorr.com> writes:

> Looking at this test, I wonder why we don't imitate the existing style
> of:
>
>     test_config advice.adviceOff false &&
>     test-tool advise "This is a piece of advice" 2>actual &&
>     test_cmp expect actual
>
> instead of teaching the test-tool helpers how to interpret `-c`
> arguments. Doing so would allow us to drop the first couple of patches
> in this series and simplify things a bit.

Thanks for a dose of sanity.  I too got a bit too excited by a shiny
new toy ;-)  Reusing the existing mechanism does make sense.

