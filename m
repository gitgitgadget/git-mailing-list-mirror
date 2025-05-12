Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C0123CEF8
	for <git@vger.kernel.org>; Mon, 12 May 2025 15:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747065237; cv=none; b=qcoXi3h7x8ovsqH9xNoXvatpc30nU5XB346FkXBvq0HIA8kzBF7+zi/pqFi7zB4swxLohC7mKjjkfMXsAh3Sy5q6dd3lw33Px+1Vo+yP1O3ouSmMbVf2jKv4nYlBLoL9RR+4FjtL/cJ4ZB8No8c4NEIwzgvbb0fm36+wdxYtaT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747065237; c=relaxed/simple;
	bh=nCcKDJLOP5eB+ermkTIJVfRH6Gmdw/1Lhv6X+q87AY0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kdQuRIGmRMQM0b3OVHT6eIjk69gLBFUmjU4OO3EQjx+QunSu7wz4dNXUmsRaSFhLdtHPzuoKruQ4xxOR2PjcfSq0cYg7LRjGfBmqMVJhRjTIDIaOiyKAm2u6FtkXyjV2cywZnX7M2+On8ghDyoFYFckWwR1dkJoB0gDwQ9kkoA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=km/soKxO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LeR1vVTw; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="km/soKxO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LeR1vVTw"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 3EEA9114016B;
	Mon, 12 May 2025 11:53:54 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Mon, 12 May 2025 11:53:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747065234; x=1747151634; bh=5fDWiQLixN
	E0MPaDURessMbkXxb+zQGoRR2fgRzP40c=; b=km/soKxO6ciuPeg2wmNQVcq/26
	yTTvINEzWw8mVaiw3BTMrvVz0Jtiz+g8P7lrWFVf+Z9yXO5Dn7C70VwoNR2NmwX4
	b+HVStutHeWcRDo21SH4plo1fLOyzoGEQL7qUenfgnOnDGhC0st5j3dqYeYyj2VW
	A1dkMOFudsD64kJpn7zRJPo5xUo39ERgAPHTyqAabdCuK5dvAU7HKx85MySsZJ7D
	49LdiP2njfkPef37L14p8t64H8pyP3QH2S6WQpZtx/5Cq0q4P/UTJvdnLVAnw/gw
	tPK5QOdVTaSi+MOcjC8XOnOhA9zd3TLD6bP0TYN5dY7MNznHfeidQoyTCeVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747065234; x=1747151634; bh=5fDWiQLixNE0MPaDURessMbkXxb+zQGoRR2
	fgRzP40c=; b=LeR1vVTwyzF6I36eS6qFOqlJn5q3cHZqJDH6tlHrjy9pcWu9YFi
	DKyyytSXAc3lRU4ElcLYjiG4G8NwU/1EPE7ZIc+9wEXzkUHx8361kRa+QUYQYeHZ
	trbwQ0TWP7vj8hTCCrB75VVF6S8eENtUizcJ21FUs7IXzSEA9Fk5cuNw5xH1dZI6
	7XspPEaS7FsaMkrNC8V2AmwPiFZwaduUzsXY2beZPdj76F9sitdvzOfh2hW3Gxd5
	dnUMpMPdtaZZVPJWZM1zk6owO5hzO5LT0rSlBg22OuJnjTxW1wKPvTZ7rPBZc2Bn
	o2SanaHezII2dUdGPDkiEJSbgrQwex9ruew==
X-ME-Sender: <xms:kRkiaHDENobeDKaXWF8uTVY9lutA5E2PxMSHfeL3kvfGlRFI0imn8w>
    <xme:kRkiaNhfBNnhGkCC9bhqiAfZBWTN8a_Z1YbDs0Y8l-YNkmH6aJsvDnfKoAjIT9Tmm
    Wx0CE3bvHVoXsf1hw>
X-ME-Received: <xmr:kRkiaCk3efcSjjh9FeUmwuM-VA8XkiJw7mm8wb0rW2_HEs64HsAc017EKE_K-XtopoyPHBhO3CzSqXfiGXbbYUrlzY22tV3X_OS9erk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftdduieejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiph
    drfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehsrghnuggrlhhssegt
    rhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtgho
    mh
X-ME-Proxy: <xmx:kRkiaJy-2vKMSG_a3z1gDH5Z9PnnAI3r-4VilMW5-ZljNtEVPFlrbQ>
    <xmx:kRkiaMQUdyr_blSNSNMA9YV6BkszQH5OuNsFW-OEsxhB_MZcD9aPPw>
    <xmx:kRkiaMaL8q4JkqDSoYaMPM8h5J8Wt54a54D0LSFBqI2yxdBZL7Xc8w>
    <xmx:kRkiaNT4_mcMs7sk4-56hOt2ecowJD2hUFSTIjeZ5zkfizRWIMTHmg>
    <xmx:khkiaHlpCNus2CmyXDOkk1UGEy1E18fTPs8oPhgiV3tQaSYXUUotpV1O>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 May 2025 11:53:53 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,  git@vger.kernel.org
Subject: Re: [PATCH v5 3/4] builtin/stash: provide a way to export stashes
 to a ref
In-Reply-To: <67ba7cf4-e6b9-4c05-9960-e95fdcd4ed97@gmail.com> (Phillip Wood's
	message of "Mon, 12 May 2025 10:10:28 +0100")
References: <20250508234458.3665894-1-sandals@crustytoothpaste.net>
	<20250508234458.3665894-4-sandals@crustytoothpaste.net>
	<67ba7cf4-e6b9-4c05-9960-e95fdcd4ed97@gmail.com>
Date: Mon, 12 May 2025 08:53:52 -0700
Message-ID: <xmqqplgdvn8v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> I think the commit message would be more convincing if it concentrated
> on the need to import / export chains of stashes and the convenience of
> having a dedicated command to import a stash as one can export a single
> stash with
>
>     git push <remote> refs/stash@{<n>}:refs/exported-stash
>
> and then import it with
>
>     git pull <remote> refs/exported-stash
>     git update-ref refs/stash FETCH_HEAD

Oooh, then as long as the other side has enabled reflog, you could
even do

	for n in $(seq 0 N)
	do
		git push <remote> +refs/stash@{$n}:refs/stash
	done

and we can call it done?  ;-)

> Having said that I do agree that adding these new commands is a good
> idea.

Yeah, I do not think there is no reason to oppose having an export/import
pair.
