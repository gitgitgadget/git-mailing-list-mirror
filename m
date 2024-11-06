Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4ABC1D6DB4
	for <git@vger.kernel.org>; Wed,  6 Nov 2024 15:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730905834; cv=none; b=Tkv1N9Tp9/O7hHVvPBEt6ZStqXxREQl2hIu1OfcJXb2ErT+Dbe9DwnCUohmqBJ7UtuQCgE0X9FKlaN7b1qm/q7EhXTHROJllDT2pAZX2ltFWpy3dt9cbroate9WUZx9eqQCmXzmZdecFkGoeZB/0puHmwalFBm1A3FLSOKYx+YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730905834; c=relaxed/simple;
	bh=67sIWxvKkHNkwt7uzGHIBFcpaEaOrHY/pvy9iGJtgms=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QhInekoGwOUbBr7J/rMLu4S2W/CkTOQKX9gUh/RJBgtay+wZZs5arWugtMddHjYI1At//TflIwXN87hHlBKOkDK63/6nDKw80+fV4BxiS4QW11ZVRLZ3/XyOint8zscUqhoYFXvE4nqeat4msRRJvnISfQa9xI81HEBb6QMWQFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=s2sn27W6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IhfQ7+PA; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="s2sn27W6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IhfQ7+PA"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B47EF1140178
	for <git@vger.kernel.org>; Wed,  6 Nov 2024 10:10:31 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 06 Nov 2024 10:10:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1730905831; x=1730992231; bh=YfEa6uhKL1
	n44pdDa4P4R1qufsyWk5q35kx2LnXzqQ0=; b=s2sn27W6wmMPxjZzlcqYaHzp5t
	oVC118nITGuf6UC4pN5LruBTSXPlZrc6Ay/VTdSafjwwUuvdnrvz8fkimepjzyyv
	Ac2L1K/Kn5Fp2CWll1D2ygmSecBK+C9JKdjw4fd3hq2NZS8JbS6dymLUzmO4lV0V
	jYignTPAwwnpid86RpEn3eWNzVMRmjfSkExiIW1y5lJ5Yy5yvTfecQb1hTyUlnfc
	OaLf985VZ5TXcRn+juMW604F4RMl6KwUIhHPzXSm+QJnyeUYPmAQi6kdN9TL4Qm6
	Dl8YtWdG8OYj/hJnZw2nDoGmww5wwPOr7kWgjHP7c36yehgpnNBlhnTn3TVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730905831; x=1730992231; bh=YfEa6uhKL1n44pdDa4P4R1qufsyWk5q35kx
	2LnXzqQ0=; b=IhfQ7+PA1BRQx8TdIYHmCRMXDnHoAORZSBeYI8kJ4R8FFLhTrGa
	AVM1fzqt2HRv2T8gx7GvpOe4rlO7QPAzTRpUXyGQI4TstcQ3k80qKwrx04nYWGxf
	+dqUkNAzoD1LzLcyW6GunUKKFAUI2SHwAggMTNtv57cZO/iHb3x8IyfOfSAPL0Gd
	hFZwMKubkcl7UlvXnrEVqMGLe04w3JT0TWb13sysbZMGAbSSBM/xg7bQC4vQJIDp
	q4c0t+8V8v09zaBb76lH7G8hWWiUtny0YNEqSQK1ZUu4N98mKfEk1vTNRBhUOC0e
	8/cGziMjk/ZHBXMPEtlQePwcJqtp73k+Y3w==
X-ME-Sender: <xms:54YrZ8XfZTy9Crk7kHmanFrm1_yxfAAyW3xHbwxABE6dwx1zAodNkQ>
    <xme:54YrZwlh_aUiBG63wUwK7nDw-VrzaDMmzzBATZEy6Af4LqdfH2-v66UudeGzFV842
    pBdIwhQO9UkyFYuCw>
