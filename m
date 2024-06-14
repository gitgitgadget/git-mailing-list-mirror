Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B40383
	for <git@vger.kernel.org>; Fri, 14 Jun 2024 00:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718324233; cv=none; b=i+AcVsjYDm8ZjvCcHKJhwf/TZ+ZIk3zOc5Uo8D7n9qFGjRbSLm2mibu6UiBUwJg8W2IA68oeRwXSFXn1NfI/QeDS7XLf+wHDOHVegoH1cy20fcP+RuCJjMmuqVGMEk3/TUZS/HAODIwsKCjlSMpKTnHoE9X5fk3U9lOdX5ccVuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718324233; c=relaxed/simple;
	bh=KWF/bVEcilVxWDAdjz18xmYq6JaeHSBq5OoP8Hwrb/8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=O3q/zsBUq/tXpCqVKddMGG6KJ6U15X1Op0DcD9WeOFzdqsRR0EAOMHRJ73gIGZUvyrUyDbrB0WTzZhIJzDQujTnRlNyUSMgRLu6iF3V05Lb1zH/fDeabFGm5Ddppwac1p5d/qxrJpR32si8wPMunDr+fRx9v64XEl5RAh9sokC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Hw0XAHJo; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Hw0XAHJo"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 8FCEA1D781;
	Thu, 13 Jun 2024 20:17:10 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=KWF/bVEcilVx
	WDAdjz18xmYq6JaeHSBq5OoP8Hwrb/8=; b=Hw0XAHJo4Ba3W2Ceut2qHj4gOfwu
	LKcVNqt3s/REgBFMxli/T/sFlLWpf42yv43v/KP3FeRLnEj+VALM7IuKxX76IA1Q
	AYMwFi2tlIwUHUgFqChgohnuLvM22VPvwyL4gaFXY/r4dMweI6/S/RYsl36yx9Cu
	1ynxobVqjpguJ8o=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 765A91D77F;
	Thu, 13 Jun 2024 20:17:10 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BF6BE1D77E;
	Thu, 13 Jun 2024 20:17:09 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Ghanshyam Thakkar
 <shyamthakkar001@gmail.com>,  "brian m. carlson"
 <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 00/20] Introduce `USE_THE_REPOSITORY_VARIABLE` macro
In-Reply-To: <9d085d3f-5fdf-4a28-b31c-458ba68ebcd4@ramsayjones.plus.com>
	(Ramsay Jones's message of "Fri, 14 Jun 2024 00:55:38 +0100")
References: <cover.1718106284.git.ps@pks.im> <cover.1718259125.git.ps@pks.im>
	<xmqqcyoklo26.fsf@gitster.g> <xmqqfrtgk7ah.fsf@gitster.g>
	<b69449d0-46f4-448e-b80e-002a8b5c4e1f@ramsayjones.plus.com>
	<CAPc5daUpzc+FDTH4-ajjf6ctnchE5Z6mHVvpm0qnbPLup18ykg@mail.gmail.com>
	<9d085d3f-5fdf-4a28-b31c-458ba68ebcd4@ramsayjones.plus.com>
Date: Thu, 13 Jun 2024 17:17:08 -0700
Message-ID: <xmqqfrtgjs3f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 70C4889E-29E3-11EF-AC0E-965B910A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

> On 14/06/2024 00:18, Junio C Hamano wrote:
>> On Thu, Jun 13, 2024 at 4:15=E2=80=AFPM Ramsay Jones
>> <ramsay@ramsayjones.plus.com> wrote:
>>>
>>> Hmm, odd; isn't the declaration of 'the_repository' from
>>> the "repository.h" header file visible at this point?
>>=20
>> No. The declaration is guarded with USE_THE_REPOSITORY_VARIABLE CPP ma=
cro
>> in the header, and repository.c does not define it.
>>=20
>
> Ah, OK. I haven't been following too closely and didn't
> notice that the declaration in the header file was now
> conditional. :(
>
> But that does beg the question - why is repository.c not
> defining the USE_THE_REPOSITORY_VARIABLE?

I think the goal of the series is to eventually get to the point
where nobody uses the_repository variable.  If repository.c, which
consists of a set of service routines that work on a repository
instance, defined it, showing willingness to implicitly rely on
the_repository through things like get_oid_hex() (which would rely
on the_repository->hash_algo), that would go the opposite direction,
so everything, other than the definition of the_repository variable
itself that allows other files that still do rely implicitly on the
variable to link with it, in repository.c would actively want to
refuse to use services only available to those who define USE_THE_*
macro.

It is a similar pattern we took when we weaned ourselves off of
the_index compatibility macros.  The read-cache.c was the central
thing that defined the in-core index services, and it was the first
thing that lost the_index compatibility macros like read_cache(),
add_file_to_cache(), etc. that implicitly worked on the singleton
the_index instance, while everybody else still relied on the
singleton and services that implicitly worked on the singleton.

