Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FDB41F5419
	for <git@vger.kernel.org>; Fri, 27 Dec 2024 14:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735308010; cv=none; b=oG2yHFUotwaBDloFXJlAtsG4uFDu0E5oK7VCLEmpZYxtYk0WkdsZWhu2iM7Lv0oRD7tCCwpVrXVp5Rx72EpvCFETMuGj8y8RD2ob2CbLl4K50uD7jnccD6vvI8+zSuJiVVmkefZs85AbRTqWrOQ/3lm7fIE1BD56Gh3Um9Cbm3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735308010; c=relaxed/simple;
	bh=7gBQCBv008kwYM83VG+gFkqyx7q78+iAKeArTl7qc4U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qxICSMQ+oQUUyE6S6T6IYkpEsdOgjcjiMADzC6ntnIiS91F7FtNqnj/cMaznyFR0d8QStGsy+VbUppRaEa+hle25t9BMhnT6u/5sdz1Z73H2JYusgBp7O5Z9GNHY+QfALylvk2s6jMMSCsKFE+nJjblbpnTMS4/kSBzcAd5BJeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=H4T2NUAV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=odxUvPUl; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="H4T2NUAV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="odxUvPUl"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5A04A2540182;
	Fri, 27 Dec 2024 09:00:07 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Fri, 27 Dec 2024 09:00:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1735308007;
	 x=1735394407; bh=U1eTPbO0VAmOFhF2VsbNrch9g3GOXw0Jzyj3BdfyZhI=; b=
	H4T2NUAVtZlGGr9EDGzQg2JWd0EADpif/UhA0g2j45jq0vQ5Ji/EF1k3zH4/ZnEj
	bBcK5Rb+Ze/QnvaVG8oVPIMV8LhszlxKLvdh14LSI6nzNnjsPzfPtm8qrIMwFe4s
	9odC+9CR/c4ctuujy6y/wNmWyNPkWI4ZPu+hi60KM+OBAiu+kkKaOJypmQrE2Fi/
	AhYMzV8btBkHigPxP/zh8jjdbvMSLGd1NxOvaz7WHS+xY+Zkls37fI9uStr6rllQ
	5XRg95uraLyc9gGP9JttmTwaeaDU2nSzLbtfUCoPcnx4Q/m/ZT1cveUkZpRGP/HW
	Xm4PyBt35shue/LF6hrPRg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1735308007; x=
	1735394407; bh=U1eTPbO0VAmOFhF2VsbNrch9g3GOXw0Jzyj3BdfyZhI=; b=o
	dxUvPUl/rHmmtFNKXZNlo1Azq17Bt/6ncUOMjvP0XeGEjhNeDRvlFQ3+Yr3RgLAA
	q9MiQsZn+63mwPlCVeamVbHalHUorud0GkX8xtfL3kVlXgg7PnegwxIRDweVGOZj
	mA9bQ/+CnGfHka3LIyxon0AMxVZyv97d5Jnk5QydhZf1q3eig+Gc6/7Hy43Bouhk
	QdcMwme+KTlPsgBERZrVb5uUyz3lSY1WueazDOKkElm8reo+i2nGbtHRK6CS/k1M
	e0ge32Q0uAdv0pdxSKz+o1uVpImnuvhFLp/bh0weSVlmkpgAmh6uuaok57hBi0me
	Ai2HQgG252Q16UEcY/nFQ==
X-ME-Sender: <xms:5rJuZ2yg1dKyrYredOkMb7xxi5eAWKfFlnWQjLn_YGQFg1_Xt_W_Cw>
    <xme:5rJuZyRynIYpeFEJnQOqLHdojOpniMRIO_Llh5UbRzey3fyvyZZWjachZ1b6wmKfh
    lD480yecB7edG5Q7w>
X-ME-Received: <xmr:5rJuZ4VJuUdq5WtfVHWkUHPCroTWd4vkjb4UJ3-pb_nKhpTuyTBikSvX9HMbWW0inpCdFdIOZ9rYAfp5Rr0oWGETkQ89aTfRi28VBfWEzoZgBA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddvtddgheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpedtuddvfefftdevleehgeethefhleejtddtueduudel
    keekueejhfffhfduffethfenucffohhmrghinheptghonhhfrdhinhenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhn
    sggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhoohhnsehiohhttghlrdgt
    ohhm
X-ME-Proxy: <xmx:57JuZ8g3cWNnqsNhW-J3n57J2Nx-ts4rR0i1lvAgOeV0pr3b5GLlfg>
    <xmx:57JuZ4A09ifHGOMDlHC_Nrw-Nuf8PRUBmyllbOD-IZ0F2hC72KhvcA>
    <xmx:57JuZ9L25R1PCXHNx4PsypmSGnJtUsigZhfAjtMggfDJdDIrbycjHA>
    <xmx:57JuZ_BU4G6rP_NrfL38T6ZCBJehLGdN1-C6UrvzmmBUzCDDNWr0wQ>
    <xmx:57JuZ7NRo-RSRiEoe0n5bYrthwH3vKQfRoncEaVj3o0qOOSVTJSjqq5O>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Dec 2024 09:00:06 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d3bb9f49 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 27 Dec 2024 13:57:59 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 27 Dec 2024 14:59:33 +0100
