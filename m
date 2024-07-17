Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96F81DDD1
	for <git@vger.kernel.org>; Wed, 17 Jul 2024 18:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721240227; cv=none; b=eMtV7vXESnfwyC0gDE3aWzUSNqboTewlgKrtSgce3TzfDLYeCsNDrV27QW7eK7EVxnMd+ifAWraq+QY3ygrFXfTQv+Gci2yY3iOvDu/a5+HwmNfejp5EEf4Vfbh+NCdmLw+D0VPlqH/ZxSUp0DLxNnK3gNZYtMxJ+ML3ID/zrfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721240227; c=relaxed/simple;
	bh=nDwP8zNdcdywZNN0HVC6ONV3/C1T8om1Nz1lh6+hIVc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KCRMeUSfrh72IY7O7a8+nbQuBR/Pgyot4Jr5B9NmYecYatPMcuTC8oxdiZsFuZeR26Mtj3NrL1cD3U+ePgTT1kq/LN1FFua6YitRN72urN+psCj79sqsi81vuGoN9hzkEH3Qoyy8AjmmCo3vVXygn5O9XP4AjtOwqFH3EJf9Mmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=kqN/t+jv; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="kqN/t+jv"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 1E78B3671C;
	Wed, 17 Jul 2024 14:17:05 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=nDwP8zNdcdywZNN0HVC6ONV3/C1T8om1Nz1lh6
	+hIVc=; b=kqN/t+jvAV/4BEggfub/FvAIlEX/di5PvcSukG2GHHEcVGgU7axKic
	M3p7nc90mcVCv8vvSN1chjMEGpwnxm6r+4ZVNURkf42pTRW16l4AxkydUZkgAusp
	UY7Qm4eEP35hlHd36+oYt7O00aoSJN+qopXdFS34rsb0jZSWCl11E=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 0447E3671B;
	Wed, 17 Jul 2024 14:17:05 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 637FF36719;
	Wed, 17 Jul 2024 14:17:01 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Emily Shaffer <nasamuffin@google.com>
Cc: git@vger.kernel.org,  "Randall S. Becker" <rsbecker@nexbridge.com>,
  Taylor Blau <me@ttaylorr.com>,  Johannes Schindelin
 <johannes.schindelin@gmx.de>,  =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?=
 Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2] Documentation: add platform support policy
In-Reply-To: <CAJoAoZnbsqF7xi9AW4--d9Dsfh=GnRuko6rRELsGUW0ihRvaVg@mail.gmail.com>
	(Emily Shaffer's message of "Tue, 16 Jul 2024 10:58:52 -0700")
References: <20240711232413.693444-1-emilyshaffer@google.com>
	<xmqqed7ylbna.fsf@gitster.g>
	<CAJoAoZnUbgX1MpisdS+TkGLFrBUyX_x_M_Q6iZ2n_AhP8r4mNA@mail.gmail.com>
	<xmqq34oa1an3.fsf@gitster.g>
	<CAJoAoZnbsqF7xi9AW4--d9Dsfh=GnRuko6rRELsGUW0ihRvaVg@mail.gmail.com>
Date: Wed, 17 Jul 2024 11:16:59 -0700
Message-ID: <xmqqbk2v3muc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 C337C100-4468-11EF-BCC1-DFF1FEA446E2-77302942!pb-smtp21.pobox.com

Emily Shaffer <nasamuffin@google.com> writes:

> What's next to move this patch forward? Should I be asking around for
> more people to review it?

This round has been out there long enough and without an updated
round, the patch is unlikely to see more reviews, I would think.

Let's see an updated version soon and see what happens.



