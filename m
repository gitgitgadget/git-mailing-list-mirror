Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3208B1E878
	for <git@vger.kernel.org>; Mon, 26 Feb 2024 22:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708988326; cv=none; b=EA3xGqe47Eu8E+HWRUsMmixNvZrl+XVRayz4yIebWPwbsWB1JVEXSCcNTMhOqUHH8Bfs2QP+2nz+NSLt3MgcTWyULJB3ifq0suTMKRN80OR+8m2K7+/+xjRsoqg2ywVraE+5/ud26cqZSmScTHBIgHrvC80GqavmzswUiTimkQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708988326; c=relaxed/simple;
	bh=2blFGWKzez/glmyl1BkaKgeekBvRKKKnENWHMbxKzfg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=t9BJVXXwGpfTWk3U/mRWsWODZnnmR+rAzlNeOHyH+35QWIov1YtdINgc2cN/0xNTelgEhKtJ9EpdsfjC2yFhMKE6OCBCrFaJ0LeAKPy6AkWTsDsLi7wTAYXNwrO7FgukKqb9vjxohS+WLIcqV0feSh4vnLCWG6XJp6PkFZ5Pyog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=JgG5lV8e; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="JgG5lV8e"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 84DE220177;
	Mon, 26 Feb 2024 17:58:44 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=2blFGWKzez/g
	lmyl1BkaKgeekBvRKKKnENWHMbxKzfg=; b=JgG5lV8eBNcoeWWzM2FXgB9dmm7o
	TTST2kBcn4OMDJ0CJz4o16vH8o+frR35PZPABnb8AzrF0qvYbstdPgwr2G/TaYHQ
	wH4y2Iic8oMi5BYjyHbLU4+hWMp0ILusqTrepLik3eBNQ5s+m8mEsMbGFN34fYTJ
	3ZpeRVeG6ADddog=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 7E6B020176;
	Mon, 26 Feb 2024 17:58:44 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D600620175;
	Mon, 26 Feb 2024 17:58:40 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: Eugenio Gigante <giganteeugenio2@gmail.com>,  git@vger.kernel.org,
  sunshine@sunshineco.com
Subject: Re: [GSoC][PATCH 1/1] add: use unsigned type for collection of bits
In-Reply-To: <CAP8UFD3qR8E0gvUQtzzkLPWv4Db45kFS4pEqHKQr5siciVJ-zQ@mail.gmail.com>
	(Christian Couder's message of "Mon, 26 Feb 2024 10:59:05 +0100")
References: <20240224112638.72257-1-giganteeugenio2@gmail.com>
	<20240224112638.72257-2-giganteeugenio2@gmail.com>
	<CAP8UFD3qR8E0gvUQtzzkLPWv4Db45kFS4pEqHKQr5siciVJ-zQ@mail.gmail.com>
Date: Mon, 26 Feb 2024 14:58:39 -0800
Message-ID: <xmqqsf1ekf34.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 956D289C-D4FA-11EE-8096-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

Christian Couder <christian.couder@gmail.com> writes:

> On Sat, Feb 24, 2024 at 12:28=E2=80=AFPM Eugenio Gigante
> <giganteeugenio2@gmail.com> wrote:
>>
>> The function 'refresh' in 'builtin/add.c' declares 'flags' as
>> signed, while the function 'refresh_index' defined in
>> 'read-cache-ll.h' expects an unsigned value.
>
> It's not clear from the patch that refresh() passes 'flags' as an
> argument to refresh_index(), so it might help reviewers a bit if you
> could tell that.

Perhaps.

>> Since in this case 'flags' represents a bag of bits, whose MSB is
>> not used in special ways, this commit changes the type of 'flags'
>> to unsigned.
>
> We prefer to use "let's change this and that" or just "change this and
> that" rather than "this commit changes this and that", see
> https://git-scm.com/docs/SubmittingPatches/#imperative-mood.

Very true.

> It might help if you could add a bit more explanation about why it's a
> good thing to use an unsigned variable instead of a signed one. For
> example you could say that it documents that we are not doing anything
> funny with the MSB.

But doesn't the proposed log message already say so?

In any case, it would very much help to fold long lines and have a
blank line in between paragraphs to make the log message more
readable.

Thanks, both.



>
>> Signed-off-by: Eugenio Gigante <giganteeugenio2@gmail.com>
>> ---
>>  builtin/add.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> The patch looks correct, thanks!