Subject: [PATCH v2 05/12] Documentation: inline user-manual.conf
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241227-b4-pks-meson-docs-v2-5-f61e63edbfa1@pks.im>
References: <20241227-b4-pks-meson-docs-v2-0-f61e63edbfa1@pks.im>
In-Reply-To: <20241227-b4-pks-meson-docs-v2-0-f61e63edbfa1@pks.im>
To: git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.14.2

When generating our user manual we set up a bit of extra configuration
compared to our normal configuration. This is done by having an extra
"user-manual.conf" file that Asciidoc seems to pull in automatically due
to matching filenames with "user-manual.txt". This dependency is quite
hidden though and thus easy to miss. Furthermore, it seems that Asciidoc
does not know to pull it in for out-of-tree builds where we use relative
paths.

The setup in AsciiDoctor is somewhat different: instead of having two
sets of configuration, we condition the use of manual-specific configs
based on whether the document type is "book". And as we only build our
user manual with that type this is sufficient.

Use the same trick for our user manual by inlining the configuration
into "asciidoc.conf.in" and making it conditional on whether or not
"doctype-book" is defined.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/Makefile         |  2 +-
 Documentation/asciidoc.conf.in | 10 ++++++++++
 Documentation/user-manual.conf | 11 -----------
 3 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index a89823e1d1ee5042367bdcca6ed426196d49ce89..4f152077dded75bedd59abd56db5f6f0693908de 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -362,7 +362,7 @@ manpage-cmd = $(QUIET_XMLTO)$(XMLTO) -m $(MANPAGE_XSL) $(XMLTO_EXTRA) man $<
 %.xml : %.txt $(ASCIIDOC_DEPS)
 	$(QUIET_ASCIIDOC)$(TXT_TO_XML) -d manpage -o $@ $<
 
-user-manual.xml: user-manual.txt user-manual.conf $(ASCIIDOC_DEPS)
+user-manual.xml: user-manual.txt $(ASCIIDOC_DEPS)
 	$(QUIET_ASCIIDOC)$(TXT_TO_XML) -d book -o $@ $<
 
 technical/api-index.txt: technical/api-index-skel.txt \
diff --git a/Documentation/asciidoc.conf.in b/Documentation/asciidoc.conf.in
index b89bccf2309d782ba29ea716a132b888c1421669..f2aef6cb79f47cf132b97d88a7e74fb40da8ac8d 100644
--- a/Documentation/asciidoc.conf.in
+++ b/Documentation/asciidoc.conf.in
@@ -25,12 +25,22 @@ manmanual=Git Manual
 mansource=Git @GIT_VERSION@
 revdate=@GIT_DATE@
 
+ifdef::doctype-book[]
+[titles]
+	underlines="__","==","--","~~","^^"
+endif::doctype-book[]
+
 ifdef::backend-docbook[]
 [linkgit-inlinemacro]
+ifndef::doctype-book[]
 {0%{target}}
 {0#<citerefentry>}
 {0#<refentrytitle>{target}</refentrytitle><manvolnum>{0}</manvolnum>}
 {0#</citerefentry>}
+endif::doctype-book[]
+ifdef::doctype-book[]
+<ulink url="{target}.html">{target}{0?({0})}</ulink>
+endif::doctype-book[]
 
 [literal-inlinemacro]
 {eval:re.sub(r'(&lt;[-a-zA-Z0-9.]+&gt;)', r'<emphasis>\1</emphasis>', re.sub(r'([\[\s|()>]|^|\]|&gt;)(\.?([-a-zA-Z0-9:+=~@,\/_^\$]+\.?)+)',r'\1<literal>\2</literal>', re.sub(r'(\.\.\.?)([^\]$.])', r'<literal>\1</literal>\2', macros.passthroughs[int(attrs['passtext'][1:-1])] if attrs['passtext'][1:-1].isnumeric() else attrs['passtext'][1:-1])))}
diff --git a/Documentation/user-manual.conf b/Documentation/user-manual.conf
deleted file mode 100644
index 0148f126dcdf6aca15a5560fb5b122b85b022461..0000000000000000000000000000000000000000
--- a/Documentation/user-manual.conf
+++ /dev/null
@@ -1,11 +0,0 @@
-[titles]
-	underlines="__","==","--","~~","^^"
-
-[attributes]
-caret=^
-startsb=&#91;
-endsb=&#93;
-tilde=&#126;
-
-[linkgit-inlinemacro]
-<ulink url="{target}.html">{target}{0?({0})}</ulink>

-- 
2.48.0.rc0.311.gb6c66824c1.dirty

