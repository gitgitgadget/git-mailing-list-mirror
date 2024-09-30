Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D152174EE4
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 08:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727683710; cv=none; b=lA2eT3so8+wmNviszrIwYs+5sOkjbO6WacRkrJVZ2xhUBFdfEdgolOoftz0pqsb7Hj1mzn8rtBycLhtH0K7vkGBOGLyFj3sWraDVe2GOUtyxc7L3QUZZBApmsv89XH6hWWLEKoX4fFxzJQoxRxZ4ndgHK9CWhv1h9P0C8ZU0Sgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727683710; c=relaxed/simple;
	bh=c0fyZc63wq2cbPQ6DrDW4EgT/pKQb2pMBYHSNKsidAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EQn23DsUfmAXt5TqQEkFB2l2+ieCoABPJIMeLrdhi/M4p2uOvhIdCIopzWLRidQpv2MSKQZMS1mvtZPSqGXHTCybnLsSbSJ19cSjjgNonlAtVRrQPImMMPMcIcOeDTJXASWWjTMUkupdyyFADYS5E4ucVnB/ULc7MaUFECquWcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QnKDdiof; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=d5tp1s5S; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QnKDdiof";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="d5tp1s5S"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C907B114021E;
	Mon, 30 Sep 2024 04:08:27 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 30 Sep 2024 04:08:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727683707; x=1727770107; bh=TqLGr9QWuP
	+PcHldril6xKjpO4o6J30kd8WpSOaR7XY=; b=QnKDdiofWgSzIsPxyTKffsJOFl
	s7vMl5z8pT4h/WVzVgCs+xc97trkqByaSzq5MItBoP5sAMKKwWMnEL0TAEK0Yy/S
	25OrV5BUdjy3a22ehRJ/oWJL2YXSgSMDjxUQizOPXM1IUjD1LA+rON91eRGibQYU
	mkEWFI935aAgYtcgbmz52Gwp/wQQYJftjF278V7OrSzVAvWVmlvYBf48eB8PjODT
	vcomTKqUVJ5mh0xPoX0SQnd1bJ6ONYsj6+YOm7mQMlKA6T24hue3i2NyXWjRyaNQ
	ajitrey1ZrVdsYxfkIIF1LleFILxc2BLcbe0sior0EY5w9/En/f8LOiHVnWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727683707; x=1727770107; bh=TqLGr9QWuP+PcHldril6xKjpO4o6
	J30kd8WpSOaR7XY=; b=d5tp1s5SCQA6sr4LPtb/rhCeWZPmL1S0oO1T3u+j+XvJ
	3ln1DtvNYEBJjxVonf2vO9Q1IVbE6rv4pej7laRDk6Haz7ug6ZYY1d9rt0KLpbg7
	UH29DDcvvgtL1l0Ojqr1pNWXVFxCE3/s6Y4ayMd7s1lazcSBub17aVlQhMHxXT0a
	1kJBRJRbHhd2/0XqYWbIfIz35S8i96zROG5lO5VfHKLH2eGQu9DiRLCMihudqZj0
	WEelE+diYpu81+ybMrWokz006d/lqeCPM2J8gi5KfPrdJDv6yJIeTjMGV5ommZio
	OkfjtF9uSwpeKO3/F9N6vvrstoTe3GUzOKsh6OAzZw==
X-ME-Sender: <xms:e1z6Zotwjr3QxOITt9fmYjoC8JGC7sY3YEWbL8YFvzwSs_7XZ8NaOw>
    <xme:e1z6Zlfp3EAnkh7ru-HPD8N8bCJDvW_yM7VmuOig90Ic1iYrvU9C0rIVCJqZ6TTte
    ZKtbZZqcyUD9nnutw>
X-ME-Received: <xmr:e1z6ZjzcR50asD5OvnGgLAJqr4Hl9YOKOelFceH6tzw6p2WntnTmEMVUXWoRJpp2gw6iL2tacEKluBIwx6kZT3FNPoFnULAOUuuciaq1dTx7XKY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddugedguddvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegvthhhohhmshhonhesvggufigrrhguthhhohhmsh
    honhdrtghomhdprhgtphhtthhopehlrdhsrdhrseifvggsrdguvgdprhgtphhtthhopehg
    ihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:e1z6ZrMZqttZvFmxWD8WjGy_WXO9jpnf9leBxRC7LoiBzlgOUAGrDA>
    <xmx:e1z6Zo-Hy4FRLa9lVHsrGIBrmvYhFR4ltb0836NJrkTueNq01TdTyA>
    <xmx:e1z6ZjXOLZq2ADba1rm-OaSYX5N6oo4OGVLUpNpVYxeWyEn1nE3K5g>
    <xmx:e1z6Zhf8PU5YaIDmYSATiZsYRjz2cu2xyyC-yY1TkQBHTL62WfZEFA>
    <xmx:e1z6ZsZW1KKd_6p0VtGyeezz2mbJrs0nDxuuxfzRlxAiRUhDUN1y0tVV>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Sep 2024 04:08:26 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 39370104 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 30 Sep 2024 08:07:41 +0000 (UTC)
Date: Mon, 30 Sep 2024 10:08:24 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH v3 05/22] reftable/basics: handle allocation failures in
 `parse_names()`
