Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57843450407
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 12:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791548372; cv=none; b=eiuyu0uE+vMDHb8rO+gBrvDXzgWguf6dCPOvrtG1MMJ6/ahecG1c/3xFYDJY4AKV9jdH195Pi4P4gxeEZoewFneyf5eWgV8NaR0mBdAt4J/yHj/CLkU7r3+HDVWrK/JDyWE8f77HQoBZkwKB9X1TT4LQmErF217awEP9qXSqlmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791548372; c=relaxed/simple;
	bh=bVYij6GcfEDT071WA/d0eDGLns7/T9tkFW0xN+KXkSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JtWPLc3Rjxg8MJ9s8fwbfbqXM60RxLQPA8pjrWocwiahIz8KL+XeuYy91XIGaDooziCpYIa2jIFQL3jyiBqRmVrm3X/KcDXd3rOkNLYMRbVS8Xhh1tDjFOdy6hAxU2LCM7koN/LbfAK3gpZatQ/c6xp0vL4FkWHyhukoPPMDPkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TjdffE+P; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kMq8FWdg; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TjdffE+P";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kMq8FWdg"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 5E17B1D0005D
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 08:19:26 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 09 Oct 2026 08:19:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1791548366; x=1791634766; bh=nqsCFJ7Act
	P5kbS5rVSN4VMMNLQBC8cmtCTnoLgcYWc=; b=TjdffE+PMxuVW+lahBIWIhIy7B
	yH0qDJRwlTzhWuV/N/roaKJ+ZyYAAPoMsE+4zmNrCZJVbyS0L3WbpVwoUsuw0Lbb
	xRkxL3PmXD4jRZOAGEVuGZK43La3GC8TluZekYW4CliAmzh14fXipDCluPvwKbSP
	dwKg7RwoFRxu3PbwRJ6bLvN9QJIaj3XuMMBPeQ23XdReDm7jx6jOffT1AhHeBb2q
	y3RfwtWk+URwWGze70e3/qSAy13xe4jYAPzsOhkuixKPiHLnCidNNb0RPe5w7MI1
	/8SRQ2s2L8+kXb5ylrnhFX867oqh3DI7Fugfz5soxK1DtZTInSTOYigJXdQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791548366; x=1791634766; bh=nqsCFJ7ActP5kbS5rVSN4VMMNLQBC8cmtCT
	noLgcYWc=; b=kMq8FWdgpPO6UGMSAVE2kSxUQwrzJnDEx1/5VIF+AMPKq8x6uyw
	ZAWrtkMGgrEvH2n2dfaCPS3xp+UPfTHZY+zUjJ6Bw2T1oN6cGvy628BlwW8t9aiu
	daHwUhOecN/oLlxfkoyMWyuvylFWz9WZrq1whIELB9BE4BDjT4uuRUw8aJu2lTeq
	vLtzFkolQ6Ffcd8UT1EaGJOaWsleClGtTaNMhXkpoFrOjA69pDZsJvpYLQMepFUB
	OCg9ub26PkJoYCsdwT+vNOvddu0Nf3jipFXgIyVVf5gVNQ349/mMYffMutfOnhcI
	agPjZHWp0tn8qpVl7BTzFSTD22ox89vuPlw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791548366; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:C5rmwv9JT+hNryvHosXGMpDOzoqLoiLEHvVx0OJM8WtilLG
	n+RMzB2t2ov1q6rg6QAw5mYjYvwlFqia4IDg7WOGtM1b+HmGEW1gpHf6ZvWb8KJs
	7lusN8K0xMu4aDkapmTGjLfyZ4hR4Eqz6kewL2ZKPtoXOeLNYXYRctiohumXzsfL
	XufmvLxiG6jS93OqsnyfjCmOhZUmNi3RWxYAS8qQL/ucI51AudeyS8SueEiXio8f
	koMnMqUJYlHaCWMH0HiGNPx1LoQV18yhMR+IUTjGYdQ/UtnczW8LMpo8zls51LP7
	6ZQYKygmrVUmYgSu2d/Ien3PgHy9KhlhnOpzbCw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:ArGVAkXPYP/OrUtPkf9Ho4TJJkJ0rtdhQmVyN7c+l0s=:bVYij6GcfEDT071WA/d0eDGLns7/T9tkFW0xN+KXkSs=;
X-ME-Sender: <xms:zdvIauTP9nG-LZL5DEE2ga_tub_VAelxqzUMu_fwBAfRFHle0TdsvA>
    <xme:zdvIarjf14tvPQRYtus119uHV3xMbDhPxrix6AK1JU-AAGvLyfPXhGoeQSdQlLJlf
    QpeikIl0WFdurQBkfSaDMW9Pzr31Pj_4MdRJqy5hoyckK4fHYcLQQ>
