Received: from wfout6-smtp.messagingengine.com (wfout6-smtp.messagingengine.com [64.147.123.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D759F4E1C3
	for <git@vger.kernel.org>; Mon,  6 May 2024 01:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714958166; cv=none; b=du588FIHgtIEg6Zlr+ITZvPORNl8t9GqXVGLHsdJmkhRjzZCik2eRwPJLb0pag6ezir4862SQ6/tx9I0fbvDQU3oc8shGmP62CKmEQT0SWmmvTXjeapCHa6SnF1qkZzvsh8/E9GcfKHBvA7J/OJFvJnL2DCuK1KZjT+Gl9fXCAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714958166; c=relaxed/simple;
	bh=azxRB72Gk2wNbYNWSNPPiatsVWVutYtCRIKGFu7d/rc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:
	 References:In-Reply-To; b=dpZVx3OQQElKsDBxhumbWthcG1LErUFvCHJoYYnP9wrIj36cmPWKRh9l/kO+KStCxTXyA0U/AZlDWhHK3dxxI5qPTAG1AZytPcoUExLuQmZ9QhJsfDq0njuXpuAiOhTG9e5SE370nLiKns5tBbvO8VtzPkdM9EGVZoCVlYdX5jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jamesliu.io; spf=pass smtp.mailfrom=jamesliu.io; dkim=pass (2048-bit key) header.d=jamesliu.io header.i=@jamesliu.io header.b=PM4fm48e; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=A5rJorC8; arc=none smtp.client-ip=64.147.123.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jamesliu.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jamesliu.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jamesliu.io header.i=@jamesliu.io header.b="PM4fm48e";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="A5rJorC8"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id 143D01C0013E;
	Sun,  5 May 2024 21:16:04 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sun, 05 May 2024 21:16:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jamesliu.io; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1714958163;
	 x=1715044563; bh=Tno9AUwS33H0ArgSCqTsdsKxHEW9mzywYQYA8uvVZqI=; b=
	PM4fm48eos9bTUEqjEZTmZ6x/31TZGht1PuECduMNct+Y0XL+F4pAIxA8CNScdNe
	HePGYWJnc0020aayRvfsKWMKJnb7ANLDCeYMnY9jW8qZXqDok1jIJ0FZapu1Jhxz
	/9ZF5uElyNJ3h7UyMV6fiBeB4wtabTgDLzMhSCi5lto/vHSB9Kiq2ZU9KleDNJHt
	Glo+4Z01+vurhLm8CpzRUf8GDwWtIQKGXzTJ3taUFJdgbahleWjcTtErxFRlSofZ
	1VRZyHWzC6ufgUKoxve3NpCxnhqeFcDOm5ObSnifAHohw/awgvi+hG8tuvNIB5V6
	HwwZ2SLxvAVzuoKHn8sihQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1714958163; x=
	1715044563; bh=Tno9AUwS33H0ArgSCqTsdsKxHEW9mzywYQYA8uvVZqI=; b=A
	5rJorC8eN7XRh4y6iUm3Vq/bj7TjaScY6omd8Bqni54UALv+tqvyHzS3CfZ1Fejt
	W3hFyynzbQg2MTK+31HM8K279DBywBYBU2aZJWp5VCEEUdCvbTOwS75RvbAwQGfj
	B7vjo9gx2/TxSsMSEmm8GkgBIr+XsftOtKD4H8yDDkbmfZNnTQoZpK8nZU6DoxBW
	pU+/I+/iJysRKN19+GMrTvFCsKRfqm2HWKzQWynWyWtx8NXIREqr0B7j3uwmpJ/w
	ybcAczYlBgjso0mmRrMtZtkANCj5TycjWUEIkfoyNXjXpjLN6kKjC8eF0deadijj
	Nn4G4BEGJk6qR6KVrvN2w==
X-ME-Sender: <xms:Uy84ZtqFqfilvb-PgNbWOzzn7-JBwOvxBFrvvqb8tL7hStbdaMu_ZA>
    <xme:Uy84Zvr1Xee6lXj8Hw837m5Cs5TzDwqg52C6bU_uf-n_h4JKsoA2EsVLi7jTNkXSv
    rBzgkWYgInXV7tO-g>
X-ME-Received: <xmr:Uy84ZqOv2HNHyDYCehytRDBoGvgmqiBqihvRl6OIOJtRnx8kt1id2W3M9jGB_vNxQqRpsm5nljiea053tiJA-EvEwMup_AS24DCI2ITf>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddvhedggeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepggfgtgffkffuhffvofhfjgesthhqredtredtjeenucfhrhhomhepfdflrghm
    vghsucfnihhufdcuoehjrghmvghssehjrghmvghslhhiuhdrihhoqeenucggtffrrghtth
    gvrhhnpefhteeuheduleettdejkeduleeuiefhveehuefgheehvdeikeettddvveegieel
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjrg
    hmvghssehjrghmvghslhhiuhdrihho
X-ME-Proxy: <xmx:Uy84Zo6mNoqJEz7xmfKC9RNaGkOVeozTpB23wCndFr7rji1LiiOsiQ>
    <xmx:Uy84Zs5CFN47X8-zU4gEosv_zKw9L6b6CkWyRoIRYjxmYSbXVbmU6A>
    <xmx:Uy84ZggidH3UXb73NOfR4_3qaDoUQv23-fG1i0zYifx2fm0ReYJY-w>
    <xmx:Uy84Zu4-A4PZPKKOx2VtIyYRorNOTiE9jBhdXrwR3OX0dTZKx7hlYQ>
    <xmx:Uy84ZsGbq4wyMj1-uYbBR5V59-EcDnMFR4C4yUSPUhsRb_TfFZYIMjpx>
Feedback-ID: i93f149ec:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 5 May 2024 21:16:02 -0400 (EDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 06 May 2024 11:15:58 +1000
Message-Id: <D125XHSBVOV4.3H49JX3P4UFIM@jamesliu.io>
Subject: Re: [PATCH 5/5] refs: remove functions without ref store
From: "James Liu" <james@jamesliu.io>
To: "Patrick Steinhardt" <ps@pks.im>, <git@vger.kernel.org>
X-Mailer: aerc 0.17.0
References: <cover.1714717057.git.ps@pks.im>
 <47eb6aee922b1e17caa76b2e7366d9bdf26aa6e1.1714717057.git.ps@pks.im>
In-Reply-To: <47eb6aee922b1e17caa76b2e7366d9bdf26aa6e1.1714717057.git.ps@pks.im>

On Fri May 3, 2024 at 4:28 PM AEST, Patrick Steinhardt wrote:
> The preceding commit has rewritten all callers of ref-related functions
> to use the equivalents that accept a `struct ref_store`. Consequently,
> the respective variants without the ref store are now unused. Remove
> them.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  refs.c | 198 ---------------------------------------------------------
>  refs.h |  72 +--------------------
>  2 files changed, 2 insertions(+), 268 deletions(-)

This is very cool, Coccinelle is a TIL for me.

> @@ -560,17 +519,7 @@ int refs_for_each_reflog_ent_reverse(struct ref_stor=
e *refs,
>  				     void *cb_data);
> =20
>  /*
> - * Iterate over reflog entries in the log for `refname` in the main ref =
store.
> - */
> -
> -/* oldest entry first */
> -int for_each_reflog_ent(const char *refname, each_reflog_ent_fn fn, void=
 *cb_data);
> -
> -/* youngest entry first */
> -int for_each_reflog_ent_reverse(const char *refname, each_reflog_ent_fn =
fn, void *cb_data);
> -
> -/*
> - * The signature for the callback function for the {refs_,}for_each_refl=
og()
> + * The signature for the callback function for the refs_for_each_reflog(=
)
>   * functions below. The memory pointed to by the refname argument is onl=
y
>   * guaranteed to be valid for the duration of a single callback invocati=
on.
>   */

`s/functions below/function below` since the non-namespaced variant has
now been removed.

Cheers,
James
