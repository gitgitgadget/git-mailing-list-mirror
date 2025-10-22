Received: from sender3-pp-f112.zoho.com (sender3-pp-f112.zoho.com [136.143.184.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2302F25F7
	for <git@vger.kernel.org>; Wed, 22 Oct 2025 05:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761111691; cv=pass; b=OzJE3I1RAEQBY6sKN0qZcH+9jMTDVXhKaw0g4ZutmDdPPdbPbBaOPo83pPg6ivB+CCnvkamvux+LwkY/eaRgBiYDaJKHf/cPSXNHQW36/JERobZyIJqi/lhLTdXl9JmybKNRbX35J45UoiwYuAjdb7zwpmx9Rdjlw1lu34GmqV8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761111691; c=relaxed/simple;
	bh=IZqQAdF8NNrTz+UUnJJtt0pge4KGRtF6easwD0UWSYI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VkJ/TWkU3+2rYjAJpZLPSgQQNs/UJ71bhRf8E0ZxAO6rj84M7qnfxunNEzadBoDA2nmgt+KOxXBoDVE33fIRVrG5LrjfwoiqaAupDRj3guGF39Gx7IqtOjNRudEqB5Or+aUIM93nc8v0YJa/tDlUYoJg+j/qulBBK8GAKxVHfpo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=j4pOiQRd; arc=pass smtp.client-ip=136.143.184.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="j4pOiQRd"
ARC-Seal: i=1; a=rsa-sha256; t=1761111613; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Zc5+qmv5I73gVeGwMZQWElWfBrzQKqmR7v9SoO48UShXZQNltQkAvA+RXNxnewTN1RTQyQ4cuuT1WXkmwzHurubvMnlIRzVmw/viEvyLG5/WJes2Kb+kSzaTWy04f+WH/seBpIN36rhZUsCnDWiNI0ySNp2mfQMyBuT6DovI4eE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1761111613; h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=HtoI28EtQsbWtkg+U1cljj+hJP0RVg31h5YX+yGQLcA=; 
	b=ipFoYWcGuzdg5B9Yct9n3Mitwa7k0PbOV0jHX5djn12swWWKXjmK0s8ufPEwLdB8KErycxSmFQwxhBmosKMR5lG5EeiKuBN+1uOGxVYIm4L/B447IgbZNl4nOF/M/gvNl5rMnwWtm8SsJNm5yOskz7XhkjyN9+a/UkK71gvcwMY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1761111613;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=HtoI28EtQsbWtkg+U1cljj+hJP0RVg31h5YX+yGQLcA=;
	b=j4pOiQRd0hdkOAK21EAJbJNH5P75hUdw2gqCAgcrPWT5ybs/kRvp8Vt8duVNmj0P
	zsNugU67gCVHENMh1IyclzDNIA9v6DeA0Cw2bdjhcLpTe2Q++x0ZtopvaVOpYXk/jmL
	TMTAzqjc3S9nnJzv054XXGWKOLp0R9kdUYDdnBqE=
Received: by mx.zohomail.com with SMTPS id 1761111610685348.22810570435104;
	Tue, 21 Oct 2025 22:40:10 -0700 (PDT)
From: Li Chen <me@linux.beauty>
To: "phillipwood" <phillip.wood@dunelm.org.uk>,
	"git" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Subject: [PATCH v5 07/29] trailer: mirror interpret-trailers output flow
Date: Wed, 22 Oct 2025 13:39:27 +0800
Message-ID: <20251022053951.602605-8-me@linux.beauty>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251022053951.602605-1-me@linux.beauty>
References: <20251022053951.602605-1-me@linux.beauty>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Drop the early-return branch that mirrored the
special case. Let trailer_process() always
follow the same path as interpret-trailers.
Ensure trailer lists and buffers are freed
along the unified exit path.

Signed-off-by: Li Chen <chenl311@chinatelecom.cn>
---
 trailer.c | 38 +++++++-------------------------------
 1 file changed, 7 insertions(+), 31 deletions(-)

diff --git a/trailer.c b/trailer.c
index a448380327..ac6ac2ac20 100644
--- a/trailer.c
+++ b/trailer.c
@@ -1266,10 +1266,8 @@ int trailer_process(const struct process_trailer_options *opts,
 	struct trailer_block *blk;
 	LIST_HEAD(orig_head);
 	struct strbuf trailers_sb = STRBUF_INIT;
-	bool had_trailer_before;
 
 	blk = parse_trailers(opts, msg, &orig_head);
-	had_trailer_before = !list_empty(&orig_head);
 	if (!opts->only_input) {
 		LIST_HEAD(config_head);
 		LIST_HEAD(arg_head);
@@ -1280,40 +1278,18 @@ int trailer_process(const struct process_trailer_options *opts,
 		process_trailers_lists(&orig_head, &arg_head);
 	}
 	format_trailers(opts, &orig_head, &trailers_sb);
-	if (!opts->only_trailers && !opts->only_input && !opts->unfold &&
-	    !opts->trim_empty && list_empty(&orig_head) &&
-	    (list_empty(new_trailer_head) || opts->only_input)) {
-		size_t split = trailer_block_start(blk); /* end-of-log-msg */
-		if (!blank_line_before_trailer_block(blk)) {
-			strbuf_add(out, msg, split);
-			strbuf_addch(out, '\n');
-			strbuf_addstr(out, msg + split);
-		} else
-			strbuf_addstr(out, msg);
-
-		strbuf_release(&trailers_sb);
-		trailer_block_release(blk);
-		return 0;
-	}
 	if (opts->only_trailers) {
 		strbuf_addbuf(out, &trailers_sb);
-	} else if (had_trailer_before) {
-		strbuf_add(out, msg, trailer_block_start(blk));
-		if (!blank_line_before_trailer_block(blk))
-			strbuf_addch(out, '\n');
-		strbuf_addbuf(out, &trailers_sb);
-		strbuf_add(out, msg + trailer_block_end(blk),
-			   strlen(msg) - trailer_block_end(blk));
 	} else {
-		size_t cpos = trailer_block_start(blk);
-		strbuf_add(out, msg, cpos);
-		if (cpos == 0) /* empty body → just one \n */
-			strbuf_addch(out, '\n');
-		else if (!blank_line_before_trailer_block(blk))
-			strbuf_addch(out, '\n'); /* body without trailing blank */
+		size_t block_start = trailer_block_start(blk);
+		size_t block_end = trailer_block_end(blk);
+		bool need_blank_line = !blank_line_before_trailer_block(blk);
 
+		strbuf_add(out, msg, block_start);
+		if (need_blank_line)
+			strbuf_addch(out, '\n');
 		strbuf_addbuf(out, &trailers_sb);
-		strbuf_add(out, msg + cpos, strlen(msg) - cpos);
+		strbuf_add(out, msg + block_end, strlen(msg) - block_end);
 	}
 	strbuf_release(&trailers_sb);
 	free_trailers(&orig_head);
-- 
2.51.0

