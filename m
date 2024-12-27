Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215AD155CBF
	for <git@vger.kernel.org>; Fri, 27 Dec 2024 14:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735309906; cv=none; b=szg0kQ9peXfYhmFsuPsX9IrHjdZ4gmMyfQeiPbg1pQiG42OESToUCvKDXuqtS4QeiEbkIvU4Eysh3rpihONGdJP1tO+BcJEyOwhLw87UKyF+R9O/Y+WRtj8R3qThFPYQuxLMOMS9wbEH4aGTfLGyfn+1cprTKfP6odfK9SMdMWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735309906; c=relaxed/simple;
	bh=1W32LwAg6JPF1bz00cuSey0TtnfkVBeCEh8rs1qVHq4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FM/lbnptwa30mGxLD5lMABSFtqbEW0FnzKXaLcu4pG4ezBQ32sgd8g6LTnI0V2rjqGb09coi+k9bKuDm0TLFbZ0MWsCSbxOSeHedfXxdhWQ1aQX5tZEYqmvmYDQUx7Bk3ZLH+plznNr+Y1ZgTvLqhmM+FOH0onQGAZHrEPw8Spc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=VGr9Ek2M; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=k5rokDMT; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="VGr9Ek2M";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k5rokDMT"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 074BA11400B6;
	Fri, 27 Dec 2024 09:31:43 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Fri, 27 Dec 2024 09:31:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1735309903; x=1735396303; bh=0JYUaG4njl
	XRkaeHxi1rYLG6kN295jrxMfHGnZXTwZI=; b=VGr9Ek2Mq/X6jfWj+ng1UEhF6l
	xObErLPSFdE1MU0ivl2lmrrUBH/YD+HDV8RsnthqUQC3vHJH7LgIOoEtFYWlzZhM
	JkZsPZGrbjhDXOO2Lq9MR+p+2m3gI2SF29ktvVQEmPOwkRiHa10jZLuBr4qWt8n0
	bfkJbwUFu8zYAai/t/k494MsEvveMixQBVZo7aaqQiglwsNhecqXkzu0XAll0BPP
	CyaXSsB+RKNZErU3R0E+fFqKsqoO7vVgi/wQLE2xwZB59kW9stUKnIvOx0NdSEa1
	V+zLm00xx1Js9+Hh9Xo69PTVeN4MBGCgjLQDNd1WGEmUNgcKcT0jkzQyAVBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1735309903; x=1735396303; bh=0JYUaG4njlXRkaeHxi1rYLG6kN295jrxMfH
	GnZXTwZI=; b=k5rokDMT13HMIk/FzpWZVnr2XXaQixvnmL+z2YNeLgJUtr+/U0j
	Uw8Wt+ThS6pZmyOBUAOQ37Z2HCpI/sYf0w1UPyo9ScW2jH+82W9BwHQXZpSadhUh
	JURUNjK+AWSi76MwYVPO1pBXAnX1oq+JaLrWyveu/S7Bdnt3eWiDfi5qZ7gOrXqy
	p6j3rvbu1yMRdOvnn3VK08kEmucx2a78/aeHlywyUmrLNgzhmEVnkxAt/3QOewNB
	+9iHJ6FoUVo5Dunmd0LvkvdYvSLD7dyCOZmrh1wXJliiXCxjz+SqDePn6FpFHQrv
	Ges9YeF3vHLf8lIerVYwLmC/RkqdxN+EA1Q==
X-ME-Sender: <xms:TrpuZwKBuLrfi9zegiBhy1WNDsGvPF8HXK8kh0IDm2wPqfzFo1KddA>
    <xme:TrpuZwLWRDZLfbLBcKwLAWyWWe2-11mf3WaTwNsytti_QYv7QJDhh93QYzbi2TcHw
    _JjN8r5GDL3qBJ5Ig>
X-ME-Received: <xmr:TrpuZwtDzfBhBF7tc58s7LW-InuCFCJCQ6-_4XoQZFKO6QmbobpuDjtP8aNp4iXlf-c1gm-s2FRcsffrS-a-qXuunaGaSr8iJA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddvtddgieeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfi
    hoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehsohgvkhhklhgvsehfrhgv
    vghnvghtrdguvgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtshhtvghrsehpohgs
    ohigrdgtohhm
