Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900A717BB6
	for <git@vger.kernel.org>; Fri, 31 Jan 2025 22:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738363248; cv=none; b=cSkK7WEdPSy4QhI2yoC+YKgoH/emj+L5SUZjhv2Hw/csgW/mIgKgI97h+jyY3ufUZ3dZlMLS/lC/C7letX/+lmUTYBkCRzrksuzNjwGvc9JwU3TP9i7nuZXWMnS91YGZnu/e6uN9kUY0NDdtmb+luAESQLYIPXCUWDX3h6t/kYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738363248; c=relaxed/simple;
	bh=4ij7lhGex8mqY9n0yLZV9g0Qs66pwmK8hNpJU9fPHo8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=p5nWA4dxwj56YqMTwEyUEFH3vmGsuJTo/knt1Q1SXoFosm+oMJRJozmCD3VnR23T3ifX+0AslqWrSDkXBmsTcOhS9wDjItruHWq69h+H1OsuMy+f/ALQd2/6Hfvp8aVPdtzgjjBtKk30xreLDAxgmN4nPpwbZhEdHe8oASt12Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hzmDHZTH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qQMX9nsJ; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hzmDHZTH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qQMX9nsJ"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 8DDC211400FC;
	Fri, 31 Jan 2025 17:40:45 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Fri, 31 Jan 2025 17:40:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1738363245; x=1738449645; bh=4ij7lhGex8
	mqY9n0yLZV9g0Qs66pwmK8hNpJU9fPHo8=; b=hzmDHZTHtGYn+zT0hWUHDRivqa
	4fBpTh7+R3OpWrD9DDWLUKLBDYt7alTxJkG71d8qA4WMGp0ojvhenDoW/tI3Ek5/
	ZUhkNJXAORmJOvG7Qqk5O23K35OAnZSOWahaSDOiy7VuyqrzXevKCH9GQt9Ll8vy
	/+CfaryHQDltZdcqoC+CnP1TbJg0l3KiCS7Umssqz9wdcNvqiyFG1Wv7g/iQzhy4
	QSFSGjCqn5k0qwthm4uCVmJQWok7ukxY6FK2FHOoNqrguVUwjQLd7IoweQetcF7c
	VqHv+Owfvl6X48OKQIwHQ6Wbf8EXrVcs7dxpZueyscbyA3oDSSAYrC0hmGuw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738363245; x=1738449645; bh=4ij7lhGex8mqY9n0yLZV9g0Qs66pwmK8hNp
	JU9fPHo8=; b=qQMX9nsJFIjg5E4Fa4KEvZWnH4D5R8XZVyTCWVRryIwdpk65KnC
	KVCDDAJiOLkrnslxPPCRmw8WN/xjIk22Gn26OqB7qz2zuEBFF/TcQHDWIY6OnIj8
	5XGvt5Ri8t7wGHKSi6MYEcETr2smNervxBje0VHpucWk0KsvxSEn5I6V0cdmHTjn
	75Kurt5ixBZ5OElCWqklGNn+cF7K78ybtlUFLETsNL6qEPEohJnbZIKb2fwglfB+
	sDlpv79uXz26+kDLecsUBXdWxkXc0IIUDHwADW/yPH66cUGZ9rpKG1eGEDG2A/wk
	u3OJb8/e8fjW3R4o0cLAFOrCwQpCZFrCZ8g==
X-ME-Sender: <xms:bVGdZ93QSRrczokEWvoRkNYYdVqcFrXgcxFOfsAP-DKVBFCAU384Jg>
    <xme:bVGdZ0GYxvwcZVKqP6ABnBeYugHGEJHctwZGCLwfZSkrwftC9C_xPK3M4vMS5MdNQ
    051LyTB3mOucKacCg>
X-ME-Received: <xmr:bVGdZ96Rpb4NR_TsZVJsXBrNaQ1kTPDLPRJh6czzC6BP1ZtQQeCTzAm7exUSB4F_FFlccjnH8k36MsywBAVWiheH_Xc9xtQfVA26>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutddtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrih
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:bVGdZ637Fy-3X8-pNKOaHJuuaz8ndbhlbLDiuz2-dkMdwWDoCBBhMA>
    <xmx:bVGdZwFbE98abN5awfSjixfmlKbWLqB17EhzN-NNhtTrCV5BxwYuBw>
    <xmx:bVGdZ79B06KIge5XIRPPEZ7e0MSWr3k4MEFTbjZcxTXB98pvWjOhSA>
    <xmx:bVGdZ9kpttF77rQ0kiqwWEx1j00uQo9xzZBD5tuRUUVFuCJKRiLIGA>
    <xmx:bVGdZ0CAVDqFlXsJDH2MYoskLRGTfTqMkBUb0Ko82QICklg-KA2bbuXV>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 Jan 2025 17:40:44 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/3] setup: fix reinit of repos with incompatible
 GIT_DEFAULT_HASH
In-Reply-To: <20250130-b4-pks-reinit-default-ref-format-v1-3-d2769ca01207@pks.im>
	(Patrick Steinhardt's message of "Thu, 30 Jan 2025 17:24:19 +0100")
References: <20250130-b4-pks-reinit-default-ref-format-v1-0-d2769ca01207@pks.im>
	<20250130-b4-pks-reinit-default-ref-format-v1-3-d2769ca01207@pks.im>
Date: Fri, 31 Jan 2025 14:40:43 -0800
Message-ID: <xmqqr04i61zo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> The exact same issue as described in the preceding commit also exists
> for GIT_DEFAULT_HASH. Thus, reinitializing a repository that e.g. uses
> SHA1 with `GIT_DEFAULT_HASH=sha256 git init` will cause the object
> format of that repository to change to SHA256. This is of course bogus
> as any existing objects and refs will not be converted, thus causing
> repository corruption:

The exact same comment on silently ignoring applies, but unlike the
previous one, converting the entire history is far more expensive,
so it may be much less likely to be worth going the automatic
conversion route than the previous one.

Thanks.

