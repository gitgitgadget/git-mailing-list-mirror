Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0952A1FB3D7
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 22:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729549795; cv=none; b=Y9XR7FC915coOE/arl6onZYOYwUbASee6ocEk4Q8edhahyOC/J53A8Yzm2TW4tIeqRHqGLxrjPLfaZH3ijn2mii29UX7YkR1Mk8Ff7bMLdxy04Haeh7k8ln/x05XHBntyUpheaIOEunZVr2L1AEmnU4kSYCyxDdfyxV4TWFSvnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729549795; c=relaxed/simple;
	bh=NGSdrhj8QgUHlSppJDhqQTTZkm6ZTscncJCSoH/yo2M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=d2YtQkUQ95tzDQNKuiy9WMVs/CM0WcylRf9ktN5BqodYtBplthq9hrChv3sTrOIhPCPmvb/THx0Vj5w8kHsnyRXw7EFzkYZUmauIxUS9qHEcV9dpj4/OI98suLvRjSJJLwaeD4QO00U79zz+TKqJdxkhQXDDOgj6Lt2WMiWP9bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l1TtiFhU; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l1TtiFhU"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e3d6713619so88737517b3.2
        for <git@vger.kernel.org>; Mon, 21 Oct 2024 15:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729549793; x=1730154593; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aDgf3BavJhVJQVYPC6DLB8jJZVIoLqe5OfbXj6xn+LM=;
        b=l1TtiFhUHSNbx87DJSBYsjUr3ThO57SlMxjpe6H3Puf8FybU1c6DcdNfaKmDZx2qjH
         cdT7qNsKd5gt3vrn+7VFKDZ4TD9GC708Rkq7Z4wAZmkzx4UtXFNXjmgCs26VnE/Kermb
         4uSbAjwIXQY+hxy0yFEdCEQGP3N13GoApqJfDs9uqG9/K17NYuFNS5GLqnJbIuv2XTqs
         IN3bRftiCUfCikpNxxUVtTMlO08/cBUPtoEoZqwfLsmteZmwftRzS3K1dX2GMyS0gkko
         Nt96z+KJ77w72XWnS/woKQ1YlEPTXa+h8otyFjh/dLLqKAcDRIaV2t7rfJGgtgIk0xvu
         OsrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729549793; x=1730154593;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aDgf3BavJhVJQVYPC6DLB8jJZVIoLqe5OfbXj6xn+LM=;
        b=KHJd761Q5cFPgw0bhFo1t/3iZqJYo8ezKqo3odPrKp17NhWiUzPpD/SClklCKAjIwP
         pSs/mtgi5g8qFTULXo7YzFpLsV4qpNUCvmk0KAiMt+TdSOduQCm9l6JsU0fvLf2D3vz6
         u9TGjkxXxgPlwDUHr/gtPm9EilKc3b/p/VNjIOZ4/s19jqoi4PWTy92bcZNb8aAoyLhe
         Oig7P1IGENw1wGxVzmS2XyuEnZY1nsCvGDpBaIi/7Dwyw7IoRfNtaOSxihBAXP3SnkaE
         esDeFWkyFOSQksc4LweF36X2ESzZQPgsCUjSF0b68A1h8uj/A0yNTY8SZsZ1BVfU0G6p
         PVOg==
X-Gm-Message-State: AOJu0Yy8vzrGN971l1uqE4T8bhoshoaBds1mYPTJKJr/Nlb5yKJ+sARB
	F02CxcVm/VEX75PpqRk0xfjabZRCFW+sRds53hO23eTEc6dGSMA9EvgEzzmDIxV+tKWT2JRtZFw
	r53Z6cmdj82bhQ7lDnGCfdAPWRhu7GLtbyLc5GT13dFBxC1NSuSlryixR6+X21eNToDtSYTONMa
	s1Jxw4nVJJD8YjuAyDGl8+IUZMlo+lRXcPmgVdN1UReIuGhKDbe5jVKzPIMmkstv6eZg==
