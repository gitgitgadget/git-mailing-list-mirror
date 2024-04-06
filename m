Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888E9A38
	for <git@vger.kernel.org>; Sat,  6 Apr 2024 01:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712365951; cv=none; b=ogCTvIFvOmnaLTh60zFHXjJ0fhuel2Kt6KdByA4y3E7M+3wwNXKciFPn19+PimGtA/PquTUm5wcBodFHyQqnD9zn0zfvDMOHO2MRtPQUT0solx+ovUvfk+UWL1CY/vj+/qXdAOwa+P+ysNRLHtlHIKCKqJWyorHKp3a/C4CBT/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712365951; c=relaxed/simple;
	bh=RuQ0JmYIJnHIVBeRggdeUcwtYyiVdnrQ+kxyJ/K4Kh8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gJctKGKGPUVOHpVVaVKSFhOwp81dRlIxWrvMWjHMnoyOJtg+NNfmaTzSWkgb7R0ebo8reRl0V6o2aqN516h4jgt8g6jOEMz4wDENI7HAVuFO6N904YwXIPw7CfyiFtKG+U4j28iLVbWOBMjSYzbsi4NWnAI11XzJL/DpkIRwLJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=VGkku4dL; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="VGkku4dL"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2B58E1F2E96;
	Fri,  5 Apr 2024 21:12:29 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=RuQ0JmYIJnHIVBeRggdeUcwtYyiVdnrQ+kxyJ/
	K4Kh8=; b=VGkku4dLf8wuOHe0YGLBXLlBFx04p8+a1Og/GUYtbHnIvr1147X4AE
	UPdXqSdTprQBNmPRW4n1tZwEiC4RcIcLzlQUplJa/nKDh+K1ygEwHc4Mt4ZzY9fT
	m77zDYRCeqsBczlATOs7hCXUs1aSV3Z7g1KDvSBUsE88liZ5nKTVA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 237AB1F2E95;
	Fri,  5 Apr 2024 21:12:29 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8679D1F2E94;
	Fri,  5 Apr 2024 21:12:28 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Dragan Simic <dsimic@manjaro.org>
Cc: git@vger.kernel.org,  code@khaugsbakk.name
Subject: Re: [PATCH v3] send-email: make it easy to discern the messages for
 each patch
In-Reply-To: <e3212c0a4ad331685c68c13afcdbced20982ab32.1712364420.git.dsimic@manjaro.org>
	(Dragan Simic's message of "Sat, 6 Apr 2024 02:50:18 +0200")
References: <e3212c0a4ad331685c68c13afcdbced20982ab32.1712364420.git.dsimic@manjaro.org>
Date: Fri, 05 Apr 2024 18:12:27 -0700
Message-ID: <xmqq8r1rs39g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 BC670F22-F3B2-11EE-A3E9-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Dragan Simic <dsimic@manjaro.org> writes:

> As the final touch, make the above-mentioned prompt emitted without using
> underlined text, which also applies to any other produced prompts, which made
> them somewhat hard on the eyes, especially because the prompt's tailing space
> character was also underlined.

Don't do this, or at least don't do this in the same patch.

Another lesson to learn: resist temptation to grow the scope of the
topic.  Especially with ascetics, your preference may not be shared
by other users, which would easily hold up the main part of the
patch you wanted to improve and the reviewers have already spent
effort on to polish to be ready.  Also are you sure in everybody's
environment that ->ornaments() call is available and effective?
That is another thing that can hold up the rest of this change.
Don't waste your effort so far and build it as a follow-up patch
and do so after the dust settles.

Thanks.


