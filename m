Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18854279FC
	for <git@vger.kernel.org>; Fri, 31 Jul 2026 12:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785502574; cv=none; b=DAeKd8DKI9vO/7YAE4ErrjcrnUwR5vKHohuEZDcFmA6GjqvLjWHfuwurP4ab6Ojtd5kX/q5JQPSecZSXGeuZAH3QFc9AXNR+0w1ntb0coQkJs9JkRyFzwch0iVB8tmZ5y3k09fdlBxFc1FKqiANIBh8n45Korah4B76g7aiuaBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785502574; c=relaxed/simple;
	bh=hhdn0ufQRmybDH3DpZfFKpuPsMxzLBiIKg+2SxJeJgU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BC08+BISYIBlMjXWcH1kGECcJawBfrOoyylWEqYYYDha+7FgnVoOEvqR6XvdDDUP3cNzZOEWh/FGyZL2ATF78CQF2pGnEMlm/ElYjH/aWW0EA2T999T3wEzX0kmVtzEgZfeV4EwHFi8q5M5U48MpOQnWKRouZs4KSbk5BsaXQfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=mLuX4XXr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YxPAg+hV; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="mLuX4XXr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YxPAg+hV"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id D79FFEC00FB;
	Fri, 31 Jul 2026 08:56:11 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Fri, 31 Jul 2026 08:56:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1785502571; x=
	1785588971; bh=fgJHfWs5CfhPcSuboxLsI3lEtXRVYuNwHUvikcEFQOg=; b=m
	LuX4XXrmpayINW365WmF41tLP3Ka3YXVzAPvgzUaMQ5zAFLl0MT0i5LAM0PxikHF
	XtzbGtyUGVV6wSTaSy9VnAGQSvE8UBeNk7erYt43BdjDA2+fFmEygWcBQ76/0G6T
	BNAKX/CvpVLT3F6risAIhi9wYdMjj5Exo7ab4PjkE7hY4nqUFosOqftRYYKcAyV9
	C1PE1O9JLN9w2smcV4Z5CcmTQ9XU27HK0aLCpxGaD8N8vpQAkJq5FQ0aI5FI9UYl
	Cpdl22tzS4MVthVcTiZjiTxBHtD6m/P8RmMI84kFgnUvTM0OXzz2oKprlAqt8+9+
	etWHkAYo1JtFUJO4uSrKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1785502571; x=1785588971; bh=fgJHfWs5CfhPcSuboxLsI3lEtXRV
	YuNwHUvikcEFQOg=; b=YxPAg+hVpMUWTfFSYhBEskPhse1h0PSZTT7dgs77RSqe
	g3GV16EjW6ObRHawxuiQqgxbOmjPwdAcK7AgcG/DvnEclfgJpQqlHjysqIOQtubR
	Y/2zcAnd6CPShA/rDEY7iSJRjM9WnZ07DqM78aeztiV+ghyojS4VNCxp6VV4X/OR
	6c8YWq5NS3Jq2tOI3whLFU5OQBaTKfYYfRzmQf4d/lJr8jOAK9NSLew3qDHBqE2u
	BV7PYikzWD+TlUGDCWQiOd9d+PxYJzAXX5Daf/v7+CV59FXUJH7K75vrMsdVcmtO
	a5uS2Z/rIdAwSNKc5WVlI7tuP+hp/gAIbXuST6gPfw==
X-ME-Sender: <xms:a5tsanq_LYtXaDNvGD9L8Qn_29MDPcr-XHEFgzadN4GPvj3KAToeNA>
    <xme:a5tsanrCjYVKWt2UtELQVCycv-CVtRd9e9I8MkU-b_fLkmjyJK330jbpVJXfC4igR
    7Yn82gS8GmzgJpsfozSHRqyJkYlKhSFOyX3y_w2ZQolhRbAK5upRQ>
X-ME-Received: <xmr:a5tsah1g1oKbkRoYOH4q442Y53SV-T47G1NdK4lpWK_Vd6jNWUDsxYoo2EwrRJCWNvqvt868t96aZc9iPAd_wUUcPv-_yq8csQ>
X-ME-Proxy-Cause: dmFkZTFvtb4z8LKpL/dDmRpyDAZ+sKRopVmXj+fK+N+tDcReyC4QfjUzed/2Yq9KPOWsmJ
    BfW4FDTVWh72NRk/WsGt/c2XNfqRyqBYn6u3CW2dsbABPUR3QlweGEUitYNQ2uZctSXuPN
    GGhPzzpvGt2YDvkIAn2JVa7q3sxFaQ6CAFtlslLJGcME8nKVR52AfaH1WQopaE4ZFMEDWb
    fbPN21+CnaxJKlUKEnVY3agkqfmhgm8ElREzHI382QqkmvYTyXLAFQgWAWzg49ocOy2Tgr
    5qT4zktJixUUwne4KXg6P/ZlG3djDFp8xyJvTBwhinQFg2z1DuGhBFx0+E5hvdN0R1+oQB
    yhmt0I343rj05YPNnW9wsNHnR66WOM51UFh4ARuWYymgTCx3UiDyAIs9tSNLsvChXfOi9u
    UInvW7ozFAIVH2VXITDUpsCeP5hL+KFDoHjuQ51OQLva4LcYFC4MufzXbIKYfjm4Ewr6o/
    NvWdCmQSJMUov8JrYZi8lFmvD5S2TO3FodEfv75N478tci6UKKmxnEwg+J3/knlxRMKYup
    25GM2IIfNzFwrB6IyjhqXZmuHRZHicx+X3ySTbnqzYXh8gjMDTdvWLgQPmnMWMnayVdLE3
    d4zM4G27xRpPvfMoRK5IVu/JlSV/giKexz6n8oORBileb3RTqBwTBtg5TX5Q
