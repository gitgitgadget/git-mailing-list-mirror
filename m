Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73AE157E82
	for <git@vger.kernel.org>; Thu, 16 May 2024 22:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715896886; cv=none; b=PK6SAOc18MU1NPyMswQ9+qc45afn2Vl+IViQQci3zGfI82n+34ZPy5+7Frx29QgTtT4OR3VqrZfjQmtfauXAgNeCOrQpCpCuMTYue+Jh6g6eyjFHjYHnpATgDl+RzVBSTf50p3zPVwtvKIItd1+9m0j7pPz6DBwKOgUgtz01ngM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715896886; c=relaxed/simple;
	bh=QUCR5qynOdQ8YmORAcUF8F2wne1HSzSYg/tWYxUFvRc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=a4JErAqpnAIYjtMKr/z/e5G5n2v2dTrx2aGG6hs/mi7UgndxhkbnvmcvhG09o+qk6i934whN+osXDBqryfhpJopeW/DtKT7JWN0vT89+nlfC0jWK5BkA4AhyL7tjFCYKatRM8lX8UBYcKcb7ArdElWn7LgHBfKPu1BJpYy05Pn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=B5107u15; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="B5107u15"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 347E329018;
	Thu, 16 May 2024 18:01:18 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=QUCR5qynOdQ8YmORAcUF8F2wne1HSzSYg/tWYx
	UFvRc=; b=B5107u15fbGiG05NG2O3uJFhpXi1wL32E9LoNBs9N+S1+/XITrfe8+
	0OB4DWBiD3xVJuRdvr5LxCvRDf+tvJ1GtuvWM116yBOmaKW+Xud33QVdFWC9bTZw
	2fhmmjL7GmSoqbaVNuCtKaDp6omW2ArOeIKi37BFpnfsFfCr9RYTQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 2C3E329017;
	Thu, 16 May 2024 18:01:18 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B3D4F29016;
	Thu, 16 May 2024 18:01:14 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Josh Steadmon <steadmon@google.com>
Cc: git@vger.kernel.org,  karthik.188@gmail.com,  me@ttaylorr.com,
  ps@pks.im,  emrass@google.com,  nasamuffin@google.com
Subject: Re: [PATCH v3] doc: describe the project's decision-making process
In-Reply-To: <5446ca49e042b104923ac2004d845a5f9018c9d9.1715894135.git.steadmon@google.com>
	(Josh Steadmon's message of "Thu, 16 May 2024 14:20:53 -0700")
References: <b2ef74c1b0c7482fa880a1519fd6ea1032df7789.1713222673.git.steadmon@google.com>
	<5446ca49e042b104923ac2004d845a5f9018c9d9.1715894135.git.steadmon@google.com>
Date: Thu, 16 May 2024 15:01:13 -0700
Message-ID: <xmqq4jaxo1qu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 D06A1B80-13CF-11EF-8FBB-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Josh Steadmon <steadmon@google.com> writes:

> Changes in V3:
> * Squash in Junio's suggested patch to remove discussion of small-scale
>   patch series.

I do not think I deserve Co-authorship for the small changes in the
remaining document, as my contributions going from v2 to v3 were
mostly line removal ;-).

> +Larger Discussions (with patches)
> +---------------------------------

Reads well and looks sensible.

> +Larger Discussions (without patches)
> +------------------------------------
> +Occasionally, larger discussions might occur without an associated patch series.
> +These might be very large-scale technical decisions that are beyond the scope of
> +...

I do not know how strongly assertive you wanted to be, but I suspect
that it will read better with "might" -> "may".

> ...
> +For larger discussions without a patch series or other concrete implementation,
> +it may be hard to judge when consensus has been reached, as there are not any
> +official guidelines. If discussion stalls at this point, it may be helpful to
> +restart discussion with an RFC patch series or other specific implementation
> +that can be more easily debated.

It is a bit fuzzy what "other specific implementation" wants to
convey.  A mere "RFC" is often an unfinished work-in-progress, and
if the "other specific implementation" is different from it, then
what it would be?  A minimum viable product?  A proof-of-concept?

All other parts did read very well.

Not that the above was unreadable, but just my reading hiccupped at
around "other specific implementation".

Thanks.
