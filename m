Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3331714B7
	for <git@vger.kernel.org>; Mon, 16 Dec 2024 16:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734366372; cv=none; b=JJOCIVsJjQ64we34NGT3Yu8w9lvGq8b6qjI8MeCpR7MaLV29W25A+/CdDcFZbe9VdML5OgzpOR3t/jF7l3jejUhToaXIFl5YB9mPC231RjsQb8xmstfCEGxt4S+QqidV/elORSc4cVTiRSfcKswsNq3KY7bPDuLTQ60SxKWLfBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734366372; c=relaxed/simple;
	bh=M8WCxUey5k1hdVsepZ0/2uCR4ndhqt5ofCYXmgsAH5I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rwPLy68fTdkYtnHTSbUVYFgo3qHxLxXCLZl9a6p9iS9Te8qHl+M4fgvVtH5ORYtA17BEnhAxuNvk1o8pOeec4veaJIb03Ls8YOOq4TUFBM7AsXyNSJF4xiJVsfpJEV+pzQtEzALZIl+28iS34NbA/7sOlR3YH/7oTCvgY/sC4So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=CdKqOYQ9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oiQbf/N7; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="CdKqOYQ9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oiQbf/N7"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id E88871383FFF;
	Mon, 16 Dec 2024 11:26:09 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Mon, 16 Dec 2024 11:26:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1734366369; x=1734452769; bh=k8N2DvwzfI
	OHORWf6TY/hPpCblicBdSln3SNnOtFjXU=; b=CdKqOYQ9jFgOAiKjWPFfecLS+y
	O8E29e5uTQhNn88v6/Bwc5Mj8A9FBiyePM9Al/LRV5i6gMJ10aMF7gZLhWM0CdXl
	/3P5Xvy31bC4ikLBcPg70IjwgdbNYHurjjsZeEll7QCWIRM5nukk0TkwD7KKmhgk
	WfiK2CAF/5EIQvKGkGIWu9/ZL2/+Rr6NRgFjYjePlgkcibBal7n90mHCFOay9WpB
	xh4PkKphOInCtfso3/x9GnFbPIDJxsYNAnauPsiLq5dQnU5pBKJu1b6HAMybKCGp
	SQKlNNnHVQ5raiU0m1qmcXWPHmDwDaAt3xwSM9wq7tgVgMPnifftFZw+aB4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1734366369; x=1734452769; bh=k8N2DvwzfIOHORWf6TY/hPpCblicBdSln3S
	NnOtFjXU=; b=oiQbf/N7FZFg4M3nsLNNJ++Ix3STcyPsokHlFPOIBZ696iQAlfm
	awe5BQWGmm8GIdlrPNWhlhSXcOFI7OYY46BtumWIDr5SVx6fn8EekCrkBfi5s5/q
	gkfms56rmqwtF5+2oBxgD9dkzY+vylgcnIhPzZlhBSV/tzammROfRA2rdQ7WMhmE
	JNIa/eL4PQGQqhVV2xqODkVozBlJ1ZIZmHNki0JPWQR6xFP6SlCBfVYglKLn8Z3w
	CwNaouJecYaHPeFRhlyo80aUJAwYu/GmvZpNy4wJgmVlhXmJhqxryKuoSMvILfv6
	1neGWeI3CjxLhhf5vrQKbLR02fmrpTJU12w==
X-ME-Sender: <xms:oVRgZ6MBbInQ1kzxoIJAc4IYxmZBcGyQqweeY4p7gSHBZ1-7k1b9TA>
    <xme:oVRgZ49Ar7AXqAn9bbjyvXc7FeU8wkE5Y9_9eA-KcEBhWz0gkI47TiE_GMNcngUJa
    77eZoG_Bwq6TYM7KQ>
X-ME-Received: <xmr:oVRgZxRP0ytBeTTsGJumc4o_3bMpEV_U7e1KzwI__NXYzOVi7uavIfh9f53TKSQYQ5fUraitqnMcZHCqqrFeHcCnnU02ilkEpvC3aIk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrleefgdekjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenogfuuhhsphgvtghtffhomhgrihhnucdlgeelmdenucfjughrpefh
    vfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrg
    hmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhn
    peegieethfdtgefhheelkefhfeegfeehudeghfeiheffiefgjeehteevleevgfejveenuc
    ffohhmrghinhepmhgrkhdruggvvhdpfihorhguphhrvghsshdrtghomhdpshgrhihsrdgr
    shenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohig
    rdgtohhm
