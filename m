Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98BFB207A28
	for <git@vger.kernel.org>; Tue, 29 Oct 2024 21:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730236276; cv=none; b=H2GA4lrnI/4T3OXQjUdd6vGXoIdMKSe4CBYbSCtSB4SCtBgUW5YPVguyiWbuoClrVDr08DRVRf20U4u+LhFiuko4FInbx0BIWNE9NMnrtbKWttM2YdSyQygWyzrkApiZ10v1z8+j7gRJLhhgnIzuIUluwNvY89rjNrXZfCs04lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730236276; c=relaxed/simple;
	bh=8m/dZl3far1w5E4PptZt6kAQBrlLmkZFbIctv8O3qjM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=L5jRYCJjAI/S0YSwVSNBuvHPN3L5D9njrlb3vgn0MW94HOajOjx6sXingjbY+jF7zTlyb+Z8sQ7FNjv7eVtkcFnuaayungeMTb7KlcpAB51SUVw4Fw2GckNcAJ2CsI5eDOog0oUBVMWpLFfidvYWINI6yJqhyOllyMmSc2CRsPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RIdEH87B; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RIdEH87B"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e30b8fd4ca1so3094647276.3
        for <git@vger.kernel.org>; Tue, 29 Oct 2024 14:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730236273; x=1730841073; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1Uc+vEeVWc/CJYQ6CfUtMUueeyKuBExRDCaDKNzVW3Y=;
        b=RIdEH87BMVWBZO2n1yNRJNlG2+GQmKdL4QuX+aUF9AKTtAFNFnLeGVpwVELeeMrn5k
         HecjeMbNzsGUkQtNaw7CtRXCCpZVMA/Md38k8Z+d/hnEFcUx5ZoKbqz8Z+xOVJGgZA2l
         shhLfeOBONU573GhufxLjkU0OVJujRJe36RD3D2aYYLDhFd2qzQyB2vnRQxtxDI2bq+m
         ssekL7INnLnJoKDxIHTOOyjSt+/LP6mWtSnhVGE1cVDmVFz9PdpXdh/EqoI/vRyJrokz
         7tMFcJE7Db3lMPxSgI9rGqsmhygQ9COB7EtBk+UehmszLJVJfStPebGPuIuihUCqaj/G
         97RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730236273; x=1730841073;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1Uc+vEeVWc/CJYQ6CfUtMUueeyKuBExRDCaDKNzVW3Y=;
        b=khiHBXN0z7prrSw589UKqoYeeVsX6+ypCaqHM9N0ZGXJLIUTZx4On/WceOdAtD5kLh
         geUBQ1X9xv5+8jX84NjyLyLi40A/FK6V68hNbrVggkXN7d0TCiFHBrne7wIsPWQ4SXKh
         P8C7V+tYNHF3oHwos3vcMAUDWwPIwJRyJtU3TkXiCfK2pe+YrNykYW3QbGaG6F3aZpAk
         5DZovAaoNWGcRTNZd0hwRM2EsupY1na9lB5cfF+RhS3uBNb02ysxWkZX6zY54OZi5NzZ
         hlg4wk+yPTkD2p7WocZrFfbkOtXMDJck2fK840WRzQLgTWaGoRXQ+u7VQ6LG1XNF3t5w
         I1OQ==
X-Gm-Message-State: AOJu0YyZOjIBckCmhiwTIX4xpFDHEFrAfvomcSoGbVibzVvbojnNnaGP
	MMlx3d/yOO1+TJwbrlt3GdYa1KtUq/S9cwr4A7sVZN0TRL9QnvnGMD3eAu5WtQwXUTC1kzrYlOw
	13/Ho9xFregDFF56qyEr3wXl63uH6umX9o0Ov/udAGwEJ/G+gZoW9JhFqMmBwOtcOpN7q5NiGFN
	GHMg7sq4tONhxuT4rlc5BrdUTwPxMs9p3hUkonsF1+DEnYMHQoh0htOT+sppjTESIbNA==
X-Google-Smtp-Source: AGHT+IFaz08TGsNVN9o71iO8PsvJOsbo3vLDktBZJQkF8I8MYVg8wiCsfKCW/acC0/WOzQ6s8MhuURmkL1CVEsr23Nlx
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:c9ca:c50e:3acc:7e6b])
 (user=jonathantanmy job=sendgmr) by 2002:a05:6902:4c8:b0:e29:142:86b6 with
 SMTP id 3f1490d57ef6-e30cf4f05d4mr697276.10.1730236273336; Tue, 29 Oct 2024
 14:11:13 -0700 (PDT)
Date: Tue, 29 Oct 2024 14:11:05 -0700
In-Reply-To: <cover.1730235646.git.jonathantanmy@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241003223546.1935471-1-emilyshaffer@google.com> <cover.1730235646.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <1027ff2cb7d9af5cc9ce6b653d28150457db8703.1730235646.git.jonathantanmy@google.com>
Subject: [PATCH 2/2] fetch-pack: warn if in commit graph but not obj db
From: Jonathan Tan <jonathantanmy@google.com>
To: git@vger.kernel.org
Cc: Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"

