Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E963AFB03
	for <git@vger.kernel.org>; Mon,  8 Jun 2026 22:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780956997; cv=none; b=DU9LifptvZ1kEyY0SEBpH6t8qOU4kkcZYO7iaUPhMBLqTpl10Ion8YLbgFGJd+L4GQlYe3TSlSmTeHjO8PmOdTJSKKNsFMO6hjt93NKZmnrq6xUjwfZKzT9BHGgwLUhZkgpU+lQFbmw7fgLrnDTx3e8GVt718bCFqEyDbzC0iJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780956997; c=relaxed/simple;
	bh=5hHZFPRySrNQvyAf0eH7u6DjnWq/bPblYF4x9OJUvxo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BS3O7f8AdrJK8htaiIAMOd/uWJpAblALuqjwSLKGgcvG/gr/L8cUC15qYFx8mAOrurPV4Bc++ixdul+w0Fpn+A9yay0EXm2ZPpHLz7U3aSvAlyEyOv0k2l1O0EbxW7e3AHs0EI7uDHw78bmDO+zqozweVKBehs8OI5kZ+uEKaI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=eU+I7Mea; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=g10gqlCv; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="eU+I7Mea";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="g10gqlCv"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3D01E7A0165;
	Mon,  8 Jun 2026 18:16:35 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Mon, 08 Jun 2026 18:16:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1780956995; x=1781043395; bh=E34L1TyahU
	+j4JPz2jMtTuVC6wIM2GRH/LQSVB1dlwQ=; b=eU+I7Mea8svSUpwSkLZ02E5IVk
	nvctAvE3rFFw5JQm6QQqMQZCT9p/n0Tw8Pq2l7cPFFQJ4eIFc/oUCTEqF+KNq4Hd
	mFLwnkyIIyA+NY7WLwZacjKo5X8esnJfyEaRjZiO+xMBL2JiCtf5KB88ZMZxOz8L
	Q8rKyk8hAje3Z3ay8Sd5P/dgBP77t9KsArE0USCM2dLKf4VIiqxFYkuRutzCRsmf
	3arbslyDxsJJCUcEBiAeC5nTz7mxV3w9WFvfsJ+7UtVrcx5eVgTLA6OigKOxIAm7
	5b/7uPctOXO43LqgoCqq4aXt38h48GsIpbxaa2t7xU/MGZkKCMZp0zVRD6Uw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780956995; x=1781043395; bh=E34L1TyahU+j4JPz2jMtTuVC6wIM2GRH/LQ
	SVB1dlwQ=; b=g10gqlCvEsOEwmjMVJv2J7FMI65mrfIVl62vZD5nhlLD2XWleke
	gKxrUFlADON8kfFGxnNJ4BNYNK+pDNCJ0+Axuyv5e9ypfDaRCTOhqzxXc5p9yn8x
	xDCEMoQg+xim9QHzieEIxxiJN3G+y4mo4GI2yqTzS6BG2f2+6c6L/BrEWlXgeHs3
	6ZvSpKgzLFfE3XpAIiL0QkNP+RuB4X0DotNuwS6yV/azhgaNxpel6dpGJJNuujZS
	Izh9/1NKBD98nYZHj1lH0nZbE/IA1NGwJhm9NG5vsXE5s9mAR6YtATl4FlEzyq7J
	zYLH6oGevkEQb18/SP3GZmwRvCpBzedLI0w==
X-ME-Sender: <xms:Qj8navWmib7ZTryQsEqStFBvcy3lQtvkjehEXXLJwCJ_1vxBcpKHXQ>
    <xme:Qj8navArSt5YbazAMPZqb3LMYYUNq84fcke3h2bFMsZN7lM64jVY1NGWhHtS6qnjy
    zdrUA1UsY-nwIbOGS0l53SvyZ5hGV4uftDLprFzYhsscyBmcBztrA>
X-ME-Received: <xmr:Qj8naoxdzB5pUEV7CLiXIoaqVG5CZe9dfXjby8p3PoSStrzth1qamwYApqdnzbDMVllFFLEe31v0NHtTqCmDpxBrLLDzwsQkh5QQ>
X-ME-Proxy-Cause: dmFkZTF26AcdjVouEdSuelpq53KU7uc85vqTH4wTMRIW3UX+2p5Gflc0ieIAFpCsqRKNH9
    YXMoItPGVV9HwOUkZC2djOgc70JSqYfP+soDTjEW4UIKg9diVTMz1NmFAcevhVDF8zhdNr
    ftKXTJ1Zl7lEdUCXNKE1wgkuRkBOR8HqEzYvmnK6yPkCJD1gvlOEiBPgcqROl5Ngn0sxcM
    8Sf/599ajK7frw3OANm9iNye3lk4JKoZbZlx1/31ltxL2LqUDq+zui3l5SuVgpwBHZXhto
    iXYkD6sK8SX/3uuL85dIA8qIu7IarnVbkSq32YnQsOsmF90JUjEfJE5/cnfUqoIgk0myGb
    ZwtOFYsXp8ZGqaM3GpYS30ei4kYeeExZSREKg+EKToazHSHUg/e82u8lP9A7L+cpbBUMO6
    4oiT0nZincWZ+xIEZMv2uvmRa5QfsWfivNWUx4UbOwq0Kz8A1JhasBouIFqiEWX2/wXM5N
    r2+ZOtluQiH7L6PeQdJ5zMErdkVbTnmrLe6TrAMYw/umC01F36Wi3sgpQ8S0PBoSUVaIBG
    91+0mu8Wm3VSTZBmWCaAFOLljCACKIMpYFgoTk0iLR5pjJnEMqWJHvKvjFff2Q2+jAVjL1
    T33erVsBkQYjnyLzUxzAcnRI7TqwVI0xvA56e181cRXLZdQ0JWrvx5PTAPSg
X-ME-Proxy: <xmx:Qj8nakAg6kaFb8cM2Y5IKt-wrEw_uOIxvSnj7aVv6qG-9FoFxtHBVw>
    <xmx:Qj8nata2CjBP0sAEJ0yzvnwTy7i7reMm98WjWMZCHZyiOh76z9df4A>
    <xmx:Qj8nakierUAnEFAv3cRLa7-xDdmlp_2CVnE4DTIJnf7HFrUlYdGQHA>
    <xmx:Qj8nan4eVE6MXvtB5avxICWj2GrIfIBAtjYGBuiGxXDENiOkTwWqgg>
    <xmx:Qz8naiuUwVD39nFiQVfaPBxuyMkkYJ615TZx3aRamIMi0zZb2USKmqza>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Jun 2026 18:16:34 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Tuomas Ahola <taahol@utu.fi>
Cc: <git@vger.kernel.org>
Subject: Re: [PATCH] docs: fix typos
In-Reply-To: <20260604131457.19215-1-taahol@utu.fi> (Tuomas Ahola's message of
	"Thu, 4 Jun 2026 16:14:57 +0300")
References: <20260604131457.19215-1-taahol@utu.fi>
Date: Mon, 08 Jun 2026 15:16:33 -0700
Message-ID: <xmqqh5ncvfsu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tuomas Ahola <taahol@utu.fi> writes:

> Fix some typos and grammar errors in comments and documentation files.
>
> Signed-off-by: Tuomas Ahola <taahol@utu.fi>
> ---

Thanks, all changes make sense.  Will queue.

