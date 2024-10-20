Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30BDA195FEA
	for <git@vger.kernel.org>; Sun, 20 Oct 2024 19:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729451732; cv=none; b=Yl6M1SVTi50ybLuBiM1jbz8UQSz31EubEpsAWL7zn8gPvs6xCD+9DKAhXvNl78F3GwgaCKdjiSxjJyHqm/ng+KjihwHJqfN5LQ8d2Gnli+EGw0n7mzMMcjMPMHh54MM8GNLHHbSlx4nAT6SvsBgOIZ1qLLhAtd8t40fC+b31aDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729451732; c=relaxed/simple;
	bh=Uj6T06+gVO8k5Z5Z/gK8PhutkLhd7UfbydIYheMMxFs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eNhevF9YmOkHC6s74OVq8PUqKljuHjQQxMndGHwZ8ddVEoj0aOHFccrt2TqRNDtTKkG5san17aPFuxZdfT5JLefSD3rNIM7JUh+JilLJvwqe2GzO4fgeEE+BSKRywJz6P+/qrIHsx1kbOeBWp/LIzoBUnK5Zwm5BKlvySmNUuLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=NGTG1v8Z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GJqx306t; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="NGTG1v8Z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GJqx306t"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 3482313801FA;
	Sun, 20 Oct 2024 15:15:29 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Sun, 20 Oct 2024 15:15:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1729451729;
	 x=1729538129; bh=er+cTxxt30Rbzddm76yLWCIVuDvUNkel9hS38y/x4XI=; b=
	NGTG1v8ZOCCKXQWlMySVMitVMRPFiSHLIHIYP8mKw8W0qzd4L3wJN0XUAuWcQq6L
	THMZ7Zn5eM+fjx+YqEuTtGeI8Wugv0wYAIU3qs1oAHX39DOl2Pak2JKpT1IahT1f
	rF9ODROX3eGc824mwak4HXl4GV3+WFFBBJT4Ag0dAYBM1sW/Lwb+5iozs72cno9X
	gMUIGK8G7WIAZbo25QbJ/ndQN39psO2A2Pt+j+U5NIdWuwdT3ZHM2RdFuogfWaoP
	icUCfQRATIrjNDBrix/rFVpxMwWSwhNFwlXJ5MR7TEumpNPIpU2ZSuuu73wImHKv
	+wZOMkKinUSNdXRNwX0mKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1729451729; x=
	1729538129; bh=er+cTxxt30Rbzddm76yLWCIVuDvUNkel9hS38y/x4XI=; b=G
	Jqx306toRuZL7UJ95FZv67UuSHiY/IkULWQxMmvnejogQGn7JtqwIzYiAVDEZiI1
	KEVS/DXy2jqLzUODbXBuXQ5hV0W1rp77PEGdVn3jK3Kv8oD+CDS8epd/n8/+AhKU
	bsmAbU/NE+e1Et2unV0/iX4JA4FdwtMOXI/18FMnV8jHRXTkbFYsCT62p6YWhP9H
	4UA/QcKfrDZ2+Vf0RFXFBu+QKd3FcFK9XGXqcRJWwn0W3U81dz38jAoKdAa/pjAt
	ilayDVQAnrH7jeks6RDIiXPGr3xOAhpau3V3LFaFI9Ok6LeZZGYfIx8nSeydwVHz
	nbmBiV9IUu61+UwzeDdKg==
X-ME-Sender: <xms:0VYVZ7kdQktVb3BjJ7_nskk9fGAKRsL3qzNtmhfkYWBtaV5Xpqf8_io>
    <xme:0VYVZ-35XI7KpSdWtEIpuOWh0ZBao3CejCXIicZdjIWdOtdfsxIlfqCA2uNRKL6Ka
    sZ3wbltNiXRoAQrRQ>
X-ME-Received: <xmr:0VYVZxqw_QkcqLS5omUAWkk3TwhzPtRjQLM55Yx8u7wuD3F8OLJ56nZPt0F0JzQNZ3Uzx5Gc5PG-s7SuWVw7sF6ifeTV1M9-T29nA_3KufnntAbyJ_zNb_Rtvg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehjedgudefgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvve
    fufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpehkrhhishhtohhffhgvrhhh
    rghughhssggrkhhksehfrghsthhmrghilhdrtghomhenucggtffrrghtthgvrhhnpefhte
    fftddtgeeifedvteefffekheeiledukeevieevleefueegjefhkeelteduueenucffohhm
    rghinhepshhtrggtkhhovhgvrhhflhhofidrtghomhdptggrnhgrlhhsohhophgvrhgrth
    gvohhnsghunhgulhgvfhhilhgvshdrihhtnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfh
    grshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    eptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhrtghpthhtoheprghvrghrrggs
    sehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:0VYVZznDFlblc3SxEoMwESb5xrBAMcQaRRYYo5aIYoT-Q4fqFZigHw>
    <xmx:0VYVZ50Z5r3RnOxCjZw6ruUWG8awHz5-1S8OIiP2hOHz8_oW90nv1A>
    <xmx:0VYVZyuSntkXZmebQGqHuEQTCe-n2Ttdt7vKwaM4VtPtydWy-x7Lgw>
    <xmx:0VYVZ9VvGJwI_oA88mCEzgf-eUV5OQtBjzxMQ3gHwylpSLWxdcelRQ>
    <xmx:0VYVZyzyGEXta7PHVcGGj_JbMTZGPnpPH7vU4hEVgwbn7ROKpCaevUf5>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 20 Oct 2024 15:15:28 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	avarab@gmail.com
Subject: [PATCH 2/4] Documentation/git-bundle.txt: mention full backup example
Date: Sun, 20 Oct 2024 21:15:00 +0200
Message-ID: <f7d9aa89c953ca7d15b5047487b4347ef62e77a9.1729451376.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.46.1.641.g54e7913fcb6
In-Reply-To: <cover.1729451376.git.code@khaugsbakk.name>
References: <cover.1729451376.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Commit-Hash: f7d9aa89c953ca7d15b5047487b4347ef62e77a9
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

Tell the user how to make a full backup of the repository right at the
start of the doc.

This is a requested use-case.[1]  But the doc is a bit unassuming
about it:

  “ If you want to match `git clone --mirror`, which would include your
    refs such as `refs/remotes/*`, use `--all`.

The user cannot be expected to formulate “I want a full backup” as “I
want to match `git clone --mirror`” for a bundle file or something.

🔗 1: https://stackoverflow.com/a/5578292/1725151

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 Documentation/git-bundle.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/git-bundle.txt b/Documentation/git-bundle.txt
index 7579dd309ac..bf0d448a736 100644
--- a/Documentation/git-bundle.txt
+++ b/Documentation/git-bundle.txt
@@ -26,6 +26,9 @@ They can be used to create both incremental and full backups of a
 repository, and to relay the state of the references in one repository
 to another.
 
+You can use `git bundle create <file> --all` to create a full backup of
+your repository.
+
 Git commands that fetch or otherwise "read" via protocols such as
 `ssh://` and `https://` can also operate on bundle files. It is
 possible linkgit:git-clone[1] a new repository from a bundle, to use
-- 
2.46.1.641.g54e7913fcb6

