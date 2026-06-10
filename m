Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8854429837
	for <git@vger.kernel.org>; Wed, 10 Jun 2026 15:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781106515; cv=none; b=ecnCewC71yxkjkwEMn/B0Qg3FeLxBVqQVPVSVLlFTFBtYNWwSGAyc4JXU5io8zu/ftiILRlukQudwroIWLiVd6M22nb6arM1WChW/dUw+7+kM7uX7vTf7VD1BWN1tTMsYPetDCdRXxntfrE4BsFWrtl3Y7Ybmai3Bzzu8KLU3YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781106515; c=relaxed/simple;
	bh=TOwwbk6CDI1vTtFqhhbZmDLbOd/ciOQGwnczLI1IoF0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Tc/VFLAx/LaFvONNzG4urYw7/LO1+COxpGd5ABWZItoQhicYd2qwqT73MIrDJHzmt9aHPBuK4AIDcQCyJ5vvmO/n5cRpHO1flsBukP4j0Nwwff/lBdBHZKPOtl6Um8MKbbSgmsr6BhkzB4clsp9ORzjJW2nBzjC86HqTv0ZYvao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=kfVe0EvQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=W4EeKVez; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="kfVe0EvQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W4EeKVez"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 3CE8CEC00AF;
	Wed, 10 Jun 2026 11:48:33 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Wed, 10 Jun 2026 11:48:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1781106513; x=1781192913; bh=rX/t+rvFT9
	WZOLLvb4Fa21EmABx07LRbZHNHWq1S2AQ=; b=kfVe0EvQqzE8bKcy8G01jC0+zv
	JULYz7/NZZs/+RLXKy2kidhwFHmXzHOBH5qz4FFmB+DhqTgQYcrdvpHGEWlfOb+g
	sw2p3UKFYr41xn2LxNe9um0FuqVRXTQBJz1FniXdRmpLrllNVcPS2/B6pbNfrSw2
	96DJQ7IEIsKPkdYYiBiuQ0D95pv/1+9TiOwuaJaP9tsLtibGiguamxSmV/uUSn0+
	qjuEymSfeRcKfdF4+7ue78ongVzWjCwMRIftwYvzTInyYmRDHVX3qIbUqWmz4F1E
	MbOUkbk2WG0AXnvS5DUotR5dtTDI1t4zzWeTR6VGE4uEYBrOV2tufM6Qn2ug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781106513; x=1781192913; bh=rX/t+rvFT9WZOLLvb4Fa21EmABx07LRbZHN
	HWq1S2AQ=; b=W4EeKVeze2N7Q/J5fNp9vi50dhTRwAaHtE3RECFe7SEj1LyjNW4
	RRFhygeXXcV8EeFbY94kPMLf6fUjReMVYYGgf6LBYW/DlWgmpryWoUIKyZ0/leGd
	D0muUNe6KNifx/tGrZuYD1+g7cUi1PTwsmf2Yz+wg+YhkA3M0JTumBEpKv/o0qSN
	7lf2Yd0cLupWNVLAz9crkYnrARNzIIvUq0HXPpOff7AK4tD5htSoJNUF+S1q11vj
	gujwx08o0P4XJuFg92/Yh6VjnGSpYDmTO+agC/761EoiKe89NalgJU3T2N+A1qbZ
	tQbrx0WS0s4vDW9uGQxhFBd6sNyEquOA63w==
X-ME-Sender: <xms:UYcpaiEstTxMfip8XBt0e82TBdGQt3XhBAS2LzRNtpotDIUSL73z7A>
    <xme:UYcpaqNWYgZkXDBboq3b1WftyGHpDyR8ReZSi9QBm9KKp-714MaLdFbaNaVcUK-KM
    vsw9AHEmm81zT0vMUT4dFkjbQjzQj-H6qbOwcC7mBZpQahkwt-xhig>
