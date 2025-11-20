Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50CDE26F2AB
	for <git@vger.kernel.org>; Thu, 20 Nov 2025 16:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763657183; cv=none; b=Zqs15UC2UNNxp7eUH/7qI2nPv/DMb6Wjv+Zp3Y92swi0XIAzJHwaGIQZDxVteU6FrQ6S+kPVUIzCXBp2W11UXXOvtAKsI21/PebHNTzHFL52GGhMTVbUFbCits5zk2v7Dk1QhMRiuNQNyd0JQz03nBbgUgWw++qw1N1T9laHopM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763657183; c=relaxed/simple;
	bh=2pnnb2pzlv4re44KxMNQKvKmzHc/nGoVZjPxcAjPIU4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=s6M856Dish8sw2YvdKhPBxnWcXb74NXDD8IcDTfBphp16dJdsh+j6CmjkvwsRv3l1PxrMsO0zzf+SGHkKjeMLNfUvHfG6JmK76MUI5jFqk5ZGadXQFtID7n7N4tXEUAk9Ut94y00rxTKS9MvWe5kGsRBhLP8bd+XR5O5706ayx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=TZnQLz1b; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sA/aQmih; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="TZnQLz1b";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sA/aQmih"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 47D58EC01E3;
	Thu, 20 Nov 2025 11:46:20 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Thu, 20 Nov 2025 11:46:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1763657180; x=1763743580; bh=xKBtdDNE+C
	bE02uYKK7JFJN8KKaHajWaroQiHCct5mk=; b=TZnQLz1bpvGtm0JTLVMhfx2lMG
	Ac+aThglNg9KcKqothzN/j6lLSZEfFXFEPGo/4bz01x8f6ntsucXwQ+gAaOlTsx4
	Hm0F2eER1Ekdln5ALd+mMV4HhWMqGVgI6NDR77cUNX2OPzkMDSaVh8z6FAU/j8Ji
	WbjvhYarPQlfRdQ3KRj1YhhxMNt82QckmHV9ZsHtLZ+1noTn4Ck/Mk6u6qQtNV5X
	mj9hZ42GVUt52C++yulMKeUGgiCIWKc8b3jsEyOaXXoJlznc2gl+7SHKOofFD/67
	CqevWmn34FoHiaMd2ZRGznJdALry+n/id6BcacLyakfbThy31PxMtwnu5KCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1763657180; x=1763743580; bh=xKBtdDNE+CbE02uYKK7JFJN8KKaHajWaroQ
	iHCct5mk=; b=sA/aQmih3KZMHI+JVkWJjI+CYpTqUZd5yc3ev21Fk/43EV6tgYd
	wTnInucLqnT2incYlzlyZjaOnmX+8H3QskAf6G0kaA8dX+HlJ4OL1OCd4bFcRwJI
	ZAbpWOFXYb948rstfMn0TEgq7ARIzgeoUe9rGz01GnFeTo/4e8sybBte+7HC1MBd
	YLnDSkjSkcr1Gg5h/s93jE2htbktP8wp3mL0dLm00XX/r2vSHuXDP9iLVjK62BAs
	ERloHjomcEngaHKzrkTW2uH3UVioGA85aX380s1PVFp60u5iE2Bv04juS4OA0qNy
	sccka8/YffmEqm2kELis7sHELRSSGB5n4Rg==
X-ME-Sender: <xms:20UfaUPdSj0o1ssmsgfeSiOav10iRWkQjM_Zws4AuBx5Fz9iILqV7Q>
    <xme:20UfaVh1WN1hgwYaJauoO5OZIAIauyYE41Zwt6f_ksUHI-3EfG4jifiQ3JBy8EaLX
    OFxriKSHHZ8p_39T_vLcKMD4HqvnfXxpqQ2nO60xjwnBsMFOSoiSg>
X-ME-Received: <xmr:20UfaX0UVw4hMntdCf8nxBPtFjgFjYPgtslM4yFAZ24LA1CvrFzjIoDhuDYFNd7_CMN36RCMhS0W6pVXbNLOeEBmDyiVotYpTFHj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdejiedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhes
    phgvfhhfrdhnvghtpdhrtghpthhtohepjhhhtggrrhhltdekudegsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:3EUfafg8-U2zPzCmmGWUPF5aRMArnmB83bcW3LJ8voYPxJw51mxN1g>
    <xmx:3EUfaXcTHLNju8a4-q2zBbdQn2sZw99dQbUF6CB6JW9AkBJiDc54qw>
    <xmx:3EUfaSlHECirJjdXcJv6ughTD0RZIjRkS2ZQK7QCw9xK01ggoj_oWw>
    <xmx:3EUfaQsJ1vF0GZ1WyUx2v7tCL9_1bLzAuSegjiTpMeyqqbcfLiForg>
    <xmx:3EUfaf_Oubg-_SrVGLZVGuUw2gBA355uIRyEwv3ZtWkmBiZUdKGjSWOE>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Nov 2025 11:46:19 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Han Jiang <jhcarl0814@gmail.com>,  Git Mailing List <git@vger.kernel.org>
Subject: Re: `git config get --type=path` results in segmentation fault on
 value starting with `:(optional)`
In-Reply-To: <20251120075019.GA1283645@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 20 Nov 2025 02:50:19 -0500")
References: <CANrWfmQUuGKWPc6JCzeCaa9t98ag_Lyk0G_Prtd8YmqP-TiRpg@mail.gmail.com>
	<20251120075019.GA1283645@coredump.intra.peff.net>
Date: Thu, 20 Nov 2025 08:46:17 -0800
Message-ID: <xmqq1pls8xeu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

Thanks for analysing all of the above (omitted); I was doing the
same on the bus but couldn't finish it and then when I reached the
office, you've nicely done everything necessary ;-)

> I put a [*] above on "more or less does the right thing" because there's
> another corner case, even for callers like commit.template. What should
> this:
>
>   [commit]
>   template = :(optional)does-exist
>   template = :(optional)does-not-exist
>
> With the current code, we will ignore the second config entry entirely,
> and the result will point to "does-exist". But that feels surprising to
> me.

The documentation says

	If prefixed with :(optional), the configuration variable is
	treated as if it does not exist, if the named path does not
	exist.

and when I wrote it, by "the configuration variable", I meant the
second "template = ..." line above, not the configuration variable
commit.template, that the machinery pretends not to exist.  So the
result pointing at does-exist matches my expectation.

> I kind of wonder if git_config_pathname() ought to be returning more
> data to the caller, like:
>
>   struct config_pathname {
> 	char *path; /* never NULL */
> 	unsigned missing : 1;
>   };
>
> That would change the interface of git_config_pathname(), but that would
> also force us to make the appropriate changes in each caller.

The problem is that there is no mechanism for the function to say
"success" without setting *dest to the discovered value.  We could
introduce multiple kinds of "failure", and have callers react to the
differences, but then it is like setting NULL in *dest and having
callers react to it, so I am not sure how much benefit we would be
gaining by changing its interface.

On the other hand, builtin/config.c::format_config() probably needs
a richer set of return values.  When used from collect_config(), it
needs to be able to say "no, pretend that the key/value pair you fed
me did not exist" in addition to "that value is bogus---you have an
error (e.g., config_error_nonbool())".
