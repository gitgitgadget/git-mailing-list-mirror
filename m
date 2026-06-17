Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7290538655B
	for <git@vger.kernel.org>; Wed, 17 Jun 2026 21:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781732501; cv=none; b=uUiPrNTvDbA+T8UhZps/x7SKdb229MrCTyrMzZfEbMBCI/9vM9AZFbN+sIpAieClcXzLM79poM8KsNep4fHMaJPdZ7vKhcZU0qoMJGpS2j0QvivVW21d8hNuERb1n9lrgobwA2O6T6MZg5MA8xuny17AgUTKa7khFvBLxKjUqJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781732501; c=relaxed/simple;
	bh=0CdksdxdW/TMoiICPiHMw+/2/x5pP639xe84i59miAk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lQngRLabL+kRYJSvx8BkQ6fCKgT8pnZumHvVzyWdB1Z9UGTBqWjiZ7yibwDZDsfsdgilrhqI9i+tnbzKrrGsP/C2IJN9vzkfnBxvG9l3+NwbHiCCVKGu8E0vwjL731J81LfGUXRtwkGVC/gp1IDagFUOQ9Me/3KOWFgr8NtO1a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=d7dlehS9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LbSffYw4; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="d7dlehS9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LbSffYw4"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 2B5831D0001A;
	Wed, 17 Jun 2026 17:41:38 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Wed, 17 Jun 2026 17:41:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1781732497; x=1781818897; bh=PwNT0gACXt
	TynZEr05LFx6DeGPDt/irjBVU+Dhg+FKs=; b=d7dlehS9CcOeNkzG7sg50SvlhU
	FbEkHNcA9Hl11Ss/Jsu63Kv5Lau1GXqCkZbxOgVH+XUmKr6kvU4zzld3tjIupeDm
	1fRCmXGcgI65MjkKG2gyHrBlFXbXWProZeMIXf2dUvyJcjW5L65iu+ceyZ899BlX
	JMbasITOsp22fulDWN9iXjQFo4za44khX1luvh/g6GU4bRdeyYYDe6qh3NRgS9cX
	+ogUtlccR3k4DTMp6M9lyyOqDLRbbPXfmSLoBzEpjIXNYHoAv/sO8N0SDH9jTo/E
	Q4l1ZSwqxTNDCiWND9AlwA9ScWXk1Wo6DxGvZFJqV/b9JtMO95YV0vgwjgag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781732497; x=1781818897; bh=PwNT0gACXtTynZEr05LFx6DeGPDt/irjBVU
	+Dhg+FKs=; b=LbSffYw4HKxPxoyq045Taq5Ap7YBVD51E46bzWRZaACUijl7KoI
	raAl6KXfNnKZn72WLJDCw93D+nvoj6guXsYrzfvTxrxqkX5r12ORmSXtSmzKHeSM
	fL/2tAKrnSsIvKsa6qjQyeILCL+nbAezQmaOe9Dtso2ooxxJp91grOkCW7b7C+YG
	TNC/R0FK0HBVWLIZwuAykDKemzw/bFIBoxo4gM3ciFbxQvtIpvvCVTHlxd1HwD9e
	G+YYPY9HmfLP6bZN4stgEzRUkK6DOp4hXCZzoqOa5yWLECywbJPqY+zrxS/KDWOF
	KsjzuCDJX0fFgbicKZSAHJKw71o5gA0yGeg==
X-ME-Sender: <xms:kRQzatGqkQQwErYU5jDUzGnzWqZRLrZZp2qId-Erd8UEFfXecE7GTA>
    <xme:kRQzapNnVqPwufntOZZMhL1hENemjQubxa7jFZ2ydignTkW1hnBCabzj9QITUB2vj
    xIbVClu3dW7uIFj-6SHnJ8lqOpSOL8Kka7P0kSLPlKDQn96ZLVDMDo>
