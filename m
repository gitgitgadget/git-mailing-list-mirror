Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1BFE2D3EEA
	for <git@vger.kernel.org>; Sat,  7 Feb 2026 21:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770500694; cv=none; b=lUgkugtkfruJa/owkqyS+L6UXn5BdZdAMqVnz3720q4VyygSiI+SGSvsoYgZxhCd+DjR2c+rEcmeSD37gagwztcm3Qc4xv/E6L1JKnQjHSv24Y8krBNETlP8ASetMS3GUnXz2ldwfhO4sGciel/EWNiIoGnVaJNrq4H2D5E+oAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770500694; c=relaxed/simple;
	bh=RuWE74SKDodbeYyZz9PxnZ4O2FwAiHrGVajFNmh59cE=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=nCrYE9eWg+AUsLGHWcwdfIVqcpPFShlUdU76yihXPwtL61MOmSdAIXTt3++uLcgj2mCH8smQ1EemJo8Ij4kIOTzqXMyT2IPub6qSQzvc+3bgSKnwG3AJ/vpq6irgSHVhalHfTi3P+RsP1iLJ9+ebw/87IZE5cXi2V1fy6eoWPu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=HX9UxPZi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZHw1F+cT; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="HX9UxPZi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZHw1F+cT"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 37548140009C;
	Sat,  7 Feb 2026 16:44:53 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Sat, 07 Feb 2026 16:44:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1770500693;
	 x=1770587093; bh=a9IHXM8VEq0pPQMnWhjod7sCWDgVO6WAL3dq06Ountw=; b=
	HX9UxPZi/o4DUUfjMmKsi+pBZWJDtk0b6ppNdbte94IxTS5PfeR7xLfku3I2lcqS
	kJat/VBE6bfTVqO1uCa4dL3ohJnoCnuRoj4hf2Bu68+ohRZTkiQx82VigOBpfzpq
	my3EixT6c5v+rS/JJfisUXkZtvUPwAtxd2oDfHWZ+dp7T8FlSRzz/PrEsDJX4mch
	TKUKT+rKUbDUJd2U+sLbCsFAHrsUTqyhp1SzAccswUMGWFmgoKaopdNXo2XMeDcA
	PqLD0Nt2KXy8RK29jbllaZ9hl3lUUgk+/FybXd3fBZGK9VExvcP29/F30iy9AGgq
	HZHaQhwcvmoCWle9tuIjyg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1770500693; x=1770587093; bh=a
	9IHXM8VEq0pPQMnWhjod7sCWDgVO6WAL3dq06Ountw=; b=ZHw1F+cTtCls51DXp
	ehDfL96heEOr+lPoWd86C7qhLLj+CH1lErulpuEhQs+mGALsOZueZlAf8kwbXvcr
	SEQjngO4FZEWrtP+3GE2NAChe6RBjabOQbZIrQezRGEdyNg+t01fSwF6tlICmTPB
	iNkkmPd8n5XoQyRenxnwtRWkDxAhIpZnz4pPd7WGKT4AXj444LRI6TGXO3xcN1gf
	guZEzsDUeBBq86RhSOe9qiUnBM8hYGK2uMf+Mt0/MUkOuZjRFwp2pvIUTVy0j3i2
	h1pV4MV+3acIV8X4772cSgzazHyGhJUpUtEmjVm3VtQBkFX9utCfJ9R4MSRdWeb4
	gVOHA==
X-ME-Sender: <xms:VbKHacouFv0ARW3ja1_YPXR3FOODGSka_K7nuw8T7Gny7D4nFmUNFYM>
    <xme:VbKHadc7QtrNyuunjXXjd8WzkElvExx0aEOEkAcmsrus9prL4YivEsF_pozZHWZ_G
    X8-XTMJYXJRhY_pe_Ge87d-2ekwEpv1l2_qW2kBDaj0YrWK14Sohg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduledvudeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefoggffhffvkfgjfhfutgfgsehtqhertd
    ertdejnecuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoehk
    rhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomheqnecugg
    ftrfgrthhtvghrnhepffejkedvjeegieegfeejkeegleevheeiteettddvvdeghfegheeg
    leelleevffdunecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepvddpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepmhgrihhlsegsvgihvghrmhgrthhthhhirghs
    rdguvgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:VbKHaXXc0V0k_t8IqIXuHbMoPLz37MHuwWi5OCy0QDSdZLMHITMF_A>
    <xmx:VbKHadhEIljtyGOo_lzNUaCc3CFAmYE0o_rEtBm_4TTrlGXBA3t9Sw>
    <xmx:VbKHaa_dVwFg_VXHWN-pMISKSGdmYfI-OTx5ANUGxz-c0dId34XoEw>
    <xmx:VbKHafCIgECFiwwcgkVmR3YEA44FvsPwn-Fis5CZRQqzxp0_nAk3Jg>
    <xmx:VbKHaa5z6ARqDgdsUuRe4w7Ll5XITnaR6_jLPNvoN2WVncfkgdMlMXVL>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 10CA41EA006B; Sat,  7 Feb 2026 16:44:53 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A2RKoXrlnTsZ
Date: Sat, 07 Feb 2026 22:44:31 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Matthias Beyer" <mail@beyermatthias.de>, git@vger.kernel.org
Message-Id: <2dc92f55-c252-43db-a412-342fc8d45e4c@app.fastmail.com>
In-Reply-To: 
 <bcqvh7ahjjgzpgxwnr4kh3hfkksfruf54refyry3ha7qk7dldf@fij5calmscvm>
References: <bcqvh7ahjjgzpgxwnr4kh3hfkksfruf54refyry3ha7qk7dldf@fij5calmscvm>
Subject: Re: git-am applies commit message diffs
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 6, 2026, at 08:43, Matthias Beyer wrote:
> Hi,
>
> I am not sure whether this was already reported, searching the lore did
> not yield anything for me, but I might have overlooked it...
>
> This was just posted on mastodon[0]:
>
>     PSA: Did you know that it=E2=80=99s **unsafe** to put code diffs i=
nto your
> commit messages?
>
>     Like https://
>     github.com/i3/i3/pull/6564 for example
>
>     Such diffs will be applied by patch(1) (also git-am(1)) as part of
> the code change!
>
>     This is how a sleep(1) made it into i3 4.25-2 in Debian unstable.
>
> TL;DR: If you put a diff in the commit message, that diff will be
> applied by git-am.
>
> This looks clearly like unintended and might be an attack-vector, righ=
t?

I have an idea for a proposal to note this in the documentation.
