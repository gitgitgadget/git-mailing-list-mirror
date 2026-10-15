Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B588953D9E6
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 15:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792078538; cv=none; b=ZRJJ9LMCOqzOkL9OSJjN4dePlrhxp8cjtMluS22ZqTpxiaIsMzQ0MzyefodagSpRf8gRR4Uo4ReUOQLOQkoqoYJhWY2uuhq+5TeWk4J3V/Tk/9OEDJnKpnddujJSy/R1r8+hZML6Zt/jiqWYsRI3HDBxO0RR2sDeitnL8dgh/Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792078538; c=relaxed/simple;
	bh=Eu5psYn76U6KY18ZRIr3OEWCUo1ec3LSVvthyAREpDI=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=CDBafYXib5wz77fRiu//8v6oi4GFrXnJtl8deFJ06Q2feKUKOCq6sztOh77QWf2p642WFRyhPPhNCAchFOhUSOcJqLls1GNKGCpWTBCgi4SVCcJ2ANaH0ZRegJvOm9Lk8SnF7pEb3guRyzIcnMMuDJjGDifpozpFoTKpH7KfT5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=arLXMbZY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OW6ztbX6; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="arLXMbZY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OW6ztbX6"
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B2CEB7A010E
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 11:35:29 -0400 (EDT)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Thu, 15 Oct 2026 11:35:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1792078527;
	 x=1792164927; bh=GVd3p5UO+DlRErvtXaJlIz+4/UaQokxh/vMCyYfP4gk=; b=
	arLXMbZYcQu3b/FRYmRLfejhR4UrnlRvfMOI/TzZI1WBR1UXgqk2MNV3D+DpfJxI
	UhiltnWeABxq44B2pSxkEEIlaTZFD2IJxbcLpA8KzZduDGF5H0MBQe68JAPkT9g4
	fOVPv3R5IGY5bn3ZkgC9RHeJE1YqjHcmEdXwJrvc80RCOj1UvgeBTOVclKntiA3c
	uuDkDUaSYrwAtgDeGfrq2KmeArLyLd24/42pHfkUvoaBfrjwiwRX6oPKNebxw51L
	5ivoDwc4Uq31vXyPQLa/YG9J2ElnJ7MqWZsJekhVY18vlcDEW8Z0bgDlE1ssCbCn
	/X9kYIGhG41bZZAzbXVuPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792078527; x=
	1792164927; bh=GVd3p5UO+DlRErvtXaJlIz+4/UaQokxh/vMCyYfP4gk=; b=O
	W6ztbX6sutSsGvLnigbjbuTxHdMulSCwC3ARm00TCvPHx3IjmA3GYUjmebxwyHul
	Afjh53p8SSDVFQ8sG+EZlnkN1wHzv8LgzyiM91K3iQurj+QAFn+gn3u1GnK+rbrU
	fpEijjI4Lla6FFDNMEQl18GV0CuzARH1hL01GMbjQzFZE8VZ/FjRstPwb6Kpl2Nr
	lUSRzjXDK3K8Qw8tsWeEiy9xjOcm36NJgJCOAee7eIrVFoMIND7fPyceM9hmRHnE
	qirjSTlAZcLpwurDadMIv4R62wnHTk5C5FUK//i7mSXB/z2QhoWZORTRUJ529jcH
	If6uMJFlcOYbWGPvdkIFA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=fastmail.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792078527; d=fastmail.com;
	mf=PGtyaXN0b2ZmZXJoYXVnc2Jha2tAZmFzdG1haWwuY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:KVc/aTphTKo2KBexjqFnJVlvmk1pIZTpge1FPCwuesMimCh
	lQegEx8o6CQbcqvLFwCIp2FPK8umx1NrrsobhvPdga68QLkh6FsXgHhgIlSo+25I
	Z9WST/r9u4+VB1AFAq5XWfrliXR1p9260tHVJugbJYFhGecI6HCiz3ztS0i7JXt/
	knA3KI0fzhtAMqgah4mxOp8ljm9o+U/NSnM8w6pRZPCdgfkPhyKlV16eiKChRPnx
	qNDmTfAtRPquJCbR2W3lYqYVQmXaHQEWplQD25xA/SJZlC+UOFge11YEckzjKL+6
	zOmVdfCS2jrF3dC0fzuzWFRBd+DWhuksBdlnDCQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:NK1A6GEp9N/waCM88+7Tv9IzXUOwwq9YIGyc29U2Umk=:Eu5psYn76U6KY18ZRIr3OEWCUo1ec3LSVvthyAREpDI=;
