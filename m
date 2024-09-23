Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630CB19E980
	for <git@vger.kernel.org>; Mon, 23 Sep 2024 17:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727112010; cv=none; b=ifXLs5b+m7bAXKpCFQzlCR3tJEJANgUmBxx6Rjxdsrfrl+6vRqERVmoqP0lowwD7/2HxpVgqezSFh2H6roXj2VvoyV0vi5ODvKiqPEwZLoV7y/irfQ1EJOkvl5eh4kPTcOQ2RgKWLJFbpIRnAC+Tu9ZvMQYJLZrbc78U5viDjqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727112010; c=relaxed/simple;
	bh=j1LcNhpEXnhJ56IO/cwTPrS5nAunbjNVz/AQqFcSONw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GKduI70G3VkSGJOI/4ynYI+QIBNUZOB0OgAxlMe/eWYki+3ouefclzjhoAqlexB3D2DOYsbs6BKYjrMkxwzHbxmTWjeN+zNcUsOhRcnt9nA0dZDuK6rG2vK7L56J8wwkFzSTzosRaelZG8LIQNfeToVz8f6Zk34z/XHgFfmKDK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=qn1Pqn6W; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="qn1Pqn6W"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B923527BB3;
	Mon, 23 Sep 2024 13:20:06 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=j1LcNhpEXnhJ56IO/cwTPrS5nAunbjNVz/AQqF
	cSONw=; b=qn1Pqn6W5f/LX7+teTvoiSJ5AGpK6iGR9GXROm8z24V1jobkh3R9R5
	3Hsz4DD64uVxR6pYdElcdIFs0+aW3gMndlK/EcHbJ24/XtsQouUaN0MyTJHikziO
	mJXJ34JRokBqgavvFDme+UYrIrgXFuFvR3SPjMjccog1S7d8SE8uw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id AE04A27BB2;
	Mon, 23 Sep 2024 13:20:06 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C124927BAD;
	Mon, 23 Sep 2024 13:20:04 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Sep 2024, #08; Fri, 20)
In-Reply-To: <34346998-deac-4e1f-9d5f-218f664e9e08@gmail.com> (Derrick
	Stolee's message of "Sun, 22 Sep 2024 21:31:58 -0400")
References: <xmqqed5ddexk.fsf@gitster.g>
	<34346998-deac-4e1f-9d5f-218f664e9e08@gmail.com>
Date: Mon, 23 Sep 2024 10:20:02 -0700
Message-ID: <xmqqcyku2sot.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 12DAFC76-79D0-11EF-96A5-9B0F950A682E-77302942!pb-smtp2.pobox.com

Derrick Stolee <stolee@gmail.com> writes:

> On 9/20/24 8:32 PM, Junio C Hamano wrote:
>
>> * ds/pack-name-hash-tweak (2024-09-19) 6 commits
>> ...
>>   Will merge to 'next'?
>>   source: <pull.1785.v2.git.1726692381.gitgitgadget@gmail.com>
>
> There was some speculation [1] that maybe this --full-name-hash option
> would be considered redundant or irrelevant when the --path-walk feature
> is submitted/reviewed/merged. I'm not sure that that is the case, but
> maybe we should leave this open a bit longer for folks to weigh in on
> it?

Let me drop the "Will merge" comment; let's see where the others
want it to go.

Thanks.

> [1]
> https://lore.kernel.org/git/81bc5d69-cf50-409d-ac64-5b9b3f722ace@app.fastmail.com/T/#me45c4fd489bae987785cddb9580339095095fa9e
