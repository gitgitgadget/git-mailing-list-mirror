Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29999253958
	for <git@vger.kernel.org>; Wed, 19 Nov 2025 07:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763538674; cv=none; b=Lyv6qOLA4msk5Ruows1RJA8ITCNagTXWN9XNdyppFWxZiOBB+UAKomXX+OEDD09Y5X/6pZLdJ4Y9OMd0s3eYNGVJ9zSmDr6E9IjuvAIXVJZksjeARg2xJFNDhgIogX2L7ywDuFwW0sWIgAhEun53yCEC9XUxYhKobKYkrvvqA08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763538674; c=relaxed/simple;
	bh=wjvwsaE72ftOP2OsCNRL52eTjv5ZilaQbEy73AwTouE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LMN/UXX7UNxCSu/ipPoxpfAs3KWc+2SMXpvSFwJVhT6zdmTwSzcVNxi7NOMV6os0qa4vx/ubUWuN+YMZ0nr79z93eidD0M9gT7hECaWbugKyCP+ehYrizYSin/2oKxxSZxa6dEJsFqiNpU5U4hWxAM0USOsGoLzyDRW+PM29uiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Pwr00CqN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DjrYgVkG; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Pwr00CqN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DjrYgVkG"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 539DDEC0103
	for <git@vger.kernel.org>; Wed, 19 Nov 2025 02:51:12 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 19 Nov 2025 02:51:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1763538672;
	 x=1763625072; bh=o86cWc3sdSw1dip8ASwio/4Z7U5S6QwDAwLdJrC3iF8=; b=
	Pwr00CqNIfZ5wZZLok/tRnp7DoT7C4e3e91a+MnDoVHRsXr6PymNE3NU+N3wpIIy
	m+BuHa9jYYMtdCYLIJT7aRPl2VnIHUGcR0eFnTIWVL5PP7sZHZC4ieGqD4ZAr039
	7aETVXgxIEiVh0tY1J6Sk895gOpmWitpUVMKEIdhuQTt5VLksmpujGdGD9mJWwNq
	8Y43h4W8GzLpyy3g5K5m1ljEW/QGdT86RZ/QPnNkVVTHwV06yB+P46VfhWtnANzH
	h01hTVl76en0HKBhJcKEwfwMcy2mStArjyGiQ91SEj3JL/0HRB9/CS85fp1gxI+9
	ie9MSd/DAS7hDjQXSUI78g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763538672; x=
	1763625072; bh=o86cWc3sdSw1dip8ASwio/4Z7U5S6QwDAwLdJrC3iF8=; b=D
	jrYgVkG1zKCSxGRoquCsc5yA2IvdoEbzK8pbPBCAVkCaNbcjmiJiCjfvJO8wuIdJ
	u0OGz/ZVbRnSlyLjOhtqi8OG7pa7MDbNqdSdQQBXoMpMBzPZXwTqoYM5BzedfUt5
	SUAEKMKPV5w9Ow56hg9z8UI56xwurbrcxXtSjaOsAJT06TfUCPXYStFXZ/n5NwGy
	5mM7o3CWS1sWnlCnnZI9Uh/CleGudHl/G2PwUBxRK1B09HsSKUBzBUCmQpUh8+4s
	+DcTkdgB4H4DHE/Nf6ngEidVFjoMWqVVQ9qiTy9bJr5vyHASzmlS7A+NuWOB3C6C
	Eq6WIix0QHEn3lU/tM5gA==
X-ME-Sender: <xms:8HYdafh7JGt1QRNfCaXgzDEasHi2c9otHluX0qS4gwWn1cZdsxhARg>
    <xme:8HYdaS-tKWW-jmjMwkcNUBJk_764oTdZ6ebHz7Hj5FLsLBrQGtNVV65PWZL1MTHkN
    9h6m32I5Hb3KyZyf0P4d-PNBRtSqq8mcODr-Oe30vVWQcHpO5AG>
