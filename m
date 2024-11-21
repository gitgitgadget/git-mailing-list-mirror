Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4DE428687
	for <git@vger.kernel.org>; Thu, 21 Nov 2024 15:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732203132; cv=none; b=kFAkVyMH+uRS+YBjinbjdp2INTPlUvLj99Y4Gnoy4thXMY+RowJWjDVQQLFHEyRGEnPLY6XeEFHZMjdc98gNxHu8Aw/mn8u3xJBjiYVtZI8WBgKNwAi/xG/Sg6xqcRuVG1RBfDW0a+W7xlApS3RCn3QXQAnhWliAyj+Q6xTUvSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732203132; c=relaxed/simple;
	bh=CaOcEWhdN91bqCMztryrXD7k07NTiX+/kPZnYUBT4mY=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=l4IEx3VsKJXZ9ZhEhaRRjfyh6r07AGPyyAohUVNY1rBXLRr+v1jS7zRZdbUJCmqYUA8Se645j2Y1XhBDGcgYD8GRNTXd8XpOrO283e2Bqa1BXjgsqHJKe405qeI/2HjFLN/Y+JbddJ6y9jIsFud/XFCzjiA1QXY3xB7btebQJic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=GsnAgqu/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=2Q6tLrtQ; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="GsnAgqu/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="2Q6tLrtQ"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id AF3A4254009F;
	Thu, 21 Nov 2024 10:32:08 -0500 (EST)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Thu, 21 Nov 2024 10:32:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1732203128;
	 x=1732289528; bh=BrKDdjSm64sDWNan39SZeyNXiqcBfdeBhjQwFxi5PzI=; b=
	GsnAgqu/0CD1y1x7RqR17fnOGLD7p/Lb0g8RPAtxi9az0Zx9F9S96Pg4USYsXMfQ
	Sn9AqfFN3HE3mr8XfU4Uq/T2uUE1mn/JKNGlJ7iIiIHQHxlZayIbpdpg14KGxRVI
	v1C4Mh9T5+opvcI3/rd6A/DsD2SQTY6yO6ebcXKgQa4cr/H4PXYAkl0xtQTDEtku
	ENJscKQ+x36iCTBF1ZM4KzMWUekA/zcs2qYqaX8ja2HDnQDb6lPvd2ZOR3uD/dJu
	tE1E23rUNwoWPxZ0B6LE/byO9IhMm4ABABcPA8aTs7PsrkL1FZjCp3pcfHsjk28t
	HnR8l8+BzNlCm5IIQ20/Cw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732203128; x=
	1732289528; bh=BrKDdjSm64sDWNan39SZeyNXiqcBfdeBhjQwFxi5PzI=; b=2
	Q6tLrtQbwf+pj5RZ2geAwBBKmeAcznbk+7sOvwX62lX8mEusB4+KyVmJWygI198I
	RhIarrpsLq4ouHx6zAHzzBb+g6XgBjCd3O1fmZa9ovsABmFfKqGmledVfMb2G5vB
	+3YmuJ73XRz9/y8fmPu2KxIJ/HK56NBYabjsKSd4bsfuDqRATFowVOemF3wv26Zr
	o7wgjFwZRZJhSaRc05ZN5enD7U1nuMWMHUR1LdymOxf0QD+BA6b+vIgIKWvnC1PO
	lJxwYEO3s/rr8kDxBQNvc0MHtW8yVX/xEsR+PeVn1Rnag4RerNzMA9UmmG0N5Taa
	zzBH36TuKT42f6pIOmlfA==
X-ME-Sender: <xms:eFI_ZyGhOQN7SmB0keu5pxwFWD9w-Aq_CL_0p8DfE_qYS01BkNXeqjA>
    <xme:eFI_ZzVdr5Yhl9riZlk3XUhjL7PSFQ0-xb7D35eh2DwZJqSbqJdGmDeGmyRf-Lla7
    v9VyzDHEDNjcNo4IA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfeeigdejiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepofggfffhvf
    evkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhsthhofhhfvghrucfj
    rghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsth
    hmrghilhdrtghomheqnecuggftrfgrthhtvghrnhephedugfevgfefgfffvdfhffdvveev
    geehhedutedvgfeuffejveejudegveefvdefnecuffhomhgrihhnpehkvghrnhgvlhdroh
    hrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehk
    rhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspg
    hrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgv
    rhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrd
    horhhg
X-ME-Proxy: <xmx:eFI_Z8KlpJBPuoFNTwb3PeePhsAf8mYO9QSfRZSYi1epddiancp7kA>
    <xmx:eFI_Z8FLwtJxLXomfdzfKgRQNKRcjFoLk8iudSDTzW7xOzF9x4OwIQ>
    <xmx:eFI_Z4Vr-bxuMLDbta2u7VO9FYo0I3srJoNXiRX28OLj2D3hESP_Ow>
    <xmx:eFI_Z_PhToKdLqmgvtUaYEE8WeNd1Y_tq0uTZL2UvWF7D4I9axhG_g>
    <xmx:eFI_ZzeuVMXPQaJuYdcbxknugyEb5sMN3UdGU-2FTmm8ZC_VQMbAY2Dj>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 4FF4E780069; Thu, 21 Nov 2024 10:32:08 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 21 Nov 2024 16:31:48 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: git@vger.kernel.org
Message-Id: <10282b43-4b1c-4e8d-a2cd-2aa725622e90@app.fastmail.com>
In-Reply-To: <xmqq5xogg2to.fsf@gitster.g>
References: <xmqqo72ai929.fsf@gitster.g>
 <a340dfc9-bc3a-40d2-a8ec-fc47c00d1305@app.fastmail.com>
 <xmqq5xogg2to.fsf@gitster.g>
Subject: Re: What's cooking in git.git (Nov 2024, #07; Wed, 20)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 21, 2024, at 13:59, Junio C Hamano wrote:
> "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:
>
>> What should be done about what one might call a
>> trailer topic version for simple topics that might get included in `n=
ext` soon
>> after being proposed?
>
> Sorry, but I do not understand what you are asking here.  Can you
> elaborate?

The patch got an Ack from Christian.[1] The patch submitter is supposed =
to add
trailers like `Acked-by` in subsequent versions according to SubmittingP=
atches.
But this one went straight from proposal to `next` as far as I could see=
. And
you=E2=80=99re not supposed to create updates for topics which are in `n=
ext` already. Or
at least that=E2=80=99s my impression.

So the question is what to do about such topic updates for adding traile=
rs when
the topic goes into `next` (apparently) straight away? I just let it sit=
 there
for the week in case someone had any counter-proposals for the glossary =
entry.
So I didn=E2=80=99t post a v2 with the added trailer before the next Wha=
t=E2=80=99s Cooking.

It=E2=80=99s not important whether the patch/commit might be missing one=
 proposed
trailer. I=E2=80=99m just wondering what to do in cases like this on fut=
ure topics.

=F0=9F=94=97 1: https://lore.kernel.org/git/CAP8UFD3p3ts_7kvk_Zm2efhcPUc=
EFnLcLFPAqzb40d46BTVzyA@mail.gmail.com/

--=20
Kristoffer Haugsbakk

