Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30EF1F4611
	for <git@vger.kernel.org>; Sat, 31 Jan 2026 19:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769887526; cv=none; b=Zl6abRbzgjRoFw/EXu8HKTPPnLOSAavGo2D0EShwOqwbVue4QwaPBS38KToHohY6gbELf/+CA8WT7waN1J0X/b7CWR7C9eaEEZLti/k7xZ4iLuLJU9mz/YyXojWVeUpy5wNCWyqEkZZ7CPs1g6gLigApRSZigRybS8WdY/iwkU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769887526; c=relaxed/simple;
	bh=CwIiaMKQyENa71rp28eMiJQ3FIOIwnFjT+LSuHAWPU8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bUGX0HWCsMygPrmHvmwSPIyJLJld57O2FZEbl7Arz+LoxOfFhlmSj25SB2ZjvwZwhG5mNoFB4HOcaYjcm9vpszN3lw/aO+uHUHdC5fKYPhvMOulzOIrDOPSxYbSPt6eTacuYHqc1AqlAvoISD7BdOnkgVMIvyL5dDjK1W1YeH1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=jrfyvTs8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rkGwyh/1; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="jrfyvTs8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rkGwyh/1"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id AAC861D0006C;
	Sat, 31 Jan 2026 14:25:23 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Sat, 31 Jan 2026 14:25:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1769887523; x=1769973923; bh=+a+Xma67uZ
	aZ1ctASx7NU52iDWfdXoSoJjiLSKs4dno=; b=jrfyvTs8roplUPfWZicZM2NiRk
	dvhFWOLUgZQoT8onRK5wqvDCu+I6qorVJGf3KdNbMhS3Zllt7VntefElFxOOeC6R
	udakTjyK1zV5dMRXlvCZpRXO+ODgIxVcS3mjONUDlzJ5zf5crgreA16O3XLJ0fcs
	Z96XcOBDT+Dw9+LeETdRDqjE3PvKhWm7eNzSMWAIwXCh/G91SUJKmvKh5F3PXny6
	9sKdGEPS9I+B98qSavSc+3u30sYfJMxY0vlPB4z1Hk5r0n+L1IuV7yg52QhdlHAj
	xGIyDoq9oouEnKQ1Dt0QqmMxSoy4fYFDZbJC8GeySWtSM5I5Ymj8RkTm95Ng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1769887523; x=1769973923; bh=+a+Xma67uZaZ1ctASx7NU52iDWfdXoSoJji
	LSKs4dno=; b=rkGwyh/1UtKmKndkRN893sXo79/zeoLyYSDzqN3rJSfhP4Gd4zd
	uQ2DBEZkSxEgTZtPIRAZJfKNRIhz8Mz3dqcBImfiZE2g4HPp42OjzKOB+1sMoSwb
	BrQkPEs/22yuZZt42w2W+ewMrZItqJSHk8pVrg5kjiszpxezeSyUvVim4pl7AeM+
	pzDEVjuEcbMYaOc23KDYgn28bTRl11w8rjSrcrCf2/g5hrUMdmI+yHP0N+G3NZFd
	tZdwf7Ry6NCUGJIEVJyZl2DMpTrOa27wETUGpJAmeF9YE1W6qimD28CGNyNWCzLd
	BcvzICt/Qokcav387kP9hJEmDCAWEOT7CvA==
X-ME-Sender: <xms:I1d-aRllM-xUAPJgTzZa5Zd3qC5aza8np43xF0EtgEp7-pRlkPBMMg>
    <xme:I1d-afZhdtKIltrIxXnjCqulYqmsUBiEbNJNrJLy5--FHd1gIcT6ESUuaVxrmMjZi
    rT16Y-PdJr1iCLQMCrtR1UGPaMwwJq7BtB85mQ_402XGyfcxcJU2w>
