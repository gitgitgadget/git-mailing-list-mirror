Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08EA3BCD3A
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 18:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792003958; cv=none; b=nDadLaAnWPliMyFxw8Cen/TAGo0kmHMID/9n4nGM0pW2SAxIbjC3XWHIxns1lbFrXJqIg0JmsQYM3mDzfjUTZqQIDS4XLy/VxU0DPCzq9fUhQX4ufsO+NYM/B3RvrFGfd+NIsT98XBr6kjQHeoqIGYMxOQYRUOZawXIVjNlskOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792003958; c=relaxed/simple;
	bh=/p2YEBcR+uW+XzBV4B9fPdZihUrPFTYOpBvtVjgAz0k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PIgvjOSzNDbCvB/bETlSo+/H33Is4JrBAKdT3PGEbG7Yvd2zp7eck6I43t8bGN3V0ThQn1TdrTsadWLNpU5opD0gRcFjP5Lb5JsbaaNZ5wBN+Z1cQLNOb1O9hrfuPdbtdFiZKnM8K66zs6lPyWyhrdxAGK3qrtfe6F7lk+VmMMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=YPhjhhtL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=E6N1w2NZ; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="YPhjhhtL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="E6N1w2NZ"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id E0EEFEC03B3
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 14:52:35 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Wed, 14 Oct 2026 14:52:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792003955; x=1792090355; bh=ZiWXQDsJ9A
	S4L0Yhq9KojYdm49xsgAmRNTJd7dP3qxc=; b=YPhjhhtLc9kFfNc8DbRVJj0VuA
	XhG2+UvlXWzawmjWbhjdY6wdX0Ggrs2sU1vXmLTlRIfhOyLFYbyJ3hlFb/bIln/V
	p9EIibwyi39JXE58TYx8bQTyxraO+7uWEIybSY0jBeo2NK2UFYnBnfKFEjWudD1t
	04LjuRWg43GBHfqoYybkF+DbwdxPgQcJ3ET+XB/xxGVEqTr2kApxSVzDjgW0gWpv
	g1E8Mfv5ZTlWifs7Q55wHL32ln40XW9FZ1hZ45q2aeKCHa5PZNjdT4/FheBo/jge
	KBfNtGWxoODgDXwdR5ET7Ma9lHXyQaKtnEWaNk1WfyYwgqKKyrJE1YKPDOig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792003955; x=1792090355; bh=ZiWXQDsJ9AS4L0Yhq9KojYdm49xsgAmRNTJ
	d7dP3qxc=; b=E6N1w2NZVd2Z6zFh9GVPcuaXhAQsG+/moRffJi45ibhfaGUquZ0
	ZMC3YFlHkTY8Z0rB4GInnkEQ7UBu1LYAXGHvbDEmIRaEc6zu98xFDKSAckRuqN58
	k1bjLPp1bUCdYaXnnDXtxGTFsCeXTrKVLqXWaqY6y43bk0fnVPefI4lECOR4MqCh
	pO8IsElckm8zTkCqZ+rcpTdABzvrvYtBB8o5gOgQOYPoNodCVWjpS1ObawnI5PBc
	xIIr/AlVWUULb2ymTrFXAaFrOE1Zx8/b46EARgEOgSMDpUkpS3kjN6O5dFUlGwJt
	eWgORtzY0boxCCgj0NFOnrMd7TUNN6ECewQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792003955; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:Jh8VflqtRXswD/w2vUqEx7EnCbhlScUrqOJMD+U53vhlnWY
	iue5aYT76CsEKfoEnlxnFXrzUvzlfCcw4G4EDjNnSEVa4Lh6d0Q2TLf5lYXlUjEr
	Fj+97iiNy9aMyLOms0UHY8WiHcPQleoGxuAnd7t4cEQ+3OQ13pSgAX42oZ6yaxig
	FwLwDJvioFfVVwx6miSKEfd17Vb18K7xpvx1sqsPcsSqGu+r87/2jDZEAg6pH/Tv
	wAZ4646e9DGbmiVn4Doa6AKgiAKtAixekokojP5zftgzJ3fMaFtux2tj1Edp7f09
	8E5pzeYgzbM73EGCy8SAlpHcCD1SRFWhmz+GU7Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:CvwplKbUjo38G2XJ23pQk7aBpA1KF/FAe+XwzqlOoi8=:/p2YEBcR+uW+XzBV4B9fPdZihUrPFTYOpBvtVjgAz0k=;
X-ME-Sender: <xms:c8_PahVCVqM7EWxMXbPQ3AwfroBTAbXmzlj6LCbFqCBOD7qW-lEZlw>
    <xme:c8_PaofnoUetcUqPAvUInafpkoYB31dU1k2IxlgN_6xb9Eq_bQ4mV0ZcyT5T9GuU7
    PJa2_0iXkJNysBQjKz_eNo_Ili2tfO6czPIBpQXuocQ3POH83jD>
