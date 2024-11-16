Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE63939AEB
	for <git@vger.kernel.org>; Sat, 16 Nov 2024 14:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731768965; cv=none; b=GIE/oocN4fpx7gMgQINIpOE0dvJe+ViGHuQN+Z6qPDcxtR9zCMqmWnElBxPo3ro38sjnU13A7jjaJQxt4slN+z2IhNcvfnY7dl9n8Di+OzWclmdxt+3qaA8V2DHgZMAVg3cXI6sHOdEnS6B4PLhcKqLXzsqTh0XCZxVeEoScWNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731768965; c=relaxed/simple;
	bh=Fk68GoRz/RT+T8JshBs68BTx5krzlabaUnPTMpnpdOg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J52s+UEzlA5v34gNRlvtVgYGivhYrYR6OjkG13lEYt1IVa1FjGY0PPUsWJATQRCHEnxv0gJbXK9BWKo8XaEb6t6LRLhmyulwpjALnRzVoOchtDUoDWziutwJnPE+m3ifFcyxUACZNhrNlVt9pi9XIXn6ktFwHFRO6TIihkypulg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=RDhND7+B; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SMTfxVL3; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="RDhND7+B";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SMTfxVL3"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 008EC1140085;
	Sat, 16 Nov 2024 09:56:02 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Sat, 16 Nov 2024 09:56:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1731768961;
	 x=1731855361; bh=bBDQZ4dWqtbmm1vwJ3MAj34IPKlUIih8354uxmk2kI4=; b=
	RDhND7+B2Ih5bJf/PhV+f0+si2C5jigJR9SCXDPYcj5UpKeU5fRLmZoACfqfO9+r
	TPCK338ccaEQ9zPQdw0/jKyQ4CBSOyaGDxq5TOPTU+CyUlsFQfhCtMlUuUbjeHqH
	C9uvh5BY14Fzge8RnEtq/1p8RseZxsKNdTLKDHRE4cHHlthZJzvtvxU5WHImyHTO
	SuD6dnMUG8Fm4FLDI8FiVnfu015D/WPZg9r3J94XB4y/k1UiDJLQHScV/4XwcB0m
	nPR7A1YNsCpBsOdBxr2dkoRJ3bTtwnCzQo8tTIx/e9Q4udVA9mAbn1kG5/eAjGR9
	ZZPtPKX7hEM0MnSz0nc5IA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731768961; x=
	1731855361; bh=bBDQZ4dWqtbmm1vwJ3MAj34IPKlUIih8354uxmk2kI4=; b=S
	MTfxVL3BE0gx/+SP8S+W4o92eijSLjcSRJ69e7YAs7mBYKW9E8SkbgYRKeuUckkE
	F/OeylWSqXPBvggjj9x0mhLEzY4+P/fKhUEbExDx71JYKIpubABlg2X/9wyq6uWC
	TSDq7ApVY0FpiYZ9hAVUJdhYuepIn53LF8vdv9NnfqOL+7Zf/zfUNrYASG0OCUKk
	7fPBJ06D7jI9oGXv1POCN+KXdPcPiNae4SC2ziffSatYGL+ggD4WHD5LgJ7ep+3e
	BfwbY13jUrKEzbP+jAy+6Pq1rUAjLJg0iKKyHVXm11tgwkAOJr9yH1YmVXtR3Zqz
	8w1qF3jfJfJcg/AsKqPxQ==
X-ME-Sender: <xms:gbI4ZwrHU3GEF58BAspQlf6eg7n4zug9NWgE0RA8TmRSAaMMHo6ocpk>
    <xme:gbI4Z2rXrPbaVvdz1zIb7STe0YwpAGbtojXDlfKUpLqUYzDVkDw8Ja5rGuibdAjEv
    K0-pven_75771vkIQ>
X-ME-Received: <xmr:gbI4Z1NMOcoRbEOI5OpQTm0sIk9E7iYbb_Gtc1Wp3IWMQSTw6MBjqz8zrKD3CkDD5yw8ooEFVnhsnf9uSALU3eoRrTByaxOcGSeNqLBTgtSAjA378vjfDbKC6Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvdeigdeijecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefuff
    fkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhenucggtffrrghtthgvrhhnpedulefgue
    eiueetkeelieefgedufeehteekhfejffekvdeuhedtvefhkeeikefhgfenucffohhmrghi
    nhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgr
    ihhlrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghouggv
    sehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhrtghpthhtoheprghvrghrrggssehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:gbI4Z359XzDDQWzwoUfjvEJAhXeDd0lxI4AionkT3maDVNkn-sNYVQ>
    <xmx:gbI4Z_5m05M23xdBwYb0nQ9YiLXoE9xu0DsFWe8uREkNqQTOC62s-Q>
    <xmx:gbI4Z3iqmZZXCJDC5aAOeUs0K-aXB7f3674XR7kRkeKEUIvRORcSzA>
    <xmx:gbI4Z5720tdedGuJDjQtLpb_MqFEdq8nEPsf10lmZ2uWOMnRV39ghQ>
    <xmx:gbI4Z1TWZNUIOcu_YUpHejinSMQKS3OE_yZd4EE7OHGgYLM4kB1sonPD>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 16 Nov 2024 09:56:00 -0500 (EST)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	avarab@gmail.com,
	me@ttaylorr.com,
	gitster@pobox.com
Subject: [PATCH v4 2/4] Documentation/git-bundle.txt: remove old `--all` example
Date: Sat, 16 Nov 2024 15:54:52 +0100
Message-ID: <7e9f320fadeaddb4b402fc1e03d95f0ef5fccb0f.1731768344.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.47.0.317.g7d2562b9734
In-Reply-To: <cover.1731768344.git.code@khaugsbakk.name>
References: <cover.1730979849.git.code@khaugsbakk.name> <cover.1731768344.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

We don’t need this part now that we have a fleshed-out `--all` example.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v3:
    • Moved over from previous patch
    
      Removing this mention was first suggested in the following link.
    
      Link: https://lore.kernel.org/git/ZxbIWEGS1UB3UIg+@nand.local/

 Documentation/git-bundle.txt | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/git-bundle.txt b/Documentation/git-bundle.txt
index b9eb9cef2f8..917d39356bb 100644
--- a/Documentation/git-bundle.txt
+++ b/Documentation/git-bundle.txt
@@ -202,8 +202,6 @@ It is okay to err on the side of caution, causing the bundle file
 to contain objects already in the destination, as these are ignored
 when unpacking at the destination.
 
-If you want to match `git clone --mirror`, which would include your
-refs such as `refs/remotes/*`, use `--all`.
 If you want to provide the same set of refs that a clone directly
 from the source repository would get, use `--branches --tags` for
 the `<git-rev-list-args>`.
-- 
2.47.0

