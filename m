Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808AD17C211
	for <git@vger.kernel.org>; Tue,  4 Nov 2025 04:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762231449; cv=none; b=Li0yhPrEteuGzboUUhe4WpjXmackx6LYWwG+ziWGM5piuU7WMa+pYM5GMAWVkMpshoJMoQ0YbTNNxZE3ohOVEPt4fzRuHIg5hnLeZH7DyMHtlYjqJGbgrTsFN5YAEIGU5Ta/2p+NNZEhX50psyGno7Aa295dgKuWHFwwGy+petg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762231449; c=relaxed/simple;
	bh=K7AZNycyMFdxlb7eUa6lpTRINX3a2uBI2lxf6mTW9aQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qkp3UVfTd0p67x7ZfLSbiSJRclZtaKETNLbpVxY40eRa8lh7xSrgUVQaPPLY9UOBfxX0Z1OB5LNlWFv7tVRLcxC5BHD4dMfwuVlzn6aXKsPAf9aKSP9dQv7OaZMxB/loaw+jn4MKn9M/4RBeKq8tfrFvfX+/037bLp7FZlzSoHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=mK05iNme; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kBsCHFyT; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="mK05iNme";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kBsCHFyT"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 6761C1D003E9;
	Mon,  3 Nov 2025 23:44:02 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Mon, 03 Nov 2025 23:44:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1762231442; x=1762317842; bh=gYtpt3PUwb
	I1GhSUy+CF/ifynxPvra7kdhpLLKxebfA=; b=mK05iNmeIYMb1mHT9TY45Zmm7I
	JQjtzpibDuEohuPNd2oF/c1nm1Vu5zosBb1GOPFq0vKN30GvyJsHNT7Tjoho8uak
	cxst3O9c1cGIcZOZ+uHRF7paQrDjNtJD2EyjKMnRr1S4pli+eG6kyxbzwCAFOPOI
	AnqJf9K66+/UYavdB3072SjVDhYVTqMeEuclMIEtEdT5+oDYOn71p8cJdJazGu+P
	t+08BJKwndD0D5T2XJ1pksteTNvPNhUSLiXL4mILRfafkLyLAcKOQg1YsxTG3Jyl
	fJBs8FRYIeHhCkEsrKKY92dttNVDe9EePDGg2ahFwOC9SCITcrS7cNWBeL/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762231442; x=1762317842; bh=gYtpt3PUwbI1GhSUy+CF/ifynxPvra7kdhp
	LLKxebfA=; b=kBsCHFyTvLxqCXbznI/8pf4NiUabZMkFtpmGV5OmIu1P4h8qWH/
	Vvp89h0QCkL6/bQICiVly5LKXREJmVX8+6VQEsXPgpxuzKAmdGxyEQH0XYa/8VEh
	XH0iAg66bDZpLpmhiMLfC9s3fjx5vqk17p8NHHi4MvO8ik6oNbcVqD2h7Xr62snD
	SyV/tlQQDkWiQJdLYYhv8BTycMbRNEW1yX4UwrJHkUh1epiOH6caP8hMZ8PKjEuQ
	aEJWBE/oo5T69sQQrtS0ZIqTkLLDNvYsWjvFfjHddC+ZlBDfrFF2HQwQbF1aiw36
	01UIN2u/OrX+kcaNVTR5SH1Hjp/LOGIjZTQ==
X-ME-Sender: <xms:kYQJaaiy7tlD45Kku5sFUKkdJ2tYxjrjbJOc_U3bMRbfKA_p-BIgEg>
    <xme:kYQJaSDCMwXnLj-bYdHzZvXJvFsr5zgFq9Yq-jRoUk5oI1kLSdB2SpWMPx6TQUDiv
    IhdfHSw0v6Y2IaFlNqnJ8cEZo1W7gqVmkvIUXBj4s6zfCErcGkmZw>
