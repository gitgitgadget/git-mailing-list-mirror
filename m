Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7BFD86329
	for <git@vger.kernel.org>; Mon,  1 Jun 2026 00:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780274450; cv=none; b=mk3pFGl1r2B5F1lzXr982VxTtE+qA/vg97PiVRtcOEovCVHbFsvZ+b9i+W9kGlDcYEUrh9UUj+y4gWB/ZjQVR12Y2IfOcjAoVe8PWE575M1GhaPKJEkyFbqcAxG0QprgoHyqsGSM0ytGV2pDjRD3uHPNljpwX3me/3qyfMS9RcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780274450; c=relaxed/simple;
	bh=QVlgGpC0LBF7HzVrNimIMLapljqt2OS/7XAWYOAAQsE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Cv5ZJN7sspqBCNnLcaXnl7gpFumJyVeFe6eKmIwJn2licWh+e8WwwYXI0FoCBqGydus5RFTl/mR0H2arsQ9D7egHuGgnA9mKg5Y2LQQIF0jrVI8mpl6mx8BBIMpAWXkUEgsLb24WAIiOyKBQNfl23Q4nfm2gCdonwXWdDIXbQI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=IVCaC21j; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aCoUxtny; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="IVCaC21j";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aCoUxtny"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 511C77A0086;
	Sun, 31 May 2026 20:40:47 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Sun, 31 May 2026 20:40:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1780274447; x=1780360847; bh=x2aCoi0O38
	B4ji7hn+sBrAgbi2K/+2aPJKiEiMbV4Ok=; b=IVCaC21jADgtMjyrG6KFnie/KC
	z3upsXpNRrAC1NfW790GOosh2+niTk9aMgiyYwVXMIiChpIXwTAb9ZPFB8L0DQ/k
	lUmU7nCW5w+G/6OhbieyjU/6IRt6eV67L0LMFs+RDfkugsVA5y8pdhmmWLbQ768o
	4wjGWo/NISZvAIr5rZTkUlb6iVKufxfB60h1DZVolwC+4NoheOIEAkgjvK4NO8vK
	hGSuuTaAQOrHHf5gX0zh9f2FHzGV+m9VsZnpA1QYDkVpaB69h/IZ9L2OGHS6fq4v
	KqizUE9TWOKzvesLHUXUCZJedw/JPx/KKwAXMRP6JIW0z6qblJoUA8jSiBoA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1780274447; x=1780360847; bh=x2aCoi0O38B4ji7hn+sBrAgbi2K/+2aPJKi
	EiMbV4Ok=; b=aCoUxtnyHY5i7u5neO7cRukTEKQHDu80Wm0B7Xnjo9LLw2Vxlik
	0tFT4ETHBwecKPOZwuVeFPth+8xmNIMGDaP/CA/LAxQSsWpNePki/kMkr/KNvl+C
	yXd/4tDvhMzOvERmbnzI8xj0oA7Wzt/I932VxtHox8fsNDjT26H6i+capSI9bPSD
	VDNUQ1II6WGNSBBbeLEybcTgdAKgji0nCBjIsbWfLtIfxYVvOai/aI0SLnDs34ZN
	koMPYj4mfaaDQv5Ux7G13d3EBVXrFd/bHpZP8QedXVev6N72fmBPpfpacupJVcsb
	pxYOfsx6yIoogzXCwYaa3+I+xb8ea4CExyg==
X-ME-Sender: <xms:DtUcajN3oBwGJoX5ZVRBOVsw6SEKu9ZnOxPDACx144osf2dWgGabUA>
    <xme:DtUcak15m5O0kcDmC2sHZ_6H0aCtYc84xnZq_lPpToC9F33nktyrEePWBRcsGJzUP
    D2V-HGJbWNI6UlV-48qCsXnYPlFvdk1VM5jhwlt4bHHGGIiHUg>
X-ME-Received: <xmr:DtUcaqlmPMRXEWUQp3EKq8XiPFwR5HGdHJsR8b7cKdF1VNCESqJyz9NJEbfrgASevRlTjKP0nHuKIwQgx8d0VtVZslexgKAfzIMr>
X-ME-Proxy-Cause: dmFkZTF/BmBhnNyBPgk+mFDolZkW/wYtNJ+kmd6G9lWiwDAHceiS7NhAZTL9tXNwy75vdv
    mHuJCPsQ4N7cyPUq6KGAwhRHztyxl4+rT3vZytILuXevjPSO06e4IiDpTsDqO5IwE1SC/l
    r9NtEbUNX6Nsr4pA1IsfyE2sm/gCJZQ9IfG/rv1x+p5mtrWYB+aSXsgxEMiSQAD8Zxsi5G
    AuEONOQsQvKyhXUHoPQXjOCtfD4oxYTy3JgjHmhDwrRVsDAHfToBKyQV5NWdKqLqy/vmux
    Kx2E3BqSQ3YqKROoHBTcMOQzWlmJZC45tqlp1pB97JVtq3d5gaA82OfrrCsHbq1C19I2iR
    eXypvaVXAISk8x69fXUd+dmZ3Q0D9WutD7zMIKYLXjss2Ei6iQc6QqRYafCQ43FByn3o3E
    u87JhiY2qcP/jMxh1wiuIlbU86eVlSYGsZNhw8L4skJXHyOs8CWb52akqoAVaouAAyaJju
    z4yXa9NIF+ihfp3VhRlmbip+FR2vYboW+mMkyhP8cwaQcQVkYHhsXWP5ExK9GxaGs9IUTL
    m5yOE/KZOM7m6inhZHTCzipJe4HmUOeN9JFcvwFPITaMn2aWPKN/f/GYX1a73i2SR1riXf
    CEtsLFwhrb7JyVRMqovBrCxJWaLoPsPGfafT5sxEHBdxCBJoeQbl1i897EhA
