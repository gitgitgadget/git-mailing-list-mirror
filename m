Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E9E517BB5
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 15:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792077203; cv=none; b=qSwZpYHMJ2DrNYIEmIFM4ZnVcmR7uflbigp5sxSZ5equagbdBiKqALpsMSfynrXpfdsOybpSsXs5xMpapCuZ8gtlGjWNm88Tc3lsEDmr8QMMbZ4K4M3URbf68fTGBa3KB6oazED7Tpe+H4HPhjOLGNR2KVCye40zPXtvrF8Ndrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792077203; c=relaxed/simple;
	bh=SXmoLXwEohzYmRZIwrbH24G4iTaKZXuEUfOPUr9R2Zc=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Aie9RfahuUjtZddvy8Hz/XCJtNQCu2SvyAfYLIsEzs8wFOEgSfwqDyvNnvOXo41Rc/vVt4GZ6Sd+QjgLmY5gBzZK0cc0L3NoZlL4qQzbHk3QmhQb1Bn6vixTq/vSj07ib/6u2RYeNLXCOqn7gblJVHyPmXNSlbIXdxOd/o30/pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=O91xG1lN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Xsa9mslO; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="O91xG1lN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Xsa9mslO"
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfout.stl.internal (Postfix) with ESMTP id B9CC41D00157
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 11:13:20 -0400 (EDT)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Thu, 15 Oct 2026 11:13:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1792077198;
	 x=1792163598; bh=SXmoLXwEohzYmRZIwrbH24G4iTaKZXuEUfOPUr9R2Zc=; b=
	O91xG1lNE8lRy+pH6KOgOMMFzGk8jsWf69fLr49g5GaqUpWYlOLpjvrI5w8GxIaL
	9RyCqlL31pyYKqO9MoTS5tcBYPJuSpwLmK21YQLaXuQ9BRSSnmfPAWH/ByIMuDMd
	hzx7AKXPjll+7wIYepihpNi9tNyuvW+fuF6CfLsm/S6BHO8omaUrUynkYM7abGsi
	9OYhS/9Mmvp1sLW/xsA7KK8yZ7BcL8N24/q+wLVTXXNkSWoADXTJwgKn9OKFHHDM
	j+GkNzS8/pkV7PeHpL6hdNKJjHf9xHObRQ/WFYtHbNHUILxPA7hYVI+HeVa3XH0I
	+G4bfMokenK1jCsGWaXQow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792077198; x=
	1792163598; bh=SXmoLXwEohzYmRZIwrbH24G4iTaKZXuEUfOPUr9R2Zc=; b=X
	sa9mslOmMJiCC0MhzrbchmVJY27vtXzHIXA2PZdNo3ei0sqZ0rmZu+CbEX/kLpLt
	apFqdHzX0qtspB+KERUXlT53kc70FdnX7gCbdo7UsfxcJpse70aBsPtSZlvv/oMk
	/FhfsJNNGySVFd3wr71BBep+b0M5k27KsjRRLE8r4rUyl4itq3PVr28mlBgBnInr
	F0zMSquA6DVAmoaD+7ZuXcWrFHbKnjoaJvbfwuq8FLyKQcWbA+2/mHq28JZ9Cmpa
	Yyooj4de6DJkzWIBpKlPD3nuGkLAnLaaSUJLRmssH+CZ6BmkKV+3shRE+r68MAoa
	8l3Ld3Kl8A2WSXFRHPuaw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=fastmail.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792077198; d=fastmail.com;
	mf=PGtyaXN0b2ZmZXJoYXVnc2Jha2tAZmFzdG1haWwuY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:QKcb3J0ICdWa5Vg1ltbLegBt4uqPAh6esrvv/yBuUvmzXjh
	GmUzvFWXF08EMBz1fMIUaU0aAMneX3N+sBwZAFqUr+TWqKwiPokvxYHrIW9GiWHQ
	4c2q+/D202+Ahq7lIRQZnoc6hIJPKWlotAYSKahYzk1sRVJFqR71cRFwwsfkqRx6
	MuWY7lBz/O448uWcvHH02Hfh481UUHUpomSeOC+xteZAdcjkywPelmF/atJXPVaQ
	NrRieWXp2E7C41Frpu6i4z1lf20LmaaVIWfOuFkPdrsXVc9LhVntfqA1hdVMjQzb
	TycR+wPNC9PiRC9ZVdbwTbYK80vEVkl5tc7kaIQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:DhZ43dlvNqRGjbGzF8Uvsd1iVqlrifIehifAiaiUfdU=:SXmoLXwEohzYmRZIwrbH24G4iTaKZXuEUfOPUr9R2Zc=;
