Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66C23CC33D
	for <git@vger.kernel.org>; Fri, 24 Jul 2026 08:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784880867; cv=none; b=IeJjNoHw6Egx04HQAZssTdbrRMo7yHv5wcvVrKEpfQhRkcV6fHMG5zRbChDXDZtcqAKOrREn3fWRPYA9DApQYsKyfm6aJstYnMGyiaEWZwDY7PKMxKpJpP1IKNunyNjknCr6AsNlu2BEBYxOdCn+HYuYpCgCI3U8y4cMq6RXhfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784880867; c=relaxed/simple;
	bh=WAhSIeOpD0X6k11rc8bYw/nOgjzY3yKRb7Bq/czSlvE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rXz+jCdh8sE5Y3kVGaIyGCh0YGgS2T6c3O3AhUEZKEvwQGcQ9lJ9I9a9kR6SxLJ6CczBOYIiRj1fvOvL7ONsbgYdV3ZKWkvFtWe9mgoBLTY804B3fkn3UIxUE9j2h9lBC5bJfbIcXl0NLHJLRV3JEKH0ipsFAcaGPbgYb/CRivs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=DyaIWs92; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="DyaIWs92"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2ceeee8c46bso568275ad.2
        for <git@vger.kernel.org>; Fri, 24 Jul 2026 01:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1784880865; x=1785485665; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1qu/610kEEP7lBSncZKuIsdgx+/Dc5NURAWjC5clJ7g=;
        b=DyaIWs92fogmBwP9ixvQoNZ5xP+BqIILyyIBs0pTA84Lx/zR7DAeTVnu1WlI8RztZH
         VfWpZJXulQBUqQZKyLpXkW0jHwTqQwOdttipxbRNBXQi0t4GimSVoWHivAllXmHWwgYk
         9SgMt15/oF/3+np9yIc4BC4JcOVPCUSeYniMo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784880865; x=1785485665;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1qu/610kEEP7lBSncZKuIsdgx+/Dc5NURAWjC5clJ7g=;
        b=Eyw3zJfp7fLrBYqPrsa91IuMT3rF40zbnw1iz2npYT14fvIhXp2RqUQEBtVakZ5Bn6
         +lANcZVMpxTIns/uWvmTzL8wZKyx4ILY3xFVJo4ieJ2KLmhw9H74IPV468vmi3eDQ3Z6
         joyEnKU/4FycgOzve6lsuNyZqiUVve0rFu+vZjxY2mW6N3mnK3DQ9KlP9fgkQp6KELaA
         BbTuEwT4XxOSF3ghVnJUmwNU4oq+YAhdJBIkboJU3akE53I1WxjIw9l17X6D16G2zFSW
         LcbGJGcslfe4xTsnSqaSOUQoB0U/Kxum7nycdOYUfHUJJgVEx0Dws0z6jqmSKd6CP31v
         d17Q==
X-Gm-Message-State: AOJu0YwkyZPcGLF+MNYzBewFhH+sTzEXdOoCamrYgu5sFXZwgfGSRt4v
	RRjBMYqINS/jx5lDonhq7OuspZGcF8fwlehyYdCBdKFQj6g+E0EoBU2gKWO78yO3KwWyamLUeq/
	EhlEBT/k=
X-Gm-Gg: AR+sD12t0vL4I1IAK79YNKSmazG5A2MFR/1DNBYwNttCSfTTXyh56F/rvgZMQ3uo1gk
	MM3+pmSGLDyi6Mlival4DuiEjtE+4IsrnsSgJBX0TrRQ2TYNCoKwoz2JQ3itgtEchSYJ26WmRuA
	DICFaZQNWi43mSbVYLxipHA5l6qKzEXKZk1uG1gSlH9Js5XpfC8OvaL56MPaAxkgFJpI4NWJDOn
	tOg9H0ZB+w34azJ2W+VfNzL5p/DU6qEK+IB/wZk8oTe5uUbPgdoMuNfxrx5OCvJpGpesBe2EAIV
	0PRurcNzdEGUnwZNJlGDUeeMgYHKExQU3M4oFNqJkKpdGzBSYV5cEPqPSOVlBfjWMVy5CejHsIg
	pbHeCOHLF7Ompv/jFUZiYXGmY4/3rfw80jeUAjpVr86T9vryQ3D5GYBaewfEZQzViH7ih59sSH1
	GaQYXvaOoG1sjxk0t/LAqRPbi6M/dWAjzbXqXYf9ga4E2NTYovzFO4f4sI6SWskr4Twrl289oq5
	SnLoO6Q7MK+olQ=
