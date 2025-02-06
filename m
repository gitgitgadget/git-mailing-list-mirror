Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D692F2253E7
	for <git@vger.kernel.org>; Thu,  6 Feb 2025 07:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738828344; cv=none; b=QGpwND8Kd3dQU6fNcSSIurhG47CfrNC8t6/V0XWxbsjV7bjbCXJ84DagzvaNbX7KKzjN2C6M7vwEpgKaHw7P86sKmlOTgMuVlZNcxvO+mfNji835rW9RSWtJjdWX7cdkGcUNsaOtur138YArkR5qVlYqNckCn5QJ/Saswq+Syb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738828344; c=relaxed/simple;
	bh=81LTn7UZRORPY2teFOFZFj1OqCLhZ9jWJcErZRHzdVE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MRKXSJq4kcFDJOEGtiTToHPAVvAccqJZWDqDc2bpFkH+t6pPLQzug20zVwEFe1WbIl2QEUbvmusAZ3ylJJgmGuVB2fqIPazGwtePCkfbuQ2NRZfgZQ+H2FLzncYyZe/i4GTXsUWzG5En9ad8qZSC9I1axI4MBqCdcIjtCxDXPwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=IBxKHQkA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=E0+9A/3T; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IBxKHQkA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="E0+9A/3T"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id D1C9013801B6;
	Thu,  6 Feb 2025 02:52:21 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 06 Feb 2025 02:52:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738828341;
	 x=1738914741; bh=nIlvnYQGf294FuH8JnUpltKC/aiSknWtZvi3roloRoU=; b=
	IBxKHQkAFYCL13/Vq7AOYRpq3BGm+AjPqDAQPdLY/rre0SZhO+RRaRbPA8julIdW
	Nq/X7cEsBo9VQRRXKITzf0mL1LuMEEX8yPLJ7J2FUsyvC/nTgOTGZyCqA7ylvz45
	fFrHZ+WLAJgU80bwa0WTE2SBYOrwaaBktHSulIWUMhJlg/hvKnEjw22WkeqGnhC4
	G9Atwl3EEPrHvhtlUYp15wxtFTmeojH2HmkuH6YJtik3xTFRGL+ny7kKYRcIIilC
	JQUl1x21T6CMtFwNqevQbIsAOFM2sIy5iNUQPH/4IejJCMZ9Di4UH8jGftwTkDDW
	Z+YSV+sRLrAyVnmNFghrgQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738828341; x=
	1738914741; bh=nIlvnYQGf294FuH8JnUpltKC/aiSknWtZvi3roloRoU=; b=E
	0+9A/3TY6BijEvJtV/abWUyi1g7CnH97uNjerf94FPQrPnR4IT//PfLHj1wXDAdB
	PVqFbW1IcpFqmmh3MJyqPfGcs/JXY+1qLCl9mSfuqHx7iHXSkN5Woh9fSgS18Nhf
	qLbBLRhY7P+U6cQonNs62ju4OICisuivXc00DgOF5XHHv2F/Yh+aqbmll6wJDvRG
	oW4HUoq2m5ECWJYupguz+NXxRGVB9hg8c9dV9vELSUIZJ2k9e6U5tgVBEQ4KO6Ys
	RAMELpbtvEKGk5RKICM8yAlSxrQZVBr+7GHKu80EZiF8u+b0NGbqurkLZXoiSlV/
	rfZ3vJFGX8zflaOp8A7bw==
X-ME-Sender: <xms:NWqkZwKc_PW1p-doyAqZ1YuHK2aByvyXMocHwpxVoDjH0kgXhHH6AA>
    <xme:NWqkZwJVhoYy-NWHw9dfMNhXv61_Nh7oE3f2gkHSiKz2Omr1f5OvaZ1-mMHpIo1lL
    RQUnwFrzdecv2Hv5A>
X-ME-Received: <xmr:NWqkZwtWygiM--0advCWMCbmlqtnKdm7H-gbDn07Q_XPwbCTD4DeGtQ41pvQFLpNkcM-5dQUvKEJS1Z8KGTHQn238BnHi0d9G93LOUCh0jG7>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvheekfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepjheitheskhgusghgrdhorhhgpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghr
    sehpohgsohigrdgtohhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepvghthhhomhhsohhnsegvugifrghrughthhhomhhsohhnrdgtohhm
X-ME-Proxy: <xmx:NWqkZ9bwe6h2MGIAifnBo43WzqTLy4I7_TX8Z0PNVLCrBxwqnqyAWw>
    <xmx:NWqkZ3aTsezuxeAJRmfudMWg0L48r_FLY-RNE5xaE6wKTGfHLk0NYA>
    <xmx:NWqkZ5Bpxhd8GRaD1HAMNwGg4lyWu1IQi7X68zDKVZoFFw5XxjlFYw>
    <xmx:NWqkZ9bjrwXD6eYdXtm5maWpk8rQ2aWgNNCR6-NypinHzK9V18V9TQ>
    <xmx:NWqkZyxqzmsdX1ZKCAfAbJIHDbkB5AWMD0aDizv58l0niagshV8CyPrf>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Feb 2025 02:52:20 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 19c5ad3c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 6 Feb 2025 07:52:15 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 06 Feb 2025 08:52:03 +0100
Subject: [PATCH v4 01/18] reftable/stack: stop using `read_in_full()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250206-pks-reftable-drop-git-compat-util-v4-1-603d276d5f95@pks.im>
References: <20250206-pks-reftable-drop-git-compat-util-v4-0-603d276d5f95@pks.im>
In-Reply-To: <20250206-pks-reftable-drop-git-compat-util-v4-0-603d276d5f95@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 Johannes Sixt <j6t@kdbg.org>
X-Mailer: b4 0.14.2

There is a single callsite of `read_in_full()` in the reftable library.
Open-code the function to reduce our dependency on the Git library.

Note that we only partially port over the logic from `read_in_full()`
and its underlying `xread()` helper. Most importantly, the latter also
knows to handle `EWOULDBLOCK` via `handle_nonblock()`. This logic is
irrelevant for us though because the reftable library never sets the
`O_NONBLOCK` option in the first place.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/stack.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/reftable/stack.c b/reftable/stack.c
index f7c1845e15..d57acd9540 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -115,13 +115,16 @@ int reftable_new_stack(struct reftable_stack **dest, const char *dir,
 
 static int fd_read_lines(int fd, char ***namesp)
 {
-	off_t size = lseek(fd, 0, SEEK_END);
 	char *buf = NULL;
 	int err = 0;
+	off_t size;
+
+	size = lseek(fd, 0, SEEK_END);
 	if (size < 0) {
 		err = REFTABLE_IO_ERROR;
 		goto done;
 	}
+
 	err = lseek(fd, 0, SEEK_SET);
 	if (err < 0) {
 		err = REFTABLE_IO_ERROR;
@@ -134,9 +137,16 @@ static int fd_read_lines(int fd, char ***namesp)
 		goto done;
 	}
 
-	if (read_in_full(fd, buf, size) != size) {
-		err = REFTABLE_IO_ERROR;
-		goto done;
+	for (off_t total_read = 0; total_read < size; ) {
+		ssize_t bytes_read = read(fd, buf + total_read, size - total_read);
+		if (bytes_read < 0 && (errno == EAGAIN || errno == EINTR))
+			continue;
+		if (bytes_read < 0 || !bytes_read) {
+			err = REFTABLE_IO_ERROR;
+			goto done;
+		}
+
+		total_read += bytes_read;
 	}
 	buf[size] = 0;
 

-- 
2.48.1.538.gc4cfc42d60.dirty

