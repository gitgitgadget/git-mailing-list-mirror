Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE266152E1C
	for <git@vger.kernel.org>; Wed,  9 Oct 2024 17:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728496645; cv=none; b=rLBImeXuZ3fMkDCs6nyuOC2vdhtGZPwiNPv0zgjEyNtlbnW5rTeO4oQnbmK2a6CtZvE9VeFKC5wGleQ3XcuPi594Nvk1ykiip5+SJJQ2XATeqec/pdDdNnjb/fBRIbhHq95O5wLgilik9vQwD8Zr+T+mmGfv+Jb8LQq3AX/LF9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728496645; c=relaxed/simple;
	bh=ZTTiVYxQuCBFOfFq9Id6vgRtZG5hO3fo6pa6T5IYBCY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lSUs6jkFEBrYlJREuimFNY6jT11FxgL9XfpYaQfY98OP4TLHxfPsZaQk4yMYsQNqy+tPoUmeGFgARm+hjIj/XOUxGcW4VX0rYSr1HP1UudbHLvUv6NOtfQYv4ChoSVpE8fXKj+soW1nePNRMfBmuQYZthnsfFhSTDPJHtiGGcJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=UOr6Sm75; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fq+nFDtc; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="UOr6Sm75";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fq+nFDtc"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EA0101140149;
	Wed,  9 Oct 2024 13:57:22 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Wed, 09 Oct 2024 13:57:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1728496642;
	 x=1728583042; bh=e4nJ5tY1TpmbnjDcd1+LU31HNuklLx3Y8C9/3hpaU2k=; b=
	UOr6Sm75gcZqjjmcamqzP+V586x1c30DqfcbCbzeWwVW/+pnJc4MdZcZIquOggpO
	MJIWg7dtnrPlTj2TiO3I4Ywz4sPfmn/gvqCH1/6AljmyQcOxhs9veM8JdQf2zdPE
	oq2nE7kirwKF/Vgm0b1vgx0wDMMxIpxQpPWKxdzIFeX+L+0PRAigDN4VAY79xZJ8
	kU+xGaNtEGsopres2qan1xaPQMNgDF1x7AqKfw/yXgVC5T9M5Bim3cN1XrClB5nI
	ZyvQI53RwWuMp1/irIRZK4FiVjaLjRzIqUIuiJOcTDOCiQnhRvk0qoRaCTsVYoDl
	DGRIVUNFVj0O+G93x5944w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1728496642; x=
	1728583042; bh=e4nJ5tY1TpmbnjDcd1+LU31HNuklLx3Y8C9/3hpaU2k=; b=f
	q+nFDtcHISmFt5L9IGaTZiVYiytAepoUnnFWIpXf1Sa/Pgq8tHULd1aoQ5c2hwMZ
	CHRUI5NHRB4mp/i0J0vQFc2WXoS0GliiCFIR7bo5JTGDXCiuRjwaPuSOqSWIXTga
	QNaqstfO42CziULYPpzC8Rcp7WjYDesYIgjuvYgILlDBbFCcQ8HH32JYsU9ehJTD
	2evpfCgo9ZFIFNPBQHf69EITj0cScSMPgV+drLs1HWLnWRxS4ITUsI5u7EsbXxLA
	FvNvyhJKH8skTfK2uvJfsEtFvcHVwSb7HyODcR4WsazLJBvpeNL4YPzWCGvC6+fA
	3AF/MaeJIPtrJdkRCko/A==
X-ME-Sender: <xms:AsQGZ8eGFLUgutCcl7JnSsoV5LDN7GJn_1q-EgsdViuYT2uRyTEsqw>
    <xme:AsQGZ-NIPqT4SPJad7VLGFOwAaJ4iGNZUVagfVpGsNeNXwOWPgRvpYs2T3JBmLGwc
    xaKs4tK2CtdKWuGfQ>
