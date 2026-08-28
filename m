Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2241A21CFE0
	for <git@vger.kernel.org>; Fri, 28 Aug 2026 22:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787957465; cv=none; b=DwUukWSAWGacU/buQ7J+vqrldvnR6mUDqROu23LNl+I3UtzUkgj5LhmLQJiXPwAFlEYYmRRTjQyMka6LcX2aR0s7Kb9zlioAQrnsrzHu/bNDDLXCNFU90ZO9BnzqA+L8TzYPb1bZwfAM6l2zaIKAH6pXHDb9anZt9z+NV6cfj7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787957465; c=relaxed/simple;
	bh=J2xZ2okoGyQmlKXt6SPXT+g8/qYEhFm0iSoN2jjfCo8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cNstphmjqSwAaZKkdmbaJ0TPV3r+Hw2/jmGbNj+SDv5HlcrWJKyHcEy/a3rogvM2WG/t6J7ZjhlbxxE73ZArIW0mRfQmFDHH9e1yHmBJTn9vPJ9ZWqbXksXW+n6VmNG3IzsoDDtla48PQwSB6YeytQ+pi/qAOs31/jHsP/fdFo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=kWcqo+8B; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mfnnRrk5; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="kWcqo+8B";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mfnnRrk5"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 09E3C1D00169;
	Fri, 28 Aug 2026 18:51:02 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Fri, 28 Aug 2026 18:51:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1787957461;
	 x=1788043861; bh=oy2NJsuXh7Cr+xJ1G0dJbMlKOo1msjjS/GCU4Aw93zE=; b=
	kWcqo+8BxJiLyav2zQQIEiIXtsz7/qXi57LX1EEqmPjh14FDH4Lrg8eaIkabcHkO
	UjK5W+WS8LEN6O+ofSZnXQ9zDU5OmwFqAtzT44/x/VWwO4n0/Ejdj4mpimjnplyL
	ZxDG9onbbOgMqAhK+46MjJadJWhScRnoOjmg80VtzAu4ZJkDXGsZzB83SvNrSzP0
	No3mLGyvo8n+/ZusIOYdonFthUieT5HQ9FS7AD7Vj2hTZe2dXT+MiiZYhiG9lwKw
	fNnBISbknU3ScEBMxjqsMeISGNETVg9jVbPNCaoOAl1z+Vt/tgZd/Qldp3QtSPvi
	P8D21gKBbJ3SQ9AL5Kt7LA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787957461; x=
	1788043861; bh=oy2NJsuXh7Cr+xJ1G0dJbMlKOo1msjjS/GCU4Aw93zE=; b=m
	fnnRrk5l1XbUQt0a0GhPB2DlatBfth2/o8S/vySX9kT88S0KZorH+/E9bfqnAqVR
	arVf7IXoD2EwBNZ1x/zE2rT+vnNbIrf/fpRjmqAedBR1NJ63xlLwwwfNF8dFjg+z
	83pbtEek0IOL6Sq39VOz4YYTJrmhX6sDu9AHpCBhcFHs152a9iiouAF6BK/D+VGh
	9BlKQpvTWJ8EpbzCSCnDwqFj+ywQRDG/GFpk0IClwI2BZHih9K1OsTHZgRAs9KeO
	CJETyjcOvbW1xsnjm6uEpGHr96j+2LYdzJwUH1zq0f4MOmkubmhY7HCD7EEq/Gc9
	9b9TpIl7lIvKqrubF0tuQ==
X-ME-Sender: <xms:1RCSakZQaGUGDmHKnTCD7aIE8DLr-zFuD_0qQJJGbLiEmrW1nuzTgw>
    <xme:1RCSambSP_0qbg1qDn5f4_ms_GMzLD58IZCb8lspA6jeS9XFajO_-7iMFGYQnWsfh
    ApOy_hJ-5rtvkmCTqLfmppIMNlGCRNc-3K1XDYoCBHP_ks2exOQv80>
