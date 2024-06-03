Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6F37E8
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 16:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717432937; cv=none; b=kWYwnMLmVCswtdEHMKAWB5LQC4i23SLA8P0X8pKrC2pm3eO2thG1GukZEfZf4exhIZa9X7dyoFrz0R20LzBLBPhlLOrsw3iA/PumP+7yld0Ia8KixdUPA2idgJKWsIxzTgSQEoOKuSj8Acu2HoQyyaH5nwVuSMEiMYo3LlSjWZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717432937; c=relaxed/simple;
	bh=NdR0UqcrKKWoEjcmMuTaSn4j58WPhzW1LtLBSEQ3Y3g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=c8rFPIlftdvpdv9LrJlSEGYhI5PtSaTaGZ4v3XargPK1FKT6bp3ouDtQ9yTGpJPowm6lS87DI3x0RJkoUwtaa/Hv5TxAaHF5peQHggtBBAtPLnwjmx0ecjgmZ0U8HWVSZKXiwEcDIuSlA6eBbq9vDHDXFne+Ely5Pj0YsPyMCBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=eZORLOs2; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="eZORLOs2"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E1C042C95B;
	Mon,  3 Jun 2024 12:42:14 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=NdR0UqcrKKWoEjcmMuTaSn4j58WPhzW1LtLBSE
	Q3Y3g=; b=eZORLOs2S7SWoW+P6uBqqJuLR/M5MkcHXCHoULKWQ87oEeYCeWcR5E
	EN9/HXvyhxWLQxJF6SLYTLddfygZ7ZQjryEhpX51xpPw2sfiKDJArmOYZD+kmwOl
	wSxen190EpOKnD0w6A89Tavh+JJM60fjDgH8TbQ7E/FnoIvYV2TEc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D89382C95A;
	Mon,  3 Jun 2024 12:42:14 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4F4A72C959;
	Mon,  3 Jun 2024 12:42:14 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Johannes Schindelin <Johannes.Schindelin@gmx.de>,
  Phillip Wood <phillip.wood123@gmail.com>,  Justin Tobler
 <jltobler@gmail.com>,  Dragan Simic <dsimic@manjaro.org>,  Karthik Nayak
 <karthik.188@gmail.com>,  Todd Zullinger <tmz@pobox.com>
Subject: Re: [PATCH v5 3/4] BreakingChanges: document removal of grafting
In-Reply-To: <4142e472ac54f5008b0566fdb967f86677171491.1717402497.git.ps@pks.im>
	(Patrick Steinhardt's message of "Mon, 3 Jun 2024 11:28:32 +0200")
References: <fc1a9fa03de7330f79dc56b0f2712834cb236b5a.1715070296.git.ps@pks.im>
	<cover.1717402497.git.ps@pks.im>
	<4142e472ac54f5008b0566fdb967f86677171491.1717402497.git.ps@pks.im>
Date: Mon, 03 Jun 2024 09:42:13 -0700
Message-ID: <xmqq8qzm566y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 3B466BA6-21C8-11EF-9755-6488940A682E-77302942!pb-smtp2.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> The grafting mechanism for objects has been deprecated in e650d0643b
> (docs: mark info/grafts as outdated, 2014-03-05), which is more than a
> decade ago. The mechanism can lead to hard-to-debug issues and has a
> superior replacement with replace refs.
>
> Follow through with the deprecation and mark grafts for removal in Git
> 3.0.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  Documentation/BreakingChanges.txt | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/Documentation/BreakingChanges.txt b/Documentation/BreakingChanges.txt
> index 904857a636..b5088dcce2 100644
> --- a/Documentation/BreakingChanges.txt
> +++ b/Documentation/BreakingChanges.txt
> @@ -87,6 +87,14 @@ Cf. <2f5de416-04ba-c23d-1e0b-83bb655829a7@zombino.com>,
>  
>  === Removals
>  
> +* Support for grafting commits has long been superseded by git-replace(1).
> +  Grafts are inferior to replacement refs as the mechanism can lead to
> +  hard-to-diagnose problems when transferring objects between repositories.

The replace refs will be transferred, but the graft is a purely
local mechanism and there is no way (other than by human
intervention) to communicate the graft entries across repositories.

That is the primary thing we should list as the reason why the
replace mechanism is a better alternative over the graft mechanism.

> +  They have been outdated since e650d0643b (docs: mark info/grafts as outdated,
> +  2014-03-05) and will be removed.
> ++
> +Cf. <20140304174806.GA11561@sigill.intra.peff.net>.
> +
>  == Superseded features that will not be deprecated
>  
>  Some features have gained newer replacements that aim to improve the design in
