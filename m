Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C612451CF
	for <git@vger.kernel.org>; Fri,  7 Feb 2025 15:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738942777; cv=none; b=XJl5Ote1Myrhwf3mayyKoBoi0tNGbc4xwCyqye+EL8oOmRk+l+hek2bm9a9GMHRIuByjwvZ4aQr3Hz+KaXWTCm8sSa8l/RZVAfOH3e/km2VwPiCZIb3fpfxSVwmY8pbaU1T4S2ZS9Kscb9HzMjxmVn6LvmDrQCp5YswosK3+0r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738942777; c=relaxed/simple;
	bh=95wPyPNwkFpcqNWh9SLAfIBtSuaqUReuNHur5jdfyFQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=G0qpLZl4WfhDVo65hL6+Ps5UUvPQrRW2xTANXMYS4C1RaP9WfIg24tSwSR2PQjH7n9kyINlHd0aTzcYenR33sHD7852JU8L1jDt4h4LUZA6dVd4i6aH10ed81R1yg4BVzSOpWegKj4YpTC1e6bmGWWo3kl19Fqvs3b6Ch05Kqyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=JDSTQLHs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xrKNFvRR; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="JDSTQLHs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xrKNFvRR"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id E007A1140193;
	Fri,  7 Feb 2025 10:39:33 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Fri, 07 Feb 2025 10:39:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1738942773; x=1739029173; bh=4RWi/jS9eZ
	qWoCxplQN8sf3ZLZVoEzCy0v6kV4oQ+88=; b=JDSTQLHs2kpxPOcx92QDDo1oSK
	SITcCungJ+VRIpYAJiiq5t4luD8m5Sg8g9OmUtNbV61aD+yCAJJS3c508hKvai9q
	r0v9vAODHkWpRIqCqvq2iCdSYs/61S/yQS2QGtETo09lUxAKxI1VJuPgs0uJbzkK
	nFxrbTch8vxxG7k9LCBjvGdrXr7GKkJCK8+1WA2snTXEQBiOrcxKtcDLeTuUHtXR
	wlZV/3ShoHkOg0QA7FwCsM7sPEdJf78XX1BZ6LwGhIZ2J4yeKTE/IBA9ogqC1FLN
	1GL4faaC4Ox59bINmUdc4il680nRVfpLPj+uNshjNVWNUIghkSGqYTNMqbgQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738942773; x=1739029173; bh=4RWi/jS9eZqWoCxplQN8sf3ZLZVoEzCy0v6
	kV4oQ+88=; b=xrKNFvRRtkeoGY95cznpVZoDhumIppnMRDl3ofbCSWPNg3IDfLN
	IobpuvY63ZmToE3GWBuQ3Kel7Vb4sz2uj1Gl9S7dDQiapSGksIXVFq9s6XJJYydp
	hSD8MEYU/Ml8+SHW6tbynw9xi0BaqiOjyqYw2AKMTxYsUPpEJUqahn7MewxNKh+i
	suZXTaU0aPfszNYeWuuGTXI5LOidzOgt46vizgvhujCQhxUd+JBa4h6AehT+JhDl
	wj82xERzJb4D8Q4dxOrtRcZsSXAWyfHBQhbl3VbjjrfZm023gqJhQhfHTzkTYDIf
	7RCDh1PqaDXPltnNkufacU22BpuoThy5U1Q==
X-ME-Sender: <xms:NCmmZ0ZeWy0fDvGBDCkpdsktjmeQAxpEP2CgcH0o87k-XUHjguY-8g>
    <xme:NCmmZ_YjGEuZAVHTtovq7uPT1GofH9fOYSdVx9sfbifrP3oFnf4er1eK4sQ9NszWL
    i63qQc9iLxtneCOXQ>
X-ME-Received: <xmr:NCmmZ--rvhv0ro6D-x9J3Rp4DpX0tRMYWaNK54ushOulJvfFGKdAXwIbGiHaH5noCf2dLMmrfbHEdHNDYcCAYbjH3YKCh8VxNj1A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvleeijecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjfiesrhgrvhgvnh
    drihhnkhgrrdguvgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:NSmmZ-pa3yUimmflnr1zNrnFWeZtMq1Rk7zZWx0ueiaHxoLB2cCYCA>
    <xmx:NSmmZ_q1w8NyF93hTjUwdE5Bhvq0GpLhCOMvCmK_tkc-_2Q09CoUYw>
    <xmx:NSmmZ8SzMT9Fakas0AiYH7kszP5Jw7W-f9AADyJVow1lWlNslf52Dg>
    <xmx:NSmmZ_oz-bKTbmROyS_E1XLW1PPv7-IMkbFtboGVwT3ks4KCogHYMw>
    <xmx:NSmmZ-VNC6H_-WnsMXm-WtjbhhVuUrH33O8gVTtgDlL_yjqNU0Aytt1I>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Feb 2025 10:39:32 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Josef Wolf <jw@raven.inka.de>
Cc: git@vger.kernel.org
Subject: Re: renormalize histroy with smudge/clean-filter
In-Reply-To: <20250207104510.GE30202@raven.inka.de> (Josef Wolf's message of
	"Fri, 7 Feb 2025 11:45:10 +0100")
References: <20250205214726.GA30202@raven.inka.de>
	<Z6PsXGnxM3UBR3nM@tapette.crustytoothpaste.net>
	<20250205235931.GB30202@raven.inka.de>
	<Z6QCX1QZxxwC7RVQ@tapette.crustytoothpaste.net>
	<CABPp-BFZ3oyKiryKMPph+nfokC=sFa7wn1wdas863273bzy7pA@mail.gmail.com>
	<20250206134006.GC30202@raven.inka.de>
	<20250206200418.GD30202@raven.inka.de>
	<CAPx1Gvc2piLT=p+dvzcJPTMDQAAjQfz__O4KiRWs-fOMg8dpTw@mail.gmail.com>
	<20250207104510.GE30202@raven.inka.de>
Date: Fri, 07 Feb 2025 07:39:31 -0800
Message-ID: <xmqqcyfthih8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Josef Wolf <jw@raven.inka.de> writes:

> I completely fail to understand why git insists to operate on smudged files in
> many situations.
>
> IIUC, once clean/smudge are installed, all internal operations should be done
> on clean files. So why do I need this "git add --renormalize ." at all and (in
> the case of cherry-pick) there is not even any way to renormalize before
> picking.
>
> But maybe my understanding is too simplicistic here...

Nah, I suspect that the reason is much simpler.  

Many tools in Git toolset (like cherry-pick) were written long
before clean-smudge got popular, and they were written by those who
did not need clean-smudge.  Those capable of updating them still
have not felt the need for clean-smudge for themselves.  Motivate
them and we may see responses ;-)
