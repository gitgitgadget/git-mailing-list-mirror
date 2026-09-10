Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C52B4A2A47
	for <git@vger.kernel.org>; Thu, 10 Sep 2026 15:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789052971; cv=none; b=FDp/ygbN7Y4ZBg8llbYfJINC8VWM/GZe5GCqI068O8S7qYacr+Sp3C5p8HpSrPrlRQyRrM9Oiq2LhGu/5p2RlsOkO6raiOqteNkZGPpqtmYBijCo7x3qHmr9TeWgXprbpJZZxtmTZqxkTvJ1J+IiDK1vttIbZ6yIGex2CzpljDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789052971; c=relaxed/simple;
	bh=qUZrhrElIydJedk4kLCwJCia0+g5yK/4x+MXoxXYSKQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dU8O7Eky6w37beIXutQ20ogat+6O+uNjbNntNHpd/8YJrgnRUFbIVUoLofQOLBJfzSCRqxaCFXz9/qvU9a4He4BSW28e3fyRlX3/BnCSHyepE+LMXTrzeropxb8GvpPagHwAIWgSFc7yua3YaTUVBn3u+hPpMMxJGISSoABmcY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KyeOJAA2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AvCPvyHh; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KyeOJAA2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AvCPvyHh"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DE6DF14000C1;
	Thu, 10 Sep 2026 11:09:22 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 10 Sep 2026 11:09:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1789052962;
	 x=1789139362; bh=cZUetpLm2qBawAl0VrzkdOEqlTIZz5ccX0YwDqOXtoI=; b=
	KyeOJAA2A7OBqetzmopL7Jr3Lj37zZ5bFfgslMOXzw8J1ByxjNiB8VupxYJmlU5c
	FxP8fQOL3xWgwlgSD/dLGbqJB4g2uoVojdDuyJdE2H6eK4uM0w7Mr6zxHKnFnIzW
	oACNCP2m2/wuziB54p6y7ZlAhza7HMg5YjAcF63/sTMd7jGy2oQXjz1EfKeOQqAh
	yWnQuiB6qSpigaibg/sXNl3OO+FwYcMrl84G6rLeh1854cCddbUvydPCKTj+bWQK
	mO4p1flisiaMlaflpOZvic+pww/9NGLJ0W7lmG7w4nHxE090QTHOXwEyoQSMDpPe
	DY5qJQtv7CVTaVLEnyFT0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1789052962; x=
	1789139362; bh=cZUetpLm2qBawAl0VrzkdOEqlTIZz5ccX0YwDqOXtoI=; b=A
	vCPvyHhUZ5PyJE3KMpoMQ7rFBuDFK02tUDOFMPByy4ixRXMg/43hqjF2zhIrSDwX
	FurBAfbRUMbKKtnYirNj7U/LuooSq82D7dhLqSrCcscDVIWAslMtOyl0xGoCIhDd
	4IPRxWfZud+h+I+w8Jr4L6/4zmngAES81hSVNChpDqdwrCjQ7PP0/V03/WW+V3L/
	y5BK7B2er561256/Qv2Zm7+emXXOs5/hiVeu3HVkULw+fnOlVYOn+nBi7yU5z+M5
	/klOFnELYM4qB4rZLIySDE0S/RT3GRMl6C++IxsXLElbBdqs9K11UhWIfrvHU+tU
	ITvWEdKJyQeA+s+1AP0SA==
X-ME-Sender: <xms:IsiiaprybFzoFADLV2j-uuiwVaFq4_1kY0LhHDQqSH9hmhoHFRCIlA>
    <xme:IsiiaiiOfomNr8bA_FXrqIx4UFQy56pLbALbNVJQuy4Hef9x7mRdGfgZINNCKy7iB
    tPK0CTBpjafkm8DaoVVat5De0GPAIYhwtKVMcKXPIMbQ2yMwYgD7w>
X-ME-Received: <xmr:IsiiaugJjZ5TKhg7kJDYpcZEKQq0SFsfNmC40RlemDDk4DlOzuJGNg>
X-ME-Proxy-Cause: dmFkZTFjMmORKiXYV5v4c7NqnDJufwejPDJi1cfPFm3mx0u8apQc0AvUhXFmyzPKLwg8qv
    gQxPujDla2ha2YRE4ueBGSHTp2xHkvls64y8wjIVNLvc9l/sEDZfcXZap63aj3KkvUT9tA
    H2U0ckPWE/epx57Ag4Ss/N1/kA7as8GrJQMRCubUFIbNx/x2/MBs1looTD1hAugKQeEImK
    WDDPtry92G1OoHWjevAppdv0F7IFYLEnNTxCW6tl/avjrRnkRSojpVwSaHdeKJpTM5NZO5
    tVPOhv3o3xBm0EQ9pB/dAdKzLgiyjpPlwQRjb18DWYa10wiyqKzjezMdYFE0HJJO4z6vGA
    Ptwt7YSy6teuIeT08ZZ71FwhOhK4Kno03mIqi6ZGxvmyrfX7xQ38Hxu8QuPudq6VyzrPCk
    A4pmDKiejdfHIWS23kkv2Al548EoCiN2Y6z0ohrcHs2FYBtNh5cd8U8YlfqxMGdCBqQmtj
    DIA98CXFwiLyAwNAov3NyfyjG98/aZi7s+RyFJs5gzDck5nS0+9TbJ5B9Yser9w7ZPfR9+
    sE2+ws5SePBhVL21WlCuiIAyV9AAL+iFzbMlk+AuUy2eqeIPm3JESEEOzJRbLdXbhTNO/b
    o3TTulwvdgAmeANJbQbgKjH2vPW0QK+IIc/UPAW00khUANcV9LnhqHMGZwxA
