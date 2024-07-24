Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B652815AADE
	for <git@vger.kernel.org>; Wed, 24 Jul 2024 16:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721837461; cv=none; b=NnF0b0AEf3cfkxy2wfurn7xQH8G2eKHUXz4dttprJ9hJCqu72xTSY2E72MsHnrSO/I9PngsGnWSb4wd9/G6OqO0QjLENGqAUDQXiYa+FHg1or9QNkWhPI+F38lNvggGPL56BTFR3Lo+mner8DB4rQQPT9BCkupkUrdD63nhvbTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721837461; c=relaxed/simple;
	bh=pcPTl/rj6QQ05Sj40Hvk9m2QtwoyNDyTjW2F0k153dc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DahUpt537A2yU+fI+h1A1GDpPxaqr3kKqGq4S/cAiBNlbtMQtWOoUvDogaeQ8/Ro5wBgzGm+5a3AQPfPInA/j+Uyar2divUHu9jiIzdwTNjMla5myeWEFvRFcnEYkH4dVtvRGH+Au9kBrFS//YbYCnqRgGV01b4fdSZ2jOBPLWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=hxWU9x38; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="hxWU9x38"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 4EE941CF3A;
	Wed, 24 Jul 2024 12:10:59 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=pcPTl/rj6QQ05Sj40Hvk9m2QtwoyNDyTjW2F0k
	153dc=; b=hxWU9x38hPN43jzyXwwbZ8XLttWnFQWuRQuacRgqF91tfUnpcvO/Do
	4mGI4c1p8ASeNh6VB6MDnC2LeJO6NxuuobX6aPWsTRvD3w2on0TICZabRgS4bYHE
	ColMyWxWvPT4I0RgQMUvkzbdbvY6A/m24baslouE6R53WUrMIhvtA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 48D461CF39;
	Wed, 24 Jul 2024 12:10:59 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C5BF81CEF1;
	Wed, 24 Jul 2024 12:10:55 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,  git@vger.kernel.org,
    Emily Shaffer <nasamuffin@google.com>
Subject: Re: [PATCH 2/3] ci: update Perforce version to r23.2
In-Reply-To: <ZqDC7O985AUUg3Pd@tanuki> (Patrick Steinhardt's message of "Wed,
	24 Jul 2024 11:01:32 +0200")
References: <cover.1721740612.git.ps@pks.im>
	<ee5d836b779087890acdad061ef6995642942479.1721740612.git.ps@pks.im>
	<da9c4d1e-0fce-3bf3-c35b-32704a8a2129@gmx.de>
	<ZqDC7O985AUUg3Pd@tanuki>
Date: Wed, 24 Jul 2024 09:10:54 -0700
Message-ID: <xmqqmsm6ydm9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 4EA82EBE-49D7-11EF-9BF6-9625FCCAB05B-77302942!pb-smtp21.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> I don't think that is a good idea. If we stop installing p4, the result
> is that _nobody_ will ever run the tests at all. The tests, and by
> extension git-p4 itself, would start to bitrot and we wouldn't notice
> any kind of regressions at all anymore.
>
> If we want to consider going down that route, I'd rather say we should
> do it all or nothing: either we rip out git-p4 and the tests, or we
> leave both of them in. I couldn't care less about git-p4 itself, so I
> would not mind ripping it out altogether. But there may be users of this
> script out there that do care, so I don't want to make that decision
> unilaterally.

Yup, I was actually interpreting Dscho's message as advocating the
removal of "git p4".  Such a move would certainly force people who
do care about it to come out.  It is up to them to volunteer to help
maintaining "git p4".

This may be a good example to discuss "support policy" not on niche
platforms but on niche features (Emily Cc'ed).

Thanks.