X-ME-Received: <xmr:zdvIau4M67VVcj_03FLji-84ckye_CqyNQl67DXzS_hqma1FWDZMKFwU53_vy7K9KXZMJA>
X-ME-Proxy-Cause: dmFkZTEZPppgja7suTZpa1KyMCc/qHkT87Y7eCFiURBRPquKhrOmtR7/wTpQmgtV5k4h+h
    /kGjfoTyRmP6mP94sH+Za9janI8A61kUJXKqEogolIgO2sIltnE0sqjNRC1jWwCiv9uAtc
    gj+8xI4Rgjww1Dn7Ezzmjnwuu1LgJAKzan19iB+rIKKgpQR2yt5+G50/KdttuI7O2v03nE
    Tm3XPLfm37X3QJSsIlpxgdFb1xsMWh0I/dHB00q/MIt+ERpiudiMY70nLsIdpP0QGCXXMq
    VkE2iaQvPGfQwUmw0wa8sxEYMFnA9Kp3dZbYvm3BGh97VN83gNsuKwYBuJBcsXRRhTiFBO
    kpYuETlmCMJ15zbsGF/Re/xuUfv6LoWjI2BEXKA64l76zhzVKsVQcMnp+0/jj1VdxOHHsz
    P1tN5kJs5hQOwpsSPLWgcrAPHp61iTXb/Jfywhb3R2Jn8922/onh6qHwAnELVb6RNl3hUh
    bumuK/+dS6TtdHirdHvLEwcp4nyyr/NDAEXXkADFCEnAuh02L8zVagm223s7KQQmHVYl9x
    G2BENqsyvTatrn8U8T8z65M0C/HNd3TaizEQ2Fhwyrnxs7AnW8gpEqnM4vxVPc6Nq5/eo7
    QEPdHGZJzbxdoN5Rvci2u0x5GS8rJC9W4/ksnzJey43tWuLelZNAqYEymobw
X-ME-Proxy: <xmx:zdvIaoDWq_wpBjNqK9lFruLFddxZSd68RQtmqbYmjx58zfRch1yrzA>
    <xmx:zdvIalZetCMLU07riLiAep3GFbpo8mSH5UTVZ55nQNhiqkDkKVKiXQ>
    <xmx:zdvIajYvBC9Cch0abzVdsQkIgaiCweUs4nIrG6LuljXFkUC25T23dw>
    <xmx:zdvIas-r5I63NvXIByCBkHL4VflYmUgar8TeyVI7H1bJ7v1f4Jeu6g>
    <xmx:ztvIalHmmkiTNi5xgraNz655Eb79HKw6FahrCSaz3X9pVRrUIxy_O_Mm>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Oct 2026 08:19:24 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7decb01c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 9 Oct 2026 12:19:23 +0000 (UTC)
Date: Fri, 9 Oct 2026 14:19:20 +0200
From: Patrick Steinhardt <ps@pks.im>
To: phillip.wood@dunelm.org.uk
Cc: Christian =?utf-8?B?Tm/DqSBSYW1vcyBMw7NwZXo=?= <chris@nortesoftware.dev>,
	git@vger.kernel.org
Subject: Re: ssh signing: valid-before is checked at the signer's own date,
 and a missing revocationFile fails open
Message-ID: <asjbyBvnFuYuE0CH@pks.im>
References: <CAHGSfbZ_Q8Ujt3om0POapkjWZed1pZVUrB-mV-e+UjmPgCNvWQ@mail.gmail.com>
 <ec4de165-c7d1-43d9-979b-08c1cb67022d@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec4de165-c7d1-43d9-979b-08c1cb67022d@gmail.com>

On Thu, Oct 08, 2026 at 02:42:42PM +0100, Phillip Wood wrote:
> Hi Christian
> 
> Having waded through this here is a human readable summary:

thanks a lot for the summary, I really appreciate it as I already lost
interest after having read the first sentence.

> (1) Our documentation implies that we check the expiry date of the key
> (which is recorded in the allowed signers file) against the date the commit
> was signed, but we actually use the committer date which can easily be
> faked.

Right. I think there isn't even a proper fix for this as we have no way
to establish the actual time the data was signed. I think this is a
simple fact in a distributed system, as without coordination there is
basically nothing that the contributor can give us that would make us
trust the claimed signature time.

You may be able to create upper bounds if there are subsequent signed
commits that you trust and that have the untrusted commit as child. But
that is not going to be always useful.

> (2) If the revocation file does not exist we print a warning rather than
> failing the operation like the gpg backend does.
> 
> For (1) I'd be happy to see a patch that tightens the wording, but we should
> also note that the timestamp in the gpg signature can also be faked.

Yeah, agreed. This mode is only safe if the signing key has never
leaked, but once it has leaked you can basically not guarantee anything
via "valid-before" and "valid-after". And documenting that would be a
good idea to not give a sense of false trustworthiness.

> For (2) I agree failing seems like the safer option.

Maybe this is another usecase where we can use the ":(optional)" prefix
that we introduced recently for some of the other pathname options? So
we'd fail by default, but give the user an escape hatch if they really
want one.

Patrick
