Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B3D261389
	for <git@vger.kernel.org>; Thu, 13 Mar 2025 14:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741875484; cv=none; b=ML7dio4/39OAmMDgsS2zcS54rVJ4r7+AzNBS5RSzukQSHT9HHdYiDWgLrcpzkmku7VWwSUIBf+RVgc9FDtpmAhMD53DuWsE/Np+WyxoqVw/Fbii1ukyRzLHZLt9T+Ab1DC1YoGq0FG1TEJ8gVPnzj+v0xYQWJDyJqVTPnTZpTx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741875484; c=relaxed/simple;
	bh=gekX9SCTfYjtVUv5Ir/6YV1CaH/euSiiRvZPRgfpKu8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eHxgVkTPj86Gy56f2k0lmuOkHUpcMnV0+CXUxdenjiG7tBCMiFUP5bWadNeBUDoiAxSktEIr9f8WvCQrrynppR1DHMjS6XfxU4BCme46k4XE6Ri6PMIJM5g2/ZykgAF8YyIAh3D/GT8o6c32vtAfI8D5jea/OkkaqwIYgkJ2Ens=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=WS2132cQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HDTw036y; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WS2132cQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HDTw036y"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 4049E1382D32;
	Thu, 13 Mar 2025 10:17:58 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Thu, 13 Mar 2025 10:17:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1741875478;
	 x=1741961878; bh=hf13J5KwnYPb/vNCqt3K8r2BTndUfxe56+Gv25YhszY=; b=
	WS2132cQEnCgV7eWIPvKSq9E/Zr/1o8GAhAQ64Bdkmkq5uxicN87bBNVZfNnFu6C
	w+dWrgl3/8iMweOTXWr3SMjly5sLvuGcUwR/0TMrkkJ8YYBr837YkeINah8l9ADt
	DogZI2TvKs91Q0u0v7ZkwRanQHV5JBKW+IMcHXbyLXN7HSzRuYm7epgFqYxEl88W
	TiRUJZmS0bz/b7PvraBLLGe+0WzOZM4bzO/vCn9M5nJBGAGDqjnoK8rVqYIKvcHF
	fZh2DNQ0t9haw54kbt7UQe/uMKde4u7VfvmsoCxchlC8Ee1S9d6w8mKKeB77cam9
	1wrq1mqlRIRyETArjFtllQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741875478; x=
	1741961878; bh=hf13J5KwnYPb/vNCqt3K8r2BTndUfxe56+Gv25YhszY=; b=H
	DTw036yZ2xCQf29bmZOgahaO4cevLDu2YefT7jCUaTWYFsbLRXoGBL4sjjEQqnJ9
	z5G5AytApRWRSC8P0dAWWz9FyR8B8DUYPnothJBtegG/YkjSlDYkhPgP6BWhEUfA
	GS3dvgP2vJDJMN6iacxz9O0WTDMD6q+Y1UEdZKaPUZUrUhQ/kQs+dEchYcoE500t
	btCOoOBu8a88Dom9DDFSshsvIePkzdhCR25RnuXaCWgeSX2nvMOlPc36QL1YT61S
	7wutBfRENNoEroUzhc+6RFb+Vtiik6MzTI2IUshARKJdGajq2S53vHkXMaxhnfML
	vklCACHu9Z8TkK6VL3lgw==
X-ME-Sender: <xms:FunSZ8bVhDNHhx4km69DXe2azJvYPD4Bxw7xPpVSN-1JFwLCCcENHg>
    <xme:FunSZ3YFHVYsoTgc3g1uRXJLAmJ05pCjKAvWNN_3spHYttxrgOE92WT7p1sTxtOyO
    33qTQgqavOE4UbbIw>
X-ME-Received: <xmr:FunSZ2-vaxEuKXkOZXa5LSLhe2UXC4H-M7t1XeFSWkXpqN7tWECnX6t6zNgYt9WLyKJ_IwEOCRKuwb9zpW1TY3hJVnNWxR-4SA56cuQJV18uj4-oOQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvdekudejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepjheitheskhgusghgrdhorhhgpdhrtghpthhtohepjhhohhgrnhhn
    vghsrdhstghhihhnuggvlhhinhesghhmgidruggv
