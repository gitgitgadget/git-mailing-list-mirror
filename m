Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E9147F4C
	for <git@vger.kernel.org>; Mon, 22 Jan 2024 17:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705945528; cv=none; b=uk3yhCYpibrW0smCZ085ZuzNPI0XjChwmqVFlRU7+PYmq9T9UmXYpR3BIym5a6zLO45ZWlAoxfUTOkMnc8zu8jYeZJVTbyPHtC+0ATdkN4eSOxJmsa+Q4pngdZ/qxm++UKndPjNmLQdqc8a+neYeEhgk+0nDIMgYCZGMd6BTunU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705945528; c=relaxed/simple;
	bh=q/FIWfXddY45QQA5QPf2E8q2ZJZ60P9R9BApNrpyCdM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qm4b/J1d61kwGilLW3QzuvYHOz9CoWkKFFJGR6JX7LTbuSJNfYz0yZMDKcpNSjB5RxFwlvqPuqhqxha9vsElUgpVGXBqKJKjet1EBR+pUosSv+5FNrPcOthQPixE0hYWpDHyXMP9sdCrVM2QH2yuVrTsFM3x2P8CbvzYTCq1z8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=FvsRXAFl; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="FvsRXAFl"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A3DC41BDE46;
	Mon, 22 Jan 2024 12:45:25 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=q/FIWfXddY45
	QQA5QPf2E8q2ZJZ60P9R9BApNrpyCdM=; b=FvsRXAFl+jzYeRnkzEUuLRZm34cW
	fkP/S2glP/g7eQKv5Jri+c/OFjuaxE9IdaQde/nvUmcl9HMdr0b5FS7q6CzH5hFa
	233SxHl9ATH20hgq6VG9thPZ6uoDBz1fLbagYfT8qmu7++1zyo0tCGNETmxDMQaj
	LiJwSUJA3CL1NBE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9BD4C1BDE45;
	Mon, 22 Jan 2024 12:45:25 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0BF161BDE44;
	Mon, 22 Jan 2024 12:45:24 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 4/5] refs: introduce `refs_for_each_all_refs()`
In-Reply-To: <CAOLa=ZTbtqvejpvNVY5MHU=Adx3tWQ=FqVJdRLG1gaxYu4BG7A@mail.gmail.com>
	(Karthik Nayak's message of "Mon, 22 Jan 2024 16:48:51 +0100")
References: <20240119142705.139374-1-karthik.188@gmail.com>
	<20240119142705.139374-5-karthik.188@gmail.com>
	<xmqqsf2thwhj.fsf@gitster.g>
	<CAOLa=ZTbtqvejpvNVY5MHU=Adx3tWQ=FqVJdRLG1gaxYu4BG7A@mail.gmail.com>
Date: Mon, 22 Jan 2024 09:45:23 -0800
Message-ID: <xmqqfrypuurw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 05C8849C-B94E-11EE-9274-25B3960A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

Karthik Nayak <karthik.188@gmail.com> writes:

> On Fri, Jan 19, 2024 at 9:57=E2=80=AFPM Junio C Hamano <gitster@pobox.c=
om> wrote:
>>
>> This looks more like add_pseudoref_entries() given that the general
>> direction is to have an "allow" list of pseudo refs (at this point
>> after the previous step of the series, is_pseudoref_syntax() is the
>> is_pseudoref() function, and uses ends_with("_HEAD") as a mere
>> optimization to avoid listing all the possible pseudo refs that
>> exists or will be added in the future whose name ends with "_HEAD").
>>
>> Other than the naming, I think these two steps make sense.
>
> I think overall the naming is correct, I would change the comments in
> `is_pseudoref_syntax()`.
>
> Because, apart from pseudorefs, we also want to print HEAD. This is als=
o
> why the pattern matches "HEAD" instead of "_HEAD". I'll add some more
> comments to clarify this.

With the hardcoded "these are definitely pseudorefs" list in the
function, it no longer is is_pseudoref_SYNTAX() at all.  I would
rather prefer to see is_pseudoref() that says no to HEAD and have
the callers check

	-	if (is_pseudoref_syntax(foo))
	+	if (is_pseudoref(foo) || is_headref(foo))

than keeping the messy semantics we have.  My second preference is
to call it is_pseudoref_or_head() that says yes to "HEAD" and
pseudorefs, even though I like it much less.

Similarly, between giving the function under discussion a more
descriptive name add_pseudoref_and_head_entries(), or adding a new
function add_head_entry() to make the callers call add_head_entry()
and add_pseudoref_entries() separately, I have a slight preference
for the latter.

Thanks.
