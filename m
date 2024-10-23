Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51DA1CB301
	for <git@vger.kernel.org>; Wed, 23 Oct 2024 16:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729700408; cv=none; b=ab7ly2bA4hlaCGDRuvRulW1MJ764lHXM0XmUSXA3tEM1ua8pWjBuGxvXInD8GpMJffmIuztfUbLuDEW+fEnurdxrtBrajX1OF97sXAOIBiBVZOmDGvFQrAMLFJz8N3dnESs2iqqxT+iBDgcLPPda0up1+Meq1k3nL4vu/fL3b48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729700408; c=relaxed/simple;
	bh=t0Wj0Ij//UPkWuUYJ5Ay+JmeIF/tD6eLOxEbAD/xV48=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=hSxV23XnvCn7RicFoBRcZOHRsgQvPco+Mhq2l2TMi/P/N5qb3R62dMLyUJ6dW0Y15aGB4tvBeDHSfYhbcBIGt4goH26bu8o9WWd3qbozkFjTx/Kjzyuj3RB/dw6Cw28nkcjCa7suqS1T3mFSe2maq6z6Q4QluRgzu2tCVybBPek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Jt+oMqiG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gWa+drpe; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Jt+oMqiG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gWa+drpe"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BEA2211401F6;
	Wed, 23 Oct 2024 12:20:05 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Wed, 23 Oct 2024 12:20:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1729700405;
	 x=1729786805; bh=b236EjDTEPUKu3pJewOTvNIwm4I88Do6fPwCq6yqxA8=; b=
	Jt+oMqiGDrmI1lWz9l2UFfLJ9xLmBHPd3wCFN+jJmksFWpFVH0jOXgkiQX5iHM0X
	dwcgFhnJbzdqpYFHRG4aH1E6TgzvWns0V4oFdelqFDyuQLgZ5mmVVuTEvRHNPx1Y
	MHUulg0ZqCbwvB7/PQsOmZrfKEzYoCxi6HGl5TQ3Xb4jMIlFmoq1mKEWKF57HAba
	Q2PpwOpDPYWnTwv1x83+p7sRoO8r+47ayp6/MvWn9CyN0pA76SG3fSlhyUGr6Iw4
	KBb1jEB0ZF5ydu9PLIUKN5Ej/9Jxd5L+TQvjFiiHrU6PFGlVEafG1G1pKP7kqyrD
	4vi83wl4+wNNpLPaC2iNnA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1729700405; x=
	1729786805; bh=b236EjDTEPUKu3pJewOTvNIwm4I88Do6fPwCq6yqxA8=; b=g
	Wa+drpe6zLliEjUfGWAf95Xa9fDpDaKKu+cx6M1pmR6Xmd2QxFLlPgjkILsJmtiF
	3Q8YYHkREos9Zpdb4pZTvGs8sLs/kUaiVV3jpqB7PILtjMcWu/0HOvAG3Mhms3H/
	qOkWjQjGi1Quol2qCisSSErV/puA4VUDfv0DsZkah6yl14jzAQQSJnLenRRrRd2g
	JTHrQQtIuJCGoVb7j5H5c/n9p8Za6Z3AzKs4/t9CyfcuvoG6u1QdfqojlhjhyuXx
	PGJRP9lMIBCEZ6KEkkO0rVIvBpWFCtMCU9f1SdhnS+GUzMy7eeankEtJ7k8E4hwI
	v5z7Kz45LUJ6t6R6jBP5A==
X-ME-Sender: <xms:NSIZZ7bjy3caUwOIHMqvh2zs3KuooLwVwUMjYNQ8XAHcNnzrPKzmVE4>
    <xme:NSIZZ6aUIzgpMnCp_nt8tlasBH1iS6zEnFpMQPJoM-Y0xpG5KEIGBMVLFC65_3cDD
    AngH39gn4LzSNQKjw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeijedgleekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdej
    necuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhish
    htohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgr
    thhtvghrnhepieeuvdfhffffgeeutdetledtfeelfffgfedtueethfehuedthffhfeekgf
    evveetnecuffhomhgrihhnpehmihgtrhhoshhofhhtrdgtohhmnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruh
    hgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlih
    hnsehgmhigrdguvgdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:NSIZZ9_GG9NvuE7XpsQLdmQFu68RakPoqdvds0UYoWj0ij4hv5eUlg>
    <xmx:NSIZZxpz99NPCEWmhXFVPBKsgannBbDqUtyyLXPYuJEc6f5-cgM7uQ>
    <xmx:NSIZZ2oiAXZOZ5f-livHgh8odHxC6NU7dyUxMRn5D-fqOFcNE0W7Cw>
    <xmx:NSIZZ3R_BWroHiflCXa6dg0XmcCvuHFXbc1f2jRt3S4VujpDdf2oUw>
    <xmx:NSIZZ91SonZDdS52UYe5BLFY27bI4WEC-QeGyL3mr3NzRYijYQiNfg9r>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 8BE0D780068; Wed, 23 Oct 2024 12:20:05 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 23 Oct 2024 18:19:43 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Patrick Steinhardt" <ps@pks.im>, git@vger.kernel.org
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
Message-Id: <51b63d57-fa01-4a8c-95fa-770a62afd80f@app.fastmail.com>
In-Reply-To: 
 <d17ca1c7ce38e12fe113f15b078c12bc92e8f0aa.1729695349.git.ps@pks.im>
References: <cover.1729695349.git.ps@pks.im>
 <d17ca1c7ce38e12fe113f15b078c12bc92e8f0aa.1729695349.git.ps@pks.im>
Subject: Re: [PATCH 3/3] compat/mingw: support POSIX semantics for atomic renames
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024, at 17:05, Patrick Steinhardt wrote:
> [=E2=80=A6]
> Careful readers might have noticed that [1] does not mention the above
> flag, but instead mentions `FILE_RENAME_POSIX_SEMANICS`. This flag is

s/FILE_RENAME_POSIX_SEMANICS/FILE_RENAME_FLAG_POSIX_SEMANTICS/

> not for use with `SetFileInformationByHandle()` though, which is what =
we
> use. And while the `FILE_RENAME_FLAG_POSIX_SEMANTICS` flag exists, it =
is
> not documented on [2] or anywhere else as far as I can tell.
>
> Unfortuntaly, we still support Windows systems older than Windows 10

s/Unfortuntaly/Unfortunately/

> [=E2=80=A6]
>
> On another note: `mingw_rename()` has a retry loop that is used in case
> deleting a file failed because it's still open in another process. One
> might be pressed to not use this loop anymore when we can use POSIX
> semantics. But unfortuntaley, we have to keep it around due to our

s/unfortuntaley/unfortunately/

> [1]:
> https://learn.microsoft.com/en-us/windows-hardware/drivers/ddi/ntifs/n=
s-ntifs-_file_rename_information
> [2]:
> https://learn.microsoft.com/en-us/windows/win32/api/winbase/ns-winbase=
-file_rename_info
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  compat/mingw.c             | 87 ++++++++++++++++++++++++++++++++++++--
>  t/t0610-reftable-basics.sh |  8 ++--
>  2 files changed, 88 insertions(+), 7 deletions(-)
> [=E2=80=A6]
> +
>  	/* TODO: translate more errors */

It seems that `Documentation` doesn=E2=80=99t mention the difference bet=
ween
`TODO` and `NEEDSWORK`.  What is it?

> [=E2=80=A6]
> --
> 2.47.0.118.gfd3785337b.dirty
