Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F08E30BBA4
	for <git@vger.kernel.org>; Mon,  8 Sep 2025 14:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757342158; cv=none; b=s9G+ufx3RV66o554GxjI/PLrzv26tUPhl/q0TvN4rpiIfqYFGrfN9FOJyY9/jiudrOOYzFTKBqKSOqRsTCzJYKoVcgvCy0/NuXzAexPqFu0RhqflUYqOngGWr4DRMKAOmw0qOdRXuyOMmAU/s94Np6Uuu4D9ZsWffrHwiF8teCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757342158; c=relaxed/simple;
	bh=Q84Lp+o7Q/QhTZAVQSytg1AfE7oeYeSdTRiERlK9Mls=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=VUDrd5Yhz+OtrDejPNgGa4ZwCQkq3ZTCUQD8S7r8w7+aCQ1E16tgQqsCpbNkFlaRWoWN0TJr/CtsEm0GloNjgDtZV7vqt1y/Zbx1eKM8EGvRw3gRFDCs6B2VcS+PxGN2CGzWXC4mU6N5nHGNgw8INARfGMHIl4AtX20jusW+VJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=PufW+rx1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=f/PTIJM9; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="PufW+rx1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="f/PTIJM9"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 899CCEC0238;
	Mon,  8 Sep 2025 10:35:55 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Mon, 08 Sep 2025 10:35:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757342155;
	 x=1757428555; bh=VkzEpjn6NidyB3TJm2rJg1ajuAmpyogFO8zqQM3sMgA=; b=
	PufW+rx1DUW2r/b52vmX0rIAxNnHpY4+YcWhVkGSv555m/hxu0PHBEKvwmuy9Dqp
	objmuU7u4QMTJKo/q86aNEdfdyrYZh5ZHKkt1fyH3YRVFLtQw0YDHPoPTOL7nu1Q
	EG8g4kzDeD8WMbHWHEH9/vTqp0fbt9i2zMPSttbzvHGHVGfJwuUNRqxWTiqhgGKY
	6VcLOdHIDIMhBfL1hdZI4NaJUIMOpty0bJnsDY5s46bZllfHT+le9kAXv1fM4jNe
	wXlWoi70Gi+/MuhOqYdw6ffn/B2/4ubZYH70kI3f/TkAkWk4BTvKlSRElwKtR7+C
	QrRltAe6kH4JWHVafDZutw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757342155; x=
	1757428555; bh=VkzEpjn6NidyB3TJm2rJg1ajuAmpyogFO8zqQM3sMgA=; b=f
	/PTIJM93A9bPOS0XH87tSCAk+UTv5gAO4KymzS9pREEKg1BWuw13dM6znWrtsnE0
	RYuk3ZxUZJTluXQJ/ubz0ox3ayJWF8FwgZZGN5JGrULTDOmSc/GgOCOfTuUdZZy6
	3pyZVEfNIVHEwsxMOz3E/5iTOA9sxiDU6cs1vIfM7ognoVvTL0K2TnbhVpz6Ib/x
	P+X7kp+Ks5tpVo4k+EnF4vTBIA3lF6ktcjOYlOIGqYf2Jr2NdKBKB0nyysIzCK5A
	4GTc/jc62YdpS+dCmlndBTwXYOG+IQGfiziHP4HpPNcdc9XhaHMMA4WmNEVH4/Us
	pvG1BxMKTkWx1F6fbbk7Q==
X-ME-Sender: <xms:yum-aLnR8EMJPrGKTnsJhqu1XnHMgmd4YljPJl3Iqc-4cu-yGdsO0xM>
    <xme:yum-aO2dd1bf8GAdhjtd5nZjk6UAPiLymn2FcRd-0hUjKoB-v3sfhOxMYvnTS5xhb
    1Eab1xvdMyPW6yGyA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeejlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpedtiefggeejgeej
    hfehuedvgeejkeelgeduudekleejkedtveejgfeigfefkedugfenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepuddupdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhes
    ghhmrghilhdrtghomhdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomh
    dprhgtphhtthhopehjohhhnhgtrghikeeisehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    khgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehnvgifrhgvnh
    esghhmrghilhdrtghomhdprhgtphhtthhopehsihguughhrghrthhhrghsthhhrghnrgef
    udesghhmrghilhdrtghomhdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvg
    hlihhnsehgmhigrdguvgdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomhdprhgt
    phhtthhopehpshesphhkshdrihhm
X-ME-Proxy: <xmx:y-m-aCfEt0FQECpPdWGnYVBIv6tNLAPYvierMuNdifeTOIkA28Gxjg>
    <xmx:y-m-aE3Su7IgcX7qDj-r6_UCkumHG03LBV_kx_u3xAFh9A8Z-N6N-Q>
    <xmx:y-m-aK-LynQuhOhsaZgzE0QuF2eAOtkY9CtNoMgrYM2haGLEX6gUaA>
    <xmx:y-m-aJ7O2wrh3_nz5KS7XIInh8LOoOWIRqANv4PlqeJ4p1Nqt8zJ1w>
    <xmx:y-m-aDBR2ejT4Qy7xWP64QmzaqZJLW7sr80Kcped03-w29hUBv4QEvtr>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id E617C1EA0068; Mon,  8 Sep 2025 10:35:54 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ArC9uYIrGXB3
Date: Mon, 08 Sep 2025 16:33:13 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Siddharth Asthana" <siddharthasthana31@gmail.com>, git@vger.kernel.org
Cc: "Junio C Hamano" <gitster@pobox.com>,
 "Christian Couder" <christian.couder@gmail.com>,
 "Karthik Nayak" <karthik.188@gmail.com>,
 "Justin Tobler" <jltobler@gmail.com>, "Elijah Newren" <newren@gmail.com>,
 "Patrick Steinhardt" <ps@pks.im>, "Toon Claes" <toon@iotcl.com>,
 "John Cai" <johncai86@gmail.com>,
 "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
Message-Id: <e8bca1d7-96d7-42b3-95b7-6a525fd3f67d@app.fastmail.com>
In-Reply-To: <20250908043620.57848-1-siddharthasthana31@gmail.com>
References: <20250908043620.57848-1-siddharthasthana31@gmail.com>
Subject: Re: [PATCH 0/2] replay: add --update-refs option
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 8, 2025, at 06:36, Siddharth Asthana wrote:
> This patch series adds a --update-refs option to git replay. Right now,
> when you use git replay, you need to pipe its output to git update-ref
> like this:
>[snip]

Both patches introduce whitespace errors.  You can check with
`ci/check-whitespace.sh`.

That script will suggest a way to fix it.

There=E2=80=99s also a `\ No newline at end of file` (I don=E2=80=99t th=
ink whitespace-
check checks that).
