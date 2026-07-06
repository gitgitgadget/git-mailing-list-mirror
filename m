Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6604E3DFC61
	for <git@vger.kernel.org>; Mon,  6 Jul 2026 08:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783327868; cv=none; b=FugJTnYITHKNrGUc+RcwuYDnkUZzLrhU0eXy/DJ0t8hHOMn77FVcMY/bOC7GILmAdC2q1gPZ4asb7uwvd1YLW9SinE6JL00VzoF822a3VAgdwejXvxcRoylan+YzyOKkzpJL8BhpnKHngvjARpdyvxAGjKa6giMQJ0iue6V1EpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783327868; c=relaxed/simple;
	bh=v42sOHU+NPEhjIkOG/WgYyh8KYHUdpVLrZrg5hNdK2A=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=rttlP8AYu4DAZhAPJszeYh8lcqs+jJtNMpzjnIWoRbgyKi2MWMiolM8AoSGvNR/kfUCll03JFNriYNOACNCM0fkG/VzPR7d6pNVmsveAFmX6pZ/0ZhagNR05vxogjskpsZG92bIh1BhFIutZwttUeA/URo5GRng8iCqFnpaYzsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W2hBzG3e; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W2hBzG3e"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-92e85499ffbso236316585a.0
        for <git@vger.kernel.org>; Mon, 06 Jul 2026 01:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783327856; x=1783932656; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2733pf3f6XCQItOqhNRXBLMf6hYjl0Tg3jbpsScbzec=;
        b=W2hBzG3eCmhPmUYXa77hZZsUTRuo1RzTFydMHm2aE92t6x70hvIm2pTnbt6db2UE+D
         EpMnJfbFF1x79st172B0HDqDujWXH1nk4y/UAAfXEoWlt2wXLblqQUJnxUEwoS+W/DVG
         isYlkX21HR11dFbEjhiTgV4t07riIZjnnN6ZVqdTGnAYLcCULzZufJjliSpf0iQTaIaH
         pk2GsfOog+fxgDRBDYwPJb/kn40+B7YLSM49nE2PnItpzyuEOC4G31i3xnf4iHtSw8KU
         jlORkp4STKZweufOd1itJa1xn0p08QHq6jc32xohr31ZdvfPUZ6/Rxs8AnjKKeLO6zq4
         1y0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783327856; x=1783932656;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2733pf3f6XCQItOqhNRXBLMf6hYjl0Tg3jbpsScbzec=;
        b=YqrOh5NhR+5kDGKj4YAzrYa0ANTRtiVtnBW2qBeNlp/SmPkO0xrE5hBfnNKS7esCjE
         sTSwiMYlABicR9pOPLfW0qKYWforTcLu8Z1n9DnLe71SzoV/6G/m8po+B1tLZBXZrC78
         +PolpiIe2JXsRKNgo3K2RpvKAA5diq8UZ1/e3R8u5hVkQO1vFPUNBQp12dYprKTydIHX
         9vvs5GFM25pIabpbHk67qFzKqwQ914Sf+jEXJNNpcvAJ5hXoE3mo/4Vtfq/iPVS5rep6
         zIgAwfotYXJlrY3tCanlvoPrYojE4ts7zmMwuDMkTHZvpN2upUqYVuBteqAU15c5tiv8
         XxOg==
X-Gm-Message-State: AOJu0Yxxb7ib2ArlJKBpA86j2IlQyi6hW/b5SOedHnMrQeYz4elH263K
	FsRFvAwcSwMUh8l70QIdiT0/xTfGl8SocoTQtPx0GH1OK8j3b7N6Ww/zr2Yvn4Vk
X-Gm-Gg: AfdE7cnN1W+qyMELaAq52RvAXZ7aGKoOZxiH+fcAdpeDiRizyFwdP1ETha9KJAZYg2s
	UTfb8TEVUGus67057GcifBNNK57UA4Q6raHHbwtbKyrBOz457U0B5ZkfBZNPN5nZ5USySYVHLhH
	LVaHieXBzoROdyzlLL7WIQcrMlQqUisbKWUwhfxtb2LPnJJ9nR1NTsTn9xuIw7fp4GcmHbh6JQo
	1AE7x8Edv0H3NEmA7e1J7wpwYycGS83jeh64WQtW8jul/6rCyIqA5zTRJdPIDCU5dhhHOSdAg4M
	owYn9dFS1kekAg9WPpGRkbyDR1EBs01FwktIn3bt6PF14zvv7LlATnCpOVyqSKgdfGv/lL8IUGX
	Oos/54oPO1is1IjNL4bZGK4HjHLFvQ4z90dEvocQ14YRAqOd1yPGbvvSGKhzMkUDHkTlPMB5O3O
	J22x7lSD96A9kHzi3jiQk7Be3NMg==