X-ME-Received: <xmr:UYcpakfoC-0kfhoMGiHdz7AH9JUCh4L-KGsEYkNWT_LA_4pfWoEf7_kLfvs0uWGsmjPkXJpYAUADuxpQtd9VapFjEGPSNKn4f62v>
X-ME-Proxy-Cause: dmFkZTFGTZjDwLbiFLBVnOywVCGUNW0WB/jQ3eN6AZKWHN6fhHsbCD6jnC9OLCA/m0KOOZ
    HwR55SOfhuvziee8pHnX7ffSr+RtQSfu4pTrwAMlFJjTGgJSJ86OfN/vC74gfsGvUOPKc5
    uADUgjrVna+5AMQLEo9f4qPOK33kBeBXaN/wcbrO28FjVyWEmet8dKv6rf5HsvO1MyTbXb
    et598wklWVPAZLacAGxQaUxEoYLwE4xJ93/cfTmtVpPoLO4JTfoXKC0u1XPxp1mUObmcXi
    h+VutoHuP4MhS1Gaae4WD3ztplWcswd0YlEO9/sCDEwDen+BCeujV69b2HYTOXUJ/AAPZw
    LrLGoK4Ixk+rsyVQC9/wfLtGBl8A32D/nmjzN3NemG/KJyN4cCGP27S/Qufkp6QmYNvd12
    w0xDTLXrQVXgkGNl1m9mgeADzU3gp598EOnIrPXv1oQGazTUFAIqUpT6ZXMLc7Dd1Z86sB
    YvDyIanM0VqMqLkgDbWG+wgWU/rHVShE6UBM/uKjJdEjQkRWXzJSgoi5sQjTkCS3R9QO20
    xLvr9V9g4VKzD7HdHITZi7+npA/uGsGDZVXb1MH9qcVApYhwBE+s3B67TK4m8TyiS7cj/N
    GkAUC6kSPnkTPAz1b38aSCau3mDdhuVA4vs9m1DMzlUAkg1bgg4t44Uk7ExQ
X-ME-Proxy: <xmx:UYcpanva1tlGdjCro8Vgc11Syn1eH2LRHcoVxQ8XSURiUvclSiyZFA>
    <xmx:UYcpallFPxHXRiotNwerB3DE23JhL9tBWccsGUjn0r10PiOfuN54GA>
    <xmx:UYcpapzWRlDIclw30UdKbCQPlVdZIUQXuokviAGeqlbjDXMHhbjIMA>
    <xmx:UYcpanPQAklhdXu6g6NhUAee5lnsKtz6ng5kH1W23cttolT5kTgeCw>
    <xmx:UYcpait3HY0oaJ5tgsn9vaXBzWbeHBnBWcGHml7z275CusVDvVH9J2pj>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Jun 2026 11:48:32 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Derrick Stolee <stolee@gmail.com>,  Kristofer
 Karlsson <krka@spotify.com>
Subject: Re: [PATCH] commit-reach: remove get_reachable_subset()
In-Reply-To: <pull.2144.git.1781033285419.gitgitgadget@gmail.com> (Kristofer
	Karlsson via GitGitGadget's message of "Tue, 09 Jun 2026 19:28:04
	+0000")
References: <pull.2144.git.1781033285419.gitgitgadget@gmail.com>
Date: Wed, 10 Jun 2026 08:48:31 -0700
Message-ID: <xmqqbjdixupc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> get_reachable_subset() was introduced in fcb2c0769d (2018-11-02)
> for add_missing_tags() in remote.c. tips_reachable_from_bases()
> was added in cbfe360b14 (2023-03-20) as part of the ahead-behind
> series. The two were never consolidated.

Good finding.  It is curious to see that these were from the same
author.

> ... Without generation numbers, some edge cases
> may be slower with DFS instead of BFS since the date-ordered
> prio_queue naturally stays near the top of the graph, but this
> should not matter in practice

"should not matter in practice" because...?

> -- worst case both visit the full
> graph down from the bases.

And of course the worst case scenario is by definition not a typical
case that appear in practice, so it does not make a good explanation
for "should not matter in practice".

> The flag in remote.c changes from 1 (bit 0) to TMP_MARK (bit 4)
> because tips_reachable_from_bases() uses SEEN (bit 0) internally.
> TMP_MARK is already used for deduplication earlier in the same
> function and is cleared before the reachability check.

And tips_reachable_from_bases() clears SEEN at the end as expected.

>  commit-reach.c        | 73 -------------------------------------------
>  commit-reach.h        | 13 --------
>  remote.c              | 19 ++++++-----
>  t/helper/test-reach.c | 39 +++++++++++------------
>  t/t6600-test-reach.sh | 18 +++++------
>  5 files changed, 36 insertions(+), 126 deletions(-)

Yay, a lot of deletions ;-)

