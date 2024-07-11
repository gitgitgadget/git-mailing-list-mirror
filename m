Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B029316A921
	for <git@vger.kernel.org>; Thu, 11 Jul 2024 14:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720708697; cv=none; b=LHj102ZSvOhp0IcLIqKB8RceDng6AfjYj+6wF9PoFCbOtsQqqnEJNLM0qp1Ky5XoL/TrFxtg6DaBxWvosc8K4b0X9d3vrNcAtFwSJBPmlzdIU03GRFHafHoxDC5ZtnCnXPlTXFkjN95IgOntvTUM2e3EGi7u1dnmwZHFxc9R35k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720708697; c=relaxed/simple;
	bh=cTRHvN/UxilEg8QqIyF0Mzmg4dcZ2EcCiOuy0xP5gC8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=W8PKdYj5cwOzi1oGRwtW3/NdxnJIyQMw9/O2FuauOxastfMP94ZYKt0SAZz8YQlOUsn/UuH8LdfraOSlwZ0vl2oOy8QhnTu5NGwTBTHFzUZUO62J/w2uevy2VIk70TQ9W04drvE8lfAmtPL3IwNJ5lyP0uLPnZRtMEEKp7qbeb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=IGXFmjT2; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="IGXFmjT2"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 2532324CDE;
	Thu, 11 Jul 2024 10:38:15 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=cTRHvN/UxilEg8QqIyF0Mzmg4dcZ2EcCiOuy0x
	P5gC8=; b=IGXFmjT2/3OMA0CjoqRl5nzfdPQpkPf1EDKG9nAjpYkyQGnlJi0Ln3
	wobbP92Dlno9HajYSkzmnW6eqfSSsopL+weGRqyydteh8ky5wWa7UIdm4Ax+PU/V
	zQg8Pl8wu/GinMbIelasuFcd6xKBkauUvcB7SFyZi+es5dJZoDAOI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 1DB2924CDD;
	Thu, 11 Jul 2024 10:38:15 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.219.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9CA6D24CDA;
	Thu, 11 Jul 2024 10:38:11 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,  git@vger.kernel.org,
  chriscool@tuxfamily.org
Subject: Re: [GSoC][PATCH v2 0/7] t: port reftable/merged_test.c to the unit
 testing framework
In-Reply-To: <CAOLa=ZR4jZhwzyQtJ=zC0wYJ9=u2CPKDgps57e-zCgQ279mYVQ@mail.gmail.com>
	(Karthik Nayak's message of "Wed, 10 Jul 2024 02:19:31 -0700")
References: <20240703171131.3929-1-chandrapratap3519@gmail.com>
	<20240709053847.4453-1-chandrapratap3519@gmail.com>
	<CAOLa=ZR4jZhwzyQtJ=zC0wYJ9=u2CPKDgps57e-zCgQ279mYVQ@mail.gmail.com>
Date: Thu, 11 Jul 2024 07:38:09 -0700
Message-ID: <xmqqwmlsngdq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 32C937CC-3F93-11EF-AB5D-C38742FD603B-77302942!pb-smtp20.pobox.com

Karthik Nayak <karthik.188@gmail.com> writes:

> This series looks good now, sans a typo and Justin's comment!
> Thanks!

Thanks, all, for helping the series (and Chandra) along.

