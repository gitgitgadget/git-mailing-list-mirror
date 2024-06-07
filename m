Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F6233C0
	for <git@vger.kernel.org>; Fri,  7 Jun 2024 17:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717781649; cv=none; b=mKQppUEKg6q4yrrziUyyjmEbh+l0XF7AJiVFc85e3V6UIA+/z0JAcUBNtwBWvakzT6Crx9yXglUwVRPwyrb58GunefE0uWML0VrL4Lb2LXw0QRhsQMW/YJYFuOMuTl12VMzHvQonTdlOE+5YMRVeS0iXQxE2TKIRPl5sLLde5tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717781649; c=relaxed/simple;
	bh=lypxU0mfXQDSUMhgA/DA9mhkby6R/A4nbuQoURtRSoM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=M6WlUakxOS1/XSYqMd3qjq1GSRgzXII17JkgUoIoIAKWZK7T3bvg42WXJ//Ti6n77XdfUHLlmlX5qPdbVZBblXX9QKBOdE+cVIj5VRzj77MMGxCLgzYggJfjz9oCdEJdA5T/6RvCZ0UfpRi9qyAwdhU8i7UqNOfjJiyXN/SRMX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=AU5rj4A+; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="AU5rj4A+"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 6F46C2FD52;
	Fri,  7 Jun 2024 13:34:06 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=lypxU0mfXQDSUMhgA/DA9mhkby6R/A4nbuQoUR
	tRSoM=; b=AU5rj4A+NXESIQVYFHWs28FGY4AgkgvP1NM43sbFQ6EutnJfb2oy8C
	GSc+TU9KXqLB07fUC+csDfz3ldHbToIlF5dFlWIvOQ0zhtc42BchYAfi2zGehRDC
	bkFIzi+q8iBkHhX/pXyHyKLTeqwV3ioCKjkoKZqHkzWHCJsEJRK4k=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 3E4E82FD51;
	Fri,  7 Jun 2024 13:34:06 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BE2D82FD50;
	Fri,  7 Jun 2024 13:34:04 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Eric Sunshine
 <sunshine@sunshineco.com>
Subject: Re: [PATCH v6 00/27] Compile with `-Wwrite-strings`
In-Reply-To: <cover.1717740365.git.ps@pks.im> (Patrick Steinhardt's message of
	"Fri, 7 Jun 2024 08:37:34 +0200")
References: <cover.1716983704.git.ps@pks.im> <cover.1717740365.git.ps@pks.im>
Date: Fri, 07 Jun 2024 10:34:03 -0700
Message-ID: <xmqqa5jwejxw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 22E86C38-24F4-11EF-A234-6488940A682E-77302942!pb-smtp2.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> The only change is in patch 12, where we now allocate a buffer later in
> time to avoid a useless allocation and the need for a call to free.

That makes sense (and is closer to the original anyway).

Will queue.  Thanks.

