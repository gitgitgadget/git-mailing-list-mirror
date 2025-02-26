Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F6C223322
	for <git@vger.kernel.org>; Wed, 26 Feb 2025 16:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740588604; cv=none; b=ovsLdTX6VjQNi1k90dav9zkfQlkRLFQEUf/BuZuXCfVW4qt0z0GvUUz48ohcJCUjqXWdvXHwNupYaOQpKHtc4IYxmUdnvGpFcw2lCxykaqoTJ7JA5Jwln2crch8voUAqTCnXo8QLOc7e6x6suuwPY3JcftH/aRxbGx0eZuTQjI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740588604; c=relaxed/simple;
	bh=vuvixqlGwU67L7daOQ+8BDk5EDAOW3z+6Xk1c+wM8+E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RDwJcNWzNKnFjGYFnQOj2pOyXDwLbhGv7E4LIG2Vk3XF0zqyhEbtw0xBqSmlSU0RLgs7r/oXOBcPu0PErW/ut9ud0GNfwOeFqyr0JhbP4/wSpxn8iP5IwYbXIwlR8DtUID92BRyIp1lxMTRnr6Nrc7YafmMLw6TiLKSw93HBHMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=djyoElb+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jBxwt/gY; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="djyoElb+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jBxwt/gY"
Received: from phl-compute-13.internal (phl-compute-13.phl.internal [10.202.2.53])
	by mailfout.phl.internal (Postfix) with ESMTP id 5CF631381138;
	Wed, 26 Feb 2025 11:49:51 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-13.internal (MEProxy); Wed, 26 Feb 2025 11:49:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1740588591; x=1740674991; bh=J6OsGO03Kd
	3U8Mzr6OfJNtEznWyfdZYyH4XVjmYWZPs=; b=djyoElb+p4BHS/4w4/hvkWdu9h
	LGkR3tL+N1zYooJC5SpBGAAWMndlbcKMZakAnWFLoFxBjDcRSL93JXb1S8uqf7Nz
	irW8Gx1GvReL0eZhbcfh+JJB1Kj40fsFpfBrM2pO3ciNJuJmdAehDOBYGYCjXSW/
	xdwepRXIKITi74G6v0Nd5a7IEcWYBusuZV9T33azzg+yYlg1wgJMx+9RbIq2uyqs
	YBYzxojyrihGEsL+USJpCZ03drbFH2UsfgIPRK9wt4UMTT7LBshBuP2YXHB0n1FW
	d1OcfTMVby2zb5g4mn9IhRG7+50QFoE7z1PJzWMYM/TLlQhf8XGcUgTdyESg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740588591; x=1740674991; bh=J6OsGO03Kd3U8Mzr6OfJNtEznWyfdZYyH4X
	VjmYWZPs=; b=jBxwt/gYQ5KlVztgtNEf14bZvl7YVhrZBcsI+0VEdpF1bX1hExA
	OLE0HusG3ip24dbh0+2C3VudaqembmwaDNsooW5vN8E+kMjEVw8jcs+FLv9w50Az
	jmbO6GadMbiujE1r1ZqkAZMhhXKezjPJIerwFWT0cY1eUVfwuShgnZwWiy07/LuY
	Qqjig33Uk0RtYAHTqJiyg/Fjs56OozJrFlMGHaYcVRkMBnJLrzxeneO5roTaH50Y
	1hB5HVgVjOKLP0Vz9jk/5s47h4NVL9VoVz9Mkq1ThFB7Kyfbheba+SCpaLxdN2Vs
	u2a/CHyta7em3PabTbKRFomDwqArGOuBSAA==
X-ME-Sender: <xms:Lka_Z8K7cMRzVvqU0p8NO0LYplGUcsYWvHXCdMppkJ0cT7rttuofMQ>
    <xme:Lka_Z8JZfoex1Egi2BxWa0LOE4woecNEbT4jaNlJXIynjfS1n6utX4Q7fyt9WM-Cd
    36UxPEbUhK7MzXXRg>
