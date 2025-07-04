Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269E72E36F3
	for <git@vger.kernel.org>; Fri,  4 Jul 2025 20:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751661131; cv=none; b=iGXG+9xe8gOTIykfGH6xuBYw1eCn9cIVuD9g1hrUbhovZQ+bIER1KVRxkGeIW6B70OfHF9OF/EePdEtjM/urhd/fryTnTPCRb1AceS5xNQuoAJvRRvgxEAQI2Mf3IrXhOY12FGwO3GTTylkNmLlIlUzjMJbpBE1cN++bMCAMouY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751661131; c=relaxed/simple;
	bh=kSReUY7iPTQSNa92YhzIhLyrHt3j4UMKTk/gGb8OhHQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=bQsPHohppyJhvrMzIUdFlg0VSbUIBfwgJ3PN4Z4Ivoxgi1yImaF4rEkyeOpcQzbyO6EksRJHcPscYhsVUhsJu1NXhtcvgmbVWISaCZJJq1CqcW4Q3ODaOXLjAukba8me0NSWbvsvPCucI/Ln6NAE3QQwzfgvviVRKW6eD2X83xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=KE8uv2qK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Gc2B5+3A; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="KE8uv2qK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Gc2B5+3A"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 22B83EC01C4;
	Fri,  4 Jul 2025 16:32:08 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Fri, 04 Jul 2025 16:32:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1751661128;
	 x=1751747528; bh=XOSmTR1XNmSOx14ncawB627a5QCzp2HxUFQ976eUHo0=; b=
	KE8uv2qKija/ylerWIoAdYEo2iiYRAbYbT2ZdIJF6DMDT92an/SDYJj+t6fIo9rR
	+ss0vEa5pvk9r44PS1K9luSVKZyay6BPHzATOswRGNLfUahM6kQ4DUaOfDgdzBKJ
	clnkVMZcOkOye8158VAV9Sez/C/9sdedbzAwggHtaXm1jPKkSev6ZmBOOrBykM/z
	1bbMyTC1pNKQRaW9Q/761Txmk6jNvheAdku4JEexUG6AU/dFUXgpMJ4cd7gak0j0
	ZV7NCNILEFbKJPq+HEz3w4tJ6RHov24tPUUxIpgADxHfC7ZM1rnQe34E5Zsbw+XZ
	S5SivqZd73AY7hB3EGnWew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751661128; x=
	1751747528; bh=XOSmTR1XNmSOx14ncawB627a5QCzp2HxUFQ976eUHo0=; b=G
	c2B5+3AZPVE/ns5FLxyFGGuCmUlBzMXRVEQjNPPmRbpFt5byszI4J5LcEv4bJ0IT
	JvGrYHSFTHcE2XJuFGiIStvDI45QBifAaxiZjEUDJZ8ertXn6wrdiFStDKVhQ03i
	YE3OfdfmK67w/BAVbhqsyvTrKxCsFOtEpv+/3mVp66d1RrelpAhLyh4WbVsmXgg4
	z4ffaAeGaIdTdaOe1/hb42tdheJbly15aAhr33Q+2MeO3W73ZU++QLq+UiIiIoe7
	bkWs4qeZjFYTvxWJeZ4FaDzLJZI79OH3KxxlNSNuGRsLgmb0jcUgGmwhzY1sSOHh
	Z2qol+ss7h7x08f+JrZxQ==
X-ME-Sender: <xms:RzpoaAM2TkEd3WgiAa2U_wqy6hZa83cmZk2-_KGK4Cv3CiewKA42tGg>
    <xme:RzpoaG_Njb-SHVymKEWrzHag9UYhB3Y9v8v4k2xiiExYtII0fCPS3qchzGUBJuZi9
    uxZzr8qxvxg1otNnQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddvgeduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpedtiefggeejgeej
    hfehuedvgeejkeelgeduudekleejkedtveejgfeigfefkedugfenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepfedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepjhhnrdgrvhhilhgrsehfrhgvvgdrfhhrpdhr
    tghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:RzpoaHSKppH5ze_qheqmEzuN2EUbxUyzeFiFFB5NlCahpfp72rgJNg>
    <xmx:RzpoaIuXICT81iOLy0ezGjllbdrmn5Dg1TymOQy92Wp4m91dEaymqw>
    <xmx:RzpoaIcsbyRzHNEyu3I9IXNFVMmwNMYYoPwFoutT2UKp3lPoQ1EHCQ>
    <xmx:RzpoaM3bsQRIpy9bEi7STlb-alOHhOfzxiZHAdudbo9pEkqZoRCB6w>
    <xmx:SDpoaA94341Zv_y2gaWu9H9L127D52kKZf_ATj99si0sMQePtXN00cPr>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id D9A2A1EA0066; Fri,  4 Jul 2025 16:32:07 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T4addccd1017fcf40
Date: Fri, 04 Jul 2025 22:31:46 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Josh Soref" <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: =?UTF-8?Q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>
Message-Id: <482f4eb0-b11e-42cd-87fe-3ad9e53f7610@app.fastmail.com>
In-Reply-To: 
 <01835272c2e92269ba0e571b29d0756f63fe9c79.1751203241.git.gitgitgadget@gmail.com>
References: <pull.1933.git.1749373787.gitgitgadget@gmail.com>
 <pull.1933.v2.git.1751203241.gitgitgadget@gmail.com>
 <01835272c2e92269ba0e571b29d0756f63fe9c79.1751203241.git.gitgitgadget@gmail.com>
Subject: Re: [PATCH v2 6/9] doc: git-log: convert pretty options to new doc format
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


On Sun, Jun 29, 2025, at 15:20, Jean-No=C3=ABl Avila via GitGitGadget wr=
ote:
>  See the "PRETTY FORMATS" section for some additional details for each
> -format.  When '=3D<format>' part is omitted, it defaults to 'medium'.
> +format.  When `=3D<format>` part is omitted, it defaults to `medium.

s/`medium./`medium`./
