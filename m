Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5EB03AA4EF
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 06:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790923606; cv=none; b=YEVWkKxCWrM+MZOAez9bw2oh1ZAvYom8HEQEee4qnga/iOO7KwP80j149rjJBzsnI7QZ5THPnk2ESud2uz0Ge9P/n9dARhTsuO4dmL4sENaPMMwDk7dTu9NFOxkC2DLPSW4kQGwqgo+ODgRVvF1+tHCNh0REPYNtJSUVdZxQOi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790923606; c=relaxed/simple;
	bh=MT3dBd2mVRBjPLvhyRIH/zJPfejRm2e9zG7EDcngCgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vp1D+dSWJ5ucfOmvO2Qef+nTUEnbpFCGGNt7cbp7QI95SojDzlVhfqYGjdPUninAxKtS4Fj3GpNzi/xgMobqhbBXCXNkpwY5R4iWNbf80FlQJfG17JEaZa8oDduzPukRwxm0KYhbnoOgP7sNnX219NE/e4FtTl8Ov/Qqk+6MT2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mJ6r1mur; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NFaKBux1; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mJ6r1mur";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NFaKBux1"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id B38AAEC003D
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 02:46:43 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 02 Oct 2026 02:46:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1790923603; x=1791010003; bh=scB5rRaCza
	uWP+DyoKNf6vw3dYoXqKHQN+yy++Vvg3A=; b=mJ6r1mur67dqtNbRcojAybO8sU
	SxxTe/JO6qIjKT8unRXd4BXQluWhn9Tql41weuzGF7ftC7rV0XwAiFqcU6Epu0qR
	rxy3lWQQpgIXMXWccV1jwju+vOX7wLXOtjKNAsZEADPDLLb7abg64lrOtgMhCSxU
	LOPRc1Gusle+MyJXsLgR2I9tWdQSKaM0x9fIydP6RG/4YQ4PP05629uOptsaf/Zw
	DMLxAkVSWXHC8a1DlK4+SfadUElCJU7TzoELsXRMS9cXUUAEysW8uk909n2u+VW6
	tqgTAZ5fOCu47vaF6RfW/LrKKfn9s7mIMg3vXuNl3cx+y7+zxzSsDtPlbkjQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790923603; x=1791010003; bh=scB5rRaCzauWP+DyoKNf6vw3dYoXqKHQN+y
	y++Vvg3A=; b=NFaKBux17VKuedo2Isd8YI4uMNVpimIshxwXUXxDT9XfPLsdfZ2
	/JQvwSLwu3lCoNCtuZCLN3zFnKQ/8fVmb65ez3NRjQyrppRIDUqrBxcQKmagI201
	C/yrNpRxb6BrhBfn1L+ShrIQrf1lgtg2QI/odBzuKCgd72KwSJEvrLWmw4kBLnk7
	Dpd4E8Mx6h7RUaAhklqZ8pWdyxywS3odR+awQKDOJr/knnIfo52OGDUNF+mrStgN
	1Oetg169A3ODXlL5F2kBONMTB2yiCZQbMONEp5lzqko9Roh9Z/QZ44UBdi1H46xX
	wuZfrAf2NGUrJYilzCPJxy0o5WLnTZDX8RQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1790923603; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:bwHTczMzkywmHlqttVLHWUmycJGV6sle+7ETuT+08VMrkGP
	rp/d7qehnmIB8dBXjiT/rjIF4x6lPiWrj7t1IKMtbYYg2qg/65E6T5Kiq16wVWQ8
	HMYfia95fSO0Q0jpxJWNcSJHGjs8JVtyixdc/j92C85QyjkFOTW0xqjpmpUcWJb2
	A4VYs/nQnEVgc/pSvXRNauW2YPoI+tKFFEaxd/uXEZuWCIm5bwKh2bUdBIKWZLwc
	lrlLKyj0oSpW/s5qd4WJPylJ2nev7DUzp3JKyygUhULQeJR0LLaus/C2e6dWcPqj
	QLlaQAlSVi4s1hKE9C22kIxB72lB/8pAeSNEgPg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:158FI+HT9YJY0Oq/PDsNAzvDmz3rNRYvKljxnJjY7U4=:MT3dBd2mVRBjPLvhyRIH/zJPfejRm2e9zG7EDcngCgE=;
X-ME-Sender: <xms:U1O_apZMnQeDZBtTDjRmslc4pOZYMn2sHXiB9jON-Z0ErxDID7E1Qw>
    <xme:U1O_amb_oxdsskUN8CZrVf6mSNkZQxAtMQhOr0mpOy5HphAkIjX67fqQM_MU5grBr
    6b4vGuM-nCKfIc6W28oybtIrjIB5bNYpONDL0xTfzrOjJiuUsPUMldt>
