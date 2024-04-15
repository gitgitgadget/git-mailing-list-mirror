Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A1641C66
	for <git@vger.kernel.org>; Mon, 15 Apr 2024 18:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713206315; cv=none; b=l+jR4K2UG2ugk9x/aUoH9KUx9f7vcYxYWrNtHeglDbZBz9hlFEn6vASPpydR+7FLTgOOxl5b/vRI6g9LjrRSnp11nYgyWBA/fCvNsdFsopBb9yR4pERrUaMcNVunedryDnve45re321ojb94NtRzSUUt0rSFYDlgmccKpHC++90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713206315; c=relaxed/simple;
	bh=0ffKk+Xx2KkoUlUgUalq6OgoUJmxwESUtY1jP8L7DuY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Mka+4sD2HvFc4ZMFQlzUwLBm+74n/uiqMXiS7SURI2A0D2RsFdprQJUjwRbmx3FN1zjT+JbGa/XF6cH9ofeyUJafLXMulg/4i8dGs8/UZCOM4KBOO1rbDKB1k9a7rijt1pE1td3Mhtg7M3yaNgQdILGdojxkaA07+h/kMjTgckQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=UfG+2IZD; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="UfG+2IZD"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 5BCCA32BE1;
	Mon, 15 Apr 2024 14:38:33 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=0ffKk+Xx2Kko
	UlUgUalq6OgoUJmxwESUtY1jP8L7DuY=; b=UfG+2IZDEmq5rNvpYD0voQExFz7g
	cBVASfL74k9ezuiGlu806HZYBRf8OkC9BuOdFkQnEkF+PsH9I6FE6ZyxOd57Y1sk
	sfxvzL2kT7Pm9R5DJUKI3ZUEeOwYxZMVgmiFAZQHc7+Meds98xsWErUK+3lc9CEp
	jzyuUNOtYwlOPjc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 52C1F32BE0;
	Mon, 15 Apr 2024 14:38:33 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 5BA4E32BDF;
	Mon, 15 Apr 2024 14:38:30 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,  Git List
 <git@vger.kernel.org>,  Jeff King
 <peff@peff.net>
Subject: Re: [PATCH] imap-send: increase command size limit
In-Reply-To: <ZhwV6CmcC8zeSJ-7@tapette.crustytoothpaste.net> (brian
	m. carlson's message of "Sun, 14 Apr 2024 17:44:08 +0000")
References: <7026075c-db4e-4d43-bbd1-d2edb52da9b7@web.de>
	<ZhwV6CmcC8zeSJ-7@tapette.crustytoothpaste.net>
Date: Mon, 15 Apr 2024 11:38:28 -0700
Message-ID: <xmqqil0impy3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 5B151334-FB57-11EE-A9FB-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

>>  ...
>> Suggested-by: Jeff King <peff@peff.net>
>> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
>> ---
>> This time I compiled with NO_CURL=3D1 and NO_APPLE_COMMON_CRYPTO=3D1 a=
nd
>> verified with a silly printf that the changed code was actually used
>> and wrote the present message to an IMAP folder whose name is 1006
>> characters log, which required a 1026 bytes long APPEND command.  Yay,
>> freedom!
>
> I'm curious, is there a particular problem that you (or someone else)
> ran into that caused you to make this change?  I agree it seems prudent
> in general, but if there's a particular real-world broken case that thi=
s
> hits (e.g., mailbox names in a given language), I think the commit
> message would be a great place to mention this real-world impact, which
> would lend support to your argument that this is a valuable change to
> make.

I personally am not curious about real-world problem in this case,
but I won't stop you asking ;-)

I view this more about code simplification.  We no longer need a
custom nfvasprintf() helper nobody else cares about, leaving the
resulting code easier to read.

Will queue but will wait for a day or two to see if Ren=C3=A9 wants to
add clarification to the proposed commit log message before merging
it to 'next'.

Thanks, both.
