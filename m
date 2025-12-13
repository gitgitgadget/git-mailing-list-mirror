Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89EF7AD24
	for <git@vger.kernel.org>; Sat, 13 Dec 2025 01:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765590393; cv=none; b=gOsCOSV6QyIfjYBdMl/+X+ytoBL3szQHNLI151T10xRVM80dB3iPARZqzyMWEH3Z4Yj3LSqkTnxV9tXgdFGsVtdrItVcb/SzipdK3DZhKN7n1JnMunRpQPzJMOg1aRL9W3T9YiSp3d5IQFCSYPXbxgrYalp2zX206EfP9JS6Oko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765590393; c=relaxed/simple;
	bh=vDUi5lthCQdWfmQza0DG0FI+LgbeFiAquGm9BJz56GU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Zy2i3ALH0ttFkLBZvYrWEhW/2cxyyQ/ejJOTV+8jfNfWJRJusFgvQsw0gXhV8ZYuVJpeN+ji22ofhWTZhnDdY97pcy9NFkWzrhDgLiwnTvtRHVAtcJQN8P44K7D0M4BNJ2iWRRLWEruv761XHJuUp4TmLh0Vtbgl3tvIgCZ7k/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=f6D6x6ag; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Wo7dqYPj; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="f6D6x6ag";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Wo7dqYPj"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id BA412EC03BD;
	Fri, 12 Dec 2025 20:46:30 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Fri, 12 Dec 2025 20:46:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1765590390; x=1765676790; bh=iyycoqSgkW6ah8vV6pAhc
	fNV44I+AbzbKvU10GeEeMA=; b=f6D6x6agsE27tfs9Xfouk8jbPgl6EPqLMhhf0
	wKGyzSr8pG/sTeHh0Ju4/fH7llMYWg0fK692RhvKn2fcOWb5GbGcwHncpe7Z6I9Y
	/rzNDpceUVdEWAe6Zr6lMRYJ9A6vWK61+BfzMeUK7c1WnBLgieV5z6EUiT8Y1OjC
	73HuIiij9groXgYeBxucSOgkpTLWvBMiQQGdulAap983BQL6It20czQr0v5jU1cn
	jHIQXN5hB6VTY4AvsY59Ve1KQ4b+sRTx5wpcWBMQSTVnySTS10pqcXdpdcs1QS3t
	d0DYUEz9fkVyepNqGI9u9jNEeoazWmQe9fEv+eMQ43MzB1xWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1765590390; x=1765676790; bh=iyycoqSgkW6ah8vV6pAhcfNV44I+AbzbKvU
	10GeEeMA=; b=Wo7dqYPjdI3PJrOJpX2lghejSswWBZToVoIRjaFINRxFgbTOSuS
	vt6vOk1yJttQd8VYTxrXmdAOhbsJvnB4LbsnlhMmhBM/NvNhSYelIee110WuphcZ
	Sks08KIOZaaArR3LKwgToNttQPtGGwHAq33PApADa4l69XKjy9jhR15l5Vd6tb4h
	kEeEyCo9yZgw3/IymaC8oCEpKbvg3Qg5+O6mYnppugIGWqOfkGIZ9x7PGIpIjYAT
	E9v5ecSf/6kvU4e2+FcK0dgOgVOEY5KoruXa9x/cfyUxbcRUz8jnqa3F4uwm1ng9
	wM7kIPbx9llfobCmWZQc59wneDMGlojckzQ==
X-ME-Sender: <xms:dsU8acLjV8yAXE0QYt_IDUT3Rd0oFpk0H_xUA5Ol7aUtYhXW6iBrsw>
    <xme:dsU8aTk9ttxdxURI1xFzewHVXq_wYtv3zyF4jTvMEN_h_SMbP8TrYZCbjQUnhqLSJ
    cZFLKHv3yizo7y88dvPfKSu85csd6LTaw-l7u0sWmNzaUVmpjMr0uM>
X-ME-Received: <xmr:dsU8aaFPo8fLGr2XqTOdvOAi1VM94cNpWIsUPYpxAPbKEqjqh1MC1XboE67ZkzwGzv9sxuP2PuVGKTMvOfS_m4c6ZdQf8UeVxw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvleejjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefluhhnihhoucevucfj
    rghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrh
    hnpeeludduudehjeeljeetffegheffteeuhfevhfduieetffejgeehudejkefhheekieen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtsh
    htvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphho
    sghogidrtghomh
X-ME-Proxy: <xmx:dsU8aTERSqlQ0jef3RhXsb3jGertRjcUwStF1dE12w1Ebu8xCYIFNg>
    <xmx:dsU8aXPTiGGb3mXtUCFkwjEWtXNTAxHyVqlKkKPc495GH-au1Yp00Q>
    <xmx:dsU8aSHb0CfwbH89pC49tVegJc2ADV1JZNJr3EekIOBZT7cBSoSjKg>
    <xmx:dsU8aeP8C6fksqVX0PhNKK94qPDQc4f4S6VEpRF1yS1Yh1EbQ_9ZXg>
    <xmx:dsU8aUOWfKMQCjhdYXJauVDVQSHQ2SYe7RTLxCsbRM9p0_YghjqJzsgb>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Dec 2025 20:46:30 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>
Subject: [PATCH 0/2] Use MEMZERO_ARRAY() a bit more
Date: Sat, 13 Dec 2025 10:46:26 +0900
Message-ID: <20251213014628.3380826-1-gitster@pobox.com>
X-Mailer: git-send-email 2.52.0-357-gead5eaf5b3
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This builds on Toon's memzero-array work to make "make coccicheck"
pass at the tip of 'seen'

Junio C Hamano (2):
  coccicheck: emit the contents of cocci patch
  cocci: use MEMZERO_ARRAY() a bit more

 Makefile            | 2 +-
 diffcore-delta.c    | 4 ++--
 linear-assignment.c | 4 ++--
 shallow.c           | 4 ++--
 4 files changed, 7 insertions(+), 7 deletions(-)

-- 
2.52.0-357-gead5eaf5b3

