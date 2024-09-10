Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B0818132A
	for <git@vger.kernel.org>; Tue, 10 Sep 2024 02:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725935359; cv=none; b=hZnWqSBW5PJPrDaN8pnFHQ/qbb5QuvmNc8JzOyREE9hB0IulKpyezu65I3CoD7BfPbF8yIPd0V63UnM9OCwbO8CbeWbwWeD2d56j1nsj0HeGVjm1y2KJ4VmaT7AeD43sUgoiR74LkZS1PIzPkDOLtOPwnjHoiUqNJp4MyRVltBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725935359; c=relaxed/simple;
	bh=VvZ16Ozx0DyoLT8whGnDIq5AaFJThd9mhJCzrRsC+nE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=nePHrNLNjpZ7Gt57eqPFrCCQCkt4gkO9YGXlNaeb29gBHAcryNphR80hp7hEkTXVnP8LGE2ksmOZMfqxxfaZs8QP8HXIKkI6FZDW5TVP/Q8EwSWAHBZalqeWkO8TmsiT8PO8V9afJ7son/fDXK3UEyIbAhcnL3USXhtmr9foIXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U73UYKao; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U73UYKao"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a8d2daa2262so253320466b.1
        for <git@vger.kernel.org>; Mon, 09 Sep 2024 19:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725935356; x=1726540156; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5SrrzhqQHt1RgqpPZdritqFwaRXue5QjWL7rwmunmcI=;
        b=U73UYKao04nCErVjLvETqG8uNDko78+gOsEM35GV4caBM1v1TDllkOJZv3ZabVW1h+
         K+9uj1fTAXAWZzUyaurTJJWIy9Ssf6w6Vet+yky4hetV7YkNPGNtJmGnPyJmmDgZYJse
         0ZeJdgRHwgksnqDUwtZ89XkyYvLXvPKcVSkhlPPwPGqgNtFj6Y3xAy7FeLcFB61j7MZS
         saMTWtt8Qh6TFia3r2BqwoyCfNL6NzwWJOvjmGQaOy+aSZnLajBdx9JopoNQHW37yIOQ
         UAAHpkmmo2/cMAQDQD76s6p+jhUksU4WuYN5Xs1brv6d0/D/Q8wbRuE7YWANLXpN8dcf
         Lu0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725935356; x=1726540156;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5SrrzhqQHt1RgqpPZdritqFwaRXue5QjWL7rwmunmcI=;
        b=P0tTLo2zBQNHeRP0tM6fZ17SGCYxRrYfM0Lg3M6gitQOK0wp5spMEw4LoMiGAN7DS2
         rIFL0rRgHbgH3HgBS61gYiSJyxKL9XFv2vUKkN0F12D/IMBgIV38VHBPmjnmN7epqwwu
         YuTT0B68rhQjUZeFNEanTYZ9LaeXox+jx8lZTFK0pxTIi4Uf93HrzDNDoPVlioY52ipp
         5mwG4gD1CG102b375LFV7njolJygr1rStaXf5ybnl8eVaDLkbh/zjBAvRfGERzt+tS8s
         ALpM5B4NE9Z6rR+PNcMY3PJ3GwejWThndvyhfw5SITry8ErH3bUcc/jj66L0WrEkZ+l5
         C4Nw==
X-Gm-Message-State: AOJu0Yx55RhpckUXcKfWuXPSwQFVfTns3yElk5oxMZqvxjKDlbU7Xs3H
	teHaNOmV4URV4drwPlkdsM4aZxNrrmYBndbYpnIcbsouTy+R3gQzXmS4ag==
X-Google-Smtp-Source: AGHT+IHOCWKipwYFAZsginAZHWI8rKphguiL5aHAMis6qHQ+ZYHxM44MfWRRO1XkRJa9ocaHGTXMSg==
X-Received: by 2002:a17:906:dc8e:b0:a89:f1b9:d391 with SMTP id a640c23a62f3a-a8a885f2d85mr993129366b.14.1725935355654;
        Mon, 09 Sep 2024 19:29:15 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25d40064sm416508366b.190.2024.09.09.19.29.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 19:29:15 -0700 (PDT)
Message-Id: <98a854c4b542309269f56ba0ae8b9a7c1504e409.1725935335.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1786.git.1725935335.gitgitgadget@gmail.com>
References: <pull.1786.git.1725935335.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 10 Sep 2024 02:28:43 +0000
Subject: [PATCH 18/30] revision: create mark_trees_uninteresting_dense()
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: gitster@pobox.com,
    johannes.schindelin@gmx.de,
    peff@peff.net,
    ps@pks.im,
    me@ttaylorr.com,
    johncai86@gmail.com,
    newren@gmail.com,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

The sparse tree walk algorithm was created in d5d2e93577e (revision:
implement sparse algorithm, 2019-01-16) and involves using the
mark_trees_uninteresting_sparse() method. This method takes a repository
and an oidset of tree IDs, some of which have the UNINTERESTING flag and
some of which do not.

Create a method that has an equivalent set of preconditions but uses a
"dense" walk (recursively visits all reachable trees, as long as they
have not previously been marked UNINTERESTING). This is an important
difference from mark_tree_uninteresting(), which short-circuits if the
given tree has the UNINTERESTING flag.

A use of this method will be added in a later change, with a condition
set whether the sparse or dense approach should be used.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 revision.c | 15 +++++++++++++++
 revision.h |  1 +
 2 files changed, 16 insertions(+)

diff --git a/revision.c b/revision.c
index ac94f8d4292..21c8b6d1bc0 100644
--- a/revision.c
+++ b/revision.c
@@ -219,6 +219,21 @@ static void add_children_by_path(struct repository *r,
 	free_tree_buffer(tree);
 }
 
+void mark_trees_uninteresting_dense(struct repository *r,
+				    struct oidset *trees)
+{
+	struct object_id *oid;
+	struct oidset_iter iter;
+
+	oidset_iter_init(trees, &iter);
+	while ((oid = oidset_iter_next(&iter))) {
+		struct tree *tree = lookup_tree(r, oid);
+
+		if (tree->object.flags & UNINTERESTING)
+			mark_tree_contents_uninteresting(r, tree);
+	}
+}
+
 void mark_trees_uninteresting_sparse(struct repository *r,
 				     struct oidset *trees)
 {
diff --git a/revision.h b/revision.h
index 0e470d1df19..6c3df8e42bf 100644
--- a/revision.h
+++ b/revision.h
@@ -487,6 +487,7 @@ void put_revision_mark(const struct rev_info *revs,
 
 void mark_parents_uninteresting(struct rev_info *revs, struct commit *commit);
 void mark_tree_uninteresting(struct repository *r, struct tree *tree);
+void mark_trees_uninteresting_dense(struct repository *r, struct oidset *trees);
 void mark_trees_uninteresting_sparse(struct repository *r, struct oidset *trees);
 
 void show_object_with_name(FILE *, struct object *, const char *);
-- 
gitgitgadget

