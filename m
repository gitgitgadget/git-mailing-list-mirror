Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB16225332A
	for <git@vger.kernel.org>; Tue, 11 Feb 2025 16:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739291761; cv=none; b=lf/z8OG5ZvvpY9c5YpDuGDy6bZ8UFogaWYlhiQ3rWNsyVVLsNM4Byvnh5PAjXcF/WP+WxDzgpq30LjjIlMWaqqblMeTa1UiFWdIbx58T4pu0iuXeLEK7C9MBqmo3cv3ic5+6gmO0pxggiGEv+vcttlgddpgDlyZW09nrjmrdN+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739291761; c=relaxed/simple;
	bh=bE20EojJyizE2YAwbjD0yRk3a+A5fQaGfcx2osTbe68=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uc6RRHKayrU9QrpprfP4DbPHUq7pLIbFbNyeRYJ2r+YjdJkrsMwcnxiw21nnib11rdZIzCCV/N9Er4rJlq6yAEUFGGhWxFjZ/UQjRgu4zaZVOrwdo/pbpszc9r2DwZ3J8gcFLf7LAbJ7dqBlqIVZoEfTm+dXvSzcqjPoXYEgoD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=EpYvza8R; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ArC4QXi8; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="EpYvza8R";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ArC4QXi8"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DD12C1140211;
	Tue, 11 Feb 2025 11:35:58 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Tue, 11 Feb 2025 11:35:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1739291758; x=1739378158; bh=WSepud/Inv
	bKoP6pvNwAbOCXrbrkJKvCaxjju6tAH+Y=; b=EpYvza8RkSsJxvS+J2KCxlEpDh
	tUhDMJayM1t8PeLkiXsFlA4L2YlaUsPliX2CroUWJRHfEkEQE8RkiW96rpuciJZb
	8z+uQ45sBckT9+D55epElJUrsJIPmqxWPxgmpjMU5pjSKPJnR83/KJAlxwTn6trc
	e5fp1sJRKmY3bOF4D+dC5j0bDCZYsgvi4UvUGy/CRtsioH0raYWJ0CbdUS1Tuu9f
	xnKPl82njXeDWH5UyTPfZB1j9VPZEJv5C9xswMxb9tmr//rGEdezVoHnPxbVCokm
	VLynq7qiYY9g+nnPu7O7VOjJGB3uxzRYOTz3HuWOu7qq8e2o31g5jhv4UTOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739291758; x=1739378158; bh=WSepud/InvbKoP6pvNwAbOCXrbrkJKvCaxj
	ju6tAH+Y=; b=ArC4QXi8YdgkXF6DqHSvvVRZGkIbao/RaDI4AlGCGsPD/n6cZ0O
	Qexu5zg71kQ6c1g42ZaEzS3/V1XSDHpQ1VScSD5RpijmfhKxwuM2OtgXRGyfrH6I
	A2TPtipXrWzUW9UcnNBqOzqF6fOnAWjmCzWUs9hTDYZch6DNe1gebBsoSDBFEpDJ
	Doc6CoNp+H+Udkzvej3VZeaKj/rzEi+7gjLqA1oeSoftjcbnpPskPmtuROei+Hds
	z8LCQA+awC2G5p4o+xvz5+F+JEMPUrEuFaCGoyy9Bvgdztpb8O5QENVZrYk4d7a7
	Om78nmnL4uy6JAL2b+R2VJ/xjJ1wgCCal5g==
X-ME-Sender: <xms:bnyrZ4WMXfy7GRs9-iRnGNTXP5ZSu9jZpaWb-0Rgx4z4fR-VgmPgAg>
    <xme:bnyrZ8lupqiVD59qhxdYZmIH6614fKSYeZ1ZCIEXecLaZ7lbcOJPUUvfsAXhRibet
    2BkOSVSYxTpL81Mlg>
X-ME-Received: <xmr:bnyrZ8YZEr0ZcMde5Sheak95goUGIwoOzOHivdCSqO9aMXxfjv-0wX9KOYFAzdRDK03pLfbTLBqQx6XiQ8S_cA5Ai5TlHrj1Ic2uHDA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegudehtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrih
    hmpdhrtghpthhtohepuhhsmhgrnhgrkhhinhihvghmihdvtddvsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    gthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehs
    hhgvjhhirghluhhosehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhohhhntggrihekie
    esghhmrghilhdrtghomhdprhgtphhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhi
    lhihrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:bnyrZ3VJSH-k5VgeIflKfEVsxOySLkPVjTGsJiwO8X_zy2_czcqFQw>
    <xmx:bnyrZykp5o2lVO1hSBKYzJu0sxNbv3Gur-kSoxHyaW34_UqxrfejoQ>
    <xmx:bnyrZ8f4rDRXZS91LK0QDEABTT9WLC7aGg2O8D1hCpkr2yhSgejnww>
    <xmx:bnyrZ0FIOjF9SeOis0LlO_RGmyfr5eBkJsNfcsvsmXRdA7qdfG8gBg>
    <xmx:bnyrZ87_MktOwf0EjFv9eAMOR89QDxQaqs3MHeqOVpxH4y2nLVJ2kS0V>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Feb 2025 11:35:57 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Usman Akinyemi <usmanakinyemi202@gmail.com>,  git@vger.kernel.org,
  christian.couder@gmail.com,  shejialuo@gmail.com,  johncai86@gmail.com,
  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [Outreachy][PATCH v2] builtin/update-server-info: remove
 the_repository global variable
In-Reply-To: <Z6r_pqqP5vjJI-R5@pks.im> (Patrick Steinhardt's message of "Tue,
	11 Feb 2025 08:43:34 +0100")
References: <20250210142820.3588250-1-usmanakinyemi202@gmail.com>
	<20250210181103.3609495-1-usmanakinyemi202@gmail.com>
	<Z6r_pqqP5vjJI-R5@pks.im>
Date: Tue, 11 Feb 2025 08:35:56 -0800
Message-ID: <xmqq4j1030cz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Mon, Feb 10, 2025 at 11:40:30PM +0530, Usman Akinyemi wrote:
>> Remove the_repository global variable in favor of the repository
>> argument that gets passed in "builtin/update-server-info.c".
>> 
>> When `-h` is passed to the command outside a Git repository, the
>> `run_builtin()` will call the `cmd_update_server_info()` function
>> with `repo` set to NULL and then early in the function, "parse_options()"
>> call will give the options help and exit, without having to consult much
>> of the configuration file. So it is safe to omit reading the config when
>> `repo` argument the caller gave us is NULL.
>
> Thanks, this version looks good to me.

Yup, this looks good.

Thanks, both.
