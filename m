Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8D71850B5
	for <git@vger.kernel.org>; Wed, 28 Aug 2024 18:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724870555; cv=none; b=C7lq3ZGFoxgbZXVwmVNX+tRyqLSsJeDjWRrIny9fJk3NXV6XanN2Na6VSHmaRGwCj+j0gamBCayRfHtMoFQDsIynWCtGUa7TKmtSik4luM0rGGi+fJd7q8CPzO4ILRd6Mofwn4RWa6pCqBeE0+51aRLkQzEVD+og+sb5ESON7Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724870555; c=relaxed/simple;
	bh=iBhLq2+bbJGgn/n717gL/Va1ftb3JUnPmSD97tFM6k0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dkfvGo8KK3esX7kK/gsMIHBoctpWtGP05pqMNfcCYavP72xIjNuyhHLXu2vQLQLzx6gqa2aqTf6vbvuE0GQAl97greKb5gfrFkGxfpHwZKUuFsQhtFW8tcSfPkGztSzUkriveH8yG51OmoRrcNt9EwOO/pkyJnlOoxY9p1YYfgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=HmPJ/w67; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="HmPJ/w67"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 8E70B28026;
	Wed, 28 Aug 2024 14:42:32 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=iBhLq2+bbJGgn/n717gL/Va1ftb3JUnPmSD97t
	FM6k0=; b=HmPJ/w67UTNkuRucleCfiT4DoZq256rNDIR+3BDtot3jHAMNFSLpmp
	i3DO5J6oitF/zbir07DpwJPVpC1MhlCin0p7GyixvyWYlMJf4qSNjUZZfc2+Sfx8
	q2p7G8NG99PhGVEIU/UVwzRwvlq2HpGASy5pK4df/oWi7tp/8KlLQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 8351028025;
	Wed, 28 Aug 2024 14:42:32 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DD44928024;
	Wed, 28 Aug 2024 14:42:31 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Karthik Nayak
 <karthik.188@gmail.com>
Subject: [PATCH] SQUASH??? remove unused parameters
In-Reply-To: <Zs348uXMBdCuwF-2@ArchLinux> (shejialuo@gmail.com's message of
	"Wed, 28 Aug 2024 00:04:02 +0800")
References: <ZsIMc6cJ-kzMzW_8@ArchLinux> <Zs348uXMBdCuwF-2@ArchLinux>
Date: Wed, 28 Aug 2024 11:42:30 -0700
Message-ID: <xmqqle0gzdyh.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 48D0CD82-656D-11EF-AF61-9B0F950A682E-77302942!pb-smtp2.pobox.com

With -Wunused-parameter, the compiler notices that many parameters
are unused.  They are truly unused, and the signatures for the
functions involved are not constrained externally, so we can simply
drop the parameters from the definition of these functions and their
callers.

Please squash these in when the topic gets rerolled.  Thanks.

 refs/files-backend.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 8641e3ba65..69dd283c9d 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1966,9 +1966,8 @@ static int create_ref_symlink(struct ref_lock *lock, const char *target)
 	return ret;
 }
 
-static int create_symref_lock(struct files_ref_store *refs,
-			      struct ref_lock *lock, const char *refname,
-			      const char *target, struct strbuf *err)
+static int create_symref_lock(struct ref_lock *lock, const char *target,
+			      struct strbuf *err)
 {
 	if (!fdopen_lock_file(&lock->lk, "w")) {
 		strbuf_addf(err, "unable to fdopen %s: %s",
@@ -2584,8 +2583,7 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 	}
 
 	if (update->new_target && !(update->flags & REF_LOG_ONLY)) {
-		if (create_symref_lock(refs, lock, update->refname,
-				       update->new_target, err)) {
+		if (create_symref_lock(lock, update->new_target, err)) {
 			ret = TRANSACTION_GENERIC_ERROR;
 			goto out;
 		}
@@ -3443,7 +3441,6 @@ typedef int (*files_fsck_refs_fn)(struct ref_store *ref_store,
  */
 static int files_fsck_symref_target(struct fsck_options *o,
 				    struct fsck_ref_report *report,
-				    const char *refname,
 				    struct strbuf *pointee_name,
 				    struct strbuf *pointee_path,
 				    unsigned int symbolic_link)
@@ -3565,7 +3562,7 @@ static int files_fsck_refs_content(struct ref_store *ref_store,
 		} else {
 			strbuf_addf(&pointee_path, "%s/%s",
 				    ref_store->gitdir, referent.buf);
-			ret = files_fsck_symref_target(o, &report, refname.buf,
+			ret = files_fsck_symref_target(o, &report,
 						       &referent,
 						       &pointee_path,
 						       symbolic_link);
@@ -3589,7 +3586,7 @@ static int files_fsck_refs_content(struct ref_store *ref_store,
 	}
 
 	strbuf_addstr(&referent, pointee_name);
-	ret = files_fsck_symref_target(o, &report, refname.buf,
+	ret = files_fsck_symref_target(o, &report,
 				       &referent, &pointee_path,
 				       symbolic_link);
 
-- 
2.46.0-563-gaeb9b172ce

