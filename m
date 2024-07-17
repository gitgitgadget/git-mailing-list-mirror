Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C362EAE5
	for <git@vger.kernel.org>; Wed, 17 Jul 2024 14:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721227741; cv=none; b=tpYaB3FX3qzydFqoZAxnJvE0Bg7wvDGCEhU3UvOm3r7jeFMPpl20LT/bwqWvJliclPC5JhWoQwnhGk4DCQRZaZoPv9FBa2BAkc86VJyy+FSj+3KBbbiI7X4HNcgMNTMJMaXs1vE2EY76bqxI41dIM/0AoRAcE/kGDOJSpRrFXSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721227741; c=relaxed/simple;
	bh=Z2oNQh9PsfUJ+4gtgtYuSSLR2x8OE3K+R+yQHK1K5uc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Bqujwnv/60weMaO1zXrr/E2hWzEpKU8Oa3iG6AVSximk29LjWMYvKBiIVhkNmm5vANBDzOBpvKFTRchPCZjXn96x2VAhRsGCCq+GhaNhblj2MXQCGPqN8/Sypn9tn24LhrzdeRru6aCZDuxaM8+BixhK9wz+fku/F4NaEjvOyhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Yt0X/2v1; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Yt0X/2v1"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id D82131F6ED;
	Wed, 17 Jul 2024 10:48:55 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Z2oNQh9PsfUJ+4gtgtYuSSLR2x8OE3K+R+yQHK
	1K5uc=; b=Yt0X/2v1dbtWVu7xScJn3ofIdAR4mZRdTCgt+2twXkieQcFTDOyqwB
	x57UQpdUjQdRxPkvgH308OIe8sYCoDk8q29jeEgjutSZtoGjitxDvScB+v71ocXk
	8YQbeGccE4t93LM+7kQOwwG/R7XWB8NbM93UxKEgQ7HV+IiR8tmWM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id CFE071F6EC;
	Wed, 17 Jul 2024 10:48:55 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 5218B1F6AE;
	Wed, 17 Jul 2024 10:48:52 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,  GIT Mailing-list
 <git@vger.kernel.org>,  Patrick Steinhardt <ps@pks.im>,  Adam Dinwoodie
 <adam@dinwoodie.org>
Subject: Re: v2.46.0-rc0 test failures on cygwin
In-Reply-To: <20240717064241.GF547635@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 17 Jul 2024 02:42:41 -0400")
References: <aacb4067-a16b-4953-a72f-3c66efd3cf25@ramsayjones.plus.com>
	<20240717064241.GF547635@coredump.intra.peff.net>
Date: Wed, 17 Jul 2024 07:48:50 -0700
Message-ID: <xmqq4j8o6pm5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 AF260C02-444B-11EF-9C1C-C38742FD603B-77302942!pb-smtp20.pobox.com

Jeff King <peff@peff.net> writes:

> On Tue, Jul 16, 2024 at 08:45:48PM +0100, Ramsay Jones wrote:
>
>>   error: could not link file '.git/ref_migration.sr9pEF/reftable' to '.git/reftable': Permission denied
>>   migrated refs can be found at '.git/ref_migration.sr9pEF'
>> [...]
>> Now try to finish the migration by hand:
>> 
>>   $ mv .git/ref_migration.sr9pEF/reftable .git/reftable
>> 
>> Hmm, note no error; of course, the mv command may well do much more than
>> the rename() library function, so they are not necessarily equivalent.
>
> This is a shot in the dark, but: could the problem be an open file that
> cannot be moved? If I run a "ref migrate" on my Linux system in the
> debugger and stop at move_files(), checking /proc/<pid>/fd shows an open
> descriptor for .git/ref_migration.WnJ8TS/reftable/tables.list.

Hmph, I wonder ifthat means the same test should be failing on
Windows, too?
