Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E519419D060
	for <git@vger.kernel.org>; Wed, 20 Nov 2024 13:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732109992; cv=none; b=CzZCD1x2l74g8ghRZPIePfw/amvEs1IeaZL1kH2W+dqQRnXP4+TnKf6lPdAQsEMqWKmx2a8l6owA7b5b+nQ/1l7KN8F+07WwbsYBYW8Da8I7NSqTwITjnFuwdzlIHppQSjse2CAOAYn1TSMQyreHwm6hEtKXZhc07xGNbXNYyw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732109992; c=relaxed/simple;
	bh=ijzJ/0pOufCEK+9JGYdulblWmmJlmDeBFQSBX7elUDs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d/dklOqUxKvkAa3iccda7qaHMep36CXC0Ezpf8EXPxYpACONJvZoWkRV5KG94ObuMeTZGz2dGMhoV95cumnlj3wmGi5glIbQCpRzazCwoN019+W0SJHXDdmnvCZgM5EBqDU7TQ0UyPxH9D9QPXjzPpDlaHW0bQccIeY0s5rVOHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=P3cMLmQC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=4XCIgHBb; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="P3cMLmQC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="4XCIgHBb"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AED6811401D0;
	Wed, 20 Nov 2024 08:39:49 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Wed, 20 Nov 2024 08:39:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1732109989;
	 x=1732196389; bh=2hc4BW9h8WuiEuy06//YD0KUbz8sKDMmAiOn6+1D4wc=; b=
	P3cMLmQCj8ZrgwepUcxF/xi5MIMkVOKHOxEdIWGIXUExtht20SC0dhO5DHhkRPup
	QO3f8ORZzzRndF4lZvmYNruvFurb+QBfJq3Jtj+ocWNJNJcK3z48qTc84UvT7RJZ
	86qpyqxFdGCXo2aeAxqECFr3I0uctczHhusZpvLF4E4sClMIt09wmSVsrxjxCnM0
	biexluWkag7HJuDJTDOeEILyaxMQVzQZ1o0DH6Mu32z4qvg7rLKl7mxOku1L7DHR
	hKDGGNSfDOef3dCCSLp3YsHue0C2uMmuVwo+O5mIyS0BbwpiW/CWcAzLRbxLArBk
	o25JQDeKWrdcNllMzBAYMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732109989; x=
	1732196389; bh=2hc4BW9h8WuiEuy06//YD0KUbz8sKDMmAiOn6+1D4wc=; b=4
	XCIgHBbMzStD8lvQxQ6SPHCKi4SkFJKN0rRUwGub4MDYvzchHkq3M1K+DzfR0Hir
	6yTZOZdzLwXlVIixVLg23w14ctCye15yVkH4cmAvrCwPWAink5G11SoKetiZWjEQ
	j+m5ay7ydpokk6STs7YauNmt+zN90/IEtp2MUZyeym2MBV8OTS5Ofoeoy5Z1D0ku
	nIwh2vcytbuPicFJyZ9fyYoFdUzMYDvZyab+p2TUBAwded5ONtKVQq9IbJtjJCoQ
	wUcOYurqOqH97wTuQ9oPAGbnjeSZKJ1kSnGJDqDy7JIhxqwinEhuS+LNnMU85mgJ
	GNNYL3800fl+OdegEF3pg==
X-ME-Sender: <xms:peY9Z5GfMQqLrtfVe7YpcufXl_FQc0-9oQapzm31VO3ua74tFTkQUw>
    <xme:peY9Z-VSHwyiOfg9I7DTu01wUMzwk7l-7J3JAJTlA4UZfut4Dqjk24-xkAELzmLro
    V4a6PvvL9EHt4proA>
X-ME-Received: <xmr:peY9Z7JhTEbVeXW1sqJ6wEOQDGG8qH_eK-v9xKB8FZEfQLOXSm68NChgbFpg6J_sj62sV7IIm30-_g7I3giKQqkSkZGa0NqReqg_4RngNU20Aw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfeeggdehgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkeduheej
    teekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprhhjuhhsthhosehgmhgrihhlrdgtohhmpdhrtghpth
    htohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdr
    nhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:peY9Z_HwRj-7QinPDrKo7queDxqpblZ9uE8h47oUcmnBBzmvNhPDBA>
    <xmx:peY9Z_XgHAZzc59zhIG7uKpxAlPIjnqfIxpVn_IGp7XBFdUoRE86UA>
    <xmx:peY9Z6OCKuXPPne2_ry1AYmcJS2di44HnEQyBQth-JlrWBixp4cmFg>
    <xmx:peY9Z-2iWf9ZiTrqYj9EKPecJlSZTifFej_q9GpsQRxACGmdQ9qNng>
    <xmx:peY9Z1zC8aqCGYUEX4p372F_lpUYix3q63oyLPKk7A_9YomB0B1kIir0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Nov 2024 08:39:48 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ec24f5c6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 20 Nov 2024 13:38:55 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 20 Nov 2024 14:39:31 +0100
Subject: [PATCH v3 02/27] bisect: fix leaking good/bad terms when reading
 multipe times
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241120-b4-pks-leak-fixes-pt10-v3-2-d67f08f45c74@pks.im>
References: <20241120-b4-pks-leak-fixes-pt10-v3-0-d67f08f45c74@pks.im>
In-Reply-To: <20241120-b4-pks-leak-fixes-pt10-v3-0-d67f08f45c74@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>, 
 Jeff King <peff@peff.net>, Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.14.2

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
index 4713226fad4e16ebbda4ba2e8d13c6eaf7d4bfb2..9c52241050c14ecbf3f7950a0c5e7b962fcaa541 100644
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
index ee3fd65f3bdb89611d7575239ee79e8c50bcd703..944439bfac729cf092d6c5962c9edff2321002e4 100644
--- a/bisect.h
+++ b/bisect.h
@@ -75,7 +75,7 @@ enum bisect_error bisect_next_all(struct repository *r, const char *prefix);
 
 int estimate_bisect_steps(int all);
 
-void read_bisect_terms(const char **bad, const char **good);
+void read_bisect_terms(char **bad, char **good);
 
 int bisect_clean_state(void);
 
diff --git a/revision.c b/revision.c
index 8df75b82249b36e7e3ee9a4a151f085c189acc45..347dabf7f9a1a87765150ec998deae9b6709b5f6 100644
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
2.47.0.274.g962d0b743d.dirty