X-ME-Proxy: <xmx:IsiiagjSdBCZu8Suziqom7zhxa2G5aqKqBbVW-9lqMlQ9iDnJcS4QA>
    <xmx:IsiiamJa5rrzsyF5rBHIwOrsnKEBk1yV4HiH0jDn5YbO7lsuymhigg>
    <xmx:IsiianHhnNvJna27ja6IwmTE58Ag3GdodJIKQOyChLgL5GfB6V2hiQ>
    <xmx:IsiiaiTLvJyQxZrkI8q7HNp5VdqnoC5VBwBqHqiyf2_JKCWT6fI0YA>
    <xmx:Isiian9JbyNJFS5_J3LKD9x2kdwJLSTrGd2QReP1N-2FKCu5Oy3ffkXM>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Sep 2026 11:09:21 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 325fe558 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 10 Sep 2026 15:09:21 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 10 Sep 2026 17:09:12 +0200
Subject: [PATCH v5 2/9] builtin/clone: defer setup of the object database
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-pks-odb-write-alternates-at-creation-time-v5-2-8d10c4238edc@pks.im>
References: <20260910-pks-odb-write-alternates-at-creation-time-v5-0-8d10c4238edc@pks.im>
In-Reply-To: <20260910-pks-odb-write-alternates-at-creation-time-v5-0-8d10c4238edc@pks.im>
To: git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>, Junio C Hamano <gitster@pobox.com>, 
 Justin Tobler <jltobler@gmail.com>, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2

When cloning a repository we defer initialization of the reference
database. This is because we don't yet know all details required for us
to initialize the refdb in the first place. Most importantly, what we
are missing is information about the object hash.

We don't do the same thing for the object database yet, but here we
essentially have the same problem. While the "files" database does not
need any information about the object format at creation time, alternate
backends are likely to require that information so that they can
properly set up their data structures.

Besides this forward-looking future proofing though, we also have a
second use case for deferring initialization of the object database,
namely alternates. When initializing the object database we do not yet
know whether we'll need alternates or not because this depends on the
repository we're about to clone from. If it is a local repository and
the user has passed "--reference{,-if-able}", then we will end up
writing alternates into the object database.

The ugly part though is that we cannot determine where the repository is
getting cloned from before it has been initialized. While we of course
already have access to the user-provided URI, that URI can be very well
rewritten via "url.<base>.insteadOf". We can of course read the global-
and system-level configuration to resolve it. But we explicitly resolve
the URI a second time after we have initialized the repository because
it can happen that we copy a ".git/config" over from our templates, and
that file may cause us to rewrite the path.

In a subsequent commit though we'll start to write alternates as part of
the repository initialization, so we'll need to have the URI properly
resolved before we can initialize the object database. This is ugly, but
as mentioned above it makes sense for us to defer its initialization
anyway so that we also know about the object hash already.

Defer creation of the object database until after we have resolved the
URI.

Note that this also requires us to defer the call to `setup_reference()`
until after we have created the object database. While you might think
that this function has something to do with references ("refs/*"), it is
in fact responsible for setting up alternates. Consequently, we can only
call it after we have created the object database already.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/clone.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 904d2d859f..bdcbd7aa1b 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1188,7 +1188,6 @@ int cmd_clone(int argc,
 	create_repository(the_repository, git_dir, real_git_dir, work_tree,
 			  option_template, GIT_HASH_UNKNOWN, ref_storage_format,
 			  do_not_override_repo_unix_permissions, NULL);
-	create_object_database(the_repository);
 
 	if (real_git_dir) {
 		free((char *)git_dir);
@@ -1311,9 +1310,6 @@ int cmd_clone(int argc,
 		strbuf_reset(&key);
 	}
 
-	if (option_required_reference.nr || option_optional_reference.nr)
-		setup_reference();
-
 	remote = remote_get_early(remote_name);
 
 	if (!option_rev)
@@ -1342,6 +1338,10 @@ int cmd_clone(int argc,
 	if (option_local > 0 && !is_local)
 		warning(_("--local is ignored"));
 
+	create_object_database(the_repository);
+	if (option_required_reference.nr || option_optional_reference.nr)
+		setup_reference();
+
 	transport = transport_get(remote, path ? path : remote->url.v[0]);
 	transport_set_verbosity(transport, option_verbosity, option_progress);
 	transport->family = family;

-- 
2.55.0.1074.ge7621b4bad.dirty

