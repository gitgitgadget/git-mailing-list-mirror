Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA84338D6B0
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 07:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773212968; cv=none; b=Hjo1RFzCG68IBeQcwRRbUmB/JqZNaejGsbstla7amGWZhnlzqbCYkEW/N2H2cUR6F2KilEs7v1pS4n8MV3Wp7rk/4mIp9i+nxHVx+TVD17GyS5L2E4KXYf7VfxrTv9KKItFnoLPwJLAQiWl6SL7M/sZUwv/8h8mLtFrnzV+LYjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773212968; c=relaxed/simple;
	bh=OWgh8tGtqlgLKtYFum4/5FSFGeE85sUTKNRqbDHoAPw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=X7pBx1IwxObIm3zLs8ACOaRdVqlcdL8sVm6cTQnWZR+6Xsh9qAdga9asxTQxHDLJSSf3bcxCUq7d7jkkwZM0WUOPXxZTfoB740V/qQX13tYWgCEJoLdIDVOeslwGOKaCxNoz50tRbhA6AkV03vbSTKpNbs/y4ro67LKTF+YjYUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=k5kYRcO3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=u3V4tMwK; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="k5kYRcO3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="u3V4tMwK"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id 28C361D00168;
	Wed, 11 Mar 2026 03:09:25 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Wed, 11 Mar 2026 03:09:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1773212964; x=1773299364; bh=a5nxtqSb1l
	ipjXmR/qsDxAOcrpL0OsLcWudbdWFW5Eg=; b=k5kYRcO3KOKieTMZY2omvrxR9O
	sUGUm3OEvPROgkdXTHLx3JTk1/zHlRCrok8WdUnC4LB5fAEVoLt0QmHCQaFFKtmT
	dLgBkuNcU4P/39on53R6JE0IA2OcqHh+eGTU1j1tIIt/MfaI8WSwqncMHYT7gg//
	LMblaRNG7HOVD+t5o2G6lN10APzfyt6M+xbtn6HfWRj1dnJdfiMubdyGmxF30+GP
	2+iW2ifHdP/Z29L5s1zXH5JNnoDTKF2DBWfSs/N8J70j6zVoF6G7tuYkQh6L3/0e
	wLK/P6cB+uF1h6Pl/A5Kp7BQcDC/vvPMFblXXkCu6mOxmGKKFR/arTLLa5aA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1773212964; x=1773299364; bh=a5nxtqSb1lipjXmR/qsDxAOcrpL0
	OsLcWudbdWFW5Eg=; b=u3V4tMwKE/ydgNL1pG2qp8vpkzpUOBASVFt8vBgPykTY
	XZ7bhAwQk1UMHk030iTgIFxYn955+pg+yyoJgXrU0yKkM+mEt61NdTrf+hd5cSA6
	CMUD/k/ZHh+FN/nKyKsVSqOwtq4gQyWW4n5MY9pIitp7g6g+LX4We/ILARMqtLYI
	2RnDum5kz+ApNwA/oGKAZXrj2LRohQzs/7KPDHikwFuLGtFUaP8TFi2V/rbJSrh2
	bgdjERh5VPWZX7KR36n8zDTtkfuyhl+AVMAjfjBddfJ65zpMF0pG40N93KVfFIrm
	3Jd9Wr+f0bVOpRqF2VSODbBJqcsjduVhv8mHcw8aaw==
X-ME-Sender: <xms:JBWxaciDlz_jEgsab54kZi8Y2OnEG9ZWFjbqu1Yc0P4in7XBrpUgNA>
    <xme:JBWxaS8VI0iJkUp2WimCFV0A0ZvBaiYG3ZitPjgxdxr-hCB0VW2Cqqabi20Lg84a5
    DTVuqQEwSkBZfUqX5gYpMSdMfQ7fIdiEZQ085H_I_5Z9BkFv8FC0w>
X-ME-Received: <xmr:JBWxabq8Em_phJVvGt4h9R8p3J-40zRuHdaF3XORWOWaiEOpUq7u2D40dCotxHQdtdtjLNezuew8j33LN4navXF_T2vxGKZ07-XzsTq0Xg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeefvdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkffvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    ekieduudetudegheegieehheekfeefffejffetgeevjedtffehiedujeeukefhtdenucff
    ohhmrghinhepvgguihhtohhrtghonhhfihhgrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghp
    thhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgv
    lhhmrdhorhhgrdhukh