X-ME-Sender: <xms:vfLQairslaxCK67D5KwcVmNSjBr7J7CaCW7ALbeWrkuf8XtKya7uoic>
    <xme:vfLQarcdSix8TfMvR4kF6LiSmw_LxKW5kmucWFf8jclSVc2BCqE33m6hEGiRRS4Ej
    ceZcpCgXju2gGO1BMrA2DRQ24gjfT4E5-R0eb3dZK9Eef2xMXN8-g>
X-ME-Proxy-Cause: dmFkZTG2cSNN4e9L1ipSC7DjPBxE7YYKnZZwXktgQMmNRGzeibEjanKV8dPZx3Fb5YAv9W
    SCC4tYM5IUxDrCmcWCpeutg7z3TBTQ6A5UIR2vkStl8AsMhqa5Q+OF2aNqW2GKWO1wDj7r
    HJep0J2G2WiO8eUs1S7kjj2LByYZ2lW3wLhXS1HnAXRIN++VlPO9Mg6pvTZzEPIZSirazl
    PK7q4dQlQ1STlODy/Nq/WETszEvxSalE/KhUiDSgx//B8ZYpEyQQJcH/a20vHbjQECVtGr
    JoRdlCdme7UShHyeEEAQ9rrzk20l7cVjduYnIORzNFaVGli3Amns1VK50eaLpHKVlLPmYp
    stZxaT7oV6QafGSEuC0Rk+DuW+OcyHlkJ9RvL/4yuVT78N6/g1RcdNSoBrGOo5indhfEce
    JvNblMgchziLHG49+eEdWhiFFbpRRpH726xA4wvtm4fa9Xmoug2jdD2ww2lsWeSxQgLohw
    L+XTnOqZd0pAdnGJmqFtmkYbnpP1bexMmHCvKOq85FJuo9rrS6THif9xsfvq8+9+r0iuj9
    wmk5FmkRbp85b8boukXu2wdReuUosdUuPhZlY7BdCA8+rWkaRkl42FqHH+hpgfpxsWsjEm
    13gCGU2Fz/RbX8Dk8phbo7fGg70e8E4HC/boL3pq+oXZqvKkktuSjZaJNdwg
X-ME-Proxy: <xmx:vvLQarHyROyMVVn6yRzwzcECKM98awuj1Db1gklYQxIUOuCxaQ3ZyQ>
    <xmx:vvLQagHfXK2d0Ta0YUW-WtCpZ04r0jPxCWHWGImQ8uUlHBo5XFtDPg>
    <xmx:vvLQagNVMx6Y-n570Q4TfYGr5zE6JJf2Sk9WkfC5N6ABjrlgScuLqg>
    <xmx:vvLQanFlkf2UHzhJLT7j7UJFFdOJnO7Z4gdJ0SaVTajKUEQcKWb3tw>
    <xmx:v_LQallYA00CuGUUt51sTBDa93DApkHynP2CsIfNjq15UxrLi9t7f0G8>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id AD6DB22C00A1; Thu, 15 Oct 2026 11:35:25 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AgdWeLtCs7o3
Date: Thu, 15 Oct 2026 17:35:05 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Harald Nordgren" <haraldnordgren@gmail.com>
Cc: git@vger.kernel.org, GGGGGG <gitgitgadget@gmail.com>
Message-Id: <f06c7de7-f9d5-4c7b-8c65-fc2cec1ee698@app.fastmail.com>
In-Reply-To: 
 <CAHwyqnWyYhRZ0=byi3_yqT2phmVa2DY8XtxA8bQT=pwcetkMAg@mail.gmail.com>
References: <pull.2448.git.git.1792070038.gitgitgadget@gmail.com>
 <fbbbabee-c586-4305-bdfe-3f7cb46b7191@app.fastmail.com>
 <CAHwyqnWyYhRZ0=byi3_yqT2phmVa2DY8XtxA8bQT=pwcetkMAg@mail.gmail.com>
Subject: Re: [PATCH 0/3] reflog: add --operations and --historical-branch
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Oct 15, 2026, at 17:24, Harald Nordgren wrote:
>> This sounds very useful. That you rebase many commits and then the reset
>> points (where each one started and ended) get obscured in the reflog is
>> classic for me. And I think many have had the same issue. This is why I
>> sometimes use `ORIG_HEAD` instead, or maybe make a backup ref.
>
> Yes! I love the reflog. But I'm also endlessly confused by it.
>
> Sometimes I'll just pick all the commits one by one and do 'git show'
> on them to figure out which one to actually pick. Not a great
> experience.

:)

I got a bit curious about this forced workflow now. I tried the first
terminal navigate-and-click Git tool I could think of, tig(1), and it
turns out that you can do this:

    $ tig reflog
    $ # navigate up/down j/k
    $ # See the commit message and diff with `d`
