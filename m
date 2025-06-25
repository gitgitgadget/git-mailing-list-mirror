Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B58F27F747
	for <git@vger.kernel.org>; Wed, 25 Jun 2025 16:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750870173; cv=none; b=BVFxiXHBAm8AWLUS6QnEtIPkqfdIugnK8/p1kp4kpugIaaIXCqHQuEog9333FsXIrPEoZ1E2mTebQF5JqMPyAxv3Iu+QIW7eD3ehTtERv4693IuzOUIedH/j61gacWNo8KHXbMLjh/9Rmpu1t5gldqWJc1bLbfsb25THgBOjUvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750870173; c=relaxed/simple;
	bh=SWAYsHSqhCpYRtzuGhjEJ3G0qukrvG/UJkEFR+EbMPo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ddJyxQqoOVPLo8VQK3kbsEha3bjpdrcGZlbhNXLu6W71oIv42qZrb1iKHeJuAUSUyo6ZvK5Nv9oZGh6MBJLfJLr56dssQj4zdSIcM/BagZaJfbEtQX/94pLqPGvdz3JHecnyAJkwunu+IiHpWoLOgsiGXp3VmMMEDWzITMSAZ3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=k9KeJQa4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iYaQU0BP; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="k9KeJQa4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iYaQU0BP"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 809EF14000FC;
	Wed, 25 Jun 2025 12:49:30 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Wed, 25 Jun 2025 12:49:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1750870170; x=1750956570; bh=DInq70hh/G
	opTLpUQW4v7k01uyrVQJEqThvi2EETGAQ=; b=k9KeJQa4XUxL5rHi/7ZBJCbQP5
	DP8VXv44Ss/V4VWinexQtG9npojUiq8Eo/kHXoaKfvTbNTz7bEk4maCJCL2Ag4OX
	HDsuVgh/GFidbMGqd0d7IL8/4yWH/yt88Gg9L6lL1vYtCQGyphq7HQMayycgRmOH
	ij3BVT3xW18CebaohIra/tjm7fpGPsU/LFmwg5Z6gkFBbNSUpbVa5Y2tUNCvYQai
	thEr2f6pt0xiTseSBxbQwW/A9bJArlehIHRqjWaOMykVEm4ebfggO9Rt71jjKfkD
	EyVwsBkKVxOXI8qVipRFRn+gB/XEg3zVHHSzki4pR1PAQNzEt7AmHe2jMVHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1750870170; x=1750956570; bh=DInq70hh/GopTLpUQW4v7k01uyrVQJEqThv
	i2EETGAQ=; b=iYaQU0BPF50bDvWWCyhvSkYAu7pBq4IqRAUVDHSyB2uCCNzb1RU
	S95xGq/RJPKfoq4fJ9RRK+7NPqdRIGIuxwm4k25aDF1p4q0DTiWg7H5AMRsaXV+P
	VtjXutxMudCsHK77ebtDHSwjCkIjRlgfmHW16SpAEx3Nw7bM/B33coO1tlc52E/b
	XDFFuIEl1+rUmaENYRIXdUWl2Qiw74rUP+R+IK6w4NePjrqv7ylt2GUAcVo14tId
	TP27IniM8CHW5o+/8LPRevyO98+XrcT28vIwzEGGA98U5uyO3YAnKCNEEbqmBgTi
	n1O7kcdLv/59BeL8hrC5paUQfjPANap6eRg==
X-ME-Sender: <xms:mihcaDYH-SSe7WNl-bEha5gEs_SRftKtoHsb2w8onZtWQjM3Tpt3lw>
    <xme:mihcaCayQDwX0AW76OnEl0MpIyrs4x-3uvKyE-CAROcWDb293_8NjHZ7Yh0FvexXu
    b4YHZnEAwfNXnFcig>
X-ME-Received: <xmr:mihcaF9WAu6t8oFOBJpwnl0kYBdpm_lN4SQyh7BFFNuV8TpdZdTC7prjhpKvd7SMgJMI5JterEi--_8uIaNOPEqN0vKdLPF8wzAmQjY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddvfedvlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehmrgigihhmsehguhhigihothhitgdrtghoohhppdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehstghh
    figrsgeslhhinhhugidqmheikehkrdhorhhgpdhrtghpthhtohepshgrnhgurghlshestg
    hruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepghhithhsthgvrhes
    phhosghogidrtghomh
X-ME-Proxy: <xmx:mihcaJqMD7cASax6hgkKHcTaqEnhTOwgvmZaD1V8Ojx7JrVoClpgrQ>
    <xmx:mihcaOr9LFC7LyMuQ-PAPjvCxg_rwHWgRGBw3ldvlPlVsrH_I0EQDA>
    <xmx:mihcaPT05g9X8QKd9rEKOKNCh-GHoAEGp7YZ5VOBhoE4nopBim75MA>
    <xmx:mihcaGoV9yA5xZKpQ_RRNLobOrtlpS3xtKri94zF2BCns-761cs0nQ>
    <xmx:mihcaP3oUV-Ahq2xF605k8cnqGTpxxylZsDGSCsOJrubhS3kDrZYMH_G>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Jun 2025 12:49:29 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Maxim Cournoyer <maxim@guixotic.coop>
Cc: git@vger.kernel.org,  Andreas Schwab <schwab@linux-m68k.org>,  "brian m.
 carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v4 0/3] git-credential-netrc: better symbolic port names
 support
In-Reply-To: <20250625142511.28857-1-maxim@guixotic.coop> (Maxim Cournoyer's
	message of "Wed, 25 Jun 2025 23:25:08 +0900")
References: <87ecv8k4y9.fsf@terra.mail-host-address-is-not-set>
	<20250625142511.28857-1-maxim@guixotic.coop>
Date: Wed, 25 Jun 2025 09:49:28 -0700
Message-ID: <xmqq1pr7wyuf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Maxim Cournoyer <maxim@guixotic.coop> writes:

> This revision fixes a single white space in a new test added in 3/3.

The contents exactly match what I locally have (as I fixed up the
previous round locally before you sent in this iteration).

[v4 0/3] does not look like a reply to [v3 0/3], though.  It has
these header lines

    Message-ID: <20250625142511.28857-1-maxim@guixotic.coop>
    In-Reply-To: <87ecv8k4y9.fsf@terra.mail-host-address-is-not-set>
    References: <87ecv8k4y9.fsf@terra.mail-host-address-is-not-set>

and refers to the message in the discussion thread of [v3 0/3] in
which you said "I'll now send a v4 fixing the white space issue,
making sure to --in-reply-to=$message-id-of-v3-cover-letter."

No need to resend this round just to fix the threading, of course.

Thanks.

> Maxim Cournoyer (3):
>   contrib: use a more portable shebang for git-credential-netrc
>   contrib: warn for invalid netrc file ports in git-credential-netrc
>   contrib: better support symbolic port names in git-credential-netrc
>
>  contrib/credential/netrc/git-credential-netrc.perl | 14 +++++++++++---
>  contrib/credential/netrc/test.pl                   |  8 ++++----
>  git-send-email.perl                                | 11 +++++++++++
>  perl/Git.pm                                        | 13 +++++++++++++
>  t/t9001-send-email.sh                              |  7 +++++++
>  5 files changed, 46 insertions(+), 7 deletions(-)
