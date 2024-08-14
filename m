Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C57A3BBF7
	for <git@vger.kernel.org>; Wed, 14 Aug 2024 04:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723611543; cv=none; b=VF3g/zNJ2uYfmpJZ7P7PAr3TblQatI8/OGxS7vfpYlkoPOLQ4MH+DLjSfxmKUaJKzhZm75IuuS4jN/XudtnIyIr3myDqParbkmvKmT54Oxmp5fQtaGxCqezLMtdfNsrLvwKcShhqMI8FKQVvcyZPjg0O3Pm2EGmPEGDHD8rs4KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723611543; c=relaxed/simple;
	bh=+QM+eTckAWLWELP1JbvNA77PD44LYI0ws93JmBYhiXI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MHrosZ/88RnZOhLALNoIItHEhqRpO32Qxq0nocDUh/amplv2ZwMpb4o7Z7FRH31HuNp58b3E8F0EdW+liOgc9MEbyg8kQa393SUpYatbSgNza3E5lzGoIXzj0zYJ0EAKUCTzgwA4+tVc3W5O+4wdn3HOWsiMjpQEqh3dPBzqe0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ANXhlks7; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ANXhlks7"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 8C5FB244BC;
	Wed, 14 Aug 2024 00:59:01 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=+QM+eTckAWLWELP1JbvNA77PD44LYI0ws93JmB
	YhiXI=; b=ANXhlks7FfMCrki6Ac7HIXXO17treth8tCCY9aru1vRHFv141r3LPt
	wcYFUvtGWdfJIKP+pijQoXMkYFbVSK0ch3HakAOD+ATfzgF0EBNBX8YHQELdkomC
	n5x6cBdeUgWuCXG5/7OVE0V1DZUO0iLLCkv7SiE1GDpXUOnH3peuU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 84BD0244BB;
	Wed, 14 Aug 2024 00:59:01 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 032DD244B7;
	Wed, 14 Aug 2024 00:58:57 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc: Ghanshyam Thakkar <shyamthakkar001@gmail.com>,  git@vger.kernel.org,
  Patrick Steinhardt <ps@pks.im>,  Karthik Nayak <karthik.188@gmail.com>,
  Phillip Wood <phillip.wood123@gmail.com>,  Christian Couder
 <christian.couder@gmail.com>,  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [GSoC][PATCH v2] t: migrate t0110-urlmatch-normalization to the
 new framework
In-Reply-To: <b369797c-37c0-4f17-b857-a2ff8680cb4f@gmail.com> (Kaartic
	Sivaraam's message of "Wed, 14 Aug 2024 07:05:47 +0530")
References: <20240628125632.45603-1-shyamthakkar001@gmail.com>
	<20240813172432.55487-1-shyamthakkar001@gmail.com>
	<xmqqh6bo448j.fsf@gitster.g>
	<b369797c-37c0-4f17-b857-a2ff8680cb4f@gmail.com>
Date: Tue, 13 Aug 2024 21:58:56 -0700
Message-ID: <xmqqo75v3dkf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 EA0E3A56-59F9-11EF-BE16-E92ED1CD468F-77302942!pb-smtp21.pobox.com

Kaartic Sivaraam <kaartic.sivaraam@gmail.com> writes:

> I'm not sure there would be a straight-forward way to have these inputs
> in the C source file. There may be some way to represent them in an
> alternate form but I suppose that would sacrifice the readability of
> these inputs which I believe is also a significant factor for test
> cases.

Just as a byte string, all bytes \012 octally expressed?
