Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387751A0714
	for <git@vger.kernel.org>; Thu, 24 Oct 2024 07:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729754324; cv=none; b=NJ6NTDghQVYQSTDPaL/bmrOiDd7o4Ae335gYn+xqvK8g/wsE5WOnqABDc2C936Y62ABxz89KAKbFpP0+c3D0t/vabIJ3wEoY9Pl5VXKqXMkwpEy8Q62MG6jT4FoPrvS7rNV9FQCF+u7niW5enwtueLon2t8p8fmSa4Tzuh38I5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729754324; c=relaxed/simple;
	bh=YqMvmb71kjGrH6swJqzyHFAnRYT96/9Noy16BvemFBI=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=SqQZe+tCv4EYAh7sT2Gtv5A0i5Go3/5u/gJ4iu0+D1B2zy0Dpmk0wEpB9udpxatLrtnKGyrZAb5WV8US4RffOqQS4RJX/P7wWfqVn/AucEvcWGagaIsxy00bs67LBVIeWwp4G9pDWrf/meRTk1pCymorcK9DvWtZwlAqUfyjyYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=LB9bnoOy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IWXeWjoJ; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="LB9bnoOy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IWXeWjoJ"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 43B821380212;
	Thu, 24 Oct 2024 03:18:39 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Thu, 24 Oct 2024 03:18:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1729754319;
	 x=1729840719; bh=zHZAvJ0SQxZ9gapX/eMwZv2UTPoEhS1NkGvH5Jj+4z8=; b=
	LB9bnoOyS23clx1VX6k/W3e2gVzmWFnzVqaM2tIK22aM5+glYR8dcBDDzmVgmNd7
	HyhXbCEV1NIyBnDmYAhebuWZQDuDKqbqoc6CJJ0hQsrAExfOAr2Uf1q0nvdomVfN
	k3OUIJPsQfp9x7i2o8hgkTF+Uy4027azOyEClBQkeA241vDRm7mVxzW1Mi1mBvx6
	wqrL/RG+tnb8ed5kS8ZbU9T4tTUzFLXr0WiXz4TIn4Med+s0PTRz5Gdca96MtZBC
	HEBXErFa6aiu8IxR3SKiRcHBCdJf2ifLhkLOjllgUt7HX0ncPjKAmO9JKQrB9tfr
	XaRby0bBS/X9zqLjeRkIFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1729754319; x=
	1729840719; bh=zHZAvJ0SQxZ9gapX/eMwZv2UTPoEhS1NkGvH5Jj+4z8=; b=I
	WXeWjoJuq7CLguXmEAhi01KUBIEK/TAyjJ/N3KeieFl5Hy5NfDWGsxMJI17bY4x5
	a7qelcYPcMwSKdA9qercdR3H01d1mPwKCdgxks86KVMSHX9KJsebX8teL4mSUrgt
	QyTOUr8ptSCYXRVAnYT0M4ERe5/GyKLDg65k3mAF2EVh13uvBKEiK6BVe4lsYgg4
	6aBuOG6IzAc1J9hbxdE1XIowN3S+ItwFqwFjY42gwBhvAT3hxafZKnXlisuu4BMu
	B2OLinT32J0ZTkD/PGLmgYFhAxMu3ck3/FWWNGXecys1x0Ox/XXWBBzaKd7u9X8p
	ycpyiHtO4cY6slAxiLOOw==
X-ME-Sender: <xms:z_QZZ5AuAdJ3nOgKWTwWH-rczgePMHSq9b6j9L2-v0FPaBtDN0SWbi4>
    <xme:z_QZZ3hPDI-NumblV6gDpF3STw2DL-3ca5Q64gFg3lgIAwHvhotAezI5PAPivv_x4
    eayxc3yIoDwFLVCTw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeikedguddulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthhqredtredt
    jeenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrih
    hsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffr
    rghtthgvrhhnpedtiefggeejgeejhfehuedvgeejkeelgeduudekleejkedtveejgfeigf
    efkedugfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhm
    pehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdpnh
    gspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhhohhgr
    nhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepphhssehpkh
    hsrdhimhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:z_QZZ0n-o0Gbn4WXkiE_IvHegN8DF2uYmR97n0lXk1_EVvmZ9a178g>
    <xmx:z_QZZzxHeEevO_D-wysbQJEmnuKJmZ4XEWXNxwfNRNHzJUzRrq8SGw>
    <xmx:z_QZZ-QAym3UkEqvhD40w2EQBM0HbHnMyVoFcJ9np90hod1fpRB-2w>
    <xmx:z_QZZ2bV5Ua_4oYv_3JTmWYxLK90tSs1CjzyW09otmqvBPHSHKm4Jg>
    <xmx:z_QZZ8dBkfrW0fQUw-Gz3CvmXx4KuPyJSVUDH5c5cUqDb0hYZHRI57FF>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id F3ABF780069; Thu, 24 Oct 2024 03:18:38 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 24 Oct 2024 09:18:18 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Patrick Steinhardt" <ps@pks.im>
Cc: git@vger.kernel.org, "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
 "Taylor Blau" <me@ttaylorr.com>
Message-Id: <d6669573-d5cc-4ad9-b248-95bda089bc6c@app.fastmail.com>
In-Reply-To: <ZxnpitkbPPNTLuGT@pks.im>
References: <cover.1729695349.git.ps@pks.im>
 <d17ca1c7ce38e12fe113f15b078c12bc92e8f0aa.1729695349.git.ps@pks.im>
 <51b63d57-fa01-4a8c-95fa-770a62afd80f@app.fastmail.com>
 <ZxnpitkbPPNTLuGT@pks.im>
Subject: Re: [PATCH 3/3] compat/mingw: support POSIX semantics for atomic renames
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2024, at 08:30, Patrick Steinhardt wrote:
>> s/FILE_RENAME_POSIX_SEMANICS/FILE_RENAME_FLAG_POSIX_SEMANTICS/
>
> No, this is actually intentional. There are two different flags:
>
>   - FILE_RENAME_POSIX_SEMANTICS is what ntifs.h exposes and what I've
>     been linking for documentation. This flag cannot be used though wi=
th
>     `FileRenameInfoEx`.
>
>   - FILE_RENAME_FLAG_POSIX_SEMANTICS is what needs to be used with
>     `FileRenameInfoEx`, but it is undocumented.
>

I made a copy=E2=80=93paste mistake. :P I should have just pointed out t=
his
(missing T):

    _SEMANICS

So you wrote it the correct-looking way in your first bullet
point here.
