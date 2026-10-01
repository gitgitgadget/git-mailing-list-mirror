Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25584493628
	for <git@vger.kernel.org>; Thu,  1 Oct 2026 12:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790856644; cv=none; b=PaTO2Zsrgy0byDm/x1tHi2A974y4EKhhgL67ieeg+Gat+8KG75Ve2uzzg1vvq1hC/y/kLRb7L8zcZOzxQtkZmrR8jW5UYPH2f4HxkPdPMcMrD5OWr7eTdkCjA7MYDC0HQIhosWlAsDjErwaOFi3oi+Ip4dvZE51u4Kn5ld6cCgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790856644; c=relaxed/simple;
	bh=/kZbsbJ3I+gIsMwkgmgEfUZJrC3Dc8+ciCxcxp2zcec=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=jkccL2j0g05KJgOp/upzfy8wRFc4/CnL7p/1Sv6S5/oNhNUPUtjb61zIGyXJD6swHhWb6CtlA49svPWdIwzfAB5agcp9D4l1gewEPIGnyyAxg1Y4E/svg/ycDf2pKtRF622Q6HJTAYx7HXbmygv0BX++gjMmoGPhyplsiXdsGC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca; spf=pass smtp.mailfrom=jvns.ca; dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b=OQZRfBjU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XVdSeV/y; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b="OQZRfBjU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XVdSeV/y"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7DB8B7A0132
	for <git@vger.kernel.org>; Thu,  1 Oct 2026 08:10:32 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-05.internal (MEProxy); Thu, 01 Oct 2026 08:10:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1790856631;
	 x=1790943031; bh=FCz8ERtTpVx+2+0kxx4pVFO/l2exnOPNSOF+swFui1g=; b=
	OQZRfBjUt/j8m9ZfsUyvYzKDxHvjBVnYOv+ZurK0pvTHZ8KS4yR85PJLyH43ftsz
	o7MfgEhrLSktKm7Vsv/eUVIA13eyflWqTDqFiKv3CmnssUU7JnDdKiVp//9YUAt8
	BNUewe9tHiscyrFUWTEynpYVLVA6raAew8nrQSofb3sRrqEd/BxHk7lwY4j1ws1D
	elBoHAlgcpIydoayKErSrhrbWpoNI6noR3PlXEfwrxFPh/pPSuyYCAWT6kZ9L7qO
	KGWh6IDRLHw8zXelB5n1aLziu/ZJN73PCuSDZ1ac4b5zk/Ag8n+ecfXTK4YlCfSY
	z+ElJkOR9HTFPlg1ULEvuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790856631; x=
	1790943031; bh=FCz8ERtTpVx+2+0kxx4pVFO/l2exnOPNSOF+swFui1g=; b=X
	VdSeV/ymyKO8YXxJC/0Y4ZT65UQFLPyWBlkR6EOJ+Lx1CYZmlpCZZMUEx5QQSojS
	p4e7tSdSQoJBM8MsyaMLpsRKYRTUo3YyTH6He0FidvsLZhVa4Eh59u3aUF4AheI5
	7a3ifpwq/jyYq/WIMRoyd/oBlNiQPg5mlCX5wI6kWr/SaKbcf+y9jCMNozKOoTCy
	9duSRXOneTPY7AF8a3D+hAJWALdd0oVTIWtRhpBrvYsj7+ULJTJw2uiZFJj/JVU5
	3Wj7P9c0e3Xn9QKjeEAkCWwIICo1GDpazgfkqkmyhLmjVx2K1OPsp9aKdDLNobIb
	oMN7ODfuhjIDyftd5eacQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=jvns.ca a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1790856631; d=jvns.ca;
	mf=PGp1bGlhQGp2bnMuY2E+; rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:SUa9iQc3V29yAHIXc0XyS8UQdDr3OMF5+pSKkDVe5BqitRk
	xurCJPbIM6HkY7LsjwSjXoqcHWJ523wZE1I4wBRebSm1UBL6ShsMWnMCymMlRBdx
	mKvim2+7VVY3918Rc7xtCp3iwwTlTBNlv7p0gHnjFaBSxQIkQ1QoMKgPz8iddKMK
	unKqAfdnYX8h5o/kMa5oopn7o/E08VWiKSKyK7KPhNMnD0FliytLWdpc2cNN/wCp
	yBUJwP1u1VezetaEVM1tvxVSkASrQKo3ufyY8oVOCMZE3TuFw1yl8vSpnodJhLtU
	xinccyryNqdv8v/1+Cs4ym2Pbtvz5tn31CBUdmg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:ZcDFXmWwSLuemZD4xB50Y3cVUi2NKhUQG1MkU1LQw2o=:/kZbsbJ3I+gIsMwkgmgEfUZJrC3Dc8+ciCxcxp2zcec=;
X-ME-Sender: <xms:t02-aqUHrDUD4wFzvrDYcHpgJK1F_NO_nOEv8SYFEWGlfWJJ3NCrvA>
    <xme:t02-ahZTyGZ6ySGS-nhiGIzEToPhR4S31wtGfrmF6BVWQ6rSJaHpqaCAPKqbVodaH
    YA2b4HY8IRM34EhhpXYc2oHecgNfulNnV20_OcV5UQqJeiEaEMc-qY>
