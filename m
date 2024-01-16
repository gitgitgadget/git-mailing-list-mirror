Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705241CD01
	for <git@vger.kernel.org>; Tue, 16 Jan 2024 17:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705427625; cv=none; b=uRjiLtOI8i1ovXzNkp68OJijkHai0j8qh4xECHgKZd16xAIrZ2c+DKLjTo4FbcsvOUftLE1waKfcYxtyeXOxLEmuMIzzFXJUvPaGmmgP5vL+PqlBHHz+6GApU8F6tJVF2xbUVc+vTBfmbSXmpNvkLViq6o3IeSNDsO20jl8E3Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705427625; c=relaxed/simple;
	bh=i7yI9X/OQ8Q1siUQJewYBVECjW7XzN556lIs/HP+okQ=;
	h=Received:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 In-Reply-To:References:Date:Message-ID:User-Agent:MIME-Version:
	 Content-Type:X-Pobox-Relay-ID; b=K9sBiF0/S96MuGrjAz6gNDWcluFkN8oOIWklV1RILLodl+hbTGJY2jat3bJFhsEpHvcN/LNSq6PvvVBPILQ5v9zhWJyyDfx2R7d78E4jHdBoxYWO/v7bwwR+hbKt6LA6KGEXT3et0MtUNIGm7BgrOon7fkC4eoqPJJydO7t7mf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=VWXSj1da; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="VWXSj1da"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id DF70918792;
	Tue, 16 Jan 2024 12:53:43 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=i7yI9X/OQ8Q1siUQJewYBVECjW7XzN556lIs/H
	P+okQ=; b=VWXSj1daOZKufWzSMaIgNlF5pi9WTkEcNiwO04629C7AP1qvN/J5lL
	ZH235oABymaoVtYC/+YY0ZgpXZ95RTOM15dhMTlD6kexte+Vc/nlUSRde9s7isda
	90Ew3KwRIzaW0pkAQ2wszObHH4yL54X7MiCxsCVZxe7h5UJnN1KD4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id D7CD918791;
	Tue, 16 Jan 2024 12:53:43 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 85A571878F;
	Tue, 16 Jan 2024 12:53:40 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Eric Sunshine
 <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 0/6] worktree: initialize refdb via ref backends
In-Reply-To: <CAOLa=ZS3aVP=h9iC2i_4Hbx_-OSdqJ8S6xYT65CPyXd+9_=4Nw@mail.gmail.com>
	(Karthik Nayak's message of "Tue, 16 Jan 2024 04:17:40 -0500")
References: <cover.1703754513.git.ps@pks.im> <cover.1704705733.git.ps@pks.im>
	<CAOLa=ZS3aVP=h9iC2i_4Hbx_-OSdqJ8S6xYT65CPyXd+9_=4Nw@mail.gmail.com>
Date: Tue, 16 Jan 2024 09:53:38 -0800
Message-ID: <xmqqa5p517x9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 2EA482C2-B498-11EE-B33D-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Karthik Nayak <karthik.188@gmail.com> writes:

> Patrick Steinhardt <ps@pks.im> writes:
>
>> Hi,
>>
>> this is the second version of my patch series that refactors the
>> initialization of worktree refdbs to use the refs API.
>>
>> Changes compared to v1:
>>
>>   - Improved commit messages.
>>
>>   - This series is now based on `ps/refstorage-extension`, 1b2234079b
>>     (t9500: write "extensions.refstorage" into config, 2023-12-29).
>>     While there is no functional dependency between those series,
>>     merging both topics causes a merge conflict.
>>
>
> This looks good to me now. Thanks Patrick!

Thanks, both.
