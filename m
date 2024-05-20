Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3705D182DF
	for <git@vger.kernel.org>; Mon, 20 May 2024 11:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716203478; cv=none; b=lGOyIJq5CHAD8pqnnAONN6+Aww/X3RGsc1GdoLdvMF0YVzfERiU6r4ywVPQOMt45XP6QMf7uazWfcxVoDDHrm3v2a0+Mqm6+18WUeWLfxo2Syq89W3LJuQKGBjXI6jd9EG+ORO8eORlm9CJC2ivYz+uA9EuV19QWHNsW78xhE6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716203478; c=relaxed/simple;
	bh=cs6A4UkWdl/w7crwYvSYznrY3s3D92v1CuvQaknXS7k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NSd2FkEJDXbhnwHcQM+JMfcgaLfzbRMY079SrY9tntfiwIGJJCWk/HdXbwDCcvWgU5jzy11Ezcor3GP5gbO+3kMD1BEwkd0DFb6ntkorfQciJDtTvddI0sVFyLRDe52QeN/aQQb+eKNkC1iiQD/YzSb/cSyfIYnk79WHnrXWSCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=Yk6pCo9f; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="Yk6pCo9f"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
	Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=TJB69kFi25+o7AGvHqKDdChmqEtI5EMwywmtlrQHtxg=; t=1716203475; x=1716808275; 
	b=Yk6pCo9fs4h0X//U6jeoUeBksR7Findb/W0+DaE/vs30mBhCeRoLNMLu/481P0Er9K/Y/TDJy8s
	hTWuEbxXbnXvJseMtxFUbxz7k00gT65252NyEl5qMDCaOinf4XPgzE+6me1vkKJq7+EfRZ5+l6Li3
	oiUN6ZkBlLI3bV+HaSqvJLc8UDebzF78P5IkEbcwUvJgAG5CRAyvShsE2U3ckqcMtRvOTLaSHnqz3
	DhDPOloKQh6cfnoU7AO9Mu3C199jxLsG1u5QkDyRuygQ+/dpM8vjd5lLHqSIirlJ5Qe2RGg4o8bTM
	UcZohpHI67+ykufWdIM+JgWxGwTrVRC76AnQ==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.97)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1s90v9-00000000DJ6-18U4; Mon, 20 May 2024 13:11:11 +0200
Received: from p57bd9a40.dip0.t-ipconnect.de ([87.189.154.64] helo=z6.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.97)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1s90v9-00000001VGP-0Fze; Mon, 20 May 2024 13:11:11 +0200
Received: from glaubitz by z6.fritz.box with local (Exim 4.96)
	(envelope-from <glaubitz@physik.fu-berlin.de>)
	id 1s90v8-000PzD-29;
	Mon, 20 May 2024 13:11:10 +0200
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Sam James <sam@gentoo.org>,
	Andreas Larsson <andreas@gaisler.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Subject: [PATCH] chainlint.pl: Extend regexp pattern for /proc/cpuinfo on Linux SPARC
Date: Mon, 20 May 2024 13:11:09 +0200
Message-Id: <20240520111109.99882-1-glaubitz@physik.fu-berlin.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

On SPARC systems running Linux, individual processors are denoted with
"CPUnn:" in /proc/cpuinfo instead of the usual "processor NN:" so that
the current regexp in ncores() returns 0. Extend the regexp to match
lines with "CPUnn:" as well to properly detect the number of available
cores on these systems.

Signed-off-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
---
 t/chainlint.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/chainlint.pl b/t/chainlint.pl
index 556ee91a15..63cac942ac 100755
--- a/t/chainlint.pl
+++ b/t/chainlint.pl
@@ -718,7 +718,7 @@ sub ncores {
 	# Windows
 	return $ENV{NUMBER_OF_PROCESSORS} if exists($ENV{NUMBER_OF_PROCESSORS});
 	# Linux / MSYS2 / Cygwin / WSL
-	do { local @ARGV='/proc/cpuinfo'; return scalar(grep(/^processor[\s\d]*:/, <>)); } if -r '/proc/cpuinfo';
+	do { local @ARGV='/proc/cpuinfo'; return scalar(grep(/^processor[\s\d]*:||^CPU[\d]*:/, <>)); } if -r '/proc/cpuinfo';
 	# macOS & BSD
 	return qx/sysctl -n hw.ncpu/ if $^O =~ /(?:^darwin$|bsd)/;
 	return 1;
-- 
2.39.2

