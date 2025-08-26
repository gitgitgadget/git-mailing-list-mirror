Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008E3374C4
	for <git@vger.kernel.org>; Tue, 26 Aug 2025 13:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756216530; cv=none; b=PBuu4LZYZs63u4AP8UmfrGSLvdOQotqBmCrKMCTBFFzIafKNx/ghkWGXOfScFSEQTe7KcPWzOTZ/ERuUnKRBiDg7KRoBXPMJUS6ug4M+fyQCMQBoHP0Fi3+CjQGEVNoYBN8lXCB4z7US4MZ/SKLfkNlsFOTWpZv4M6xm6HRoZkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756216530; c=relaxed/simple;
	bh=cALp0lzcHn7mJ6+HXurfs4ZNS7FgiUNfCMXPeqznj4Y=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=L96j9tfqv9oyS6K8XHxT6FqciPVlvd3gdNOfu+tRldJMYoD1vRMlInrZYz7PUEpn17OLJKwf+H5kuWL2G8UE0tZTFlW2ztinHmd8TdXzH70TckPNZGUayVxv1Edue4G7kkXmns9h/BTPiPp8VetzH2PiiND4Rakm/nnhoY9BeXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=lrp61OT3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=et/rmq1c; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="lrp61OT3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="et/rmq1c"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E81147A00B6;
	Tue, 26 Aug 2025 09:55:26 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Tue, 26 Aug 2025 09:55:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1756216526;
	 x=1756302926; bh=A8ziVfS0cTZnl/XM8FruugrZkZcCZ7jaZgthPce33aQ=; b=
	lrp61OT3hlSaWtKKiEKWj8zICOHbuFnSMvlCQk3O+R5lRbDzgP6JQgPI3LeTUFB+
	5lkvhbhjB+6mR2qaRsGIMmhGmg5ayKxwrSZWWGy3TU6cs//vvC8Pe4aWrKSWhWiS
	+Rcjz+eqoN1Ak9jjmtGWrwkOuCdz0l4oA3ipZ81XCv7ytFmetC3ONzhjesGlB4uF
	pz9cvGVRQCBmDxmnBTHpxSSNZZtG6mhy5sfR4fjUK7ereShytgJYMBFBaRWkRScR
	ot+ZlQ9ucS8PT9tW1WQsbyURUDuMxVxxIrFQgeGawHY/VJK8uZM88xBIRBE7BgXt
	H7WGLWSFMzO2k3vGfLP+NQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1756216526; x=1756302926; bh=A
	8ziVfS0cTZnl/XM8FruugrZkZcCZ7jaZgthPce33aQ=; b=et/rmq1cAu8BbR25O
	gcfc2Qv/X1WnbylKo3+/ryceLDWyCa+N787yWmyEPv1qmSizedqW+CNQPwyE9rtf
	X8hO2ndlfhJR01c65kvurzjcG2RJyVj4e4zSZl5uqNco9gI1GA6CZcuOcYryKOr1
	GAGBbuCQi4NcJleijc/vtOth83yDisRo+/RGsaP1uwqItGp1ge6gn7O4R57Me/k2
	OWVHM6a2n/F3oz8ADvIncwB6T28rEnE5WgZNB5t5+UqQqE967LL3L9IEiJgJ2Trb
	U/ytGl9H8dMC0JoE6BKL8xOv3WAFaubxkw6/QNwcKaPlBjnlPgOfdVSjvzPiu3OH
	00ofQ==
X-ME-Sender: <xms:zrytaJ2yPy2URGhesa5x4cZ_8nq9_JeQ3NwPq0POrFKAr1fUS78SHCw>
    <xme:zrytaAE3SpX19V-mnMVGWJNVKt6T9vRD7k32BQSB-OYdhD7GXB764UATzIT2XJXWD
    IshG0wssj8PJ0kqxw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujeehgeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvffkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpeeukeegfeduveev
    teeileeihfeugedugfeludetleejieeikeekhfejudfggeeiueenucffohhmrghinhepkh
    gvrhhnvghlrdhorhhgpdhgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedt
    necurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkh
    hksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtoheptghhrhhishestghhrhhishhprghlmhgvrhdruhhkpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:zrytaB75IndZ6EISKcKgN7dk1O1PTmFjHg2pAcnSHRnRizIhgPWR7A>
    <xmx:zrytaH2DI7srbTBMiC9khlGOYnpK_FiK86Y-YwDlQpFyi8bslSi7mA>
    <xmx:zrytaKY1FdE_Y5yDgf7Fh5FueCe1Nz3zAHVLb0wLFVY9N5hie5Wo9Q>
    <xmx:zrytaHCu11gvD6yEKZrDLVhtU-t7tFeXFcj-Du-VKDshErFuL8VHPQ>
    <xmx:zrytaI0T_Z1Rr9KncEMf7KxWr-p08ecKUQ03XEXSeWlaSQ41H-wEsyRD>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 8350F1EA0066; Tue, 26 Aug 2025 09:55:26 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Ay7D334CPtTF
Date: Tue, 26 Aug 2025 15:54:43 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Chris Palmer" <chris@chrispalmer.uk>, git@vger.kernel.org
Message-Id: <04d5ce4f-53aa-465a-aeb1-bef84532e424@app.fastmail.com>
In-Reply-To: <1011073f-9930-4360-a42f-71eb7421fe3f@chrispalmer.uk>
References: <1011073f-9930-4360-a42f-71eb7421fe3f@chrispalmer.uk>
Subject: Re: git whatchanged
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi

On Tue, Aug 26, 2025, at 15:04, Chris Palmer wrote:
> We still use whatchanged frequently. Sometimes to check the later
> commits, and sometimes as an easy way of searching for changes to a
> specific file.
>
> I'm not clear whether you are proposing removing the functionality
> altogether, or whether there is a new/better way to do it.

You can replace it with `git log`:

=E2=80=A2 Given: `git whatchanged <opts>`
=E2=80=A2 Replace with: `git log <opts> --no-merges --raw`

... with some minor output caveats about empty commits (commits with
no changes).[1]

=F0=9F=94=97 1: https://lore.kernel.org/git/20250825085428.GA367101@core=
dump.intra.peff.net/

> I'm not clear whether you are proposing removing the functionality
> altogether,

Yes, the command is slated for removal in Git 3.0.  They have not decide=
d when
that version will be released.

(although the functionality is still covered by git-log(1))

See this doc (from 2.51.0): https://github.com/git/git/tree/c44beea485f0=
f2feaf460e2ac87fdd5608d63cf0/Documentation/BreakingChanges.adoc

--=20
Kristoffer Haugsbakk
