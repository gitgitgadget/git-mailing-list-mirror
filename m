Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81704946C
	for <git@vger.kernel.org>; Mon, 16 Feb 2026 06:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771223960; cv=none; b=kDokvCZ6mctYDQiS5zpLblj97B1gwNZERV1qhpoRG+PxvKjJ1m1VVkdLCZQVYuU4lFS0K0hCodsmFg6JDhPFOwOxyrJZtj7Q1K+ieVCPMbJW9yWNkLkKctjiKZzs1X2LPv5MT8IvvbUfUKmr+CA/zBYtzu5UsJrSMdwr5KCe674=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771223960; c=relaxed/simple;
	bh=g5eb9lUNReg0myYDTB5rPvGAb/CKnVbt8oLAP2ZDlLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jacd7siY5mNFVtPVMAb8ojWzKqnF+o2CcVPkzsNrwjPpBsildao7m59kRJNQA39fOgDp9r+E6ajhcyTPi2+QgDGMnpir1LhxVNZSG1m3dMIkBs26fHf2k16/itVxUiXo/ea3PaDL7CpJgQJpZowkEe4LYhHjn19lhjue6V7461s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZoiW4oEC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rK3FbV+3; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZoiW4oEC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rK3FbV+3"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 3EBA51D001C5;
	Mon, 16 Feb 2026 01:39:17 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Mon, 16 Feb 2026 01:39:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771223956;
	 x=1771310356; bh=+XD05kOfn9FxEBATy9v/br3VD1EqfcivenZy+eczFPw=; b=
	ZoiW4oECnhlkcaG7u5ypWrY8hi8Dt4CsjtCln5ukIvdSFFLNvUt3ncwnp0n9yGk/
	EVYPcftPNQMUxnuFUeU8xW13avMq+dDZ8suXt2CGzfCPRkn12DO+Ye56srHF+nVj
	FJHb8j2qLlT+wVKXCsNJUPoLN9/lAhIz9rpOPiF5hd2bXwgzlZzT++E+EPje4WRU
	nrm7T1GDFF/8+6O9v+wD5APOfpzhCTC+kfuUx7x2zB70R5ejrNavQRbBXCaQKECd
	m46GuoZ9Y7d0lQIoleBXpBnSpBGEeXt1endNbXIFg74EIzpW/ykzs9h9t5eXYGfS
	9IwlaN66nCPcIm+ZM3G8Sg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771223956; x=
	1771310356; bh=+XD05kOfn9FxEBATy9v/br3VD1EqfcivenZy+eczFPw=; b=r
	K3FbV+3/rbn5eUcdKf2r8VRpFJ8Rtjjl6EEl4tQK5VS93FVSZLcWz+ED5f+bZ8/B
	y+K2MBFLbCE2l8zGc9zSTkF7u8w/j47xvfvZdPURYyjVjHrHhz8PLaSY8Ubq9M8M
	XEpsa3Ykx5BKwnuQrB46ZAsSTpcNbghPhZdUZp1TC1yF37PZcLM+GldVcyaKncDD
	BMH9jXF8OFJn/DFXROjKH8fsZoWoBQSOvdgcZYQCm4YeUmQ//5/Z62P6pyWV4OmH
	tRWZgPyrZqtdsf5PlHm5joskN6pfFUDf7vTXQU/fs2AcMEHNuwQnNHU9dp1QLXtA
	oECEaPJPYq9JoMGPy19wA==
X-ME-Sender: <xms:lLuSaWOtPnA3OQui_aK27zCNZI1fu6vIvZFe8g4NO8zAcvu526WnLA>
    <xme:lLuSab-F6S56B1oO14B2TjfPMsZFNa-KmbMpAYWtGVE654J_0OjZ2DpmDdBqA7Rfu
    N23LmHSwAyIDE2E7W7nN2tkenR1T_mw6NfWZx7sWo5ck37ksnEzCMM>
X-ME-Received: <xmr:lLuSaSSalSPXsAuaufb6dRpyzUmeaHC47quIkI2N7f88rMa_QYMSLkF99hGsEu_zraqS6EV2W82zqK3SkUsQiZzv7HfCW-4BeGRCjexfAg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvudeiudejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpedvfeejiedtteelheeiteekveeftdefvdehkedvveetffdvveevjeejleegtedvgfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghi
    lhdrtghomhdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrg
    hsthhmrghilhdrtghomh
X-ME-Proxy: <xmx:lLuSaVkHf7lF75pvBEJTpxgvZqWFHGLuyiQQUVlH6z5XEaYJjNnnQA>
    <xmx:lLuSaaRM_bybd4MhXFcW8ngOTOQbt38VruB7j6d54L18H6PJvGUmHw>
    <xmx:lLuSabNHezjdRo91KTepg-Wz6jt_KZacK_OGeXnN2VIxuhhKeC4ajQ>
    <xmx:lLuSabVs16k_CqDLFlOND6XbX-LlfKGe0ugRuS8FLyPRYpCa7bee0Q>
    <xmx:lLuSaVxVzf5ovHtZg8xWC17Tgw9-ce2i6fKXeqohafABjphtD3VQl5Dx>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Feb 2026 01:39:15 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ba870d02 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 16 Feb 2026 06:39:13 +0000 (UTC)
Date: Mon, 16 Feb 2026 07:39:10 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	"D. Ben Knoble" <ben.knoble@gmail.com>
Subject: Re: [PATCH v2 3/5] builtin/history: replace "--ref-action=print"
 with "--dry-run"
Message-ID: <aZK7jmvLwu1evxUp@pks.im>
References: <20260213-b4-pks-history-dry-run-v2-0-756ac376e9e5@pks.im>
 <20260213-b4-pks-history-dry-run-v2-3-756ac376e9e5@pks.im>
 <315801b6-bc9e-42b4-8356-12fd8b83223c@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <315801b6-bc9e-42b4-8356-12fd8b83223c@app.fastmail.com>

On Fri, Feb 13, 2026 at 06:30:10PM +0100, Kristoffer Haugsbakk wrote:
[snip]
> > Besides usability issues, it also has another issue: the dry-run mode
> > will always operate as if the user wanted to rewrite all branches. But
> > in fact, the user also has the option to only update the HEAD reference,
> > and they might want to perform a dry-run of such an operation, too. We
> > could of course introduce "--ref-actoin=print-head", but that would
> 
> s/--ref-actoin/--ref-action/

Indeed, I've queued this fix locally and will send it out with the next
version.

> >[snip]
> > +`--ref-action=(branches|head)`::
> >  	Control which references will be updated by the command, if any. With
> >  	`branches`, all local branches that point to commits which are
> >  	descendants of the original commit will be rewritten. With `head`, only
> > -	the current `HEAD` reference will be rewritten. With `print`, all
> > -	updates as they would be performed with `branches` are printed in a
> > -	format that can be consumed by linkgit:git-update-ref[1].
> > +	the current `HEAD` reference will be rewritten.
> 
> `HEAD` is mentioned here because it could be detached `HEAD`. So you
> can’t just say the current branch.
> 
> “the current `HEAD` reference” seems a bit much. Is this less precise?

It's not, but this commit doesn't rewrite any of the description, it
only deletes the sentence that becomes out-of-date now. So I'd prefer to
keep this as-is if you don't mind.

If you feel strongly I'm happy to add another commit on top.

Thanks!

Patrick
