Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC27F28ECEF
	for <git@vger.kernel.org>; Tue, 24 Jun 2025 13:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750771965; cv=none; b=krvgWTRH1JEV7m6W3KduJ+nx5rEys1ztMEcN42Ouz+AJt1gAB4N3IMCFXQPB/DfpHXTyCZDm6MAiGueEtFb+7mFny1vK+bPvtNnVkQjEY9GhBY6ZiervZazabkNn/OTd5BxvgfjXQCVER2xrc0NuhWqk4xVMBTlwbYs9HvEGaKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750771965; c=relaxed/simple;
	bh=rnM0F1hIJ5h8olmXA8No+wLSdLbHihqUstpgwuSV+Nc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=djgsUCDelbbf6hJD/LjytQRsVXmnsA+ndAqvTguQyuzutRPwnaU3KOVk79DRQHA6L7J0hz+85G6eBJphPeSP2i5pzL4Y3/RjIBksxLcGjiCJ/YqsnT9oynrzJSBybpMKb6Bdd019ZzYks2/KFGRX3NAvyh3ojKfS2BSvCt48fF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=pHwOMLoH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UA7qSyZM; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="pHwOMLoH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UA7qSyZM"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8B4817A0136;
	Tue, 24 Jun 2025 09:32:40 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Tue, 24 Jun 2025 09:32:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1750771960; x=1750858360; bh=FZopyggio7
	t12K5HWMYAPJ2dSO9+ozjK3JOF02/ijk0=; b=pHwOMLoHYPfQtADo/+AGKURLcQ
	ITT+yaiyM7oC697J6ZO0+S4qlVs3YMLWoJqQLvlqqnlZNJBOCIdByqu18H5T6XIK
	uXVS3pXHAmHmLKsxQMzsnJpIOVs9YUMv4WyL05WrkhIM7suPmetprnLYrmmTohjy
	ar+iy/8hc+pLTD2KNrDjyJFNfN3IXxYcSQffBOh6iGq1jJcNW9LkZ/REpiWc+B5d
	3UhJahI4QIN3diHRYvDO6Gol5S3o76oPtGx9aGb7Ok/j3j4d86hDit7+LEz4p/n2
	3e3hgzToxE85vIEAJ56ZpqSBHWGWfKD0xzg8QuIK9LqJmzVMKpfM7Ln6/iug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1750771960; x=1750858360; bh=FZopyggio7t12K5HWMYAPJ2dSO9+ozjK3JO
	F02/ijk0=; b=UA7qSyZMYIcpgqdP6B8BwBtnhBZAuNSJ7dOXLnJPSBsdPdvrguP
	WTiPY1e3UUwJ01h2cjZHsomQoyanHTadI7YzDAv2XH1V86MpOFKZJUoWNDSqWpHT
	cmS2RDWuGgkOAE40uD6TatvNpoq7Wgq5zvu4HbHm+V66eeum5Fuwl89YX6n22aHK
	dRx8gxEzuBG5smXHjl1n+k+XOHUQiZufdZSa7iiGVAcKh4Gd5Mh31VAyZuqHHHpw
	g6A8OC8esvOM6c8hkngAZksdcWQzNGGW1Wl+p9LXWl1VlfPaf5M/o4+jF5LggpBQ
	VZWADyHRl7i9JxPepX8vha0RkbrgdySQmCA==
X-ME-Sender: <xms:-KhaaPlhdTXajXoUjEF6NPL5A7buZfh3Jk3rHrEf2R1hHuW8hRlf3g>
    <xme:-KhaaC2JgsBjS_01iQKQ7cbvL6lcZZUcCcGWAjrL6iaTK0hr8pWyIdlteAHtxzFzv
    CEv9vawaMiNUOBrHg>
X-ME-Received: <xmr:-KhaaFour7GVWAwGymdJ4QPp9ZZX9Ar4Qeo5klq0WMrZBxTGuT9xVBr0gfAFuwcI9LQIOq_qDiyBY4mq56dP3-dTTDG9ugfn_PsP0xY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddvtddtvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopeihlhguhhhomhgvvdguvdesghhmrghilhdrtghomhdprh
    gtphhtthhopehkrghikhhophhonhgvnhesghhoohhglhgvrdgtohhmpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhm
X-ME-Proxy: <xmx:-KhaaHkEFxdIZMqSK3u8R0J8nPN7QxIA5eHqzVZYr4x5obrr0xjczQ>
    <xmx:-KhaaN1hoczH1QT5j10Fwp3TTkb56J7GnlrOip3XRORc1XPJKeKY-g>
    <xmx:-KhaaGvVRX0_Po4u4lOZ97FJyMh7pBEsX9SWxTr0bwHYRAGJU-UAXQ>
    <xmx:-KhaaBWSuw9bXiao5N1Grrtv6RwexcBIHjzB_2_geR-0I8tpv2XcPQ>
    <xmx:-KhaaGIcj1kdXylqbXFpjMhJ6vSYtDX_lO7-02rHWx1a7t9vyvwWMh0S>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Jun 2025 09:32:39 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Lidong Yan <yldhome2d2@gmail.com>
Cc: Kai Koponen <kaikoponen@google.com>,  git@vger.kernel.org
Subject: Re: Perf bug: rev-list w/ 2+ paths relatively slow with commit-graph
In-Reply-To: <E6A4C972-9675-47AE-B5CE-75103DB1D153@gmail.com> (Lidong Yan's
	message of "Tue, 24 Jun 2025 11:16:09 +0800")
References: <CADYQcGqaMC=4jgbmnF9Q11oC11jfrqyvH8EuiRRHytpMXd4wYA@mail.gmail.com>
	<xmqq8qli5jyi.fsf@gitster.g>
	<CADYQcGrR0mKLEWSYZCrL6b7NYLGfdsZsuKCCFQ_ptpMJ8mofmQ@mail.gmail.com>
	<xmqq34bq5g29.fsf@gitster.g>
	<E6A4C972-9675-47AE-B5CE-75103DB1D153@gmail.com>
Date: Tue, 24 Jun 2025 06:32:38 -0700
Message-ID: <xmqqo6ud2rk9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lidong Yan <yldhome2d2@gmail.com> writes:

>> It looks like that the necessary changes are probably fairly well
>> isolated to two functions, i.e., prepare_to_use_bloom_filter() and
>> forbid_bloom_filters().  Right now, for a pathspec that has one
>> element "dir/file", the code uses two bloom keys for "dir" and
>> "dir/file", but if we have "dir1/file1" as well, then it does look
>> like a matter of using two more (and the bloom_keys[] array is
>> designed to be variable length).
>
> I believe the issue here is that revs->bloom_keys[] represents an
> AND condition, whereas what we actually want is an OR.

Yeah, you're right. bloom.c:bloom_filter_contains() is called repeatedly
by check_maybe_different_in_bloom_filter() to see if all the bloom_keys[]
appear to judge if it is possible that the path is changed by the commit.

So if we wanted to extend in the way we discussed in the message you
are respoinding to, revs->bloom_keys[] needs to become an array of
bloom_keys[], one for each literal pathspec element, and then we can
extend check_maybe_different_in_bloom_filter() to run the current
logic for each literal pathspec element, and combine the results by
ORing them.  The way revision.c:release_revisions() releases the
bloom keys also need to be updated.
