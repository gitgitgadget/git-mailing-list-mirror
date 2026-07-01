Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F203536605A
	for <git@vger.kernel.org>; Wed,  1 Jul 2026 17:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782925940; cv=none; b=PosODcA04MxNfpmAHv6BFF7XVulvisXmaQ9qcEmdpAe4LR7O6+Vg0i40hp0R5ebyV+7aoszni8L8uzAljVbMhgd+fQoqt1k+9gQ0v5GZ3xKJcT1eU566b/1kGfn/Dzg4oqGSG3VPNr70gP62cDrDo7pfhC1FcVcvG4k9ctbrUwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782925940; c=relaxed/simple;
	bh=l7cID8ugX7WPVgbsl6fa7WH33Uoo8uTQDRvvfT85BkU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=obSmlb4zZ41LZ1TDybdP7wHY4C/UX/HQVULKHLqnXsk7Y4oCymRPi9/xyjSSa6eQz2opYuOjgyOATU8AnKYr4pEE/Jsq2afM0Yh/Rjwr6ZN+4G6JeEfCi8LJiBFY2s/B06j0FAeWFSTZQ/LoSt6w7ygxE7TB8+e7q8oZ4+Pkjys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ACXBoX1x; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gJHHhPus; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ACXBoX1x";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gJHHhPus"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 36ABDEC01C0;
	Wed,  1 Jul 2026 13:12:18 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Wed, 01 Jul 2026 13:12:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1782925938; x=1783012338; bh=uwV72iEi9H
	a2TvfRvksO62SA5Rwe2wl6eO4BoNIPkgA=; b=ACXBoX1xu6+MlNS/nE/yXp+vRN
	0lwcoEPm+A9kq0taq+icgyA5z6sYpUHsKLMf5yVPh90siO3o2QU6SoZWuyrpHMYe
	j5ii60/t6wvyEwkVO3b8dU8ccVLWTGVnBz5ubFeXvkahzDmKQG75tuQWaaK6rE0N
	rddXW5LHMRIGzwA2EIUum4fdDYhGlra6UM3KoQafIVSi/Vvqaj/bk7yNG6H09kXp
	FUkVE5wLBPlCfCtG4aKmfXV0fCiKRUUejTnpGEtWm/0RULtk24ziEytnaLxEcR4x
	5WUqHRq6791iEJHCjLL3cJOjpbZ+vEt2ed2fWxl8MKuccYvvTKlyB+RPWGOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782925938; x=1783012338; bh=uwV72iEi9Ha2TvfRvksO62SA5Rwe2wl6eO4
	BoNIPkgA=; b=gJHHhPusszx1PHC1523nTvXMw7D+v6zdiOMF4mWCyBnIjHDit7r
	jNs/opx70fMmZZUimULwjs3OioAFXZfRuXkb5ZymCPo9PSFnUTckwxPv6Ee0ywD7
	5oVTryzAQh3nGF2MD/O4bBWasxFsGnfHoCy7Kxyy0Otvliy4O3ajMvhKWAISbyle
	cr3kzsLwNm1X5qyD676k/7J0jGlmC/ZsTlrR8switB4qTF1YaiX/a06mebhguoeC
	6OsE3G0POhQ3ylg+q8C6mFmN+P4abFgP0HvUnzcj8zvVdoL3fGm0zx67ND7KzIRz
	bmrU9pmBIP1wGt2SDmkWRutuxpDrMsXxWow==
X-ME-Sender: <xms:cUpFajMALxcwkm9aLl9rp6H0e0UdUj-epYt7wS9SAZoNcvSSL-acmw>
    <xme:cUpFaupV5BB-FptcEUKTXToYvu1P0gAgUTtghh4oqRc1fE0l-lblSqjvvb7fUjOb3
    _Ulsfn-L7yD3nMPVE69Ewj8OG7gDseOi4kL7saX5zJ5ktH-egAtKw>
