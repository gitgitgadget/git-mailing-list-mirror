Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6071E2834
	for <git@vger.kernel.org>; Mon,  5 Oct 2026 20:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791232681; cv=none; b=LK5iDIjF0P3HKav/OQ5cAXA094Bk3VGDkqdRKQeWirY2/XgKtQbh/YhwWYC5mDyEYKm2Jz01sCJSeItbQR4bztE+DhrH/dMoHJxDqbULR1MzVgfsajN5vXEmkEqmuGUqYAyWpXtmwDZaS1VkYEy/IbhhLwP/R8WLaSGZ4ErXnPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791232681; c=relaxed/simple;
	bh=vbxv02YdRzopReAFeW5ieb4nLJacE3CPE4NQvs8vRgg=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=jtDNr1XC6gKijjohP3VsUEq9dJqQB75MQDpvx9rSkhqYEJOjOtCuuVuhutRXgm3NNijyRaKxwmMT5MCqfIYug0OdftosbtFbQ4+PO5FaVuIRbgL7LqtcdDXtAZ+stoV0f52t9zGD+MAJL8Vjobhqb5IuIS30DXb9cN1Z4X63aow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=cVMS8FQf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=waNP87+G; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="cVMS8FQf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="waNP87+G"
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3F4411400181
	for <git@vger.kernel.org>; Mon,  5 Oct 2026 16:37:58 -0400 (EDT)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Mon, 05 Oct 2026 16:37:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1791232676;
	 x=1791319076; bh=RGz3hRi478g5GKph0uTkCBeqpcBDs6+TDDPzuWBZnCo=; b=
	cVMS8FQfjMUsqOlCmlgfBJTg8+kJ2DSiK+ZXUsrHXTDir+jGvyDBPHKZIqk4a2D2
	GbsI8H7A1zhoWmXTdfZvwt5GJjb/TULwMAqew3wrPRlyNigDAWtO/BXlFWQxnWPX
	T8dcV+n79eAXv6TGig3abjCKKFw5GCgwpceVXPRJSoBtlxRzvf3QTYs+p6FTgWIS
	26z41BIXZiSn/Lwgs5pP9o7a77fo5JGL6y5zB0ClDAJkoB0ZwXSp8ATTTrUR+h9d
	rjnFNmH1rNlJGnkzpvdIoMO+bfDG3aaQvdBwmn/JMRpdkDelGo/rvdj58uMS5LTd
	juSRxXr/m2KtwPNG3KQXSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791232676; x=
	1791319076; bh=RGz3hRi478g5GKph0uTkCBeqpcBDs6+TDDPzuWBZnCo=; b=w
	aNP87+Gkslt9+y9UDhFdiF1NJMAwXS+lILC+NLxbcUsER605hWSrAno76tcW7m/h
	S/V1KZ58z4EIh+UnpvO4QEdlCzOgDN/FLE0LOI8rqvQVqII/CEbVCHqf0ekN7PZv
	WPdhUAk4rKqsXN75WIhvVjr4UCbqS8o4udmlkegnbXa+iBp1DwkIL4AF4E2aiRoO
	jcvWOGBOhLwnUJtQKriQrL9JE7WsIIozJGixQN7G0edLCcxlmK/DOF16x8nbhkEF
	meJ7KcSryll1tsJ1jxSsTWayJzWsc088AHob6F2ieAoBl35bt4XGwC/WHAagBsp1
	lDJc+bytRv9Ko4LPQcARA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=fastmail.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791232676; d=fastmail.com;
	mf=PGtyaXN0b2ZmZXJoYXVnc2Jha2tAZmFzdG1haWwuY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:VvthmTmc20DbtiILjeXJ7aqDd5hFAEBKyX8gNE415T44Z3m
	wjPc1uPDvgvs4WeTUbRIKIj9Fia3NYmvkpZYINYLnps742a6o3jYeJ8XMXbFtvgn
	vJjlaXnrxXwr1jEmf8ljgFUxHX9xPFVjHMD5mZE4/hVb7tedi2jRRoT4JIwURuwa
	iLIRNMH+Xq/ALCAZfNkQBHhlFVdpdl/IZkFMS+NIV5voUQy9dDDBUE2kVUop+DuF
	H2v1KqiY+15bQpMfyt4e9mgVXSq2to5P1DOj54edUO1Kg/Ly1+x3m+dp5RrbEXJF
	z9MbfTjqM2nXKW2glCan2Wm5yqV0pf0c/UsaWJQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:jvlYrTd5p3dVFI8DOXc4JkCpglLM2wUlFNdtbztbbrk=:vbxv02YdRzopReAFeW5ieb4nLJacE3CPE4NQvs8vRgg=;
