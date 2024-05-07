Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F6C19E
	for <git@vger.kernel.org>; Tue,  7 May 2024 00:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715041283; cv=none; b=OZPwW3bQTVj/n6SEh21V6Cd7Ku1N2/mv892XoUlN3uXbyk4UxTBtjhOLkS/GirCQHqmjtNM3108Ytw7NvU1SuC+k6zCgf22pihEe5CdOoI0hzQTDxrxrJxbmJgAw4cp3pPNmZYZ8x0FGr6ZGuWn1fTubFb9qYNwAQEime+Qcy7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715041283; c=relaxed/simple;
	bh=DrIiNc6jAHun+vnBm0e24HiAjFTsmleE892qKNTJxI4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VEIG64bXabaU83/JRSaIdnLwdZZfLRv6/aSDau99o4prd1zlSHNek4jXSys4xHQlVB94b2bylEyuJcylizFdx4WaRN/U2m5KuVpPI+lUvhKZ314W0aKNFE9pSJsILORjb46CO8B1wnPmqTZVuOrFz5oWt/6YMaWAgeTHAg8ZQc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=x9lUdiXo; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="x9lUdiXo"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id ACBCB2CFF7;
	Mon,  6 May 2024 20:21:21 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=DrIiNc6jAHun+vnBm0e24HiAjFTsmleE892qKN
	TJxI4=; b=x9lUdiXoJyMcIUoO9N6VQRHS99ncX6PwVSqasWtWECUF1DttjyZ0UM
	jg9898vQkQ8E+/om855zeJhW9zxs70EyAIbWVpN2x8kGa65jc26/9/PeVAGNmW1C
	JXVlRbfreQR71jyYnkXu6vVTVGz+8WX1e+WFDS6ZoAOknEKDDiEBE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id A4F922CFF6;
	Mon,  6 May 2024 20:21:21 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 264442CFF5;
	Mon,  6 May 2024 20:21:18 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Dragan Simic <dsimic@manjaro.org>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,  Eric Sunshine
 <sunshine@sunshineco.com>,  James Liu <james@jamesliu.io>,
  git@vger.kernel.org
Subject: Re: Re* Re* [PATCH v4 0/3] advice: add "all" option to disable all
 hints
In-Reply-To: <5665eef37193e8a6894f100a554bce4d@manjaro.org> (Dragan Simic's
	message of "Tue, 07 May 2024 02:11:29 +0200")
References: <20240430014724.83813-1-james@jamesliu.io>
	<20240503071706.78109-1-james@jamesliu.io>
	<ab604f4b73eab1d9aae4e2a20ba0630e@manjaro.org>
	<xmqqjzka7p2t.fsf_-_@gitster.g>
	<CAPig+cRZEQjwhnMYvQ_0BjvXaR=3x=LQeJHzFOxC+ZPyOy9yJQ@mail.gmail.com>
	<xmqqbk5m65i8.fsf@gitster.g> <xmqq4jbe64l9.fsf@gitster.g>
	<CAPig+cT-xk13jGEUmpT5QmwVYTxKNUZsu9xJ=Ph3h4AzKHg6pA@mail.gmail.com>
	<34d77e4d-6edb-99d0-7fc5-fea5224654c7@gmx.de>
	<xmqqbk5i3ncw.fsf_-_@gitster.g>
	<5665eef37193e8a6894f100a554bce4d@manjaro.org>
Date: Mon, 06 May 2024 17:21:16 -0700
Message-ID: <xmqqikzqwjyb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 B91CAF94-0C07-11EF-AC6E-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Dragan Simic <dsimic@manjaro.org> writes:

> See, the creation factor is described in the documentation as some fudge
> factor, specified as a percentage.  Without going through the actual
> source code in detail, a question that pops up in my mind is why do we
> need to use 999 or 9999 as the new default value?  Shouldn't 99 or 100
> be good enough instead, if it's a percentage?  I'd assume that the same
> question might be asked by other Git users.

It is very much deliberate to choose a value beyond 100.  Setting
the value to such a large value was designed to force somebody to
ask that question: "what does the value mean?" [*], and in a sense
it already has achieved one half of its objective ;-).

We never had an satisfactory update to the range-diff documentation
when we discussed this parameter in the past.  It was stated that
the unit to express the value for creation-factor was called
"percent", but it seems that nobody had a good explanation that can
be given to a layperson what that percent means (e.g., what is it
relative to?  what it means to have that value at 100% as opposed to
say 50%?).  Somebody should come up with an easy-to-understand
explanation suitable for users after reading and digesting the
overly technical "algorithm" section of the manual, and forcing
ourselves to do a good job at it is the other half of its objective.


[Footnote]

 * Having more than 100 as a value that is measured in "percent" is
   not unusual, by the way.  You can zoom into a picture at
   magnification level of 400%, for example.


