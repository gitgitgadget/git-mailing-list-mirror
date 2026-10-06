Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67FDC231A23
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 17:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791308117; cv=none; b=VSFxlEz60npTS1FUHy+S3hXBxr6Kfks+ttjl/2fwGJuhd3C5qXIZdUIEBZDstQtFVTBXiUZhIidWKpO/v+WWdeIgdZU+H3gxDvpnrIyZXP4b13yzT5tQ+1Yj0TOzLJK9dO8klW2KoO88lopVh2YrlYZevsCwCIbJsIEoysuu1EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791308117; c=relaxed/simple;
	bh=Ph6sbxXs8TEWdHh0BRlQoKHp0NiMGLEHo3S1hfP78uE=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=s1MrokbAO6YXPoHnekVsTrgPMDltropp9ie/GycbMJaM9+0ly4oFRsc3EDfRSFsdDeI7bKhjIx7bVh0p3OCh1+StYjrKRS+o93DlEL3S1f2ZBmUsgW6EUS7d8DOlvpNpgb6txB9ZdAEhfY12aoinWrToPAv2FG35+0L8uCN16lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca; spf=pass smtp.mailfrom=jvns.ca; dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b=qeSw3Mam; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Pd7aQFGN; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b="qeSw3Mam";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Pd7aQFGN"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 3F59FEC0638
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 13:35:14 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-05.internal (MEProxy); Tue, 06 Oct 2026 13:35:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1791308114;
	 x=1791394514; bh=xFInb5hmeGqwRtTX5DYqLJQSLUbDIcnHvWqCXPIqFSA=; b=
	qeSw3Mam4msnx5faXjxYGT9AYArWEYNGwZWjcZxkYeR55rteA57tH4MKdwxHYLrN
	2aJjbNZy2a5+Sp04ZBxMo8LpAuTeeUjv/PJNnfQ6qcyxQHju3iEsdTB48Dmsros/
	uC+8/OK170XYdUqcLy7BVRCwTI8OkOTo+K9UlQe0jBXk6sEwMRI2rh28/1ZtyFqb
	0dGwi7oU9JlQ+KWpCHRMszzf3QhntLBxMuAUr+lDMe6shSmnM993SBEh+EkT/SSq
	Om9TsJ1JO0osBbGe44Gz55UoWW/WsuFZxIF/3MYH9LGvWzHcQYpWF4WRyv+B5hFZ
	fwGMf5jON8mXbJWRuNc7xQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791308114; x=
	1791394514; bh=xFInb5hmeGqwRtTX5DYqLJQSLUbDIcnHvWqCXPIqFSA=; b=P
	d7aQFGNFRyzgZ/O+nRbxebKLOLLydI1LvZgEj/cKbB9o1QfR48OFHNBqKyFoPGKy
	KU2jiV0mYGBLxLjyDkAtzmQNGirhj2gsYcYhP5Vmq+1pBddM4kTpDqaMTnUqFCWe
	yNNfE3NOh7EjV7l19k9X1dzG0CyOMD6FRL9C1eY8sTaHk2CgmiqwGfvkyTWgzKrU
	sO56T1UFk0mVukooNt/nxZE8VfAMJSxJpRPyb1R9lhrLrmxo1R08CVP/yQZgdlQX
	x/AZGIfCDre9CYJYQw8yo1diolWqGn7lAIvJYRXOUhKTKpizIuYlDD+qZHrTI3vm
	s9XQEwfIjY8D4VDk8MGdw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=jvns.ca a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791308114; d=jvns.ca;
	mf=PGp1bGlhQGp2bnMuY2E+; rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:AtiIKswK/O8Am3hX0hWW4bsvmfw9xbBXNc1d4HGD7voFvwu
	ak0Rg6xHGF2Cu6m/YpgkhC0tXZXSe82ba/cIKX3W+WCaPGU2ulyTJn4clpy2O2zh
	S0AHpj6jdUcX1vAT0ZjR1Hq8L3wsEVzqbhWEQU4rrRjWKrgE5ClH/YBTE+DcfCqE
	hrlFgY+vgFHTCkr01d07FXzODCDUzPUYAu53Xh/52Zov6YALSx9Wsjb6ezpAWlLy
	fSQHdRoY5v7YmW4ua0CPcBZiqt6sSOSq/1RTuken0aYsRtR9MdoImv+MVcWByGkM
	87R7VTBLmbY7xU5xpGVp+EA6J/65REQAuuI8oJA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:ObgZ7pTdRzQX5Shb+HvgmkTNKe0btwTPGP06iiP+01A=:Ph6sbxXs8TEWdHh0BRlQoKHp0NiMGLEHo3S1hfP78uE=;