X-ME-Proxy: <xmx:oVRgZ6sPWAVnL06EsjZT5B04mjj1yMzYpSBuxZSkWofT-9XuutDlwg>
    <xmx:oVRgZycSelx0P_cp5NXshR4jhzGS5sSobtxPKK5KCV0SAP5HcxxZ-w>
    <xmx:oVRgZ-1gIxtoxezTa14aDpvTBbRCf_2mZs5LH7mI8QCeoBUOdRqb5w>
    <xmx:oVRgZ2_EPqr20yZ5vLcYUQWA8JAWfsOtLjueSyXlFAsVKY01EgrN2w>
    <xmx:oVRgZy4XrJM3LGQgGOeKovvMyeayJrPy4ORZqbkhlt9hYn6xQxBc_W0K>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Dec 2024 11:26:09 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Dec 2024, #05; Thu, 12)
In-Reply-To: <Z1_gqiCuTZOdRVO0@pks.im> (Patrick Steinhardt's message of "Mon,
	16 Dec 2024 09:11:22 +0100")
References: <xmqq8qslf5h1.fsf@gitster.g> <Z1_gqiCuTZOdRVO0@pks.im>
Date: Mon, 16 Dec 2024 08:26:08 -0800
Message-ID: <xmqqed277fxb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Thu, Dec 12, 2024 at 09:31:06PM +0900, Junio C Hamano wrote:
>> * ps/build-sign-compare (2024-12-06) 16 commits
>>  - t/helper: don't depend on implicit wraparound
>>  - scalar: address -Wsign-compare warnings
>>  - builtin/patch-id: fix type of `get_one_patchid()`
>>  - builtin/blame: fix type of `length` variable when emitting object ID
>>  - gpg-interface: address -Wsign-comparison warnings
>>  - daemon: fix type of `max_connections`
>>  - daemon: fix loops that have mismatching integer types
>>  - global: trivial conversions to fix `-Wsign-compare` warnings
>>  - pkt-line: fix -Wsign-compare warning on 32 bit platform
>>  - csum-file: fix -Wsign-compare warning on 32-bit platform
>>  - diff.h: fix index used to loop through unsigned integer
>>  - config.mak.dev: drop `-Wno-sign-compare`
>>  - global: mark code units that generate warnings with `-Wsign-compare`
>>  - compat/win32: fix -Wsign-compare warning in "wWinMain()"
>>  - compat/regex: explicitly ignore "-Wsign-compare" warnings
>>  - git-compat-util: introduce macros to disable "-Wsign-compare" warnings
>> 
>>  Start working to make the codebase buildable with -Wsign-compare.
>> 
>>  Will merge to 'next'?
>>  source: <20241206-pks-sign-compare-v4-0-0344c6dfb219@pks.im>
>
> I think this series should be ready to go, yes.

OK, let me mark it for 'next', then.  BTW, I found
https://staticthinking.wordpress.com/2023/07/25/wsign-compare-is-garbage/
amusing ;-).

>> * ps/send-pack-unhide-error-in-atomic-push (2024-11-14) 2 commits
>>  - transport: don't ignore git-receive-pack(1) exit code on atomic push
>>  - t5504: modernize test by moving heredocs into test bodies
>> 
>>  "git push --atomic --porcelain" used to ignore failures from the
>>  other side, losing the error status from the child process, which
>>  has been corrected.
>> 
>>  Needs review.
>>  source: <20241113-pks-push-atomic-respect-exit-code-v1-0-7965f01e7f4e@pks.im>
>
> There was a newer version of this series again sent by Jiang Xin. I'll
> try to have a look today.

Thanks.  I do not particularly like "competing" parallel topics that
do not talk much with each other, so I wanted to take a look at the
other one, too, to see why these two are not good enough.

>> * ds/path-walk-1 (2024-12-07) 7 commits
>>  - path-walk: reorder object visits
>>  - path-walk: mark trees and blobs as UNINTERESTING
>>  - path-walk: visit tags and cached objects
>>  - path-walk: allow consumer to specify object types
>>  - t6601: add helper for testing path-walk API
>>  - test-lib-functions: add test_cmp_sorted
>>  - path-walk: introduce an object walk by path
>>  (this branch is used by ds/backfill.)
>> 
>>  Introduce a new API to visit objects in batches based on a common
>>  path, or by type.
>> 
>>  Will merge to 'next'?
>>  source: <pull.1818.v3.git.1733514358.gitgitgadget@gmail.com>
>
> I was a bit late to the party, but have sent a couple of review comments
> to the mailing list late last week that Derrick may want to address.

Yup, I saw your comments.  Let's hear what Derrick says.

>> * as/show-index-uninitialized-hash (2024-11-11) 2 commits
>>  - t5300: add test for 'show-index --object-format'
>>  - show-index: fix uninitialized hash function
>> 
>>  Regression fix for 'show-index' when run outside of a repository.
>> 
>>  Comments?
>>  source: <20241109092739.14276-1-abhijeet.nkt@gmail.com>
>
> I've just had a look at it, looks good to me.

Thanks.  This was fairly straight-forward and looked good to me,
too.  Marked for 'next'.

Thanks.


