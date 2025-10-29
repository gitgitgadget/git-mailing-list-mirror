Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549D22D8DB1
	for <git@vger.kernel.org>; Wed, 29 Oct 2025 03:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761707166; cv=none; b=mCEVWKVUFe7JzaxA21CtZfBRw8cT8ajJZN4gvNDqpWSd8fCKWZCdefMaIxmkkZyfQK+eHaBNHX66vHTB5J2hctHcS8tmo4TwMiHNjszAQr6Fcf1Q1zlZgQ1xHlKZAp7fNNNqWHEIOmCL9WX+BfgWkoqk0oSds3vWmGH2eTQ1fKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761707166; c=relaxed/simple;
	bh=d6bCnSVp0wz4JdOm5gLeh2KNjOYCYRmAoBj8u85bYP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=inIUITXgcImhTOQoFP6TeKaUl8gIsi4k8xxBOzuSo/QwrjdjBUrsNTSI7yJTr8fPwtkjGR5J8a2f7kASEKTNkB/32eypz62MQ28kgKAW0VlLHKC53ZAEWleyAglVRKkG20XIizJsQw9zUQn5R5VOqwvATr6EUnwq/u102D+umno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=YMcjqjEM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pzKumXDf; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="YMcjqjEM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pzKumXDf"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 636E07A0177;
	Tue, 28 Oct 2025 23:06:01 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 28 Oct 2025 23:06:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1761707161;
	 x=1761793561; bh=15r9bVO/x3im2bfT/82lfAQxOiJHiFNN+9Fof5lQ1Ec=; b=
	YMcjqjEMoliD26ZdIHkGQkKjiME8xFAkhzbmFcnqNfTd7BP+zYtEa+EBa75HK1OC
	hTx8MS+YAvcZpEIDHsRUc1dK0lLebqPi2C9H0l/YjV04VsjWbei49CnK1zKw6dL5
	nviZD+kwMi+7iuXt9LBhpc8uka7i4VgsVdOgcwIzXVBLYv43l0zBCWpFoBv40sL9
	fRZXTQSwlSiE5Sf5ItYFnRE78vWDvsaYtgXMRpzj9AsYcYFxacBbY7lUjHbRW/s3
	RPTsnsnQQ1+dhz/9Q0hLShZ7uVyXV137cmgid7yEKjHesz7eMzMixQ6XxKPz0/8h
	hhavkrJoyg5g5mDtY8cMzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1761707161; x=
	1761793561; bh=15r9bVO/x3im2bfT/82lfAQxOiJHiFNN+9Fof5lQ1Ec=; b=p
	zKumXDfSXP8uyhuQd3VWnC7I42UC5XB2rMBH0srS0kRT2eQtFM+XFx6vKcEFBh5P
	2cn0GIMDrIBCDJvDSE0SJqgK7Egc5fj5sBxSy8R313fNb0LWMdIFyMwVkQyaXBdo
	QbnG+iN3EMf9DozIOOJqY49e/VMVduJ/L1MXkMI5uBwLweUEFowGf3WgsOGpa/UP
	y5j7aHQHnO9eShkP2FNlpv7NiTuTzmpy/eahGgfVjC1McNJvARSxayK6eRUT13TW
	6RBKJQYAf8p6PKIEnZpt9omysw4+6ogc9PXlOaGn7WKMKL6kS5WTfH9XyRUxcqmc
	AAJXcFwnGTXthiR1m2kbA==
X-ME-Sender: <xms:mIQBaUwJ7kZHvg_eurRCANpZRSr7JDEBBwXifZyKqAiz6Ov-8bpvvQ>
    <xme:mIQBafIj8aQEVTHatmyeq1y8guuBMg3YmMn45-up1XvX0pi2exQoqLkQhS2M2fU6y
    xlN2DY3i-UldBajhSOB7jku3k5iWRnlZ4WMT7fRzPbYPF5yH0eaLg>