X-ME-Sender: <xms:UTHFap-hrqPvYU7xtjVWKO6SXEKedADIwk56MDGALdBoUq8zBXR1-Q>
    <xme:UTHFaoh-slKnIBGJBvemZRuSndywMU03dJ3gP4Qck5Y5PSbSNEufJxAoJrTbutdOX
    oa67zActxdT5uaK5rLdPLMQXFvODD4KALgFUlgyQAdzU-7A45ph8TJ7>
X-ME-Proxy-Cause: dmFkZTEwncfwaHqVL+oGAgUxUxgwrjAPeBPbXyTJKG6rBOYaNUqgjT/7KVyYW+wMh7MJO+
    UAuEwJB18W7x2IBt06FARXsm9FGaKGY3RFDyaVI/C7RSMsl7z1Ho8aOgfU5JbuXcS+g/+s
    oaQA70ZsnSD8bbKUQY7+XpXBZHKsXLVokwtJOJMocDKpjKIhB0YZswz5yQe4T9izLCOA92
    QKI3rJRLl7neg+kR+9ltbbq6T34ZdUYGHLu8Z/k5fQPxDXVONCbK+ge+LT0Xz0S4USeu6N
    EiPcmylQ04bMgIhUK3bVS+5LX/55a6sr0Dk68VP0TVNThZj5usIa4T54X0eDXddE5B91Bs
    XR+Fy/0ouD8hVUqvwsK89VCFo7mWRmdtwJhbQH2m5/rX4DUz1CutjuG6DSX5ruwurywLi1
    xkOXmFnM5Ox6KGdmrnbMCQdbIqR5wpkvZvGJl4P2Na93/RWMsd1Y7he+8v29yYSwojaaLI
    fHe/JAOQpjxZXcCr0RuAuDwnMqrd6uTwndPbfsLd3XtWaH4PUF2Cg2Wy0dj/tD7pxiU56X
    waUxikm/+fl89Utl/MLdU4I0u+9h08TpQjXSvE2usN8FTMXoJ0YgF0IewAJLzYqGph1RdK
    i9IEFvv9H+lB3ERRTX6zWBp8U/DihBPiyxCel7Xup9Md7YLqurGZdAHIy11w
X-ME-Proxy: <xmx:UjHFatmunNvnBGgi2Vf3Y3RephVQLg1B-pS0rWUvGmwInUj7dzVO7g>
    <xmx:UjHFamp2-X3EfTAmS2PQE3v9CSqgqVl1opVUatT2auF1nZJ63yWUog>
    <xmx:UjHFauHck4bctkI4oNN1R2r7l-_1dglTfNVzURPeTfOuWDKbUszySw>
    <xmx:UjHFaqx_aTFC1thSityT1ehtRc38q_GhVxtLWXm995wHKvrtlO_LQg>
    <xmx:UjHFamGEiAyOT5P6BFJmBMnU_XEbk04dDyDoc_gaLdpg2noXWx20M7Z1>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id E3CCB780075; Tue,  6 Oct 2026 13:35:13 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AqO-TNe5d1d7
Date: Tue, 06 Oct 2026 13:34:53 -0400
From: "Julia Evans" <julia@jvns.ca>
To: "Tuomas Ahola" <taahol@utu.fi>, "Julia Evans" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,
 "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Message-Id: <26a10538-525f-4160-8719-b82968c39261@app.fastmail.com>
In-Reply-To: <20261006055002.M9X9O%taahol@utu.fi>
References: <pull.2241.git.1790627122.gitgitgadget@gmail.com>
 <pull.2241.v2.git.1791231610.gitgitgadget@gmail.com>
 <20261006055002.M9X9O%taahol@utu.fi>
Subject: Re: [PATCH v2 0/2] [doc] Remove gittutorial-2
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


> $ git diff je/doc-remove-gittutorial-2@{1} je/doc-remove-gittutorial-2 
> -- ':!po/'
> diff --git a/command-list.txt b/command-list.txt
> index 5c649c882e..63ae2a67c9 100644
> --- a/command-list.txt
> +++ b/command-list.txt
> @@ -244,6 +244,7 @@ gitrepository-layout                    
> userinterfaces
>  gitrevisions                            userinterfaces
>  gitsubmodules                           guide
>  gittutorial                             guide
> +gittutorial-2                           guide
>  gitweb                                  ancillaryinterrogators
>  gitworkflows                            guide
>  scalar                                  mainporcelain
>
>
> That, as can be guessed, causes git(1) to advertize this "obsolete tutorial".
> Perhaps we would like to avoid that.

Agreed that we shouldn't advertise an obsolete tutorial. 
I'll remove it from `command-list.txt` on my branch and submit a v3.
