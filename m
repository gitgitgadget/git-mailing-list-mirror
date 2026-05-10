Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8783A347C6
	for <git@vger.kernel.org>; Sun, 10 May 2026 01:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778375478; cv=none; b=Fh+FVyFJtlj7mCPfYZLvBnVgA0DGCZI2LOFosZmoq6K+TGMeML5AKJr42KIkFUO5GbMmNonexy0SjEuD8Ktdfi6gfS86ElCdn4Qwtpqn/0kVGdokAq6Av4zpXEf7pbsHn0Vqu0I+xTDWo8ZKb4XMH0gryQMuZ8xn/bod61gOApM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778375478; c=relaxed/simple;
	bh=S67qOv7vr59ubiu7hdk6juLAMSmt4r7MCfiSrGkGGxs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NVDwOPWp2pLOrj4ZV//e8TpVN8CpdF0bDw90Bbg8uN/2xvBYB64D3B5Dw3eY42R1nQOjRJeJWevEF+PDMEtcEYfBYeyJ6P06OniyhMJOia/HsCvnF5xliJZHSvJlOlTbaAr+IVWqn7rf9c5Iv17tOjwVzSlgK5d8/Zx/gGR23rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=rRMOfbv/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZHUphVeR; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="rRMOfbv/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZHUphVeR"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id C5DC9EC0064;
	Sat,  9 May 2026 21:11:16 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Sat, 09 May 2026 21:11:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1778375476; x=1778461876; bh=OekPK1brsP
	jRr81AK7TiYWjOKvdk98YKvOYClcXzmvE=; b=rRMOfbv//Qw+Hzsl/YvKDmu2Qc
	A7yFTf6knCobJYX1AefSTb86KN5Ju28eMBZEgG8feuJBTMNPa/0E2LcJsdTthshO
	2+789wrlkXAbDlfaT3MVlt6ja3oBYg0Csu4scC1re4cNVDj6VDG/h7/FbmxdBqqM
	iziyNsqh6XWrL01ENbonUEaIOZQRWD0e1vhJrf639tJQpVhqhHC+vERGbkc4YZPS
	IElE0ECih/Ft+2XfFIxRU/G5fhvH6xbei9zFBJjKGKyAY3kVTWXhx0XwEHXIAzna
	wwBGvTvgDrvoPCDZQm4bSqpWDE1LNW5y1ICG/Uc8mKkyxpMVMuwODOXbYW+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778375476; x=1778461876; bh=OekPK1brsPjRr81AK7TiYWjOKvdk98YKvOY
	ClcXzmvE=; b=ZHUphVeRQ8DsJ8B4UuSnFuArsYoCNA/Xw7rlh95KAhTImKs2d1F
	iyywFyzrID+p+mTFavnQoAN8XPS4Tjwdfu5Hvtc9jJX6vhfrtZjKWTMEyaeCcCCV
	hUnhLS2qkGlqdXegwjSNl3+tpsB0s9qrHxaga/nV3lzF9MhqLgK7lKTcRRuoNPM4
	aKErEbwPEx6YlG9Pdwx2dUKE94gRVf0kU8pLA4R/H6u83qu1TDFpSI1ZJ0BzOg/L
	9iRZ/mLiBMz1PR9CY4z6MRbDrtx821ubm5po4dw+XIrQiGVCV/dq3g7vsNT1zh62
	nt7pIdoBWPkF+r6XwVpRb1RwE3n1r0TI88w==
X-ME-Sender: <xms:NNv_aYXI-czINKT-_JKwxOVNZmMIiUUnOlr66f4HuhhjCsLveGa1yg>
    <xme:NNv_aTmfTETxMbzJ2ofp0XJqd8vMbyE-Q0tjsZWmtc20-j3H1YjcB1aI5o5XXTtSF
    7NWAri1eZ9ffdi0gXx0MHibno8z9lcCrohKvKjSNDFe1xoVo6H5QQ>