X-ME-Sender: <xms:ogrEakz4wle5DlD-44m42pF9F7KjlqjBGbkuEjMvc2D21kg6dJJpjPE>
    <xme:ogrEajHUtjI92OztVrvlZoDzYTAzHzNESX_GbnaTSJSSuZHmcoNOeav20VvsknXck
    wcFZM6WsN2Ia0xs9cnlXvCN77NjreskEHZ15PTbI7jqf3PzdFTUl6Q>
X-ME-Proxy-Cause: dmFkZTEcCf6TfQc4PyMB6bZlOfxhutn7/Fx6RQzeKt/ne6nchNJj0Yv6wnCeWljfh+/+lF
    PzqjFnddvqu5kWkb7AouIVkMuvBekBC/9VcDIT+PR679A9yMz/MB4E7Da2z8iU0jE/BjK6
    UH+y1AJlStm0uPM9kR1ZuE9r0W4XCW4+e2UQW4x8dB/L9DoF9stfDeultZ3lX1akXgJQDh
    skIO0njJ5NXe4RQOxBfPF5irJjFjFbe86f6eHa4b9ss5AEW4mXVm5honwdgkwDaC25GkhB
    8r4Nk+qUV0FWgTtngkLt9snQDeM617CPXrbvgLTiukuRSeZdhLoAsoBsIcdvvazfbxbuHJ
    H6IdGfdxnBdGu4HH2oqdbTUe5wRG01m2h3GWiG3ZpQYpvdPIpuMOh6BEkAtD0J3Xug1+pm
    4AUvn9m8UUrJmCIckS/5/wa23RAiW8gzewNI13RgT73RNECJwfTq3n8YMR7ca9Xb+BGho/
    mIHTPOgoDRybkQI8jzOQhbWKcSRtGdnN/1G17mDSI1xU7Q1QISNTmYvm9D+CL7uqCCgzuI
    3xrvd885QRi+4F/RkahhJ+bRAFSBf4ahOURcE6Dg+KfSFoBMkXEUY7Qt3asS+PHsAbLmhT
    Xnzvzw6xBypCDpFP8Qdc1Xvl4R74PKhPpu4OIiaBhN/oRXR8diww2NeUIggw
X-ME-Proxy: <xmx:owrEajbXgZ3-fMTPmaIiWguKm4M8UyiV3Q1lFQer_mUoNee4G0IjXQ>
    <xmx:owrEagM0i8rir5Wj5n-sakgrpFnYNYe7MIPK0-5L_vapCQCzti1K5w>
    <xmx:owrEagYNBYjBG74g61CJin0LN-9CXh8nmCMsrvv6cgR8pbrwmwj3_Q>
    <xmx:owrEam09-Pe8-o-gBxzGTHrxxBZzB2Ohwy_pkatq4ziyINPHxf7K1w>
    <xmx:pArEasrPKMBbiFFvDvSkG1LKWIiKLivS7FpPtVgpHa1anoBzKkX2Hc4q>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 278A422C009C; Mon,  5 Oct 2026 16:37:54 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 05 Oct 2026 22:37:33 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: git@vger.kernel.org, GGGGGG <gitgitgadget@gmail.com>
Cc: "Tuomas Ahola" <taahol@utu.fi>, "Julia Evans" <julia@jvns.ca>
Message-Id: <474cac93-0502-4a89-a8c4-3af66c1670bf@app.fastmail.com>
In-Reply-To: 
 <5fd36f91f086bbff929b267c6d74ebc822951da3.1791231610.git.gitgitgadget@gmail.com>
References: <pull.2241.git.1790627122.gitgitgadget@gmail.com>
 <pull.2241.v2.git.1791231610.gitgitgadget@gmail.com>
 <5fd36f91f086bbff929b267c6d74ebc822951da3.1791231610.git.gitgitgadget@gmail.com>
Subject: Re: [PATCH v2 1/2] doc: remove gittutorial-2
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


On Mon, Oct 5, 2026, at 22:20, Julia Evans via GitGitGadget wrote:
> From: Julia Evans <julia@jvns.ca>
>[snip]
>
> More importantly, this approach of introducing Git by learning about the
> contents of `.git` does not work for most people learning Git for the
> first time. It's interesting information for some people (maybe more
> advanced users or folks with a strong computer science background, for
> not appropriate for a general tutorial).

for not?

   ), but not appropriate



  