X-Received: by 2002:a05:620a:29c1:b0:914:afc1:c66d with SMTP id af79cd13be357-92e9a2f76e3mr1340943885a.11.1783327856209;
        Mon, 06 Jul 2026 01:50:56 -0700 (PDT)
Received: from [127.0.0.1] ([4.227.174.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e90ba1a3dsm902548685a.15.2026.07.06.01.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 01:50:55 -0700 (PDT)
Message-Id: <212e9c228f03a10203a38ba3cf5e522e070c53ed.1783327849.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2337.v7.git.git.1783327849.gitgitgadget@gmail.com>
References: <pull.2337.v6.git.git.1782635349.gitgitgadget@gmail.com>
	<pull.2337.v7.git.git.1783327849.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 06 Jul 2026 08:50:46 +0000
Subject: [PATCH v7 2/5] history: give commit_tree_ext a message template
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
Cc: Harald Nordgren <haraldnordgren@gmail.com>,
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
index f95f26e684..305bde3102 100644
--- a/builtin/history.c
+++ b/builtin/history.c
@@ -101,6 +101,7 @@ enum commit_tree_flags {
 static int commit_tree_ext(struct repository *repo,
 			   const char *action,
 			   struct commit *commit_with_message,
+			   const char *message_template,
 			   const struct commit_list *parents,
 			   const struct object_id *old_tree,
 			   const struct object_id *new_tree,
@@ -130,13 +131,16 @@ static int commit_tree_ext(struct repository *repo,
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
@@ -189,7 +193,7 @@ static int commit_tree_with_edited_message(struct repository *repo,
 	if (first_parent_tree_oid(repo, original, &parent_tree_oid) < 0)
 		return -1;
 
-	return commit_tree_ext(repo, action, original, original->parents,
+	return commit_tree_ext(repo, action, original, NULL, original->parents,
 			       &parent_tree_oid, tree_oid, out, COMMIT_TREE_EDIT_MESSAGE);
 }
 
@@ -644,7 +648,7 @@ static int cmd_history_fixup(int argc,
 		goto out;
 
 	if (!skip_commit) {
-		ret = commit_tree_ext(repo, "fixup", original, original->parents,
+		ret = commit_tree_ext(repo, "fixup", original, NULL, original->parents,
 				      &original_tree->object.oid, &merge_result.tree->object.oid,
 				      &rewritten, flags);
 		if (ret < 0) {
@@ -855,7 +859,7 @@ static int split_commit(struct repository *repo,
 	 * The first commit is constructed from the split-out tree. The base
 	 * that shall be diffed against is the parent of the original commit.
 	 */
-	ret = commit_tree_ext(repo, "split-out", original, original->parents, &parent_tree_oid,
+	ret = commit_tree_ext(repo, "split-out", original, NULL, original->parents, &parent_tree_oid,
 			      &split_tree->object.oid, &first_commit, COMMIT_TREE_EDIT_MESSAGE);
 	if (ret < 0) {
 		ret = error(_("failed writing first commit"));
@@ -872,7 +876,7 @@ static int split_commit(struct repository *repo,
 	old_tree_oid = &repo_get_commit_tree(repo, first_commit)->object.oid;
 	new_tree_oid = &repo_get_commit_tree(repo, original)->object.oid;
 
-	ret = commit_tree_ext(repo, "split-out", original, parents, old_tree_oid,
+	ret = commit_tree_ext(repo, "split-out", original, NULL, parents, old_tree_oid,
 			      new_tree_oid, &second_commit, COMMIT_TREE_EDIT_MESSAGE);
 	if (ret < 0) {
 		ret = error(_("failed writing second commit"));
-- 
gitgitgadget

