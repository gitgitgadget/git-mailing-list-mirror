Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B231E201E
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 20:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729543677; cv=none; b=YupYvlsb5M73qnUnX8mP/V86a6JU1puuBA7NGQJg9+/zwvvMaV8C08nyIHz9IXCLP9qVf/3wgNZk49G5BCkHGvKeMu74Jo+dyxxY1msJ4MHIkQ4o2tWYoIVWLecl9/WUlulrmcyyBVGGL01Ji/0vU8q51ponVQ50H3+5pQsnQr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729543677; c=relaxed/simple;
	bh=Y/V3ncOZU6ezzelD/qVVtNyJGj73RAn9yaohB1zn4MY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FOimmZwGVnn3eebA0equUtP59/FkNC7krSULlYQ8oF9RnaDS2xEvN1hei6GeDACSTsfmrHAz8ikkBNLJr984g2sOlJVyhElLmTlzP7lMiyXyc1goHpxvMyTGon44WXsVPwSnrO9YJLP/kPdIsUTu9Vt7fDT56VBpyf4gwTTnQ4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=PwNMb8VA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oZ0Ig+Bp; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="PwNMb8VA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oZ0Ig+Bp"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id E37551380457;
	Mon, 21 Oct 2024 16:47:54 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 21 Oct 2024 16:47:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1729543674;
	 x=1729630074; bh=828TwMVvnPOadAP5izEAN6CNFhHxv6U+AxTZL/xZLIU=; b=
	PwNMb8VA5uqoHUd0VHtwJTPVY3raEzOwrlZVkAX+2itpz1sIUEmtLdzheEnCi24J
	FS30wLoJOOqh7lIXWVqZ74sPv0+ku8KQs0KlxlTBKEVUbvMUfIDn9+VNNpeGKl2P
	BTdTdTYbTK/2hhYH5n63MMQrSvaI9m7er14hXNzIbYSFUsiJQuIeezKtX0y5wH61
	YaA9t8eKvPQVrFozWJLkoQxWgbjYuoB23ayl6ZJAWhd1URGl8Agt3LeKWqz7clm9
	pxSu/2QSwJn0X18Ivuqsm16gufZEOq37VcGtn5z+3WsaURXbzbfy9N6qzdamj/NK
	kHwS6Evn+X6G1i70LBI5Rg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1729543674; x=
	1729630074; bh=828TwMVvnPOadAP5izEAN6CNFhHxv6U+AxTZL/xZLIU=; b=o
	Z0Ig+BpoK6J/hD9eqW5+0iBRHtYdSoVOSOc//s+AIS9NRcpO8F113vH0UV4oyGRs
	qBINnK5SrJIR94xL8PZCteSm2SdQlMtvCDHyVHQzWYYMNsHowUUZ2woUPmkDv2XK
	fjdAWp1n3IIcUDzZ8OYAdfZHcqvhRmPvsE1H4ABd5unMoF+aA9QTjjqYPWqzZeK/
	rCj71w+BLxMQrxVrLJy7TpKjQ/1+ANVEPGFLwcR7LTy+U1Bzdc4MXl4oFRKILSk8
	BmfGNlcuMP2WatQ/HyJ/0SAr4GSJtwshZvb6SPMiyJVMFqX6KxArqqtPjaI4pxeh
	h/EgxIHGRz0hBQIpI4UGg==
X-ME-Sender: <xms:-r0WZ7G0ecfyxxtUy4BojUBEPVDJN6yZMI_KRd9-OeLRISiK4H-1Ei0>
    <xme:-r0WZ4URS6Bxl6wsmLXgUxcdXQH1gYpUvyLDBGznsT40bWCQjR1KqxYoTjTjgQnH3
    WicwflsAs7WuKnuHA>