X-ME-Proxy: <xmx:DtUcajW2YInsrBEwgcRwP3F9N8tTB79wFSivVKVEWyZcwjZFutxjeQ>
    <xmx:DtUcaovv0oUmLe2qDOE8FEgl-U8YbKwmnX5ky7RbeTI8NCaUAw9xyw>
    <xmx:DtUcauY5J-DwWTGWfrhfq6UsgjXKCsIqJgasBO8uWpTU6toPA9Cylg>
    <xmx:DtUcavWS-dhkNBNEc7xOrP23l0ro52dnu6yeZk45Fi7KWrZvpybOyg>
    <xmx:D9Ucatbw7X7zZ09mD0WC9i09chkOXBvBwi9FkGtnUC1cEtQHRWyvrr0m>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 31 May 2026 20:40:46 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Tuomas Ahola <taahol@utu.fi>
Cc: Jacob Keller <jacob.e.keller@intel.com>,  <git@vger.kernel.org>,  Jacob
 Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH] describe: fix --exclude, --match with --contains and --all
In-Reply-To: <20260531234644.97LRl%taahol@utu.fi> (Tuomas Ahola's message of
	"Mon, 1 Jun 2026 02:46:44 +0300")
References: <20260528232950.187002-2-jacob.e.keller@intel.com>
	<xmqqo6hwcves.fsf@gitster.g> <20260531234644.97LRl%taahol@utu.fi>
Date: Mon, 01 Jun 2026 09:40:45 +0900
Message-ID: <xmqq33z7ay9e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tuomas Ahola <taahol@utu.fi> writes:

> Junio C Hamano <gitster@pobox.com> wrote:
>
>> It is curious that this fails in some but not all CI jobs, and even
>> more curious that these failures look the same.
>> 
>> e.g., https://github.com/git/git/actions/runs/26671595367/job/78615760984#step:4:1984
>> 
>>   +++ diff -u expect actual
>>   --- expect	2026-05-30 02:21:23
>>   +++ actual	2026-05-30 02:21:23
>>   @@ -1 +1 @@
>>   -branch_A
>>   +remotes/origin/remote_branch_A
>>   error: last command exited with $?=1
>>   not ok 70 - describe --contains --all --exclude
>>   #	
>>   #		echo "branch_A" >expect &&
>>   #		tagged_commit=$(git rev-parse "refs/tags/A^0") &&
>>   #		git describe --contains --all --exclude="A" --exclude="c" --exclude="test*" $tagged_commit >actual &&
>>   #		test_cmp expect actual
>> 
>> Rings any bell?
>
> That's way out of my wheelhouse but this seems to fix the failure
> for Alpine at least:
>
> -----8<-----
>
> diff --git a/builtin/name-rev.c b/builtin/name-rev.c
> index d6594ada53..1776ffab46 100644
> --- a/builtin/name-rev.c
> +++ b/builtin/name-rev.c
> @@ -416,7 +416,7 @@ static void name_tips(struct mem_pool *string_pool)
>  	 * Try to set better names first, so that worse ones spread
>  	 * less.
>  	 */
> -	QSORT(tip_table.table, tip_table.nr, cmp_by_tag_and_age);
> +	STABLE_QSORT(tip_table.table, tip_table.nr, cmp_by_tag_and_age);
>  	for (i = 0; i < tip_table.nr; i++) {
>  		struct tip_table_entry *e = &tip_table.table[i];
>  		if (e->commit) {

Ah, OK, when the test has multiple candidates with the same score,
of course emitting any one of them as the answer is a valid and
correctly working program.

So switching to stable-qsort here may "fix" the test breakage, but
it makes the real-world use cases worse, doesn't it?  When any one
of the solutions with the same "goodness" is acceptable, the change
makes the code behave as if the elements in the table before they
are sorted have an "if same score, earlier the better" kind of
relationship between them.

I would have preferred to see a tweak on the test side to avoid
having more than one answer of the same goodness, or perhaps list
all the possible acceptable answers and instead of using test_cmp to
check for the exact answer, take any of the acceptable ones, or
something like that.

Thanks.