X-ME-Sender: <xms:jO3QaklFiw59TZQeFQixRN7Gw-aWzTvrJVyoUvmsnKE56oSafJsZc6k>
    <xme:jO3QaurpZlq4R-ooVi8vp9YqOLGbstmO7lvPWJJht66QJ1R48vXWeOOso7iOhP_KO
    oCVoNRt5_KB-HscYnUi4Z0hVlsW5Za0sYVYPdURdOHqg3UFEG6bjuI>
X-ME-Proxy-Cause: dmFkZTGUD1bTKDrqo8l0rIa/paAUehbYPx4iJycQLpyvCL1HrzkEgQ1CNJdjdmgft5hETp
    5YFU3430IhLazdsWHce9WogExtTRLeZu/W1bvyU2SfmhRzl0FBkvn6M1ulJtF157hlkD//
    z0+7Ui3nmEhTvGEU2eqQ4jcA3pF7cI3gUjX3DuR71JRb4nnnsdDk+xiaRu4UVaCSYzP99v
    Pevswsb+MSL3R1cmCQ0LA4krqWCASd7FOHP0kEzlrCCzsLcmm5gOo2TmmlyWQJ+mQTLHs7
    tcv6ijS/bPeRAS7jvmb/+YjPLNUIojSGpjChK19Aaak3OaIxpkWM6Kfs/qbGiFK+iBwWaI
    gZHN5mGoi7m+I2tdem/0IQH4v5ZjLATdTSo5sp6tX2Q+5b4r2yxM6kjdNYQXMraLJk8rRJ
    jm6Tm2sjIBVvksaRgJXh9JKSrR3fbksOm9gw93JeVdD+sFwdxvwWtUIu2IXZCmkdkToeo5
    WydC0QBMqNKd73E5omTLx1Mz/Z1KdYxaNdpEuYqiU9qJBWW5+K6BW17+LdIhW/GKHi4zj7
    B74AJ3zifKtkycEP4OLRvpvglcJ2UvzsZqCyA9zKMPI18/0DSUOeqAhCA6Cpk1aQ7HeAjv
    a8BCt434PER5hY7if6W86O/D9iNXUxSAX9qFAFwHwMEt+7NG2qIvdsFno8xg
X-ME-Proxy: <xmx:je3QauMYzhDCO1BcIow0z-Ye9i3OsBzStbj5VdeVlK7n9O3OJD4gsw>
    <xmx:je3QaqyYgPbXQlc9E-511TCQeVF19qFA1Nh7-Dtara8J9obHEcPR_w>
    <xmx:je3Qavu-vBEAhjWy68Fa5M7LhKBM6jVnavYJIu-he1Z11Wl5yY6Hyw>
    <xmx:je3Qar4g7SgAgG6yD3oEVj7OC006lfqyiw4ntxEWhfq1SWafyKLPkA>
    <xmx:ju3QagBnrDo6IFFd7112Cyrtlql0YHpfVoSrYHil6xNTheIDK57Kdiye>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 72C3922C00A4; Thu, 15 Oct 2026 11:13:16 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AlOAx_7OTDuF
Date: Thu, 15 Oct 2026 17:12:47 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>, git@vger.kernel.org
Cc: "Justin Tobler" <jltobler@gmail.com>, "Patrick Steinhardt" <ps@pks.im>
Message-Id: <85a904ec-a478-4d47-b4ab-37817c5f67c7@app.fastmail.com>
In-Reply-To: <20261015144559.3652143-5-markchucarroll@fastmail.com>
References: <20261013172849.1109478-2-markchucarroll@fastmail.com>
 <20261015144559.3652143-3-markchucarroll@fastmail.com>
 <20261015144559.3652143-5-markchucarroll@fastmail.com>
Subject: Re: [PATCH v6 1/1] repo: add filtering options to "repo structure"
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Oct 15, 2026, at 16:46, Mark C. Chu-Carroll wrote:
>[snip]
> revisions are specified on the command line. In order to accept standard
> the standard revs parameters, it uses `setup_revisions`, which does a

s/standard the standard/the standard/ ?

> ref walk and populates the pending objects list that will be used by
> "repo structure". But this ref walk doesn't count refs in the way that
> "repo structure" requires, and because "setup_revisions" doesn't support
> a custom callback for its ref-walk, that's not changeable.
>[snip]