X-ME-Proxy-Cause: dmFkZTEC3gEB3tifH8MdrGGZfb5hzt1yHWTYrwtoCnfDsrq5GpxC8Hc8cEmud8yvpn+ec+
    Hy3cLJ9ALtWOyio7Pw8R1CYz8tLGbvD1J2WSpHBK33uDeLYbvdAQTT6PWzzHWVVORueFT2
    YHcIzZcHUDkCpFXUsy7r4NZNzP1VX6vjGONFDFF909j5xK5YX1jLcESbunTkSFZq9bbOsg
    UIR8B3j5Uz+hwyAltaWwO80mrHk+/dm877lGfa9n4rYs+b3T8ZoBcyoYemFPs9r2FBgVZV
    IvrgxVCp9ebAv7LfhpJ8WxZMbjaV39aEAfLlVJC+vEVL/aVHpNKU8RPHGz0gr4YgBenUdz
    7UYUdF3zxOHB4ysLK9OGXVS4bW0v7qX/8HTzrxNM9CgXTGqixDwPmy6HMtsNqeKUUmUwM9
    qKnqlPU2e1IyxVpWeB/QvPIp1QMYLTlEUEB5oGRxfz+qCyeSxwCfXmyFzwRxiIWLLHtWpB
    iOa5q6ZAyVU7Y9iFSfY7mY596WK1Xfttgylds7gXrbP57rCUHQGAcNZGbXFWLPDrsjCLFf
    0i2e0iaK5AOpYLyIY/2hlfu0ct9C0Y/pf8yudKd5o7X98FmPvpT6iEgF1kas5XpDxL2W4e
    PXKq+XGuas6S/WAqmCs7IwkQEc8M6DeNs/8P0qFwdLZZNaMHPksF8y2ec51Q
X-ME-Proxy: <xmx:t02-an8rsiYZRykyf96cg7pTLErmfikQATq43tB0tK8vzbhbcm7Z2A>
    <xmx:t02-ahitJKFX5CRBqexqZjnEvbuuvbXI0AdWfGOSpEJMwvaR98_86A>
    <xmx:t02-avd4gp9GBdrVjJJ1qfVDSpM3kmK5ohNr8yJC-7BEMhgJxxxt_Q>
    <xmx:t02-agq5hSdnUvdUYdHfnpWaJzH4zbzWNqrXHv--0Ul57xcbT-SZxQ>
    <xmx:t02-aoy5tivdDHSwEnVBHq2AXu_291Wa2CkfybPODW_2894VMWuVOPZA>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id A32A7780070; Thu,  1 Oct 2026 08:10:31 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A4MQIL0NZ3EZ
Date: Thu, 01 Oct 2026 08:10:11 -0400
From: "Julia Evans" <julia@jvns.ca>
To: "Patrick Steinhardt" <ps@pks.im>, "Junio C Hamano" <gitster@pobox.com>
Cc: "Julia Evans" <gitgitgadget@gmail.com>, git@vger.kernel.org
Message-Id: <86a7df9d-362a-4530-82db-44ef7500fd10@app.fastmail.com>
In-Reply-To: <ar3sGzEknG2_Un_E@pks.im>
References: <pull.2237.git.1790261062.gitgitgadget@gmail.com>
 <ad4853dc36cdb883c9a8dc6bda747a5ea318e7a8.1790261062.git.gitgitgadget@gmail.com>
 <ar0MVRV5X8zgZfLy@pks.im>
 <5ba2088c-4919-465f-8892-4ed0685f81ea@app.fastmail.com>
 <xmqqqzia8ohv.fsf@gitster.g> <ar3sGzEknG2_Un_E@pks.im>
Subject: Re: [PATCH 1/7] [doc] Add new gitmergeconflicts man page
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


> +FRUITS = [
> +    "apple",
> +<<<<<<< HEAD: abcdefg (fruits: add apple, 2026-10-01)
> +    "cherry",
> +=======
> +    "banana",
> +>>>>>>> add-fruit: 12345678 (fruits: add banana, 2024-02-03)
>
> That format would have a bunch of advantages:
>
>   - We don't have to teach users about special refs like MERGE_HEAD to
>     let them figure out how to access each of the commits.
>
>   - It gives a bit more context about what each specific side does, at
>     least if you have good commit messages.
>
>   - It also gives a sense of timing because we include dates, and that
>     may help in some situations to figure out what's what.

This is so cool, I love the idea of including the dates and the commit
messages!!! I think this would be very helpful for the reasons you say. 

Though re "We don't have to teach users about special refs
like MERGE_HEAD": I think that users today could run`git show HEAD`
or `git show add-fruit` to see the commits on each side? I've never
used MERGE_HEAD though so maybe I'm misunderstanding what
it does. I think adding the commit ID makes it clearer too.

I just ran downstairs to show my partner this example at 8am
because I was so excited about it :) (he liked it too)
