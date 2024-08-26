Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95CDB12CDA5
	for <git@vger.kernel.org>; Mon, 26 Aug 2024 07:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724656954; cv=none; b=A1Qf//O/7b1dYz6ht67h9OR6jDwiNYycqiIA9a3nBIRclYaDEo9dYVA5c8GKWNKqtP4v5hOxCv6d8AAJ23q1WfxIS/bcynQ+T/U6hZdtJ8yMZlpPISTlxc8bvIPV+h1jcoFMscHWCjTfEYlKEurj7vpZTxCwt8qBXZZ2/L5c0nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724656954; c=relaxed/simple;
	bh=8ywnKjeap2g/sIKWB0GIlWYURcFIOTrICXpCFFGBvRs=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V3C2eb/VERnAL0fBmERvgUBn7q6FYwlRtdjUj/UGNW0duwi/y2NXlc4+gC6z28yaH5zNdzbWJPSC9lxcqJGej54rpoO6U4n6Twn8nEt/Kw5bFKiDXWU1PZlL8p1f/jYRdNI4Mk4ktQ6CpKcSG7eY7f5rjsCH82w0Bd0ojRkbIzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=EoYR8JhE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cplzWjfB; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EoYR8JhE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cplzWjfB"
Received: from phl-compute-08.internal (phl-compute-08.nyi.internal [10.202.2.48])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id B57891146D9C
	for <git@vger.kernel.org>; Mon, 26 Aug 2024 03:22:31 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Mon, 26 Aug 2024 03:22:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724656951; x=1724743351; bh=6pjR5jFOS/
	3E3tw+QUXeasg/k5nUcCoHrYVCVNZyfcQ=; b=EoYR8JhE4MJzBD2GByeMkrKgHO
	4pghMplzXgK7z0RBGo6X9MZsL3sg6MCB6BZ3HtR2ijMbCc0q5aKONL21sML5YlhZ
	5y3QG+e8S4G54GDnUHd1BvwEZX/DdLNYpPUD/zxxufFS3PAPIky2vkNN/8aFpwC2
	eWTcxl8j4qdZ/J6DWeM9+0vs8tpQGAeBApGD5TSUv7OkwykzW07EC0W3DxAlHKPd
	zlxiWh2wUy/4WizIt34qVC5oYh1wXPeohqEH8qCaXP7skIadX8CDXrHB7FMCL0tU
	O72SRvmHpxFGBxqLc50kdelC/OSKGeXS6SHqNyplgZGdnPpec97A/zALI5+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724656951; x=1724743351; bh=6pjR5jFOS/3E3tw+QUXeasg/k5nU
	cCoHrYVCVNZyfcQ=; b=cplzWjfBZvubclEKImGtnI392FQJfI2VMKoEGnz/hAN8
	UvQDSkMn4WZQVIgn6o+1w5IM4ygUK4MbU43d9xd7VhN/K+FT10wptMlPZjU8+R4N
	gDEk+z8tGGafJ4xhzKS1GUjNkVfWm0H8rTuLkJINYxZ5xVwTWeRrayQNkTRjNo7e
	xwqe66Qq9Vqy9DWp8XgPULFZyBX9Ka8kZ0XNh7ndFS+LS1OIBnCPZyq/Nq/f7H/+
	+VRnKaslGU/B1TJUT9VEIfAdDi5i9t3IjPQVdPuOdlmSVFg9USYsbmynIwWf0YgQ
	iz8bw+k2b1IzyvhN5g27sQvXSqIRwVTitnVw58iUJQ==
X-ME-Sender: <xms:Ny3MZnikkSUr7dTZjrfQmP3hm5Bu-s9s0UjcF-GKJ8Af_SCpr9O9qA>
    <xme:Ny3MZkDzXM-WEBIFi1rmUj9jQpzKOl-sS5MlTBsh0dFKGw6_p3i8d83AdJHI23HrA
    fNvyS5zLitKPHhXUQ>
X-ME-Received: <xmr:Ny3MZnFqf4MR1kw5puEeGmFnznklNcT6Ua0TK9VFt1_2JTEpvTsZ6paYhk60Uq9jeZr9xRtrTjxDEixdvKpSHcHppyktFzq4KoymDGwWQZ7e4v8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddvjedguddukecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeehkeeffeegge
    dvgedvfeefheettddtffejuefflefggfehfeelffeljedvfeehieenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Ny3MZkRE8dkOUcCsUuNd3fLJ-4canOilucebVRWMogozwUhVTrwy0A>
    <xmx:Ny3MZkztArLXpf-g6zFBpYjhHUWhkT5KjFpkXVYQx2xJfKs9rkAEfw>
    <xmx:Ny3MZq7tZ5eiZr_qjhYbQx9NctXbAZNpYtMEpbcZ7Ka_dO-Gjm6YQA>
    <xmx:Ny3MZpwY0EnfBAJMIO4VK4Ltwe8Y0sty_0O0mHO6KhON7JYNiNVLmQ>
    <xmx:Ny3MZhoUqybLpspa92IIdHWaGDwObEV1swynHOUuyAbMGys8BwRlamfD>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 26 Aug 2024 03:22:30 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 25e25f3b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 26 Aug 2024 07:22:29 +0000 (UTC)
Date: Mon, 26 Aug 2024 09:22:29 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 18/22] builtin/grep: fix leaking object context
Message-ID: <0722cb38ea9d6b158a07da6f31ad0fe83424cb2e.1724656120.git.ps@pks.im>
References: <cover.1724656120.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1724656120.git.ps@pks.im>

Even when `get_oid_with_context()` fails it may have allocated some data
in tthe object context. But we do not release it in git-grep(1) when the
call fails, leading to a memory leak. Plug it.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/grep.c                 | 1 +
 t/t6132-pathspec-exclude.sh    | 1 +
 t/t6135-pathspec-with-attrs.sh | 2 ++
 3 files changed, 4 insertions(+)

diff --git a/builtin/grep.c b/builtin/grep.c
index dfc3c3e8bd2..dda4582d646 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -1133,6 +1133,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 					 &oid, &oc)) {
 			if (seen_dashdash)
 				die(_("unable to resolve revision: %s"), arg);
+			object_context_release(&oc);
 			break;
 		}
 
diff --git a/t/t6132-pathspec-exclude.sh b/t/t6132-pathspec-exclude.sh
index 9fdafeb1e90..f31c09c056f 100755
--- a/t/t6132-pathspec-exclude.sh
+++ b/t/t6132-pathspec-exclude.sh
@@ -2,6 +2,7 @@
 
 test_description='test case exclude pathspec'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t6135-pathspec-with-attrs.sh b/t/t6135-pathspec-with-attrs.sh
index 120dcd74a51..794bc7daf05 100755
--- a/t/t6135-pathspec-with-attrs.sh
+++ b/t/t6135-pathspec-with-attrs.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='test labels in pathspecs'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup a tree' '
-- 
2.46.0.164.g477ce5ccd6.dirty

