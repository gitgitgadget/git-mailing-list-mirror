Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DBDA277CAF
	for <git@vger.kernel.org>; Mon, 20 Oct 2025 18:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760983298; cv=none; b=qoKIf6eJANzWf2XzGdcIh3RhzrOPU6TsOOf4t8ppWWDIrhKBcZi6bWYYEKrl0GNtv0JJ252e47+MG23dv7iVHwHzfhHw+A5Cotdo0SHRJTpz2oB3do53/NFHd1j8sDXTZvJoEwCWf2uL26Y0Df3G/bBaRAIvJ2VK8w9bDhM0xOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760983298; c=relaxed/simple;
	bh=xkfhFwk37wOjcVnOd8x78lwfENWWc5fg71v7iKkAeb4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Tqw+U8aLz1O07NwMtlupbN1gcPt/Dqawh3KBBkqTZLM6SV1G7PF7SHFWcVDWSr8MpVKxuxkojaOxqqgG3omzqKb1MX4hrZxfbBoHC5AxVlGRn1CxyuHXA7XTLLA8c7EhyC/DU5/UqwXNtIXDpcaJ2k8hudlerHRctiZ9/o0+4CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=g6Iw5ayb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JozClKa/; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="g6Iw5ayb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JozClKa/"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id C90DB1D00135;
	Mon, 20 Oct 2025 14:01:34 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Mon, 20 Oct 2025 14:01:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1760983294;
	 x=1761069694; bh=/bM6Gq+poebVfvC92FRdXSGwjhp9rY6K634mi4VuutU=; b=
	g6Iw5aybs4qfrLD/s4hhrbwq82DT/td1zXcRmf6CR/l/QcSsvV/NjRuiEQi3voK2
	xXU4d2YnrooHpVFC6KWXzQKlIKpx5TLEeDc9+wCKMJ4aBjRXG9MU6YAqTTXkAd9M
	ywIYr/qVYCC/Yi/zz7JC7XgN+pgQsG5ln4ebU2o/6b7wvjyZnU7Ka/IiZdMUMbR6
	+2xgqymGjE0LKDd3olX2b6iIJuTjXXZukgFqxZV2yB1JvEc5MJIY1NoaStaJx+Rt
	EJ8we3ZrHCjv2bUDSaKV4EDOgoAuaVXCYnQEgbGqbDkUvz5yEryOO1F+CoAk04yO
	UsS2IdLvrne7IaRcCGzW8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760983294; x=
	1761069694; bh=/bM6Gq+poebVfvC92FRdXSGwjhp9rY6K634mi4VuutU=; b=J
	ozClKa/eMmnJ+t5w4EOoP+3vCqcTZOnaU8UW7aVCQXCnrp+FgwWz1JNPbz4r883m
	WrwgrW0cJbZsUyZLLQewmw2EsMrdej/rN4CQAlrDy4O6IbzMpXJf/HrMcxfz5bCK
	FBeGo0HICoAG5oE4vivIBMFXi0kNrauReZ2Q+2ERRWmGDfUPlaNsJf4NVsUkfMJ/
	A9AtC6zQGsdkPNXIwYbGnfj22xDbzEhT0CT77UXK9k5p0OwA9DICuxyuHliHDU8C
	DQwX6iqRoDrTknbrW5mWWoQ6l/mfbfMYDZDLX0v58RULNAf/hsavtBZbduAnZEkT
	hzx1OOIw/VlFwzDMt/95Q==
X-ME-Sender: <xms:_nj2aJauDRrn0uJjDz6ih9yby21luT-6RYbIN9gaB6rIvDxM7jq_mA>
    <xme:_nj2aCoexGf9CwTOfzT6LcD4sabsPbUt8EMJcHNNYbfVl2Iah0aTGePn9r4HZIaQ2
    HHZexC0mUv3Cfqnd2fdOv7quLZcS0Upg1IEnUcr87VlWqGsqRoulw>
