Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA6341DEE5
	for <git@vger.kernel.org>; Wed, 26 Aug 2026 15:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787757882; cv=none; b=Jx5RqMlu6XGJOOW/YK5HLrrlibFPihzfL92kY4J94PAldVIyonS5nLgJYMBxb2iE+nkeI9oAqj2cUJSxwIXNkLHx3FCfXgujDrbRcpX2K0GzxS2GZsathDsOqs5nfZfWlOe3Hbj2bN+3mBz066c0cAdWvsA9TPngOO9CPe4Vd8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787757882; c=relaxed/simple;
	bh=rR7nQ5h/ucn1/5SdPSNNlkmAcGCE7kg+wEtcatYsodY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NCedssOBe7cSfw/JG/SaVCDqdNnFSWGm92KUJgz1i30xq81I4c+TLWrgS7bOxmVF/eSKmVU+iFl/uQWERtfzDc2/qGo9WIqu6+ezxK2jJlJKJ+5wtzryzMA9CUD4/r64HZxHAUF46aLOS9dAdmq0CiH/lFJp9GdLwj4LbdyOZBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=NfRruQxX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VxNUTbFD; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="NfRruQxX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VxNUTbFD"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CBE2B7A011C;
	Wed, 26 Aug 2026 11:24:39 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Wed, 26 Aug 2026 11:24:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1787757879; x=1787844279; bh=JdqlVpt7/p
	dzVutdn11mWFNzSbY/Ef8orM9GHM96CA8=; b=NfRruQxXbIs8sa59N2d+kgBQrF
	2h8IMA8CO6zrAM2dbGJ6/TubWwVQJ6cGZpfTA0qNEP4dypH9hpH1UvQHpG6jKS/9
	sXthq4uH5+/xw6V+F3wGLChldmJvSifkpJzCj1LySUDvlUITdauYsnxLf/sp1anq
	w7XVw75xOO/TXP9wZ6u0G8XjbinE07VAR1G40OG2fOO25+M0KE6eEfTQv0039KlH
	BOPxa2WMC6yas/0kl7Da105ZlvpSkRJartggA+aqjFHxfI/kye8dSkObuTptgYP0
	99cAEmo2ZE0Ik9k1ZHHaS1ZMtl4X2mLbfJCSOq0lAd3PgXZ44OZdz4cZBlIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787757879; x=1787844279; bh=JdqlVpt7/pdzVutdn11mWFNzSbY/Ef8orM9
	GHM96CA8=; b=VxNUTbFDXY/0sYK9MHVaCYx3aepHgIxHEK41WwQc34N6zB1jllk
	Y1TvlTZQsIIiBCeWkfWBe+yxTFgmjdlYHUh5XDztuiX/hf38/YPNqdtEkQZm77Xg
	YQNmNFcAeSschdJadBnVQstFP9klJsthpKR4RteY6C0r4Bc/DMxlRKI6irMhKRKG
	1qH12t/c3VOtqGfF0Bkwdx/jixzbLGs9VzRIqOgiQNsJoQv955h1ZiXoafhAVPs3
	d+59nWtZbsbafLm3T2j6YMe2SRzETQZ+5O1+yRenAWxkuQPqOQybJmZDdz0/NWLW
	aOEwgiBmPoYe8fH5PEtFbo/t8m1zM1GEo6A==
X-ME-Sender: <xms:NwWPaqWV-E66qucjtHOjWd7tTyv-VZuBCunqRj0X6HsJC1RHfqoS2Q>
    <xme:NwWPaqQ21_f9ZxCQtd4JaNjLl_Rv_3U5mMznr4HvRJfESI0xz92rOj-3fdYQbiXyd
    9y1F5jJvYxCRa-ALEv39LrpewqGu4LvuKCKiVaETlI-lWVEWQYetg>