X-ME-Received: <xmr:-r0WZ9JLsCUuM9XKcQGI0DwkbiJ3POwUJqWvV_pIy23mFGyxOblly0kb4_JDnxDeTKGmMqeRIXrE06TiKI7V-vrRtkNEspKppbUK_QyH99MyN-AZHsJHEPkP7A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehledgudehgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvve
    fufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpehkrhhishhtohhffhgvrhhh
    rghughhssggrkhhksehfrghsthhmrghilhdrtghomhenucggtffrrghtthgvrhhnpedule
    fgueeiueetkeelieefgedufeehteekhfejffekvdeuhedtvefhkeeikefhgfenucffohhm
    rghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshht
    mhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptgho
    uggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhrtghpthhtohepphhhihhllhhiphdrfi
    hoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghpthhtohepghhithhsthgvrhesphho
    sghogidrtghomhdprhgtphhtthhopegsvghntggvsehfvghrughinhgrnhguhidrtghomh
    dprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehsuhhnshhhihhnvgessh
    hunhhshhhinhgvtghordgtohhm
X-ME-Proxy: <xmx:-r0WZ5FgqrY4o7eB95LHOcQoyT3OGG-ix0X5dOI4clJDcT53_QIrkg>
    <xmx:-r0WZxUoPdnZRtokZlZwZR4gxYRuMdwqvp1LTZ6hF9Y26jCCs_vNnA>
    <xmx:-r0WZ0OLTxvi0fagYJ9nNLcHMb8j78ghCmhVCkeMMjAvq3awZX0mxA>
    <xmx:-r0WZw0PXgZqO4JhZuYuVuhc-Rn9fOzmSlIgKTMS_c9dEV1bdB5EZA>
    <xmx:-r0WZ9rMMUXrZSPjtfiNxxIW4g2iM9MPbPNKhKPIE97CVRtvCx4hsWWc>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Oct 2024 16:47:52 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	phillip.wood@dunelm.org.uk,
	gitster@pobox.com,
	bence@ferdinandy.com,
	karthik.188@gmail.com,
	me@ttaylorr.com,
	sunshine@sunshineco.com
Subject: [PATCH v3 1/6] =?UTF-8?q?Documentation/git-update-ref.txt:=20drop?= =?UTF-8?q?=20=E2=80=9Cflag=E2=80=9D?=
Date: Mon, 21 Oct 2024 22:47:24 +0200
Message-ID: <9c40351950fe8b8735965f538d6b2ae830fafb1c.1729543007.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.46.1.641.g54e7913fcb6
In-Reply-To: <cover.1729543007.git.code@khaugsbakk.name>
References: <cover.1729367469.git.code@khaugsbakk.name> <cover.1729543007.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Commit-Hash: 9c40351950fe8b8735965f538d6b2ae830fafb1c
X-Previous-Commits: ad9ee00a2a971522968f95dd413deae24839ef71 91c1cae32098e82033f9b20ead6d1bc8e315da22
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

The other paragraphs on options say “With <option>,”.  Let’s be uniform.

Also add missing word “that”.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v3:
    • Also add missing “that”: “after verifying *that*”
    
      Link: https://lore.kernel.org/git/CAOLa=ZTJqcEOQm8Ns58t6DxEXYn2ws__HDRRAaAhsBkJJFLXmg@mail.gmail.com/
    v2:
    • Message: tweak
    • Not done: paragraph wrapping.  I found something else in this
      paragraph: missing “that”: “after verifying *that*”.  I will fix that
      in an upcoming series since there were four other missing instances of
      this word and I did not want to add another patch to this series.

 Documentation/git-update-ref.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-update-ref.txt b/Documentation/git-update-ref.txt
index afcf33cf608..a2bee2ea24a 100644
--- a/Documentation/git-update-ref.txt
+++ b/Documentation/git-update-ref.txt
@@ -55,7 +55,7 @@ for reading but not for writing (so we'll never write through a
 ref symlink to some other tree, if you have copied a whole
 archive by creating a symlink tree).
 
-With `-d` flag, it deletes the named <ref> after verifying it
+With `-d`, it deletes the named <ref> after verifying that it
 still contains <old-oid>.
 
 With `--stdin`, update-ref reads instructions from standard input and
-- 
2.46.1.641.g54e7913fcb6

