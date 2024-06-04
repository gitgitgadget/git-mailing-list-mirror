Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5AE179BC
	for <git@vger.kernel.org>; Tue,  4 Jun 2024 18:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717524015; cv=none; b=vFNtL/6cpbC/KaAWdahErLWeoJtVxlx1zvGmv/zs9eaVqobSq+QO8cnOWZ27x/s4x2Gd5Vzdo8v+IePB0+Y6ANNGhBOL5Mu5NIvcwnJsjxzDSu1WcegqQ5hhWs34luBBHn1tD5vVj4paZNnLaS0RgLoq1lqkTdDRGf0RZRBIfLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717524015; c=relaxed/simple;
	bh=YQeTdfyOBaCUxKp833mhUDdLnnrr0KvyuJ+yMSgO5Fo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JZV67AE4Hscvy/DUAdjV9XMmXOljAx+9CXHBDA1RUfEJdkZm7AxI1mvyvN3IxuEJP+cq1W0EZVvVrR7s75XkORaGdllkBrs3LpFqGyDowkyvVwO01LgX9TDghVDNJqHvkGmY9Kd+C69L6rJ3q+ik3CV9oLaGNpCiBg+qVD4nPYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=kYOtEBU3; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="kYOtEBU3"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7BF7B1D1C5;
	Tue,  4 Jun 2024 14:00:13 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=YQeTdfyOBaCUxKp833mhUDdLnnrr0KvyuJ+yMS
	gO5Fo=; b=kYOtEBU3Zk+qxeiLAHKOtshYXfTWBk6O0nXIQ4lZEVuzfKrfqgmK6Z
	cfBGoMqSK8XeNCOjYimjdEMLvgnXmTGRmBxaaOMYqf4J1SQZTf6IxMetv7XwuO7v
	kO9uFLtgIAMzmJwm/E7dAewJSHGyNfOLz8le9VvvJw9L0DJk6CloY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 718341D1C4;
	Tue,  4 Jun 2024 14:00:13 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AE7AD1D1C3;
	Tue,  4 Jun 2024 14:00:12 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Johannes Schindelin <Johannes.Schindelin@gmx.de>,
  Phillip Wood <phillip.wood123@gmail.com>,  Justin Tobler
 <jltobler@gmail.com>,  Dragan Simic <dsimic@manjaro.org>,  Karthik Nayak
 <karthik.188@gmail.com>,  Todd Zullinger <tmz@pobox.com>
Subject: Re: [PATCH v6 3/4] BreakingChanges: document removal of grafting
In-Reply-To: <b25b91a5e707f671785012c1b4a68c36241e537e.1717504292.git.ps@pks.im>
	(Patrick Steinhardt's message of "Tue, 4 Jun 2024 14:32:46 +0200")
References: <fc1a9fa03de7330f79dc56b0f2712834cb236b5a.1715070296.git.ps@pks.im>
	<cover.1717504292.git.ps@pks.im>
	<b25b91a5e707f671785012c1b4a68c36241e537e.1717504292.git.ps@pks.im>
Date: Tue, 04 Jun 2024 11:00:11 -0700
Message-ID: <xmqqo78gvb9w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 4A3A07A6-229C-11EF-AB0B-B84BEB2EC81B-77302942!pb-smtp1.pobox.com

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
>  Documentation/BreakingChanges.txt | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/Documentation/BreakingChanges.txt b/Documentation/BreakingChanges.txt
> index 5d7e80aebb..9fb6d8c78a 100644
> --- a/Documentation/BreakingChanges.txt
> +++ b/Documentation/BreakingChanges.txt
> @@ -96,6 +96,18 @@ Cf. <2f5de416-04ba-c23d-1e0b-83bb655829a7@zombino.com>,
>  
>  === Removals
>  
> +* Support for grafting commits has long been superseded by git-replace(1).
> +  Grafts are inferior to replacement refs:
> ++
> +  ** Grafts are a local-only mechanism and cannot be shared across reositories.

"reositories" -> "repositories".

> +  ** Grafts can lead to hard-to-diagnose problems when transferring objects
> +     between repositories.
> ++
> +The grafting mechanism has been marked as outdated since e650d0643b (docs: mark
> +info/grafts as outdated, 2014-03-05) and will be removed.
> ++
> +Cf. <20140304174806.GA11561@sigill.intra.peff.net>.
> +
>  == Superseded features that will not be deprecated
>  
>  Some features have gained newer replacements that aim to improve the design in
