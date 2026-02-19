Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E41E2D1911
	for <git@vger.kernel.org>; Thu, 19 Feb 2026 12:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771502637; cv=none; b=m66+R4QlVXmlwOqm+l04/SsP/sw5wq+9WyKBUfuq5IgrOlb22BGNJ4cQvnFqt2WGqQ65jAE1carqUP+aTXucnuLv1WiT3gxoTZyusIkXVSsoc75Yqk2XVTdElpCSIylWbAhTuVbuhGmyPPBWCMswrTgbryeYFIq6GZ3EM39gU7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771502637; c=relaxed/simple;
	bh=izHY6GhHOnlEnfqPxJg2JVJQzDN6UYm6jOJ+74LKhqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VHp6N0p70i/mjrV4lpHJH7BQiE6n85iW9phY7eFzw1xfTPPrueE2Wqx4lM+LQ7OJDgnm8a0aKd15qdmSD6RlJ0Y1tPGrJMqlRdH/6tivWyq5Qq6Orf5m1UJh3SUhu4bXhgUTD97dzJq3QtFkWOcCKCekNgKjx3loqcWMx8T/Rxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=Fb23UE1O; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="Fb23UE1O"
Date: Thu, 19 Feb 2026 13:03:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1771502627;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=izHY6GhHOnlEnfqPxJg2JVJQzDN6UYm6jOJ+74LKhqw=;
	b=Fb23UE1OD4Ru/HbpDo9pmgQDiYJfJIsMG6BTjZamYtwLG+cFysKuZDct+u+xzECufXbhRi
	sLaXeq1bt3knrKjrnUr8NtYDUf1+nMb1D+ccjEyCJ+du2iNzQRdx9O2v9Tu0bg2nXnpPJ4
	IaM/VkFn9Qt75QrJxL/cRarvxLbLDYrpzMbdjP8kSs7C5NhkeCSp187+NvXaL0iQ6l0rsi
	OHkUTMNiyMTXooRXXniWjF3WSMFL4Ne7CekFC3kiZmQ9H94tGnyGKLfQI7WMF8zYy/h51O
	iQcTjffCHkCKVWh7XqfJHFDYGurONOr/jce6DrUU/P+XB+nRetZHjn6eAWdjNg==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
From: Mirko Faina <mroik@delayed.space>
To: Jeff King <peff@peff.net>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, Patrick Steinhardt <ps@pks.im>, 
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, Mirko Faina <mroik@delayed.space>
Subject: Re: [PATCH v2] format-patch: fix From header in cover letter
Message-ID: <aZb6Pi_xkDflihHw@exploit>
X-Developer-Signature: v=1; a=openpgp-sha256; l=638; i=mroik@delayed.space;
 h=from:subject:message-id; bh=izHY6GhHOnlEnfqPxJg2JVJQzDN6UYm6jOJ+74LKhqw=;
 b=owEBbQKS/ZANAwAKAUh5fqGcGb7RAcsmYgBplvv8HKSLpZqZoZPHA/IW+7mRIBNUlpIz4SdXX
 EPGshHHya+JAjMEAAEKAB0WIQT/Ky37K0pSwmwsybZIeX6hnBm+0QUCaZb7/AAKCRBIeX6hnBm+
 0Sg8D/9AHQokngrv5XNtfPjmDV/XmkuW9altOHExZvJs5/1N6wzIx1RGdMgCHRfkEHDkh98nymE
 poeofS4g4qeCHVSVAJSDIy0FM5u1SeyDjZnHn59mqcu26JEQLqlqEY7oxnYYXFI+AsSyPTNjCqc
 EChWQiUH3i+IRgvrROXQjKySZVbU3IIGD8v/FQ+M++hMvQRvNkIRAccxBh+/G4QCu5BpEea8t5n
 SV3EsfngpfgslfBD2sdx1FBu0vDVtWGYfvzSy6A6pSeYxaHxp6ytOxhfVI1ugPC8FR3SA4f9Oxk
 W4Ed5vmbDXOl44ymB3CehyuY4jI9ep9sJ/kKZToQilQXOUX4idXh/e6sOuj7EAB8fFOZlMVaawP
 4VS3VRoTKHebq/xVIHjEyK+cMQUl1gGbJdmdeyCjgc44eSErEp3mVAgmXEKZLPrV+dyxjnlbuXj
 DkBVvAtXZRYyfAVwohJjTa3PWAes35M4yrf/6wAi66wlPB7W2+oIo86VRarFodqbCkO7aCi8otB
 uv81qlDyM+/k3vsR0X4CcEuef2xxFZlodPKNJzzIlql3shGOy5CmH55WKHmLswXtOKmul/k2MSB
 l4DABk8hN91FWXWv5/+1cW1jkJiC1ll5yQdKkfjBCxHhZV3RwX2kBKt3TV1vQhGCMaFP8hU9ywu
 ad8F+YpfJwFWzGA==
X-Developer-Key: i=mroik@delayed.space; a=openpgp;
 fpr=FF2B2DFB2B4A52C26C2CC9B648797EA19C19BED1
References: <aZAMr6XOwKkTa55q@exploit>
 <20260216152730.37478-1-mroik@delayed.space>
 <aZQJEDyUyMv4_c1l@pks.im>
 <20260217063400.GA101988@coredump.intra.peff.net>
 <CALnO6CD6c36ur4cxqNAB=Jy=m6yxVfoSzAAekewQZr2vjjKn2w@mail.gmail.com>
 <20260219112918.GB3529@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260219112918.GB3529@coredump.intra.peff.net>
X-Spamd-Bar: /

> Maybe nobody noticed because most people do not use "--from=<foo>" with
> a <foo> that does not match the committer ident in the first place. I'm
> not really sure why you'd want the two to differ. Which makes me wonder
> why I added that feature in the first place (as opposed to just "--from"
> with no options).

I usually commit everything under the name Mroik. Having the "--from"
option is useful to send a one off contribution, otherwise I'd have to
change my committer ident everytime I decide to use a different name (I
know most people just use their full name so it's not common to have to
use "--from").

Mirko
