Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD941ABEA4
	for <git@vger.kernel.org>; Fri,  2 Aug 2024 23:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722641514; cv=none; b=tQaC/I3qWwBio6PVaOQ6qqCJSYMnC35arSodoMXXbSKBkf59wIxHpMcbpcrsKa7yBluWySV5x+f+FMdQKMhCcKTTpH+m35EHOresykKFlljIKAkThyh79CvX9JUf6/kr9S4kix8mGAMhN0uB0lufVSId++NXYKgTQHE435Fx4kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722641514; c=relaxed/simple;
	bh=9RzJmys1rE9FrQC6+ahXZKiN8+9md7sugf/ol3/w9aU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TL5E8ig13zXwszb86lvnEkZry1nDF1ojclxbn20qOMUJoLs43n8Fb1gdFugKPDtebRzdpP8rcAbtH62uvWRsLiqFA9Hu0NyMuSaIRBVwA5Y/1VQPdxYz9BFoJRM1igmLXuFyZPLLnh1odMKKDpk2zeoQE1OwiChMlOU4hct35j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=XoCl+6qd; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="XoCl+6qd"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4E74818E59;
	Fri,  2 Aug 2024 19:31:52 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=9RzJmys1rE9FrQC6+ahXZKiN8+9md7sugf/ol3
	/w9aU=; b=XoCl+6qdYGqwsOniwLM75kiqsHBu4MVpLgaO7282yKeg+ribpsvVfv
	/o8JRjeU5bYraXGHx32UNy8elveVV9Pd91SW8uRdy89bX/xX0jDMti1gcFLqx+HP
	aAcONOQ1Uu22hwUdUazLVKQqZ9pYuHEi/RjItGumWeKcuycwZ+Niw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 44A8218E58;
	Fri,  2 Aug 2024 19:31:52 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 93F8218E57;
	Fri,  2 Aug 2024 19:31:51 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Emily Shaffer <emilyshaffer@google.com>
Cc: git@vger.kernel.org,  "Randall S. Becker" <rsbecker@nexbridge.com>,
  Taylor Blau <me@ttaylorr.com>,  =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?=
 =?utf-8?Q?_Bjarmason?=
 <avarab@gmail.com>
Subject: Re: [PATCH v5] Documentation: add platform support policy
In-Reply-To: <20240802221948.2367124-1-emilyshaffer@google.com> (Emily
	Shaffer's message of "Fri, 2 Aug 2024 15:19:48 -0700")
References: <20240802221948.2367124-1-emilyshaffer@google.com>
Date: Fri, 02 Aug 2024 16:31:50 -0700
Message-ID: <xmqqjzgy8psp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 6542AB70-5127-11EF-BE2C-34EEED2EC81B-77302942!pb-smtp1.pobox.com

Emily Shaffer <emilyshaffer@google.com> writes:

> - Wording and bulleting format fixes in commit message and body
>
> - Clarify cadence for tests against 'next'
>
> - Attempt to clarify dependency version minimum requirement to something
>   reasonable and flexible. Note: This section still probably needs
>   better wording; I took a crack at it but it still feels awkward.
>   Suggestions welcome, please.
>
> - Be more realistic about finding non-intrusive platform support
>   approaches ("we'll look for" rather than "we'll definitely find and in
>   fact know a few options in advance")
>
> - Move up "Minimum Requirements" section to the top, so we don't
>   bait-and-switch maintainers of platforms who don't even meet the
>   baseline but start making effort to set up testing infrastructure and
>   so on.
>
> I believe that this version addresses Randall's concerns with the
> "minimum requirements" policy. Are there any other outstanding concerns
> with the policy itself, as written, or is this ready to go in (modulo
> nits)?

I won't be able to speak for Randall, but I didn't see anything
questionable in the changes since the previous iteration (I have
not yet read the whole thing again, which I will later).

Thanks.


