Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9653227D782
	for <git@vger.kernel.org>; Sun, 24 Aug 2025 17:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756056374; cv=none; b=piLo/MFUUCEk59F9ubTT+vHRDuuUtD2BG0H9g35Upi/FgoNgWNsI/40++Xps3gvW9RYKsNd/k173rKug3mIR5STjWeyOdUYlaTsZYJ33+iIek3GpvbHBfsG/LN/UKL+tqNYw0VkKt/fwHGKeg+MAgfdr1ZTiZtVcMyJAYVkNxk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756056374; c=relaxed/simple;
	bh=V6H7QPBFpf/3ZO45BeQJvtwUt7rwjIAfEaoMUW28vYw=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=necsYKyuysalrYZx3feqs54A5xXre8UMP6RmTBH9roTNJk+33YJ+mZSSvW0A2xX0EBAaGh8psxlJhDYvXHug+7rWLCbX8b+nq+ppj4SfynnvJeXFXiYfizXrl6G0XmnDkEZM2sy+EwlQjLIAGIHrt4B+I0PCw/T9nefwAhs0E9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=FIMjG8NJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ItgGCeZO; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="FIMjG8NJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ItgGCeZO"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id A9E631D0005D;
	Sun, 24 Aug 2025 13:26:10 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Sun, 24 Aug 2025 13:26:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1756056370;
	 x=1756142770; bh=8yJj9EdBt+fwfpCoBgYVjTgXVGZdcUVdi0KZ1z6FvJc=; b=
	FIMjG8NJAjwfwbGDDBCENbyDrvLfNtyG21qkRF/zt1bnJqrjUpHrRe0OdPFbORKl
	9K7xeLcqfEeAPg+uVd41vNPkJZAhcmEgZduspwnywdHnV6qUbo81U+1yULJMRGjK
	6n7gRNPaP/cCRtWnEaVoprUCBHdq/+nKjVIrlPYkqiLj3Z3cw9+ljF38MMXRe838
	ncbPJzSbeHfR2bb5cE80MpUIbEHTaDTRkvp5t1CTnilgiAQp0tcnY5cBfBvUVs0+
	yxztWBdb2shpMStjFlj3luoMarzcOsZPLpSWsHt4v3WX8rOpwttTiYdy9vrDl27R
	QhSBmhhnMNNEbGGjRZtMDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1756056370; x=1756142770; bh=8
	yJj9EdBt+fwfpCoBgYVjTgXVGZdcUVdi0KZ1z6FvJc=; b=ItgGCeZO9SQ4Vle/C
	v89WeeCFCBuwHPsDBzmI9I847ohw22WChe7ISPoVArIeIyrggQVjsffPKQCyUc8i
	sNCSueitElX9SZ8o5vHVfniOOeQX9IAHE0WtaeBW8xVA/MyHeM3ufRxoyVeuY75R
	WlxSAaV5QHGgKQlMqSKakE0gY02Nccy5MWoSTWTbgVYtIzmUEfGrsol7KgjRdNsG
	J+MHj6evTdgT3prBEOTpq0oGU3ZfWgs+DhKT0OPSiaRwvgXYpi1exPNxf05egvVx
	oJztnN1NNDuH9e/MayZ72zixyZM+NjKmBFsdxSQmgFf27lG4l5E6a4J+LDEoAaTa
	6QieA==
X-ME-Sender: <xms:MkuraCwfHX7mfv2qKfrKy-cFb0qlm_RUPuXMALhogmTts2dQ7W0_eb4>
    <xme:MkuraOTp7QjMk21whD3sm0dKTmDRPtDfQtea4Ux3Id0Lp0Iyj9uZVrQc-N_VlSd20
    JRSiPIG0_bvi4EV1g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujedtuddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvffkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpedtgfffteetudel
    hfefkeehtefggeefjeevieekfeefieekkefhveeiledtkefgueenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepvddpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:MkuraG2nAIschspSA0axO_QqSKbTXyTQO-k9ynOMkGhDFnUGPNq_-A>
    <xmx:MkuraCC19Y3IZTtwUAdIGzzD_XBL_C3ZNH7PYpZSk03pZlI_Y7mEmQ>
    <xmx:MkuraA3KcIku5S3YHzOVW94igNIU3_W6h_098b1WcsYVkYRU85xIEw>
    <xmx:MkuraEtoHkArV5JzKgEd-kt2It2PhtkaWcRhXGHPs6T7577tn-Njnw>
    <xmx:MkuraCnUtOWVNeMPQmTjvGearSVaphw0SlEURr8uFPUV_QrJg2XNS5hM>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 46C061EA0066; Sun, 24 Aug 2025 13:26:10 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A8xKGemTdluZ
