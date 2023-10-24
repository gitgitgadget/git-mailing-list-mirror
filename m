Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1591024212
	for <git@vger.kernel.org>; Tue, 24 Oct 2023 17:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="b4IE0BhN"
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03608122
	for <git@vger.kernel.org>; Tue, 24 Oct 2023 10:08:05 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 7833C1C8D9D;
	Tue, 24 Oct 2023 13:08:02 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=IgOOD0ec8gP+0edrc84u8lYwhxrvWqWuFFTIqU
	Lvg8g=; b=b4IE0BhNM2GnkNL8T8k7alSG8iYfGI3m4yhUpJXafG5DgqRy6Z9ZtE
	Sp4RmExZTYAOUJqyt77ZkWplg1z4XrMv8/X1nLUDVY5ajkEqUadvOPJ3tKcmWFio
	QaGZXWKlmwggYqgypE3qd32WB+tHap1sQjKMUswI+UiZih0xiEb8s=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 706D31C8D9C;
	Tue, 24 Oct 2023 13:08:02 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.198.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AE1E91C8D9A;
	Tue, 24 Oct 2023 13:08:01 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Jeff King <peff@peff.net>,  Taylor Blau <me@ttaylorr.com>,
  git@vger.kernel.org,  Elijah Newren <newren@gmail.com>,  "Eric W.
 Biederman" <ebiederm@gmail.com>
Subject: Re: [PATCH v4 4/7] bulk-checkin: implement `SOURCE_INCORE` mode for
 `bulk_checkin_source`
In-Reply-To: <ZTdlgEaRLpdSjB1n@tanuki> (Patrick Steinhardt's message of "Tue,
	24 Oct 2023 08:34:40 +0200")
References: <cover.1697736516.git.me@ttaylorr.com>
	<e427fe6ad383cc238c13f313dc9f11eab37a3840.1697736516.git.me@ttaylorr.com>
	<ZTY6kTZT-ni16usH@tanuki>
	<20231023185842.GE1537181@coredump.intra.peff.net>
	<ZTdlgEaRLpdSjB1n@tanuki>
Date: Tue, 24 Oct 2023 10:08:00 -0700
Message-ID: <xmqqedhk54pb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 E379C6F8-728F-11EE-95BB-25B3960A682E-77302942!pb-smtp2.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> I'm inclined to agree with your philosophy. Makes me wonder whether we
> should write a Coccinelle rule to catch this. But a quick-and-dirty grep
> in our codebase shows that such a rule would cause quite a lot of churn:
>
> $ git grep BUG\( | wc -l
> 677
> $ git grep assert\( | wc -l
> 549
>
> Probably not worth it.

Yeah, we can stick to our usual "do not add new instances, fix them
while touching near-by code" pattern for this one, I would say.

Thanks.
