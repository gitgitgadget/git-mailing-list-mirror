Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8948834
	for <git@vger.kernel.org>; Sat, 24 Jan 2026 02:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769221109; cv=none; b=LUOUf5ZkdBl6bN+iobuXND4e86cjhsEJHbbiUL55Z8b22CU6B+FuRNli0KAd+nyERWGDv1HspMbFUx4mLYEZ1GaYvf0gnzytQHyvKAnJPC6UYjt4jtbO9Tv2XCATj/q3/6hYwzTsZAn4tSElL9+YojATDPtYy5CiGjX/6wQVz5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769221109; c=relaxed/simple;
	bh=qBm0dc0jwRjQgw5UVFxG5rBUe+JYvGfXwkxeHVWGOrM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ktioNUQgC/NjCX0uloE9v7/HhUVcjp3X/RL37BD9R69/HrgXxZup+4EDAesNA2Db2CfdnSyCFzCUNb8FNO7CbU/WZfe1mHs6dPR71qHeN7YpVNsbCxuOugT6tKggWVCLyYqgTZoaji9FU7sYVhjoot2q1EADQGchiT7ZxQviXYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=nHxnFB6p; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AlabLeJr; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="nHxnFB6p";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AlabLeJr"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id D98A9EC011F;
	Fri, 23 Jan 2026 21:18:26 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Fri, 23 Jan 2026 21:18:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1769221106; x=1769307506; bh=yqbVEPlpXG
	41qRjc19+frcRi0sQ7wYvv+ecfknkgps0=; b=nHxnFB6p/0vQ5j3V+suACgqDGR
	SS6fePukjQsL5KbhR7V4rQneracb9L/K8CNlsxTO5yAQXghROoAza9hacGe7UDRf
	ylP9BL/J3wh4Ozydiu7jHmtNa7GJowpv5PFt9OgMSKWbF2XTtZqnDHndDNXjQf/F
	ePghqEyu56gqluX9TLneeI1+2Ujb1AoQ2YoCY9rKiJUvSgG1nwOL5uLDMZiRiTc8
	c+w6oXO85bpURkozHP+uomXlq5eRQNUryE3y6ZUsvfEVxB3z+T7iGb58P1GjWgS9
	RFWLDhqWf+wQi3t/ZBqjGXVkE6lOvR6sXYIKy/2cZKRtAUkmcH4TZELc556w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1769221106; x=1769307506; bh=yqbVEPlpXG41qRjc19+frcRi0sQ7wYvv+ec
	fknkgps0=; b=AlabLeJrU4GREXHThh3N1WOMEsEC9KOWGiHajuXqnkWbRjYER+t
	R6HOixp3E1CizFBl7onWbJJXiDT/xNZoijWeoQGfn40ssy3I/Nm+qJYh73zJOsnA
	eDZGnehcCMfIMlk/tZTiIqWNDVKupoa0mkl0zZEi9umJcTuCwcrdePypur75qN8t
	H61kMFJ48jwI5D8f3NBHznAoktY6C/WRnyzSe6oDpe2PawMM6Q31/ii29sNAci1e
	+6MEWDdt3ArFURMX37bszrmmfhZ7geG6/CFX9ni4rt96XATFAUhVw05V+P4GHnQR
	O4nxFVCytqCnI7hoQpO1W2rVTolP5QEHTPw==
X-ME-Sender: <xms:8it0aTqDaurjVQcbxvaetE8mt_UALQl1QZlTNTCrJ7rNfHwSoPdjpg>
    <xme:8it0aW9rparkjNkmZQGZHnLJoYRqiLNWpou0nnfuY9DD1p5HgMELnjB-pcYeXd7q1
    ki0W3M4MXIuICwLeUlcp9obaf4-ndX_id91EEqEdV_V-HuK4x25-A>
X-ME-Received: <xmr:8it0aXdHvvkrHeLHMA7cO7nCnoZQ2lGXj97ALT_cqKAkqqwXX4sRJ0J3neWBjge2PlW6fba8rwn-NMno-Ne49HYtccX90GlNC_tyXAw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduhedtjedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepffeiteeujeevfeehuddvjeduffeijeegfefhtddvkeefjeejhedtgeefgfei
    jedtnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehnrg
    hsshgvrhdrghhrrghinhgrfihisehoshhsrdhquhgrlhgtohhmmhdrtghomhdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsggvnhdrkh
    hnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgt
    phhtthhopehjrggtohgsrdhkvghllhgvrhesghhmrghilhdrtghomhdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:8it0aYJ2He3vXALq89Ph5NXzmZy22lTjgmZgX_Q0NSOkSrHofFFvfw>
    <xmx:8it0afi35HefZQzE0R8WL69Z29HAsNCo5meVjbMPgGZKMCTsdRR_PQ>
    <xmx:8it0aeQoGTGh4-aiiZxOaxasPs9dpFzxiDShV6Kn3Ni9CuhXMKAu6g>
    <xmx:8it0aRUd59caV3d2LSKF5ThKRHfbTD4zKWzSUCN3yJ3XmgGTcscZUg>
    <xmx:8it0aWuvxMM5hYn-hoNKheqhMZ1-AsJFYr0k9DX8L3yju96lAAYqeuBV>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 Jan 2026 21:18:26 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Nasser Grainawi <nasser.grainawi@oss.qualcomm.com>
