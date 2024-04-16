Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF1512B154
	for <git@vger.kernel.org>; Tue, 16 Apr 2024 15:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713280980; cv=none; b=Y9gBfhOy1v8hnkHDtgyjMEDAh+j3A0XNLSkFaiMs7gKP/diXa5kulgQqhI1wdGt23iQrnUSmGBH2eF75HCQuMEFtymUoG9GcmzosvWL8iZfC9esHx/pO73WMcYu7zU6sCb/waih3FDZi/sBBBDyfGKT4yefhx2FHOggTYFC/5Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713280980; c=relaxed/simple;
	bh=zJt4jNTHMYlGgnYdcn0KjZRb7AkwXbhedW0uYKj0OoA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=r6ovf6H/ND8omVVGw5mUvDA9NpLVflYpLgBnRBWn9B7SOaMMlo7TfjNwQCGNw/99urI/mbCwFJA1KanI6+yrOyJQF8wkQof24vD4AzPMtaIm6s3dQiePqr0E+XjRvR1Sv25xrTSM3HilTa/CwVDeYe/qAMf3htzxhocgvdyV+a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=cIEy1aAH; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="cIEy1aAH"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 64D4B1823B;
	Tue, 16 Apr 2024 11:22:58 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=zJt4jNTHMYlGgnYdcn0KjZRb7AkwXbhedW0uYK
	j0OoA=; b=cIEy1aAHN+KzvWiWruNv93tanBzlNonGsd5d52P58TctINCIjAI7UA
	02tp/4EjOPOdzxaLjuU4vnSt9OgqcnD9rRH2itwcUcrfsrTFUfK/nDxn1NepA+el
	hUBdBhvuq0Y5EEuie63Hzkf9iX/mXgYalfIywD8yhpyFEXO8UrfHU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 5E4AA1823A;
	Tue, 16 Apr 2024 11:22:58 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B961B18237;
	Tue, 16 Apr 2024 11:22:53 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>,  Git List
 <git@vger.kernel.org>,
  Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH] add-patch: response to invalid option
In-Reply-To: <64d4ba8e-0dfe-407c-9b32-d02f1ce40393@gmail.com> (Phillip Wood's
	message of "Tue, 16 Apr 2024 14:56:37 +0100")
References: <4e2bc660-ee33-4641-aca5-783d0cefcd23@gmail.com>
	<xmqq5xwhhacm.fsf@gitster.g>
	<64d4ba8e-0dfe-407c-9b32-d02f1ce40393@gmail.com>
Date: Tue, 16 Apr 2024 08:22:52 -0700
Message-ID: <xmqqr0f5fi2b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 31ED487E-FC05-11EE-99F2-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Phillip Wood <phillip.wood123@gmail.com> writes:

>> That flow of thought makes sort-of sense, if the choices that are
>> offered are too numerous (say, around a dozen or more), but with the
>> current command set, I am not sure if this change is an improvement
>> (note: I did not say "I do not think that"---I simply am not sure).
>
> The complete list of help is 15 lines long (we don't always print
> everything but if you're in the middle of staging several hunks from
> the same file we do)

Ah, OK.  Even though I was the one who stole this feature from
elsewhere, I forgot that we had that many commands, and it makes the
decision a lot simpler ;-)

>   y - stage this hunk
>   n - do not stage this hunk
>   q - quit; do not stage this hunk or any of the remaining ones
>   a - stage this hunk and all later hunks in the file
>   d - do not stage this hunk or any of the later hunks in the file
>   j - leave this hunk undecided, see next undecided hunk
>   J - leave this hunk undecided, see next hunk
>   k - leave this hunk undecided, see previous undecided hunk
>   K - leave this hunk undecided, see previous hunk
>   g - select a hunk to go to
>   / - search for a hunk matching the given regex
>   s - split the current hunk into smaller hunks
>   e - manually edit the current hunk
>   p - print the current hunk
>   ? - print help
>
> I find it long enough to be annoying as it means there is a
> significant distance between the prompt and the hunk text.

Yes, I now agree.

So the log message may want a bit of rewrite in the title and the
introductory part, with a clarification that '?' is what we already
had and not what this adds (from Patrick's comment), and there may
be other small improvements we want to see that I may have missed,
but other than these small-ish points, the basic direction of this
patch is good?

This is a tangent, but I think we _mostly_ take these commands case
insensitively (e.g., you can say 'Q' to quit the program, as well as
'q' that is listed above).  But 'k' and 'j' (there may be others)
act differently when given in the uppercase.  This would limit our
ability to later add capitalized variant of an already used lower
case letter without retraining users---should we find it disturbing,
or is "add -p" mostly done and we do not have to worry?

Thanks.
