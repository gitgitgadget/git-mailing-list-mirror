Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16463DBD5E
	for <git@vger.kernel.org>; Tue, 24 Mar 2026 16:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774370360; cv=none; b=bzAXESfvo0aIWrDDgdFuQs32XG9jGeZNVz+BHg6OlSYB0ru1y7K/Ar9NyfR4XSFkZRYIMeTxXhoXXaj0/Sfl/dgGkA5ce6gdpKz7+X27oTfjLdlDTT7I3WNBDk8dqyq4RpGV8b7kXSyHaJppFGh3yUd3slsyWtKMr7hgelnkH1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774370360; c=relaxed/simple;
	bh=3+f/doCrlEDgeWGXwIsNvNzTWdkVs6dKw6VhUQn19vE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=exa/pEz16aiPT8coms9JwpjBowOtd4Gv4cERzVmhXSjtNXbwqE/OtywZfBC7UROkxmCvNZk0CFkU0QhQRVsa2AeLDWGhpGeuXfFBLdfKmTJAy4JSkLVt6dbzaq4axOVecyj6DrQ7FOiiups4bzbzjhFO5tDo0NQeHb4g77OP1Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=F7aIQ+iv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gP0JZkDC; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="F7aIQ+iv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gP0JZkDC"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 25F16EC0208;
	Tue, 24 Mar 2026 12:39:18 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Tue, 24 Mar 2026 12:39:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1774370358; x=1774456758; bh=wNGYP9RFD8
	jICvUQPkIPLNPPInXzIjgaV+N+aMzk3cQ=; b=F7aIQ+ivcGZCM9Nmf9NPivEY0Z
	wW/izaPj4NPCUGiDeVbNTPLyNg5cJW5a/RXNWGXgZX/td0lPjPW1vHgCWJvqJ1Kx
	j+KxTf7xYS9J/ILGgFZgiEb8tt7O1nl9RtSo1Zqn+DmtGSIV2OdNZO9LRtEDAHR3
	S1l1bPvWLSYWsrUwESh/3NJdpW1CEJEH8ev1AZt23TH4MjMLO6bmG3ahT282zUq0
	k6Ts3OVa0+ZZ/1Uxq0JOYW/W6HS60DmkgB8Q++8Wz7uRFTrg3UUZE2jiXFBiXEWP
	XYn9ZSB1iawwv2lVfcCUl0oM0cGEH+Ol4/I/zpilerJMH/RJoPCuzgDLFv3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774370358; x=1774456758; bh=wNGYP9RFD8jICvUQPkIPLNPPInXzIjgaV+N
	+aMzk3cQ=; b=gP0JZkDCCPHxxLeWW505sNCYWE+OMufJMjSPc3WxqmD+7pcQFLK
	ESW6eIJiXGMSv2wxC611Fu9xwTLoRaO4ysyHSnimBYn8uXVG3s/2wPpsAqbg6+Kt
	C0pINK70A34dI+zECxJTPameXhTIpvv8Jg7jL1/S3R0IYoDv5TWk/aj8za9Uls4R
	4HPkiZfIrmmnhLhVEK8Jg7WiZ3hnG3uXluWqfQGfStfLNR2y2Qod6bh62K7CBXp/
	GYAGcVRNW6EpPotFiOHcun4husLBgaX/rhBAohzzeTfD4FemTZkl10FeUiYF8cAo
	my+Qz8jLo7y5d841ANxJe+BdspFL2x1u4qg==
X-ME-Sender: <xms:Nb7CaY2Eb8fr7Pl6a4j6yeCwU0t2sU-4EtA7PPYhm-oC6pELZmbnhA>
    <xme:Nb7CaaHevPZJc2nlUOcgM87eRDlb6JVe0ctXgBWcTYfISyOY4_75zDhKQTMH7JDdO
    4OMoRmY_TKLBw7oLabTZw4tVOe5HlYh5K_qOH6iy4t4LgDLx3A5>
