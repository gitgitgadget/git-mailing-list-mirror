Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ECC827450
	for <git@vger.kernel.org>; Wed,  5 Jun 2024 16:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717603439; cv=none; b=ciptUiJyVyZfPmI5TDL/d8hvbW2p/+eN6EqsZdIGZPvWN4S6xDDZMeSJPHkQKApvtCu6Q0a/wgsFe2Bfj43qXqIhh/r9SWZ/BojxOazTHZp7pqs9KGBfWVw7bdvlvt73lA0+03/10kfXxKZ51Y1TgvGdS3OwVr7SGzS57fxMD2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717603439; c=relaxed/simple;
	bh=Dx/xFmE4wQzHfpWdO+PooZlwipSmxfnOJ1SAv/zAQds=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WQrdKVFVdD63TVNjy7tHtF8VGysdNFBZiysyy2il5xId2DmTmBvXgdbW/S+Ib1gpMoVn8bIAiS5liSgwpfxfEs5C5B4zsH23ltR3bqn5lTcl/bjK+l7gsC959zNQPSeG8hxdOxGsLe8PfjLJB/IxtLitxueY7g4PK8XNzwtmbiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=j6Nmdnq0; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="j6Nmdnq0"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 950FA1AD12;
	Wed,  5 Jun 2024 12:03:57 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Dx/xFmE4wQzHfpWdO+PooZlwipSmxfnOJ1SAv/
	zAQds=; b=j6Nmdnq0TuuCY4Ff3EBiYxJNyOGihUjjcjiZp8fXYAUCoE2ZnW7trK
	Sj0dpDsjPd2RUL99LU/fK7GjIKXmo0/V10x3m/YFmlZhS0+gQZOMmcPrtEAXltTx
	+7e4FXNH0WmQ8zu4vvxDrfXTbToET5Kouj7S28cWGBLibd7AuYAVY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 8D47F1AD11;
	Wed,  5 Jun 2024 12:03:57 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id AC0551AD0D;
	Wed,  5 Jun 2024 12:03:54 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Johannes Schindelin <Johannes.Schindelin@gmx.de>,
  Phillip Wood <phillip.wood123@gmail.com>,  Justin Tobler
 <jltobler@gmail.com>,  Dragan Simic <dsimic@manjaro.org>,  Karthik Nayak
 <karthik.188@gmail.com>,  Todd Zullinger <tmz@pobox.com>
Subject: Re: [PATCH v6 1/4] docs: introduce document to announce breaking
 changes
In-Reply-To: <Zl_4IIqFmoPhx1Gc@tanuki> (Patrick Steinhardt's message of "Wed,
	5 Jun 2024 07:31:12 +0200")
References: <fc1a9fa03de7330f79dc56b0f2712834cb236b5a.1715070296.git.ps@pks.im>
	<cover.1717504292.git.ps@pks.im>
	<a260bbf281d2975562a042a71ca0dd7f88f03da4.1717504292.git.ps@pks.im>
	<xmqqsexsvbaf.fsf@gitster.g> <Zl_4IIqFmoPhx1Gc@tanuki>
Date: Wed, 05 Jun 2024 09:03:53 -0700
Message-ID: <xmqqjzj3wf4m.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 356B6298-2355-11EF-B44A-ACC938F0AE34-77302942!pb-smtp20.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> On Tue, Jun 04, 2024 at 10:59:52AM -0700, Junio C Hamano wrote:
>> Patrick Steinhardt <ps@pks.im> writes:
>> 
>> > +* Git 1.6, released in August 2008. In retrospect, this release should likely
>> > +  have bumped the major version.
>> 
>> No need to reroll just for this alone, but back then, a non-zero
>> third component did not mean they are maintenance releases (e.g.,
>> v1.5.3.3 was the third maintenance update for the v1.5.3 series) and
>> v1.6.0 _was_ a departure, a breaking change from the v1.5.x series.
>> 
>> It is more recent tradition that we only use three numbers.  I'd
>> strike the whole "In retrospect" comment if I were writing this.
>
> The reason why I included it is that I didn't want to create the
> impression that breaking releases may also happen when bumping the
> second version component. It did happen with v1.6.0, but in the future I
> think we'd want to always bump the first component on such releases, do
> we?

But "in retrospect we should have called it 2.0" is patently false;
switching from 3-tuple version numbers to 2-tuple version numbers
has nothing to do with introducing breaking changes.

It needs to be rewritten in such a way that the readers would
understand the following:

	Git 1.6.0, released in August 2008.

	These days, we use two-tuple numbers for feature releases
	(e.g. Git 2.45 and Git 2.45.0 with 0 as the third number are
	the same things) and maintenance releases have non-zero
	third number, so instead of going from Git 2.56 to Git 2.57,
	we would jump to Git 3.0 if we decide to make Git 2.56 the
	last feature release of the Git 2.0 series.

	With the versioning scheme used back then, going from Git
	1.5.6 to Git 1.5.7 would have been equivalent move to Git
	2.56 to Git 2.57, i.e. incremental and non-breaking feature
	release progression.  Deciding to go from Git 1.5.6 to Git
	1.6.0, instead of going to Git 1.5.7, was akin to moving to
	Git 3.0, signalling a breaking change, in today's versioning
	scheme.  We were reserving the increment to the first digit
	for even larger breaking changes until Git 2.0 happened.

Between Git 1.6.6 and Git 1.7.0, there were breaking changes.  The
same is true for the transtions between Git 1.7.12 and Git 1.8.0,
between Git 1.4.4 and Git 1.5.0, and so on.  They weren't as huge
and controversial as the jump to Git 1.6.0, though.
