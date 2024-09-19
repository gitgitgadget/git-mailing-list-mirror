Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D79C22EEF
	for <git@vger.kernel.org>; Thu, 19 Sep 2024 19:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726772963; cv=none; b=EDJmcx0VHdQFQMRXQM6qKATQbls0gytBPsG88lNA5WFCiaf/wGkK6QznpGCLe2OmDALAQVIP6VGFmxQ+CEI7FaQcC9ub1QW50L3B3SXeSOiIcgUQ6thDABOzHLsYGr4sfzcdbBy1GrF1y2YRxf8d/tpzIKgXGnk1xRmVxiUfBiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726772963; c=relaxed/simple;
	bh=viX2qjvT70lD92Og10zNDFTOTNvAan1gOnh9IyX8aKc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KXm6FTkpgnp2+XCxgY87i2LHJoqDKgah9bgxkKa2D7UvpFRiwRi5qoAvsQlIyIUjxmwDgEWPtAcdES/YDaW8MQIKJatfSHIyuGUXm/NEBkeh1D2W8UA2LXdBqxtLnKJlSxzR/CH5NPfMYdXqOJA6sAop8MEUoH0rrf8Emi3ommQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=wmkJQbtU; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="wmkJQbtU"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id DB9D22A85E;
	Thu, 19 Sep 2024 15:09:20 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=viX2qjvT70lD
	92Og10zNDFTOTNvAan1gOnh9IyX8aKc=; b=wmkJQbtU7tohDxgpE9lrzbsk2JGX
	LJDRt0mKWCBYIG+8jokE4gOdcfghMTGPsvAAYVT5MBG+Zt9D/W9+wkDGl3pDfV3X
	U4s/4c2RJBBUBSI6QK6b/Aiyv9Vhe/SA7K0rCnbrxS0XxswQ5jRAhPPr7Kcopq0o
	zJ5nKcOBGVBkLKQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D35D02A85D;
	Thu, 19 Sep 2024 15:09:20 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4C2AD2A85C;
	Thu, 19 Sep 2024 15:09:20 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Matt Liberty <mliberty@precisioninno.com>
Cc: phillip.wood@dunelm.org.uk,  git@vger.kernel.org
Subject: Re: fatal from submodule status --recursive when used with grep -q
In-Reply-To: <CAKDm0rO6H4RTa5EXMrNvSy2swVegHveasY1koZXF5V7HvZzK0Q@mail.gmail.com>
	(Matt Liberty's message of "Thu, 19 Sep 2024 08:17:17 -0700")
References: <CAKDm0rNaHbzoiPg=DeuCoxzooNAsxw2BJfc0wg7fC_-=o9uJ7w@mail.gmail.com>
	<7b4ce2fc-3763-4881-8459-e0c1f2cbc69d@gmail.com>
	<CAKDm0rMsXUpFSWRWkW0J0FUpEbot6wQqdzYTT5CLZ=3TGbV-OA@mail.gmail.com>
	<467f6fb4-5f83-416b-bc09-572a82f210ea@gmail.com>
	<CAKDm0rO6H4RTa5EXMrNvSy2swVegHveasY1koZXF5V7HvZzK0Q@mail.gmail.com>
Date: Thu, 19 Sep 2024 12:09:19 -0700
Message-ID: <xmqqsetv795s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 AC95D912-76BA-11EF-B911-9B0F950A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

Matt Liberty <mliberty@precisioninno.com> writes:

[administrivia: you are not supposed to top-post on this list]

> On Thu, Sep 19, 2024 at 7:22=E2=80=AFAM <phillip.wood123@gmail.com> wro=
te:
>>
>> On 18/09/2024 15:28, Matt Liberty wrote:
>> > I'm not trying to capture the exit status of git but of grep.  Compa=
re
>> > it to "yes|grep -q y" which doesn't generate any error even though y=
es
>> > generates endless output.
>>
>> Sorry, I'd misunderstood your original message. So the problem is that
>> you want "git submodule status" to be quiet (i.e. not print an error
>> message) when it dies of SIGPIPE?
>
> Yes and also to have a 0 exit code.  No error occurred from my perspect=
ive.

I am sympathetic to the line of reasoning, but I wouldn't go that
far.

Running "yes | less" and killing it with 'q' saying "ok I've seen
enough", and running "yes" and killing it with '^C' saying "ok I've
seen enough" are pretty much the same from the end-user perspective.
You told the command to go away, and the command complied.  But I
haven't seen anybody complaining if they see a "Killed" message or
"echo $?" immediately after it says 130 for the latter.

