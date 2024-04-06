Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476EC2137E
	for <git@vger.kernel.org>; Sat,  6 Apr 2024 16:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712422528; cv=none; b=hRwxu16LEerndoMSRLde/QFXwlxrCLSTbTUfvGalAWxs6MHEgJmWU2Fb7XPfKLyQYQGJJSKE98TisLWqUFj/kRN9TuJhPMF33pEFwXDlVtYvGSDhz+q7rTuFBGlDOlqeryomnVR1MvJfaMEvanFkP+jhfSyOHHqTvJZ6b+q7nsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712422528; c=relaxed/simple;
	bh=eBT4PGaucfY9mR8Voov9ef3LqbeDkxdhgDBe0iIJ53Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YQWEEQnu93tr2vOg/2VZvraxjGty19K2fdMk/GXStlvVeuRElhjvdx58rKIbmbwN6di7kI1wFxPbBmIuueFETyWGiM6wQsnmUQJYhm2rv6SLCeKbAYyz0KnwPtRVLIRzWeq9mN9RAxHd2n0hGpYebkk/FA8LAYa8FhT6sQhVWeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=u6+4Eppx; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="u6+4Eppx"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2336C1F81F3;
	Sat,  6 Apr 2024 12:55:26 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=eBT4PGaucfY9mR8Voov9ef3LqbeDkxdhgDBe0i
	IJ53Y=; b=u6+4EppxeL5sRS+aVUoE3afONAAQ2NtMas218rXawLCzDTDTmkP7lK
	jwZxCzO0wBpDG6vvUSABdpA87dExQcdUD2h300DO4H/8rTqo3qEg7FcaVka0VScF
	NGQVlsysu+VX9GCC13Eqf3Leh04FCQ8hhOTzOThUmnTzG6KPUe4T8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1B8711F81F2;
	Sat,  6 Apr 2024 12:55:26 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7E2781F81F1;
	Sat,  6 Apr 2024 12:55:25 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Dragan Simic <dsimic@manjaro.org>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Apr 2024, #03; Fri, 5)
In-Reply-To: <de15fc1ca9b5abe694196f4d468d4226@manjaro.org> (Dragan Simic's
	message of "Sat, 06 Apr 2024 10:37:09 +0200")
References: <xmqqy19rtygr.fsf@gitster.g>
	<36f7e1b7122b0bdeb2e8b70f69abd331@manjaro.org>
	<xmqqr0fjnkul.fsf@gitster.g>
	<de15fc1ca9b5abe694196f4d468d4226@manjaro.org>
Date: Sat, 06 Apr 2024 09:55:24 -0700
Message-ID: <xmqqmsq6l9c3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 76E6F1F4-F436-11EE-AB0E-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Dragan Simic <dsimic@manjaro.org> writes:

> Ah, sorry, I wasn't precise enough, please let me explain.  When
> I wrote "prefix", I had its use by humans in mind, e.g. for searching
> the "what's cooking" emails by hand, to see the statuses of one's
> patches.  I mean, that's what I do -- by searching for "ds/", I can
> easily find the statuses of my patches in "what's cooking" emails.
> Does that make sense?

Yes, and the fan-out reduces the search space by a lot, but like the
birthday paradox, given sufficiently large number of people, the
chances of two people falling into the same shard increases.  It of
course does not help that the first and the last capital letters in
people's names are not evenly distributed ;-).
