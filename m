Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85BD5A79B
	for <git@vger.kernel.org>; Thu, 16 Jul 2026 15:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784214383; cv=none; b=cjd2pU2xqvga+xqwjZWcPwgu4vYhWWCl6UErDedtU0oKgtgcboMYD+nGi7czOq0thJSBXAnKA/Zg3+HuP+Mr8on+EqE30NtV+YKigApj/st98YORWrDgh6D55r9547tvbHkZl1UoQW4MUzn49zZ2G1//KjG0y0WePo4x7ARVHoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784214383; c=relaxed/simple;
	bh=kKwkrHP7mMcVMm9nquDuXxHDK6o+YTLgSFk9D1/OPQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q4bAnebTyuSLG6e+IUXFZ+/e3aMmHZiR6zFaEB+UwPzgfYSkdK9HB+YBCwFOnl84q8qywTtuPhNRJGClBJvwYCC2jX59zCUKmMvrzCOSAd6T4h+KPy5LPbRxp/bztOxuubpaa4sXzyGKW8MeqJ1tKZZTMLBrph6PFQGtwJytlj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=UWWFfcBS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nJtB9L/H; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UWWFfcBS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nJtB9L/H"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id BB0ECEC012D;
	Thu, 16 Jul 2026 11:06:20 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 16 Jul 2026 11:06:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1784214380; x=1784300780; bh=OrjmJEYJ6r
	cTW4Tv2zC5PhH2HzcTohkW2WoS81nyO8Y=; b=UWWFfcBSV9r6a1ymqPDOuSnLWW
	JPZFCENXePnKPFRvwsD940NKVg6i1yAW/GLdxWVaUG1Ki62pgOOhCggk4hmjs9M1
	DgvcQ4GmDZDyfVydgffEzSrTlSzL+i5H5mHDvSTJvr1AGGKuRBCnHc+zYb9ygljb
	G0YmUj0NzAKyalXv9Rddrurv6+lnbJf/Tu9zZ24mJ7IP8xdiRRnROxftxiAoXFNx
	QkEz6HBH3ePvl1QmFlTmAV6DpnzczkaJyjA32g5M9sLPemGHVwQJmk3nH/kcDYOC
	ItDKdvY4eg7J4Ju2qShm7viGL7o3NU4vNKdDJm9YyoxrqnUwST/0xuT2fYcw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784214380; x=1784300780; bh=OrjmJEYJ6rcTW4Tv2zC5PhH2HzcTohkW2Wo
	S81nyO8Y=; b=nJtB9L/H0n+Z7hhEZSYgrZx3oBr9V0Gp60wnoZqe07tjuWaM671
	gAuyowQSsJmyIaAuXcCVTAWPyddT27hZo6L32J0WGROf/Ler+KiuZL75ceKq2NXP
	dLng6igjFYrh7blivuobRADf/ro+yFiN+UmihoWhwr7mJnx+4FXad9uvWKpTwH7Q
	GVBz+lWJVubt8khhAyUJW/ddobybRmeTjqvCNwA37iF5hRvyaDwLyyH6wIthO/cJ
	q+dw7Xj/4/r7Tbjw+esIyDZTn2s7PCnDIJzSI+n5h/nwqxBCTTbYy2Z7y5y/xiUb
	zaZwKokAzMK2YosPv/kYDgyfr8gAOSgyvSQ==
X-ME-Sender: <xms:bPNYakEuoqKrB1d1SvNkkFWacLlD8rML3I65hvvg7hlPXv5b6xj4zA>
    <xme:bPNYarRgYh7AQRINSUsRk5FxvMevIkDNfS5A5hIBZgSA4U2YSsratiHMhEjtQk8rC
    fNT2Zr743YNaSpOEOTmyWkGyfb4od2VBA8OVQk2rRrZrD6s10AmFQ>
