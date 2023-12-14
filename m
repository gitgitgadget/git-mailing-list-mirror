Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75BE6929A
	for <git@vger.kernel.org>; Thu, 14 Dec 2023 19:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="pcgvz5Yl"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 620B21E270;
	Thu, 14 Dec 2023 14:13:20 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=T/50iFnch0iz2gbTB0Hr6UodRT3PN2ddMcX0y8
	ivblA=; b=pcgvz5Yl4YDBh7YnF5ktZ2SSdb0EsyEIkKTu9tl+gNkihYWLImGb8C
	db1fy1bpw3G2wIgDgQoJOWJ42asjVTkCf+ISMJBs9GzOi4aqZoOtUkM4+dnVkzyZ
	GKsWCJ5WN3hNql5+CxTVBirLUzFDooQAMb3/sN4+1DgslPila0ShI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 5B9AB1E26F;
	Thu, 14 Dec 2023 14:13:20 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.193.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 062BD1E26E;
	Thu, 14 Dec 2023 14:13:16 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org
Subject: Re: [PATCH] tests: prefer host Git to verify chainlint self-checks
In-Reply-To: <CAPig+cQvcSeSKVE=0kDyNiSztNAgVwhfAzoL5K7uYHEKe=0f_A@mail.gmail.com>
	(Eric Sunshine's message of "Thu, 14 Dec 2023 13:10:48 -0500")
References: <4112adbe467c14a8f22a87ea41aa4705f8760cf6.1702380646.git.ps@pks.im>
	<xmqq8r5zrzg1.fsf@gitster.g> <ZXlbNlG28e1sAYPU@tanuki>
	<xmqqr0jqnnmn.fsf@gitster.g>
	<CAPig+cRc2hW_xhJRPJmEVYik71zWLDQ_EFjBFw095OgPGYrWGg@mail.gmail.com>
	<ZXq5GL723v4E3_IH@tanuki>
	<CAPig+cQ2-PB24n0xfcoSy_1UT-VbEZUXXJ9QbA8FBA8Vfyd6Ng@mail.gmail.com>
	<xmqqbkaspxn6.fsf@gitster.g>
	<CAPig+cQvcSeSKVE=0kDyNiSztNAgVwhfAzoL5K7uYHEKe=0f_A@mail.gmail.com>
Date: Thu, 14 Dec 2023 11:13:15 -0800
Message-ID: <xmqqfs04oawk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 D6034772-9AB4-11EE-A7A4-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Eric Sunshine <sunshine@sunshineco.com> writes:

> (The only postprocessing of "expect" files which needs to stay is the
> bit which removes the "# LINT:" comments which litter the "expect"
> files explaining to human readers why the linter should insert a
> "???FOO???" annotation at that particular point.)

Yup, that matches my understanding.

> The chainlint self-tests were never meant to be about its general
> output stability. They were intended to ensure that the "???FOO???"
> annotations are: (1) indeed inserted for the set of linting problems
> the tool detects, and (2) inserted at the correct spot in the emitted
> output relative to the shell tokens to which the annotation applies.

Yup.

> Minor differences in the tool's output (whether over time or between
> platforms) should be immaterial in respect to those correctness goals.

But there is no reason to make such immaterial changes to the output
gratuitously when we are updating the tool to improve it, no?
