Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA3D1BDC8
	for <git@vger.kernel.org>; Fri, 10 May 2024 18:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715367573; cv=none; b=fNRI5T0pDGxG/9QK1yuWFBTVzlccYB6RezZKDJzMqHK13QlNU5QufQH+UedM7z1OmDO4RqtwOCng38mJ+UviBm1vYh4FwuOzRAeGK5Qu5/UuX2NZoT+yuyElfGwltzGtGyMKRdnKRRkg7685bobzLRKzlsP+JNRH+GTra1W6NSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715367573; c=relaxed/simple;
	bh=cE1k1R5FcgG7YGmMYbqloFa6SeiLzcGaEGLiRSawEN8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EoLVFt7gWWsdQ1PhvJUdehvPaPe845fSYSrS/sDvmYIJd0/UIQi4W1nbDJdqTR5Y2WDFsv5u9UzedkE/g7C9EEvxcYamW84fln4PSYOkgvE/rJAhZVza2Ml8WtMpoh6dbaCtkv3ePXp1VogTqlaQmcbnDAalBoGXev3t+5RrNVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=QLTi7VU1; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="QLTi7VU1"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id BCA5B25FCF;
	Fri, 10 May 2024 14:59:30 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=cE1k1R5FcgG7YGmMYbqloFa6SeiLzcGaEGLiRS
	awEN8=; b=QLTi7VU1FNrX5cIrCd+9rsUQZ6jml25UsC5DpJnO/SGz1TZ4h3ERTS
	0Hf5cEp2u7MbkOP+xY4CJ8nbUCb2oU5Umali4fhClo3iOL14mje+556edPDz85SP
	KE9rCS+oI7F/BluygalHYGuLvVq/7EX4Leq7WTbF9FLIoUsPPKi9c=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B497925FCE;
	Fri, 10 May 2024 14:59:30 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2C2DF25FCD;
	Fri, 10 May 2024 14:59:30 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Karthik Nayak
 <karthik.188@gmail.com>,  Phillip Wood <phillip.wood123@gmail.com>,
  Justin Tobler <jltobler@gmail.com>,  Kristoffer Haugsbakk
 <code@khaugsbakk.name>,  =?utf-8?Q?Jean-No=C3=ABl?= AVILA
 <avila.jn@gmail.com>
Subject: Re: [PATCH v4 00/10] Clarify pseudo-ref terminology
In-Reply-To: <cover.1715330206.git.ps@pks.im> (Patrick Steinhardt's message of
	"Fri, 10 May 2024 10:48:01 +0200")
References: <cover.1714398019.git.ps@pks.im> <cover.1715330206.git.ps@pks.im>
Date: Fri, 10 May 2024 11:59:29 -0700
Message-ID: <xmqqpltt4hny.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 6E50644C-0EFF-11EF-9055-25B3960A682E-77302942!pb-smtp2.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

>   - Reorder patches 6 and 7 such that we first correct `is_root_ref()`,
>     and then adapt `is_headref()`.
>
>   - Furthermore, I have inlined `is_headref()` into `is_root_ref()`
>     completely now as it didn't have any users anymore.

This does look like a good change, relative to the previous
iteration.  The code paths gets greatly simplified.