X-ME-Received: <xmr:bPNYaltie3qKqd0ND5CemTzdTRuNY-gtTxgQptK2wPpVk_WDtBK3X3jaNBJnesyv9LThoflViqLYeO3sXvjYV2ZvZ75xqYNEsY6qC1dM>
X-ME-Proxy-Cause: dmFkZTGcgH1QDQSaUAKq1ONBf6e/v/+Qx6i2XGH05BYb+qf7d2Bkpkgme8OcSvTkyW8nlQ
    kn0dFrCBMrtjUVoRbVkRz3q3DKtve65jHcdwz/m0jPAu8R2zUUpgvnjc8szwX5ZHXqjeuP
    7Ti+aIMSV78gkdCp4XJH+F7TiRqE2GThTEHhQkUyRRpZZfCmCV+7qYL2TntCfg/WXSIltF
    LtBjdfneoEDdhUf7I1HiAv/HiD6vUj7emn6SX0r00WxWE86r4ux0PB+G6mONWQ2JB6O4ci
    fAdtGXwdqtbuXsljZ63Ux0u9PsXL0BWrWXFlXzl+LtAd0xjNxAdsaBmspXD1l35D9ulTE/
    uZXE7u3OOwesMxn2xcGCANNHVWcheupQHwGjIzLPExSsgeQbRlRRJBwafkwfi1q41MJTru
    eQBfOd8pUIfXn+RdpNedtWAR9d5cC14REaSfQkDs8oklM8qhso1WLkZ5Fr33QFnsZi9ViG
    KKRUt247fhTEz5FjyJy3kJIP2lWi9XWt1lSWliDcSsMjcV4ke/SqcOYdQ9t+r0YgYEnr8R
    u5elDYlmJTfRu78CkMYiW/DdikkQCypg8TLE9CwLbtLsMSDJzirWYH5Z8IytG8N/97BDkW
    vHFN7jf9zuVyWHJyOCbtEA7IK5j9ovf4oxCkiC3b331h5y+Vdk3vw9u0V6Hw
X-ME-Proxy: <xmx:bPNYaiyOYjQ7EyMwzkWZrRJU1lLn5BdZPVjGwwml0n1fpLfwNYYncA>
    <xmx:bPNYan7D1u1CPoBmcgeeKPi2ykWWDYozIuMJ42QONO62sQvD_gckYQ>
    <xmx:bPNYakVoDmbrx4jgSO0N8J76zc71-ldxCI6YpcpjHG0NVH9VRLa6sw>
    <xmx:bPNYar1r6o9fANGm7uGjXFAAuGkroaEjuhKlwSI8ARW0KwVkiKiW9A>
    <xmx:bPNYaoIP1kQLP4168igqSnL0OIAB97yFtSxF87TJUd_NDPyQZGYhIe-M>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jul 2026 11:06:19 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 83f5e606 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 16 Jul 2026 15:06:16 +0000 (UTC)
Date: Thu, 16 Jul 2026 17:06:13 +0200
From: Patrick Steinhardt <ps@pks.im>
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org
Subject: Re: [PATCH] copy: drop dependency on `the_repository`
Message-ID: <aljzZar4sG6IE4-h@pks.im>
References: <20260716-pks-copy-wo-the-repository-v1-1-8f1e078bb82f@pks.im>
 <27d4d72f-1ab5-4dc3-8cf6-1a9b6883a631@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27d4d72f-1ab5-4dc3-8cf6-1a9b6883a631@gmail.com>

On Thu, Jul 16, 2026 at 02:41:44PM +0100, Phillip Wood wrote:
> > diff --git a/sequencer.c b/sequencer.c
> > index 1355a99a09..c9ede9c02d 100644
> > --- a/sequencer.c
> > +++ b/sequencer.c
> > @@ -2419,7 +2419,7 @@ static int do_pick_commit(struct repository *r,
> >   		} else {
> >   			const char *dest = git_path_squash_msg(r);
> >   			unlink(dest);
> > -			if (copy_file(dest, rebase_path_squash_msg(), 0666)) {
> > +			if (copy_file(the_repository, dest, rebase_path_squash_msg(), 0666)) {
> 
> The path for "dest" is obtained using a local repository instance "r", but
> we're using "the_repository" to set the permissions on that path. While that
> matches the current behavior it is clearly better to use the same repository
> instance to obtain both the path and and permissions for that path. In the
> hunk below we even have "the_repository" and "r" on the same line which
> seems confusing. This patch uses a local repository instance in
> refs/files-backend.c and setup.c, lets do the same here.

Makes sense. In that case though I'll also adapt the two uses of
`the_repository` below. Thanks!

Patrick

> > @@ -3864,11 +3864,11 @@ static int error_failed_squash(struct repository *r,
> >   			       int subject_len,
> >   			       const char *subject)
> >   {
> > -	if (copy_file(rebase_path_message(), rebase_path_squash_msg(), 0666))
> > +	if (copy_file(the_repository, rebase_path_message(), rebase_path_squash_msg(), 0666))
> >   		return error(_("could not copy '%s' to '%s'"),
> >   			rebase_path_squash_msg(), rebase_path_message());
> >   	unlink(git_path_merge_msg(r));
> > -	if (copy_file(git_path_merge_msg(r), rebase_path_message(), 0666))
> > +	if (copy_file(the_repository, git_path_merge_msg(r), rebase_path_message(), 0666))
> >   		return error(_("could not copy '%s' to '%s'"),
> >   			     rebase_path_message(),
> >   			     git_path_merge_msg(r));
