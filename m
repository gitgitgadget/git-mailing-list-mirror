Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81943E49D6
	for <git@vger.kernel.org>; Thu,  1 Oct 2026 03:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790825404; cv=none; b=e0KTssJ5limmUVNzoeEP6yq8zLUue/9FwmqhgJppjOlRb6twwpNz7Eyh33rW6PBk8TXQ5fKGsyoT1g4GwEyVc/AvCry1yrwBk7BhHuOgcMGFhTsE1iTHRh5phiPuUQgDOWErKNzFXh84dVkiC15xZS32np/E5dhzdANv00MCihc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790825404; c=relaxed/simple;
	bh=aSw3O6i6dZiddqTmIdF5VEqQiQ3btaJqXAM4SxKzro0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=f+dnyeb3rhaMoY1IYJBnDw0Jkeuoam+zZNyrw9Slp9wrBY5JZTZhQUn8e1vsg6HUKd315HtaaLnGRhjY85ZTxbPE0zUfDFw8ObyRb9l2TbtC8BSycjKn4lZa5qcnVYqirbEzMhhKmdf2/vLHtcM7xfY9ZIkjl6xDjYdVLK5o5oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=LpU4Kk6o; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qvo5LxU7; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="LpU4Kk6o";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qvo5LxU7"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 228E07A00CC;
	Wed, 30 Sep 2026 23:29:52 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Wed, 30 Sep 2026 23:29:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790825391; x=1790911791; bh=MGNzhOge8W
	z2IgWto0eyyT/vB5ZQoXMcIK8jmwfEl58=; b=LpU4Kk6oXR7Ob6yxlX/0VQLev2
	avKinSzAgzbB5/sZQu3svBQT7PpRyjkpB/gym1Ak/Kl7AJEKChVWow56RIcG/RPT
	ir6zWVtzORFzEMviYlsVv2Q0DZQ5xAhk6zHjFE77rsVFTr4hAUbz2KfwpLbJUlwQ
	XvPEOoXRUTa1ENLBGztyrUivDsRnUrp+WJxs9uEEpOUp+ZZ2JKuSOJtN75+9nrMT
	iHZEvl3BLVMp7aUdNiJMcmJ0RjUhVS7CQRjOXgEUdazYe5o+8GFhBC9Pm51aCbub
	+ri0Swkj6Omb7hDrbKtHxio5NKrXDc/2tudgywK3ILn+ZuNYojiAq3mYzFEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790825391; x=1790911791; bh=MGNzhOge8Wz2IgWto0eyyT/vB5ZQoXMcIK8
	jmwfEl58=; b=qvo5LxU7aBDad9mUkLp+sBv/jEFv5XRT4sGM7jl5ZEpee2JEQP4
	B9qTF0gD8MI1iuZ9+ol3FXEJ6CmPVCntB5CaMXF1C2bqqnXK/s9MWMOtJmYGD5ZL
	L48Hucv5TkXxiy0KptLkZ02napK3vIu0jeVmzcsyCVzvQGT3OMv/Fk+1wMm8Ac6H
	E5QV26RzQdI+phZUGMOMs6BZMTOgok0F+k3hyZneWwrz8DcYlqEZP61sq0DouaEg
	Zo43fSDAHq86+rnJanvOMMGGhsPNopUBXlTEPOPo9WV/168lnsHZ/OCdd9htU3el
	g6jSS8FhlhaKhztsi8SNGflaUq1cPzSlNvQ==
X-ME-Sender: <xms:r9O9ap4LFKyOFyQF0rgsbEqjcCOl1x0Ea7vNSAeaF4rziptguNldog>
    <xme:r9O9atzMzRsb-LHb6w9ZNC4iDfLOW-_epcxMpK6dugXqOEd2-shS6GyuEsB6sVWfh
    NNxEPNgspLOCmWPz8t3-yiR60rrCsRR4mtcxyCgs6-p875HN3JVmaQ>
