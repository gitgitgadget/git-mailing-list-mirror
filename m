Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BAC085270
	for <git@vger.kernel.org>; Wed, 21 Feb 2024 17:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708538187; cv=none; b=hr6aw2V+7PyASI3Ps3zCqRUQxoDFu9xCiXwikQqc+OUxQW1Rppr6tT/qyhoyfcqdc3g+UCyQ5DpAqw8ud8ZE1O6YvGGWqcXWb6YZ6hMyqh7efM/PLjxv40FNmui4Zu7dCqcxaJu9pE2JXQVY6T27eucERRoVisNxihzmVKaGzwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708538187; c=relaxed/simple;
	bh=5H6tm8Ds5UhSrLe5xFoat1iB1GhrpbYDpuRINLY33Fo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ksHWC2I/Blf0DosAefU+T4HTLYmqzqnE2NPdKgEEhyliE2J5kM9haKfY2TBnKZ9cSfK7GJgiBeTc5Zx5hTLguqvNIViC/Zcsyg/b8afP1ydnWJzjy3Z6ia/hopRybUJblww5NkBAJ3nIQ+ZPUipexgdNVjuk+k1z3/pJjRqBs8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=JKDqAypr; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="JKDqAypr"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 671D4317D2;
	Wed, 21 Feb 2024 12:56:25 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=5H6tm8Ds5UhS
	rLe5xFoat1iB1GhrpbYDpuRINLY33Fo=; b=JKDqAypr8IY37zkGOFPsVKvhaUm2
	R/oaUJuChOBxxT2KqDD7S1SVKfP9cMESXyaj558kxzjaxraA9+zjuDTZG1PgXPfS
	uLoDeODHWb/i/Z1ztExQ/J3/bWORDDadd22epVlnGqg2PXsUOoJnXiOiGLFzzTtt
	Tvo9OJDd3F7Mau4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 5F11A317D1;
	Wed, 21 Feb 2024 12:56:25 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 009EB317D0;
	Wed, 21 Feb 2024 12:56:21 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Michal =?utf-8?Q?Such=C3=A1nek?= <msuchanek@suse.de>
Cc: Harmen Stoppels via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Harmen Stoppels <me@harmenstoppels.nl>
Subject: Re: [PATCH] rebase: make warning less passive aggressive
In-Reply-To: <20240221173822.GA9696@kitsune.suse.cz> ("Michal =?utf-8?Q?Su?=
 =?utf-8?Q?ch=C3=A1nek=22's?=
	message of "Wed, 21 Feb 2024 18:38:22 +0100")
References: <pull.1669.git.1708442603395.gitgitgadget@gmail.com>
	<xmqqv86jqc2e.fsf@gitster.g> <20240221173822.GA9696@kitsune.suse.cz>
Date: Wed, 21 Feb 2024 09:56:20 -0800
Message-ID: <xmqqr0h5og57.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 85BFA8B4-D0E2-11EE-8F7E-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

Michal Such=C3=A1nek <msuchanek@suse.de> writes:

> Or if it does touch the po files it could as well update the
> translations.
>
> There are changes that can be trivially translated without any knowledg=
e
> of the target language.

You need to know the target language before deciding it is OK and
sufficient to just remove =CC=89=C2=BF? from around a sentence to make it=
 from
a question to a statement of a fact.  You may know enough, but
reviewers may not be.  In addition, it would allow bypassing the
language teams, which is the most serious problem I see in such an
attitude.
