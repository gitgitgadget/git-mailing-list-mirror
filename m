Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9117260890
	for <git@vger.kernel.org>; Tue, 13 Feb 2024 19:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707854232; cv=none; b=eetNGTMi/vC8sou9KgJMKMSQj1keW/cr617m/eGPwICVi+bNEdfghNJS5XE+i1HfbqxqkiQ46+r0vQ6cvtPjUm1MKymcwiUz+DDqXNaHDATJMQ38/tlzaQleM8A728wntqA52xAVoHR23NindGqX/ROr7OujU2CLm/XCZZjBUCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707854232; c=relaxed/simple;
	bh=bUNQ2jI4ipkF5WcYLO5v4SOALhSi6jZA+26UgrFSZEg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=T0od8xxHBqwE4Z3bq4KE44evmnb8tmLn89uSJ2L4jjUPJuLTkR/Ib+PcG9djCZfhVlpZnDuXncmswpvH1dNyZYeS9+KQnk1alW2tZu5LCGXRdvk4CQl39Pqsy6iZSVk9ToQ0ETNaW4DmZxIn7HoXD0JfcgMGLcHcXfl3yzhKq4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=MjMV1dPb; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="MjMV1dPb"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 0C3031C8D32;
	Tue, 13 Feb 2024 14:57:10 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=bUNQ2jI4ipkF5WcYLO5v4SOALhSi6jZA+26Ugr
	FSZEg=; b=MjMV1dPbzMZJ2hsaUnCc1tIAkdOam4fQnNvlD2F3CeiXU7KXNeJDBF
	xXxB30HB/H13dtfuSZ+osYZMAx8Gc6KClXfUoqkCpZzINUjUk917htr0kZxa1Dkl
	ZlJld0imDCTgG+LIaWEcV0wPyVfBJBzStAM61v8BgC4BxKIWfQ0JQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E92CC1C8D31;
	Tue, 13 Feb 2024 14:57:09 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 493B41C8D30;
	Tue, 13 Feb 2024 14:57:09 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Linus Arver <linusa@google.com>
Cc: Christian Couder <christian.couder@gmail.com>,  Linus Arver via
 GitGitGadget <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Christian
 Couder <chriscool@tuxfamily.org>,  Emily Shaffer <nasamuffin@google.com>,
  Josh Steadmon <steadmon@google.com>,  "Randall S. Becker"
 <rsbecker@nexbridge.com>
Subject: Re: [PATCH v4 00/28] Enrich Trailer API
In-Reply-To: <owlywmr89ms9.fsf@fine.c.googlers.com> (Linus Arver's message of
	"Tue, 13 Feb 2024 11:39:18 -0800")
References: <pull.1632.v3.git.1706664144.gitgitgadget@gmail.com>
	<pull.1632.v4.git.1707196348.gitgitgadget@gmail.com>
	<CAP8UFD3qLGua5PTA+i29N+yJH8iKVBPwUn=S606B2E+s959JFQ@mail.gmail.com>
	<owlywmr89ms9.fsf@fine.c.googlers.com>
Date: Tue, 13 Feb 2024 11:57:07 -0800
Message-ID: <xmqq5xys5e98.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 122BA4FE-CAAA-11EE-A386-25B3960A682E-77302942!pb-smtp2.pobox.com

Linus Arver <linusa@google.com> writes:

> This sounds fine to me. IIRC this means for the 2nd, 3rd+ series I have
> to remember to say "this series builds on top of the other topic
> branches '...'" in the cover letter. Now that I've written this out I
> will hopefully not forget to do this...
>
> Or, I suppose I could just introduce the 1st sub-series, wait for that
> to get queued to next, then (re)introduce the 2nd sub-series, etc, in
> order. Hmm. I think this will be simpler.

FWIW, which was how the recent flurry of topics related to the
reftable backend were done by Patrick, which was quite nice.  People
certainly need the feel of larger picture to get motivated to review
an earlier part of the series, but now that they saw the projected
end-game, splitting these into 4 series, each with materials in 7 or
so patches in v4, and presenting in not-so-quick succession one by
one, would make it less distracting and less daunting.

>> I am a bit sad that this series doesn't introduce unit tests using the
>> new test framework in C yet. I understand that this series is mostly a
>> big refactoring and maybe it's better to introduce unit tests only
>> when the refactoring is finished though.
>
> This was my original goal as well, and still is.

That's OK.  If v4 were 40-patch series instead of 28, I am sure you
would have had the unit-test part near the end.  So a bite sized
series of serieses may not show the unit-tests while the earlier
batches are still cooking, but as long as we all are aiming for that
same goal, we are fine.  Let's help ourselves get there soon by
reviewing each other's patches ;-).

Thanks, both.