X-ME-Received: <xmr:AsQGZ9hSpeYVjIgTSik5rrPn_uTEXpN4yAVJQXO56PhDrpKfTRYfMnqyjIyoMek1oVc1nqTNFuZZvv6KJYPslh_PM872wPiA4apV>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeffedguddvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtgfesthekredttder
    jeenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnheptdffvdetgedvtdekteefveeuveelgfek
    feehiefgheevhedvkeehleevveeftdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiph
    drfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtghhithhgrggu
    ghgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhm
    gidruggvpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomh
    dprhgtphhtthhopehnihgtohhlrghssehguhhitghhrghrugdrvghupdhrtghpthhtohep
    ghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:AsQGZx_C1bAjAFteg_1p2JvcvykjPNiEdS_ZFxfxqDxW0GND1n9D6A>
    <xmx:AsQGZ4tFQ2rPc68wtwumanZFxMf1vD0uF95RtZ3DbdiwOFoVZAVezw>
    <xmx:AsQGZ4EaKtbQfOBpGMYTPe4PzsuJ2d55rL1PRNEC3gBTBhQXwVT89Q>
    <xmx:AsQGZ3PARsNQ8h0Ar7jBJxPJbUehJGcN4hoQ_y8fQot8b3ZAg8AaBQ>
    <xmx:AsQGZ9_Rp0lZxXr7VqWyixBwGUz2ql78Pxd9yQT0Hjd1FfDyBVZWr-ev>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Oct 2024 13:57:22 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Nicolas Guichard via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Johannes Schindelin <Johannes.Schindelin@gmx.de>,
  Eric Sunshine <sunshine@sunshineco.com>,  Nicolas Guichard
 <nicolas@guichard.eu>
Subject: Re: [PATCH v3 3/3] rebase-merges: try and use branch names as labels
In-Reply-To: <ca5f7ce3-f3ec-4627-b503-6b43695c9439@gmail.com> (Phillip Wood's
	message of "Wed, 9 Oct 2024 15:21:55 +0100")
References: <pull.1784.v2.git.git.1728084140.gitgitgadget@gmail.com>
	<pull.1784.v3.git.git.1728460700.gitgitgadget@gmail.com>
	<19d8253da07624aa14ec78d00b549bba8799c55c.1728460700.git.gitgitgadget@gmail.com>
	<ca5f7ce3-f3ec-4627-b503-6b43695c9439@gmail.com>
Date: Wed, 09 Oct 2024 10:57:21 -0700
Message-ID: <xmqqr08ptb0e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Phillip Wood <phillip.wood123@gmail.com> writes:

> Hi Nicolas
>
> On 09/10/2024 08:58, Nicolas Guichard via GitGitGadget wrote:
>> From: Nicolas Guichard <nicolas@guichard.eu>
>> When interactively rebasing merge commits, the commit message is
>> parsed to
>> extract a probably meaningful label name. For instance if the merge commit
>> is “Merge branch 'feature0'”, then the rebase script will have thes lines:
>> ```
>> label feature0
>> merge -C $sha feature0 # “Merge branch 'feature0'
>> ```
>> This heuristic fails in the case of octopus merges or when the merge
>> commit
>> message is actually unrelated to the parent commits.
>> An example that combines both is:
>> ```
>> *---.   967bfa4 (HEAD -> integration) Integration
>> |\ \ \
>> | | | * 2135be1 (feature2, feat2) Feature 2
>> | |_|/
>> |/| |
>> | | * c88b01a Feature 1
>> | |/
>> |/|
>> | * 75f3139 (feat0) Feature 0
>> |/
>> * 25c86d0 (main) Initial commit
>> ```
>> yields the labels Integration, Integration-2 and Integration-3.
>> Fix this by using a branch name for each merge commit's parent that
>> is the
>> tip of at least one branch, and falling back to a label derived from the
>> merge commit message otherwise.
>> In the example above, the labels become feat0, Integration and feature2.
>
> This looks like a nicely described useful improvement, thank you for
> working on it. The way the code is structured means we always
> calculate the fallback label before seeing if there is a branch name
> we could use instead but as calculating the fallback is cheap I don't
> think that's a problem in practice.

Thanks, both of you.

Will queue.