X-ME-Received: <xmr:NwWPaoP2rMG5Bf5-9jvIvnrlIT_z_u0xqDrIDV-jfNYiBlqwS0EDRWBW6EtLsVP_ILpgUXM6HCpFZQ6qlaJ2wP-gawRo-dmDnw>
X-ME-Proxy-Cause: dmFkZTEInG3yPjlfGJOvKYO41PXxrKfBSTdxAYMb2kC97/570sWLYA7xRuZ5kVTZZqRZAd
    Sd0S7Xj+LzXqDnkCeGKEj7BqmWizxaK75RoxA+rA5ERYZlpZcPPurHae0rcvUXGGFcpnzj
    wcXSBVqTeofIpUESQ5n3xwfw2oBeNVeWOHkuZ1+QwIuY7ByLSr1Oep1svtSC0iGy4xbk1+
    FxUT6gUL4Ys9xCYPzfJcg3U8YrXZUaZEbUM6e/WFyEOPfssgSVX+gHYB2MuJdbEWgPNuU3
    46/aj467g7yg0ag5SExupJzh9Llnh1ScvloRJUJMeAprXG9X8N+PiXzUtpFCm/J4hxAXqE
    uYfLGiAP/k/8dW6lBFq9lHl7TdKlQTbP1I8S/dqnvSCyof8k2Cx/XuaeHxOrvarrwIJLAT
    fomc1SREhvOUGycy4bhDHboah8X5aJmVwrl7uwdNhGJYc2vmeO1hXlrVM+G0a4GXUm39lz
    BlC+VnmuyBoFoJF0V3wQzbjOiQX5Hvw4VPF/EczQXx+j8Ociu0SEnJY/ThEMIlItk40AiZ
    YrJuS6sI9MxDQ/Rh3YeUoZOBmHLKN3JvXIhHkwvk6P9KzVu9i6RnM0wHapn6tjXFl+YAEb
    NArcizPHmJ4CELa9Axi+y8ZXz0taWaBJxVjKDsSdBM1OQNsCxprtVeMijN9g
X-ME-Proxy: <xmx:NwWPaoQX0Joq7odwjEP1_mfWFJWIFCZP7hDg8iJI8e766DP1qbnleQ>
    <xmx:NwWPamhq4Gs0YsWituuRbVFWJVTJdZ6FBIVc6D0mjU7HdfX1pBxozw>
    <xmx:NwWPah_dNmWSY-IOQUZKZgLMI-2l6TigXRp3e5M6cB0vBBYsuhc21A>
    <xmx:NwWPatF2oiusyTgRO7JtThJqxsf7rO8XuGRhk1BZo4WktMIT_ngYOg>
    <xmx:NwWPao4gCNqhWI8HYLQoV8e6Vaw5ulcslw2hcUr-kuRT8lX8CEp6cHP4>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Aug 2026 11:24:39 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Yoichi NAKAYAMA via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Harald Nordgren <haraldnordgren@gmail.com>,
  Yoichi Nakayama <yoichi.nakayama@gmail.com>,  "D. Ben Knoble"
 <ben.knoble@gmail.com>
Subject: Re: [PATCH v9 1/4] checkout: extract function to display advice for
 ambiguous remotes
In-Reply-To: <e3f7d885209e6cf9487bea296bc81df43f3758db.1787741111.git.gitgitgadget@gmail.com>
	(Yoichi NAKAYAMA via GitGitGadget's message of "Wed, 26 Aug 2026
	10:45:07 +0000")
References: <pull.2197.git.1786177301832.gitgitgadget@gmail.com>
	<pull.2197.v9.git.1787741111.gitgitgadget@gmail.com>
	<e3f7d885209e6cf9487bea296bc81df43f3758db.1787741111.git.gitgitgadget@gmail.com>
Date: Wed, 26 Aug 2026 08:24:37 -0700
Message-ID: <xmqq4iggkiq2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Yoichi NAKAYAMA via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>
>
> Signed-off-by: Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>

Don't we want to describe a bit of explanation between these two
lines?  There are a few things that immediately come to mind as
motivation for such changes, like that the original place was too
deeply nested, that the original code was incorrectly indented, and
that we are going to extend this function in later steps in the
series.

> +static void advice_disambiguating_remotes(enum checkout_command which_command)
> +{

[2/4] updates this function to a better name; let's give it that
name from the beginning.
