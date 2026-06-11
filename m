Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289E01A9F90
	for <git@vger.kernel.org>; Thu, 11 Jun 2026 23:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781221709; cv=none; b=uAvAyKOZ9a64slN9NOQqvs0hP0Xu1PxVEkw8NzeIePGH7RdblxxaJGO6JG7YVDUmA+GnRHlYzfIn8fEvsT8E7W9ik3HyhFDmrDxexj71LCR3/gI8nxL0twDuP9Hxj/JO5bngfkFJAWEhOUKIoSX957oR049Thn+2H0mwt76G6tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781221709; c=relaxed/simple;
	bh=tXQN+r/yx4bNcYk3jcr4rB3yWNJnMk910vHxH8SxnK8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UcZ3Yi8CO3GMeEESuFenXJir8gzdLOtXP0jfgmiCqXMh0V3zeXQ53hGe9w7Ys2tMAJY6V5SI/OxtSONUnzGKXPH2n4wIBguLY3HXQFfcwQ0ZG6kgMrQQfHfvvL+Sz1gyplcfoqd1tjb2JTRve4m0ulAGat2FCOvc5aqeEXLIVxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=iGn7XCRi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dTaS8rjt; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="iGn7XCRi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dTaS8rjt"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 4D28DEC0177;
	Thu, 11 Jun 2026 19:48:27 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Thu, 11 Jun 2026 19:48:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1781221707; x=1781308107; bh=40N56RJahY
	WzdIfVmwe0MPYIIYZdy/dD4ADC1a1yuWc=; b=iGn7XCRiBDOMc5zonatOWPJIjC
	SajKD8pdzmh+G5Yw9NzsRRAADBNAMBF7YOBGMgC0VM0yhrot//8rxH0JutBP9Ryq
	QSOyKiEjEezIeyFQF6ZAlWuiC9+Cj2qdKORUrNpdqG+pzQiiv4cWjoVfCMI2HCqf
	6cVQpbj0SZSrGrOuHvwSBiCfVIuoJSsJYB11M8aCN06+j/BWlaAyRJfWHGlwpHAb
	QCJdkGFrDVR9ASPRWJpVc6XHVIW5eKAm67FFnO8rXfeqE+UqBdMWB/EgTg5B6DwY
	1h2QCzJhcpzmR/c/EQMEgWql8veA1SXc6OLfSjDF8wh3b79FZ+DyPb4GynIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781221707; x=1781308107; bh=40N56RJahYWzdIfVmwe0MPYIIYZdy/dD4AD
	C1a1yuWc=; b=dTaS8rjtUeOBJ3CZBZEkInIrmxMxkrXXX2j1swi40i5bSyAcK15
	YG1zYok3hBSn4vIJgTW5RKGq0zuuj2a4TaoN0mY0nmGIpSgVzwg17GVNrU3dInqZ
	jHkRQuacSKJ5Gws/LKwHmJT7Gmckz6uH1krSnrtPKeQXP9CXahtmGBFG03uXAFHX
	Xu+vjeuGj7hxna3NL/3U5DLl/nenX8e7lEogSIzLxo+ny3Yz/y2CYyVoZiSeYuCu
	Wm02c0B3f8/THgOI84ZoWGsO8gki2G4wavTxy4oFFLP/KWJ4RlVqBYetl8U86mE4
	x65L56dOHibPLdL3VY8aesytXU5OddL1KCg==
X-ME-Sender: <xms:S0kraoxEZhtF3iHz6lrkjyi30KGj9q1cbPO-QO8ObEkKJ3Rvn2d5PA>
    <xme:S0krajvvAtdbaXO0gRrQ1I8g0oC-dYMdzYqoipFcLU3BSqxoC8aqky52_dnGVf1GE
    bOTQeIXPAqELJ2eAwWk6ZnWrxoIxL_QfeQSruv7JoWqA7ICSAOSEw>
