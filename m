Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F17522E
	for <git@vger.kernel.org>; Fri, 19 Apr 2024 02:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713492835; cv=none; b=PHyuUey31lQFWQ+kqAxiBpOIgmrcoO2v0kIi+7ZSjQW1CBrQ0wfvF3AhJd12+ZByMrFDTQPXqaWR6un5uS2y+JGNeBKwPw3YWzZp5HIcXsXB/bb6OWde554nHxPJL1RyOOxhaQKuIqdPDoUd/utQFo/Ep9rmxNt7C4cOBrCXlg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713492835; c=relaxed/simple;
	bh=CQgIR2lNikdVJB203Vurj94lYg+eIwUQD2eGM5rsqwQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Z3IF4OYg0YYeVEnNLZaD7cvYNpGOdi8bZYOCQtnchZBlbkRcPoB/DHQ39bquGHs8hahPsUZU5h0tbp90EzJRgL1jFt3V9q5IEnjVVuK0JbNzh+fMg/LbZCmCLoT1bVenUOdn48CoRnly/7qaG7ihQCu9UcHVNlx1KPMsMzuhKhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=dCmMU52F; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="dCmMU52F"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id C5AF926426;
	Thu, 18 Apr 2024 22:13:53 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=CQgIR2lNikdVJB203Vurj94lYg+eIwUQD2eGM5
	rsqwQ=; b=dCmMU52FKE36wTtupztitrrWj9HSR1cGMstB43xFyR24hNgWrZRzP/
	Hsa+uvBMcek2/qRqJo+SGFZ6K7Tbdo76/rqdvIyNhGoMzkxJa9t6T0EJVTOd50+G
	Ip9UemasH+bGKQRy2F+YKXgm0BwMpprcH5wDhH/1zLdhIX/gc4D8w=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id BE82826425;
	Thu, 18 Apr 2024 22:13:53 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4339826424;
	Thu, 18 Apr 2024 22:13:50 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Dragan Simic <dsimic@manjaro.org>,  Phillip Wood
 <phillip.wood123@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH 3/4] format-patch: new --resend option for adding
 "RESEND" to patch subjects
In-Reply-To: <CAPig+cT9A9N=zGZDXuB+c17L8hZ-h5zvZgD5W-8VYqiM9QaBew@mail.gmail.com>
	(Eric Sunshine's message of "Thu, 18 Apr 2024 20:15:11 -0400")
References: <cover.1713324598.git.dsimic@manjaro.org>
	<1d9c6ce3df714211889453c245485d46b43edff6.1713324598.git.dsimic@manjaro.org>
	<154b085c-3e92-4eb6-b6a6-97aa02f8f07d@gmail.com>
	<xmqq7cgwau1v.fsf@gitster.g>
	<c2cb9268c29ae4a5cac34383b7443763@manjaro.org>
	<xmqqle5b66sr.fsf@gitster.g>
	<19d5f3d4c99fc1da24c80ac2a9ee8bf8@manjaro.org>
	<84dcb80be916f85cbb6a4b99aea0d76b@manjaro.org>
	<xmqq5xwepafi.fsf@gitster.g>
	<CAPig+cT9A9N=zGZDXuB+c17L8hZ-h5zvZgD5W-8VYqiM9QaBew@mail.gmail.com>
Date: Thu, 18 Apr 2024 19:13:48 -0700
Message-ID: <xmqqedb2nlpf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 76408614-FDF2-11EE-873B-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Eric Sunshine <sunshine@sunshineco.com> writes:

> I do understand and am sympathetic to the desire to reduce the typing
> load (hence, the original `--resend` proposal), but I have difficulty
> believing that `git format-patch` is so commonly used throughout the
> day that the time saved by typing `--resend` over
> `--subject-prefix="RESEND PATCH"` warrants the extra implementation,
> documentation, and testing baggage. Likewise, I don't see the value in
> `--label=WIP` (or `--rfc=WIP` or whatever) over the existing more
> general `--subject-prefix`.

I am not interested in adding unbounded number of --wip and the like
at all, but the value you seem to be missing of the separate "--rfc"
is that there are folks who configure something other than "PATCH"
to "format.subjectPrefix".  They do not want to keep typing
--subject-prefix="PATCH net-next" on the command line, so they use
the configuration variable, which is "set it once and forget".  The
stress is on the fact that they can forget about it.

If they are told to say --subject-prefix="RFC PATCH net-next" when
they want to send an RFC patch as one-shot basis, they would not be
happy.  That is where the value of a command line "--rfc" for a
particular invocation is---they don't have to remember or care that
their normal subject prefix is "PATCH net-next", which is required
if you forced them to use --subject-prefix.