Cc: git@vger.kernel.org,  "D. Ben Knoble" <ben.knoble@gmail.com>,  Patrick
 Steinhardt <ps@pks.im>,  Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v3] submodule: fetch missing objects from default remote
In-Reply-To: <xmqq4iobhpvg.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
	23 Jan 2026 15:26:59 -0800")
References: <20260114194815.1049888-1-nasser.grainawi@oss.qualcomm.com>
	<20260122152722.866341-1-nasser.grainawi@oss.qualcomm.com>
	<xmqq4iobhpvg.fsf@gitster.g>
Date: Fri, 23 Jan 2026 18:18:25 -0800
Message-ID: <xmqqms23lpn2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Nasser Grainawi <nasser.grainawi@oss.qualcomm.com> writes:
>
>> diff --git a/t/t5572-pull-submodule.sh b/t/t5572-pull-submodule.sh
>> index 45f384dd32..faafe31409 100755
>> --- a/t/t5572-pull-submodule.sh
>> +++ b/t/t5572-pull-submodule.sh
>> @@ -257,7 +257,26 @@ test_expect_success 'fetch submodule remote of different name from superproject'
>>  	git -C a-submodule reset --hard HEAD^^ &&
>>  
>>  	git -C child pull --no-recurse-submodules &&
>> -	git -C child submodule update
>> +	git -C child submodule update &&
>> +	test_path_is_file child/a-submodule/moreecho.t
>> +'
>> +
>> +test_expect_success 'fetch submodule remote of different non-origin name from superproject' '
>> +	git -C child/a-submodule remote rename origin o2 &&
>> +
>> +	# Create commit that is unreachable from current master branch
>> +	git -C a-submodule checkout -b newmain2 master^ &&
>
> This test assumes that the first branch created by default is
> 'master', which will break in one of the CI jobs:
>
>   https://github.com/git/git/actions/runs/21304166518/job/61328461844#step:9:1942

For now, I've queued two fix-up patches on top of the posted patch
to avoid CI breakages when the topic is merged to 'seen'.  One is to
rename t7425-submodule-get-default-remote.sh to t7426-submodule-get-default-remote.sh
(both filename and the reference to it in t/meson.build), and the
other one is the following.

----- >8 -----
Subject: [PATCH] SQUASH??? fixup

The test as posted breaks when run with

    $ make WITH_BREAKING_CHANGES=YesPlease test

as the added part assumes that the default branch name is "master".

This band-aid is sufficient for the purpose of the maintainer to get
the CI passing, but the real solution should probably be done better
in such a way that the latter step does not have to rely on the
creation of "anchorpoint" in the previous step.  I'll leave it to
the contributor of the topic.
---
 t/t5572-pull-submodule.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/t/t5572-pull-submodule.sh b/t/t5572-pull-submodule.sh
index faafe31409..dfc07d050b 100755
--- a/t/t5572-pull-submodule.sh
+++ b/t/t5572-pull-submodule.sh
@@ -246,7 +246,8 @@ test_expect_success 'fetch submodule remote of different name from superproject'
 	git -C child submodule update --init &&
 
 	# Needs to create unreachable commit from current master branch.
-	git -C a-submodule checkout -b newmain HEAD^ &&
+	git -C a-submodule tag anchorpoint HEAD &&
+	git -C a-submodule checkout -b newmain anchorpoint^ &&
 	test_commit -C a-submodule echo &&
 	test_commit -C a-submodule moreecho &&
 	subc=$(git -C a-submodule rev-parse --short HEAD) &&
@@ -265,7 +266,7 @@ test_expect_success 'fetch submodule remote of different non-origin name from su
 	git -C child/a-submodule remote rename origin o2 &&
 
 	# Create commit that is unreachable from current master branch
-	git -C a-submodule checkout -b newmain2 master^ &&
+	git -C a-submodule checkout -b newmain2 anchorpoint^ &&
 	test_commit -C a-submodule echo_o2 &&
 	test_commit -C a-submodule moreecho_o2 &&
 	subc=$(git -C a-submodule rev-parse --short HEAD) &&
-- 
2.53.0-rc1-193-g609e9a7b29