X-ME-Received: <xmr:cUpFagel1b1cjYwYKH-O4VYxmLmFJo8lzrbDVJr8sfJYMLHwnF_1JVfV-LqF9Oo2Qw7cBemc8BVNAU4--SzucYsCEwQqj-_BuBHOabQ>
X-ME-Proxy-Cause: dmFkZTEmvVpNnXrBkYmr9W8F1b6PXODrsMuYEq9R3vKPgOpdl7mSEV4P3uOJs3dRsq82mY
    1S7TyFz/0MtnNCoqsFaeC5TDPht1PIFyiB8Wd4bk2bb+PzwOpLL5A1XY+SClWU1hZ+zeZf
    wJddWqKhMLCbIVrveY3DIPxylbnR3N6cqWawa5akLz0rtEkLV7R/T2qk2rM1bJ8O5kbEkg
    uSRLnTX9aIvOOgo9f5I/urX+sj82xE0XsHfaDEWQNxALZ8ekLxdQbksOaZuCXP3ZghsAoq
    cPL4Ieh7EYNxHbSPjBuOxEhi0V08xSVA2Ukp2Z9usrrHvFhh9DHNckP+EW9klWALVTVSkM
    6ur9oGRYvxBS1Fqw9hS+55a7PgMsvOQCxYqk1voZchqjteHKriDSpaQa4fxRnMM2nvAFP+
    qXSpcP7vwiiGbhLl5PJvWu69GUHem5k2F9z4dNqw46v+a3KIYA1v/JppTQglxyKXTy+1cf
    wGSrKalIBeSSj/8RB+GKocuA+F9eNNJ44pOzc7Ben5HLfLSiUZBKtGUEpMDaLmnFMmvuMN
    QPha6BTDCGcaaNOc6B8czn7V+Sxr3FHPHyaNaZSsLEKTPfGm/rhH6pwvnnKFbtKGY9IAjn
    1RKuH53Rd2wE6EXQ+KQLjJvIB3kuYPv7X133m9uBTIDjiDqJo1le4BHWorgA
X-ME-Proxy: <xmx:cUpFasTt_EyDeuqHk_gBazb76Xzh8u-lLgoNVkgAkcJ-B2o6AAGkuA>
    <xmx:cUpFahaw2aEC9X_h0g8YX1gC4D0JWmKgDHcIhRV0l4UUdOyqZi8cUg>
    <xmx:cUpFane4lHR5QDBSUPMwLoP8APmUjZRgYRMvwusuXSzOrb4VyvZqLg>
    <xmx:cUpFaqIyThQgga6oGN-QuqhBwS1zma5zhlcrWuCrjx3g5A2uPs9ZBw>
    <xmx:ckpFapZCwfAnc1KIePo4lNh8kotudvhieu65LRlnbyrDIdCVedhBtGCt>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Jul 2026 13:12:16 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Pablo Sabater <pabloosabaterr@gmail.com>,
  Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,  Phillip Wood
 <phillip.wood@dunelm.org.uk>,  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v8 00/11] builtin/history: introduce "drop" subcommand
In-Reply-To: <20260701-b4-pks-history-drop-v8-0-19b5cdf1facd@pks.im> (Patrick
	Steinhardt's message of "Wed, 01 Jul 2026 13:35:27 +0200")
References: <20260601-b4-pks-history-drop-v1-0-643e32340d55@pks.im>
	<20260701-b4-pks-history-drop-v8-0-19b5cdf1facd@pks.im>
Date: Wed, 01 Jul 2026 10:12:15 -0700
Message-ID: <xmqq1pdmprbk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Changes in v8:
>   - Pass `RESOLVE_REF_READING` to make `refs_resolve_ref_unsafe()`
>     return a NULL pointer when it cannot resolve the reference.

OK.

>   - Drop unneeded code that sets `head_target = "HEAD"` on detached
>     HEAD.

OK.

>   - Add a test case that verifies that we can drop commits with
>     "--update-refs=head" and a detached HEAD.

OK.

Sounds good.  Will replace.
Thanks.