X-Received: by 2002:a17:903:2c03:b0:2c4:397:dd7a with SMTP id d9443c01a7336-2cfbd6a2b1emr23010245ad.4.1784880865215;
        Fri, 24 Jul 2026 01:14:25 -0700 (PDT)
Received: from com-76773.corp.openai.org ([2601:646:300:69b0:f912:1358:fd39:7404])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3147d47960dsm26218810eec.0.2026.07.24.01.14.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 24 Jul 2026 01:14:24 -0700 (PDT)
From: Ted Nyman <tnyman@openai.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	me@ttaylorr.com,
	peff@peff.net,
	ps@pks.im,
	karthik.188@gmail.com,
	sandals@crustytoothpaste.net,
	avarab@gmail.com
Subject: [PATCH v4 1/3] http-fetch: correct --index-pack-arg documentation
Date: Fri, 24 Jul 2026 01:14:23 -0700
Message-ID: <a6a40b80461377452a0b2c9204c3a659ab60a7d5.1784874850.git.tnyman@openai.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1784874850.git.tnyman@openai.com>
References: <cover.1784676106.git.tnyman@openai.com> <cover.1784874850.git.tnyman@openai.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The --packfile mode accepts one --index-pack-arg=<arg> option per
argument passed to index-pack, but its documentation and option
dependency errors still refer to the plural --index-pack-args form.

Correct the spelling and describe the repeatable per-argument form.

Signed-off-by: Ted Nyman <tnyman@openai.com>
---
 Documentation/git-http-fetch.adoc | 8 ++++----
 http-fetch.c                      | 4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-http-fetch.adoc b/Documentation/git-http-fetch.adoc
index 2200f073c4..09b5d675ee 100644
--- a/Documentation/git-http-fetch.adoc
+++ b/Documentation/git-http-fetch.adoc
@@ -50,11 +50,11 @@ commit-id::
 	URL and uses index-pack to generate corresponding .idx and .keep files.
 	The hash is used to determine the name of the temporary file and is
 	arbitrary. The output of index-pack is printed to stdout. Requires
-	--index-pack-args.
+	one or more --index-pack-arg options.
 
---index-pack-args=<args>::
-	For internal use only. The command to run on the contents of the
-	downloaded pack. Arguments are URL-encoded separated by spaces.
+--index-pack-arg=<arg>::
+	For internal use only. An argument to the command run on the contents
+	of the downloaded pack. This option can be specified multiple times.
 
 --recover::
 	Verify that everything reachable from target is fetched.  Used after
diff --git a/http-fetch.c b/http-fetch.c
index f9b6ecb061..601a77c3c1 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -155,7 +155,7 @@ int cmd_main(int argc, const char **argv)
 
 	if (packfile) {
 		if (!index_pack_args.nr)
-			die(_("the option '%s' requires '%s'"), "--packfile", "--index-pack-args");
+			die(_("the option '%s' requires '%s'"), "--packfile", "--index-pack-arg");
 
 		fetch_single_packfile(&packfile_hash, argv[arg],
 				      index_pack_args.v);
@@ -164,7 +164,7 @@ int cmd_main(int argc, const char **argv)
 	}
 
 	if (index_pack_args.nr)
-		die(_("the option '%s' requires '%s'"), "--index-pack-args", "--packfile");
+		die(_("the option '%s' requires '%s'"), "--index-pack-arg", "--packfile");
 
 	if (commits_on_stdin) {
 		commits = walker_targets_stdin(&commit_id, &write_ref);
-- 
2.55.0.openai.131.g83a728de1eb6