Message-ID: <922783708def23c7e0c73db846076cf5e242154b.1727680272.git.ps@pks.im>
References: <cover.1726489647.git.ps@pks.im>
 <cover.1727680272.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1727680272.git.ps@pks.im>

Handle allocation failures in `parse_names()` by returning `NULL` in
case any allocation fails. While at it, refactor the function to return
the array directly instead of assigning it to an out-pointer.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/basics.c                | 20 ++++++++++++++++----
 reftable/basics.h                |  9 ++++++---
 reftable/stack.c                 |  6 +++++-
 t/unit-tests/t-reftable-basics.c | 11 ++++++-----
 4 files changed, 33 insertions(+), 13 deletions(-)

diff --git a/reftable/basics.c b/reftable/basics.c
index 3350bbffa2..5ae6e6acdd 100644
--- a/reftable/basics.c
+++ b/reftable/basics.c
@@ -135,14 +135,14 @@ size_t names_length(const char **names)
 	return p - names;
 }
 
-void parse_names(char *buf, int size, char ***namesp)
+char **parse_names(char *buf, int size)
 {
 	char **names = NULL;
 	size_t names_cap = 0;
 	size_t names_len = 0;
-
 	char *p = buf;
 	char *end = buf + size;
+
 	while (p < end) {
 		char *next = strchr(p, '\n');
 		if (next && next < end) {
@@ -152,14 +152,26 @@ void parse_names(char *buf, int size, char ***namesp)
 		}
 		if (p < next) {
 			REFTABLE_ALLOC_GROW(names, names_len + 1, names_cap);
-			names[names_len++] = xstrdup(p);
+			if (!names)
+				goto err;
+
+			names[names_len] = strdup(p);
+			if (!names[names_len++])
+				goto err;
 		}
 		p = next + 1;
 	}
 
 	REFTABLE_REALLOC_ARRAY(names, names_len + 1);
 	names[names_len] = NULL;
-	*namesp = names;
+
+	return names;
+
+err:
+	for (size_t i = 0; i < names_len; i++)
+		reftable_free(names[i]);
+	reftable_free(names);
+	return NULL;
 }
 
 int names_equal(const char **a, const char **b)
diff --git a/reftable/basics.h b/reftable/basics.h
index f107e14860..69adeab2e4 100644
--- a/reftable/basics.h
+++ b/reftable/basics.h
@@ -38,9 +38,12 @@ size_t binsearch(size_t sz, int (*f)(size_t k, void *args), void *args);
  */
 void free_names(char **a);
 
-/* parse a newline separated list of names. `size` is the length of the buffer,
- * without terminating '\0'. Empty names are discarded. */
-void parse_names(char *buf, int size, char ***namesp);
+/*
+ * Parse a newline separated list of names. `size` is the length of the buffer,
+ * without terminating '\0'. Empty names are discarded. Returns a `NULL`
+ * pointer when allocations fail.
+ */
+char **parse_names(char *buf, int size);
 
 /* compares two NULL-terminated arrays of strings. */
 int names_equal(const char **a, const char **b);
diff --git a/reftable/stack.c b/reftable/stack.c
index ce0a35216b..498fae846d 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -108,7 +108,11 @@ static int fd_read_lines(int fd, char ***namesp)
 	}
 	buf[size] = 0;
 
-	parse_names(buf, size, namesp);
+	*namesp = parse_names(buf, size);
+	if (!*namesp) {
+		err = REFTABLE_OUT_OF_MEMORY_ERROR;
+		goto done;
+	}
 
 done:
 	reftable_free(buf);
diff --git a/t/unit-tests/t-reftable-basics.c b/t/unit-tests/t-reftable-basics.c
index e5556ebf52..1fa77b6faf 100644
--- a/t/unit-tests/t-reftable-basics.c
+++ b/t/unit-tests/t-reftable-basics.c
@@ -72,13 +72,14 @@ int cmd_main(int argc UNUSED, const char *argv[] UNUSED)
 	if_test ("parse_names works for basic input") {
 		char in1[] = "line\n";
 		char in2[] = "a\nb\nc";
-		char **out = NULL;
-		parse_names(in1, strlen(in1), &out);
+		char **out = parse_names(in1, strlen(in1));
+		check(out != NULL);
 		check_str(out[0], "line");
 		check(!out[1]);
 		free_names(out);
 
-		parse_names(in2, strlen(in2), &out);
+		out = parse_names(in2, strlen(in2));
+		check(out != NULL);
 		check_str(out[0], "a");
 		check_str(out[1], "b");
 		check_str(out[2], "c");
@@ -88,8 +89,8 @@ int cmd_main(int argc UNUSED, const char *argv[] UNUSED)
 
 	if_test ("parse_names drops empty string") {
 		char in[] = "a\n\nb\n";
-		char **out = NULL;
-		parse_names(in, strlen(in), &out);
+		char **out = parse_names(in, strlen(in));
+		check(out != NULL);
 		check_str(out[0], "a");
 		/* simply '\n' should be dropped as empty string */
 		check_str(out[1], "b");
-- 
2.46.2.852.g229c0bf0e5.dirty

