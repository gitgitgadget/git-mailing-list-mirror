Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A5313B2A5
	for <git@vger.kernel.org>; Sat, 13 Jul 2024 17:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720890508; cv=none; b=sW8vxdUvkv2asn6Zttr/EFo59DOVfjW7peENHpkBWjlgC35je4hBycCf3OTvoSRD8qxacVXwlxgyyyMWarjgOSZtwfMbx1kbeXS/qK9+M6QzaHkyMespi+RcJ5bFRneFN9XhFAElZAQ78+k72JJDmPKs3liBrFGbqEj7oxkFKBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720890508; c=relaxed/simple;
	bh=D1od7YOXBhK7Z5zDGPCZNdmRXRH7oFw83HSUuuD9XlQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=r5jnM93M8FqKbdkhAxNcrBZ5dADhtU5AydVOCXXSEmBiDsK1Osu/Z3twbqm0ghrsVyq6rw0LnehpYe/bHYRVBfUADrnRJm+pW+7F6BehAVh/Z+G2e7XJ+7S77lI3rBxf6JPTRUjP5yOjWpe6vcLKNJ+SgjZfkdnBsMzuMl1OEfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=PzEhMHSA; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="PzEhMHSA"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A12C02ACB0;
	Sat, 13 Jul 2024 13:08:24 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=D1od7YOXBhK7
	Z5zDGPCZNdmRXRH7oFw83HSUuuD9XlQ=; b=PzEhMHSAzUsw/24RRvpWn5oIIkbE
	ZZvgVabkUFTqgEmqVh8iV09WEK+IZvMpMB+0f9PX4l8XWtEaT+WslHtgzvzWbgh0
	rTzzvDYrsPFhZCcd+0poiv0wab7SL+NOcyYHu2lh6mxDiL79atmfps1haxd9tr3p
	5jnjeAGlXrhEwwg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 981142ACAF;
	Sat, 13 Jul 2024 13:08:24 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0435C2ACAE;
	Sat, 13 Jul 2024 13:08:23 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc: Git List <git@vger.kernel.org>,  Dragan Simic <dsimic@manjaro.org>,
  Jeff King <peff@peff.net>,  Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2 0/4] use the pager in 'add -p'
In-Reply-To: <ebcba08f-3fbb-4130-93eb-d0e62bfe0a8a@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
	message of "Sun, 14 Jul 2024 01:26:00 +0900")
References: <2653fb37-c8a8-49b1-a804-4be6654a2cad@gmail.com>
	<ebcba08f-3fbb-4130-93eb-d0e62bfe0a8a@gmail.com>
Date: Sat, 13 Jul 2024 10:08:22 -0700
Message-ID: <xmqq7cdpb4op.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 8368AF34-413A-11EF-AEE1-965B910A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

Rub=C3=A9n Justo <rjusto@gmail.com> writes:

>     -+	test_write_lines P |
>     -+	(
>     -+		GIT_PAGER=3D"head -1" &&
>     -+		export GIT_PAGER &&
>     -+		test_terminal git add -p >actual
>     -+	) &&
>     -+	tail -n 7 <actual | test_decode_color >actual.trimmed &&
>     -+	test_cmp expect actual.trimmed
>     ++	test_write_lines P q | GIT_PAGER=3D"head -c 1" test_terminal git=
 add -p >actual
>      +'

"make test" has this to say:

t3701-add-interactive.sh:619: error: head -c is not portable (use test_co=
py_bytes BYTES <file >out): test_write_lines P q | GIT_PAGER=3D"head -c 1=
" test_terminal git add -p >actual
gmake[1]: *** [Makefile:132: test-lint-shell-syntax] Error 1