X-ME-Received: <xmr:kRQzane-bsUWdYpsuyBjzOF9sXwtuSvbiCmt1cnU4Z9LzAtsoJPM4GvJzpRqPKNGiimFkJSJjj1OVsufwezrK1pplJ-L2cDQU0iR>
X-ME-Proxy-Cause: dmFkZTGlkBMjYjufDoNjo7aFQ1IBL+AwQE2l3modqGrSYe3UbhGN1lNpHaU/uiquqOep1+
    Q9Nvv2ov0xCqOTj8NdtzeLoeXTekXd/tJEiUdc/j4k7yOAGRsYQDqRG8H+C13JmryxpCa9
    9JYcPZykz5FepX3Rpjfy/sygZFNO9iLUwSYvdX8J06Gsk0813+iCjba9Vx26KFEYolmds3
    BzyuJtGTr9+SKgVQVOZqciR5WimVpRY0Q/8+pF2FOIo+rSoZp1WxDhsC1A1/eYGSz1G/fI
    c5qWXga/fcDgiSFjoww4g68MbNQnyZG33nr4U5HIO4n/pjwVjO2gcmd+lwLiwgPRml6TI7
    tOR4iGQoDTKrrx2SBTT5VIMh7QNHX1J/LYnXP2wedSvO9Vvgqf46a2/2dM1pSosgZhs10+
    +LfpbE2tgAO55fsEUBM2sCgi9h4hAHaDguRM4TTXxAAigy84gVS0mOFOe1T9SBg1dhiVtM
    lelGxilghhVzDeuuKzrAl/r6m5X9esrOAJOUkuCHecIisR9pu4mImdpKiTd8H3VbN7TZcl
    OPdw3kGVCyNOAT4KM1Gu7M5X5h5IsmNS3zhWV56FcC7YrAaAhREm44tj1xtpdpZwIf44hy
    rZmC/CB4Ho9iyczdB1ZrTKXEUNdCVZvq2/liWMbpfr+G6gbgxv5CmdlcJo5A
X-ME-Proxy: <xmx:kRQzaussm9yRXDKZjo1ds5beWinsfUD_bTG3C8FJ5mRK--XmhL2ufg>
    <xmx:kRQzagn_JsDgL6Iq-moMkh1yJMRux7IgYXbVgYlP-L105brMaJCLqg>
    <xmx:kRQzaowGBcg37KUbAODriwM1jD-3VKx-Y6qev987NRdQp5n7ZyUEQg>
    <xmx:kRQzaqPZTnUbc8ZmO1YWRqwasiAX0I6hq5-nzBRzILN_HJmkrm4CUw>
    <xmx:kRQzanXIeVPoDuHXxmdpiV4C3v3HP55HGSQXltTmJ2Fp15bEtU1ILKjt>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Jun 2026 17:41:37 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk <code@khaugsbakk.name>,
  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 1/5] SubmittingPatches: encourage trailer use for
 substantial help
In-Reply-To: <V2_encourage_substantial.9b7@msgid.xyz>
	(kristofferhaugsbakk@fastmail.com's message of "Wed, 17 Jun 2026
	22:52:15 +0200")
References: <CV_SubPatches_trailers.8f3@msgid.xyz>
	<V2_CV_SubPatches_trailers.9b6@msgid.xyz>
	<V2_encourage_substantial.9b7@msgid.xyz>
Date: Wed, 17 Jun 2026 14:41:36 -0700
Message-ID: <xmqq4ij0vo8f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

kristofferhaugsbakk@fastmail.com writes:

> diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
> index 176567738d4..0b12badf86d 100644
> --- a/Documentation/SubmittingPatches
> +++ b/Documentation/SubmittingPatches
> @@ -443,8 +443,16 @@ identifying, and not misleading.
>  The goal of this policy is to allow us to have sufficient information to contact
>  you if questions arise about your contribution.
>  
> +=== Commit trailers
>  [[commit-trailers]]
> -If you like, you can put extra trailers at the end:

I think majority of AsciiDoc files in this project places [[anchor]]
before the "=== title" of a section.  For example, here is how the
patch flow section begins in SubmittingPatches:

    [[patch-flow]]
    === A typical life cycle of a patch series

    To help us understand the reason behind various guidelines given later
    in the document, first let's understand how the life cycle of a
    typical patch series for this project goes.

I do not offhand know which way is kosher, but we should be
consistent either way.

Thanks.
