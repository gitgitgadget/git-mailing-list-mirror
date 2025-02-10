Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F321F8BC6
	for <git@vger.kernel.org>; Mon, 10 Feb 2025 15:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739202639; cv=none; b=XJ2mneaeu/uWklL7a/+zbqcPeBPquJArdkTtPuDxBSJlpW6bDtspOfrAb3wD55bzW9DO3GBx5G+wYcEoBAink6JGsn/dZuzRko0Et5rr7rL/kHUowc434TVYeyPZZ7WBykoJ9EDrqstRz1JQw1bnIiC6bjhjB+I8V/NCY9fArtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739202639; c=relaxed/simple;
	bh=GSxTQhygQ6/IKaBJA3Ez0UMLxhizyM4V2tPXUHWG968=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LStK3Q9nyJxEMR7Mq/xf9u5knCTu1+2yG9ElqDxonLLSgxQorSOGqyp9xKjAg8p+QBnoNWDxqRxdLVkZeejluOlPrC1n3AMTEJt4jNn4nKazIl0CgPYCUdG7TDSAdKcH+AtV243hPhluKcXUsH0WwirvuFIIBagi59QFExPYfuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=PtPu55w9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sDQgUEbV; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="PtPu55w9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sDQgUEbV"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 91682114023E;
	Mon, 10 Feb 2025 10:50:35 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Mon, 10 Feb 2025 10:50:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1739202635; x=1739289035; bh=2JcD8cGA0b
	S1oEFQIcFtM7BiQhik9bYQGo5gsMIUzN8=; b=PtPu55w9z/5D6lDnQKb9Za1yzw
	oBg1HfKTukfoOFt2NXXu844AIPrP21mX4BqanoYF3TOxWhrky68wdpleCINchhEi
	EPGE18sg+VsBSfq3Io9ehoUQBCyGYyeMEoRhYnjKpccnfLDy+Xl6ipGY9T7RZHtC
	eOzwN9qN1VB4YB/gUagNDsLjaD97sg6i9ZrzfAu8hq0ZnEo6c2RDM/Tu1u333fp3
	6Dmgkm9f4TApmIBI1oHsi5EVMNppXNcHB4TFP0PH964Xtk6zQZOW+NBNwAua0+Vo
	nJXbnQSOnsIyPV2X8lOQ1i5iMel6ZPQX8bfDRs4Ts8HRvxtWNqbzeUmP9MJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739202635; x=1739289035; bh=2JcD8cGA0bS1oEFQIcFtM7BiQhik9bYQGo5
	gsMIUzN8=; b=sDQgUEbVwCM6xYEd3LWRHvnbmCUK3d0imXqfiA5PuTA5Mj5aqsI
	1wrHMyNbvo82TGi0BKM2hRNfbzhx5Zj37LJ73JhfxWM3KD4JfKvHTOi2G1mjY8pG
	fFSKlJAh5Kvj6Wt9zTdpu6zi1DJPyzJ2hzJMOa/yf93Lxk0iVT+hOEPmn7m1jL3h
	4x2RF6/MKgrSlUSe9AlnyTMNINohKh467r5yPb4vY2EEQCx+25ljm6IgYEW15thw
	p8j9N4YywGBqklZtv9aoEPZI8FKcfjgYWQsweKFLlUZ3NPc/ZMPW7qercjN66lN/
	UXPv70F1YehqxTOwQf4vW7dADw5kowTW7Og==
X-ME-Sender: <xms:SyCqZ2m34UJtU8rN3Z4_CIKkFsdFDvm5ADO4hUvJ2UXPxMCKy3q9MQ>
    <xme:SyCqZ92Jpa9Le4S1S6fBeE_9H1ppAPZz9c87xRhFEHse9ptJhCVv1noLm8hdBbZx1
    kuZBt5ZfRyaZAZtDQ>
X-ME-Received: <xmr:SyCqZ0qZdDjPHgQKHKXq0W9AWNtoqmGyeouD57DZqrxYO6zrv9pWO8D_hjoyJoyf7NVnQKIu9pJgIKzI_pn3iyP6NVDDQ5CkVnXm>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefkeegjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjiehtsehkuggsgh
    drohhrghdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepvghthhhomhhs
    ohhnsegvugifrghrughthhhomhhsohhnrdgtohhmpdhrtghpthhtohepjhhlthhosghlvg
    hrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrd
    guvgdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:SyCqZ6kseYz6_2U7Au_vHajsYA_HnGga4mTuKo9ol-Bz5VB7-NuOjA>
    <xmx:SyCqZ02ex6NiFzadxuuqngSOJqtVhMblsceW7CosaZfueqXNOW8fQQ>
    <xmx:SyCqZxsxGkoErUZKv9sU-WHW0RjAEDeIy3MLgwV1HOUeSGIXTSh95g>
    <xmx:SyCqZwW8xjbdWJmCFRfKBNXLt3LQIKOYaRdK7z0Logzfyd1SAuxYUQ>
    <xmx:SyCqZ1lFqS4IDL2gd9eb66E3wLcroT3RK2C3Y68nreUFo4mRW1nOBEA2>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Feb 2025 10:50:34 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
Cc: Patrick Steinhardt <ps@pks.im>,  Edward Thomson
 <ethomson@edwardthomson.com>,  Justin Tobler <jltobler@gmail.com>,
  git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v5 15/18] compat/mingw: split out POSIX-related bits
In-Reply-To: <c48e8fa2-cca4-4abc-95d2-234fa5c69b8d@kdbg.org> (Johannes Sixt's
	message of "Sun, 9 Feb 2025 14:14:37 +0100")
References: <20250207-pks-reftable-drop-git-compat-util-v5-0-ba2adc79110f@pks.im>
	<20250207-pks-reftable-drop-git-compat-util-v5-15-ba2adc79110f@pks.im>
	<c48e8fa2-cca4-4abc-95d2-234fa5c69b8d@kdbg.org>
Date: Mon, 10 Feb 2025 07:50:33 -0800
Message-ID: <xmqq1pw5er3q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Sixt <j6t@kdbg.org> writes:

> Am 07.02.25 um 12:52 schrieb Patrick Steinhardt:
>> Split out the POSIX-related bits from "compat/mingw.h". This is in
>> preparation for splitting up "git-compat-utils.h" into a header that
>> provides POSIX-compatibility and a header that provides common wrappers
>> used by the Git project.
>> 
>> Signed-off-by: Patrick Steinhardt <ps@pks.im>
>> ---
>>  compat/{mingw.c => mingw/compat-util.c} |  28 ++--
>>  compat/mingw/compat-util.h              | 220 ++++++++++++++++++++++++++++++++
>>  compat/{mingw.h => mingw/posix.h}       | 216 +------------------------------
>>  compat/msvc.c                           |   6 -
>>  compat/msvc/compat-util.c               |   6 +
>>  compat/msvc/compat-util.h               |   7 +
>>  compat/{msvc.h => msvc/posix.h}         |   8 +-
>>  config.mak.uname                        |   6 +-
>>  contrib/buildsystems/CMakeLists.txt     |   2 +-
>>  git-compat-util.h                       |   4 +-
>>  meson.build                             |   8 +-
>>  11 files changed, 266 insertions(+), 245 deletions(-)
>
> I can agree with this rearrangement of compat/mingw.c. But the
> Git-for-Windows repository has much higher stakes with all the
> additional changes. I put Dscho on Cc.

Thanks.  I agree that it is a very prudent and sensible thing to do
to ask for input from Dscho.
