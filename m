Received: from flow-a4-smtp.messagingengine.com (flow-a4-smtp.messagingengine.com [103.168.172.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297FE4D09EC
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 16:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792083496; cv=none; b=kkXyqNNu5Xsl6fUAvJXAwiFdrBlMI+4ucSvR+72s7ofbbonttFgh7us38UdNs+e79PRtgYcaJYWQ08VsPuipgB3rZmyLrgtBiwXHzeMMbjSUQlcfEdVmYArXN96k+fHNkhwiBu1a2VhRWuVq2mGi1NInwzHiBckwvv8cHQRV6Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792083496; c=relaxed/simple;
	bh=GJvIgN64h0eB9op6ZgvRnnUe+edCHi/Qnerr0HbO2XQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=P20eGgN/1ReFLYZorhK4hsKYXgQa2/pQzVfjpwfWog7Ajw4PcsyADy0WKSYblNMor0zoCPAoWB4FH44zDfup1WJGejmqWBQwAGoCoIM7rEgrNVlmAAg/YUNgUS04OOUNc5nGJ4+VLNOeWYBjPKh1d0enDWPginmdtb2dtbLRIMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=igzJ/TLY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xEsSg6Dp; arc=none smtp.client-ip=103.168.172.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="igzJ/TLY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xEsSg6Dp"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailflow.phl.internal (Postfix) with ESMTP id F00051380144
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 12:58:02 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 15 Oct 2026 12:58:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1792083482;
	 x=1792087082; bh=GJvIgN64h0eB9op6ZgvRnnUe+edCHi/Qnerr0HbO2XQ=; b=
	igzJ/TLYeomoLxLxdWmD7mAkbtO+PYUhLLUc2pAewrPmhPu9bWD5TNsWl2CBO0pY
	NdNd7ZKG8xeMq5VljASFdzN/8PbuDy4oziC0Czg+A+18cCtfXJZTyQ9ixbbLR9Sz
	+klnl0MKcY0OqR2AKBZYaZ11B0WZ8FWnoffmZP8USOgk2W3t4xhs+7Qh6TWOemYZ
	BN0tlnKipmb5BI8OwFl6BAFqErCO5qBnTl7Z9XOSYQhOv94BgC+Vrlf862uGNaDi
	TJUPszihImwXzAf/Z9APzCL/o29UOQCRpzhD6Nin0NRL4v79GwZnBMq+735af+/R
	7fL4cnJJRtppPW2Tyox+kw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792083482; x=
	1792087082; bh=GJvIgN64h0eB9op6ZgvRnnUe+edCHi/Qnerr0HbO2XQ=; b=x
	EsSg6DpbuR62v8qjyb+M4YbxaAKQ+0g0k1Bhg64XSOx90U0m2yPDs9lSQJIXCbn8
	3u+QEVcLFwPr6QKyGzhgHASl2/lSb4COmZH2ctXakO3R6V6Om7LNzkXF436Ve4CK
	bCn1DEOpGrQsAkn0ixj25SZsMrV8HMDJucM3EWnqH5wG8ybe8r4u5JnsY148h25m
	RUOF0Mk8JhSJcBRq4vrqNcfb1+xoFZp38wf2Df2CiWI2nCf/1vYL0TMAUiG59lm/
	Hn5/Co6npV08hqQ+LPmK9DRhUogF6r6an0abbqUvE3LN5aK4CA09HzMaO3HvxTAh
	M+MwxB9w3oxHzoeka8A1A==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=fastmail.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792083482; d=fastmail.com;
	mf=PG1hcmtjaHVjYXJyb2xsQGZhc3RtYWlsLmNvbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:Pv0iGzDmVrtJWhvWz3wpqKSA0jlAklApPf4F+TZsMBYxN5i
	8pM6rjiYHuAle/icZiTejTx0v0eQG3eZ8yv7IeLZhnOBBazO0D0KyVb4Xu0oXkUx
	tonNsw8SQxjhn28rmYNCoGY/XsSQqHUvooGvtkeZOlHt0/RdwcejslmCsuqihaXn
	/0qjsrGi22fU0rDrzLwwopxU+CbTxcZfI60QhHb9JK/tdM/Nn7oJ8jR/y2jqc9HD
	IuWizflpvqR6lpFpBsySb0o3+q5XPvRv30YwTq432iiYiycU11euL46Q4A0oQkES
	e9VqiisVJnPooEyjm2xz/rVI/vQjobjLU9ij1og==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:ak7BO7KLCEuUVo0/hbSNetxzokpejRfNspMl36cHjBI=:GJvIgN64h0eB9op6ZgvRnnUe+edCHi/Qnerr0HbO2XQ=;
X-ME-Sender: <xms:GgbRatBEInSDlkjapEn0iFo_aYCqaOteIZfDjOAC4LQRsWECoYvLjQ>
    <xme:GgbRaiYTVyfSaa_fak2Q0NyZj65bf1YPfIRY9wWyxH86JGChFDZ0qTAld0J1brVvN
    Mk6Vju1qnZ6CXjgUni0QEzJW7lVyGM3_yDspcy4Jli94tHYXLQwL89s>
X-ME-Received: <xmr:GgbRag7eYTlGtX0fybuz_NjuvnXBDWBko0D_z4Eesv5qJAzOd2V2W_j8q-eOTX6B136YxA0NfKkhh4TopjYzIEWiSA>
X-ME-Proxy-Cause: dmFkZTEHjnsaSgsdHI+bVzyWlGG+dwiNjwhq5Mw24uzd5BkVNz2oRHoMGIToO2DPY7Tw7/
    zYlfqc9wcgcX+0nxCl/r3QHRB1YKRvHxmg+7rfy51BQWMgZuDA5zaoW1WUYYns41nqPzh/
    4Ivr4BF3wxRt7g4HxiHEQ1vEtJ84Rv8tYkmNQ3z/xA4eIfSNwDQEGGEx0WFx4pmK1j/vzn
    3oEoCY17vl4FMp0WtyIlrcsCVfU3qmn1MfT0lJwjt0cPtO+qfCuc9C9r9UmhZp6RPRQgTk
    h3dctstae7YYh3XQUAInVcZUDKz9TOt7eQxcd+mCOpxOQWHI4+/tvvMnvnewZ2KBCpIIs6
    4IAd9ZIHd9zf6GE+iti81RKX6EJd76z3df7QbQpOpJE7gYskKQA+nWUzGlyg22y2/OSoO5
    lQhg4BqawZv3dx1VDJ59yYZNxZW1GAQ4jcVY0mUgvwOqThI2e07cULqgATZtWm7iL2k3cD
    c0+p0swiYLMhtJwujfVikpY2EM7P7OeVSOjx0zamaUVRfk8STgB+xonaeUyWAcP9ta7G6o
    nhTg11HnG0FP2vmD7vznK6dE1fHJmjmUK8gojVfEI3NXn06QR//xPkE/LIT2rxrNsvYX1d
    SWhVxNov3M4iDG+aQAEeHmtRkEjVavBa/IS5qM7djfYE9EBsyoR7vllkChMw
X-ME-Proxy: <xmx:GgbRajZKtbpJrAomT7cyybitdnd-ZubKW3xkiFElEzBgFIDEc3Blsg>
    <xmx:GgbRavjZutKGEeXCGn8E8dM6ZX1rujg1a_e6afh8hJWkz5B9A4LsBQ>
    <xmx:GgbRak_4_52wdijEuqlh-YdHs-h0trtSsfdSst9ZmqzuCVITy98vLA>
    <xmx:GgbRaqr7IACRBrbGPzjaghmvLJEX7oQx_mNUvZFComzVvpL3p7jsKg>
    <xmx:GgbRahMds3OcBdwEo9u4fpHE1SemaEXyWJ--4JwdVo3qFvouS5YaF4Ps>
Feedback-ID: id2564aa6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Oct 2026 12:58:02 -0400 (EDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 15 Oct 2026 12:58:01 -0400
Message-Id: <DM5KKQ5ARTE6.12QH6KBE69HUY@fastmail.com>
From: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>, "Mark C.
 Chu-Carroll" <markchucarroll@fastmail.com>, <git@vger.kernel.org>
Cc: "Justin Tobler" <jltobler@gmail.com>, "Patrick Steinhardt" <ps@pks.im>
Subject: Re: [PATCH v6 1/1] repo: add filtering options to "repo structure"
X-Mailer: aerc 0.21.0
References: <20261013172849.1109478-2-markchucarroll@fastmail.com>
 <20261015144559.3652143-3-markchucarroll@fastmail.com>
 <20261015144559.3652143-5-markchucarroll@fastmail.com>
 <85a904ec-a478-4d47-b4ab-37817c5f67c7@app.fastmail.com>
In-Reply-To: <85a904ec-a478-4d47-b4ab-37817c5f67c7@app.fastmail.com>

On Thu Oct 15, 2026 at 11:12 AM EDT, Kristoffer Haugsbakk wrote:
> On Thu, Oct 15, 2026, at 16:46, Mark C. Chu-Carroll wrote:
>>[snip]
>> revisions are specified on the command line. In order to accept standard
>> the standard revs parameters, it uses `setup_revisions`, which does a
>
> s/standard the standard/the standard/ ?

Argh.=20



--=20
Mark Craig Chu-Carroll (@MarkChuCarroll at gitlab)
*** Software Tools/Math Geek - Software Engineer at Gitlab
*** Work Email: mcarroll@gitlab.com / markchucarroll@fastmail.com
*** Personal Blog: http://goodmath.org/blog / Personal email: markcc@gmail.=
com

