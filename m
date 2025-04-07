Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63021F8916
	for <git@vger.kernel.org>; Mon,  7 Apr 2025 15:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744038696; cv=none; b=P/d0H+HVNfT6F416XMWM3uAO62NmjxxRFUwHr13tEwCtoLY1FtOx4sMdRKMaTtcg5tisOriQHj0tugPCxVt7rNFxVFGQCP3Hlh6jjlqy6m9gxbvy8rmtHdvKe12C9z0aIgdTCKR6B3pm5sz3nhmpju+xechlxpOVzR5+nIgXYTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744038696; c=relaxed/simple;
	bh=2VsRDnvA+ND6qmOnetTt2aAngOaG8b6wiIR8+gFtZ5Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=e79xUAgPPIykllVt4wpnuuWR09IsNtWI5jnCVCi2+wziBmuF0F24RnHsf/EhXzRuPnwK5KaYVkB8TFsnPL2QUiFWtyQHRw6qoj+hTe+Rr/XtpTyBHB8z6DvjU9nbZ1vg97yghVFT7i2Lx/siHqWG6xRX0cAMLsn6Zxs35iy0J94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WWlXnaBB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SEFVIO2A; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WWlXnaBB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SEFVIO2A"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id A61BA13800B0;
	Mon,  7 Apr 2025 11:11:32 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Mon, 07 Apr 2025 11:11:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1744038692;
	 x=1744125092; bh=bM9uucouHNHINKoNi4eUZPUKe5JqifofZ6R196P16Nw=; b=
	WWlXnaBBodmURLP03iadcwWKNE4c/mex9DX34pjgAfPF5rbmplOGT9xivo747v5V
	OQZg1c7uUPHeqG+TSndBhPTOps3NrC/vqWgGd1M3QY9q7bdHrO8QvJBfAY8pokGd
	CyMy2ahIfwlOCc343JgX7N9NxXX3lQlA3+lEun37jsXoD2B5RG4+R/O6NOb6IMQN
	9xeuIj6bAxlwGymCsQqNc0xsHFaqiLA0vCohjeNe7GcNh5DteqVILcsJZnyAxMIu
	gC88ZyNj69NsZND5pTFoGJFrr34+AH94nsTGI5RlftbDH/wdy+Hy1qyPsmPuvC0a
	QETAARAR5Z4lx37suTHOoA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1744038692; x=
	1744125092; bh=bM9uucouHNHINKoNi4eUZPUKe5JqifofZ6R196P16Nw=; b=S
	EFVIO2AJ8YCyM3nT9ITnXXawMi8S608VI5qR6DVqAM8yFYEvZXjm1HnpHEfCScjC
	3dljHRzRuembMP4/+uaHossKgnfNJFbYFwhRJjUhUZaczFhvOl4Hcu3KXVxb54QQ
	qWYgdQtg1wibm9WMUL+LbaWpOAoTbeimDVIECYDu+giYGToZFk7s8ccDfBjGYxgg
	7WPmTP12/Di8BVGgvMfQ9+/0Mdwtnijifa7iTt/fP50xhGJS+4VVFXw9UclZyKiv
	6L9sR/Bxcsr1kuRNQEpMnaIa4+tvNdQlqlidPKCGj4brQyN0Rtw6+Gw3Vrmfzf2a
	fM/wkiodqgvcdvugRTGhA==
X-ME-Sender: <xms:JOvzZ8cdCXLRMyxxcPH46QWQvxnDTIht7WBBJwnewYm8YQZjpdwsvA>
    <xme:JOvzZ-OTDAz1UwtH_q7YhDAWRuuu8vGfUwV1g3bTJ9YG3G9GIsX055qA1bwDbN5Qc
    oa8RgBIinHZsWgUaw>
X-ME-Received: <xmr:JOvzZ9hB3ZSJyLWtHf5R7kF3VZIuRQaf6FkiEJ1e2Ro5hIKWcG_UvPdgfUuBBZlNDKjl-bk2uBtoBT_61S7bibUo5baavmpuxGje>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtddtheduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffgffkfggtgfgsehtkeertddt
    reejnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpoh
    gsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeeiheduheelveevtefgueeguedtuedu
    ieeghfeguefhveeihfdvveekudefvdffjeenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggp
    rhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjnhdrrghvih
    hlrgesfhhrvggvrdhfrhdprhgtphhtthhopehsiigvuggvrhdruggvvhesghhmrghilhdr
    tghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepjheitheskhgusg
    hgrdhorhhgpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:JOvzZx-FYHN-SAvSJdnZ4F-kB5aHAKYrBQ7IF5t4h-dBGkxHUlO_1A>
    <xmx:JOvzZ4tMiq4ae2o3MOVcAdpzxjftSXHPJyD3XgriL6xd5lWBn95cOg>
    <xmx:JOvzZ4EVsizkEHpQFaQU-HgOYHRQwdCyuMMLXjBHWqE_3TfbfNj6SQ>
    <xmx:JOvzZ3OfrirdRmlDNp4svPcg8F-_Vhh4QBL1cTy-ygU82eZQ2LU9dg>
    <xmx:JOvzZ3DjrRHIBW5HOMoeknCNQMSCMis0kZzJvkGFYh8xe-ALMNllwEHn>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Apr 2025 11:11:31 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Cc: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,  Patrick
 Steinhardt <ps@pks.im>,
  Johannes Sixt <j6t@kdbg.org>,  git@vger.kernel.org
Subject: Re: [PATCH] doc: fix asciidoctor synopsis processing of triple-dots
In-Reply-To: <dfe21538-e70c-4d19-a90f-2c3cf8d3d377@free.fr> (=?utf-8?Q?=22?=
 =?utf-8?Q?Jean-No=C3=ABl?=
	Avila"'s message of "Wed, 2 Apr 2025 08:49:40 +0200")
References: <Z+rUsCW0zEb8kAK8@szeder.dev>
	<20250401110811.117851-1-jn.avila@free.fr>
	<xmqqecyba6zz.fsf@gitster.g>
	<dfe21538-e70c-4d19-a90f-2c3cf8d3d377@free.fr>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Mon, 07 Apr 2025 15:11:30 +0000
Message-ID: <xmqqfriknh0d.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Jean-Noël Avila <jn.avila@free.fr> writes:

>> The .gsub() changes seem to interact with your "doc: fix synopsis
>> analysis logic" in the series that updates reset/mv/rm documentation
>> mark-up.
>> 
>> 
>
> I will incorporate this patch in the reset/mv/rm series.

Thanks.