X-ME-Received: <xmr:Lka_Z8vbqCfEAOr7soOattwyARIt5JnCa2tS8lgX6tcUx4lySdUY7kI3SiEkP2WevuiE1Bn3s8_S19eiqGGKlZdFY0iTR0rWWaf7>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekhedutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdfotddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeeikeeufefhtedvffdtgeefkefhffeggfef
    iedvudegfffgffffveevvdeileffudenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehphhhilhhlihhprd
    ifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhgihhtghgrughg
    vghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhg
    rdhukhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:Lka_Z5ZjZYaWdHtofS-FQwbGFGfblSxZBIzwasYWVdtav_bXigGEUA>
    <xmx:Lka_ZzbvL2_Wb8mAavNi9Ax0YWrtNPtTRhO67Pr5Ws5pVxxGhTshxA>
    <xmx:Lka_Z1D6AUPejcRNZrKDxMJtlETHg5RUxvKzELL-nqdHq1zM0Iq1Qw>
    <xmx:Lka_Z5YFGePYLkgGuMTFUfO3dHLkj11Mddn07q0A_VLaS98EDAvwDA>
    <xmx:L0a_Z-xguax8UB9OZr3d9i1pOszxGzqhH9Qfocuyf3yrcjRMOQXj1nuS>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Feb 2025 11:49:50 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: phillip.wood123@gmail.com
Cc: Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 1/2] add -p: mark split hunks as undecided
In-Reply-To: <618d4a61-7480-46b7-8563-221264290ed1@gmail.com> (phillip's
	message of "Wed, 26 Feb 2025 14:40:43 +0000")
References: <pull.1863.git.1740149837.gitgitgadget@gmail.com>
	<43a0592a462cf68bcfdc54373da2319431c3c1ca.1740149837.git.gitgitgadget@gmail.com>
	<xmqq34g79e8k.fsf@gitster.g>
	<618d4a61-7480-46b7-8563-221264290ed1@gmail.com>
Date: Wed, 26 Feb 2025 08:49:48 -0800
Message-ID: <xmqqikowejmb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

phillip.wood123@gmail.com writes:

>> "Ah, here is a big hunk with 10 changes, most of which I like, but
>> one of the lines I do not want to include" in which case I may do
>> the "Add the hunk to grab 10 changes, visit that decided-to-be-used
>> hunk, split, and then visit the one minihunk that I want to eject
>> and say 'n'".  This makes the workflow simpler and more stupid by
>> requiring the 9 minihunks to be chosen individually after splitting.
>
> If the user wants to deselect the 10th mini-hunk then they have to
> wade through them all with or without this patch. If they want to
> deselect an earlier one then they will now have to do more work.

Or directly jump to it with "/go-to-the-one-with-this-string"?

> Currently after a selected hunk is split we always prompt the user to
> make a decision on the first mini-hunk even though it is marked as
> selected when it is split. This seems inconsistent and confused me
> when I first tried splitting a selected hunk which is why I wrote this
> patch.

Hmph, so there is an obvious alternative "fix" to the inconsistency,
i.e., after splitting, move to the first unselected hunk?

> I can see that in some circumstances this patch does make more
> work for the user, but I do think it makes it easier to understand
> what happens when hunk is split.

And the alternative may resolve the inconsistency and make it less
work for the users?  I dunno.

This is totally orthogonal to this "split" issue and outside the
scope of this topic, but one thing that I do not like the design of
"add -p", which most likely was inherited from the very initial
iteration before it was rewritten in C, is that we never ask
reconfirmation once all the hunks got decided.  With 3 hunks, after
choosing hunk #1 by mistake, I can still go back and correct the
mistake even if I noticed the mistake after making decision on the
hunk #2 (thanks to the fact that hunk #3 hasn't been decided), but
if the hunk #3 is missing, going back and correcting #1 becomes
impossible as the program exits immediatly after deciding on #2.
But I guess this depends not just on the user but on occasion.
After all, re-running "reset/add -p" after such a mistake is not so
huge a deal anyway.

Thanks.
