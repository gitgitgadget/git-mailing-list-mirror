Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6791B1487EA
	for <git@vger.kernel.org>; Fri, 12 Apr 2024 15:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712936780; cv=none; b=BTlHazO2YZtsx1FIIjJyd0ZRVXXSS8R0uKcBHgKoklgwUT0LgVMScfU2InNFCYCgWpX/lm1w2gtoQ7I8HLwkTaP+QPswccVOqgvy6q5/888k2mKO7MpMywV8lg8T5qRDae5s0alIToPnoXZhFXZVUfvhHJkl54eeBDis4xwKTY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712936780; c=relaxed/simple;
	bh=pFGuDP8ogcRS0qp5iy8pjpZgPVoEECbiKApXPjUbql0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jryaqA6WMdn8SyHBpsc/9YyvF4NuVwKCf1+k7RwDaq82nH6jwwzH7mKh1xRjRQieWUngbgtoCOm1lKqz3qeQjWNH49+wAdrvJ2LYeVhr9QbzxtPIThS1ksGIzwV/DcqRxq2yFjISioomLvztum06yMuOX5Pak+C15DolFMGYQhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=rXJi+3YL; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="rXJi+3YL"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 7B2852FCAA;
	Fri, 12 Apr 2024 11:46:12 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=pFGuDP8ogcRS
	0qp5iy8pjpZgPVoEECbiKApXPjUbql0=; b=rXJi+3YLCX3n9k5JR+IHeKakczug
	6xpslWPhpPPEeuo8iBoVAunfcXgsisAIAK8pHmiVT6U6fumAO5aDmtb6CkK5bPCs
	7it7qWUYnWOmV8WVzQ12c43sRG+spRWSQW4wzjyOY2Hhf5cyz0o1mc//zhhvwvzC
	9uPXhscyFjXh5Nk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 738D82FCA9;
	Fri, 12 Apr 2024 11:46:12 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9C5752FCA6;
	Fri, 12 Apr 2024 11:46:05 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH v2] launch_editor: waiting message on error
In-Reply-To: <d485c4cd-f963-45b7-9fa6-801738c7c066@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
	message of "Fri, 12 Apr 2024 01:18:55 +0200")
References: <e60c1217-aeb6-48ce-9aa5-7c0b13396e33@gmail.com>
	<96bef5f9-1286-4938-99ec-6beed13ee68d@gmail.com>
	<0258a583-a90a-4434-bb4e-a1672d574b9c@gmail.com>
	<xmqq4jcb495u.fsf@gitster.g>
	<54dcd4f1-5a79-47ba-9650-7115b7170a84@gmail.com>
	<xmqqle5lxlwm.fsf@gitster.g>
	<d485c4cd-f963-45b7-9fa6-801738c7c066@gmail.com>
Date: Fri, 12 Apr 2024 08:46:03 -0700
Message-ID: <xmqqwmp2posk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 C5E6D54C-F8E3-11EE-8CBF-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

Rub=C3=A9n Justo <rjusto@gmail.com> writes:

> On Wed, Apr 10, 2024 at 08:44:25AM -0700, Junio C Hamano wrote:
>...
>> It happens ONLY when the error message the editor itself emits
>> (which comes later on the same line as "We are waiting for your
>> editor...") without terminating newline itself.  Otherwise, we'd
>> have
>>=20
>>     We are waiting ... THE EDITOR SAYS I FAILED
>>     _
>>=20
>> on the screen, and the cursor is at the _ position.  term_clear_line()
>> would not clear anything.
>
> Not with a careless editor:

That is why I said "Otherwise".  Of course, a broken editor would
give broken output. What else is new?  And more importantly, if you
wrote such an editor, would you release it in such a buggy form to
the outside world?  Does it still look like a problem worth spending
our brain cycles on?

