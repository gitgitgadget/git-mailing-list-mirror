Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E1C130E58
	for <git@vger.kernel.org>; Fri, 29 Mar 2024 17:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711731715; cv=none; b=WFBt6wSygpsYyKAiAzaqoObqtGpF17YTRn+N0V/6x7gafsfh2dqZVdLKx7Q1/Xlt7yE3XXGdr0fwpbJGEzMQI2JMUP4Eh7lNgHRb2wDelzxtVHi0atSuW82d1vNWaPpw6PyqExSBtKM/wQtV/wgoGPlWQMpXPkRbNEdrE1EuxvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711731715; c=relaxed/simple;
	bh=fppd4amEVYDF6sHfzNRD0fRSmv2vLTwAp5mC6c50kGc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ue7Ry1gdXNklv1ChYjRTS/IwGRacMTGeytrry1F16ZzCE3bzKfOxZChOLA2+v1Si0f8YQoNfFS0f8lbiPHLVV3MiAru0V3rjODriAyV78L/0sBPjFEv5GXbbDrBDcsJbcSPorQtJdpsIoA+RXwmtZGkjbNbf0UTmozyrhQtK1zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=xP/CR+S1; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="xP/CR+S1"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 7FA3D263D7;
	Fri, 29 Mar 2024 13:01:53 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=fppd4amEVYDF6sHfzNRD0fRSmv2vLTwAp5mC6c
	50kGc=; b=xP/CR+S1dmwAprt2Zs5BevXoptW/JBMYxwhPcshv9OVnvmOEFp0dd2
	uIuo0ZACNv+j09kPo5z80vMm3as8l5Qwh7Nug0ut6uEPyZbODAP0fvxIwsgoOH1G
	E/bdp9IcwC9VTDybhKbkMMS27KFwOgln/CWFhSLR2nlXQVwfeS5Ng=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 7966A263D6;
	Fri, 29 Mar 2024 13:01:53 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0A3A3263D5;
	Fri, 29 Mar 2024 13:01:49 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org,  Eric Sunshine <sunshine@sunshineco.com>,  Han
 Young <hanyang.tony@bytedance.com>,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] t4126: make sure a directory with SP at the end is
 usable
In-Reply-To: <20240329112730.GA15842@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 29 Mar 2024 07:27:30 -0400")
References: <20240319095212.42332-1-hanyang.tony@bytedance.com>
	<xmqqttl2qml9.fsf@gitster.g> <xmqqfrwlltjn.fsf@gitster.g>
	<xmqqsf0bz5oj.fsf@gitster.g>
	<20240328103254.GA898963@coredump.intra.peff.net>
	<20240328114038.GA1394725@coredump.intra.peff.net>
	<CAPig+cQe1rAN2MUFTwo7JoCt3sO2eCk_psnJL9D=Rs=Q9MWO9A@mail.gmail.com>
	<xmqqa5miuutd.fsf@gitster.g> <xmqqh6gqt674.fsf_-_@gitster.g>
	<xmqqil15srub.fsf@gitster.g>
	<20240329112730.GA15842@coredump.intra.peff.net>
Date: Fri, 29 Mar 2024 10:01:47 -0700
Message-ID: <xmqqplvd0y6c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 08CBC332-EDEE-11EE-83D0-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Jeff King <peff@peff.net> writes:

> On Thu, Mar 28, 2024 at 07:18:52PM -0700, Junio C Hamano wrote:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>> 
>> > +test_expect_success 'parsing a patch with no-contents and a funny pathname' '
>> >  	git reset --hard &&
>> > +	empty_blob=$(test_oid empty_blob) &&
>> > +	echo "$empty_blob" >expect &&
>> >  
>> > +	git update-index --add --cacheinfo "100644,$empty_blob,funny /empty" &&
>> 
>> It seems that on Windows, this step fails with "funny /empty" as
>> "invalid path".
>> 
>> https://github.com/git/git/actions/runs/8475098601/job/23222724707#step:6:244
>
> Ah, sorry, I didn't actually try my suggestion on Windows. I guess we
> are falling afoul of verify_path(), which calls is_valid_path(). That is
> a noop on most platforms, but is_valid_win32_path() has:
>
>                   switch (c) {
>                   case '\0':
>                   case '/': case '\\':
>                           /* cannot end in ` ` or `.`, except for `.` and `..` */
>                           if (preceding_space_or_period &&
>                               (i != periods || periods > 2))
>                                   return 0;

Yes, and no need to say sorry.  I was also surprised, as I thought
that the non working tree operations ought to be platform
independenty, with this.

> It's interesting that there is no way to override this check via
> update-index, etc (like we have "--literally" for hash-object when you
> want to do something stupid). I think it would be sufficient to make
> things work everywhere for this test case. On the other hand, if you
> have to resort to "please add this index entry which is broken on my
> filesystem" to run the test, maybe that is a good sign it should just be
> skipped on that platform. ;)

This is a far-away tangent but we may want to think about "the core
of Git made into a library that works only with the objects in the
object-store and does not deal with working trees".  To work with
the objects, we would probably need something like the index that is
used in the original sense of the word (a database you consult with
a pathname as a key and obtain the object name with mode bits and a
stage number), etc.  Elijah's merge-tree may fit well within the
scheme.

There is no place like the above code in such a world.  The
restriction must exist somewhere to protect the users that use on a
limited system, but should come in a layer far above that "core
library".

Anyway, I think you convinced me in the other response that we
should just use an existing prerequisite, perhaps FUNNYNAMES.  The
idea is to exclude platforms that are known to break with the test
without any hope of fix.  Because they are incapable of taking their
users into the problematic state being tested in the first place,
this is not making things any worse.