X-ME-Received: <xmr:54YrZwa_vIvXGnSPcR_YuPHX5-6KhKRBx4uhvDPJjBJhfHBOSv4_zeXiRlxI8pgzWHdwlgHwGQMLnFB0bn4bu2N8QteDXhQOkLjzKH4cUXXlWw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtddvgdejudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukf
    hfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgr
    rhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeehkeeffeeggedvge
    dvfeefheettddtffejuefflefggfehfeelffeljedvfeehieenucevlhhushhtvghrufhi
    iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprh
    gtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:54YrZ7UlaKWBc4EkG0zReof5uJrjYuOrNqhOe660ny-MB3k8zU9ARw>
    <xmx:54YrZ2lwWPTXRFl1XSwDeH8ijyFs9OlPKS4bxkVZ_wO9OeNJcxtmGg>
    <xmx:54YrZwfPWK5tZt3F2NkV2pSBp82SPbdBy0ChSoeYxAfZaWj0guiE0w>
    <xmx:54YrZ4EB4mTLGjAsnk512mWIsh8nsmvC4Ohfzu6zkZSe6dyhdQFY_A>
    <xmx:54YrZ6tSWPu68JZbQMDC0x2T6F9cG1hv2d9KjC2t697K_a3TOYSxDBHD>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 6 Nov 2024 10:10:30 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 50a1f3fd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 6 Nov 2024 15:10:06 +0000 (UTC)
Date: Wed, 6 Nov 2024 16:10:23 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 02/26] bisect: fix leaking good/bad terms when reading
 multipe times
Message-ID: <cdc06afa6dbb11a0a6ffcdaf20053b66a2fe3974.1730901926.git.ps@pks.im>
References: <cover.1730901926.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1730901926.git.ps@pks.im>

Even though `read_bisect_terms()` is declared as assigning string
constants, it in fact assigns allocated strings to the `read_bad` and
`read_good` out parameters. The only callers of this function assign the
result to global variables and thus don't have to free them in order to
be leak-free. But that changes when executing the function multiple
times because we'd then overwrite the previous value and thus make it
unreachable.

Fix the function signature and free the previous values. This leak is
exposed by t0630, but plugging it does not make the whole test suite
pass.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 bisect.c   | 14 +++++++++-----
 bisect.h   |  2 +-
 revision.c |  4 ++--
 3 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/bisect.c b/bisect.c
index 4713226fad4..9c52241050c 100644
--- a/bisect.c
+++ b/bisect.c
@@ -28,8 +28,8 @@ static struct oid_array skipped_revs;
 
 static struct object_id *current_bad_oid;
 
-static const char *term_bad;
-static const char *term_good;
+static char *term_bad;
+static char *term_good;
 
 /* Remember to update object flag allocation in object.h */
 #define COUNTED		(1u<<16)
@@ -985,7 +985,7 @@ static void show_commit(struct commit *commit)
  * We read them and store them to adapt the messages accordingly.
  * Default is bad/good.
  */
-void read_bisect_terms(const char **read_bad, const char **read_good)
+void read_bisect_terms(char **read_bad, char **read_good)
 {
 	struct strbuf str = STRBUF_INIT;
 	const char *filename = git_path_bisect_terms();
@@ -993,16 +993,20 @@ void read_bisect_terms(const char **read_bad, const char **read_good)
 
 	if (!fp) {
 		if (errno == ENOENT) {
-			*read_bad = "bad";
-			*read_good = "good";
+			free(*read_bad);
+			*read_bad = xstrdup("bad");
+			free(*read_good);
+			*read_good = xstrdup("good");
 			return;
 		} else {
 			die_errno(_("could not read file '%s'"), filename);
 		}
 	} else {
 		strbuf_getline_lf(&str, fp);
+		free(*read_bad);
 		*read_bad = strbuf_detach(&str, NULL);
 		strbuf_getline_lf(&str, fp);
+		free(*read_good);
 		*read_good = strbuf_detach(&str, NULL);
 	}
 	strbuf_release(&str);
diff --git a/bisect.h b/bisect.h
index ee3fd65f3bd..944439bfac7 100644
--- a/bisect.h
+++ b/bisect.h
@@ -75,7 +75,7 @@ enum bisect_error bisect_next_all(struct repository *r, const char *prefix);
 
 int estimate_bisect_steps(int all);
 
-void read_bisect_terms(const char **bad, const char **good);
+void read_bisect_terms(char **bad, char **good);
 
 int bisect_clean_state(void);
 
diff --git a/revision.c b/revision.c
index 8df75b82249..347dabf7f9a 100644
--- a/revision.c
+++ b/revision.c
@@ -51,8 +51,8 @@
 
 volatile show_early_output_fn_t show_early_output;
 
-static const char *term_bad;
-static const char *term_good;
+static char *term_bad;
+static char *term_good;
 
 implement_shared_commit_slab(revision_sources, char *);
 
-- 
2.47.0.229.g8f8d6eee53.dirty