X-ME-Received: <xmr:U1O_aplYmoLLNLiQ5sji47BTTF2znoGj1o6KB5iyzlYjuqzt7jeI7g>
X-ME-Proxy-Cause: dmFkZTERSteVU7RBmKgtVkQpV0HLzuQ3zqg6ciQu4JWGvby8+yZ4ei1ttIROBoQPC+QaQ7
    Dhn5HpSczX/eeBoADwe4u7a0PPUDet+Tq5Y3fNg91qnYQOlZmiDOe6qQvOetKgMX7nWILL
    9mxJjwjP//oGQ8fm7u44jbxAU+qIdZI6b2jnkXT9Nfw5L+DYlp3jjJt+8nlLG5ktP/5FAk
    HIVddVDdaveYH7oT3yhOnvhNwCi9jCvp+ovAUZ0IH4/r+tX8io5N3LFDDsdFiI4KqC9lKy
    vmnzvv74y81hV12d0Fu6xHKfzP8RcupxiLULsp9+ZesYRAaK5a+hpxie6/6LbA8vl4nFC7
    2LoI36N65dHer1OR30L89L0DuZK656oOshxmn+SERc5PDF8jZ6+58hqDs68ARDd1w71jqs
    ayOsp+htwBOATWMEmStResAhKqTbF5YzuiuLzcxRr0r+Ii+fh7Mk9E72yG0IsW9NI78yx/
    46L53wSDtWBhs/0JMhk8zLiZ9M9v4eflJINj/iD7NMgVr9BgJsW6LPv3rqC2oQC9cYF/ca
    hq41FrmqMmYo+eZl2EtITqd+bVqCsc1jzxDt2097uxbBPMOl/1KYS7QRnLhZOFDJjLQUKi
    2xW4xmBAHVyF7obBtW+n1/DKkzw4i3y2TVpEhBmXuycCxPxctw1Svabm2f7w
X-ME-Proxy: <xmx:U1O_aix4N8otaETCk5B4Ro-HmmLnfLl6afCROW6RsS7npk0DwOKi7g>
    <xmx:U1O_anMw7Mn92D0Yr6bq0T9Xt-uzHttZNm6Io_wxRMw4ykBUu6LxzQ>
    <xmx:U1O_amTesy5EnfAZTx3Fcv1ggw5a0T17VlRVheQlYmmbAzB5i469dw>
    <xmx:U1O_alY7KBRfoPLp5kGkvaRTO86RpFrcHjJJvBBu7SEAU6iG8ikyCQ>
    <xmx:U1O_anMLhDm3OSRc5gjDPUJPa_dP-c85oCsj_F6MIw3al_EMijFs1hop>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 Oct 2026 02:46:42 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id cd4c7405 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 2 Oct 2026 06:46:39 +0000 (UTC)
Date: Fri, 2 Oct 2026 08:46:36 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Alejandro Colomar <alx@kernel.org>
Cc: git@vger.kernel.org
Subject: Re: git-rebase-walk
Message-ID: <ar9TTB5nmPPAdABE@pks.im>
References: <ar5KL4_IKXYbx3Sb@debian>
 <ar5eereSq91xldo-@pks.im>
 <ar5-7ZtM6C23H-8m@debian>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ar5-7ZtM6C23H-8m@debian>

On Thu, Oct 01, 2026 at 05:51:58PM +0200, Alejandro Colomar wrote:
> Hi Patrick,
> 
> > Date: 2026-10-01 15:22:02+0200
> > From: Patrick Steinhardt <ps@pks.im>
> >
> > Hi,
> > 
> > On Thu, Oct 01, 2026 at 01:58:42PM +0200, Alejandro Colomar wrote:
> > > Hi!
> > > 
> > > I use this little command to apply iterative rebases, which are easier
> > > to handle when there are large conflicts.  Are you interested in it?
> > > 
> > > 	$ cat $(which git-rebase-walk)
> > > 	#!/bin/bash
> > > 
> > > 	set -Eeufo pipefail;
> > > 
> > > 	git merge-base HEAD "$1" \
> > > 	| xargs -I{} git log --oneline {}.."$1" \
> > > 	| cut -f1 -d' ' \
> > > 	| tac \
> > > 	| while read -r c; do
> > > 		git rebase "$c";
> > > 	done;
> > > 
> > > The source code is trivial, so I guess I don't need to explain much.
> > > It behaves quite nicely, IME.
> > > 
> > > You may of course want to adapt it a little bit for merging in git(1).
> > > I could help improve it a little bit.
> > 
> > this reminds me a bit of git-imerge [1]. What this tool does is to
> > basically perform a merge between two branches incrementally using a
> > matrix. The tool tries to address exactly your use case, which is to
> > "present the user with one pairwise conflict at a time for resolution".
> 
> Yup, from the description, it seems to do the same thing.  Thanks!
> I've also seen at least one other tool that does the same thing.
> 
> > Maybe that tool is interesting to you.
> 
> Not much, because I prefer a 9-line shell script that's robust as a rock
> vs. a 4k+ LoC python script for the same functionality.  :-)
> 
> > But it's certainly fallen a bit
> > out of date, as it hasn't received any updates for more than 6 years by
> > now. Chances are it stll works alright though.
> 
> My script I use it in shadow-utils and in the Linux man-pages project,
> and is in use today.  I was wondering if there was interest in
> integrating it to git(1). 

I guess the answer is "maybe". The fact that multiple folks have solved
similar issues over the course of many years is an indicator that the
funcitonality may be more generally useful. But it probably shouldn't be
a separate script, so if we wanted to integrate it I'd think the best
way forward would be to integrate it into git-rebase(1) directly.

That's of course more involved though, so I understand in case you're
not interested in doing that.

> If not, I will likely provide it in the man-pages repository as a help
> tool (which might end up packed by distros as part of manpages-utils).
> Is that okay to you?  (I ask mainly because it's using the git-
> namespace for commands, so you should at lease be aware of it.)

I mean overall this is our primary way of extension, by picking up
utilities that have the "git-" prefix. So arguably you don't have to ask
us for permission to do that.

Whether it makes sense to distribute such a tool as part of
manpages-utils is a different question, and one where I myself am of a
split mind. But that feels more like a question for distributors rather
than for us in the Git project.

Thanks!

Patrick