When fetching, there is a step in which sought objects are first checked
against the local repository; only objects that are not in the local
repository are then fetched. This check first looks up the commit graph
file, and returns "present" if the object is in there.

However, the action of first looking up the commit graph file is not
done everywhere in Git, especially if the type of the object at the time
of lookup is not known. This means that in a repo corruption situation,
a user may encounter an "object missing" error, attempt to fetch it, and
still encounter the same error later when they reattempt their original
action, because the object is present in the commit graph file but not in
the object DB.

Therefore, detect when this occurs and print a warning. (Note that
we cannot proceed to include this object in the list of objects to
be fetched without changing at least the fetch negotiation code:
what would happen is that the client will send "want X" and "have X"
and when I tested at $DAYJOB with a work server that uses JGit, the
server reasonably returned an empty packfile. And changing the fetch
negotiation code to only use the object DB when deciding what to report
as "have" would be an unnecessary slowdown, I think.)

This was discovered when a lazy fetch of a missing commit completed with
nothing actually fetched, and the writing of the commit graph file after
every fetch then attempted to read said missing commit, triggering a
lazy fetch of said missing commit, resulting in an infinite loop with no
user-visible indication (until they check the list of processes running
on their computer). With this fix, at least a warning message will be
printed. Note that although the repo corruption we discovered was caused
by a bug in GC in a partial clone, the behavior that this patch teaches
Git to warn about applies to any repo with commit graph enabled and with
a missing commit, whether it is a partial clone or not.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 fetch-pack.c | 22 +++++++++++++++++++---
 object.h     |  2 +-
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 6728a0d2f5..5a0020366b 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -57,6 +57,7 @@ static struct string_list uri_protocols = STRING_LIST_INIT_DUP;
 #define ALTERNATE	(1U << 1)
 #define COMMON		(1U << 6)
 #define REACH_SCRATCH	(1U << 7)
+#define COMPLETE_FROM_COMMIT_GRAPH	(1U << 8)
 
 /*
  * After sending this many "have"s if we do not get any new ACK , we
@@ -123,15 +124,18 @@ static void for_each_cached_alternate(struct fetch_negotiator *negotiator,
 }
 
 static struct commit *deref_without_lazy_fetch(const struct object_id *oid,
-					       int mark_tags_complete)
+					       int mark_additional_complete_information)
 {
 	enum object_type type;
 	struct object_info info = { .typep = &type };
 	struct commit *commit;
 
 	commit = lookup_commit_in_graph(the_repository, oid);
-	if (commit)
+	if (commit) {
+		if (mark_additional_complete_information)
+			commit->object.flags |= COMPLETE_FROM_COMMIT_GRAPH;
 		return commit;
+	}
 
 	while (1) {
 		if (oid_object_info_extended(the_repository, oid, &info,
@@ -143,7 +147,7 @@ static struct commit *deref_without_lazy_fetch(const struct object_id *oid,
 
 			if (!tag->tagged)
 				return NULL;
-			if (mark_tags_complete)
+			if (mark_additional_complete_information)
 				tag->object.flags |= COMPLETE;
 			oid = &tag->tagged->oid;
 		} else {
@@ -809,6 +813,14 @@ static void mark_complete_and_common_ref(struct fetch_negotiator *negotiator,
 	save_commit_buffer = old_save_commit_buffer;
 }
 
+static void warn_in_commit_graph_only(const struct object_id *oid)
+{
+	warning(_("You are attempting to fetch %s, which is in the commit graph file but not in the object database."),
+		oid_to_hex(oid));
+	warning(_("This is probably due to repo corruption."));
+	warning(_("If you are attempting to repair this repo corruption by refetching the missing object, use 'git fetch --refetch' with the missing object."));
+}
+
 /*
  * Returns 1 if every object pointed to by the given remote refs is available
  * locally and reachable from a local ref, and 0 otherwise.
@@ -830,6 +842,10 @@ static int everything_local(struct fetch_pack_args *args,
 				      ref->name);
 			continue;
 		}
+		if (o->flags & COMPLETE_FROM_COMMIT_GRAPH) {
+			if (!has_object(the_repository, remote, 0))
+				warn_in_commit_graph_only(remote);
+		}
 		print_verbose(args, _("already have %s (%s)"), oid_to_hex(remote),
 			      ref->name);
 	}
diff --git a/object.h b/object.h
index 17f32f1103..196e489253 100644
--- a/object.h
+++ b/object.h
@@ -65,7 +65,7 @@ void object_array_init(struct object_array *array);
 /*
  * object flag allocation:
  * revision.h:               0---------10         15               23------27
- * fetch-pack.c:             01    67
+ * fetch-pack.c:             01    6-8
  * negotiator/default.c:       2--5
  * walker.c:                 0-2
  * upload-pack.c:                4       11-----14  16-----19
-- 
2.47.0.163.g1226f6d8fa-goog

