Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4051043BDB9
	for <git@vger.kernel.org>; Tue,  4 Aug 2026 08:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785832259; cv=none; b=XPgwJOcx3802VnMPFZ0Pl4jqdUsygfnQNfAmTP0HtQHTUWUdhneBJxLaRX0I6XjKfj7Miqm7BZWu87QC1+CQjtadUSkuk2oc5PUXButnbcaMZlDNTeY3AQQLGrr4vief2jWeAoQmU6u5Xc86SCodyj7K+4Ki/3TLkkTQIaqHaJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785832259; c=relaxed/simple;
	bh=Qlw5ArwqpUvv+GwBilOYc/NbsKYNhuo0w1wlRcFsLzc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=gHMVIyIrsGqnGnht6C/KMQJlzViHKfUgeAwGbpMQxI0Zj+F922jQQyG2YBWUHzC8NIdTyvUzBD4nd4rXhw6vij2RU2/W95Tlqs5eYC4iqAWjB7mPj0mR4/T5LeCKOmK+zhP9nzZEn+tkQWrx3tAUZ+8XefMrNjbzVDrpqDHgC3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qa/e/9ev; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qa/e/9ev"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-81ed000b507so38274697b3.0
        for <git@vger.kernel.org>; Tue, 04 Aug 2026 01:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785832256; x=1786437056; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1MANe9lQPFH+VlE97G8EHUib2wUcQHWWgKSk5STbLHg=;
        b=Qa/e/9evyDG/9ULufhvWGjxH5dtt9acpfMZVSlzWlzqQOTmHzNTVInNTR/fkSoOA5L
         32TN8B4ES80iDbJUFY9+y/aaPX1UVSF0jXguidLqBuBLYT8HbT6ObX7VtLV+ReBwg+Cp
         HdYmBqXidMWrEZbOHEKmvUjvBVbQG7x4kx24wf1DnbW0VWVmEMn2gu7ARRM9D6EecFjk
         imT/YhExTqag/y19rVgxwjRgq4KRqBNo4fyXaUIBetqxC/J2tGu67ZvJDL7TASMB3EwE
         PVaHbkQLxOTjhRrEH9Voc4FOMKcr5/gIl6qh5x0DLFMNhHawUJdjPvByJmoOs448AqDF
         jtww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785832256; x=1786437056;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1MANe9lQPFH+VlE97G8EHUib2wUcQHWWgKSk5STbLHg=;
        b=n0cwkM5z/d/8TQE4fgV1Vthx6z0WKj/BEV6/SgadlwH8b2XMK0+5wvUXG7IJwiVmou
         Svx2eTVIrCUFSGlVM1tVOnyF18O0xWm7o/+uGMOVyHLzFS5wxSd4zy4etkGr+b7IRGJD
         QEZE1krozSQ71Z8qxXa4eJd/o1YrxL5cD/EVNttO+35a3021ZVutuiaWseehtGP//zZL
         1KmgAQ/XB11XRqSmFUiyCWDyEr13fGt5wjs0ZVSndvfHkA9UqrUdFQVzX8NfGeflLMjg
         Zy5xk3joxmeL6TZ+nFgKa4JNljw1IZPHWUrs9BJm+DL14dOLXJyeATq0pTVzuK6I4uDg
         e1Aw==
X-Gm-Message-State: AOJu0YwgyV7QrSZ8HImiujbxE7XfXUyhnxepZ3EwgHF6XrvFJI++sO2p
	T9eJSIew9TIMzlzdHVE+vBbUmCtd0S5F7S7PXXZiemkBh4edkKeKfqKNy8Nkcg==
X-Gm-Gg: AR+sD13hp5Xur+hsJjue1NK1vPusppueElyyNNJPAnBiQR0Z7+OdAKKhI9rfnmdAGNY
	4+zN/T9kgskoqvcQ4ffVv8PqMIUJFofbuhYVKX6tKumIDaJpGp7lUPvFBbgpe6YUL4FpYEnicss
	ouRAo0lBDflvZj41JNCm6d7Bn5i4Eh1t6ozgD/paV4tKSEPnby8L2pULj7j44W/8JNwUVyWPCT8
	bp0WuovftBQLjvZtL8g9CPTEBnQQvweoTqG8ko04kKSqYwNPJfDRZjCFquJWt4Zh0ynnzx5m7uf
	eIJjvkcU845tB1x6G9/CZ/UHGJ5xWKbCEPFr0V7ut70FxF1bzt3TeLOsHYzA6L7w5BmGNnBHK0p
	sA6kJpOMc6h/QCpuO0a7z7oeRnI+kyxLI26YZE4al0CKTHFgzcEt+wJSQa//ntAbg6iKO+DVthh
	cj2/fyhgK4htrOsYdGajK8E+AxibgYT24dwFN9Z1qFPUcRa5gApMF74hROAlgYIN0f+qAKMVTj/
	w==
