Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B96A170A1C
	for <git@vger.kernel.org>; Wed, 21 Aug 2024 20:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724273988; cv=none; b=YOpbISHvotQF9JwcMDud3763PuOOe7bwK7qE0SiJQVk/ePPBl9WBWOfUjaKPDksXIFDBjkxA7hZqedaLkrxZkPHTKpRMyEoPD06abhKpydkasxOoYxWrwG1Qwubk3SOXmFiKPX9C1FYlMJMsc6KKlP656edr63TYahiDoJd7mDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724273988; c=relaxed/simple;
	bh=Ms2JkLc1VnHtR5Im1Qt9N+SXxyRr9EjtuseWAcN7xp4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lxACP5/bK8Cx8u239BAoAw0x7oRdEiCbjnGD670eOAYSWDzSSc6/ue+9RW+AOUKZJSiQ6gq+GrBS4xMuxTITdlJE6kYXUdGpmRyRZJpxB8StFfVS1NoThGQJhL7baT2s9K80pbPN0jl22PDrJJypDqtP9IbSeAFJBR4k46gwfb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=dcnnLGjr; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="dcnnLGjr"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 44A2B19170;
	Wed, 21 Aug 2024 16:59:45 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Ms2JkLc1VnHt
	R5Im1Qt9N+SXxyRr9EjtuseWAcN7xp4=; b=dcnnLGjrmXf2P3S8clhomlIH+pyE
	0V7l65Qemym+TVD+aI3fIDhFUO+vq+BmpPi9HD5esDIeBqqJ5vkF9u1HvcV/ccHV
	vD65w6MzXXC9flbQnIrPny/mU7bV4qwr98AnPzVORdoEoIIApTbHM+5hB02McFjM
	dXrvPO1YSZscqL4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3C17B1916F;
	Wed, 21 Aug 2024 16:59:45 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A4A141916E;
	Wed, 21 Aug 2024 16:59:44 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Yukai Chou <muzimuzhi@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im
Subject: Re: builtin/config: --name-only doesn't imply --show-names in "git
 config get"
In-Reply-To: <CAEg0tHQVK9hgcHTzn-ZPdwoFbbYFB2joeT0jLQgtD6yEH+1GiA@mail.gmail.com>
	(Yukai Chou's message of "Thu, 22 Aug 2024 04:28:34 +0800")
References: <CAEg0tHTWzgD5bw3oK7-Rtv9oTymqyhvZz3bcJ7yNRhF8wXMLGA@mail.gmail.com>
	<xmqqttfd2734.fsf@gitster.g>
	<CAEg0tHQVK9hgcHTzn-ZPdwoFbbYFB2joeT0jLQgtD6yEH+1GiA@mail.gmail.com>
Date: Wed, 21 Aug 2024 13:59:43 -0700
Message-ID: <xmqqttfdwq0w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 4B08A1AA-6000-11EF-BC40-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

Yukai Chou <muzimuzhi@gmail.com> writes:

> Junio C Hamano <gitster@pobox.com> =E4=BA=8E2024=E5=B9=B48=E6=9C=8822=E6=
=97=A5=E5=91=A8=E5=9B=9B 00:07=E5=86=99=E9=81=93=EF=BC=9A
>>
>> Yukai Chou <muzimuzhi@gmail.com> writes:
>>
>> > # get empty line(s)
>> > git config get --all --name-only remote.origin.fetch
>> > # get lines of name(s)
>> > git config get --all --show-names --name-only remote.origin.fetch
>> >
>> > Either the doc or the behavior of --name-only needs some adjustment.
>>
>> This argues for making "all" imply we need to show the name of the
>> configuration variable,
>
> Sorry can you elaborate on what that "all" meant? A new option "--show-=
all"?

Sorry, but "--all" is probably a red herring.

What I wanted to say was that we can=20

 (1) get rid of "--show-name",

 (2) have the combination of options that can emit values for more
    than one key to automatically show both name and value, and

 (3) add "--hide-name" so that such command can still show only the
     value.

where I mixed up (2) and "all".  In fact, "--all" is not something
that gives values for more than one key (it is things like regexp
and urlmatch).

For example:

 $ git config --get-regexp 'sendemail\..*'

would show values for more than one variable, and depending on the=20
variable, it may show the values for one variable more than once.
According to the documentation, this was replaced with

    --get-regexp <name-regexp>::
            Replaced by `git config get --all --show-names --regexp <name=
-regexp>`.

but it could have been

    git config get --all --regexp <name-regexp>

as it is clear --regexp could give results for more than one key.

This points at a bug in the documentation, by the way.  "git config --get=
-all"
is described like so:

    --get-all <name> [<value-pattern>]::
            Replaced by `git config get [--value=3D<pattern>] --all --sho=
w-names <name>`.

but this gives values for only one key, and the command does not
show key names.  It is replaced by

	git config get [--value=3D<pattern>] --all <name>

without "--show-names".

