Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C826837D123
	for <git@vger.kernel.org>; Tue, 14 Apr 2026 07:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776151400; cv=none; b=iF/BqH5mXCE4/0KqSAqx1HRaugUMJUC1yACr6pLdYvL6ZKUdPWz7zF7KFmEhb7s/yvR3FmD24fBdQiXBXaZwgu6UwzuCJrOFaJKpAxL0szH/p/cV6ssWqoazEuauwVKNCq5HApkjvhv2sknxMaaN88WgNrggoEwg4/eAxdIopAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776151400; c=relaxed/simple;
	bh=eEDgMBP6UvOpCj1kQoTCprQ0PaAUNIO3r3aL8De5obc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q+3Wz8tDzMmqFJCz230KNr6h/uXbvHwYNv2EVEUV+VbXZyifH2lULzpCHlSzhsJXjwYDj80JTq6u7KDA+02PWxncVG8hxvYbXDQANIc7Nvf9jrWt/8GJi691j15rWO4AFvgWAGDK6vdqKAx22wEfS5//g42fXBYdpfKMkEjT9FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qf43umK8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kC4PQjut; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qf43umK8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kC4PQjut"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E61267A00E6;
	Tue, 14 Apr 2026 03:23:17 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 14 Apr 2026 03:23:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1776151397; x=1776237797; bh=FPr625XL98
	Ga2QaCBuFVwyrhl9cv1PlOHyvsO1P3xvI=; b=qf43umK84zu4nh3ApgGok0kxHS
	KA64/a5xVGDQLKKMkx14UT45BTH1TJoVt/7hOIRHE1EmC+rTMj/MoNpOpc4TqyOx
	3dOyBQ+Ds4+bYnRltfZikVN2FIEy8LUZQt30o9BAVb++O/B/h/1U3dMZ3TgZyakF
	dDO/2841lSieBRfIUr18nU9CRrS36Wti2VeOHjoSxeLGTO2fWV/hQvupR9E1McfC
	S3ZRMVyvRzEZ20iZCINP16xVPLWyXkpqz9mQ5v8ojQVJ9S/Z+JNQxwYy2L40btwL
	wIFyo+Y9A6P1s/nS8KuSuquItAf3147oJINKPH1nV+x87510Hg6YusjvT9Tg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776151397; x=1776237797; bh=FPr625XL98Ga2QaCBuFVwyrhl9cv1PlOHyv
	sO1P3xvI=; b=kC4PQjut6tPW8bFaDGB0dPukAUUPuYULRGw5KC0Ixr+Shdc31xm
	kLLI8hsawiH4frshUuyVp9wep8udX9rsMbNr2N7p52HiUsrE6zCJfla2CSrN6GcG
	4hakRSDzSINvn470Oih1F38ATAXSs5wS4X6rsp+062FboP6WXabKwORCTAxjkmLF
	FQoR5Eeirk7xn68Dxn6zjfdhL2XfbUFrhg3b7mb+c0YdzyJ+syb8rn0nXOc9toVk
	WhZI+faG6+s7iiy8E53MrMr3hQjJdIR5PjQB6PmiDk+aD19ZIXtNrK0WeScaze5c
	R36AVK3+o7Q2lsB1xRm3uX1b35Y8xTTrnyA==
X-ME-Sender: <xms:ZevdaTu1EsnYLviuYamRykgPShowYPDs2Bhme36D83LCuZRW0WDslA>
    <xme:ZevdaafLwYD6OkuehdbmYic9SZYV87gTfobp2AM9x5ubJzs-aXo5uumqxfcwOMXOu
    c3R-1LbKfqXViSL-qZyYBmTHh1ruVC7z2wEpBRLJv1THafNWJVSAg>
X-ME-Received: <xmr:ZevdaUa2uLMmuHXNFREVmB0nv94t4y3cioRXhQDZPBqbkLWzLxGBjmBqX8DAn64k94Lr0JAPwKy5p4_XZUW0crprvo740t-8SE_QrKccY5tXLA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdegtdehfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtredttd
    dtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhe
    fgueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:ZevdadXIyl32JNDQ7ojXk1mKlHAn6eyxFrRywadAFdrLRqnhbUb0ng>
    <xmx:ZevdaWhe6eNnGkBc77s2YMWHHi_pyJAylNNLcqANI0f4xjhUo-frmQ>
    <xmx:ZevdabWNpopF6AuLg3DzyZkcnYIwGhd27KzUvMX9Ry98PiD97BCUlw>
    <xmx:ZevdadOmqyD_Tkn597dQbmpKoHoHeKsLNlPNNlG6S0PJcyUOgpsztA>
    <xmx:ZevdafH8icSmH0rRObuY96FibdKATIZfGaw7swwcqL6g1_zo_o04YKJx>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Apr 2026 03:23:16 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 26e22e6a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 14 Apr 2026 07:23:14 +0000 (UTC)
Date: Tue, 14 Apr 2026 09:23:07 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 02/12] t: prepare `test_must_fail ()` for `set -e`
Message-ID: <ad3rW2aWD6WrGUiG@pks.im>
References: <20260413-b4-pks-tests-with-set-e-v1-0-5b83763a0e84@pks.im>
 <20260413-b4-pks-tests-with-set-e-v1-2-5b83763a0e84@pks.im>
 <xmqqcy02kefc.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqcy02kefc.fsf@gitster.g>

On Mon, Apr 13, 2026 at 09:33:59AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > The helper function `test_must_fail ()` executes a specific Git command
> > that may or may not fail in a specific way. This is done by executing
> > the command in question and then comparing its exit code against a set
> > of conditions.
> >
> > This works, but once we run our test suite with `set -e` we may bail out
> > of `test_must_fail ()` early in case the command actually fails, even
> > though we expect it to fail. Prepare for this change by marking the
> > command part of a condition.
> >
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> >  t/test-lib-functions.sh | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> > index f3af10fb7e..f8bc77619b 100644
> > --- a/t/test-lib-functions.sh
> > +++ b/t/test-lib-functions.sh
> > @@ -1195,8 +1195,12 @@ test_must_fail () {
> >  		echo >&7 "test_must_fail: only 'git' is allowed: $*"
> >  		return 1
> >  	fi
> > -	"$@" 2>&7
> > -	exit_code=$?
> > +	if "$@" 2>&7
> > +	then
> > +		exit_code=0
> > +	else
> > +		exit_code=$?
> > +	fi
> 
> This is obvious and clear.  Alternatively
> 
> 	exit_code=0; "$@" 2>&7 || exit_code=$?
> 
> would be more assuring to readers who (with less fluency in Bourne
> shells) wonder, upon seeing the else clause, how far "$?"  traveled
> and it still holds the status of "$@".

Fair enough, will change.

Patrick
