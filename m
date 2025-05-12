Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3855827703A
	for <git@vger.kernel.org>; Mon, 12 May 2025 19:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747076599; cv=none; b=X3KmzfGz89INrV/M6Qz20EmuL3i6fpHetV9PqtfAV0XppkuOCpPWJP0hwmufBTgykJ21/gzocAb9JsbY+NkAKVWD5KEBGkwDgH5JtUd4MF1SyFx5Bjk6hc3EOoUPaQJUnKGT79J5ALo9JpTHGdbVgYJI9CN1xRMH++z+bXHvqoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747076599; c=relaxed/simple;
	bh=Vx0ukIBsC/PW5fOnATyXe5puxnmD25cK86KhSB0iTh8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ePTdaent/lhQWtgd5UrGbL1Q4RVgu2RSm02PIMLptHNLdbGXzTnW+NNKdLEgaYVCRqRRrYFLR/owozvyHEoWqm1qAublkD1BhAeolw57fVaquSdMDGDpxGQF3UXg6uTt+HNh/oZyNfTAiUIZCht9BHiyJ6LaWmMtSfpVHOrAV+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=nfYw8nXY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YAullJW6; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="nfYw8nXY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YAullJW6"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 1D45D13800D6;
	Mon, 12 May 2025 15:03:17 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Mon, 12 May 2025 15:03:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1747076597; x=
	1747162997; bh=TKTUhbag6ST43Tx4L+5am4gJsbtAXM6wNJeE2cWFa84=; b=n
	fYw8nXY09oz3a4DUqUmhpWAbBE1eqSOjE40wz1ETPpbxCw142lDWho/vyRNxo8jP
	Cy8H2iQfz5JHptdyJfJSfzlV2pFtOMBHvLCdYYVVt7Rtzxskh5PD9ufbJhR0ehp7
	QD20+IKgNrW3KwuVzvuCYJ3HgxSc9+I/sB+bBUtVOKcSzTeUkQup+9mas83HpcN/
	0Vtw39JRmsYYV6f5a9QxgrEyTB20GVq+wqj9FGQoCkWOoZ0VEpGNu3su55UeUMx8
	ej88KkG99gHg9PQVUpI+E8i8V6n1FYMLu1Lei4hUkK6f8qU1dq6EH+oqyAwPdOuv
	jGHKjX1MPhcujZKHLfi5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1747076597; x=1747162997; bh=T
	KTUhbag6ST43Tx4L+5am4gJsbtAXM6wNJeE2cWFa84=; b=YAullJW6kRQ4LAy3B
	CiLWfLqCv3a7AIP0aFSy/GmGqZEa0e/r+2mUnm06VDltbMoRs0G/O5cZZvsI/ol+
	vAk7irrhmWNRhs3SM+0o7LCMFjr+s/yRFc0h/VCx46mJGpjqqg5Rc4Rg+NXckrjT
	t33N/Z693pJ9cABDv3SnsriPSrxbzjCuRLWpjPiSeTWSMhCeWrcGPYvc4nU3iLX5
	PTPT/qUYKkU0VbqiHtnVe3URN04hj00+0hAENHoOtWhySu9+naF5D+86DlK/i5Le
	ltdo6DFIgCe2vrajaHmYLyUQWDxWOTkoZeKfcVi4p/Dza/eFUiTKXMgc8lad6lIU
	XuQVg==
X-ME-Sender: <xms:9EUiaOHaNTQF72UstF6t1QswkeUY2bNuXbetf9p0WBe8LsjVM9wqFg>
    <xme:9EUiaPVz9spuUjDh4Ew22yKgVuTfy_FX6G89PXeHzI1yg6wpTIqNrWaH5ihey7_k9
    EbjpqeP6fjwfDV-ew>