> diff --git a/t/t6600-test-reach.sh b/t/t6600-test-reach.sh
> index b5b314e570..51b140a539 100755
> --- a/t/t6600-test-reach.sh
> +++ b/t/t6600-test-reach.sh
> @@ -391,7 +391,7 @@ test_expect_success 'rev-list: symmetric difference topo-order' '
>  	run_all_modes git rev-list --topo-order commit-3-8...commit-6-6
>  '
>  
> -test_expect_success 'get_reachable_subset:all' '
> +test_expect_success 'tips_reachable_from_bases:all' '
>  	cat >input <<-\EOF &&
>  	X:commit-9-1
>  	X:commit-8-3
> @@ -403,15 +403,15 @@ test_expect_success 'get_reachable_subset:all' '
>  	Y:commit-5-6
>  	EOF
>  	(
> -		echo "get_reachable_subset(X,Y)" &&
> +		echo "tips_reachable_from_bases(X,Y)" &&
>  		git rev-parse commit-3-3 \
>  			      commit-1-7 \
>  			      commit-5-6 | sort
>  	) >expect &&
> -	test_all_modes get_reachable_subset
> +	test_all_modes tips_reachable_from_bases
>  '
>  
> -test_expect_success 'get_reachable_subset:some' '
> +test_expect_success 'tips_reachable_from_bases:some' '
>  	cat >input <<-\EOF &&
>  	X:commit-9-1
>  	X:commit-8-3
> @@ -422,14 +422,14 @@ test_expect_success 'get_reachable_subset:some' '
>  	Y:commit-5-6
>  	EOF
>  	(
> -		echo "get_reachable_subset(X,Y)" &&
> +		echo "tips_reachable_from_bases(X,Y)" &&
>  		git rev-parse commit-3-3 \
>  			      commit-1-7 | sort
>  	) >expect &&
> -	test_all_modes get_reachable_subset
> +	test_all_modes tips_reachable_from_bases
>  '
>  
> -test_expect_success 'get_reachable_subset:none' '
> +test_expect_success 'tips_reachable_from_bases:none' '
>  	cat >input <<-\EOF &&
>  	X:commit-9-1
>  	X:commit-8-3
> @@ -439,8 +439,8 @@ test_expect_success 'get_reachable_subset:none' '
>  	Y:commit-7-6
>  	Y:commit-2-8
>  	EOF
> -	echo "get_reachable_subset(X,Y)" >expect &&
> -	test_all_modes get_reachable_subset
> +	echo "tips_reachable_from_bases(X,Y)" >expect &&
> +	test_all_modes tips_reachable_from_bases
>  '
>  
>  test_expect_success 'for-each-ref ahead-behind:linear' '
>
> base-commit: 600fe743028cbfb640855f659e9851522214bc0b

Initially I feared that changes to the test script were a sign of
need to adjuist to behaviour changes, but as the proposed log
message explained, all of the above changes are about the name of
the function being used and tested, which makes sense.

Thanks.
