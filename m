Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CFC93B6378
	for <git@vger.kernel.org>; Tue,  8 Sep 2026 20:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788900126; cv=none; b=ArziZYF/Ub4+Bnjsa6bNaOw28GrjKKKxqJxb1CImUsDFQmTJxthilgANEuuG2MSkpcsvuXAga5OtdTGepl8G+aC82Q9h4HCkRifygXvTymsC4VsEV65jFumJcRMU+Q/nvxRSSHpynhpIu3+HtxI8YCqTPlLfl4OvY6qCapHZ0L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788900126; c=relaxed/simple;
	bh=Qlw5ArwqpUvv+GwBilOYc/NbsKYNhuo0w1wlRcFsLzc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=OiwnX2liBAMs3NE1ZrwVj3LoWrrFUjZnhlJGTgNBtFISm0SQnaqhyFpaceVQwNxi0rsHhN0EyPGHW7+P7yWi2aepkzeWq9m9FdPD8yq7cO/pWjYrcVCVkqh2vW5trYxjjUTLL8lMtp4FE6yOpwOjncUqDnWPzKY+fKAOM52Bjgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HKuzC7+J; arc=none smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HKuzC7+J"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-90ef16ca83eso4525996d6.0
        for <git@vger.kernel.org>; Tue, 08 Sep 2026 13:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788900123; x=1789504923; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1MANe9lQPFH+VlE97G8EHUib2wUcQHWWgKSk5STbLHg=;
        b=HKuzC7+J2vHuhb7YUI2+z/PZlOy5/tPPHY8FyZVrukG5smjFHvs80Q2cBdPstbpXR2
         DykHzKJYWECWe0l7xYAUPLzEVwQCTXOht3IUmkBAr4YS7SlFz9zKqI4KmQ+MqyyERHr4
         L6H++ehtbFmMsX8yAODUq3qvNygbVho48gj3RFyG7i0dHP/HQCbc+gVLfncE3Yd9ukZp
         tEFyBCGAvWutXCuuktHF1H9LEVz+CwivU7Qdv8YtuutltfilXJ2gxo3ILhGBKhNGLGOB
         SZyg/XIokeRPrZtDOkKGcrMQcAJWc8BINGnKoMTNEGicGI+glV/LVhxbRxmJECrPaAUz
         mzSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788900123; x=1789504923;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1MANe9lQPFH+VlE97G8EHUib2wUcQHWWgKSk5STbLHg=;
        b=YFj+sicXjIy0pXIe3RqUyINlgUVUHvmGvOSB8PPx0Cu+G+SEaXNVdp7jYxDppeXf6w
         ixjNEmsSlACDin0yO9OZGRUYgOGDpGFrXNFtK+9wip+Vz2o4PiVkhgBh6Ma7fGlcnr5g
         pu51ZVGDqRBBH/TJEs0MCw06ZIhaJl2e5J+9y2Puu5gHYr6LZ1zhg2asGjb7TBhBq2uE
         pvbgaKxfBS5ufR0ZhPKccaYOKvvSIVOx6nXQKIye/6DONAR4mC0cOys4xppi/dU/anqp
         n3ERvT2pduTKj21G9PgDCo2qnkmdvH/n9Pt2d6svVSHZMY1jEX0b/bUz6jSLTLqaPIjO
         HBEA==
X-Gm-Message-State: AFuF++k0MC05vvDUGK0L6Iz87+oVnhG4/A4pytWYtrFUr85CVjG8wp10
	cNWrJwQHUYRt/yJMjq0j1HofCIKDdcHgTFHS5AcuJqJS0rRJKXFO3Hrsdg2YqQ==
X-Gm-Gg: AYBFou1dJeBpP+pORR2kbNEHF9gvx0PJVPSvfBiBxXpYfSsMDGrXdDzNMIRnExh5bk3
	QQ/uVGAfsgo638wgS2+3PEdpPZDDIoBCKbSitetWtt9Pb+Yaq/5rfFMg0F5uDsQ1UWJSPaiX6xU
	pJ0xIipmCwFO8dJZBv+oLgiGIuzy2fORn+w9ijIzhncOJko/2pQ2921xgg4cIGpCcHMuL2lCUzO
	1JTaAai1mbHvo50rArlOpnx0JJXGNfe2uJI8zBc1vXXTsEsMloHLlmV7Eb5Tjk5Lhd+BzEFyRTF
	WKTybKl2BXbNJdoDLR7jMK2+3DXTDoZSZ8ASjPqk1hLQs2HJFL3HnMt8mqvoi1Vgp4sJPPhIW6B
	nXqFCQ6kuv+8hunLmzFWk7hw/72AUT2Pup91stBc0TBAMk7yEPdIMIJ9YXyfCDWU/fC/ClcokIU
	UVZ5uFny5BBzCr3Em+JmrAONcPVZcxaUgZ8ob27hO43whCSZreSOiIHy8pECuNPtCQ
X-Received: by 2002:a05:6214:b64:b0:910:1989:a61a with SMTP id 6a1803df08f44-9106b3db560mr28806636d6.9.1788900122825;
        Tue, 08 Sep 2026 13:42:02 -0700 (PDT)
Received: from [127.0.0.1] ([20.106.198.166])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91040694543sm125400906d6.33.2026.09.08.13.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 13:42:02 -0700 (PDT)
Message-Id: <9d99354988def36e76d27419975fe2424c799b72.1788900119.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2337.v15.git.git.1788900119.gitgitgadget@gmail.com>
References: <pull.2337.git.git.1781465141.gitgitgadget@gmail.com>
	<pull.2337.v15.git.git.1788900119.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 08 Sep 2026 20:41:53 +0000
Subject: [PATCH v15 2/8] history: give commit_tree_ext a message template
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
    Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Tuomas Ahola <taahol@utu.fi>,
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