X-ME-Received: <xmr:mIQBaepMIoOMjRAWMPXRsAyqG7dpJn3gxqa-c99R1zFP-l0VGeoedMxPImJ9SlWGUpcjkEJty8AVs_1sRWcV6fBrcNsJJgsKiw7mVqPv2lbb10sPfOEQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduiedviedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttddunecuhfhrohhmpefvohguugcu
    kghulhhlihhnghgvrhcuoehtmhiisehpohgsohigrdgtohhmqeenucggtffrrghtthgvrh
    hnpeeiteekheeihfdtffdugfeuvdefkeegieejvdfgjeefgfdvgfeugedvleeigfevffen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehtmhiise
    hpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepvggsih
    gvuggvrhhmseigmhhishhsihhonhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepfhhivhgvvdefuddttdefsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgv
    rdhnvght
X-ME-Proxy: <xmx:mIQBaeIlDgA8c9ukxSVGnAi157Kld3z_BDdz-qUltKQ7mzWUvdMBzA>
    <xmx:mIQBaTTqfNmFQdAQ2u8c0eNENgGiJU0mTSr0dfD1cTT-k4rtYNHuUA>
    <xmx:mIQBadvJhtidbmkzlUUfmPj_FH6Mhi9KaoHQqmvlBn_PTOB2mb2LoQ>
    <xmx:mIQBaUb826BE2nfqAL3Q-qzsQYc95EGqUnhzocDqjQgv9dxyCyekKQ>
    <xmx:mYQBabniUFDmYCTAuwqt7D_nss6p8e3_DMl8aK8q9poVJL9sV69uMIeQ>
Feedback-ID: ia13843cf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Oct 2025 23:06:00 -0400 (EDT)
Date: Tue, 28 Oct 2025 23:05:59 -0400
From: Todd Zullinger <tmz@pobox.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, git@vger.kernel.org,
	Kousik Sanagavarapu <five231003@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] t1016-compatObjectFormat: Really freeze time for
 reproduciblity
Message-ID: <aQGEl6Y-BaHsLphW@teonanacatl.net>
References: <ZoV8b2RvYxLOotSJ@teonanacatl.net>
 <Z8HVkqqD054QGPIE@teonanacatl.net>
 <xmqqbjlump3m.fsf@gitster.g>
 <87zf9c8glu.fsf@email.froward.int.ebiederm.org>
 <xmqqqzuoi6sg.fsf@gitster.g>
 <875xc02mmq.fsf@email.froward.int.ebiederm.org>
 <87o6ps16pj.fsf@email.froward.int.ebiederm.org>
 <xmqqms5chyr8.fsf@gitster.g>
 <87frb310d2.fsf_-_@email.froward.int.ebiederm.org>
 <xmqqv7jzc5hw.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqv7jzc5hw.fsf@gitster.g>

Junio C Hamano wrote:
> "Eric W. Biederman" <ebiederm@xmission.com> writes:
> 
>> By default gpg still allows time to move forward with --faked-system-time.
>> So in those rare instances when the system is heavily loaded an gpg runs

s/an/&d/

>> slower than other times, signatures over the exact same data differ
>> due to timestamps with a minuscule difference.
>>
>> Reading through the gpg documentation with a close eye, time can be
>> frozen by including an exclamation point at the end of the argument to
>> --faked-system-time.
>> ...
>>  t/t1016-compatObjectFormat.sh | 6 ++++++
>>  t/t1016/gpg                   | 2 +-
>>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> Geez, how are we expected to find the need for '!' ourselves X-<.
> 
> Thanks for root causing the issue so quickly once it was raised.

I'll second that.  Nicely sleuthed and explained.

It explains why I had trouble that I thought looked like gpg
wasn't setting the time as expected, long before the code
change which caused the custom gpg wrapper to not be used by
all the tests.

Back then, I went so far as to run the whole test suite with
the gpg wrapper setting --faked-system-time, but I didn't
notice the crucial lack of an exclamation point on the time
either.

I applied this and Junio's previous patch to ensure the
wrapper is always used on top of 2.51.2¹ and ran it through
the Fedora build system where I consistently saw failures
before.  With this patch it all worked as expected.

¹ It's much easier for me to test a released tarball with
  the existing Fedora packaging than a snapshot of next;
  even though I know it's of *slightly* less value than
  testing the tip of next or seen.

Thanks!

-- 
Todd