X-ME-Received: <xmr:r9O9aox0kAKdE1dyUk25zF2c0DMZMFotePFaGjXDez6y6t84tJc78hAHBC6FOvmocRBMoO3DOA-9Atf6viT3SMtEzzWZYM1BntUz>
X-ME-Proxy-Cause: dmFkZTFxPhMuMyAI3yrl3SHu/NCdruEPYUwq0Z4kjIZFP72PkLwT6PvN3iCRkEkmY08MBz
    trHKA2RRtvxh98Yz8RZw4YuS/ttuywTH7CROOh9r/IaWh5t4Kr9DYTtLzxW9xse/LVuAL2
    eIZKlJ5ZgftMZ5j3m6Feq2dkhV7ljI38vfF56MES9rTH6H59Ij7EBMEY4F4oBFmqw9PyHa
    mm62o30gVYu6G/pF0KT8kYd5XjaofhfTVkB6jFUmC2csSQviE6mAsxY6YI2a4Xi6v0eTMt
    EYRBjbCmaLu3mABrnF4RR+br+f78CYRrjyPGcSpHJcY/4FwDef+PiNeYYpxdoFWziPA7DX
    9DWpVEcl4Ivg2Ea5KXxU/LDi384PWKN2o7Mln9eCwS/lTuD4+J6zNKqDgSSLOU+X1VM9WH
    NZ3zyVPN7SbpJK6L/p7zRzIBlQijCe1rtHpWkI/aMpiTLGd09ah7mNoaeqv1At/xN0xVKY
    LvU0pgM7VB75yu3i+vPPo+MjK6H3NJTTmsjGpn2uyXQxZUEtuHgBR2kP0x/jq0vMs+9f8Y
    b5IezN10JArMawAI86CCxV8H6ZsiajmiNABcQTmmuHhATka+ld/rXgc476ypJwYMntiqfG
    Kpk3fsN1oBZeG2CFyh8AX6+Kv8fTWD9XcRstBwk7s+38BymeQKB2AZQ9yPsw
X-ME-Proxy: <xmx:r9O9atyR6D6N0-wPm5D0Zfi3hldcfbDYlqbVbjjVAXac_CKlog-TFA>
    <xmx:r9O9aqZ_9y97JxC18PNA1biR3_cLMfPyUIUWxvQsXfq0mjym0FStxw>
    <xmx:r9O9amXXFG5RKVGMsKdZg9279y8yrs7L6lsAd8KmzlqKQhIMjeMVQA>
    <xmx:r9O9agi8uRVX5N7B3AqRZGB6GaSI8JwDVUvWNFe6du0I2PBF359syw>
    <xmx:r9O9ahBfYYhiauPqHRedB4XPuNnXL0L8qbiUYJADLTswOZkJVrUo3Fj1>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Sep 2026 23:29:51 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH] object-name: accept @{p} as short for @{push}
In-Reply-To: <xmqqbj9e8kb3.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
	30 Sep 2026 15:07:44 -0700")
References: <pull.2431.git.git.1790797186658.gitgitgadget@gmail.com>
	<CALnO6CBR0XJUJR=2e5kUM8Fk9aV5uz+QxajRpnFFVTEkFfJQ3Q@mail.gmail.com>
	<xmqqbj9e8kb3.fsf@gitster.g>
Date: Wed, 30 Sep 2026 20:29:50 -0700
Message-ID: <xmqq1paa85e9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> [Footnote]
>
>  * https://public-inbox.org/git/?q=gmane:268185 would have given us
>    a good way to find what thread Peff was referring to in the cover
>    letter of v3 iteration:
>
>    https://lore.kernel.org/git/20150521044429.GA5857@peff.net/
>
>    Unfortunately, we are getting 502 back X-<.

Well, I remembered that gmane still offers nntp clients ;-)

We can visit nntp://news.gmane.io/gmane.comp.version-control.git/
and ask for article #268185 to learn that the thread begins with
the message <20150501224414.GA25551@peff.net>.

That's 12-patch series of v2 that can be seen at lore:

https://lore.kernel.org/git/20150501224414.GA25551@peff.net/

And then it also links back to a different thread

<1389126588-3663-1-git-send-email-artagnon@gmail.com>

that started <branch>@{publish} notation.  In one of the messages in
the discussion thread, I see I was asking

    If @{u} can already be used for upstream, why not allow @{p} but
    require two letters @{pu}?  Just being curious---I am not
    advocating strongly for a shorter short-hand.

The thread also has a fairly well written summary of what symmetric
and triangular workflows are, and how Git 2.0 would give users
choice to select among three simplest models.  The thread was
apparently from pre Git 2.0 days.