X-ME-Received: <xmr:_nj2aONvlodj1kYwYMn5CIIxhGXTgQr6wcGyy27lGEVgxMFv4HqKtXyRryzwydlt_lPdS00cKEZHLl4F0Rx7lRLUq68QzzAV1iYo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddufeekgeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeejpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhkse
    hfrghsthhmrghilhdrtghomhdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhm
    rghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    phhssehpkhhsrdhimhdprhgtphhtthhopehjuhhlihgrsehjvhhnshdrtggrpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:_nj2aNoDh3FGECIhsTJeiv0Fnd_hycfhYHFP56Ysxi-YdrCK7jf_LA>
    <xmx:_nj2aDdUn4S-6ctAPJ6UmVA8nv5iQipTc1_9Bt6rWm1vq7rdgk5rXw>
    <xmx:_nj2aDSlgURSVMIQ_ZHxb5eh9qA5-fQB2OArVX9TM3sTi8SbnLVjAQ>
    <xmx:_nj2aMZqan1HTSvzP-Ur-rQv5W-zdEqZF0lW6VhQNY0SFiHNPkl1tg>
    <xmx:_nj2aHdip6dDOknGg0bTKRai2-mvinQDqrq8f9MqatYvibONi8adBq8Z>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Oct 2025 14:01:33 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: "Josh Soref" <gitgitgadget@gmail.com>,  git@vger.kernel.org,  "D. Ben
 Knoble" <ben.knoble@gmail.com>,  "Patrick Steinhardt" <ps@pks.im>,  "Julia
 Evans" <julia@jvns.ca>
Subject: Re: [PATCH v3] doc: add a explanation of Git's data model
In-Reply-To: <c1c456b5-aca7-4b24-a4a2-558405214f24@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Mon, 20 Oct 2025 18:37:30 +0200")
References: <pull.1981.v2.git.1759931621272.gitgitgadget@gmail.com>
	<pull.1981.v3.git.1760476346040.gitgitgadget@gmail.com>
	<c1c456b5-aca7-4b24-a4a2-558405214f24@app.fastmail.com>
Date: Mon, 20 Oct 2025 11:01:32 -0700
Message-ID: <xmqqy0p5zc3n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

>     xmlto: <git repo>/Documentation/tmp-doc-diff/worktree/Documentation/gitdatamodel.xml does not validate (status 3)
>     xmlto: Fix document syntax or use --skip-validation option
>     <git repo>/Documentation/tmp-doc-diff/worktree/Documentation/gitdatamodel.xml:71: element link: validity error : IDREF attribute linkend references an unknown ID "tree"
>     <git repo>/Documentation/tmp-doc-diff/worktree/Documentation/gitdatamodel.xml:96: element link: validity error : IDREF attribute linkend references an unknown ID "tree"
>     <git repo>/Documentation/tmp-doc-diff/worktree/Documentation/gitdatamodel.xml:397: element link: validity error : IDREF attribute linkend references an unknown ID "tree"
>     Document <git repo>/Documentation/tmp-doc-diff/worktree/Documentation/gitdatamodel.xml does not validate
>     make[1]: *** [Makefile:380: gitdatamodel.7] Error 13
>     make[1]: *** Waiting for unfinished jobs....
>     make[1]: Leaving directory '<git repo>/Documentation/tmp-doc-diff/worktree/Documentation'
>     make: *** [Makefile:3676: install-man] Error 2
>     make: Leaving directory '<git repo>/Documentation/tmp-doc-diff/worktree'
>
> The syntax looks correct.  So I don’t know what is wrong.  `make html`
> works *and* makes the link.
>
> At first look it might be to do with the anchor on a definition list but
> I tried removing the anchors and expected to get an error for `blob`
> next.  But that didn’t happen.
>
> In short I don’t see what is special about `tree`.

This seems to work it around without breaking .html generation too
badly for AsciiDoc and without breaking .7/.html generation for
Asciidoctor.  Generation of .7 were broken with AsciiDoc so we
cannot complain even if the result is suboptimal, but the generated
manpage with this patch using AsciiDoc did not look too bad, either.

I do not know AsciiDoc internals (and I am not particularly
interested to learn it now), but I am guessing that the bug is that
when it sees [[tree]], it tries to find an element to put id="tree",
but before it finds any approprifate one, it sees [[filemode]] and
uses the element it finds to hold id="filemode", losing sight of the
need to add id="tree" somewhere.



 Documentation/gitdatamodel.adoc | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/gitdatamodel.adoc b/Documentation/gitdatamodel.adoc
index f49574dfae..7232fe3861 100644
--- a/Documentation/gitdatamodel.adoc
+++ b/Documentation/gitdatamodel.adoc
@@ -83,8 +83,10 @@ trees::
     A tree is how Git represents a directory. It lists, for each item in
     the tree:
 +
+1. The *file mode*, for example `100644`.
++
 [[file-mode]]
-1. The *file mode*, for example `100644`. The format is inspired by Unix
+The format is inspired by Unix
    permissions, but Git's modes are much more limited. Git only supports these file modes:
 +
   - `100644`: regular file (with type `blob`)
-- 
2.51.1-556-g06b2a500e9