X-ME-Proxy: <xmx:JBWxaZ9imQVLpfizDDlSfekoPl8LTMtoiJqskJezU3OxBLV_yJVN0A>
    <xmx:JBWxaXWKEtnMl_ed5Vrp6Weh4inOQ64dseZmOyD6QWqfhSYK66h-CA>
    <xmx:JBWxaXAJ-ODOW7sF0YIolpx9SAZQ04QCBwLST7mjrnzcXcWwJz-v8Q>
    <xmx:JBWxaQyt1Kk5h22yGQnzlb0-jSaYgHnSIEZ4r5uhBI8YA0FNhqKeHw>
    <xmx:JBWxaWmu1vSH_vW4dASA47PV3DDFK9H2OPNN5RcOfiERTP9tmTdwi5Mh>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Mar 2026 03:09:23 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 51783141 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 11 Mar 2026 07:09:22 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 11 Mar 2026 08:09:18 +0100
Subject: [PATCH] editorconfig: fix style not applying to subdirs anymore
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260311-b4-pks-editorconfig-fix-subdirs-v1-1-4938193ccd31@pks.im>
X-B4-Tracking: v=1; b=H4sIAB0VsWkC/x2N0QpAQBAAf0X7bMsh4Vfkwd0tNnWnXaTk310ep
 6mZB5SESaHPHhC6WDmGBCbPwK1TWAjZJ4ayKJuiMgZtjfumSJ6PKC6GmRec+UY9rWdR7FpDjbd
 V25GDVNmFkv4Pw/i+H2D5hQhxAAAA
X-Change-ID: 20260311-b4-pks-editorconfig-fix-subdirs-981e6db389ec
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>
X-Mailer: b4 0.14.3

In 046e1117d5 (templates: add .gitattributes entry for sample hooks,
2026-02-13) we have added another pattern to our EditorConfig that sets
the style for our hook templates. As our templates are located in
"templates/hooks/", we explicitly specify that subdirectory as part of
the globbing pattern.

This change causes files in other subdirectories, like for example
"builtin/add.c", to not be configured properly anymore. This seems to
stem from a subtlety in the EditorConfig specification [1]:

  If the glob contains a path separator (a / not inside square
  brackets), then the glob is relative to the directory level of the
  particular .editorconfig file itself. Otherwise the pattern may also
  match at any level below the .editorconfig level.

What's interesting is that the _whole_ expression is considered to be
the glob. So when the expression used is for example "{*.c,foo/*.h}",
then it will be considered a single glob, and because it contains a path
separator we will now anchor "*.c" matches to the same directory as the
".editorconfig" file.

Fix this issue by splitting out the configuration for hook templates
into a separate section. It leads to a tiny bit of duplication, but the
alternative would be something like the following (note the "{,**/}"):

  [{{,**/}*.{c,h,sh,bash,perl,pl,pm,txt,adoc},config.mak.*,{,**/}Makefile,templates/hooks/*.sample}]
  indent_style = tab
  tab_width = 8

This starts to become somewhat hard to read, so the duplication feels
like the better tradeoff.

[1]: https://spec.editorconfig.org/#glob-expressions

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
Hi,

this fixes a small regression in our EditorConfig introduced in
046e1117d5 (templates: add .gitattributes entry for sample hooks,
2026-02-13). Thanks!

Patrick
---
 .editorconfig | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/.editorconfig b/.editorconfig
index 6e4eaa8e95..82e121a417 100644
--- a/.editorconfig
+++ b/.editorconfig
@@ -4,7 +4,11 @@ insert_final_newline = true
 
 # The settings for C (*.c and *.h) files are mirrored in .clang-format.  Keep
 # them in sync.
-[{*.{c,h,sh,bash,perl,pl,pm,txt,adoc},config.mak.*,Makefile,templates/hooks/*.sample}]
+[{*.{c,h,sh,bash,perl,pl,pm,txt,adoc},config.mak.*,Makefile}]
+indent_style = tab
+tab_width = 8
+
+[templates/hooks/*.sample]
 indent_style = tab
 tab_width = 8
 

---
base-commit: 7f19e4e1b6a3ad259e2ed66033e01e03b8b74c5e
change-id: 20260311-b4-pks-editorconfig-fix-subdirs-981e6db389ec

