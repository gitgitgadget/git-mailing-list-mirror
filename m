Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5170323D7C2
	for <git@vger.kernel.org>; Wed, 10 Dec 2025 07:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765353344; cv=none; b=hJtJzRjPUUhvELfSYetV1QqmH4fy1ehQwIH5vyUBsFg2ZYrKO+zKPmczxJ6HcEGGb+RyWyuWMrLjcEyioph47EZc14lYNcdvbgyfakdZuzirZUg4llA44FKZBmQ0jzov87YwVad202RgVs2EP955OwWi4jbx7FOS/4ZAsALIP9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765353344; c=relaxed/simple;
	bh=KfkrochFuOfUf8X5Cm6MtdSkaQVU/6hhTDjHKPV6e0k=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=sKrh1GIB4uZRRbeH2vWUfd8rrW56+ox270ioiXGeeaVXc1UAT2LGMF+P8uMkxZElbcqZaB8+P2b2KNxTItxZWZrg/BYPMpUiMNTdrFTsav0Uxo0NMeVZodKI+45htLofdb7sbZuflRQ8kxSFLjOB3vOLdaU0kTHz/qjikT/7y7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Hmnvpqkh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sY+tY22C; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Hmnvpqkh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sY+tY22C"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 6E877EC056D;
	Wed, 10 Dec 2025 02:55:41 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Wed, 10 Dec 2025 02:55:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1765353341;
	 x=1765439741; bh=OtZqbjJdyFKL+NMfcPxdVvpy6/fINS7v8XO9LvaGoPs=; b=
	HmnvpqkhleTFTaDZ/G5c5d5udryJ+t/r38sNjp7opDCcM68/1euN3f0M6aoVMm96
	TO58zXzWlkO1Jt59G4TkglUVMtLpERJJVLye2nm56KBCJZflyBDtd+uGdjqVd0r8
	7SVHIrVTkznW1BMSb93VJC8p9O5fd/VKSzkpyT4vdY4MmM46QDFdy6zg01sFsuB7
	db28pkduz/rqRAZokCyi+CsSjnLRnqxY3OoD48GlXjBK3P+24K2HYnM8gPZgw1vW
	FHw5ol04NpPNskheXKD0+sgY7XXR9jj+1yhKXCa//fvEf9SBL6u236kbIMdshV5V
	6j4HR5/UcJKXub+xagYhEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1765353341; x=
	1765439741; bh=OtZqbjJdyFKL+NMfcPxdVvpy6/fINS7v8XO9LvaGoPs=; b=s
	Y+tY22CuIkD+ClG+iE78ax2VdR/MA4Kv5skJfXn/0u0aRGfkxHxzGgugL6AAlQhD
	R/PcD+7GjlZ45D3YDHa2pOsGebJnugf0zlGDkT4wizka1qVCOtc5G4gIEg2qDrMN
	337Q9yRAsVDGYQF7YDoVildqIGvdQEcPnyWfEOLDCxUZBzlKCzwMPWefnSKaZqNL
	U2k6xm7BHk5aTbWZP5Ihh4TZV+enuACR6RmA6nOnCk+DMDri2R/ko0SwzEE/Nyx7
	PC3ciVkoScVlx2Ak47QEWvhJ3mu4hzJObg4ZUV15G4s9NJhirkCr1Nzt8NkXZNwk
	Yrhcn1THbIfp7sqhjonSg==
X-ME-Sender: <xms:fSc5aY1_-XVrpvs66lF6uPyigaQmxhegoXdgSR5WFurO-XJQhtYYfa0>
    <xme:fSc5ad7QXhvTfTBEnlF_cVJua_r0qay6b7FCyl6Uzp9xj_jbIiOY_JjTUQ1GFsAbL
    gQXHBtYrEiO8RFlQimMa548gJ4hti_ao3lZCqiss_pQXhTDZ6T_w4U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvudekkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfghrlh
    cuvffnffculdefhedmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdej
    necuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhish
    htohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgr
    thhtvghrnheptdeigfegjeegjefhheeuvdegjeekleeguddukeeljeektdevjefgiefgfe
    ekudfgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    khhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehphhhilhhl
    ihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:fSc5aYaIF-rfKmKzsxW6gj3k37LlCkMccvavGoi7Mmw6e8xMofyfGw>
    <xmx:fSc5aTgGx-ovMSNJJo4p9Pt986SWfsgsS_mQMbaCyRF1LD41BODSbw>
    <xmx:fSc5aa7_xn9qdxgkphZxkaPBUDPRSqB33M9Qd0nEmMtOwspMHR-peg>
    <xmx:fSc5aa7xBy1nX4ncpye1kbE5IkaiDAQloEm77FzWirtZGpjebZOJsQ>
    <xmx:fSc5aX_vajaknyznEBiZyBT1dDbvOjxvtLRGWBmsvs3RkQt2yQzS_hHP>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 0EE1F1EA0068; Wed, 10 Dec 2025 02:55:41 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AhQdJ9mmpmZo
Date: Wed, 10 Dec 2025 08:55:16 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
Cc: "Phillip Wood" <phillip.wood@dunelm.org.uk>
Message-Id: <39b57721-ab9e-489d-a382-16d9fe94c300@app.fastmail.com>
In-Reply-To: <xmqqfr9jjrci.fsf@gitster.g>
References: <xmqqfr9jjrci.fsf@gitster.g>
Subject: Re: What's cooking in git.git (Dec 2025, #02)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 9, 2025, at 22:08, Junio C Hamano wrote:
> * kh/doc-replay-updates (2025-12-07) 3 commits
>  - doc: replay: link section using markup
>  - doc: replay: document --contained
>  - doc: replay: mention no output on conflicts
>
>  "git replay" documentation updates.
>
>  Will merge to 'next'.
>  source: <CV_replay_conflict.101@msgid.xyz>

This needs a new version to at the least incorporate the =E2=80=9CRequir=
es
--onto=E2=80=9D on `--contained` suggestion from Phillip.
