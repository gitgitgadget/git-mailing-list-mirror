Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A0B2AE6A
	for <git@vger.kernel.org>; Sat, 14 Jun 2025 04:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749873937; cv=none; b=LVTvIZMkVGOhrdTnD9oCkQYASaLAy4UZalv55gsgxMpvmE1kS3Toxg4V4NF/fKne3Gw6D8/O8COFp419FwkKKNdUMoo3eff9s3nKNErs5J1eV9RCJBlA48J6egVB36g/efcjSTUk++upxdrMGN0FSXl4I+hjDwZc2tWysyM6iqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749873937; c=relaxed/simple;
	bh=SNr0qgVT58YrmUe7Ygo5Eao7ehVAAJZcrjznvVC9NPk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OLA7MJ6bUuivBWFOQTXEznVKTZox3w7dFj1hwnenoPLuo3tbmgLQaxn7LM91k8WfCfsn9heeS081gm5HwjQmuI09LJjUzcq0WUfVPIouM5GHje2lOXenznW8MHDjObOUw46zs8Ze8G3NK2gKPIrK/XvYOj2yG5AGiXZuzGTajUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=u1D7esPZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ea1lu2NB; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="u1D7esPZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ea1lu2NB"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id D190911400E5;
	Sat, 14 Jun 2025 00:05:33 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Sat, 14 Jun 2025 00:05:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1749873933;
	 x=1749960333; bh=AVt2NNTtONxmFjlDA9hroOc6w0CczLh/J7fnHrhR8Bs=; b=
	u1D7esPZVOP5qpLtFCu1L5qCV40Acjqqioh/j9EzRWHqznSjOXfLEqaap0HJ09oT
	xHQEIoSQAYEKm5JE9f/stZe/9Xs+y3vafBgK4+7xZWmOG46TjhLwcfXCdiKW5bXz
	7kTSp6vbLkvr+qkg6tMVe8Lzxm2z0lMi4L6EphKyGErdfMTaG6eVUoZomjC5BWAi
	YZkGNAp6o0hdHzHZY3ogLMj2kZpE7V7Ihi40GRz03kFMtZ88Br/OtvkivUPg0ZAq
	0kzDN6zoIZR0HKNY6srIiCzr/oiYl43ofPSKHblFoK/uQ//hfoDRK7TBAa+Twksu
	S/PtJ4R17QU6BckJ65zYHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1749873933; x=
	1749960333; bh=AVt2NNTtONxmFjlDA9hroOc6w0CczLh/J7fnHrhR8Bs=; b=E
	a1lu2NBwPlzM/bFnW+6JivdQ+dfUMINrajcWIG0/tXTzDqMtlPChpEZfFKUR24z5
	mZj2QrZFAypsRMMp+Apm6DoEiPUwKy1VJULtl/gotSYM4hTgROmnKps9wQOGtMr5
	3ugvXPe1oAY5tcFQAo/Zb7pL4MI6z+R18LWGDfO/0ZoDI7DCVr17vGEN5nv2kuDQ
	Rl4Qfs/Ku4uQZ4a75935EXU6x/VIhNtcZ+0qj/zFevVudVGQ+l7GqlQvuyD6PWpb
	o5/VNmEGaBoZK/bzDk9go5dt03BVv/6YK6IJYHZZEZqOyuvDMFUaY4qu61GS071g
	kcuZlTiYlRblt4iBybQeQ==
X-ME-Sender: <xms:DfVMaLwgieJ5Y0b_uenkn_8KHJjEUlbzWnk_8N3bN6Rficn2IeSyTw>
    <xme:DfVMaDT0ESWUEWIIbJEeEoxpuft7pVKv13j70DpY_psC5-p61uX-_J59_CdlOcsvt
    elHLaX6mtg5iqasDQ>
X-ME-Received: <xmr:DfVMaFUKXBk4q_YzoLJ-l80Y4XUe_LZY5nsfCk6FgtdWl42-H5qS1JOv0eyVucKH5Ij7kFKApUd6KuZffVGpUgIyd-YoF_oCzKLO>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdduleekvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvve
    fujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihhoucevucfjrghm
    rghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpe
    dtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveevfedtheenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvg
    hrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrg
    hilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtoheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhrtghpthhtohepgh
    hithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:DfVMaFgwuP4mnE4xD3qnODuq75SiGusrqvXOlHHPxk-RH3D57mcDgg>
    <xmx:DfVMaNBpPw2JIq1cyGW23OG-9STbHe8ZJ6E8sX9xb5I-Gs2gPZEZdA>
    <xmx:DfVMaOKJtwkBWq0lbzfh3Re_lg05YdcDkiEtt5_9PkkOoXr97Sv--w>
    <xmx:DfVMaMBS_JPXqOCkmHwGKHxFh6_F04ilsRjzyDj31ES_O9gd4je-xQ>
    <xmx:DfVMaPy6x-K6aq9A6gxuESZyIBOCrh2O8YK6RDR8yGJDd9Iih-A2cR_u>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 14 Jun 2025 00:05:33 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: Re: [PATCH] doc: provide clone commands for the pre-built docs
In-Reply-To: <45581cb36fbcc33992cae5b740bb801e2724aa90.1749833159.git.code@khaugsbakk.name>
	(kristofferhaugsbakk@fastmail.com's message of "Fri, 13 Jun 2025
	18:47:04 +0200")
References: <45581cb36fbcc33992cae5b740bb801e2724aa90.1749833159.git.code@khaugsbakk.name>
Date: Fri, 13 Jun 2025 21:05:31 -0700
Message-ID: <xmqqv7oz6k8k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

kristofferhaugsbakk@fastmail.com writes:

> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>
> These repositories need to have these specific names.  You could end
> up cloning the “git” organization htmldocs repository[1] which is named
> “htmldocs”.  So you would need to provide `git-htmldocs` as the second
> argument.  But it’s easier to clone the GitHub “gitster” user
> repositories since they have the expected names.

I'd rather not see people do that.