X-ME-Received: <xmr:kYQJaXF13NojrNAMVWXvO0sdWAKElyXU4A_wd9jdfvYi0UznbOFMNx9RyoexkEo06FFD-Iau99Qm4JdLwVVdhvEq2a_PUIf0xwLB>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukedttdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghr
    thhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomh
X-ME-Proxy: <xmx:koQJaSKVrVy3J2JM9J6hAg4HxKXwSnLCsL15S2px9wuxYBXNQ2aTRw>
    <xmx:koQJaTlBfg4EhWVjsJ7kyyfUX_iIwCY6qvmsT2vMOBCvMziHC4UITQ>
    <xmx:koQJaSRJfXfSt6VElVTi4uYWrQwggr0hGqRb77Xgw-UVoLWOXIuOrg>
    <xmx:koQJadKPKZ0jTaqtArNCVizw-ohopRPECgh6vW2pNdmoQhhyQsG52Q>
    <xmx:koQJaelyjZt35CeWyCYqorcSFTJ7ojjB0oLqyXpdNyuL03dyZ1tKyfCT>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Nov 2025 23:44:01 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org,  karthik.188@gmail.com
Subject: Re: [RFC PATCH] diff: add option to report binary files in raw diffs
In-Reply-To: <xmqqa512sfcj.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	03 Nov 2025 18:26:20 -0800")
References: <20251104021455.379807-1-jltobler@gmail.com>
	<xmqqa512sfcj.fsf@gitster.g>
Date: Mon, 03 Nov 2025 20:44:00 -0800
Message-ID: <xmqqzf92quen.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Justin Tobler <jltobler@gmail.com> writes:
>
>> I have a usecase where I would like to know exactly which files in a
>> diff pair are considered binary by Git when computing diffs. When
>> computing patch diff output, Git already omits filepair diffs where at
>> least one side is considered binary and prints a "binary files differ"
>> message instead. From this message we cannot discern exactly which files
>> were considered binary by Git though.
>
> I have a usecase where I would like to know exactly which side of a
> diff filepair ends in an incomplete line in a concise format.
>
> Should we add yet another column to the raw output to indicate who
> is complete and who is incomplete?
>
> Where does it lead us and when will it stop?
>
> IOW, yuck ;-).

My point being that it will be a huge mistake to do this only by
singling a trait that is not so special as if it is very special,
only because you have been thinking about it too long (the "ends in
an incomplete line" trait is what has been on my mind for the past
few days, "this side is binary" may be what you've been thinking
about).  There are many other things people would want to learn
concisely in machine readable format, like "where did the file stop
using CRLF line endings and swithced to LF line endings", that are
equally plausible as the question you are asking, or the question I
would be asking "which commit lost the final newline?"

Perhaps an extensible command line option syntax like

    $ git log --raw-extended=binary,incomplete,crlf,...

is in order, and the presense of these options would add "tt,ic,cl"
somewhere in the output to signal that both sides are text, preimage
ends in an incomplete line but not postimage, and preimage uses crlf
but postimage uses lf, or something?

Extending beyond 2-way diff is still something we would need to
think about, I guess, but the only thing we need to do may be to
allow N-letter tuples instead of limiting ourselves to 2-letter
pairs, perhaps?

>> In this patch, the raw diff format is extended with a
>> `--report-binary-files` option to explicitly specify which files in the
>> diff pair were considered binary. The output in this form looks
>> something like this:
>>
>>         $ git diff-tree --abbrev=8 --report-binary-files HEAD~ HEAD
>>         :100644 100644 a1961526 e231acb1 bt M	foo
>>         :100644 100644 31eedd5c 402a70d7 bb M	bar
>>
>> With this format, there is a new column before the status that specifies
>> the binary status for each file. 'b' indicates binary and 't' is used
>> otherwise.
>
> How will would this extend beyond 2-way diffs, I wonder.  
> Should 
>
>     $ git show -c --report-binary <a merge>
>
> show [bt]{3} instead of [bt]{2} before the change status letter?