X-ME-Received: <xmr:c8_PaltxeRuBj7fwyA9S8DUtrdrm7bAttdy_w5BYbdbao5uf7YtBuzO_Z9fPtIPnUqh3DI-mS8Ch5UsQVlQQHmIoHn1aSTTUVtLu>
X-ME-Proxy-Cause: dmFkZTGfAfy6wLQBgzH8XRzf6ro3Q269GcpiHbSvw4ucDbTjeDQyvBLq+Rv8CipYlK01wJ
    8KkS5/IOLAyRyC1J0gL5wXbAo22TpUC2H/Wg5R0xy5rxkPiCqekuaPRBcKNBSloxUlpjr8
    DCF2E4FxqquRvyx7C49JhTEWYy/2pnAzrUMFBgA0V4zwMJ+8CvqHzs2P2smuC5b4hrZM/J
    3S+PUcr98UdlQUJKd+WVQ0N3hzBOgOrosYip7nN+HRh1Qkc347delx/uaxbZ14vLdBGTFB
    K0qWjXrvpKpVT9D1dcUFDNdIdAhsyE7xpT8xe/HqaDY322tHZbImlKnWr2JTytn+7c3oDE
    SF2adtqB3Zl16Avx9wtSJ6j+NUehQC17UghK5jx2DnwygzloVVUdcrQXY+vqgNl6ulx7kO
    CDCtjR/CH2N33sac6umGbAFZ/G8WfxsSnTbtFTiQCyu/JlkcIMRQkKE/GeLBcrBBdKqIE4
    BdS7O7l9DGrLbWdPSOoT6EPsCHCwRexmLAp7N/2CAONoke55goHYS6NjDTbm5tTS28+wVO
    vBE/eCKpXPahLspqyxMaZwTgokxikJTuII9bCuvpY0mslYsPM9Pznq6kWi3TslhTvez8HM
    HBugBQRUMx1IgLjTstUQL+H6HIX7UT5SlKQZjxqXn391CLiqHxwjmHN7QVKA
X-ME-Proxy: <xmx:c8_Pav8vEr57uoFTIl1r0A_-lzq9_8JHXamUVnbotscMk3QuxhESwA>
    <xmx:c8_Pao1GB9u2d_x8KlE9UmpToMJJTz9LxT3NK7j9Ydt8M2xVgxaY2g>
    <xmx:c8_PasARdB_gkzKuHmw9JBgZjlcOGiCWLoDoUmMHhCUirCMux6kWFQ>
    <xmx:c8_PasdWl99_AxsWOAWsyJWCO9IetupvvE9Orgb_WU2dQ56gzU70GQ>
    <xmx:c8_PavPmbSZ9Ri-RMW4sAHvFfepgBZ7mIXuEM9k8vxFVZ_EhGjaDX6q9>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Oct 2026 14:52:35 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH v2] doc: checkout: rewrite detached HEAD state explanation
In-Reply-To: <pull.2250.v2.git.1791896486100.gitgitgadget@gmail.com> (Julia
	Evans via GitGitGadget's message of "Tue, 13 Oct 2026 13:01:26 +0000")
References: <pull.2250.git.1791384721919.gitgitgadget@gmail.com>
	<pull.2250.v2.git.1791896486100.gitgitgadget@gmail.com>
Date: Wed, 14 Oct 2026 11:52:34 -0700
Message-ID: <xmqqecdsru6l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Write a new explanation addressing these issues, and put it in a
> standalone guide so that we can easily reference it from advice
> ("see `git help detachedhead`").

Isn't it 'git help detached-head' in this edition?

> Co-authored-by: Marie Claire LeBlanc Flanagan <hello@marieflanagan.com>
> Signed-off-by: Julia Evans <julia@jvns.ca>

Can the other author also sign it off?

> +Git will eventually permanently delete those "garbage" commits during
> +garbage collection. Those commits will be deleted after 90 days by
> +default, see linkgit:git-gc[1] for more.

Does this say 90 days because that is the gc.reflogExpire retention?

If you create a commit, change your mind, rewind the tip of the
branch (e.g., with "git commit --amend"), and then keep working, the
original commit before amending would be unreachable from the tip of
that branch.  Its reflog entry would then expire after
gc.reflogExpireUnreachable, which defaults to 30 days.  If your
commit were created on a detached HEAD, I am not sure offhand how
the thresholds for gc.reflogExpire and gc.reflogExpireUnreachable
come into play for HEAD, as HEAD by default flips back and forth
regularly across branch tips that are not reachable from each other.
When "gc" kicks in, the commit HEAD currently points to is unlikely
to reach the abandoned commit.

It might be safer to either say "after 30 days by default" or
generalize it to "after a few weeks by default" to avoid being
overly prescriptive.

> diff --git a/advice.c b/advice.c
> index 401d047391..43f86c2eaf 100644
> --- a/advice.c
> +++ b/advice.c
> @@ -291,6 +291,7 @@ void detach_advice(const char *new_name)
>  	"\n"
>  	"  git switch -\n"
>  	"\n"
> +	"Run `git help detachedhead` to learn more.\n"

"git help deatched-head" here, too.

>  	fprintf(stderr, fmt, new_name);
> diff --git a/command-list.txt b/command-list.txt
> index 63ae2a67c9..922a1dbd84 100644
> --- a/command-list.txt
> +++ b/command-list.txt
> @@ -218,6 +218,7 @@ gitcore-tutorial                        guide
>  gitcredentials                          guide
>  gitcvs-migration                        guide
>  gitdatamodel                            guide
> +gitdetached-head                         guide
>  gitdiffcore                             guide
>  giteveryday                             guide
>  gitfaq                                  guide

This seems to be manually aligned with SP, so compensate the
addition of "-" between detached and head by removing one SP before
guide on the same line.

Thanks.
