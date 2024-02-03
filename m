Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D85101C1
	for <git@vger.kernel.org>; Sat,  3 Feb 2024 04:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706935397; cv=none; b=pAAgZAj4j+2mOCiGjILX/rbZSrZ63jjKsb9GTnyZc3trdZOjHnSl1n4kypk48Ga5TBtfHiNOYzLn8Vz29iDP9keekyUD49XzoJSJ2bNtTnGADRUoX6oF9XLhsjvwTCUtEtLCZ1H7qc8k7S7syKN3rRR3EmindzW3tFQgONcBEPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706935397; c=relaxed/simple;
	bh=cfyzWbvOJw6sHtfD3OspUDIYqlpHDnqKik/YVf3SDf8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=N0v2zEZhaY77XDLxczaeRqPAZS4/zpwU5irt9LgifJZ/OVhL4U6DL1g0tHmvAa3VpbxoyMLTtA0hg5D/pb70jhXDQYxex5NJeqAbrly5PKPReS05Px4VeSXxNgyIwkDu9DY89g198sK4xa5KxvJh7zzfdwpLK9ay3rXEAZJqrAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=pX7Rq1Ls; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="pX7Rq1Ls"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E0F321CBE6A;
	Fri,  2 Feb 2024 23:43:08 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=cfyzWbvOJw6sHtfD3OspUDIYqlpHDnqKik/YVf
	3SDf8=; b=pX7Rq1LsRuSJBQRjDTsWGFbYynGNfAOp1Sqkqi/nYZT6XDyku014V0
	XmWa79tflrCZZuMb8C8EHfYstb/x3XdhK8LhPF7/x2nckF6frIig7rwae0vAPyxO
	pJC2xLEktRJe6L9hRZ1HZfCHLXzVsz0ziG3eDoSw3GDiaxhn1AWD8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D85171CBE68;
	Fri,  2 Feb 2024 23:43:08 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 425B11CBE65;
	Fri,  2 Feb 2024 23:43:08 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Linus Arver <linusa@google.com>
Cc: Linus Arver via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Christian Couder <chriscool@tuxfamily.org>,  Emily
 Shaffer <nasamuffin@google.com>,  Josh Steadmon <steadmon@google.com>,
  "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: Re: [PATCH v3 05/10] trailer: make trailer_info struct private
In-Reply-To: <owlycyte1hhj.fsf@fine.c.googlers.com> (Linus Arver's message of
	"Fri, 02 Feb 2024 17:09:12 -0800")
References: <pull.1632.v2.git.1706308737.gitgitgadget@gmail.com>
	<pull.1632.v3.git.1706664144.gitgitgadget@gmail.com>
	<c19c1dcc592186d8da2857692f4ebbfe35adfac0.1706664145.git.gitgitgadget@gmail.com>
	<xmqqplxgyq7f.fsf@gitster.g> <owlycyte1hhj.fsf@fine.c.googlers.com>
Date: Fri, 02 Feb 2024 20:43:06 -0800
Message-ID: <xmqq4jeqtaxx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 BA3DD2FC-C24E-11EE-83AA-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Linus Arver <linusa@google.com> writes:

>>> +size_t trailer_block_start(struct trailer_info *info);
>>> +size_t trailer_block_end(struct trailer_info *info);
>>> +int blank_line_before_trailer_block(struct trailer_info *info);
>>
>> And we need new accessors, which is a good change regardless of the
>> answer to the "do we really want an extra pointer dereference?
>> Shouldn't the existing 'private' and 'internal' label we see below
>> sufficient?" question.
>
> I am very surprised with your response here, because I was expecting the
> complete opposite reaction from reviewers --- something like
>
>     Hmph, we have to write accessor functions now when before we could
>     just reach inside the struct directly? Isn't this just adding
>     needless verbosity?
>
> (perhaps with more dissatisfaction). Something tells me you meant "bad
> change" but accidentally wrote "good change". Am I correct?

I often make typoes and screw up my double negations, but not this
time.  While I still suspect that the extra secrecy afforded by
using a pointer to an opaque structure is something unnecessary
between friends, as coding convention, it would be a good change to
introduce accessors and have them used by the API users, i.e. code
outside the API implementation.

You can still "git grep" for references to the ".trailer_private"
(or whatever the "private" members are named by convention) member
outside the trailer "client code" to see if there are people who are
too intimate than they should be that way, as they should all be
using the published accessors.

