Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2B01CAAC
	for <git@vger.kernel.org>; Sat,  6 Apr 2024 05:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712379833; cv=none; b=NL8BIiV4tpdCChpy5lZZYJcZDcEnn/MSaPzAoEc21Qc2gzCpFdJs6D5+lCHlcAYZGpTTgVFsQGLU+5k6DPot8Y0m+7jSSDtdXIvf+RAETjigdmgTcaSJD4UqI/GUP1GrfETkHrSNH7XINlnomll3scJzlomTyQM3WIC8g4UzMs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712379833; c=relaxed/simple;
	bh=z2lAyMt/8sWbizZazqxFQa+EZb+rccC1KznH8q2635w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=m3vvHQH4Lbs1NHFLNRnRuKvBkrwQ493Z80Aq6+k7m+AI8NTMs3mj5Aj3t8EDT0++spC1zlpkL9agGj/pGEmizarplF3KtqGjnvQIZ0nDsiJpiDvTqCfb2IV61rMinGMFSRFi/NT4PgM+RnJdWkyUVdMXVNCcnf74g/aUYryz06k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=IaWNwaW2; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="IaWNwaW2"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 7EA80296B3;
	Sat,  6 Apr 2024 01:03:51 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=z2lAyMt/8sWbizZazqxFQa+EZb+rccC1KznH8q
	2635w=; b=IaWNwaW2CQChQDyIM75F0ufMdJs1Czl0x73OK22XJzF8RoWC+yrDfP
	z0xTn/xtPWwuImGUNX/C51ff1Y9kprae3OCc0p50QhLE7rrjG+dMI55Lk7Dyvo4C
	XI+xK7YJSy70Tajun0Vw/Gy2Be/7gqyfwoLFYsfJjhPhDD7ASLrLM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 7707C296B2;
	Sat,  6 Apr 2024 01:03:51 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 00BDB296B1;
	Sat,  6 Apr 2024 01:03:47 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Dragan Simic <dsimic@manjaro.org>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Apr 2024, #03; Fri, 5)
In-Reply-To: <36f7e1b7122b0bdeb2e8b70f69abd331@manjaro.org> (Dragan Simic's
	message of "Sat, 06 Apr 2024 03:11:14 +0200")
References: <xmqqy19rtygr.fsf@gitster.g>
	<36f7e1b7122b0bdeb2e8b70f69abd331@manjaro.org>
Date: Fri, 05 Apr 2024 22:03:46 -0700
Message-ID: <xmqqr0fjnkul.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 0D3366C4-F3D3-11EE-AF1D-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Dragan Simic <dsimic@manjaro.org> writes:

>> * ds/fetch-config-parse-microfix (2024-04-05) 1 commit
>>  - fetch: return when parsing submodule.recurse
>>  A config parser callback function fell through instead of returning
>>  after recognising and processing a variable, wasting cycles, which
>>  has been corrected.
>>  Will merge to 'next'.
>>  source: <pull.1709.git.1712285542303.gitgitgadget@gmail.com>
>
> Isn't this an example of a prefix collision, i.e. "ds/" points
> to two different contributors?

"ls .git/objects/" would tell you that no object is important enough
to squat on a single "prefix" and exclude others, and two objects in
00/ hierarchy are by no means closer together than an object in 00/
hierarchy and another object in 01/ hiearchy.  The idea to use the
fan-out in the ref namespace is pretty much the same.



