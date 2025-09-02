Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC6B2E2852
	for <git@vger.kernel.org>; Tue,  2 Sep 2025 06:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756793932; cv=none; b=R5Q/u1FGwCii4ZbO4pKbDZQyToSP5vXDbs6jWttWO2CzDpzspEVZB4ey9jDy0OB32unGSIKfFistZ7NvHI7pAx3xHX8G3F9jFtfbUXoBS+yKHkhSsb0e2wP3FEfQiz2vyixm/Cb1BKWf5Me5ZPsp3SkPLixfmFTzhFGS8ezhfro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756793932; c=relaxed/simple;
	bh=16wRDG26HaOpyyDLAslxnfUCKQck8uApQOFLhHIC9dg=;
	h=MIME-Version:Date:From:To:Message-Id:Subject:Content-Type; b=BV7T8MuhcF1mPD4XjYvcxBRg717rqbP4nZwlHBoWH0mDlFecHRA5OiDZop3i/tHl7tCAOkpkPWNxZbO+FtBMAQqyNajw4sfil+eCOTYncOiUXBDRbtjt769XgZAmsfnkzMlAOw4CFpgNrpFP9ecYPBvojGaQKX1ytIvp6e7z8ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ml1.net; spf=pass smtp.mailfrom=ml1.net; dkim=pass (2048-bit key) header.d=ml1.net header.i=@ml1.net header.b=AJUZOnZa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dZdrBovE; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ml1.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ml1.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ml1.net header.i=@ml1.net header.b="AJUZOnZa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dZdrBovE"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3DD8714002CF
	for <git@vger.kernel.org>; Tue,  2 Sep 2025 02:18:48 -0400 (EDT)
Received: from phl-imap-16 ([10.202.2.88])
  by phl-compute-02.internal (MEProxy); Tue, 02 Sep 2025 02:18:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ml1.net; h=cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1756793928; x=1756880328; bh=it8B0l818g
	gFqkGZWT98nkNiGzELUMXkiENqjAEN/gw=; b=AJUZOnZaxq6bgts987YkP80NoW
	qa1tf01GwJ8he4QMQIUWbmyHHYPrJtSxSNh+Ui1GjZ9P0uCx0/K86fV8fW1bseBu
	BihCcslwPI+Y3eNAB5xrLcCiXuQab7XoylH8YYIqX6fHm8s0zelqdh3prEP1rkBh
	4EnRSxgoSfNFfjACoxapaGH6HXT1Xo+wrIA4Poa1vWKPXlu0cGIwQL2tWSCVBscB
	TxaNyjJVaon/oTpZBUW8CiX3r2TimWkNRZ2I8pKNNBu74wAsC5mCy/amj4wm1qgN
	SVulILx2s5H6GkE4qqeYk7RPRMVbSjhkTXwxwFbPaMf0iVozqswl3lDV9aZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756793928; x=1756880328; bh=it8B0l818ggFqkGZWT98nkNiGzELUMXkiEN
	qjAEN/gw=; b=dZdrBovEG3tkx6OmYcJwVvKB13jSAv6xiG34Enj2lSGrX6KCiU0
	dWK1YrJDoqJ3BewQt0UEIM8t7GraW3kkq73nGabIhB5CGOlG90YgJkRSsoJ75iVv
	7KkF+l9sB7mDVQzd5l8oy/Y+s8WHQIVKx1Mz9j0FRmc5Y1zAQR+gXpdUrztt6BhQ
	WJhf13z/XBX4bpYYdxiluYjiyIpZzhOfurfh++I+K1xNpyHOFaBFSn6V4yaMSjFt
	1v+IfVLB2+T1CKuUkBemFpE6ag9uOnfOquq0xwkgtQybjPKjbOjIvZw0yCLysjwZ
	g7h8lmS0MSXyzrIFygIYr2WjDKNoDVj9zgA==
X-ME-Sender: <xms:SIy2aCb1V1kNTSqF3IihzhBKARUYl56wuI2EbuFS0_svFfLDO54NHQ>
    <xme:SIy2aFahsUsPL3ltdqrbzT7gLCxK1_GpkTIZJXzd_Hl87R8xSaxE98HzIbo_gkrkD
    KD7AAesymD8SjEi>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduleegvdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefoggffhffvkffutgfgsehtjeertdertd
    dtnecuhfhrohhmpehjohhrghesmhhluddrnhgvthenucggtffrrghtthgvrhhnpeegieeg
    ieduffevvdetgfefjeeigfehhfdufeevveetffeuteegudekuddvieetudenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjohhrghesmhhluddr
    nhgvthdpnhgspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:SIy2aMS1ciuF_kJr3hhjqmW1RDDXCIs7CV4HDvnFA746eE4wlt7aWg>
    <xmx:SIy2aOBx-rhMxbzmPnFlvWvZAgmUPc6AOE9nkZMc-AIpY9JgrY-eAg>
    <xmx:SIy2aE2pHMHfRK2bCPcQ7Be5uCdfbC1y2vJvPVXotJR3nzahmc3pFA>
    <xmx:SIy2aEVNSuGZ9j7ZUGMAz-_GoXw7vYd5CIUIACll9H_7G3eDiUFWLQ>
    <xmx:SIy2aDb-TywcxwAK8Ot3IMgEIhfikU5J5qzNI7Y_NYxWcIwlUbF326p8>
Feedback-ID: i470841e3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id F35EC2CC0083; Tue,  2 Sep 2025 02:18:47 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AaL8HUsuz1kN
Date: Tue, 02 Sep 2025 09:18:27 +0300
From: jorg@ml1.net
To: git@vger.kernel.org
Message-Id: <74c5f07d-6376-4787-a5e2-bb09abc58ce1@app.fastmail.com>
Subject: Still using "git whatchanged"
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

apart from what's stated in the subject, I think it's not logical to use "--raw" when I want to see what has changed.

"git log" shows me the log. What's the raw part about wanting to see what's changed?

If "git whatchanged" will be abandoned, please at least let me type "git log --whatchanged" in the future.

Thanks.

Regards,
J 