X-ME-Received: <xmr:I1d-abSOUCLeHwPXLC1pL6l_W2oooXjxFKIvyt0ThdE_T_lqlbxD0jdaOxF54TBNv2jZttovwUTKxowqhvktet24KepeVzEZEw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddujedvjeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepledpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprggsrhgrhhgrmhgruggvkhhunhhlvgehtdesghhmrg
    hilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehphhhilhhlihhprdifohhoug
    duvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshiivgguvghrrdguvghvsehgmhgr
    ihhlrdgtohhmpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgr
    shhtmhgrihhlrdgtohhmpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:I1d-aRsw_68BXaOvR97Vwxw1sTZB05nphEX0Wh2xK89MExs4ircd9Q>
    <xmx:I1d-aVHtQ3kGwlMLzD7ep2hUL9Vi27nZxGIMC3ncSQd8v-_3NEVAFA>
    <xmx:I1d-aayHcL8cd0ypmr_kPJY9QkOXmuD6YHEFdJ8FO5gGY-FHA_PE3w>
    <xmx:I1d-aX1IZaAOrphBs9o5Gfc7zj-2f0rXvwDZhlZFU_lt5ffWHuSDOw>
    <xmx:I1d-aVhJ3VGmMnoScgg_DK6gxpTmYeUqtKvL9FXML_zbomTU0vESQd-e>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 31 Jan 2026 14:25:23 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Samuel Abraham <abrahamadekunle50@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Phillip Wood
 <phillip.wood123@gmail.com>,  SZEDER =?utf-8?Q?G=C3=A1bor?=
 <szeder.dev@gmail.com>,
  Christian Couder <christian.couder@gmail.com>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Ben Knoble <ben.knoble@gmail.com>
Subject: Re: [PATCH v2 1/1] Allow reworking with a file after deciding on
 all its hunks
In-Reply-To: <CADYq+fbt7zHO=gAsRp=b5MTb=2aFfifCjWnW6u+58iv4dk6bMQ@mail.gmail.com>
	(Samuel Abraham's message of "Fri, 30 Jan 2026 10:22:25 +0100")
References: <cover.1769522219.git.abrahamadekunle50@gmail.com>
	<9b21cb901ab14397af94b8ed2d09da1a9a6d862b.1769522219.git.abrahamadekunle50@gmail.com>
	<xmqq7bt2g4tl.fsf@gitster.g>
	<CADYq+fYeWh0tLEepOGVa=1i9tXZfWaGfyi6H+xUB7rbdQ=t5aQ@mail.gmail.com>
	<CADYq+fbt7zHO=gAsRp=b5MTb=2aFfifCjWnW6u+58iv4dk6bMQ@mail.gmail.com>
Date: Sat, 31 Jan 2026 11:25:21 -0800
Message-ID: <xmqqqzr54mam.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Samuel Abraham <abrahamadekunle50@gmail.com> writes:

>> What I observed after adding the '>' and '<' options is that if a user chooses
>> to use a hunk A in file 1, and then goes to file 2 with '>', comes back to
>> file 1 with '<', and decides on hunk A to skip it instead, because
>> patch_update_file() has
>> applied the file with the hunk the user initially decided to use
>> before proceeding to file
>> 2 with '>', coming back to redecide and say skip does not apply the
>> latest decision
>> and when you check the index, the file with the hunks which the user
>> initially decided to
>> use but changed to skip is present in the index.

I am not sure if I would like the end result or rather prefer your
"all-or-none", so please do not take this as "here is a better way
to implement it" suggestion.

But you should be able to keep the current semantics, if you wanted
to, even if you apply the chosen hunks when you switch files, like
the original code has been doing forever since it was written.  You
know which hunks you applied, so after applying before moving on to
the next file, you can drop these hunks from the list of hunks to be
decided for application.  When the user comes back to the current
file to decide on other hunks, you know that the already used hunks
would get in the way, so why keep them?

Having said that, I think the all-or-none mode may be handy if one
makes the current working tree dirty with many little unrelated and
insignificant changes and the only way to make sense is to see the
"git diff --cached" output after adding some and leaving others, at
least in the way some people work.  I usually am very incremental
when doing "git add -p", in that while using the command in one
terminal, I run "git diff --cached" to see if I added unwanted
things by mistake and "git diff" to see if I left out necessary
things, so I would probably not be using the mode.  But that is just
my hunch without using the new interface long enough.

Thanks.