Date: Sun, 24 Aug 2025 19:25:48 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Patrick Steinhardt" <ps@pks.im>, git@vger.kernel.org
Message-Id: <f9f4a4d7-3111-4671-8b5f-43c96702f83e@app.fastmail.com>
In-Reply-To: <20250819-b4-pks-history-builtin-v1-6-9b77c32688fe@pks.im>
References: <20250819-b4-pks-history-builtin-v1-0-9b77c32688fe@pks.im>
 <20250819-b4-pks-history-builtin-v1-6-9b77c32688fe@pks.im>
Subject: Re: [PATCH RFC 06/11] builtin/history: implement "reorder" subcommand
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Disclaimer that I=E2=80=99ve never used Jujutsu.

On Tue, Aug 19, 2025, at 12:56, Patrick Steinhardt wrote:
> When working in projects where having nice commits matters it's quite
> common that developers end up reordering commits a lot. Tihs is

s/Tihs/This/

> typically done via interactive rebases, where they can then rearrange
> commits in the instruction sheet.
>
> Still, this operation is a frequent-enough operation to provide a more
> direct of doing this imperatively. As such, introduce a new "reorder"

s/direct of/direct way of/

What=E2=80=99s a use-case for doing this imperatively?  With a nice reba=
se
frontend you get to shuffle around some lines in your preferred editor.
This seems like using Ex mode in Vim.  Which is legitimate but I don=E2=80=
=99t
quite see when you would do it.

The thing with e.g. the Drop subcommand is that I might have some
commits marked `TEMP` that I wanna quickly drop at some point.  That=E2=80=
=99s
sort of a semi-interactive use case; I might want to lightly script it,
but I am always going to invoke it interactively.  Doing that light
scripting on top of git-rebase(1) sounds like a hassle though.

But in this case I don=E2=80=99t understand when this would save you tim=
e over a
nice Rebase frontend.  Because I don=E2=80=99t see when you want
semi-interactive history reordering.

> subcommand where users can reorder a commit A to come after or before
> another commit B:
>
>     $ git log --oneline
>     a978f73 fifth
>     57594ee fourth
>     04eb1c4 third
>     d535e30 second
>     bf7438d first
>
>     $ git history reorder :/fourth --before=3D:/second
>     $ git log --oneline

The `:/` notation makes sense here.  You=E2=80=99ve probably just made t=
hese
commits so you want to match the newest ones.

Is this example meant to demonstrate how it works or to also demonstrate
how you would use it (i.e. with revision syntax)?

>     1610fe0 fifth
>     444f97d third
>     2f90797 second
>     b0ae659 fourth
>     bf7438d first
>
>     $ git history reorder :/fourth --after=3D:/second
>     $ git log --oneline
>     c48729d fifth
>     f44a46e third
>     26693b8 fourth
>     8cb4171 second
>     bf7438d first
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  Documentation/git-history.adoc |  32 ++++++
>  builtin/history.c              | 135 +++++++++++++++++++++++++
>  t/meson.build                  |   1 +
>  t/t3451-history-reorder.sh     | 218 ++++++++++++++++++++++++++++++++=
+++++++++
>  4 files changed, 386 insertions(+)
>
> diff --git a/Documentation/git-history.adoc b/Documentation/git-histor=
y.adoc
> index 3012445ddc..6e8b4e1326 100644
> --- a/Documentation/git-history.adoc
> +++ b/Documentation/git-history.adoc
> @@ -9,6 +9,7 @@ SYNOPSIS
>  --------
>  [synopsis]
>  git history drop [<options>] <revision>
> +git history reorder [<options>] <revision> --(before|after)=3D<revisi=
on>
>
>  DESCRIPTION
>  -----------
> @@ -40,6 +41,12 @@ Dropping the root commit converts the child of that
> commit into the new
>  root commit. It is invalid to drop a root commit that does not have a=
ny
>  child commits, as that would lead to an empty branch.
>
> +reorder <revision> (--before=3D<revision>|--after=3D<revision>)::
> +	Reorder the commit so that it becomes either the parent
> +	(`--before=3D`) or child (`--after=3D`) of the other specified
> +	commit. The commits must be related to one another and must be
> +	reachable from the current `HEAD` commit.

s/current `HEAD` commit/current commit/ ?

> +
>  EXAMPLES
>  --------
>[snip]
