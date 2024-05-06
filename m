Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB6415B54C
	for <git@vger.kernel.org>; Mon,  6 May 2024 21:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715029872; cv=none; b=WGFT9xfOuqzk4DzaVgovW2pO9d5nDVhPBCqM600xjDrY4uKVPHZAr1efBomN0+FEXk6hwVeDMoSxLkHyqfmfRwe6wM8rrc/cvH3BeztxgSWmmlbimOVOSHhMGXvlgBrgSSn8vVgyl5QLMp+aiPKrLTKnyistp8g6wwtS1uOWU8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715029872; c=relaxed/simple;
	bh=ZClk1zTAUpaaKHYDoMzql36O9C++GVYyb2Qan2YmjYY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aGU84xSGUAn+I8PmqzgKdLUlDzVvkrpFyiowFNRnJsLeRZO1Hfz1o9q8MZvA3oYt8yr+vX+liM1UhnLI0cZo0zSxs7/I3Fq5eWKs9rIRRnn7JdVaWHM5snh+lhlgJFnddIb0vQkDou8TqDSQEkJwHKygQYehwfECxq+hNlBRhT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=rFMi3n8M; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="rFMi3n8M"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 42D1B183B4;
	Mon,  6 May 2024 17:11:09 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=ZClk1zTAUpaaKHYDoMzql36O9C++GVYyb2Qan2
	YmjYY=; b=rFMi3n8MDkK9SLffcoWoGWYQ7pzVNpn7Z0ss/wnbbooYON0Z1nBmZj
	K7WVHUDEAksvxk6hFVrU6GhSCIkF0X/fAnaXwHq0KGxXShGRI80KRUl1+TNATBV0
	qAdWq4o1U7l0uLHjlDRzSEHIE4NcwZ9sOJOTRq7bFnxfQouBI8kWw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 3AECB183B3;
	Mon,  6 May 2024 17:11:09 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9F08D183B2;
	Mon,  6 May 2024 17:11:08 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Josh Steadmon <steadmon@google.com>
Cc: git@vger.kernel.org,  peff@peff.net
Subject: Re: [PATCH v6 0/7] test-tool: add unit test suite runner
In-Reply-To: <cover.1715024899.git.steadmon@google.com> (Josh Steadmon's
	message of "Mon, 6 May 2024 12:57:30 -0700")
References: <cover.1705443632.git.steadmon@google.com>
	<cover.1715024899.git.steadmon@google.com>
Date: Mon, 06 May 2024 14:11:07 -0700
Message-ID: <xmqqedaey7bo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 28841A4A-0BED-11EF-9DE8-25B3960A682E-77302942!pb-smtp2.pobox.com

Josh Steadmon <steadmon@google.com> writes:

> For various reasons (see discussion at [1]) we would like an alternative
> to `prove` for running test suites (including the unit tests) on
> Windows.

As I got tired of keeping that "Windows" bit outside this series as
a separate and dependent topic, let me see if I can get rid of
js/cmake-with-test-tool topic by queuing it at the tip of these 7
patches, making it an 8-patch series.  It looks like these 7 patches
are pretty well done, so let's plan to merge them together down to
'next' soonish.

Thanks.