X-ME-Received: <xmr:Nb7CaV5-xQY8FeWOn9NLN9Td6Z7awwoVwbBDPH8O3E-RpPHYnu0OckzAhLoG9aCVDSrQvePyTVGGrUQ_Wyv4b_vHzrzk6sB2zw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvddvtdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepmhhrohhikhesuggvlhgrhigvugdrshhprggtvgdprh
    gtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:Nb7CaQtQZy1plxkxQb8Fe1kxwihn8D1f3bF9JZjJXcXLDhy0Exn3mg>
    <xmx:Nb7CaW4sTCj4_hiPVOi91zwg77pOT4cJ8W2D8kLiXKzCltzbBIZp_w>
    <xmx:Nb7CabUMWEDgYLUuslCAVljQLXFu97B9wdd4lkKGrerUyqHdzy47kg>
    <xmx:Nb7CaY8ar7VMKEwAOHrr6vCyA7OV05j5i5S6FKZpn8SJqRPhCO3H8w>
    <xmx:Nr7CaW_UPOfDlhgkuNNDskLqxJbS3Fk_9zpK0KLpiokN80QEspIXLFvL>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Mar 2026 12:39:17 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Mirko Faina <mroik@delayed.space>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org
Subject: Re: [PATCH] t4014: fix call to `test_expect_success ()`
In-Reply-To: <acKx6yBi-BWUVJcv@exploit> (Mirko Faina's message of "Tue, 24 Mar
	2026 16:48:35 +0100")
References: <20260324-b4-pks-t4014-fix-test-execution-v1-1-ac83c1bcc828@pks.im>
	<acKqvI0EhaORjoD7@exploit> <xmqq5x6l2q5y.fsf@gitster.g>
	<acKx6yBi-BWUVJcv@exploit>
Date: Tue, 24 Mar 2026 09:39:16 -0700
Message-ID: <xmqqo6kd18sr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mirko Faina <mroik@delayed.space> writes:

> On Tue, Mar 24, 2026 at 08:38:49AM -0700, Junio C Hamano wrote:
>> Could either of you remind us why "make test" did not catch this?
>
> My bad. At the time when I ran it I simply saw no failing tests and
> assumed everything worked fine. Next time I'll check that the actual
> name of the test is present in the output.

No, I wasn't complaining a human tester not running tests.

I was wondering if we can make the test framework better so that a
misspelt test_expect_success would cause a louder failure than what
we have now, which is something like:

	...
        ok 5 - check hash-object

        t0002-gitfile.sh: line 46: test_expect_successo: command not found
        expecting success of 0002.6 'check update-index':
                test_path_is_missing "$REAL/index" &&
                rm -f "$REAL/objects/$(objpath $SHA)" &&
                git update-index --add bar &&
                test_path_is_file "$REAL/index" &&
                test_path_is_file "$REAL/objects/$(objpath $SHA)"

        ok 6 - check update-index
        ...
        expecting success of 0002.13 'enter_repo strict mode':
                head=$(git -C enter_repo rev-parse HEAD) &&
                ...
                test_cmp expected actual

        ok 13 - enter_repo strict mode

        # passed all 13 test(s)
        1..13

when I corrupt the 6th test of a random script.

        diff --git i/t/t0002-gitfile.sh w/t/t0002-gitfile.sh
        index dfbcdddbcc..d65f664914 100755
        --- i/t/t0002-gitfile.sh
        +++ w/t/t0002-gitfile.sh
        @@ -43,7 +43,7 @@ test_expect_success 'check hash-object' '
                test_path_is_file "$REAL/objects/$(objpath $SHA)"
         '

        -test_expect_success 'check cat-file' '
        +test_expect_successo 'check cat-file' '
                git cat-file blob $SHA >actual &&
                test_cmp bar actual
         '

There is no indication of something bad happened, other than
"command not found" and 13 tests passed instead of 14 the script
has, which nobody knows.

So, no, it hardly is your fault.

I wonder if the test framework is safe to run with "set -e".