X-ME-Proxy: <xmx:a5tsamBDNzgmMYY0HnzsnmVKfWkX6wuGn4mJAvIC0QBRqVYHlrJZKg>
    <xmx:a5tsapdtVtzuFNsNjs_-5_NkB-hXJOrEWSRAg7yMVznNq3GViy2uoA>
    <xmx:a5tsarg-Dg6PNlS_06-H54zQsqhZ3gxgcNNZcAMvXNZpqlll7WdBXA>
    <xmx:a5tsahq3ngWmiqmHH7T-GClOEOaeI_0IFxSiLdPaa4otDx1rTW0Njg>
    <xmx:a5tsarASSuMPl-fVm7czsydgLKwGD2m9CqN0obRhTuDRtL-js5XsHs97>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 Jul 2026 08:56:11 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v3 3/4] read-cache: add remove_file_from_index_with_flags()
Date: Fri, 31 Jul 2026 05:56:04 -0700
Message-ID: <20260731125605.3638938-4-gitster@pobox.com>
X-Mailer: git-send-email 2.55.0-599-g5cacd2ad51
In-Reply-To: <20260731125605.3638938-1-gitster@pobox.com>
References: <20260728215219.753678-1-gitster@pobox.com>
 <20260731125605.3638938-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

add_file_to_index() takes flags such as ADD_CACHE_PRETEND and
ADD_CACHE_VERBOSE and internally handles both reporting (e.g.,
"add 'path'") and suppressing index updates during dry runs.

In contrast, remove_file_from_index() takes only istate and path
without flags.  Callers that perform file removals (such as
update_callback() in read-cache.c) are forced to manually inspect
ADD_CACHE_PRETEND and ADD_CACHE_VERBOSE flags for removed
files.

Introduce remove_file_from_index_with_flags() to encapsulate
pretend mode and verbose reporting for index removals.  Update
update_callback() to use the new helper.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 read-cache-ll.h |  3 +++
 read-cache.c    | 19 +++++++++++++++----
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/read-cache-ll.h b/read-cache-ll.h
index 71b87615eb..8eb266cfd1 100644
--- a/read-cache-ll.h
+++ b/read-cache-ll.h
@@ -391,11 +391,14 @@ int remove_index_entry_at(struct index_state *, int pos);
 
 void remove_marked_cache_entries(struct index_state *istate, int invalidate);
 int remove_file_from_index(struct index_state *, const char *path);
+int remove_file_from_index_with_flags(struct index_state *, const char *, int);
+
 #define ADD_CACHE_VERBOSE 1
 #define ADD_CACHE_PRETEND 2
 #define ADD_CACHE_IGNORE_ERRORS	4
 #define ADD_CACHE_IGNORE_REMOVAL 8
 #define ADD_CACHE_INTENT 16
+
 /*
  * These two are used to add the contents of the file at path
  * to the index, marking the working tree up-to-date by storing
diff --git a/read-cache.c b/read-cache.c
index 58c378414a..ad77c0d5e2 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -638,6 +638,20 @@ int remove_file_from_index(struct index_state *istate, const char *path)
 	return 0;
 }
 
+int remove_file_from_index_with_flags(struct index_state *istate,
+				      const char *path,
+				      int flags)
+{
+	int verbose = flags & (ADD_CACHE_VERBOSE | ADD_CACHE_PRETEND);
+	int pretend = flags & ADD_CACHE_PRETEND;
+
+	if (verbose)
+		printf(_("remove '%s'\n"), path);
+	if (pretend)
+		return 0;
+	return remove_file_from_index(istate, path);
+}
+
 static int compare_name(struct cache_entry *ce, const char *path, int namelen)
 {
 	return namelen != ce_namelen(ce) || memcmp(path, ce->name, namelen);
@@ -4004,10 +4018,7 @@ static void update_callback(struct diff_queue_struct *q,
 		case DIFF_STATUS_DELETED:
 			if (data->flags & ADD_CACHE_IGNORE_REMOVAL)
 				break;
-			if (!(data->flags & ADD_CACHE_PRETEND))
-				remove_file_from_index(data->index, path);
-			if (data->flags & (ADD_CACHE_PRETEND|ADD_CACHE_VERBOSE))
-				printf(_("remove '%s'\n"), path);
+			remove_file_from_index_with_flags(data->index, path, data->flags);
 			break;
 		}
 	}
-- 
2.55.0-599-g5cacd2ad51

