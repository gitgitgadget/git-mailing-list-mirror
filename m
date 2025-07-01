Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DDA2274FCE
	for <git@vger.kernel.org>; Tue,  1 Jul 2025 10:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751364071; cv=none; b=p5BW85sU0OXNttrSAf46G2LpVExjgi6z1rVmJnL1bnmmw3WPV6FbUEb0XIMLGiyLcrZjVMT9CQ5Hc0GI1zfzWz7CxNzsYldb2+vTR+dFXGTThvLyUFJ0Trs/1184dxsdlLUJwJYo1TULw8BOqgPiTrUutCUv/gudI8Y/32PJ7k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751364071; c=relaxed/simple;
	bh=bgYXo6HJhKw0/oFI0Rz0md8CkTWx/HtuipcEUTrYYRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dbnRgkW1CFSS1nIevd74aTEWc2jJHgE8WaQ7T34Uu4sYjCxAmCWo9QWc/0JES7fgtv3FXXxg4L6da5n7zfrMOQQlHJSfliM4GoddVy7BiC9bada0ppNvBrCJv+5CtVSdE8LUZ/HLe5SfU9LRkePhTDoxt2yNEd5CeDy7mElrfbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=UrU+lWHk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=B+GjpWi6; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UrU+lWHk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B+GjpWi6"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 2236B1D00011;
	Tue,  1 Jul 2025 06:01:07 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Tue, 01 Jul 2025 06:01:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1751364066; x=1751450466; bh=YdsdEzCDjG
	Pslq1xb21fmNrYOYfZ9v9m0eeR+jdg7dg=; b=UrU+lWHku1yrCLDqR6yKyBqHHl
	YyHvpyfwsWlw5KjZQpy7AT9TGAmdRXEXnId4PMKLklyNo75fbU3eJ4vf00U40yzm
	Sw82vdWBFb1fSuo+70rZZM1uql7MrxyH+VVDwHZskVPVPGhWZBwiniffMNyzr6rC
	8Yhvrd6ejzPgfHEzwoLjd0+mIrqB+PNA2fb1AL9SLZogv55Yz7C2rPW0nqaZk5dK
	jm0t7VSU7EOkii7MDyzFrFpWvJ9v7bWTUxOmadKS+VW5ILr7Zs6j6egY/rpba32L
	WiOz3ElvlZSrfpr+wJkAeVeRB2JVWn5gKh8miV/AeDahFAg5LSDf/bNseHHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1751364066; x=1751450466; bh=YdsdEzCDjGPslq1xb21fmNrYOYfZ9v9m0ee
	R+jdg7dg=; b=B+GjpWi6JTmx+qqAAOAgbeIAM0o9A/qPFpFXOD+fGRLsKdRxrqw
	GZVF55OLPK3CXyc3CayvP3ka2gG4WP3+9pxOnPfZYnRjgLqKSCjMsVd+7lY24RMj
	/1W3mDhHs0GXbDTkvSOHhrhUffKLSZVuq2RcLe0dHlCgVN0msrEFRlI5GyYtcVY+
	NfbgmhInvf5zNfn9JNpUHKLinRBJ/YDnQYNgtB/E4ve+js4yDngV5WQnqI4pbb0G
	WlubjhY0sjsnkejn68/SurCWoJvZ74Vewu+Jqa59fwCYhQxLdPxKOSiwyGnUI6/K
	pRW9fv0+aGUnl7NiQ26+pRJbwg/HLeDz3sw==
X-ME-Sender: <xms:4rFjaEUFBNivyugMGDtv0glkWEMR7mZxX3qrZL7Mn0D6xTyjSYe3eA>
    <xme:4rFjaIlYBJDHM7KSJKZt7q-v0gtCwsAJud00LRlCzUCSExorLifV3lcW-Tr9Xojt7
    kHL7osclF8cCFE6Eg>
X-ME-Received: <xmr:4rFjaIYgEZ0wv0EaLeM6uYWSUaskHSAobHemhF9JiWBl1prWj_xZIpYS7j_VZy7hSL747CEZjUZhKTUnd5pZCuzwHVH4vDOlZzCe88Nwqw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugedvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhn
    rdgrvhhilhgrsehfrhgvvgdrfhhrpdhrtghpthhtoheptghouggvsehkhhgruhhgshgsrg
    hkkhdrnhgrmhgv
X-ME-Proxy: <xmx:4rFjaDWp7rdfuZlDm0F9qCCDXr-fePOKYhmhLlbHR_YGhl-GHfGRcQ>
    <xmx:4rFjaOltw-tQG1ys3crNquXMpk_KtcjENIuLsLXGS07zEoPcD2zLyw>
    <xmx:4rFjaIe-p9gQn52H7TUvbOkByw1WJR1QeUHR0qeypO9WDvhW5xR34A>
    <xmx:4rFjaAH7qh2LO_f-hKX-LVFnuMHJPUaui37NTGeYe63DBpLViTfvmA>
    <xmx:4rFjaJm83vk4yU33AkK3CKGOAZTVG55GdslgidUZIuizhudw4qch5KXe>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Jul 2025 06:01:05 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3a12ea84 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 1 Jul 2025 10:01:03 +0000 (UTC)
Date: Tue, 1 Jul 2025 12:01:00 +0200
From: Patrick Steinhardt <ps@pks.im>
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org, Kristoffer Haugsbakk <code@khaugsbakk.name>,
	=?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Subject: Re: [PATCH 0/5] doc: config: update for the ps/config-subcommands
 series
Message-ID: <aGOx3C7-9NNi7h8Z@pks.im>
References: <cover.1751310455.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1751310455.git.code@khaugsbakk.name>

On Mon, Jun 30, 2025 at 09:10:22PM +0200, kristofferhaugsbakk@fastmail.com wrote:
> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
> 
> Update git-config(1) according to the ps/config-subcommands series
> (fe3ccc7aab (Merge branch 'ps/config-subcommands', 2024-05-15)):
> 
> 1. Document `--show-names`
> 2. Document `--value`
> 3. Mention `--value` throughout instead of the deprecated
>    `value-pattern`
> 4. Mention `--url` in the synopsis
> 
> Kristoffer Haugsbakk (5):
>   doc: config: document --[no-]show-names
>   doc: config: use --value=<pattern> consistently
>   doc: config: document --[no-]value
>   doc: config: use --value instead of value-pattern
>   doc: config: mention --url in the synopsis
> 
>  Documentation/git-config.adoc | 28 +++++++++++++++++++++-------
>  1 file changed, 21 insertions(+), 7 deletions(-)
> 
> 
> base-commit: cf6f63ea6bf35173e02e18bdc6a4ba41288acff9

Except for the issues mentioned by Eric and Junio the changes look
sensible to me. Thanks for improving these docs!

Patrick
