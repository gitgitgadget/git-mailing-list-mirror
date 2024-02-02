Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C198D15E5AA
	for <git@vger.kernel.org>; Fri,  2 Feb 2024 19:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706900689; cv=none; b=ZPPpkA0+PDdt8/5f5INoz0fSZnCSxnvxgruS9Yv6WyNjBdD0SUJwfj6PcDgb3/Z0I7aeXkC4hWi3qDee8HsLhjD8xS8lR7tzrQIOMrMDOdnNcsCMqdhZQqVspY8Dks5n+8ETa8Q7upuEO3RNinUlTbD2A8eC+LtNGtSY7Zd29K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706900689; c=relaxed/simple;
	bh=+OWFquoMSwVs9Z0VNeXxGBG+eOuMj12yPu5Jy9tOcTI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OLVXlQLB2ZLUq162kUC1rNfBRWMFBzieK5pbuK2453EFvQfE9ptCTZhdWsA/2piwSR4f/M5vAXQUj43CxpeBSTDnV4oPLykqnDsX7XQS9PJIm6GeCCZ+ipZts2wC83i81tKk0ie6Cxuoxsr0eUoncfCtbmzvDxYfhaMIG/+fhB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=NHMaufy0; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="NHMaufy0"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 2A5E32603A;
	Fri,  2 Feb 2024 14:04:47 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=+OWFquoMSwVs9Z0VNeXxGBG+eOuMj12yPu5Jy9
	tOcTI=; b=NHMaufy0RNy8TezBwMde+ag7POISL+aop6Bl/87mEgCTKoOhG4ePcg
	isBIusY76rUQtslNEejxcfXqETm+JH+4algfTQKRk2DRNaGIT7TCHCzu3N1oCIGr
	9WTonm6j6Gu+PPZm2ONWSt/L8mJN11ppg6sRfwlxXULpkJCPIfIOQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 222F826039;
	Fri,  2 Feb 2024 14:04:47 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 5708C26038;
	Fri,  2 Feb 2024 14:04:43 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: rsbecker@nexbridge.com,  "'Sergey Organov'" <sorganov@gmail.com>,
  "'Hans Meiser'" <brille1@hotmail.com>,  git@vger.kernel.org
Subject: Re: Migrate away from vger to GitHub or (on-premise) GitLab?
In-Reply-To: <20240202161643.GD119530@mit.edu> (Theodore Ts'o's message of
	"Fri, 2 Feb 2024 11:16:43 -0500")
References: <AS2P195MB21350F44B079009C05A1EAF1E2432@AS2P195MB2135.EURP195.PROD.OUTLOOK.COM>
	<AS2P195MB2135D91EE464FF30EE84E77EE2432@AS2P195MB2135.EURP195.PROD.OUTLOOK.COM>
	<877cjm53bf.fsf@osv.gnss.ru>
	<008b01da55eb$9f3c36d0$ddb4a470$@nexbridge.com>
	<20240202161643.GD119530@mit.edu>
Date: Fri, 02 Feb 2024 11:04:41 -0800
Message-ID: <xmqq5xz6sn5i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 EC7F5D86-C1FD-11EE-AECB-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

"Theodore Ts'o" <tytso@mit.edu> writes:

> So from an open source project perspective, which is primarily run by
> volunteers, each open source project has to make a cost-benefit
> tradeoff as far as the *project* is concerned.  Individuals do not
> have a fundamental human right to contribute to a project.  Hence, the
> open source project doesn't owe an obligation to spend a huge amount
> of effort supporting some kind of forge web site just because some
> potential contributors are clammoring for it.  Especially if they are
> saying that they can't be bothered to follow the mailing list traffic
> because it's somehow too much.

Thanks for saying this (even though with my Devil's advocate hat on,
I am not sure how strong our "this is run by volunteers, so do not
demand" card is these days).

> (Of course, I have all of the Linux kernel mailing list flowing into
> my inbox, and have e-mail practices that can handle that load --- so
> it's hard for me to have much sympathy about people complaining that
> the e-mail load for git is too large --- compared to LKML, it's
> *nothing*.  :-)

True, too.  We may have enough patch traffic but not enough reviews
on them.
