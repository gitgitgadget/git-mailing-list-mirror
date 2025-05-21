Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57AA17BD3
	for <git@vger.kernel.org>; Wed, 21 May 2025 07:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747814011; cv=none; b=uF9OAgTrTkgIgDnrqMBmhmkGSQSpbX4tn08A3MZ8rKPf3BjshlUsUOi9qTvYTb65p1xvfrDsJ5LpKCAnq2I4GcgOy6F74GumCJByTTpDTXBrk3ucw5cSZ1Zda/+OMdE+PMdJbGEp4rCf2swj8kAGBYQSUC2IbxzdD/hv8H3MtF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747814011; c=relaxed/simple;
	bh=rO2yL97vXKA2oTZDMtfY3mnDLRU9hPEG2NyiIq4znLg=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=uI6TgdHHzqKi5WEB1Lne8A1erfClVTBJ06bkBToxGGwRtqdHoxhnNge+VwmLflPGmMwooNp3mxLGw45GlWpWN0ruprmltbjq90v2W/Mt7n4aiKmjLf7Jta17Y0mlx4AWlAkehTgbBBCOZMFHwz3GLDx75uqZe1fesySTTM4uC9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=qnauPswd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lF8Gt8DW; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="qnauPswd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lF8Gt8DW"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D5FB8254010F;
	Wed, 21 May 2025 03:53:27 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-09.internal (MEProxy); Wed, 21 May 2025 03:53:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1747814007;
	 x=1747900407; bh=yAwEyZrlncWduCbQvHo2TdkLbhOrV2guJ60XTpNtXfM=; b=
	qnauPswd/B+quoRmNgukFlevEskvssOyW7MSZAnkO/sRrNZpee62U/3HqZYbP2/z
	WloH6At/xRqLXw8vhhkKDpG/i8hHuc+PyJpXujpCN45xJ8VU3OXNSWIxEePRsTj/
	IU0Z+24zcp8nLfkDVsu+3ZPb4ug+1IgEqf36Jmyy493+iJ/I0btMed6j75JMUv1A
	8DCsf9AiilBgBM6+0fa12zbrfFKMKnaDIXmWDF135ycLdH0wR0lI31ymT2/A4HMK
	Ne3glb2elHmW7+1H4l4iVVbLVohBVrdSwF8gA3yTXmEkHTJHoLyEQpdHzGosN6xG
	u+ZPDMdYY0CmT4fYTxViTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1747814007; x=
	1747900407; bh=yAwEyZrlncWduCbQvHo2TdkLbhOrV2guJ60XTpNtXfM=; b=l
	F8Gt8DW0QO/nD0FVPKFbRKpjFWLkPalxeeXG03z9v3/9GPYl9yt7sN8HsagnKevr
	LM3LDusswXcYslFqUD7CLP8WlTALIJP/bOOq/+nF/4Htw6ksxKgHoTWHgVtJMsbz
	Yo1cmeiQ/lJBnO+CUmG23xMIBx9ttECGzkju73rxQSepUUVz5mo2/4aSX+deUbRJ
	e+vJEecrjH6f1BnBCIqNIgdzOje9nBIXMmJPVGuhAd+wxRdE1gsoRf4gpW4K+opM
	t/LEhk3kdSLJ+HEeY9mzNpNg717KjOt3/LdTHFcWE1sKzV+4cANYxYI+pz75cXgZ
	yH6+3MYupxAgaq4JekbQA==
X-ME-Sender: <xms:d4YtaDL31a7hBJ2h74gZGG-cYi_jpsjAOb07HfYvpL0inndFBnKuWBc>
    <xme:d4YtaHJIPzNKzg_0nfGtpDx6Yna79wP95Opl6FRzyCJwn44B6Zzo6caBGt96nORg0
    -EPjANtCWbODYpD0A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvheefucdltddurdegfedvrddttd
    dmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgf
    nhhsuhgsshgtrhhisggvpdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttd
    enucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkfgj
    fhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghugh
    hssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghi
    lhdrtghomheqnecuggftrfgrthhtvghrnheptdeigfegjeegjefhheeuvdegjeekleegud
    dukeeljeektdevjefgiefgfeekudfgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrsh
    htmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtth
    hopehophhohhhorhgvlhesrhgvughhrghtrdgtohhmpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:d4YtaLucgEmtgV8viZQIPEJj1AiKGzWxuPI9B50l3mUVaUygrPnU9w>
    <xmx:d4YtaMYp2sMvHPCd2soUsLSvwuhLB-7ZSMYT1cY2Ie9Sc7BhX7V9Dw>
    <xmx:d4YtaKZxN9g1IJZLocr8OGcHOaNrpNWdBrJfv-ZW0noA2g2KdXkc-Q>
    <xmx:d4YtaAAkpRnE4bGHLVoOPRA4bMSd6rhiabNoqQzUPjAggPJ4PP_4mQ>
    <xmx:d4YtaP7po80syHzZs0yC4Lw8wOXqBSjMmVrNdi9UQIH_WCI1iJUBwWvl>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 72B4A302005F; Wed, 21 May 2025 03:53:27 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T4cc5a9967cd96d54
Date: Wed, 21 May 2025 09:53:07 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Josh Soref" <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: =?UTF-8?Q?Ond=C5=99ej_Poho=C5=99elsk=C3=BD?= <opohorel@redhat.com>
Message-Id: <b2abe6c5-042d-4842-9928-39b7fb7b2c0a@app.fastmail.com>
In-Reply-To: <pull.1925.git.1747813502225.gitgitgadget@gmail.com>
References: <pull.1925.git.1747813502225.gitgitgadget@gmail.com>
Subject: Re: [PATCH] cvsserver: avoid precedence problem between ! and %s
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi

On Wed, May 21, 2025, at 09:45, Ond=C5=99ej Poho=C5=99elsk=C3=BD via Git=
GitGadget wrote:
> From: =3D?UTF-8?q?Ond=3DC5=3D99ej=3D20Poho=3DC5=3D99elsk=3DC3=3DBD?=3D=
 <opohorel@redhat.com>
>
> With perl-5.41.4 and newer, git-cvsserver fails to build because of
> possible precedence problem[0]
>
> Added parentheses avoid this issue.
>
> Full credit for finding the issue and coming up with the fix goes to
> Jitka Plesnikova (jplesnik@redhat.com)

You can mention the person in the trailer section above your signoff.  F=
or example:

    Helped-by: Jitka Plesnikova <jplesnik@redhat.com>
    Signed-off-by: Ond=C5=99ej Poho=C5=99elsk=C3=BD <opohorel@redhat.com>

Or choose one of the other common ones (from `Documentation/SubmittingPa=
tches`):

    If you like, you can put extra trailers at the end:

    . `Reported-by:` is used to credit someone who found the bug that
      the patch attempts to fix.
    . `Acked-by:` says that the person who is more familiar with the area
      the patch attempts to modify liked the patch.
    . `Reviewed-by:`, unlike the other trailers, can only be offered by =
the
      reviewers themselves when they are completely satisfied with the
      patch after a detailed analysis.
    . `Tested-by:` is used to indicate that the person applied the patch
      and found it to have the desired effect.
    . `Co-authored-by:` is used to indicate that people exchanged drafts
       of a patch before submitting it.
    . `Helped-by:` is used to credit someone who suggested ideas for
      changes without providing the precise changes in patch form.
    . `Mentored-by:` is used to credit someone with helping develop a
      patch as part of a mentorship program (e.g., GSoC or Outreachy).
    . `Suggested-by:` is used to credit someone with suggesting the idea
      for a patch.

--=20
Kristoffer Haugsbakk