X-ME-Received: <xmr:NNv_aRYPI5BW1DMnlOVi1AQVCXEEbYASx3vag1_EGYhM3BxLRXjgvLG4AaOgg5mf48hozEIGncCvcGn7jhCdPQZm9vLH_ShxfQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduudegjeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhephefhkeefkeeiveelveekveekkeelgedvvdelgfeuhffhgffgieffjedviedv
    gfegnecuffhomhgrihhnpehsvghquhgvnhgtvghrrdgtfienucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgt
    ohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    hmrghilhesrggshhhinhgrvhhgrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:NNv_aWM-47MuBhUcRrB7HySv4hMFbWS4DC-fJavnFq3U338TDr1Z0Q>
    <xmx:NNv_aea3U8ye_MhHfyPL6U-IITuhXtxyIo0BPMDm9l6dBQWxF8DwGQ>
    <xmx:NNv_ac0-fIG7t_ZSsLBdLW7UUX0shwqbDAmKfQ_EiqeTTo-a6MM7HQ>
    <xmx:NNv_acf-OfXh17rgfZAAwq9G7ovRgEka7_GnJrovpU8h7uj_bfyvjw>
    <xmx:NNv_ac6ssWZPgxKLtOMyTF8snUedHt8p0BXXmXzr-AkBitzTf0CMvy-7>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 9 May 2026 21:11:16 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: mail@abhinavg.net
Cc: git@vger.kernel.org,  Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH] rebase: ignore non-branch update-refs
In-Reply-To: <20260506023944.90691-1-mail@abhinavg.net> (mail@abhinavg.net's
	message of "Tue, 5 May 2026 19:39:43 -0700")
References: <20260506023944.90691-1-mail@abhinavg.net>
Date: Sun, 10 May 2026 10:11:15 +0900
Message-ID: <xmqqqznk9ih8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

mail@abhinavg.net writes:

> diff --git a/sequencer.c b/sequencer.c
> index b7d8dca47f..25bcfc5da0 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -6428,6 +6428,16 @@ static int add_decorations_to_list(const struct commit *commit,
>  		const char *path;
>  		size_t base_offset = ctx->buf->len;
>  
> +		/*
> +		 * The global decoration table may contain names loaded by
> +		 * a previous pretty format such as "%d".
> +		 * This will result in refs such as "HEAD" being present.
> +		 */

Your long topic branch may have local unannotated tags that point
into the middle of it, marking strategic points in the topic.

With this change, the command no longer moves them when it rebases
the entire topic.  Isn't it a regression?

> +		if (decoration->type != DECORATION_REF_LOCAL) {
> +			decoration = decoration->next;
> +			continue;
> +		}

In other words, what you want to prevent from appearing in the insn
stream may be "HEAD", but if so, "must be DECORATION_REF_LOCAL" is
too broad a net to catch it, and causing unintended collateral damage.

As to the style, as the body of the new conditional works
identically with the existing code to exclude the current branch, I
wonder why it shouldn't read more like this?  The following
illustration still uses "must be DECORATION_REF_LOCAL" and that may
have to be corrected, of course.

 sequencer.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git i/sequencer.c w/sequencer.c
index b7d8dca47f..1ba95fbae1 100644
--- i/sequencer.c
+++ w/sequencer.c
@@ -6429,10 +6429,12 @@ static int add_decorations_to_list(const struct commit *commit,
 		size_t base_offset = ctx->buf->len;
 
 		/*
-		 * If the branch is the current HEAD, then it will be
-		 * updated by the default rebase behavior.
+		 * Exclude the "current" branch, which will be updated
+		 * by the default rebase behavior.  Exclude non-branch
+		 * decorations as well.
 		 */
-		if (head_ref && !strcmp(head_ref, decoration->name)) {
+		if ((head_ref && !strcmp(head_ref, decoration->name)) ||
+		    (decoration->type != DECORATION_REF_LOCAL)) {
 			decoration = decoration->next;
 			continue;
 		}
