Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C5A1946C7
	for <git@vger.kernel.org>; Mon, 12 Aug 2024 20:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723495815; cv=none; b=jsc5RPmIHh/BT3DYlq9EDkmoeNJGvF39HjCRBq0HH1GO4wJND53TuuIJWipDvlDRvH/jI3ukyqQVzvRsTDP60tV0DUY0tIFkd0i7d5tt9OS8DCCAScntuGfFiVT7B+ytWkVKPx8M0T1n7NNkH+1UpqVjUmF8FQK6VOJuNMJJdiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723495815; c=relaxed/simple;
	bh=vJgwv8QDnbde+wkoGHf/UoQlV/NkZSkmMnwzXerrgmk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fJoNdXoyf9/DDuEHl2+lsvXDZkSSnq/gX/xMWxJxtWJSv/qVIp+B92tNqmqqVYNl6GwhDa9j9uxusp/bX43dLJ7PdsoMYgzBENdP0A1Pwd+UdXZ7u1/Tw8Rz3cuOVUtd6YQy6rcCFxeyEGRu5sgrxlLk6os4PhNW8ST4O/zSQaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=nB6BQsuu; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="nB6BQsuu"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1E7FF1E6D8;
	Mon, 12 Aug 2024 16:50:13 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=vJgwv8QDnbde+wkoGHf/UoQlV/NkZSkmMnwzXe
	rrgmk=; b=nB6BQsuuoPWE4ewIsITQCE/3gHVL9OI1ivxlnv3mlb6CDBBS/L3mrk
	A6on+7qTtmNdt7RPKtWMbpVE/W55Z9Yv5Y0Euoc/7t0Q6cD76dq50USw81BBW4GQ
	Oou9ChJOGo/WnJNy0PSQpgxbkc/fehmtkfFB4HzUvq1Ada6CWa2AY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 043011E6D6;
	Mon, 12 Aug 2024 16:50:13 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4ACAA1E6D5;
	Mon, 12 Aug 2024 16:50:12 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Josh Steadmon <steadmon@google.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  =?utf-8?Q?Ren?=
 =?utf-8?Q?=C3=A9?= Scharfe
 <l.s.r@web.de>,  Kyle Lippincott <spectral@google.com>,  Phillip Wood
 <phillip.wood@dunelm.org.uk>,  rsbecker@nexbridge.com,  Edward Thomson
 <ethomson@edwardthomson.com>
Subject: Re: [RFC PATCH v3 0/7] Introduce clar testing framework
In-Reply-To: <k6uar46lu7ffbnboguca65afwegpcpfrivzfm7gspcorfefxnw@csqkd7wsoggk>
	(Josh Steadmon's message of "Mon, 12 Aug 2024 11:10:46 -0700")
References: <cover.1722415748.git.ps@pks.im> <cover.1723095269.git.ps@pks.im>
	<k6uar46lu7ffbnboguca65afwegpcpfrivzfm7gspcorfefxnw@csqkd7wsoggk>
Date: Mon, 12 Aug 2024 13:50:11 -0700
Message-ID: <xmqqy151zcsc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 7828B6FE-58EC-11EF-95D3-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

Josh Steadmon <steadmon@google.com> writes:

> I'm generally in favor of this change, but I'm still unsure what our
> plan is for importing this from upstream clar. Are we going to vendor
> our own copy here and (hopefully) someone will pay attention to upstream
> fixes and apply them to our copy? Or will we replace this with a
> submodule?

As long as we do not have to make any changes to the "vendored" code
ourselves, that would not matter.  We will not randomly update the
gitlink that specifies "we want to use _this_ version and not other
version of upstream clar" without good reasons if you are using it
as a submodule, and we would need to justify why we are updating the
hierarchy if we import the hierarchy as vendored source.  So the hassle
of "updating from upstream" is pretty much the same.

For something as small as "clar", I think it is fine to start with
the currently proposed layout and see what happens.  If we can keep
going without touching the imported part of the sources at all, and
the system proves to be useful and stable, that is a good time to
suggest moving it out and binding the selected version of the
upstream as a submodule.

Thanks.