X-ME-Proxy: <xmx:TrpuZ9bZqI69cusH6l0KL_ZfEe9xF4rGzScJzZlPJQO408f-2-FiKg>
    <xmx:TrpuZ3bIJhNg0cR8liaThIyWop2LkiLwahdhzYnlIj4qprf3zv6vNQ>
    <xmx:TrpuZ5D6S6GbqScUwFZsqPA_K4_8xjn0A4wNLTwbcgZ9uWo_lPi_yA>
    <xmx:TrpuZ9ag1D8qUdJMx5WV7qKGVEyKTtzaUbQvQ9zpMlicu103nlij4w>
    <xmx:TrpuZ8MqMLri2-QxZT73DKBZXkB8Zz55OhewdI_izdGl8W9VCF10ufKB>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Dec 2024 09:31:41 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: =?utf-8?Q?S=C3=B6ren?= Krecker <soekkle@freenet.de>,
  git@vger.kernel.org,  Patrick
 Steinhardt <ps@pks.im>
Subject: Re: [PATCH 1/4] add-patch: Fix type missmatch rom msvc
In-Reply-To: <e396131c-1bd3-46d0-bae6-cd97ca9710d8@gmail.com> (Phillip Wood's
	message of "Fri, 27 Dec 2024 10:38:33 +0000")
References: <20241223110407.3308-1-soekkle@freenet.de>
	<20241223110407.3308-2-soekkle@freenet.de>
	<xmqq34iaxh7r.fsf@gitster.g>
	<e396131c-1bd3-46d0-bae6-cd97ca9710d8@gmail.com>
Date: Fri, 27 Dec 2024 06:31:40 -0800
Message-ID: <xmqq5xn5urhv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

>>>   struct hunk_header {
>>> -	unsigned long old_offset, old_count, new_offset, new_count;
>>> +	size_t old_offset, old_count, new_offset, new_count;
>> These are not "size"s in the traditional sense of what size_t is
>> (i.e. the number of bytes in a region of memory), but are more or
>> less proportional to that in that they count in number of lines.
>> If ulong is sufficient to count number of lines in an incoming
>> patch, then turning size_t may be excessive---are we sure that we
>> are not unnecessarily using wider-than-necessary size_t in some
>> places to hold these values for which ulong is sufficient, causing
>> compilers to emit unnecessary warning?
>
> That's my thought too - I think something like the diff below should
> fix the warnings by using more appropriate types in expressions
> involving the hunk header offset and count. Our internal diff
> implementation will not generate diffs for blobs greater than ~1GB
> and I don't think "git apply" can handle diff headers that contain
> numbers greater that ULONG_MAX so switching to size_t here seems
> unnecessary.

Yes, exactly.

Of course, when filling old_offset and friends by parsing an input
line like this:

    @@ -253,7 +253,7 @@ struct hunk_header {

it would be a bug if we did not check if "253" overflows the type of
old_offset, etc.  And I would very much welcome patches to fix such
a careless input validation routine.  But replacing ulong with size_t
would not make such a problem go away.

Now, I would be a bit more sympathetic if the patch were to use
integers of exact sizes, in the name of "let's make sure that
regardless of the platforms we handle patches up to the same limit".
But size_t is not a type that is appropriate for that (and of course
ulong is not, either---but the original did not aim for such a uniform
limit to begin with).

> @@ -1626,7 +1628,7 @@ static int patch_update_file(struct add_p_state *s,
>  			else
>  				err(s, Q_("Sorry, only %d hunk available.",
>  					  "Sorry, only %d hunks available.",
> -					  file_diff->hunk_nr),
> +					  (int)file_diff->hunk_nr),
>  				    (int)file_diff->hunk_nr);
>  		} else if (s->answer.buf[0] == '/') {
>  			regex_t regex;

I skimmed your "how about going this way" illustration patch and
found all the hunks reasonable, but this one I am not sure.  Is
there a reason why hunk_nr has to be of type size_t?  

When queuing a hunk (and performing an operation that changes the
number of hunks, like splitting an existing one), the code should be
careful not to make too many hunks to overflow "int" (if that is the
more natural type to count them---and "int" being the most natural
integer type for the platform, I tend to think it should be fine),
again, that applies equally if the type of hunk_nr is "size_t".

Thanks.
