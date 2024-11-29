Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9051A00D1
	for <git@vger.kernel.org>; Fri, 29 Nov 2024 13:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732886035; cv=none; b=NJWLZFqva9SvX4CgtQVd4ZRuQHVHqbyNjrfT9mB/x64p2FyNEYKkQbyUKJKjeN+aiM2OKGPPBuGydmXdb4GH8nIYAleUFzBUdpzqHIPZIvvjQdZGWC2eJdDubAYXPKqXR1zqVmQ7+gKkvhjprX7euobl3gxRThh231gFpSw7wLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732886035; c=relaxed/simple;
	bh=OrIjeXuF9w1rHOW5ZBOKjcpZv9boHrkcBksyNW6vs6M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jFPpN0eqSzCWJd6kpnBBlgDRWpreD27tBoid0KU1LXEWXUYlowdKZk462mYRwyW977S8LMWKJpNkMU2Xq06A7EGfvAkY+vZZx56dFMOGcDfbihutEuToqKDrP228jELor9gKuqxj9V88rRM1sM11m6uo5kYjbk4XMiqa3qUpp+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=sUvpTbKe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Y98USHCt; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="sUvpTbKe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Y98USHCt"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id 5B59511400F6
	for <git@vger.kernel.org>; Fri, 29 Nov 2024 08:13:52 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Fri, 29 Nov 2024 08:13:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1732886032;
	 x=1732972432; bh=1RpNUTixPgdVutE0Y8H/jYG71yZfDcWpSTddOqURV3Q=; b=
	sUvpTbKeXcx1g3IHegZZNtsUb9Q2UdrC1EbLtI7McqLSmwJdcI+HFNoZzhIrvMVr
	j1i1RKd9rU8TYMK66klgyBNolSKRICBmZAkm/niB3K8jwB2pWcFafre18FcY4dFO
	FOJaqcM5Pz6h8uNFKDv20hG/7BKfSYxnyQf9PNAfJllOz6DbwRD1qgpYNUnswiR+
	eX58KF7pngscAageKpEPxv6Twv7uS9aSDnALpWfVIFZI/FW9D7Uksecokym/FuOb
	fndGNbto+jDvIW7aWkENwLhYTSc+weGSF7V2D7jCMpTPYCqDHEmDD29rzMUhu8k5
	X0fy7W0t+OwITmNZs65T+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732886032; x=
	1732972432; bh=1RpNUTixPgdVutE0Y8H/jYG71yZfDcWpSTddOqURV3Q=; b=Y
	98USHCtuPBN0qwrYHMJPDB7AsYevotOl5QnfQRjQ9KNcI3BwW0mFDxiLpjyJh9K2
	EUvH40rbWaDCZ8rGHuuSktKxZrK+dyaoRJk22nJwGeHu0Vlt7k1gzT9RXVZiePEt
	uc7ARe2UvGAKTj/eERK5FCQt13P4ymMG5x3rjAorh7x3sdSd7e6cpth9UqZ+aQP+
	/yKMmE4y9QV4jDF/sSWBIWCui8hh9AxQeCB0mOZQVGNbL9y6kma8R/e6mohX8sZ1
	PdowUcJXVrf6m5prUOvGm8ebaoOg5JYybzO1a8+oZLGisRarBul6mQ0DbeDrUIO8
	G9JlWHPpOsY80RSM5lIQw==
X-ME-Sender: <xms:EL5JZ1iYXqiOjM1UP8eIgKrFqlBwO8mRJaLVr_L5MydXAy3Xae8eBA>
    <xme:EL5JZ6AJPLbzyDR9LhAZbkaPk4U-Edk8FhM1e9T7rdojBj2vOlLB3t0u6RAt0AsAv
    YPImYtXnvhhX1mSsA>
X-ME-Received: <xmr:EL5JZ1ExFh-zR6VZ-79OY2YdibAFd6_O_3KOz80PfjuufiP5j-ujrCg1xQsilzSKmdhsh9k84yAdEQUpUm2z-Y1WIbWNKea88_FLLzibFlCdzkqukw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrheefgdegkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephfffufggtg
    fgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvd
    ekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:EL5JZ6QxUSYB86M170-mXAGb6GBCpsYvhsteijK-zR4gu2Rwr-LPfg>
    <xmx:EL5JZyw_n3ommR7tmce_y0JBQQicEoVa_B96zq3kFa82a_eXbd87BQ>
    <xmx:EL5JZw4KBi4V3Kh3w0dDUjnF99YG4h0BR9AKhNmIG9IfRZv2LfpzPA>
    <xmx:EL5JZ3xtIOEklceYPFE7Shq9SrQySWhUS7Weo22ZpuA6Pq2GiOFA4g>
    <xmx:EL5JZ3pNV4LCXlYeE5gK1nKU9p_XyMismF-AnBCEQ9hQ_rPq5Chkontw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 29 Nov 2024 08:13:51 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 08711739 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 29 Nov 2024 13:12:42 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 29 Nov 2024 14:13:31 +0100
Subject: [PATCH 10/10] daemon: fix type of `max_connections`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241129-pks-sign-compare-v1-10-fc406b984bc9@pks.im>
References: <20241129-pks-sign-compare-v1-0-fc406b984bc9@pks.im>
In-Reply-To: <20241129-pks-sign-compare-v1-0-fc406b984bc9@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

The `max_connections` type tracks how many children git-daemon(1) would
spawn at the same time. This value can be controlled via a command line
switch: if given a positive value we'll set that up as the limit. But
when given either zero or a negative value we don't enforce any limit at
all.

But even when being passed a negative value we won't actually store it,
but normalize it to 0. Still, the variable used to store the config is
using a signed integer, which causes warnings when comparing the number
of accepted connections (`max_connections`) with the number of current
connections being handled (`live_children`).

Adapt the type of `max_connections` such that the types of both
variables match.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 daemon.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/daemon.c b/daemon.c
index bf313bc21a0b82a12064c534af78c9ad51be78e6..5ca70335fc4b94b6f3cadeac309316b70dd9377f 100644
--- a/daemon.c
+++ b/daemon.c
@@ -1,5 +1,4 @@
 #define USE_THE_REPOSITORY_VARIABLE
-#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "abspath.h"
@@ -801,8 +800,7 @@ static int addrcmp(const struct sockaddr_storage *s1,
 	return 0;
 }
 
-static int max_connections = 32;
-
+static unsigned int max_connections = 32;
 static unsigned int live_children;
 
 static struct child {
@@ -1315,10 +1313,11 @@ int cmd_main(int argc, const char **argv)
 			continue;
 		}
 		if (skip_prefix(arg, "--max-connections=", &v)) {
-			if (strtol_i(v, 10, &max_connections))
+			int parsed_value;
+			if (strtol_i(v, 10, &parsed_value))
 				die(_("invalid max-connections '%s', expecting an integer"), v);
-			if (max_connections < 0)
-				max_connections = 0;  /* unlimited */
+			/* A negative value indicates unlimited children. */
+			max_connections = parsed_value < 0 ? 0 : parsed_value;
 			continue;
 		}
 		if (!strcmp(arg, "--strict-paths")) {

-- 
2.47.0.366.g5daf58cba8.dirty