X-ME-Received: <xmr:9EUiaILVWSrQIxthRv0kAHWerX_4eXsaV9KLSAkT1oKIUZQoBdWxGZ6oZAIrFBVNu26lwYXv40uFsjlfdnpHgb9QkPa0Nfoegidmgow>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftddvtdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredt
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepvdfflefhueetgfektedthfduleffudet
    leefieeulefhvdduieeukefhtddvudeknecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtgho
    mhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:9EUiaIEgzpJREtFRL0fZ4KkKnI8-tqd8hXgA_aMdk6OfzPhDoeP-tg>
    <xmx:9EUiaEWBJ8S9_ooRBJYIMDHmV0O5h4vob7vUGPf-tek1aR28HgkXlQ>
    <xmx:9EUiaLOkeIU2zQQpDPNdtTaIf0n-wGasQ8CxLvn1zF-VZQkp203CcQ>
    <xmx:9EUiaL2D-Lmxg0K2L0TAq7yoWeYnQtX5FA3yC5CFZ67UCYRZHSa86Q>
    <xmx:9UUiaPCDyXqzwFBxa3v9JWeXm3VYPJ69ZLumSGThGWtlA7pudQO0ZgzV>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 May 2025 15:03:16 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>
Subject: [PATCH v4 2/6] doc: prepare for a world without whatchanged
Date: Mon, 12 May 2025 12:03:07 -0700
Message-ID: <20250512190311.1451556-3-gitster@pobox.com>
X-Mailer: git-send-email 2.49.0-674-gc1e4f99c0b
In-Reply-To: <20250512190311.1451556-1-gitster@pobox.com>
References: <20250503005814.3030099-1-gitster@pobox.com>
 <20250512190311.1451556-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some documentation examples reference "whatchanged", either as a
placeholder command or an example of source structure.

To reduce the need for future edits when `whatchanged` is removed,
replace these references with alternatives:

 - In `MyFirstObjectWalk.adoc`, use `version` as the nearby anchor
   point for `walken`, instead of `whatchanged`.

 - In `user-manual.adoc`, cite `show` instead of `whatchanged` as
   a command whose source lives in the same file as `log`.

Helped-by: Elijah Newren <newren@gmail.com>
[en: log message]
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/MyFirstObjectWalk.adoc | 4 ++--
 Documentation/user-manual.adoc       | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/MyFirstObjectWalk.adoc b/Documentation/MyFirstObjectWalk.adoc
index d6e9dfdbbe..102a465a48 100644
--- a/Documentation/MyFirstObjectWalk.adoc
+++ b/Documentation/MyFirstObjectWalk.adoc
@@ -83,13 +83,13 @@ int cmd_walken(int argc, const char **argv, const char *prefix)
 }
 ----
 
-Also add the relevant line in `builtin.h` near `cmd_whatchanged()`:
+Also add the relevant line in `builtin.h` near `cmd_version()`:
 
 ----
 int cmd_walken(int argc, const char **argv, const char *prefix);
 ----
 
-Include the command in `git.c` in `commands[]` near the entry for `whatchanged`,
+Include the command in `git.c` in `commands[]` near the entry for `version`,
 maintaining alphabetical ordering:
 
 ----
diff --git a/Documentation/user-manual.adoc b/Documentation/user-manual.adoc
index d2b478ad23..7124345966 100644
--- a/Documentation/user-manual.adoc
+++ b/Documentation/user-manual.adoc
@@ -4240,7 +4240,7 @@ command `git`.  The source side of a builtin is
 - an entry in `BUILTIN_OBJECTS` in the `Makefile`.
 
 Sometimes, more than one builtin is contained in one source file.  For
-example, `cmd_whatchanged()` and `cmd_log()` both reside in `builtin/log.c`,
+example, `cmd_show()` and `cmd_log()` both reside in `builtin/log.c`,
 since they share quite a bit of code.  In that case, the commands which are
 _not_ named like the `.c` file in which they live have to be listed in
 `BUILT_INS` in the `Makefile`.
-- 
2.49.0-674-gc1e4f99c0b

