Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08451EFF9B
	for <git@vger.kernel.org>; Sat, 26 Jul 2025 17:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753551924; cv=none; b=cpLnHHnPCJFoifbDTq2voA+uxoGEFuPF2vo1N/fgjwlTp31j/jBvVQpchuR2u6QD2Z2pSweYk9J0k9PNgee8ngbZ/cwum+sFfyq2tv8cR8Tbt5tRlxbn2mesKS/1IzBDbxGnzlkHIPG/LwY+xU6Yz0Y49lRM2MGZqv8q1F7b3pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753551924; c=relaxed/simple;
	bh=W7K3k8afU3D9u3+Z97JC+o93WIK4VjOLec8vSBXzPJc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NeeygeyNr+wNkZhoF/20K+5yECAwScWGRpEiNmtjTorDRP5arO9nT3N9iHPiZLz6wdhY7oycULCK0oRqTGWM1TqpQCjuqOf1RwBIwypDenhvbnU5eMgQliYeAIRDE8/zwUTyI2bl9IPgz1oXRCn1BpVl4hzSunQfUuP7i8kdJC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Q/N8oecp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BxchwkP8; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Q/N8oecp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BxchwkP8"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id E9A291D000E5;
	Sat, 26 Jul 2025 13:45:20 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Sat, 26 Jul 2025 13:45:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1753551920;
	 x=1753638320; bh=CXxn2V620ScvEBO5rcaD4CHKvtU9Pc6NqwfvmmsVBn0=; b=
	Q/N8oecpCrfr8Got33zltQ6QCAEk9LKSE8HMxOoya2cTXsiEwz+E/1yOk4SU2RIM
	hYFzo7yjXMv774zsjMK6SyWTtrGVoyOfpEYhjgo0GkhpyJglUhabQdDArNRNzDpl
	Twm+Zf9dw0bOb8u3ydr2kfxuxx2Z8MWa+jh5BZ9Bq/KJWGW1FXz1YNzGWMjMtYSf
	mhHvISD/Qjn11MTWdy+gGrXcru7G8VgUAEe/8Dq3uDoDRChrBwPGFBP7zCushP8+
	vacpPFGKSXVXSqoa7JpoE63UqEmwE2eZkRiRHiHl2qTtbWSKAqXHUBytLG92JBO9
	DppAO45eHzwslRIkEy0EOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1753551920; x=
	1753638320; bh=CXxn2V620ScvEBO5rcaD4CHKvtU9Pc6NqwfvmmsVBn0=; b=B
	xchwkP81pikSg7v6ZlgQLb6MAlh+8JIK24os7EtFYatviY4jCYuHS1jon3h/noWb
	CyRhaoWi1bxLYhqxSdBo9IEac1YAswG0R2uw9afvmiqFD7o/Y9dom/zEiFXWnjBY
	0d/8UilOQzAZ1WD4VDyL6Bh/U5jyMz9Vc10YrOIE+qYP37cTWDomFqOXRQINJDFl
	yV1BEjXiOttfnH33OvI9IMA/QIp3HwPSM2BEF3/oImSI51/dzYt4m2FxktEIdl/+
	IU3yx1LMeM6keSF2uQSbTjlgSI1Ppa8XL4YJBhAkqspnwNXSCd7oX1oLiix7GumS
	9yINISRvngKeGzZ61JkWw==
X-ME-Sender: <xms:MBSFaDt6yhEmqU6x3rRmuxdZnb2rN35WS1zcT6pANt5TuJ_Y4rXsKA>
    <xme:MBSFaHsV6YkPNhHJxmQl3xCrxzYEpgJtAXHmT-ESi7J89m017sdK7RsLXrymUVpFf
    YdCjexlVZLwNlFI4g>
X-ME-Received: <xmr:MBSFaAMruYFHF-XIaqQOo_ga02QN5TSIPxgCgLljS_vHTn6iBRkHYA50k9cK_ICqQzsAikgFVyn7_eT5NHcsXo2cVRN9FkUmy5QqqA4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdekjedthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepueefteeufeefvdfgudetjeffhefhuefhkeffhfeiffdtgeejffehuedvgfej
    ieehnecuffhomhgrihhnpehthhhinhhgrdhurgdpshgrhidrkhhnnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosgho
    gidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htohepuhhsmhgrnhgrkhhinhihvghmihdvtddvsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:MBSFaN19oUM_lID0WtsBih839rTHM9rshg623zJZal1_5wSsHE61vA>
    <xmx:MBSFaEOmJJtKOAV4lqVGF-qSj3MaN3nyfBsm_dXW1hWVJZd5xdGmmg>
    <xmx:MBSFaF0Gksl2UqLYuhhINxPliSEgrLtEpOO7ZDZou7SZEtGJrH_j8g>
    <xmx:MBSFaDEEz-voKEkVcsjMyVAdcOZfgFiWU66rLPmT0TZ6effsrvJ3iQ>
    <xmx:MBSFaMURZhhaj_MQjFOa1n47tehrInBSsCncTGIMK4Fhfn08616kFm-i>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 26 Jul 2025 13:45:20 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jul 2025, #07; Thu, 24)
In-Reply-To: <CAPSxiM9Udi2PxpT7f8DdLn1ihny2gW_H=ieLjV25sEFYSdAjMQ@mail.gmail.com>
	(Usman Akinyemi's message of "Sat, 26 Jul 2025 07:33:31 +0530")
References: <xmqq34alik2g.fsf@gitster.g>
	<CAPSxiM9Udi2PxpT7f8DdLn1ihny2gW_H=ieLjV25sEFYSdAjMQ@mail.gmail.com>
Date: Sat, 26 Jul 2025 10:45:18 -0700
Message-ID: <xmqqldoa26dt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Usman Akinyemi <usmanakinyemi202@gmail.com> writes:

> On Thu, Jul 24, 2025 at 10:48 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>...

Administrivia.  NEVER QUOTE SO MANY LINES from the original if your
response has nothing to say about them.  Remove the part you are not
commenting on and leave only the relevant parts that you are about
to respond, and then say your thing.

>> * ua/t1517-short-help-tests (2025-07-21) 2 commits
>>  . t5200: move `update-server-info -h` test from t1517
>>  . t/t1517: automate `git subcmd -h` tests outside a repository
>>
>>  Test shuffling.
>>
>>  Seems to introduce a few "todo passed" when merged to 'seen'.
> Hi Junio,
>
> Is there something that needs to be done here ?
>
> Also, some tests still have both the `git subcmd -h` test outside and
> inside together
> and the first patch of this series already tests for all the outside repo.
>
> Should I send them as an update version with this patch or wait till
> this gets integrated ?

As I wrote, with this merged to 'seen', we see "todo passed" in the
test result.  You'd want to dig to the root cause of the issue and
update the patches if needed.

> Thank you
>
>>  source: <20250721115519.140361-1-usmanakinyemi202@gmail.com>
>>
>>

Also do not leave the original that you are not going to refer to
after you finish saying what you wanted to say.

>> * kn/for-each-ref-skip (2025-07-23) 6 commits
>>  - ref-iterator-seek: correctly initialize the prefix_state for a new level
>>... 

Thanks.