X-ME-Received: <xmr:8HYdaUtizWmxkIXdsZTG_MkCEP5ivuwIjwh_8fQ7S6xLcR1Rm7XMlmfzHcO6bPIEr0kUorXmOBqp8NPbq0wLzXsO4QmmPpioFaOq37NY6g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdefieegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepudenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:8HYdaRa9W6KrxOSD_RfpMvks3KPLLqw8tFTvp1VfVJWBMtXB5PUkAw>
    <xmx:8HYdaco7XpLA4DmuO8MoaUo-9JEXtW5KcccUIqpjr4DC4aFCfFWH9Q>
    <xmx:8HYdae_duQdY8o3lGyinPM3DN2h5IR1VlNXTC-hP_JG41X7faNAR6A>
    <xmx:8HYdaT9C2zBnnfhBYmXGfrHlWbbJB_fsibYWj7VQkG9eE-pvFgprXw>
    <xmx:8HYdaQh-sUBBAQ9_Ns5oVS_atgZamn_yId4l_w2PNBQDCvuGMaHDbdIf>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 19 Nov 2025 02:51:11 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0dd83225 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Wed, 19 Nov 2025 07:51:10 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 19 Nov 2025 08:50:52 +0100
Subject: [PATCH 04/13] odb: refactor `odb_clear()` to `odb_free()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251119-b4-pks-odb-creation-v1-4-2b2ed2612cb6@pks.im>
References: <20251119-b4-pks-odb-creation-v1-0-2b2ed2612cb6@pks.im>
In-Reply-To: <20251119-b4-pks-odb-creation-v1-0-2b2ed2612cb6@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

The function `odb_clear()` releases all resources allocated to an object
database and ensures that all fields become zero'd out. Despite its
naming though it doesn't really clear the object database so that it
becomes ready for reuse afterwards again -- the caller would first have
to reinitialize it, and that contradicts the terminology of "clearing"
as we have defined it in our coding guidelines.

There isn't really only a reason to have "clearing" semantics, either.
There's only a single caller of `odb_clear()`, and that caller also ends
up freeing the object database structure itself.

Refactor the function to have "freeing" semantics instead, so that the
structure itself is also freed, which allows us to drop some useless
boilerplate to zero out the structure's members.

This refactoring reveals that we're trying to close the commit graph
multiple times: once directly via `free_commit_graph()`, and once via
`odb_close()`. Drop the former call.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb.c        | 19 ++++++++-----------
 odb.h        |  4 +++-
 repository.c |  4 ++--
 3 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/odb.c b/odb.c
index bcefa5cede..29cf6496c5 100644
--- a/odb.c
+++ b/odb.c
@@ -1073,30 +1073,27 @@ static void odb_free_sources(struct object_database *o)
 	o->source_by_path = NULL;
 }
 
-void odb_clear(struct object_database *o)
+void odb_free(struct object_database *o)
 {
-	FREE_AND_NULL(o->alternate_db);
+	if (!o)
+		return;
+
+	free(o->alternate_db);
 
 	oidmap_clear(&o->replace_map, 1);
 	pthread_mutex_destroy(&o->replace_mutex);
 
-	free_commit_graph(o->commit_graph);
-	o->commit_graph = NULL;
-	o->commit_graph_attempted = 0;
-
 	odb_free_sources(o);
-	o->sources_tail = NULL;
-	o->loaded_alternates = 0;
 
 	for (size_t i = 0; i < o->cached_object_nr; i++)
 		free((char *) o->cached_objects[i].value.buf);
-	FREE_AND_NULL(o->cached_objects);
+	free(o->cached_objects);
 
 	odb_close(o);
 	packfile_store_free(o->packfiles);
-	o->packfiles = NULL;
-
 	string_list_clear(&o->submodule_source_paths, 0);
+
+	free(o);
 }
 
 void odb_reprepare(struct object_database *o)
diff --git a/odb.h b/odb.h
index 71b4897c82..77b313b784 100644
--- a/odb.h
+++ b/odb.h
@@ -167,7 +167,9 @@ struct object_database {
 };
 
 struct object_database *odb_new(struct repository *repo);
-void odb_clear(struct object_database *o);
+
+/* Free the object database and release all resources. */
+void odb_free(struct object_database *o);
 
 /*
  * Close the object database and all of its sources so that any held resources
diff --git a/repository.c b/repository.c
index 6aaa7ba008..3c8b3813b0 100644
--- a/repository.c
+++ b/repository.c
@@ -382,8 +382,8 @@ void repo_clear(struct repository *repo)
 	FREE_AND_NULL(repo->worktree);
 	FREE_AND_NULL(repo->submodule_prefix);
 
-	odb_clear(repo->objects);
-	FREE_AND_NULL(repo->objects);
+	odb_free(repo->objects);
+	repo->objects = NULL;
 
 	parsed_object_pool_clear(repo->parsed_objects);
 	FREE_AND_NULL(repo->parsed_objects);

-- 
2.52.0.rc2.482.gaa765fefd0.dirty

