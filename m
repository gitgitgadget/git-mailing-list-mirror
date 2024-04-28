Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE6E33C8
	for <git@vger.kernel.org>; Sun, 28 Apr 2024 22:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714344932; cv=none; b=mZc042CkqdaIGFDx50PFsYj3VKNVxVSRVTHJgkzSIg/l4jOcZdquSj18E9RMI54RQ5UNAbb7AwIsak8Lb2ntDc7P21XgpdUGAI+/iksIqeIg29OSksfcLC9lXCZzC7h/CIAUO08npYx7YYUFgPQ1jk/+X9OvK7fopacRSRy0RhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714344932; c=relaxed/simple;
	bh=u2q+CqZy4yMSI9FQTUXX1uVq13TavXbNNppWEoRByMI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=R82Gzt/t9ih/Wt5PECEb7+flmaFCVk5cYNeTFmclHZuQcftgaWyVl7V3S7xSDX4RO7ESZqoJmRl0I/co8XeHcl1IFnlZcw/ukIyNgmUoSoMXZHxfz6wu0qNjO/pCYgRpNAgib8TAf3HayfrqddFQWaXOGBuPnKR2dfstQ8j/wTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Lkde0iLn; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Lkde0iLn"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id DC70230B76;
	Sun, 28 Apr 2024 18:55:24 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=u2q+CqZy4yMS
	I9FQTUXX1uVq13TavXbNNppWEoRByMI=; b=Lkde0iLnRuuBjf9SjOwN1Rht8c0o
	wTmu+HVPFQsZhFhiqI9ZVzwazi8mVSuXzc3ZashNClGL/wgiE+MdXSfboNus/pMi
	9dKsQxYJQMQXG9KrNRecUj/OvO4h4i25m14SxXs/vaA0XpU7toQhfR7V2OjXixKe
	MUGoJnHdwx8PlFs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id D548330B75;
	Sun, 28 Apr 2024 18:55:24 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C86AD30B74;
	Sun, 28 Apr 2024 18:55:19 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Britton Kerin <britton.kerin@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org
Subject: Re: [PATCH v2 1/1] completion: don't complete revs when
 --no-format-patch
In-Reply-To: <CAC4O8c88Z3ZqxH2VVaNPpEGB3moL5dJcg3cOWuLWwQ_hLrJMtA@mail.gmail.com>
	(Britton Kerin's message of "Wed, 14 Feb 2024 11:49:08 -0900")
References: <9627364b-c0c9-4b85-a81a-ba1ef0735c9a@smtp-relay.sendinblue.com>
	<20240109010830.458775-1-britton.kerin@gmail.com>
	<a718b5ee-afb0-44bd-a299-3208fac43506@smtp-relay.sendinblue.com>
	<ZcSJaRczdHApmnVi@tanuki>
	<CAC4O8c88Z3ZqxH2VVaNPpEGB3moL5dJcg3cOWuLWwQ_hLrJMtA@mail.gmail.com>
Date: Sun, 28 Apr 2024 15:55:17 -0700
Message-ID: <xmqqplu92j3e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 6332C600-05B2-11EF-958A-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

Britton Kerin <britton.kerin@gmail.com> writes:

> On Wed, Feb 7, 2024 at 10:57=E2=80=AFPM Patrick Steinhardt <ps@pks.im> =
wrote:
>>
>> On Mon, Jan 08, 2024 at 04:08:30PM -0900, Britton Leo Kerin wrote:
>> ...
>> While this second hunk here makes perfect sense to me, there is no
>> explanation why we need to change `__git_find_last_on_cmdline ()`. It'=
s
>> already used with "--guess --no-guess" in another place, so I would
>> think that it ought to work alright for this usecase, too. Or is it th=
at
>> the existing callsite of this function is buggy, too? If so, we should
>> likely fix that in a separate patch together with a test.
>>
>> Also, adding a test for git-send-email that exercises this new behavio=
ur
>> would be very much welcome, too.
>
> I'll look this one over again and add some tests eventually.

It has been a while, but is there any progress on this topic?

Thanks.
