Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C8E8615A
	for <git@vger.kernel.org>; Sat, 29 Mar 2025 16:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743266211; cv=none; b=LRdab7RY04ZAeDYv4YeYbBloDGxQCDBOZGv/7v3nFxwfTS1epQPqpZ88nLCnFg97MCvXYZWTQFtB6/33CL7rc+N+aZQwzLoQNgozyXACQNqVOPjBrSiaE8leq+FUbiQlKXlvJFtAFfuEfyz8dHTgpbDSfdQOIQkgPysK5Bm2les=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743266211; c=relaxed/simple;
	bh=ouwpxpnY4Qp8KjelVSauUD4sCxlTdplCbQRP/UXWxU8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=COSsbMrfostAaJXf2MdkcL3FUKX47EtcDsOLOGCdqxOqgPrGtBBmbgSvlhwnOg0Qk4+Kjf1/Q9C1k2O5N42xbLg5M6EvFbHgzy5hSX45IXDTiUCTpTfv3fkGaZJj4rY1x+Ie00L/4YAVx/sRuWVNxKM1kDWRuZISmkXXpYwPMwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Y8VvYRkd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sPOofizn; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Y8VvYRkd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sPOofizn"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 4B6A21382D7B;
	Sat, 29 Mar 2025 12:36:47 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Sat, 29 Mar 2025 12:36:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1743266207;
	 x=1743352607; bh=yWr/jkJJl2zLJIbIuJ6T3ouRLsU7FGE99Im4KFtpnpI=; b=
	Y8VvYRkd3WaP9R6nYuJsUkmMlIm8PjTxsQfnw3uM5KtSuLPX6lOYtilzgWFUXR1f
	kjhAj0yyO6C7kmVnvccF+1RNLpulhWgYx/veqZ/y9nZ7J8GWpX4SgUIRkiu9MyCg
	r1uHOxhB9D56HqpfyXIMXn2VQyruGvtdZnQtbgyvIbFm3aeT+rG4GK0w5GJS0Fbn
	Spw4ULVdp5AhJkeMlvhI3EYNoeqr9G5Q4WtVjFriHq5u22jQ0ownrAbK7mRtsDWL
	HzoFV0Be7+tVKO4HD4oPf3D43+x/3P0DEJg0Np7tVLBeEGTfdJnIYZRTgM1EdzDU
	AsY1tUpS8K2Homhp3H65Cw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1743266207; x=
	1743352607; bh=yWr/jkJJl2zLJIbIuJ6T3ouRLsU7FGE99Im4KFtpnpI=; b=s
	POofiznFvb9E70Z/epqnLvrjIoOxHNTcdh8w4W1j25Ji7HuJOEq4PYUbamc1m39/
	GlHb5W5DIRBu4wiHSuqUZ9IUL586XCxnhs8nTH6UqOxDlK0W+1nCe9Udeju9SsDL
	8Ku5r6ENR9QmhQ/3/pqNO5yXEOKYd8LMfV/oV3lAK3YHI+Tjgmgbkvlo7BGqDU5m
	Wogc9pwraSnYKx0bfP5cwwSXoCm3zeLAiMKQppDEHt+Cv+wEc75wnEIlEJAYOLS+
	yc1FasBF9TmwlDuoNlCVYJvtmGwrDnOacHDk5yUJzBnS0WIvs5ercat+om2Ho9Tt
	6g/IkMacf6mgpaPNYqTjw==
X-ME-Sender: <xms:niHoZ2NroYzWEGDAj_FZKSgC9AWmgZpAZ-3WKSgiB68IlrdPjZ3zSQ>
    <xme:niHoZ0_HbwhWMAA49RiI_px6r5zmqO8Jk6hb7MNMhUnwTO4OxdiH-D4pMeFYbjnv_
    732Aez0D9AonsTbqg>
