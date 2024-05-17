Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E68538DD6
	for <git@vger.kernel.org>; Fri, 17 May 2024 17:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715966628; cv=none; b=QueK6edFBAcRij/FKpq6iplAHR1amPeYyscUZ1zpztAeji0gvdf662WzJ1+qbcIz5xYl4YQ9rsM5cDdrvVD9ebzDbw/k9TiWQ59tM4Y68ngvPFOkWZaTh9423fxVYUrhTZjD8+Uoh2laq0kiHz3+jiCH15sQoAYoKzDA87L6pHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715966628; c=relaxed/simple;
	bh=4KmSppyjGbKv3NXZji3sg1QVbD/QG+lgH44z5jKERoE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IyO9yLypq7uh4eqb8Zz2GWvZi5HaprT985vPeDI9Egn3ID1YP+8wIV5d6F5bwDazfyWHlHvhSyNiXr1mAeA9DRg9ltZDMqfoq7TcJMsmxuHIhQvJf+UvgTxEGvLGKKRKQC8vV2RdEjNruXxkMxeDqFKKUMeyM+lirPgt6PUkof0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=KmstiOy0; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="KmstiOy0"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id B322E2F59C;
	Fri, 17 May 2024 13:23:46 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=4KmSppyjGbKv3NXZji3sg1QVbD/QG+lgH44z5j
	KERoE=; b=KmstiOy0TEfF+nxZkxf7SDv2Zi5Dp10W99gqiU2YFhLi3MZ3knbjZg
	z8BmhDqdakumEH1g6fv5c5F0CTQEfpz3rsMYBIvo/7jMgj5pN4RgXHZ7LKACnh1j
	0eJm0za7hBvpJ+IN2/L+LvdzyTI8bWJ1ibfvqUCuvWvWRMj3R6sx8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id AC1962F59B;
	Fri, 17 May 2024 13:23:46 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 7D1552F59A;
	Fri, 17 May 2024 13:23:41 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org
Subject: Re: [PATCH] SubmittingPatches: add section for iterating patches
In-Reply-To: <CAOLa=ZS1bhHAtz59z71sMxOT63jwF0pHYO5YKtY7Lx_V8ubV4A@mail.gmail.com>
	(Karthik Nayak's message of "Fri, 17 May 2024 11:33:42 +0000")
References: <20240514123039.1029081-1-knayak@gitlab.com>
	<Zkbn9_-cOiapWSSb@tanuki>
	<CAOLa=ZS1bhHAtz59z71sMxOT63jwF0pHYO5YKtY7Lx_V8ubV4A@mail.gmail.com>
Date: Fri, 17 May 2024 10:23:40 -0700
Message-ID: <xmqq8r08jqsj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 34BB075A-1472-11EF-BD2C-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Karthik Nayak <karthik.188@gmail.com> writes:

>>> +. Build on a suitable base branch, see the <<choose-starting-point, section above>>,
>>> +and format-patch the series. If you are doing "rebase -i" in-place to
>>> +update from the previous round, this will reuse the previous base so
>>> +(2) and (3) may become trivial.
>>> +
>>> +. Find the base of where the last round was queued
>>
>> It's somewhat unusual for bulleted lists to start with a dot, but this
>> is consistent with the remainder of this document.
>
> Yeah, that's mostly why I added dots instead of asterisks here.

Here we want a list of numbered items so that we can refer to other
items in the same list like "(2) and (3) may become trivial".
Wouldn't asterisks give us an unordered list that is typically
rendered as a list of unordered items instead?
