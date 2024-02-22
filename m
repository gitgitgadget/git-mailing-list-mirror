Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE57134CEF
	for <git@vger.kernel.org>; Thu, 22 Feb 2024 16:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708618552; cv=none; b=tGRzOjMVDQGel6ZBEQRmGsigMGR1d4POW6Xp7zqovMnM4sakUeLlqkH14mn3JvREN+N+ZSrm7Z5tA74i3rsIMMsMgoOFlAuuUUOWN27OVZeWxAbBTBAcFiqnmHDt1WPKs9RvLgdXxzwe026cnf36O7onjPEHzPP04ZwP06c/Ooc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708618552; c=relaxed/simple;
	bh=XhU+NL0G9Xv8R9snhJYQTu/IqhDMxeiK4twXtSCf6b0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PdOf1BRSYSlR0uMVM4u7GtPuDYtiszrJWBSYuo/0PCOdUNZtDbkihltlUJndF1rkr1aTdGurmP5+qkgLDwoEgcCcxMvrBm5xpuL7gchfOVJ2WpwAr37dQwD7PKb2bXaPxvPZWN9Gqvtp/8w2NgB19UdhxqDCZoikmeb2q8ckOrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=aAEZUlWb; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="aAEZUlWb"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id EAD4C1D6200;
	Thu, 22 Feb 2024 11:15:49 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=XhU+NL0G9Xv8R9snhJYQTu/IqhDMxeiK4twXtS
	Cf6b0=; b=aAEZUlWbFZkFaoACzZCcm5mSpo/rr6qed0ILwJwZUgCzTzatbUKJwu
	fvhnzlhnqJZzM0/WuIvPh/W+GaWQHqPDD8VUJGHVwG3EE07xi/Bh7rVy0LaLJrRs
	+JZgQawO3gnrUEp9RUUdwb1i0dR94vn7p5psyM3edY6J8Bdbpqznw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E04E61D61FF;
	Thu, 22 Feb 2024 11:15:49 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4E4D21D61FE;
	Thu, 22 Feb 2024 11:15:49 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Karthik Nayak <karthik.188@gmail.com>,  git@vger.kernel.org
Subject: Re: What's cooking in git.git (Feb 2024, #07; Tue, 20)
In-Reply-To: <ZdcFDEg4Gl8YpCQi@tanuki> (Patrick Steinhardt's message of "Thu,
	22 Feb 2024 09:25:48 +0100")
References: <xmqqplwrqbd2.fsf@gitster.g>
	<CAOLa=ZQOtDgyWxmV+C9r_wfqo-KdJ5uqW4KwJKD8WdT9qM0t2Q@mail.gmail.com>
	<xmqqle7drcm5.fsf@gitster.g> <ZdcFDEg4Gl8YpCQi@tanuki>
Date: Thu, 22 Feb 2024 08:15:48 -0800
Message-ID: <xmqqmsrsiiff.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 A4673EB0-D19D-11EE-8A02-25B3960A682E-77302942!pb-smtp2.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> This version already has the updated UI with `--include-root-refs`.
> There has been some discussion around whether we want to refactor the
> refname checking interfaces so that we do not have to introduce the two
> new helper functions `is_pseudoref()` and `is_headref()`. But that would
> result in a lot of churn, and we thus agreed that it is fine to do that
> in a follow up patch series.
>
> I then forgot to have a look at the remaining patches. I can do that
> today.

Thanks.