X-ME-Proxy: <xmx:FunSZ2rYrmuODBrC1xhHtmWkUClpogMssiBVTwmA3ih2MqNEN3_RkQ>
    <xmx:FunSZ3ol3ZlpcQYL-v4DL5FCBlx22YUNQIgCtN9nf5-zbiC-cMfEaw>
    <xmx:FunSZ0QtMwxqTMLw_c5Wf4EcGqaRGLiPVif7g1orAYB-OiZtEUSM3g>
    <xmx:FunSZ3rvwlHj-hddQrCewnhTN6cnZOL5pytQHgbW9QppFekekdsTeg>
    <xmx:FunSZ2V3MgjBSi_QEfhFNll-_fn-7h14-Ij3PTWQsn4Xtzubi_G7MW3A>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Mar 2025 10:17:57 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 777082d9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 13 Mar 2025 14:17:54 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 13 Mar 2025 15:17:43 +0100
Subject: [PATCH 1/2] compat/mingw: handle O_CLOEXEC in
 `mingw_open_existing()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250313-b4-pks-mingw-lockfile-flake-v1-1-bc5d3e70f516@pks.im>
References: <20250313-b4-pks-mingw-lockfile-flake-v1-0-bc5d3e70f516@pks.im>
In-Reply-To: <20250313-b4-pks-mingw-lockfile-flake-v1-0-bc5d3e70f516@pks.im>
To: git@vger.kernel.org
Cc: Johannes Sixt <j6t@kdbg.org>, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-Mailer: b4 0.14.2

Our MinGW emulation of the open(3p) syscall uses one of three different
code paths depending on the flags passed by the caller. Ideally, we
would just use `_wopen()` for all of these directly and instead rely on
the Windows SDK to implement the logic for us. But unfortunately, this
interface does not allow us to set the `FILE_SHARING_*` flags, which we
need to have control over to implement POSIX semantics.

One of the code paths is for opening existing files, where we end up
calling `mingw_open_existing()`. While this code path is executed when
the user passes `O_NOINHERIT`, we don't know to handle `O_CLOEXEC` yet,
which causes a couple of code paths that use the flag to not use the
emulation. The consequence is that those code paths do not support POSIX
semantics because we don't know to set the sharing mode correctly.

Supporting `O_CLOEXEC` is quite trivial: we don't have to do anything,
as Windows already closes the file handle by default when exec'ing into
another process. This is further supported by the fact that we indeed
define `O_CLOEXEC` as `O_NOINHERIT` in case the former isn't defined in
"compat/mingw.h".

Adapt the code so that we know to handle `O_CLOEXEC` in case it has a
different definition than `O_NOINHERIT` to improve our POSIX semantics
handling.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 compat/mingw.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index f524c54d06d..101e380c5a3 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -560,7 +560,7 @@ static int mingw_open_existing(const wchar_t *filename, int oflags, ...)
 	int fd;
 
 	/* We only support basic flags. */
-	if (oflags & ~(O_ACCMODE | O_NOINHERIT)) {
+	if (oflags & ~(O_ACCMODE | O_NOINHERIT | O_CLOEXEC)) {
 		errno = ENOSYS;
 		return -1;
 	}
@@ -632,7 +632,7 @@ int mingw_open (const char *filename, int oflags, ...)
 
 	if ((oflags & O_APPEND) && !is_local_named_pipe_path(filename))
 		open_fn = mingw_open_append;
-	else if (!(oflags & ~(O_ACCMODE | O_NOINHERIT)))
+	else if (!(oflags & ~(O_ACCMODE | O_NOINHERIT | O_CLOEXEC)))
 		open_fn = mingw_open_existing;
 	else
 		open_fn = _wopen;

-- 
2.49.0.rc2.394.gf6994c5077.dirty

