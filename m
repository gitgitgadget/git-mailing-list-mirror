Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52CAF23778
	for <git@vger.kernel.org>; Thu, 21 Mar 2024 16:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711038199; cv=none; b=I5bt/3LyrurnKlP4XlHjnTOxOa6O6odfMjDTLSs1ocAEI8BNmq8YS4e1hl6qPzP29MkKZidTgT8FIshOv0W5zDnpFSrth6drx7yNvTqnMG9lXgCwB7VhJoiuZcIMmLHv9sBkhx9FPPDKeJlINF2iHbm6xGwKEN7UvSlw6MxWXyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711038199; c=relaxed/simple;
	bh=BrL9v2w1MVyEQ5H968MftXsPzQ82os8uVs1no1qxcA4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=so/WdH4vWMbCLkUrg3TdTzDw3VBMvDbAGJnRj7TmFcNNIZgSkIE2kUVIJMnwhT4N9g4BJJq24pbS80su3dGcylauRvygBgVa+IeOeKyyOumdryiouflzeHYbIgni81r/Ig6tY3htllIM6pIkfInoPqHMblJfBpc1A+siW1kSxRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=tRFJ8/qR; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="tRFJ8/qR"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 415E01EFAD0;
	Thu, 21 Mar 2024 12:23:17 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=BrL9v2w1MVyEQ5H968MftXsPzQ82os8uVs1no1
	qxcA4=; b=tRFJ8/qRbyCpwSUzJwidnoi9dFj+Bw1lPRO9Nihy6WUkjWWYLVcGDk
	uC2E06spHEA8Z3uLAdRWhX/h0OE25t2lm1vP2996Ux3GR50IBKCCbSagBgiUTIPb
	mJY7KVzittUw3kL1FUk5RPvmL8bmHCxjq3FA21oYI8WSh84dDyjos=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 39BAF1EFACF;
	Thu, 21 Mar 2024 12:23:17 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 96AED1EFACE;
	Thu, 21 Mar 2024 12:23:16 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Brian Lyles <brianmlyles@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH 1/2] docs: clarify file options in git-config `--edit`
In-Reply-To: <ZfwFKyE-eOJo0zl4@tanuki> (Patrick Steinhardt's message of "Thu,
	21 Mar 2024 11:00:11 +0100")
References: <20240316050149.1182867-1-brianmlyles@gmail.com>
	<ZfwFKyE-eOJo0zl4@tanuki>
Date: Thu, 21 Mar 2024 09:23:15 -0700
Message-ID: <xmqqcyrnbll8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 5293D4DC-E79F-11EE-9274-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> On Sat, Mar 16, 2024 at 12:01:24AM -0500, Brian Lyles wrote:
>> The description for the `-e`/`--edit` option references scopes
>> inconsistently: system and global are referenced by their option name
>> (`--system`/`--global`), but repository (`--local` is not. Additionally,
>> neither `--worktree` nor `--file` are referenced at all, despite also
>> being a valid options.
>> 
>> Update the description to mention all four available scopes as well as
>> `--file`, referencing each consistently by their option name.
>> 
>> Signed-off-by: Brian Lyles <brianmlyles@gmail.com>
>
> I know that this series has been merged to `next` already, but as it
> didn't get any on-list review I just wanted to mention that this series
> looks good to me.
>
> Patrick

Yeah, thanks, both of you.

>
>> ---
>>  Documentation/git-config.txt | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>> 
>> diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
>> index dff39093b5..6876803253 100644
>> --- a/Documentation/git-config.txt
>> +++ b/Documentation/git-config.txt
>> @@ -275,7 +275,8 @@ Valid `<type>`'s include:
>>  -e::
>>  --edit::
>>  	Opens an editor to modify the specified config file; either
>> -	`--system`, `--global`, or repository (default).
>> +	`--system`, `--global`, `--local` (default), `--worktree`, or
>> +	`--file <config-file>`.
>>  
>>  --[no-]includes::
>>  	Respect `include.*` directives in config files when looking up
>> -- 
>> 2.43.0
>> 
>> 
