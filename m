Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBBF91F706A
	for <git@vger.kernel.org>; Fri, 27 Dec 2024 15:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735312079; cv=none; b=b7Cyj+5vx78/zi31IaaUey8WctN271e1QTQthYDp7+hx3/21c9KR+TDCxqBGZaQPtsasdmAQuRTZX23KU+jSmVXtty523zu1X0YIig5NnsWWS6ImM1D95/QilRyg6WgrppfvoE9Xi84vzeDj1ICNRBVnRhnOx+bdVOBcQxlAmME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735312079; c=relaxed/simple;
	bh=j1CxN2j/IbumtQg+oAyzJeipKLA26ucQ84+CD4O/Zm8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aoSyfa16Lsb00Akrtq0/oHWKroFolvdp4/g0NFJL+/M7ftuJwQg5PqXsLjTTG8ntDT+HahSLjQODJYzhQrkYUvXRJ5mqRbVrKNZEV/KMQKwhXMX+geM3zmmjF0qL0mgI+rOcJBk+ZxCFaHiQJpFCyYLGYl8CpQ6InpRGEU0QFlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=6NCxsBbC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PFDZzkMm; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="6NCxsBbC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PFDZzkMm"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id D207F13801E7;
	Fri, 27 Dec 2024 10:07:55 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Fri, 27 Dec 2024 10:07:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1735312075; x=1735398475; bh=CWi0s0/4t8
	4N/vQMZFvVimCmlwU0OZGzGMv4bVHTeW0=; b=6NCxsBbC+1gG/wRUrlLZbgEuy9
	fZqcnm004aD6wyjo5Ne9btfbgFME8xlP40tPU1jcKsbXXkWfM84CX/SmpK9BtVht
	xlxcjTzNGFiLOAXWoh5Vk28BoJ/KyUxf6frG8TwzgYzpr2rmiEb7cwequ6PYtzZ6
	0KuvY1/Mvr4BqT7VA37fYieqdpXKVBQxFntb0jbusDO2+5886xERrmxtqNf2eP1l
	1XmUrycifOJtb7VR1XJXE8kH5E5Pz8AuXxQ4d3IjDQvbuMGxUW/W9o7Kea02vp/a
	Vzs37uc6cKZGVIlNeohlLtDYPAsCy5k4x2jelSjt+x50o/voInG59Cqzzm/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1735312075; x=1735398475; bh=CWi0s0/4t84N/vQMZFvVimCmlwU0OZGzGMv
	4bVHTeW0=; b=PFDZzkMmVfFI4Bw0bsTf6uvD3/847ImcbfeWjdslw9g2GZt0vRk
	KSHqPXegSTVhoyLgEzzWQjPopgVLiORGuxgqDP9zTLudS8Fr7LuSp2Wq1EwAABNi
	V8eSFVPmhgmbLJbho4u/AgtasLUO1y6k/p1DPv60SW6O8Cqau7EvLdW66g2e9zpt
	sOYO6Fu6llbrM2sOtXSsNWNFTOzfqNpqlFQP5+4rtA9rY9nTNlSubNaiHmB0KQW+
	0xhoSTLoo281cpQzVO4TR2FfkEtu3MqiClspjMamTFTY07EmvRaZMTW9vlSg7XbL
	tWT9LdDz1NYDf0DNdVQuNtrAU+84tWvYGSQ==
X-ME-Sender: <xms:y8JuZ4a5b_uZDjFUumXOqs57YcxKv935fK8ARdBQIvX5CZ6IepBFJQ>
    <xme:y8JuZzZ-vvKuoePegkofAxJ2_zEeKkMk6yZZ41nzCGDOw80nK2gYxV2n5AiUG5k-5
    ScuIgCDyHXNZFQgYw>
