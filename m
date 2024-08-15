Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1997C2562E
	for <git@vger.kernel.org>; Thu, 15 Aug 2024 15:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723736268; cv=none; b=IdEnOw/D45EtdQRW9aDsdHybGYYdYI8+STWzqpMiu4a3bIfl9AoVgPSwaOy7/NOfs0dEUOvUdhEpE4jxDtYzb74SJCWzE/grRYwNMOVnEa6hpA2+Qgou/CHYGe4TTHzc5C58hmQ8TpxAxeZejkU2rTngKmRcxIHrQMh/2Ll75nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723736268; c=relaxed/simple;
	bh=/GHC/EA50ipeJeB4lQ9u+Tf+pcWud0v4lEAXMLdsrNk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ie4ycHGs8wuT/Ge8eZ9nSHLwj6PkIzCK3ygAXdUMZAaHGegXRUDhqeHUdMsi98F77p1It65eGV9HzVFNsC+HIDBYcGhdwGdd5ZfiS6Ss75lDz29GhROILLTvfN5ts1YXeHdsnIlO/1IQudDwq4x76ZXSlC+dLx9zDKjko0AP2aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=fuheHvcO; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="fuheHvcO"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 2038122CED;
	Thu, 15 Aug 2024 11:37:40 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=/GHC/EA50ipeJeB4lQ9u+Tf+pcWud0v4lEAXML
	dsrNk=; b=fuheHvcOXtWJYrrekBntIjWHkutGFcGx53wK57qayEX5jgPcqwYscD
	VwlwhVzVuaTRgt1CKC0z6SWKBZ8cO+RRZ7TO3/nLBmgMBRZ6Zv3D2kA98Iw3iOI2
	CNOphQ7xqH+qGoPnUYoIpU+89/iiaHvBYm1v0NuMlQj24rG6ES1Ho=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 17DB222CEC;
	Thu, 15 Aug 2024 11:37:40 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7E93122CEB;
	Thu, 15 Aug 2024 11:37:39 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org
Subject: Re: [PATCH 0/7] builtin/maintenance: fix auto-detach with
 non-standard tasks
In-Reply-To: <de298972-a359-46dd-b808-4edaa8701d40@gmail.com> (Derrick
	Stolee's message of "Thu, 15 Aug 2024 10:04:10 -0400")
References: <cover.1723533091.git.ps@pks.im>
	<de298972-a359-46dd-b808-4edaa8701d40@gmail.com>
Date: Thu, 15 Aug 2024 08:37:38 -0700
Message-ID: <xmqq8qwxvltp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 4DDD53F0-5B1C-11EF-813E-9B0F950A682E-77302942!pb-smtp2.pobox.com

Derrick Stolee <stolee@gmail.com> writes:

> I sprinkled in commentary, and most of it was just things I noticed
> while reading the series in order but then later patches or a careful
> read made my comments non-actionable.
>
> This v1 looks good to me.

Thanks for a "think aloud" review.  Very much appreciated.

I thought there was a minor reroll for phrasing planned, without any
other change on significant part of the series?  Let me mark the
topic for 'next' when it happens.

Thanks, both.