X-Google-Smtp-Source: AGHT+IGqNZxXgCH9l8LfwIm8y4C5WVlqE5pSierRzGMVdLkYWV/eOmVMdQk494dwRCrdQIpEIfYltXoaMXEJNmRLYb6p
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:5f48:7349:7c03:e18a])
 (user=jonathantanmy job=sendgmr) by 2002:a05:690c:4487:b0:6db:54ae:fd0f with
 SMTP id 00721157ae682-6e5bfd8eba6mr369417b3.7.1729549792813; Mon, 21 Oct 2024
 15:29:52 -0700 (PDT)
Date: Mon, 21 Oct 2024 15:29:44 -0700
In-Reply-To: <cover.1729549127.git.jonathantanmy@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241014032546.68427-1-hanyang.tony@bytedance.com> <cover.1729549127.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Message-ID: <fb2c202591b466eea33b4585e47b70e9086603bb.1729549127.git.jonathantanmy@google.com>
Subject: [WIP 2/3] pack-objects
From: Jonathan Tan <jonathantanmy@google.com>
To: git@vger.kernel.org
Cc: Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"

---
 builtin/pack-objects.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index e15fbaeb21..a565ab9b40 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -4310,6 +4310,18 @@ static int option_parse_cruft_expiration(const struct option *opt UNUSED,
 	return 0;
 }
 
+static int should_include_obj(struct object *obj, void *data UNUSED)
+{
+	struct object_info info = OBJECT_INFO_INIT;
+	if (oid_object_info_extended(the_repository, &obj->oid, &info, 0))
+		BUG("should_include_obj should only be called on existing objects");
+	return info.whence != OI_PACKED || !info.u.packed.pack->pack_promisor;
+}
+
+static int should_include(struct commit *commit, void *data) {
+	return should_include_obj((struct object *) commit, data);
+}
+
 int cmd_pack_objects(int argc,
 		     const char **argv,
 		     const char *prefix,
@@ -4326,6 +4338,7 @@ int cmd_pack_objects(int argc,
 	struct list_objects_filter_options filter_options =
 		LIST_OBJECTS_FILTER_INIT;
 	int exclude_promisor_objects = 0;
+	int exclude_promisor_objects_best_effort = 0;
 
 	struct option pack_objects_options[] = {
 		OPT_CALLBACK_F('q', "quiet", &progress, NULL,
@@ -4423,6 +4436,9 @@ int cmd_pack_objects(int argc,
 		  option_parse_missing_action),
 		OPT_BOOL(0, "exclude-promisor-objects", &exclude_promisor_objects,
 			 N_("do not pack objects in promisor packfiles")),
+		OPT_BOOL(0, "exclude-promisor-objects-best-effort",
+			 &exclude_promisor_objects_best_effort,
+			 N_("implies --missing=allow-any")),
 		OPT_BOOL(0, "delta-islands", &use_delta_islands,
 			 N_("respect islands during delta compression")),
 		OPT_STRING_LIST(0, "uri-protocol", &uri_protocols,
@@ -4503,10 +4519,18 @@ int cmd_pack_objects(int argc,
 		strvec_push(&rp, "--unpacked");
 	}
 
+	if (exclude_promisor_objects && exclude_promisor_objects_best_effort)
+		die(_("options '%s' and '%s' cannot be used together"),
+		    "--exclude-promisor-objects", "--exclude-promisor-objects-best-effort");
 	if (exclude_promisor_objects) {
 		use_internal_rev_list = 1;
 		fetch_if_missing = 0;
 		strvec_push(&rp, "--exclude-promisor-objects");
+	} else if (exclude_promisor_objects_best_effort) {
+		use_internal_rev_list = 1;
+		fetch_if_missing = 0;
+		option_parse_missing_action(NULL, "allow-any", 0);
+		/* revs configured below */
 	}
 	if (unpack_unreachable || keep_unreachable || pack_loose_unreachable)
 		use_internal_rev_list = 1;
@@ -4626,6 +4650,10 @@ int cmd_pack_objects(int argc,
 
 		repo_init_revisions(the_repository, &revs, NULL);
 		list_objects_filter_copy(&revs.filter, &filter_options);
+		if (exclude_promisor_objects_best_effort) {
+			revs.include_check = should_include;
+			revs.include_check_obj = should_include_obj;
+		}
 		get_object_list(&revs, rp.nr, rp.v);
 		release_revisions(&revs);
 	}
-- 
2.47.0.105.g07ac214952-goog

