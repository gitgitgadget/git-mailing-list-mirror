Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1941D257851
	for <git@vger.kernel.org>; Wed,  3 Sep 2025 12:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756902021; cv=none; b=iWWqsA7SYg7rSPKglj+xRrP07iS0PiggRwD0vV3JlgjGy9pDPxz6n7fTcc/fqOjmlUgBWitdhKmw7JR/G9RmCeCRLbLqdiEERbL0nnaVchw6nW6UK3BT35H4ULa+76qkNWvX128ewTk+LZ3yBElg68PI7YUGkpD5zOkTKHJiqA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756902021; c=relaxed/simple;
	bh=i6QxR3cQw+WlGRMs4HPBecJNquqTBJkD3NkGVjYmQhM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oy883fQT1TatyoT70XCwX0fjcYT6CoADIFvUs1Ijf2QdRdkzzr99SRPyAHvADQARC5g4VtgixTc6EXPMeiwinP8v1f0Z4lXgseAu0BAt0FLejxEGzAHBv08CJowjo777RWc6EORKDlLx2nlqAHPlTmdcLHqHYQrXgJkJ0fshjxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hy3HuW+d; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZFxM+ISd; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hy3HuW+d";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZFxM+ISd"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 265801400401;
	Wed,  3 Sep 2025 08:20:19 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 03 Sep 2025 08:20:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1756902019;
	 x=1756988419; bh=NnrvOvNdP/gOGqYfmHDYSPdGB+aAlh3+LzLBWCQ8avo=; b=
	hy3HuW+dcaLRVKNC0y1Hg7lJADsww5vIWuv3ab7n+iajSnWt8h2ZBmyCC43BqhEc
	EWeLNGBMR93khizc2R8Qp/MCI8kq3TVZGzTGZpwBiFIMKLn71FVP58ZexXmZYmQn
	QPhsUrQJQHKdkUsjPb8UV8mlKTewexqyFzxrsEtiiOPpyY0KX114AFe8GuNv8pII
	m3ogoL/Gsdxkbqi7yH31bMlEWRcZCc8KgRxRPHWVEbipCbs4VmC0PyNbQHm9gdMf
	W+6oM7rioK2XegtNurbmrgK2heOyoxme0ukY1TtIk/lxkZ+R+tCzvuUlp73AU50T
	nEu8ezJDq64eAIBrCJdYfQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756902019; x=
	1756988419; bh=NnrvOvNdP/gOGqYfmHDYSPdGB+aAlh3+LzLBWCQ8avo=; b=Z
	FxM+ISdEjALCnNcXxrwh5ZkpKWIiscESXyruzvwZlI1eoyE9FS3iE7IsK6Mt32XU
	yx01db86GycVvlG8SFJra34BppNWXQ7j2MHCD8d6MzpuPwbHOFMqbDSO3PA5TeUg
	5tV9iGU+T++eQW/JtSbyw7vrvmy6BtVQn6g2CPqFq43CBO//AWMoot3+TCivqRLI
	1e/n2x3QxTI+ECNu0Xa/kDVWr9a3kuVZbSCyUP/5oIxH+DGTm031qGMWgxyp+T0P
	M3OeAHHtkDYrToURvM/OVtkHrVHK2x+OBnTokSpF9Bc2cqgwhCcjQuGdjBLKFcK3
	wC8DADvGZKKfL0Y3SpdIQ==
X-ME-Sender: <xms:gjK4aMFoCb2KNc8e205CQkS0hcD7L9V7GEzTmlmA_5HfTpxM3IXylw>
    <xme:gjK4aC7cTsz-MZYNq7jLkRC4zwDtIosURDyp3NK4trczb5G_VuW-1_rHin6v_wQJe
    oEsRU1q2IRuZwdf1A>
X-ME-Received: <xmr:gjK4aMmBfES_1cU55ecR38VL8SyvMi-uMx208shvJq3RFvcMuc7qsWicFBDBGH9KgPdz47Expklv3QTA_dpu19JXOQuvQYowM80BwOY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvfevuffkfhggtggugfgjsehtkeortddttdejnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    duteehffeguedtfeevgfethefhgeevfffftdevieffjeelueetkeetueejgeekveenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehmrghrthhinh
    hvohhniiesghhmrghilhdrtghomhdprhgtphhtthhopehjnhdrrghvihhlrgesfhhrvggv
    rdhfrhdprhgtphhtthhopehsohhrghgrnhhovhesghhmrghilhdrtghomhdprhgtphhtth
    hopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgv
    rhesphhosghogidrtghomhdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomh
X-ME-Proxy: <xmx:gzK4aPqsnkDc4h2lXN1XqERWoiNp1DLSITmz8yTXL9XMI8O5ydlQYw>
    <xmx:gzK4aDuivafRA42WZtjnFyI1p8AAyhLvWPQOx7Xqz1uiuqmQO8KGCw>
    <xmx:gzK4aMFwvfcvAsFwKTwN-JsBdeROAshEF8I_c1_cOrml5Q0JO98Gxg>
    <xmx:gzK4aEZjS40U1IZ7ebMjN9IlIQPsj465Dln6kcKq0jzH3IEk4UUBFw>
    <xmx:gzK4aAxuu4Fc0z6OhYfJtoziCLvIxnVDxvaGVTQ8zgiC7O2yn-lcArUn>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Sep 2025 08:20:17 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e8476414 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 3 Sep 2025 12:20:16 +0000 (UTC)
Date: Wed, 3 Sep 2025 14:20:13 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org, "D. Ben Knoble" <ben.knoble@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Sergey Organov <sorganov@gmail.com>,
	=?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>,
	Martin von Zweigbergk <martinvonz@gmail.com>
Subject: Re: [PATCH RFC v2 16/16] builtin/history: implement "reword"
 subcommand
Message-ID: <aLgyfZEmjDAYewaV@pks.im>
References: <20250824-b4-pks-history-builtin-v2-0-964ac12f65bd@pks.im>
 <20250824-b4-pks-history-builtin-v2-16-964ac12f65bd@pks.im>
 <5079326d-497c-4335-88d0-a248e0b8c6d1@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5079326d-497c-4335-88d0-a248e0b8c6d1@app.fastmail.com>

On Sun, Aug 24, 2025 at 08:08:07PM +0200, Kristoffer Haugsbakk wrote:
> On Sun, Aug 24, 2025, at 19:42, Patrick Steinhardt wrote:
> > Implement a new "reword" subcommand for git-history(1). This subcommand
> > is essentially the same as if a user performed an interactive rebase
> > with a single commit changed to use the "reword" verb.
> >
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> 
> I get a “split” error when I typo the commit to reword:
> 
>     $ ./git history reword ./s2
>     error: commit to be split cannot be found: ./s2

Oh, indeed, this is a boring copy-paste error:

diff --git a/builtin/history.c b/builtin/history.c
index cdc93a1cbd..f03272bddd 100644
--- a/builtin/history.c
+++ b/builtin/history.c
@@ -749,7 +749,7 @@ static int cmd_history_reword(int argc,
 
 	original_commit = lookup_commit_reference_by_name(argv[0]);
 	if (!original_commit) {
-		ret = error(_("commit to be split cannot be found: %s"), argv[0]);
+		ret = error(_("commit to be reworded cannot be found: %s"), argv[0]);
 		goto out;
 	}

Thanks for noticing!

Patrick
