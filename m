Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B45D33DEF7
	for <git@vger.kernel.org>; Tue,  1 Sep 2026 08:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788250583; cv=none; b=SYMOPuZhHSJ7mn7t6Sf15v7bQwnA8D5JjYuY72roSWVC3tj6y6pXgu8ntDeCNIja5o0U24wMjkeM5OMoFNySG96ayTqwZV3oNaLeRKzTuAAZ+cUxIq8mWV0lc13TB0XA7Pv4ft2vUColdTfvFPL0+2Q78GWOrHQ2wNOYKYOg4Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788250583; c=relaxed/simple;
	bh=nq8asQZ3SpGBRuB/Pi5KVdRgg6UaTEkA+5azKBIyrko=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Ok7nvcKKNmELAZqEj+X72c3KMqi/IhlRkjPhvVd8ku8KhMfrq0C4YA2RVpCNYU7G+KMbQ6STZd50HdsQ5QcRWKtfJdo6mbAHwtc8oWyENKO//Gx4TPlesPQsYcBSHqw5b9FikvI5EfEdomSyxOHqyInnRONdoLHHFG5FWJn6TIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=IgZwBsQM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ekqs9Fcd; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IgZwBsQM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ekqs9Fcd"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 209B1EC0243
	for <git@vger.kernel.org>; Tue,  1 Sep 2026 04:16:21 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 01 Sep 2026 04:16:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1788250581; x=1788336981; bh=ScgA4/G6Tf
	PXTZfjriUjYiH+jitu3HvHeX6ApVj7jfQ=; b=IgZwBsQM0lFKln6w7wC4KIaVrC
	Hm582w62C2AHFyAOW3PbOeuC/HTqV0l7ZgrYrzXf2HY84UzGfBQtuOgcktLehmf6
	XKvmnDhXKDjGVV6MEn0IXH+Sfh/6RZDyjdh0B8SFqAbmljS4W3Wt9NckGDh0sQKX
	BchWLIGRZxvDM3oPfZ/7kmlGiV0cH0Yx0XsR87kc4H5rlQHWBGE31LCkNk+lHPo+
	aFmW3Hy9UySaMss+4ghB5TNhEVSiuymE2B/GS9fTV9GMWumDQ08lJmb+eqgQTnwN
	+6IrDUDXo8DPjLvT4GoD90/DaMYbNTG4OqRfaA6mZwrTsywS22d41Sw4Afyw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1788250581; x=1788336981; bh=ScgA4/G6TfPXTZfjriUjYiH+jitu
	3HvHeX6ApVj7jfQ=; b=ekqs9Fcdw5tokfK+BeRUEwL7JAO4w8XmrlMLza9Rob9q
	pxO7Cs7JUUSJHMk8G0o5a2WnMJ3qwJ24TCbm96bQaJVGpHxkhsGSHk+PN4HyZUGV
	u/OH9IOzHDM2EgX+kjfsSG7P2uRMT1MhLc8Cn+XeOjyTB9omaHuhjr0TUF7yRDUG
	EK743LJn58e9FbzRJDsd3I5Q7FIv/SAp00rguzi67KAsdgNFvN5Z6imK6Nz4iJwr
	FZyFP+yJtieJnUnW8sxEfez1KxekAL+cAG+FcMvY5+bp+1rOTN4vJI/0RAyM0kSi
	oB0l/MiJCR6XVTVCvvgpgS0EIdGCil8WejoOFF9psw==
X-ME-Sender: <xms:1YmWasB9SeqTyMTnXTmDoCv2FVRrHu53TRjnk3OTqlddKbrFqN-fFg>
    <xme:1YmWalcf5dsOmhbPYuAXmXnvfg1J8uJePgnlFPkRz_vc2AwJ1Gw_y_ARI9FAeeNRn
    YKeh3WQmTk_8r49YwoJlEiaCJ2dkeTTQQDzVJk-Jr7LgMtZTIIAtuM>
