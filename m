Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63683655FD
	for <git@vger.kernel.org>; Sun, 31 May 2026 10:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780224255; cv=none; b=PZGrPky+4P8L2ff7jsyBI4Tnuq+KoUOCzT8OSU3lewThcQZcgINsDEfQD7x9lKZ92koFP25LbFJI7uOztpeFTHaH3WSRuvQmnYmS5YBVEeHnhkOKFVIwi1CuEgbAOlGcNHolnEVgLXG4T8XhZ8oJMwNWK+7LiqYWJ2AzKg8WI4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780224255; c=relaxed/simple;
	bh=rQtoY5bRvBS7kv/EWz4MNgINzXBpsNWuucv8WMBB1D4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HUM5NBdGxse/+4b8c3dVof4bQfeiIivlwlajsfVMATw/Ztqq7XcpKsCsqUgIGk4ewUpnQheBxfGjjdgLXS20S3FnxPrjfGCxZnBQT5KxHGHrpUprBhQQKaGkN6qTLDWU2GEvV0iIQomd775Lt8jtZL4zpdcP7wP9zDN3FPSEvsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=pBKRNFSV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dp6ih/Ax; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="pBKRNFSV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dp6ih/Ax"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 218A9EC0728;
	Sun, 31 May 2026 06:44:13 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Sun, 31 May 2026 06:44:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1780224253; x=1780310653; bh=UtAbT9CPsa
	gT9DCkgoIrGgWlCdK4NFDDwUDIri9PSV0=; b=pBKRNFSVrRVX/OmnzXZzqz3BtQ
	7C1Do0MsnoUUWKW5tlGrcBn34Z9QQ2O41N5tw3iTN52CCByx5oKsejTFKjA/sPuS
	zbSnOYAgIq7cT77BMH+pwgDYTxnkIjV0m0fHiVxfcTBbIkobQwSqCzBrzxOr0Q1h
	0oOWadpnO2Qxrwc1LxVJSlkomYc9KzcthIQDNv92SLmG1n4pwgKgB0Eyxc/ltzMr
	LdBXwkmStNfxJMykW2x06sa2l8Y2PuN4RGZo9jjPIBne4sldOMoZ+NYMxwsVAuYx
	lhm3oN2VRSFagC1uKYxbnimNeb5IRUlUU9FTsGKR48VC8UQkroW4/qQQNYvw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1780224253; x=1780310653; bh=UtAbT9CPsagT9DCkgoIrGgWlCdK4NFDDwUD
	Iri9PSV0=; b=dp6ih/Axad2w1hgoly9bptrj591ySVHeh4/I3FomT24c1WyCzif
	3Vh5CpSEHNd2w1UZo0+s6Z+43HjSuT2XyOC89Vq+OdoCpYBKBTENtQ9W1ekv3lMl
	0vHriYWYHDVsGSkU5rF+G5XTfZGXUgFLIeDYdi5GsDXlfLnyKC8m0tVc+wQkUp2Z
	KW/f4KyGVqc0sPUtNZEXxWX69imlYR7Wfwii6DYeRGo+KJN3BJQ5owpg6E+GfYwd
	nZvN9lamdhXrND7SMcTu2MZELJxgJG79CQrq/tkvBOZW5ma0BfWaXL09M6BzhPXW
	Q1+tsGiPguCgwewa6YtirGHzy9d3PE00iLA==
X-ME-Sender: <xms:_RAcanvQ_FH2MAKAD-y73b1sMwosj1AHJBTpgp5qrelIjrhWXQQp5g>
    <xme:_RAcavcGhkodfnnvxyavxDRfB5jqsAcQvKBjXWKHSNCwgQQ5KedpRqxILS7becVTk
    CGIUG2mIOW-g973waoT3a_4beiq0MkpncPa2M4e8VDxSPUuw94Bag>
X-ME-Received: <xmr:_RAcavzu8DAvE8Zzhf6rwY1tATf0xcOl-lBiTf8FvdDXL1Hh3GGjSEFOI0Oe8I-QiRXMPAVs1aEKutYiIQMwGV7u8FEtAagbappU>
X-ME-Proxy-Cause: dmFkZTF6NyMpg600qiOVLjkSmitSuGybXgw6vu9TjzyopdgdBV83stZrDeb6w5jgfOsoMe
    lipJ4zv49vunm3wPuujZ6OJ6CFCglemaix/QytijpQ9Ii7dRZXOo2IcXzIuE7/2Wpwk71p
    VB83gvv2+rgOIDhakb0PIfRANYFxK5Q0iw4WSn87PprWR0K8/B5n5NQpIxcY4cZ3hnigwS
    awzW0fQry80tQLZhDk9H71d+ON4KrTTfC4W/yNUVAW6OHRpsX+vE4niXFolKRcEEGDiamq
    BrS3AIFDUoKGXEjAkL5/KTNvQuYSbxuBhQUZQwQAFSu8h2S4EfBJFe1XraHWKzoGlKFVdX
    W/Wvwl1Ou+yLbNkSkc17BGvsozJOriJ3KXXFL9G/Xc6Jx5uGGNPRGO8Bq9yV1NiGhg8u58
    C7qO6j61uySL41Tj/oOykKT5dsdtiHjur5v/oI2EY6ktXTCi+J0DRhUu/BWSqdPoLQAMd8
    4LYUFtZlutHGh2ZVjTZCN/1xgwgdkaxF42zlW0SpDEDntlzriMBkhtnf7N8JUvjgudVb/N
    npeNd6qbs4rEBCTW5p6HICUmebXQxgYsCLwTxKMuuYNIbknk07HOT20w3GQGexcYtmHq1B
    1gK9AYLxq9CA17k54X82cqoazNQ2a8r+PVMosq2wmH5Y/eGxv+RxnysllIdg
X-ME-Proxy: <xmx:_RAcalE3vP5-UPPdFm1uyGdqhrtENTKUJHSbcEKP5qCq1HnA-84Y-w>
    <xmx:_RAcajyJw3mGQMFhjlbttSkrbvIw3isBscfzPZNpeGqV8Grmju1jzg>
    <xmx:_RAcamukc18LSAKBqXAtlZ0XPwaTd45_RR_2lnsuSkU5qU-_eZ0nTQ>
    <xmx:_RAcag03hG44ypwn_Lgw-pM4LhKut9eWDenDzK6ieEeG5p7cKP5TBA>
    <xmx:_RAcaltUytWNH3748DU_Zcy5Ack3NAjjcQotdc-PZXvnWmO3INkQGYgc>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 31 May 2026 06:44:12 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Michael Montalbo <mmontalbo@gmail.com>
Subject: Re: [PATCH v3 0/6] [RFC] diff: add diff.<driver>.process for
 external hunk providers
In-Reply-To: <pull.2120.v3.git.1780087700.gitgitgadget@gmail.com> (Michael
	Montalbo via GitGitGadget's message of "Fri, 29 May 2026 20:48:13
	+0000")
References: <pull.2120.v2.git.1779733799.gitgitgadget@gmail.com>
	<pull.2120.v3.git.1780087700.gitgitgadget@gmail.com>
Date: Sun, 31 May 2026 19:44:11 +0900
Message-ID: <xmqq5x43dfk4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Language-aware diff tools (e.g., Difftastic) and format-specific analyzers
> can produce better line matching than Git's builtin diff algorithm, but
> diff.<driver>.command replaces Git's output entirely, losing downstream
> features like word diff, function context, color, and blame.

This seems to break CI on Windows; take a look at

  https://github.com/git/git/actions/runs/26709491830/job/78717295153

for an example.

Thanks.
