Received: from flow-b1-smtp.messagingengine.com (flow-b1-smtp.messagingengine.com [202.12.124.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615944B95B3
	for <git@vger.kernel.org>; Tue, 22 Sep 2026 20:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790108537; cv=none; b=QF1PmXJp2xS4JJHN22v+MEvyy4WKI1w5Egxcy9NRjInDQfI/h7VevsuV3J0IQJWAQP+/J4A3U7dItKpjoYghm3vWwDNm3ibny40WpQQlHjvhUGSiQ2EvqyIbWJboPg0oN1hmohMtTIFHmH6ge/acInN7ZISgdNvLNHMVmGKV4Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790108537; c=relaxed/simple;
	bh=IeNQHPUu8y7nDgIKJAYGpGS+iC9V5MPY9pec+20CNgI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YKr8CQ0fi1kWfHlIF2Zr7PGqsEtS1KYQ2qY6NK6ShYpOyl1p+FrICqUikSSeoiJOhHHbmFLjH837U7Ie+9EfgAKNmMCiKXoHk/Z8GSGAGAR0uhebG7+QtuUDbq7wfK8zj/qYI/ehyJr5CBsOvpTsXnajircdDpLrnW9fNB5g7TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=N7d3nWQI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eT9raanN; arc=none smtp.client-ip=202.12.124.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="N7d3nWQI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eT9raanN"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailflow.stl.internal (Postfix) with ESMTP id D873113000DE;
	Tue, 22 Sep 2026 16:21:54 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Tue, 22 Sep 2026 16:21:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm1; t=1790108514; x=1790112114; bh=VzsESsx1zA5G9bXGcbs2O
	rXu5aV4o9bA2Fz/39AVH8E=; b=N7d3nWQI1tVeLCtmOt+x4NUuFoJEnEBKoo9iI
	x0J0PHJVlv9r7ETs0u/FOHdbHZpXLtgWm3V5T4x+ArNWQik2igni9sJcQsDWRl81
	+cVVKAcX901UV+ZNZn2/uCIc4iSED4q+pEbfhmhujFH6Ofv3h8LvRrmSnPYExLSK
	s8ba8szYS91I62N/eVAzISmicIHH6rKZEWivgs3Jbp7XcVipgqOsg8JMAAxycvlh
	PyDw303Il8qDrFFVZIRc22UH3KQH5BUUN18u2C7CVzcnsyl6R+nGX6TP5EDdxx5j
	sgDNrYDr2j1LQ/jXAQl6H3EBiuHo5GzPohWFOM9MWTRH4GBcg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790108514; x=1790112114; bh=VzsESsx1zA5G9bXGcbs2OrXu5aV4o9bA2Fz
	/39AVH8E=; b=eT9raanNYhAl3Cx3TFg1zD2QJ5v0brAO0YZa0et2hiSQzoYTFKc
	I2XB9k8BuOxq2eAr4RS9hRfb7r/YatbU7y80U6qyNXhU1sJoXOyCXlyU+sJHHiz9
	zzGS0FKWGwI5uThA5CAvlF40TXydE2Z6eJJwe8AjqtYZyF47HFij7d0jZP4z8WSs
	DTu/JYZnbvJ3/IZv2ZfNn1S86cZHwLWEo/2dHupwzNP7aqyh4MKrzgxatsyCdXgE
	/lWVyzHDMLTxH+D/KQ/XA54WQcv0LWLQYDQYkhbLo2HPxBOXe90Yc5PA92HRZxlQ
	Zp41gGfFhXHw2hMKUhBPBRaGeLKci9+R6ug==
X-ME-Sender: <xms:YuOyaqoEd_vdS2mHpomLHe0Jdfwgzo2M-CNybV9zDC1FQgQd30IMvg>
    <xme:YuOyaupXKZFVWtIv2-S35IAKD6XxxDUa5zeDUIn2JnlCviikVnYGQ0Kk7qj5zAoMg
    uByYrFrKi4k3TJKovVHTP7qDAe0u0TjNfRXJ7xDjDiqtekWJ79aHYBs>
X-ME-Received: <xmr:YuOyas2glx_H8wDmDL4-oQaboE_p_yYEaj7sCXx1BAYScyavhnrLrTHi2Gui2gGHQpDYi0Tb0ZH6yDNkqwHQ7u_OaVKBIxfdkooCZCTrrY9gTQ>
X-ME-Proxy-Cause: dmFkZTFodfHVhT+HudPzyYCUDdTkMCSleyNHYTEK8kICfGyawLyJQEBVRMa9d5NBGt2kA6
    Qkl8uJylRrNBqZhBhxhgVyF1o1xrR2/o5rjHSFD1s16x4i/GQxTCQKiVAZtwCp03pMKXKA
    nDDmdRrpTWN7ksxFPKV05ChMhgMwJQTTzVZdZ+T3ydXTGwt6Ehnqauqac0wGUWUB7tk62W
    ZerelYHdeCfDJUb7F5Im/jqXNPJPXOuPYU/9o0BRCGE5MgW4qpZ9st78N78/NJ3eLfp/+I
    gx9fUjfLvA5sMWG7lvdCUrQUqw+/0nBP470OE7Aq/3xwTuo0/LEsIAXP4W4Vrx0N4Ve5jT
    2thIhxf8K7ADvBA3L9e8mf4PyXCHIIfFXDcqii/YN/qMURrej/neWNQ4KzHcfrewjm08/k
    liCQ2nAKEi7d2fVTspvPN3L/cCpvhjM8hwC6HNc5kKJ0q7ERKKZ958tsnVCPuh+USEJiVI
    GF44MfMNpCsCUzmVLfHGdEERnYWlDP0ttTsCHxBLh0yGKUefK5fjfbOMvJdHQQNMAy5FtE
    CK3hluXmAjk2+Qt753DDkJZraAvkWjbyDZDlTeyRjYybxiqfHAmJRHaTe4vcrEcLV1L5MN
    mHBfzt3JUn68cD4fh5Nr1yJFy2yTlR9iLPWGTNDpgvpsxD1PpdTkM9mY+FHQ
X-ME-Proxy: <xmx:YuOyalDu3dhnf8XNH4EJPzx4qrneip6jwsf2zkTwT3Tn6TQJzQLJhQ>
    <xmx:YuOyasfVILZMPdWCp0Vh2osFa2s6UYd3oAe2E2mvhzUV3Gv1rZ617g>
    <xmx:YuOyaii7F0_QnpXAIusTgxQHMUF-xAnnS2pkr5ylmqyaNsqImTGzJw>
    <xmx:YuOyaspStRNegaGMBxZuVeRf2gWPK1FscMalWLkX-vORdMCyd7VKrg>
    <xmx:YuOyagGg86sZeKDS_QYBe6zy9K_bEJ9xqcpyUe2HmV2rLjFvWIX1AGtc>
Feedback-ID: id2564aa6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Sep 2026 16:21:54 -0400 (EDT)
From: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
To: git@vger.kernel.org
Cc: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
Subject: [PATCH v6 0/3] t40*: modernize
Date: Tue, 22 Sep 2026 16:21:49 -0400
Message-ID: <20260922202152.842793-1-markchucarroll@fastmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v6:
- Fix rebase error to separate commits correctly.

- Link to v5: https://lore.kernel.org/git/20260922143119.3313620-1-markchucarroll@fastmail.com/T/#t

Changes in v5:
- Update t4001.sh to the correct commit version. (Argh!)

- Link to v4: https://lore.kernel.org/git/20260918171847.2670739-1-markchucarroll@fastmail.com/

Changes in v4:
- use a "test_expect_success 'setup'" instead of setup functions
- make capitalization in test assertions consistent.
- improve naming of rename tests.
- make all indentations use tabs correctly.

- Link to v3: https://lore.kernel.org/all/20260917195436.1102981-1-markchucarroll@fastmail.com/

Changes in v3:
- Correct cover letter and commit message issues

- Link to v2: https://lore.kernel.org/all/20260910-modernize-t4001-v2-0-ac53e9f5d717@fastmail.com/

Changes in v2:
- Merged setups into main test bodies.
- Removed unnecessary echos.
- Cleaned up here-docs.
- Updated names to modern style.

- Link to v1: https://patch.msgid.link/20260908-modernize-t4001-v1-0-cab3933a173f@fastmail.com


Mark C. Chu-Carroll (3):
  t4001: modernize
  t4009: modernize
  t4010: modernize

 t/t4001-diff-rename.sh   |  89 +++++++++++-------------
 t/t4009-diff-rename-4.sh | 142 +++++++++++++++++++--------------------
 t/t4010-diff-pathspec.sh | 122 ++++++++++++++++-----------------
 3 files changed, 167 insertions(+), 186 deletions(-)

-- 
2.53.0