X-ME-Received: <xmr:niHoZ9Qu3Tqtdet7xWJhlPhna8ILi-CXq6Ltd9Jrw6AVOBmXr74VXVgfJ_KAJsiKWJ9jOZS9FsuWtdkkQqQOGFIUsGwpEwdIoWFgLEU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujeegieejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgfgsehtkeertddt
    reejnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpoh
    gsohigrdgtohhmqeenucggtffrrghtthgvrhhnpedtffdvteegvddtkeetfeevueevlefg
    keefheeigfehveehvdekheelveevfedtheenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggp
    rhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjnhdrrghvih
    hlrgesfhhrvggvrdhfrhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtph
    htthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehphhhilhhl
    ihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehpkhhsrd
    himhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:niHoZ2vUkhCIvYP1luXCspwWcsxIJNalLoenHtVIItPiFMU00GCHGA>
    <xmx:niHoZ-dXRNKRDtEH2e9u7V4hXYeBneB7uazc6a7NGTz1wpejndSQgA>
    <xmx:niHoZ62T7cnjKSVPTT3eNl1Ch1RUW0sAT_lLLpduXnMFDDo4ohU8wg>
    <xmx:niHoZy_g7ggWLnE8MhqvtdiIanFkhL_aWnTW1iztEeQStpe85qTVBQ>
    <xmx:nyHoZ0vDJebEeP69uXPyjeAU8KU4iQHF3_-zVO9PGIFZ5Clbc_vUjH5D>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 29 Mar 2025 12:36:46 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>
Cc: git@vger.kernel.org,  Karthik Nayak <karthik.188@gmail.com>,
  jltobler@gmail.com,  phillip.wood123@gmail.com,  ps@pks.im
Subject: Re: [PATCH v5 8/8] update-ref: add --batch-updates flag for stdin mode
In-Reply-To: <6141866.lOV4Wx5bFT@cayenne> (=?utf-8?Q?=22Jean-No=C3=ABl?=
 AVILA"'s message of
	"Fri, 28 Mar 2025 14:00:49 +0100")
References: <20250327-245-partially-atomic-ref-updates-v5-0-4db2a3e34404@gmail.com>
	<20250327-245-partially-atomic-ref-updates-v5-8-4db2a3e34404@gmail.com>
	<6141866.lOV4Wx5bFT@cayenne>
Date: Sat, 29 Mar 2025 09:36:45 -0700
Message-ID: <xmqq34evequa.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Jean-Noël AVILA <jn.avila@free.fr> writes:

>>  SYNOPSIS
>>  --------
>> -[verse]
>> -'git update-ref' [-m <reason>] [--no-deref] (-d <ref> [<old-oid>] |
>> [--create-reflog] <ref> <new-oid> [<old-oid>] | --stdin [-z]) +[synopsis]
>> +git update-ref [-m <reason>] [--no-deref] -d <ref> [<old-oid>]
>> +	       [-m <reason>] [--no-deref] [--create-reflog] <ref> <new-oid>
>> [<old-oid>] +               [-m <reason>] [--no-deref] --stdin [-z]
>> [--batch-updates]
>
> In the case of expressing alternative command line invocations, you need to 
> repeat the "git update-ref" command on each line. Otherwise, it means that 
> this is the continuation of possible options of one command


Like this?

diff --git a/Documentation/git-update-ref.adoc b/Documentation/git-update-ref.adoc
index 5be2c16776..9310ce9768 100644
--- a/Documentation/git-update-ref.adoc
+++ b/Documentation/git-update-ref.adoc
@@ -9,8 +9,8 @@ SYNOPSIS
 --------
 [synopsis]
 git update-ref [-m <reason>] [--no-deref] -d <ref> [<old-oid>]
-	       [-m <reason>] [--no-deref] [--create-reflog] <ref> <new-oid> [<old-oid>]
-               [-m <reason>] [--no-deref] --stdin [-z] [--batch-updates]
+git update-ref [-m <reason>] [--no-deref] [--create-reflog] <ref> <new-oid> [<old-oid>]
+git update-ref [-m <reason>] [--no-deref] --stdin [-z] [--batch-updates]
 
 DESCRIPTION
 -----------
