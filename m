Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B414756D1
	for <git@vger.kernel.org>; Tue, 28 Jul 2026 21:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785275546; cv=none; b=eW+UmTWogz2B1PzkGCZ5EO0xuenEBN4UVa08EDYrWeERoLtRg0x2rNxIAIlpMuwwQCZRT/s4qMhW01yZaBU0v89WxasrqpITJhOqR/hiv0GTbHab+qhkkxMoool3oPAotl4GKqMom/pCNKKB7qSFG3t54McqibinH38uPVOyrG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785275546; c=relaxed/simple;
	bh=RBd+s7AwTPxB+cRGnqrS4dx3t7YIOZaS8k/IVs8Wmug=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lgJjUgxVMmtbF7nRE+BafmCS/SAYssdFDlYj2uXLFwJcyIelrTMC4l+EUC4ic8KNUpNUexkG/SNJvR869PDitDGYV3P51bHEMqPQ2jnvhvxkqAX6EUQCYPN7lDl7ETFjHVLTEqa+r3TVW3z8O3jOXaJxY7uFHD286CM6Tg2tohM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Xh5Cac5g; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BHjvRuje; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Xh5Cac5g";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BHjvRuje"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 777887A02D7;
	Tue, 28 Jul 2026 17:52:24 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Tue, 28 Jul 2026 17:52:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1785275544; x=
	1785361944; bh=C5YRHlza+8JIXowMxR7LOxQaglIMyDcPwXj/W1jju98=; b=X
	h5Cac5gCUV1iGhTkll4AxDLBv272FTf7zMmiAqDP1CpPBXpym0L0waHBzr2LlNwG
	Whz1hD4MkG7Y/gMffvjHl3YOeAQ96LjHgnr1qSnTzglVwOJxk6HHNnb5SJ3T5J1g
	LAxTatCjgHvVKYZk+3c4GRwKj5NO0iTPxKniME8V3IOZPHdtku08nQG/K7P9Rj2a
	Z4qV6/qmTufiXscoHSN9NFGSdF2ih6WtI9CLiqZzLAl7/LWm/vebALvEsL7n7XMl
	cLfNbg27B8/lU8ymrwQ3lagwzwyv/XSIag2ReX7PRyZTKPaUNCKLvEij+vtISEZM
	rRd2lE7VDNc3zOoMpBy1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1785275544; x=1785361944; bh=C5YRHlza+8JIXowMxR7LOxQaglIM
	yDcPwXj/W1jju98=; b=BHjvRujejUftsZgtX2OWWyFgaZXsGAGWK8MQNw2S73ig
	TTmwpKzziuqjcC9TEGLvliXmc1Ng07sTV5R9sPeWLHan4P9w6+d4imyjpJdFCtyi
	4dZ5PZ0lm6S6LTc64gYVEGKk7wSIOxrpWBIsECCuVFiZTaHW2xf7QHcmA6Wf4E6t
	kzxyxMhtmynw/V1zSdDilwRQoE+ALUE/dCNdJgu7pBaarTwIvH3aO+p62CQ1NzRU
	3sT7lQRbGbEtsPit/OLg3vqFLuUrvjpFrxdrJP4vv8sQ1ljAjaY9bEtFE2zVueWd
	QxWmlAPi7M+Hw9fAHZylqjrBk8Zjguy9cmJXnWTAsQ==
X-ME-Sender: <xms:mCRpajnti5zuoZW0xObmFlWXHh-HgaevMBeAO8kDkvdXNkgx4cvvgQ>
    <xme:mCRpas3W1FV3htTxG2uSnxjX01gHQu3m01fnURYAgyVlMWJnN-ghxe22Ilhjwro84
    GqBoBmpE_Wu82oswzEIdyTk_SccFCgs6hXP2nz-8zJmHfTDODDVgg>
X-ME-Received: <xmr:mCRpanSZ4MPaOuwrfa_-9kCOwMcNVymPXOMsbKxl9KIzmcbQV6eeG63wQwnOhEcFwJgtXXXx1Vu-unT-96iKfjlNArlhGUw_Yw>
X-ME-Proxy-Cause: dmFkZTENokmCfF4brrBsGZ1UDBa8Un+p+vEyOEHif+FXrrVATFlQ2oZgzu1txpSutD2+X5
    irLx4rfAcRCRJcE0p0ZM+a/LKmn6UrLBYElwYAs183cLdvkj/Pd5W9uAA7Z3ZBNbYfPKwJ
    8/ruVvBa9klzWxyzQoV8e/m0tx379woNqIVCQMVJA5xNGXQhPf4pfc/DCdtuKFp0PtJqAT
    luZwMtLjMrwwi+EJCtPpJMGts6INVYozSLJQuPMrm3z98xQnbmkwURxpozrcQuJwakUEyV
    IfFMsq8gjkY89rwqjbUqKLJaMZcMzr4HWMX7iIploR75vzmbBF3yXBrxNafChuPEg4q1Wo
    8tJSAgm8SdmS2gtTf4DpFcL/nynay5xU+/Oou2UDPPTIUfNSIzbyIBYt+700oEXlbELa3Z
    ABfR8EqC2ie6Z6DtyJ5w/vZmv/Mgxw4ZA0NNKUZtO3mOhV92XzWv5Ppa8Gz3J66GIuVyF1
    3c1maBHYHqtfInrRsj2P71/ylQ0pKbLWIjBzL4YEPcKWZtnXWwomSyu59wOKTF5Zot2TC8
    5ew/YZmPoRCjWcs6Ku67Voza3aKb7GdBFT02d2ECWpBRUaODaIK+fextqo5kgJF3TdD3N0
    odD/q96lohAC0PZrfz5NtcjPfKK9xZtP5LGEWOKF8x464PszfCze117mEdIg
X-ME-Proxy: <xmx:mCRpamvXSWezYLXJnTbeSTlTSX_DUDuxJGg75n5BGaDOemh98RRwyA>
    <xmx:mCRpakZYZZweD_NyaS32VHnJ47DA91qmnCXi0QtKsI6QotilUvt8OQ>
    <xmx:mCRpajtllVaQEU2ryPezXCG_9IvzDehLmR7eeKgMQs43oPyM2IdxUQ>
    <xmx:mCRpauHOh244N3H44htL75WcyvNJiu3cwV_gRkm36u047qdRJA6HPA>
    <xmx:mCRpau8LJQ_cjxGb3FmGR3cpnpdEHRTpPVplF4KvVV8-RyBE5vOVTC3Y>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Jul 2026 17:52:23 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 2/4] read-cache: add remove_file_from_index_with_flags()
Date: Tue, 28 Jul 2026 14:52:17 -0700
Message-ID: <20260728215219.753678-3-gitster@pobox.com>
X-Mailer: git-send-email 2.55.0-594-g42d2bf033e
In-Reply-To: <20260728215219.753678-1-gitster@pobox.com>
References: <20260728215219.753678-1-gitster@pobox.com>
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
index 38b55323dd..6fbab77225 100644
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
@@ -4002,10 +4016,7 @@ static void update_callback(struct diff_queue_struct *q,
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
2.55.0-594-g42d2bf033e