X-ME-Received: <xmr:S0kranvmEBgysmKXG5kZMm6le6tyAVIqBkUQp66LAGAGHcgs2rBoSl3cSpe6nlOmgBvQR1qO-3gTZC00lA2mpxzuYH2zn6YxNFex>
X-ME-Proxy-Cause: dmFkZTFIHPy75sglNnRFmxSn5dzOL6vGECK/NSH69wVlohqiuwBZ3Ort9FOYo2XwVCr9hW
    noWzvwHjsUIAdj5Qk4lIanCN0Uy6zfIFcttB+pdzfW0aXv3dH0QngosM26dK7xCEGBGp0s
    h9CM24UdpZFfTJeYpNnTYGb+O+G1wjOvZxuXpYiZE0Ej/atj/d6cSQsXN4h9tZKWOUyGmj
    7B8ac/GF7jR4w1uYOUg4m/KJbRRtGCVEWo2sNNwQfWw63G5hDeDfnSqD2HTv+cvYVVb3qj
    qOG6PUHKr/B5z4cXlS1f9FmeQAlIO4p7sz0DNfQf0Yee8R/I94tjnq7NI/7uluax1Pydc6
    HsVUSixGRaegjnqwKByhQXYMSXVhlhX8MMBKOz+ioK7wgQs8Eyqq5vnGvXz80A/ejTZZC6
    LHR4q7hwlBcRRJ6DKC0kMoPJ/tcmL4Hrg0W96+Q8lnlLHP4i+5azJXkAhGAR3VH7Vypzql
    Wb8U9sTwUP0o072DNGeJ9U+tD8IUwo+uqyCC3mqi8MlrMnkbsybkW+AeP9HS7Z5g6MKqf0
    Dt9hOx5S6EFjzAHgYzrmMbp4PzqQ2DLKmXZ54+TY2gW1f/1Z9JANy80/Xrldensr2vpknQ
    ssB+P0sK7XgIXCfZUU4BjODS13Hlm8R51uZrL1aLjyJUtFW6LcWRyrGwNzeQ
X-ME-Proxy: <xmx:S0kragMoc3pVFIGq_reD-l3fFniBGknHojvVFoBzl8TOV6QmmaFUmg>
    <xmx:S0krat02IIC_obwrGtgM5cJo3e1PFcPGqRZV8FxzegqF1PrKRRnWVg>
    <xmx:S0krakNrT8MP3-o42mHd33aVEpAHO6B7dPJfwLKVEjKsOdXDP7BzlA>
    <xmx:S0kral3nxeyrM9wI29sEFUB_IXddtz-bmg5mciaKUisASEOrBc9b6Q>
    <xmx:S0kraqUhv48fbocXDABXOTF9Gp4T-cymmgiFABmgSU1xIQzYfB7iMM2j>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Jun 2026 19:48:26 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Weijie Yuan <wy@wyuan.org>
Cc: git@vger.kernel.org
Subject: Re: [RFC PATCH] MyFirstContribution: mention trimming quoted text
 in replies
In-Reply-To: <080402ff0ac8127b654dccea59a1bf643df62a5c.1781186476.git.wy@wyuan.org>
	(Weijie Yuan's message of "Thu, 11 Jun 2026 22:14:35 +0800")
References: <080402ff0ac8127b654dccea59a1bf643df62a5c.1781186476.git.wy@wyuan.org>
Date: Thu, 11 Jun 2026 16:48:25 -0700
Message-ID: <xmqqcxxwljue.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Weijie Yuan <wy@wyuan.org> writes:

> ReviewingGuidelines already advises reviewers to trim irrelevant quoted
> context when replying. Give the same advice to new contributors in
> MyFirstContribution, so our documentation is consistent about mailing
> list reply etiquette.
>
> Signed-off-by: Weijie Yuan <wy@wyuan.org>

Makes sense.

> diff --git a/Documentation/MyFirstContribution.adoc b/Documentation/MyFirstContribution.adoc
> index 607876f3d8..0e2a9313ce 100644
> --- a/Documentation/MyFirstContribution.adoc
> +++ b/Documentation/MyFirstContribution.adoc
> @@ -1453,6 +1453,11 @@ effect which had not occurred to you. It is always okay to ask for clarification
>  if you aren't sure why a change was suggested, or what the reviewer is asking
>  you to do.
>  
> +When replying to review comments, quote only the parts of the message that are
> +relevant to your response. It is usually helpful to trim away unrelated context,
> +such as large portions of the patch that are not being discussed, while keeping
> +enough quoted text for readers to understand what you are responding to.
> +
>  Make sure your email client has a plaintext email mode and it is turned on; the
>  Git list rejects HTML email. Please also follow the mailing list etiquette
>  outlined in the

The insertion point is well chosen, immediately following the
discussion on how to handle review comments and before the technical
details of email client configuration. The text itself is clear and
gives sound advice.

Will queue and wait for others to weigh in.  Thanks.