X-ME-Received: <xmr:1RCSaj9HJgPFKThLKcSLyaBtdjDA5rIn-GTnG_90q5syAJz2nwSwI40Pxa7Csxi4gVL3Cu-HDW3WCVnS7nD3XRj6fcdQoFOxhQ>
X-ME-Proxy-Cause: dmFkZTGSA2QLkSSEaxYkHeXIjmDZDeaE5AdFbBlATx7HPNrclQvlRMJ+7DoSTJb5FqrJCD
    1d2XHjHws9qK4xafzI9y19VPpKnCRo0aofUhsIdPsgp/2HK49GfDMaV3LzBY9hCxDnVZHz
    bNW0c9L6rWlaPUAJlEG2F1H1xr9h15yFn6ADlI4/istrJZMIU7sfpECXpxOgN6bqgB/h6I
    ocUaLBYCTVIqw/7p92Wbe2DBTjz/obVbpGrdcQO4+qV3UUw/5RPncqxeYdzNySiRyqfu76
    XP81L2Wxvv84VsgHqcgVSWk2YMkBvCDrLaSg1cK1U+ii/lePAAKphejjj0/jS2RYNqPJQJ
    +5C1TUJoQseaOcWY7TqL3c63z2XgMQj7ywS3s6FvOnxYtABn/RQvalOYd4UDSVQed0X9I/
    LS3vLmrEY1cOY/t7mDfhHj/BVGml7kcUmlG8WivOKrfUqsLlevRZvL4z3FSs0x+hqXgQlS
    UkLC27QoEZ5jMQEe1VSSDntjMEf0Baux7tCrni2JbAUsevKdwAosmLbukzUIEsSFkc/U8H
    MQmyiRt2KY3T8Mi99FULSrnccpJyBajgC5dYTaeuIVEIUCAnzO0Y+9mCJ+Fy0L9RxsVJZj
    xUJDfdUrGHW0C3kTwXVBX8WnGj3t1s9Pd4b5b2e8iJ0WynO2Oflgq6ENSEUQ
X-ME-Proxy: <xmx:1RCSatj9guRgRzO98KWXpk9ULdqx6pn_h5aCR5MUOBTsc6QvHo_fyQ>
    <xmx:1RCSardaN_wtXrSMMNqCcHSReSM2A2-JPPuIGHfF3ZpxtpE05_i7cw>
    <xmx:1RCSaspXXMDa05z9j1z1Z5Jf4o15kxMaJcQ1qlm0DAHD4JTEOmLHMQ>
    <xmx:1RCSaoDwU4ArKMrUplKsfNV1wfEK9v2X_Zdibd_cen39eqpDMqbouQ>
    <xmx:1RCSajdSFIUeI92cqF_Sqm1jTXhm-2xTFQwP-9B91lbew2dePwMyAZXg>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Aug 2026 18:51:01 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: Hardik Kumar <hardikxk@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH] builtin: replace the_repository parameter in
 is_bare_repository()
In-Reply-To: <CALnO6CCsJGmgmvKyMdX3q1Kr5AnBwYJ=_UiQ9+m7jWe7hv=3Qw@mail.gmail.com>
	(D. Ben Knoble's message of "Fri, 28 Aug 2026 07:41:39 -0400")
References: <xmqq7blb8g04.fsf@gitster.g>
	<F276C11F-1904-496E-AA77-953724362C9A@gmail.com>
	<xmqqik4v6y6i.fsf@gitster.g>
	<CALnO6CCsJGmgmvKyMdX3q1Kr5AnBwYJ=_UiQ9+m7jWe7hv=3Qw@mail.gmail.com>
Date: Fri, 28 Aug 2026 15:51:00 -0700
Message-ID: <xmqqh5kd3lm3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"D. Ben Knoble" <ben.knoble@gmail.com> writes:

>> > Hm. What if a program wants to do « exactly what ‘git switch’ does
>> > » sans shelling out?
>>
>> Instead of cheating, properly factor out reusable part from
>> cmd_checkout() into a set of libified routines, and make both
>> cmd_checkout() and cmd_switch() to call them
>>
>> An approach like that would help "libify" things.  libifying is not
>> just reducing dependence of globals.
>>
>> Calling main() from something else is not a libification.
>
> Sensible. Thanks!

I actually answered a wrong question though ;-) 

The way cmd_switch() and cmd_restore() were introduced by sharing
what used to serve cmd_checkout() was serviceable, but ugly.  Had we
started from separate implementations for 'switch' and 'restore'
that were later merged into 'checkout', we would not have ended up
with a design centered on a single monolithic choke point like
checkout_main().

That is what I meant by "cheating instead of refactoring reusable
parts".  However, that is not directly relevant to your example.

It is an anti-pattern to call the top-level implementation of 'git
foo' in cmd_foo() directly from cmd_bar(), since these cmd_foo()
functions are like main() in ordinary programs, performing one-time
initialization (such as git_config() calls) and finalization that
cannot be repeated.  To help our codebase, as well as the use case
you imagined in your message, it would help to trim down these
non-reusable cmd_foo() implementations by turning them into mere
orchestrators that call refactored helper functions.  Such a change
would put cmd_foo() and a client that wants to reuse 'git switch'
functionality on the same footing, allowing more of our code to be
used in different contexts.  I think that is what people mean by
the "libification" effort.