X-Received: by 2002:a05:690c:a94:b0:81e:d001:e0da with SMTP id 00721157ae682-81fd4b521f5mr145917477b3.18.1785832256062;
        Tue, 04 Aug 2026 01:30:56 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.143.40])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8201341c6f5sm1460027b3.28.2026.08.04.01.30.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 01:30:55 -0700 (PDT)
Message-Id: <b99867a0d463e08de45258e6bc585052661fae89.1785832251.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2337.v12.git.git.1785832251.gitgitgadget@gmail.com>
References: <pull.2337.v11.git.git.1785567209.gitgitgadget@gmail.com>
	<pull.2337.v12.git.git.1785832251.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 04 Aug 2026 08:30:49 +0000
Subject: [PATCH v12 2/4] history: give commit_tree_ext a message template
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
Cc: Phillip Wood <phillip.wood123@gmail.com>,
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    Patrick Steinhardt <ps@pks.im>,
    Matt Hunter <m@lfurio.us>,
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

commit_tree_ext() reuses the message of the commit it is handed. A
caller that folds several commits together wants to seed the message
from more than that single commit, so add an optional message_template
parameter. When NULL, the behavior is unchanged.

Pass NULL from the existing fixup and split callers.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 builtin/history.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/builtin/history.c b/builtin/history.c
index c22715d848..a60e8dbcd0 100644
--- a/builtin/history.c
+++ b/builtin/history.c
@@ -108,6 +108,7 @@ enum commit_tree_flags {
 static int commit_tree_ext(struct repository *repo,
 			   const char *action,
 			   struct commit *commit_with_message,
+			   const char *message_template,
 			   const struct commit_list *parents,
 			   const struct object_id *old_tree,
 			   const struct object_id *new_tree,
@@ -137,13 +138,16 @@ static int commit_tree_ext(struct repository *repo,
 		original_author = xmemdupz(ptr, len);
 	find_commit_subject(original_message, &original_body);
 
+	if (!message_template)
+		message_template = original_body;
+
 	if (flags & COMMIT_TREE_EDIT_MESSAGE) {
 		ret = fill_commit_message(repo, old_tree, new_tree,
-					  original_body, action, &commit_message);
+					  message_template, action, &commit_message);
 		if (ret < 0)
 			goto out;
 	} else {
-		strbuf_addstr(&commit_message, original_body);
+		strbuf_addstr(&commit_message, message_template);
 	}
 
 	original_extra_headers = read_commit_extra_headers(commit_with_message,
@@ -196,7 +200,7 @@ static int commit_tree_with_edited_message(struct repository *repo,
 	if (first_parent_tree_oid(repo, original, &parent_tree_oid) < 0)
 		return -1;
 
-	return commit_tree_ext(repo, action, original, original->parents,
+	return commit_tree_ext(repo, action, original, NULL, original->parents,
 			       &parent_tree_oid, tree_oid, out, COMMIT_TREE_EDIT_MESSAGE);
 }
 
@@ -675,7 +679,7 @@ static int cmd_history_fixup(int argc,
 		goto out;
 
 	if (!skip_commit) {
-		ret = commit_tree_ext(repo, "fixup", original, original->parents,
+		ret = commit_tree_ext(repo, "fixup", original, NULL, original->parents,
 				      &original_tree->object.oid, &merge_result.tree->object.oid,
 				      &rewritten, flags);
 		if (ret < 0) {
@@ -886,7 +890,7 @@ static int split_commit(struct repository *repo,
 	 * The first commit is constructed from the split-out tree. The base
 	 * that shall be diffed against is the parent of the original commit.
 	 */
-	ret = commit_tree_ext(repo, "split-out", original, original->parents, &parent_tree_oid,
+	ret = commit_tree_ext(repo, "split-out", original, NULL, original->parents, &parent_tree_oid,
 			      &split_tree->object.oid, &first_commit, COMMIT_TREE_EDIT_MESSAGE);
 	if (ret < 0) {
 		ret = error(_("failed writing first commit"));
@@ -903,7 +907,7 @@ static int split_commit(struct repository *repo,
 	old_tree_oid = &repo_get_commit_tree(repo, first_commit)->object.oid;
 	new_tree_oid = &repo_get_commit_tree(repo, original)->object.oid;
 
-	ret = commit_tree_ext(repo, "split-out", original, parents, old_tree_oid,
+	ret = commit_tree_ext(repo, "split-out", original, NULL, parents, old_tree_oid,
 			      new_tree_oid, &second_commit, COMMIT_TREE_EDIT_MESSAGE);
 	if (ret < 0) {
 		ret = error(_("failed writing second commit"));
-- 
gitgitgadget

