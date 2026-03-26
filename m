Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06FF13921E0
	for <git@vger.kernel.org>; Thu, 26 Mar 2026 18:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774548502; cv=none; b=ohnjmIirE/BLWkPSWVlixVCztc8K/JrzRaK9uIs6oMuOBmKYrhDZbrv5bI06MwOjQ0o4RhBVllx56EBmNvrusNV++xZ9746sRmIQ3K7MLESvjufQKXPbV1MLXKtRH6knc+rreTZPx9X/P/5hSvxpr6xJqh1cilgy3T0Tc2m88+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774548502; c=relaxed/simple;
	bh=FnxPA1eB5D/FwEzAIgxRZIvhLuFn0QUFVDNAiCVvk0E=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=fuhxJM2nhFEqGYInIPYckoQpEhn5VZSpRWcAjMlvSV2zjiVDoTANrvA780soPfvB2Uc7pPwi2wHyapcpQfhBJKg7NXSDQzIgbGf9PtpaJNqy7dAbG0hFX3FACYooxBXIgzOq/CcS81tV2pFAZ/ZQNY05dlmdIp2sT1sR/Hp/K54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=V8ajxB9y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kmNxJX45; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="V8ajxB9y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kmNxJX45"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 10DC07A029E;
	Thu, 26 Mar 2026 14:08:17 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Thu, 26 Mar 2026 14:08:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1774548497;
	 x=1774634897; bh=Zyygjsif9/pW3fDxvx5EfBio5lo+T+j7nQdaOZ4raN8=; b=
	V8ajxB9yesp53XcI+JIvp9e6L9SKGvRyxnk04+wMEypHPBxEHelUEBfD2LOOz+jm
	/3jaWbrbqUi2n8G0wwQtp6OGmOBFdkA1xVh5+pnXs7+L+BUEnzbL9o/8a2AXV0S5
	WWZ0nr/TjYfYk1KzCC99Y+IIdEx9QesiZxprqrqg8ZjlBcqWu+E4kEtbL4MUG9fx
	kIKyRgISNoRD/b3JVwIkQtcrKPLxkFX/FPMUVr6Ijb1b295GOwj/bPXnrKDAKp/P
	594wAFOKu6GAbd8c7p7/as1fvaO/ZqrQ2bJ4riP4HQMcOhPSEntHoThL89kw+aab
	JVtmNadgn4KSRUmR3TlApQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1774548497; x=1774634897; bh=Z
	yygjsif9/pW3fDxvx5EfBio5lo+T+j7nQdaOZ4raN8=; b=kmNxJX45O4KfN+OB3
	IK0t2YwwiTFUuiLwNuPENu1lx4Tjrrm2LjZPqsdNywc+YOw2/nsKeNGDaw+6vx9D
	UdNko6jW+VTLWo52FZ6DBUcloSOUd/scVok/3iC+498dZduhflr1VQwB3RJR+BFl
	8ycMFOeXlc4GSfhC+yIGnUHNojrrS5/JIyrxwW/nLxWSBvD07Mih6vxzCLxF3+72
	fVHDEhAZLxKt0oJobet0HFcZldw4QaxEoNEIg0XExLFtxMiH9TWf7u5AH7/4+KRc
	T9xn/+kvGB0jkQ+LQO6cwArVuB1eqlaRM1EW9b+th4cpLJCARjwnv+xKRH9C1tqO
	Mcd5Q==
X-ME-Sender: <xms:EXbFaYH5zEIwT1582vuocOrEQD-6uRWPr1vWFYif9akk7fykKn9VfpQ>
    <xme:EXbFacL16lX1UC6ztrydCmT4ZFkfemXUSHX48Zba90ZCR8n0LsnNU_Jtzd0-O3b-P
    PlDVfl5QdwHe27RrJrLFRSLkI0lMCe5bPDVXCWDkvsEp67ET-0Maw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdektdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlfeehmdenucfjughrpefoggffhf
    fvkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhsthhofhhfvghrucfj
    rghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsth
    hmrghilhdrtghomheqnecuggftrfgrthhtvghrnheptdfgffettedulefhfeekheetgfeg
    feejveeikeeffeeikeekhfevieeltdekgfeunecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhes
    fhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:EXbFaezCvPnZ3XCj_LeZG7SXxqImtDuzG-TAARFZ7Ae2T_NWZTb1ow>
    <xmx:EXbFaYNP6W2O1pPTrQW2vBM8huqO7k3LhLN70ZZ3f8i4puqKAaORcA>
    <xmx:EXbFaX4KUToy1kWTDW060Ku3vXLJesMOGPHCAIaEXzmAGWQ35he52w>
    <xmx:EXbFaROXrjGB-8ExrqNkw3-exU5blqFaVlr7bADB3kKV_KEk9tghSA>
    <xmx:EXbFaX5lstMHNv8GSByaJAlLkiClik2ule4a73cPk7TY-mgD3RYMMgwh>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 9F2441EA006B; Thu, 26 Mar 2026 14:08:17 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 26 Mar 2026 19:07:57 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
Message-Id: <e33142cb-1ec3-468f-8080-ba3bad79ae25@app.fastmail.com>
In-Reply-To: <xmqqldfgy1ye.fsf@gitster.g>
References: <xmqqldfgy1ye.fsf@gitster.g>
Subject: kh/name-rev-custom-format
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 25, 2026, at 05:20, Junio C Hamano wrote:
> * kh/name-rev-custom-format (2026-03-20) 2 commits
>  - name-rev: learn --format=3D<pretty>
>  - name-rev: wrap both blocks in braces
>
>  "git name-rev" learned to use custom format instead of the object
>  name in an extended SHA-1 expression form.
>
>  Comments?
>  source: <V2_CV_name-rev_--format.51b@msgid.xyz>

I=E2=80=99m working on rewriting the functionality in the form of a new =
builtin
git-format-rev(1) that lives in `builtin/name-rev.c`.
