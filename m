Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60BB2586F2
	for <git@vger.kernel.org>; Wed, 19 Feb 2025 21:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740001059; cv=none; b=Kmfi09861b6l6iTEXWyxJeW+Z+a9Wju7aRSgbiuIZQjtJiDH5lVWu6SpSaGa1dvULEbk6t7hEtE30gIRU8BESUtBzXTn3+UZdwyu/9wpz88ecdKi8s/B23HQ9d4YtENHKqEUkMmNJ54Gkrgk81YvShfvAefIUUfcFB/VXMtPSyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740001059; c=relaxed/simple;
	bh=KqXRZSquR53EQYoAO3gPVfU2NVFOYx/SekZNfLKZSeQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Rm0CN9PZzS5R49Xr/mt8+8NdMEeQVPomepalJ4PCzIdg4mJWyBWEQgFhfa6/I4/Rpm9D08+nCjnSNovCXSFR+Nm4O2iqMFulUIFZ/uBncSGcdB3sbw1fM2NVQQ2UK5OhJ3+WjsAnSC2Z5Bquw4VyXpuBHVhinPNTMUToV1B8tBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=SlCnDLgD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=k4ArHAzL; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="SlCnDLgD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k4ArHAzL"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 8F48D13802BF;
	Wed, 19 Feb 2025 16:37:36 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Wed, 19 Feb 2025 16:37:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1740001056; x=1740087456; bh=KqXRZSquR5
	3EQYoAO3gPVfU2NVFOYx/SekZNfLKZSeQ=; b=SlCnDLgDkrdpxDD1HxSndIpVlj
	vm88crwWzBSgAIKD2MOtjmrYQgc2GKvscDnLCSIclBgvRezkwvp9n6tAjeDBNGr1
	nxKUOf0vtjS/e0mI2yzrJMT4gNFkWHEphePduTEooVilgG3XElSFs6MZ0jsGsTTt
	NXWy4ilDJokvMU4L5L6QI+yqQx7uu2dRPE3J8zn3DbrBi+FasMpQdoDT6vodbe7O
	yZhp9NZDOxYXvCDW4edpqQ1kUqR6jLot/+hzFp+ZCFtkSn+2DN3D0HntDwvpjIEq
	edNZ71PvSvk8GhUDtnxMIx7Ee3exJ0bPGLO8O+p8uYJoWPuzSiQ6RUCaeaqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1740001056; x=1740087456; bh=KqXRZSquR53EQYoAO3gPVfU2NVFOYx/SekZ
	NfLKZSeQ=; b=k4ArHAzLulSM6ksUjwOi2JZI/GLOJ63NDcm0I31yYnDf4Mh2cpx
	34awQyidr/3GNkhPQbcYsJGyld613+US1V632U/U3TtZ35nOLqppRKwnM2SSUbwG
	xGyreMCF0J/+wOxp67n5fsx+PZwplAohVmr25PkHWemDKHnSMTGtcsuYDB/qVuRL
	ywLcSJWkktdrjrj1KHUwSTARzYCLrUeuNdHmy7rqjN7nc6XSgPKUCs6eqbkE8avs
	1xLw4jbwPvs3Z4npat/nB6ftEZr/ybobt+zvcObS1Ezx4ZJYNq2sYQ52mzuMjF3B
	f+34CRc0/CtYWeErecnMv7UD7pb3u/hkOTA==
X-ME-Sender: <xms:H0-2Z21YYQiqKjgJz-N0gsYZJAiPbdTFoEQlRps94IewzWQrrpPHeQ>
    <xme:H0-2Z5GwVllkbfzTc4i_RlHcXd1Dn01Q5c6aggpxd8n9PnjEjmQ2LsBp6szODfpwa
    zIYm7UxZTR6YKotWA>
X-ME-Received: <xmr:H0-2Z-7Ll2eQoohWVdmOXhvsYlLgEwoqLThG-WfclwHij4vwUA78Y04htTAYIwD2tVE9yWEsqK11J65fdnUpI7ZSAReUkFZFhHqktDI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeiheefiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkrghrthhhihhkrd
    dukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hpshesphhkshdrihhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:H0-2Z30UJSXpS6v-vzyZrr5u4jj0twh_ykTJbGJRHzsBCeLhTFZAoA>
    <xmx:H0-2Z5HLsaZQByUIEPgrM7-fJA6tV0XFz0zSGNOzgS7qIFrHWS8xdg>
    <xmx:H0-2Zw-PKp9wBAVserOTROBMlUOmS5zFMmic6rRysihpIPbHmFTGnw>
    <xmx:H0-2Z-n0F1gW5B_Zoib8M6dpecIrKtOhwHZ7DS6MHnoAm5bD8UaapQ>
    <xmx:IE-2Z-6yOYC2kHcwOyB7MTMdziGuG_PH_pU5KRum_vlUF2CAXMiobIQs>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Feb 2025 16:37:35 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Toon Claes <toon@iotcl.com>,  git@vger.kernel.org,  ps@pks.im,
  jltobler@gmail.com
Subject: Re: [PATCH v3] builtin/refs: add '--skip-reflog' flag to bypass
 reflog migration
In-Reply-To: <CAOLa=ZT025hWSG0JuoWTUe5aDgPg1fcHDaAhuQ+CxHQ2zvreXw@mail.gmail.com>
	(Karthik Nayak's message of "Wed, 19 Feb 2025 12:28:02 -0800")
References: <20250211-477-refs-migrate-add-a-flag-to-ignore-reflogs-during-migration-v2-1-991a2ec9a796@gmail.com>
	<20250212-477-refs-migrate-add-a-flag-to-ignore-reflogs-during-migration-v3-1-98b2c4d2bb0c@gmail.com>
	<87a5aiqmeq.fsf@iotcl.com> <xmqqwmdlg92k.fsf@gitster.g>
	<CAOLa=ZT025hWSG0JuoWTUe5aDgPg1fcHDaAhuQ+CxHQ2zvreXw@mail.gmail.com>
Date: Wed, 19 Feb 2025 13:37:34 -0800
Message-ID: <xmqqcyfdfwf5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> I share the same reaction. I didn't consider that flow of thought at
> all. So I too agree with name change. Let me push in a new version.
> Although I'm not sure if, Junio, you want to wait for the `git reflog
> drop` command that we were discussing before accepting this topic [1].
> I'll leave that to your discretion.

Well, from my point of view, "reflog drop", if can be done for both
files and reftable without too much hassle, would be a greater
addition to the toolset than the value "you can drop while
migrating, but you need to remember to pass that option" gives us
;-)

So it really depends on how involved the work to add "drop" thing
would be.

Thanks.
