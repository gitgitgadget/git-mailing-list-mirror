Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A13F189906
	for <git@vger.kernel.org>; Wed, 19 Feb 2025 17:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739985115; cv=none; b=uvXLEKs/NSa3r9P0IolCzABF2gU3jLkdlEZ86SYhe13hkbb73AL/W310qFA2T+mGmY/yoGowNEHU7/3FO1JpEPZUc5xlkFcHzBjjkuGnnh5T8lIphHz28BCt1Nkg0KPySkKJ3fdujlqzvFRO7VxVvF9ed02ax5/35V0mih14hNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739985115; c=relaxed/simple;
	bh=HPq9zcgEDKeZ8b3TJR3XUc1l+o5jbpgAbtTBY9S+7uI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NYo8MEEwRpwW/Im3GIvNp+pBfHCN+CUFds/K3oW3bD23+4QPDSmf2n2BiODhigOedbF3vMHld9vcZEhinnlY3/cDB75yTgPLvqxu64T+xeZ4hfrABJKzIp5qxbTVX6waw2rQtthXSES2mQleMSDWspeoCGh9R7rR1pE6+fhvA+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=XVHKDcyb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xLO1ZhwA; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="XVHKDcyb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xLO1ZhwA"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6BC21114010B;
	Wed, 19 Feb 2025 12:11:52 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Wed, 19 Feb 2025 12:11:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1739985112;
	 x=1740071512; bh=dGbrKgop71H+rco/IhheQc6KKajx7i9Zp3uNupGgkxc=; b=
	XVHKDcybQqgB0pcugyt6/BliYssVEfEANXE+E4bH1sVXSVOlESTPjCU7nGPwR8BR
	5G81OGQV6yt7YJImaJ654nj0Dd96ImeaL1nK7+QzCxuXzgQOisBiEJ55EEmnJqUH
	M2Ait2FNuy4s1T2HOpX0WRTpM+10v09sWggzphtPmGscNVAOP3aW/xID2s7cfHPu
	KjuIWErlcQaAhXzaf8iZeB3Y4LdweCuUDYM1kHvZXv3j8qOPxfPCwJPHE2ykav5S
	PqPtCK9odO9JlfofqJ/44R9be86inUEAMzlm1EnFAss2qdV4gvpkiDgxepoDXSN+
	5yt9X51VHLaRMGzSVFi48w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739985112; x=
	1740071512; bh=dGbrKgop71H+rco/IhheQc6KKajx7i9Zp3uNupGgkxc=; b=x
	LO1ZhwAYiSZal0k90HBtMEpPO5IFhraygHgZF9mHVImauMKSxAYS7wyefjmHfTqP
	FDWrLkUx3d7CsI4nswObCISId4eNyAN1VOckyfHtC/NOmyrcFp/kHNprGdnnDgsu
	rIwBoNJ1d4ahipT9BxBwh4GJuj9EnV1+lK0YlTvMB5XKO3gjb9ke8TXdQC6av8VH
	8AdxTisFui8mjhdj8fo2URAGkfZmfe/EDk2qW8QyfacnUC4QE6GKl7f6dy1/5/m6
	nVi07MeTyaAG1qMi1D/nSblbDfHgWmFEFchJ75aZNdKItYR9G8L03kQOGYHbM20U
	nwl8Uc+NEdeBvQHYENROQ==
X-ME-Sender: <xms:2BC2Z4lqzAGNkmA7KU02ieMCTNQ2sy_KacIB6ETdKXkJawCbPm-4tQ>
    <xme:2BC2Z32OAri3WBpW57PmhgnWBCwMfpKZY9dbCyAmFAwVQn4DK7x7hOqKWTbn0DDR1
    bBUS3kdNa-TwlnCLQ>
X-ME-Received: <xmr:2BC2Z2pRt11fWwzJmvK9T4AupsmmvqLmNomDwaZs5OAPXzV-kixMQ8znMWJxYOBHu1XcNLBDkl0xXKIS7NyryUiGW1KozfOe4pm_oKc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeigeekfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvve
    fujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihhoucevucfjrghm
    rghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpe
    dtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveevfedtheenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvg
    hrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehmrghilhesrghnshgvlhhmshgthhhuvghlvghrrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:2BC2Z0lSztiyAPPqxnV8IBlY-9ypUerQTJxfRDVtSluY5s5QtF8Tdg>
    <xmx:2BC2Z21jVhNHqgw9Ezc97288LmydXT8d853-uT6vnA9NbF2fFgkT8A>
    <xmx:2BC2Z7vffog3UB6fZpvsJRSsVFhySQDP2Qm_xRH99FeKvHpQUtg2aQ>
    <xmx:2BC2ZyXWCPjpwjw1jCCtCKyshOc6kBvUoJ0LR9JeNMxXyuzL5z0PRQ>
    <xmx:2BC2Z7xh_8VEw91bKPCNnP-XOIlWdLO29DZ680lsM2OfAiZtV3rpcCLw>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Feb 2025 12:11:51 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Anselm =?utf-8?Q?Sch=C3=BCler?= <mail@anselmschueler.com>
Cc: git@vger.kernel.org
Subject: Re: Possible bug: Empty magic word list in pathspec is handled
 differently in short vs. long form
In-Reply-To: <216a7288-b599-4333-ba62-10665d6a94d8@anselmschueler.com>
	("Anselm =?utf-8?Q?Sch=C3=BCler=22's?= message of "Wed, 19 Feb 2025
 11:49:39 +0100")
References: <216a7288-b599-4333-ba62-10665d6a94d8@anselmschueler.com>
Date: Wed, 19 Feb 2025 09:11:50 -0800
Message-ID: <xmqqr03tg8q1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Anselm Schüler <mail@anselmschueler.com> writes:

> ﻿If you run git diff for a pathspec with an empty magic word/symbol
> list in short form (prefixed by ::) and in long form (prefixed by
> :():), you get different results.

The short form is prefixed by a ":" and optionally ends by a ":",
but the optional termination may not be required when there is no
ambiguity (e.g. ":/!path" is "from the top, not matching "path", as
"p" cannot be a magic signature; ":/:!path" is "from the top,
matching "!path", as the set of magic signatures ends with the
second disambiguating colon).

The long form is prefixed by a ":(" and ends by a ")".


> Here’s an example use of git that illustrates this:
>
> ~☭ mkdir gittest
> ~☭ y gittest/
> ~/gittest☭ git init
> Initialized empty Git repository in /home/anselmschueler/gittest/.git/
> ~/gittest (b0)☭ uuidgen >file
> ~/gittest (b0)☭ git add file && git commit -m "$(read)"
> read> initial commit
> [b0 (root-commit) cd3bd43] initial commit
>  1 file changed, 1 insertion(+)
>  create mode 100644 file
> ~/gittest (b0)☭ uuidgen >file
> ~/gittest (b0)☭ git diff -- "::file"
>
> file
> ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
>
> ───┐
> 1: │
> ───┘
> 66d18ffa-1128-42a5-8d4e-f9d75eb86b92
> 9acea2b5-50a6-4f87-ae1a-64019a93e55e
> ~/gittest (b0)☭ git diff -- ":():file"
> ~/gittest (b0)☭

Doesn't ":():file" ask for a match for the pattern ":file", with a
leading colon?