X-ME-Received: <xmr:y8JuZy-ZqKWZlwf6cVGCulIbBbeXpswvD-ULQeeAFMHNYL8yliOD0WNtAXx5muQEVz9IaojGFRQU96DyQo2tFVKyY90mhe8WgA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddvtddgjeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    ghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:y8JuZyrfoEAF-dGJgHtDrKM55gUT0YHeGBNKT9gJR55YerduUA6wYw>
    <xmx:y8JuZzqF-m8tsnGuRRt6k65QJXbWMH8PfPCH1kBCDGt38eKt7hTF6A>
    <xmx:y8JuZwRyu19eY9tk6Y1_9a6GdGSA9b0kCzCb-Oi6cTYCxtFA5SJpRw>
    <xmx:y8JuZzq1jDHxxIiKbA-fnwxiNCbDPQOZkxHe_XkYv81MfzJJPudS_g>
    <xmx:y8JuZyWUNp_gWM_jOhU1dgTcIX152aVJk4VOC-G20EcJiUTHsSi4Q9B1>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Dec 2024 10:07:55 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] show-index: the short help should say the command reads
 from its input
In-Reply-To: <Z260VVuIH_-0Ylis@pks.im> (Patrick Steinhardt's message of "Fri,
	27 Dec 2024 15:06:13 +0100")
References: <xmqqfrmidyhk.fsf@gitster.g> <Z260VVuIH_-0Ylis@pks.im>
Date: Fri, 27 Dec 2024 07:07:53 -0800
Message-ID: <xmqqv7v5tb92.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


Patrick Steinhardt <ps@pks.im> writes:

> On Fri, Dec 20, 2024 at 10:02:15AM -0800, Junio C Hamano wrote:
>> The short help text given by "git show-index -h" says
>> 
>>     $ git show-index -h
>>     usage: git show-index [--object-format=<hash-algorithm>]
>> 
>>         --[no-]object-format <hash-algorithm>
>>                               specify the hash algorithm to use
>> ...
>>  * I also found the option description somewhat funny in that
>> 
>>    (1) it makes it look like "--no-object-format sha256" is
>>    accepted, which is not a case, and
>> 
>>    (2) "git show-index --no-object-format" already is a curious
>>    thing to say; the command certainly needs to work in _some_
>>    format.
>> 
>>    But (2) is common to all the usual command line options to allow
>>    defeating another instance of the same option that is given
>>    positively previously on the command line (i.e. "git show-index
>>    --object-format=sha256 --no-object-format" should behave as if no
>>    object-format option was given), and (1) is shared by all the
>>    other options that allow such override.  So I'll let it pass, but
>>    if we really wanted to improve it, the fix should go into how the
>>    parse-options subsystem works.
>
> Can't we already fix this via OPT_NONEG? Or is your point rather that it
> is awkward in general and choices like this should never have a negated
> variant by default?

Because '--object-format sha256 --no-object-format" is accepted by
tools in the wild, OPT_NONEG is a regression, I think.  IOW, (2)
could be a position to take for a new tool without any users, but
not for existing ones including show-index.

To solve (1), we would probably want to phrase it like so:

	--object-format <hash-algorithm>
			specify the hash algorithm to use.
	--no-object-format
			override a previous --object-format <hash-algorithm>
			and revert to the default.

I think we should say something about what negating does, but with
the wish to make the mechanism generic so that callers of
parse-options API do not have to write a new string, I did not think
of one better than somewhat overly verbose one you see above.  The
parse-options API should be able to construct the above without any
extra input from the programmers.

Or, just show this, without saying what negating does:

	--no-object-format
	--object-format <hash-algorithm>
			specify the hash algorithm to use.


and defer it to "git help cli" to give the most generic version,
e.g., "the effect of an earlier option '--opt <value>' on the
command line can be cancelled with '--no-opt' later on the command
line, if the command supports '--no-opt'", or something like that,
at a central place just once without repeating.  I dunno.

> I was wondering whether we have any other usage strings that show an
> expected stdin like this, and indeed we do. The usage string in
> "builtin/mailinfo.c" uses different syntax though without the angular
> brackets, but "builtin/pack-objects.c" does use them. I think with the
> angular brackets is more idiomatic in our codebase though, so the
> addition looks good to me.

Yeah, we may want to make things more consistent.  These two
commands were what came to my mind and had me check before settling
on the version of the change you commented.

Thanks.
