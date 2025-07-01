Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE752797A0
	for <git@vger.kernel.org>; Tue,  1 Jul 2025 15:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751382907; cv=none; b=k1F31Db1+eGiQ6Z7lwj0Y99c+WUQAEXB26Ee5214th8ooT/eCVuRe6O9T9c5s1O/Y3EhzhWVljgklVo+RoK9861FH9Z4FhQTUTAhLCZ3Yxvu1CXunHzMoOGJ62OtcozmwNKk12GimqYQnpIjaJ9NVU7s2/mHgXsGkk6RKxRfYfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751382907; c=relaxed/simple;
	bh=IxOKgR2+f302B0nVXqz+GxbN3VV+SLOJ2SRjW40qrQo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WEBPtz4V53ACRaPnIE4cVyLlpO3VMRQTN0UVXbSKfs1jDQgscTKXQogITcpQQTkgYM/s6O4xdbkX9kQy/OoEYUhlibH3Tls7H9QK/zLPM/4PRESBEq05cgzXCfcmDIONUZ3+LzYotJiQNz+sJc3wdjbnNw2UZtmV8bJHITHIc64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=wsY+LnWc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=F2eHFXT7; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="wsY+LnWc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F2eHFXT7"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CD1DB1400029;
	Tue,  1 Jul 2025 11:15:04 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Tue, 01 Jul 2025 11:15:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1751382904; x=
	1751469304; bh=6sKt5+mUkWc6mbePyGQ1apuMZQuGbxuw4pu5FNayl5Q=; b=w
	sY+LnWcRlqk+pWnrchH8mVvJR3VATqCzSwEpuydqfUjH/C/yiZEvnrtTvucyq3Jd
	Oh7nri28VS+Ucj4zFa82Nh2idDKvptH2HDD3olTEAqa9xwTnEblG7XRDyHPNOohY
	ACvpVepMTv+GUGHRyA8/iVsxDAcfd32mcmONZsIrMtvFs4jsWfdYF/lLVkz5VD3O
	/KBBYpA0RrR6ednNJ34TXgZkPsvkBCy9IUHR2zivdqXrgcxElkOAJZXb0T4FgO0Y
	lhrwDR5LShTJHNf7A+lGr0S6S1bdzvZo9kZ8RWrmgCMl6fcs0l854xSwVeMdX2R9
	RsZ5ClwhhIzQBCkib5bzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1751382904; x=1751469304; bh=6
	sKt5+mUkWc6mbePyGQ1apuMZQuGbxuw4pu5FNayl5Q=; b=F2eHFXT7bhhQUQY57
	usJ1KSTvaeIvgZKfoV0xay3eBEXOYaq1ILjxSCeJu1KF6KGedVZgxrc1eMi1wSlj
	HX7ZmpLTemN5o2+gtaLZadDom6YBqLVBGyYFdB+DBNJHlBDdBOeNU6N9R8M5gGnN
	tjif7PBrt5msE8jOBylR3qcCir/2fIKKjTDrepzsYuwPFUHfBlwSKjyV2h6PiSD/
	a4OyImqMGkoFxyUyViI9GnGnFAD3zIAA7C0cfMWkhys5XOZnXyaShVIMmREIKW2S
	rYCRMnj121ATIsTENhEmOu1vVWuTISRh7PScfX82RQsHQCyIzanAMdayt5d6hZBT
	zb+DQ==
X-ME-Sender: <xms:ePtjaNfSZq8aBIcjvRroZ7D5CBmvwc96FY5Ng90aRDOOjW8PZ8667Bo>
    <xme:ePtjaLMLXygtea-dYqP7U2o3jwmMY3_S_HVohKUjJ0iHohBtXckrI8xh-B1zJP7sz
    kuqkqFdYiD8aLPL9w>
X-ME-Received: <xmr:ePtjaGglX4-Zkd3XNTmNmv5qIj4Kvv3gubGdKHt_omz22G4jFEw-d_0hFnt7Q_FgbgFnrvaKo0O6xDH8CgGraSL8C5GFcHpdwJTp4nY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugeekhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpehkrhhishhtohhf
    fhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhenucggtffrrghtthgvrh
    hnpedvgfetiefffeejgfeigfdukeejleeutddtgeeileegieelgedvkeetjeehjeekfeen
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhes
    fhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    oheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhrtghpthhtohepphhssehpkh
    hsrdhimhdprhgtphhtthhopehjnhdrrghvihhlrgesfhhrvggvrdhfrhdprhgtphhtthho
    pehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhm
X-ME-Proxy: <xmx:ePtjaG_J4Xec7Dl8sFWyuNhSHyY9miO5iLztADoH4q3HPBxXhExK6g>
    <xmx:ePtjaJtCtBZHd4ceVXdZwMvfw9f9_M5bfPgE236u0GCK8iS2tCtvnw>
    <xmx:ePtjaFE6YvDdBaSRQyRoa9N_CwtNpWMcTsVZG2ivDXYsjgkH-y3sJA>
    <xmx:ePtjaAMsgQ0V-UJz034Ki1MsTGNDcqtKbxaPDwKLbDfHMw3WCTqMZg>
    <xmx:ePtjaD464G9MIfZmGtvkV621mexXnL5CMPWz6-GvpodZiTDf3vCQiv6C>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Jul 2025 11:15:03 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Patrick Steinhardt <ps@pks.im>,
	=?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 3/5] doc: config: document --[no-]value
Date: Tue,  1 Jul 2025 17:14:30 +0200
Message-ID: <c85b42e33310c87102b8543ab214564f7a2a9e64.1751382830.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.50.0.136.g907b27ebd9e
In-Reply-To: <cover.1751382830.git.code@khaugsbakk.name>
References: <cover.1751310455.git.code@khaugsbakk.name> <cover.1751382830.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

These options were introduced in a series of commits from
fe3ccc7aab (Merge branch 'ps/config-subcommands', 2024-05-15).[1]
But they were not documented here.

Document this option and the negated form according to the current
convention.[2]

[1]: `--value` is a replacement for the `value-pattern`
    positional argument
[2]: https://lore.kernel.org/git/xmqqcyct1mtq.fsf@gitster.g/

Acked-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 Documentation/git-config.adoc | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/git-config.adoc b/Documentation/git-config.adoc
index d3ddc538555..03808b18d3e 100644
--- a/Documentation/git-config.adoc
+++ b/Documentation/git-config.adoc
@@ -200,6 +200,14 @@ See also <<FILES>>.
 	section in linkgit:gitrevisions[7] for a more complete list of
 	ways to spell blob names.
 
+`--value=<pattern>`::
+`--no-value`::
+	With `get`, `set`, and `unset`, match only against
+	_<pattern>_. The pattern is an extended regular expression unless
+	`--fixed-value` is given.
++
+Use `--no-value` to unset _<pattern>_.
+
 --fixed-value::
 	When used with the `value-pattern` argument, treat `value-pattern` as
 	an exact string instead of a regular expression. This will restrict
-- 
2.50.0.136.g303b50f9132