X-ME-Received: <xmr:1YmWalPtDE1boh88lxQAkIkRNB0bJG6OZXNRpPM8kkyImLs9zQXZow>
X-ME-Proxy-Cause: dmFkZTFFEm2sNiVT2ptpFLi8a/hJD2iea6m8bJKc11JyGQHcAaaaXcA6hQqT5DQRJBD/pm
    2/5uSDkUV+TRF7qgolcOnv/47irH1z+kB4sbbbLpHGwPS6X6fCiyMmk3SXKTnE62vwQEDV
    QKbIxWQ9VPHyul09uQ7BFXfdrrM4LiEmcJXWytVnuiGaZtCeG+ZIS0lE5OdphnSFzhjt9c
    uU8qqLI4Tekbg7u2/3QtB0pmCKyxdWEJhutUyjHnfHo6YCOaD9Bi8y8I3IMg/huvvnlHvu
    OwEC/pSk6/mmY9jfMaOk9jsh0J8kJLCRHcOxqQB6PNp7MFWnmtqbxijTVMY1+0bBuDPhf2
    fBJtbUgr4DME8XAvSWz2TaZFeW2gXA8+xD2rP057afED9/Hap8/vV6DeuthZELfyXu90vF
    WZFYdoB6QSCRAMVYBdYF2wqZn0Yc6Kp6YQycjojUVGcczAK+avK5j9lqMbpZPhzjbuMcnU
    3YX8b3dhgpRvO7WUTbs1+DEfYmdWCaXfABQEO5XBh8IDy7xrnQLfcm2sKvTB5NcjFNFKyl
    DYNeOr3LBe0Ww6V6kArS13N/wOJfpZlcGg8aIAEeOlJhOdaeMK0rKC2uqq/oU+uFWg0/aa
    a6oiYRI+kv1VQfsPq3nJGbdHAOj9VXC9Z4pHExpH7OXoT2fGK2j0MIePp8dQ
X-ME-Proxy: <xmx:1YmWan4fs5ZZ_lOntHK1r9gd_xp0h04_Ks4Tww9_smWud85LEsO9pw>
    <xmx:1YmWahKS3AX3wGztaUBrHS_XfFKzKvRvFgPho82--RtvFga8Dsu-Nw>
    <xmx:1YmWapdKabBHAmZB3z2amstaI4PybbW3J1pgVZnGw6blc5wsSkQNxQ>
    <xmx:1YmWasd1C3qkxWxtecnBBWn3hQI9sVYfgc41nvbO_Natc2nTrd9S6g>
    <xmx:1YmWanBKxpDG3J-Erc-5kuaWFZvXpEoDJ51r7bwTKSKCJuAlNvghtuwP>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 1 Sep 2026 04:16:20 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 555d57ed (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 1 Sep 2026 08:16:26 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 01 Sep 2026 10:16:11 +0200
Subject: [PATCH] ci: fix missing Ruby dependency in "documentation" job
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-b4-pks-ci-fix-documentation-job-v1-1-a8257ee2a9a4@pks.im>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWN0QrCMAxFf2Xk2UA7xqT+iviwZplmYjuaToSxf
 1/UxwPnnruBchFWuDQbFH6LSk4G/tQAPYZ0Z5TRGFrX9i44j7HD5alIgpN8cMy0vjjVodoO5xy
 Rw9mzd1Ok0IFVlsIm/h6utz/rGmem+s3Cvh8TEy0lgwAAAA==
X-Change-ID: 20260901-b4-pks-ci-fix-documentation-job-e971e10fbc94
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

Our "documentation" job has recently stopped working with the following
error:

  + sudo gem install --version 1.5.8 asciidoctor
  + gem install --version 1.5.8 asciidoctor
  ./ci/install-dependencies.sh: 23: gem: not found

The root cause of this is that we never explicitly install Ruby, and
consequently gem(1) isn't explicitly pulled inus, either. This used to
work alright because we transitively pulled in Ruby via asciidoc. But
due to an update it seems that we stopped pulling in the transitive
dependency, and consequently we don't have gem(1) available anymore.

Fix this by explicitly installing Ruby.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
Hi,

I spotted the failure yesterday. You can see that this fixes the
pipeline at [1]. Thanks!

Patrick

[1]: https://gitlab.com/gitlab-org/git/-/merge_requests/660
---
 ci/install-dependencies.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index 10c3530d1a..502e518077 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -164,7 +164,7 @@ sparse)
 		libexpat-dev gettext zlib1g-dev sparse
 	;;
 Documentation)
-	sudo apt-get -q -y install asciidoc xmlto docbook-xsl-ns make
+	sudo apt-get -q -y install asciidoc xmlto docbook-xsl-ns make ruby
 
 	test -n "$ALREADY_HAVE_ASCIIDOCTOR" ||
 	sudo gem install --version 1.5.8 asciidoctor

---
base-commit: 1630431f326e15fcde608827b5ff38422528eb59
change-id: 20260901-b4-pks-ci-fix-documentation-job-e971e10fbc94

