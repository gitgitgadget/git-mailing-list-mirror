Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C6C1AB6FF
	for <git@vger.kernel.org>; Fri, 13 Dec 2024 08:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734079750; cv=none; b=jhecHROJ0D0Vu9vIKVBsWjvqZIvDNDyxLnXzx07lRAnSe/0eFGtKOKRNUU1LFgcUt477V3Vg1ecaEa8HPF7DTSTM3l0x5I3xV6g56Pzv/xQozlp1Chj8IW9xz+Dg5cje2pJK7DmPzrY7vEm78GkMT9r1eZDtkCxuQg3YXJgNiow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734079750; c=relaxed/simple;
	bh=/PdkcsFWIQARpiHUpgs/ZkdJ9HFqVD7AAkLGY0Qa8Is=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MxadULW9yWFWLRf734+v+Oo8UQhPOVVOjaEtU14FTy2Jkw6Plf4zj2gyQdwNVONgSXvi3v2D+0QiFSJgrvXcd5uzPmnOr83bfIBj425hYCE/fz4ghXBGvD9UbizaMwd1sVnWbRKMuXDzbuZk+qMveVLNTKhZ5SebBUeoFftcZe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=tW635vq/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nYHilIv4; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="tW635vq/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nYHilIv4"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D0AD125401F4
	for <git@vger.kernel.org>; Fri, 13 Dec 2024 03:49:07 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Fri, 13 Dec 2024 03:49:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1734079747;
	 x=1734166147; bh=j0wT+/kY998aNlD5W1+lt3IGG0XErfdsTcYxxvb4T88=; b=
	tW635vq/7AXH9Hm7y5Y0feQDqclbBw1utaDpATwiWn7H7g2njbI1Eem4Z8pCZXaj
	XR2JBYKSjGmPFZSSV84PRnGQzjSPad9KkIoP04KYkDy6oiMWvY4/eLTMXWmXEgql
	Mr0YBoZrW4gV4dkZeEd7LI7WuZVO3rdl3C1YukRwfHdXr3aMXVYRdTgjfAqcDjeY
	O1XRlUQef42Hfm0d75drzsh18VW0IbBFiGuM1B3L+12R9J+ieQbvmXeiX/WbKRa4
	ND6JT4I0nm5clzV0yEJcu+lGeiO0E/g6dtZaEW1hmN0PiPOpudPa4a8kb/HBaihO
	j/PEka1+WIHsIac/+UHLEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1734079747; x=
	1734166147; bh=j0wT+/kY998aNlD5W1+lt3IGG0XErfdsTcYxxvb4T88=; b=n
	YHilIv4QrLUr8i39s5pCdKOtxPBQ0GWNUR59N1UoXlntFcxgtJbrRLYCzLmarRlr
	c6LHpmmDo9sJ6ehlfqosRAQX5XwDBwvtISEVItSginw4+GbBfQt6CeYA3osYgkHI
	eAocyjFG2p9NLseTj5fhOYNjD6Y2lJp0haPRd8ItukISjDMGppXc/LnF8OIVKcyX
	5f6ns5Qwb70pSOJe2aL+5OW73mkXPsuyvO4BB7dZMjipojEks/AmpeQyZc3vAZ4x
	c0/oLDFnnicbKqUzrd0vH4IsNRMUAC9wdDefb7e9tg36Ahrf8xUqL7tGtoWdkbzx
	adNVGO8gTwF6LHbrYTLZw==
X-ME-Sender: <xms:A_VbZxwjb1fRmzpSE2K4VngQAZ1dt4u4p4cDWdZ7tEQDRdlqEjwUuA>
    <xme:A_VbZxQ3owGGauv6zpsnzLjsLDFmc4HZFnbs5aYH3mlijL5M2FWYx33zWVxzJ4ouI
    -bykkWLxVaRnbJWDQ>
X-ME-Received: <xmr:A_VbZ7XDymtdIUEa6Lnn7i-dCf8CMt_VSjLZveGvk2a12-cTvyuYxNdyTEWtTqFTXa1ZhD2AVVTgYos8910yirfqPzCUOfErJleZYA5c28Zcm4E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrkeeigdduvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucgovfgvgihtqfhnlhihqd
    dqteefjeefqddtgeculdehtddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeer
    tdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesph
    hkshdrihhmqeenucggtffrrghtthgvrhhnpedtuddvfefftdevleehgeethefhleejtddt
    ueduudelkeekueejhfffhfduffethfenucffohhmrghinheptghonhhfrdhinhenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdr
    ihhmpdhnsggprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:A_VbZzhe6bYw-CG_Y9NaduGUZb_D7iGsAMdma09ooMpqOAEL51eiQw>
    <xmx:A_VbZzAy5zPQYJW3zaNvqooXb4gMJK2zDc1mXF4u5bM0xQLNph9rPQ>
    <xmx:A_VbZ8IarjUlZFpCQQY113ZLc60jCt4J29bgr5vSP5s5LQov9wnVKA>
    <xmx:A_VbZyBCoaCPkoFZBNFNBAye5N67lNbxFa0tdLbCQWoCOwOb0TPaFg>
    <xmx:A_VbZ474CAdIx51HitdAcL1JTGOiN1H25DWwGdJ27wGuzwOgFRa_ediF>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 13 Dec 2024 03:49:06 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 3e221e68 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 13 Dec 2024 08:47:25 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 13 Dec 2024 09:48:34 +0100
Subject: [PATCH 05/10] Documentation: inline user-manual.conf
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241213-b4-pks-meson-docs-v1-5-0c7895952cd3@pks.im>
References: <20241213-b4-pks-meson-docs-v1-0-0c7895952cd3@pks.im>
In-Reply-To: <20241213-b4-pks-meson-docs-v1-0-0c7895952cd3@pks.im>
To: git@vger.kernel.org
Cc: 
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
index 3392e1ce7ebc540784912476847380d9c1775ac8..31c17f7d655e1dcbdde315115609b798363e7328 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -367,7 +367,7 @@ manpage-cmd = $(QUIET_XMLTO)$(XMLTO) -m $(MANPAGE_XSL) $(XMLTO_EXTRA) man $<
 %.xml : %.txt $(ASCIIDOC_DEPS)
 	$(QUIET_ASCIIDOC)$(TXT_TO_XML) -d manpage -o $@ $<
 
-user-manual.xml: user-manual.txt user-manual.conf $(ASCIIDOC_DEPS)
+user-manual.xml: user-manual.txt $(ASCIIDOC_DEPS)
 	$(QUIET_ASCIIDOC)$(TXT_TO_XML) -d book -o $@ $<
 
 technical/api-index.txt: technical/api-index-skel.txt \
diff --git a/Documentation/asciidoc.conf.in b/Documentation/asciidoc.conf.in
index dbe36a52eabfabef59e31d3be6518549e4f90206..83ddbb76f65d7a041e4e787a81e19ff1db1d9d55 100644
--- a/Documentation/asciidoc.conf.in
+++ b/Documentation/asciidoc.conf.in
@@ -25,12 +25,22 @@ manmanual='Git Manual'
 mansource='Git @GIT_VERSION@'
 revdate='@GIT_DATE@'
 
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
2.47.1.668.gf74b3f243a.dirty

