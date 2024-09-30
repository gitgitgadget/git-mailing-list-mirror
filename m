Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089A918892F
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 09:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727687634; cv=none; b=PNUtJoKnzpJEfkaNwoWluYA19G3Zm5ynSQOLNFGaiZBWp0xwp1+xHbr1jZ4UcbUWk5i1dYBi10tbj26ZA8Zd1BCnOc5M9D1LppZIU2pcVwfG7rQ1/ZdNZjIhQyCuekK8LQVCOJ3tH7tFSQzGTjT76FJUstT4V3ZVL8RaKaZme88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727687634; c=relaxed/simple;
	bh=tIjyd92U/zjhAzxQ174Uh0LVYzjb7xvYHNpcZrVj9Yc=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KY6KnbMVLbbblX9lU/j+p8c62Ur7pFCck8lN48iiU/zjDFnFHdI4j/OfbxUPs8QLcQySuoSjg2Wr9vTLVwpaCe/mZ/gw0VHAXMGpBDApFaqpMuVoAl64wHFnc9tCioS9vhTmOzDLySzVRWDs/cdHPWN3vLfE49vwFVM4HCwD27U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=njunO4vm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iGoulgdG; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="njunO4vm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iGoulgdG"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 44B8213803A6
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 05:13:52 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 30 Sep 2024 05:13:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727687632; x=1727774032; bh=lSu7ojzHzx
	w0l63Gw41WQmmw9/lZt3eXDeVkUcX2bms=; b=njunO4vm01TabnOUSNizWmiFhS
	cyowdxZSplq4GApLtlobTdpc6pGuQ2d88gK4pxnpW3D+x2O0I8dOz+PbVNFJcZgN
	ehQ7Nr9hUBcDNLk58KHVuzq6HO1njPER9FPhTq3zTnxiez7nt8LDTmedHOv9WS94
	Y66w968vY+wI3n3okYVMaF3opQYEokuGw/v36PQeCl5kM+j6gGJPcOU5YVqA9PyD
	6aE2WSAPMLHU/KJe2snFrZIvzQNAsWfC37Mo9iBJI98l8Kn1Vax7Yw4p37KXpn0B
	DWKagw1WvvYr7/a/odCZWRzE+qCiL7UeGCa8uq7yDaNVx8whOagw9R4rQCyg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727687632; x=1727774032; bh=lSu7ojzHzxw0l63Gw41WQmmw9/lZ
	t3eXDeVkUcX2bms=; b=iGoulgdGFcYpSNapH6dIhJGcAbDmbYDKUAJ/pUsN93mJ
	3c5OlyZIQayl3dyLW99uwMP4hqOFEYrpwkqBrcXQWRiWlADDEFt6U9u3YMbfmttY
	6wYXNaDzF1JF6sqr/H8SuKo6toZl8dBZ9PhqWZZl/3aPcUMg/uBj7vw/iSMUiBvL
	quZYcUgJw4xdoM3pmhtm6gnDifZ80nWnYWgWNmTSuZzlB5vbtsnSj5tIvDSTuJ1+
	HnRehxFbzyrvO+cOnxq8LKPPWcRQeWdCLQIQOYCWq52FMIqSeva34/ErSGeECkp4
	4TYO5/3Kn1Beoo6xWc/T+gFODUBg9WHSm4M/BaAPSQ==
X-ME-Sender: <xms:0Gv6Zirb7aVeNCZ5rJOar-Uz460dWkmCwv8G8y7G9joZFmu_UDPdJQ>
    <xme:0Gv6Zgop3Bd1clvfzxwR0_NQyhYXdvODcWOs6hvjSBY0Mt98djo2Va4k83Rk3kfPe
    H8cD61OwLVTewiIKg>
X-ME-Received: <xmr:0Gv6ZnPNNG7A2jgvDyrX3W7vuzjatVcNAwdGP95GCrEq4GMu5pFDt_A3V8XsaShI1ZY79-0im4V-RZX-Fo2qpjbj6oy8tzMpAXbxrXwOBr2lgow>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduhedguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuf
    fkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhh
    rghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepheekfeefgeegvd
    egvdeffeehtedttdffjeeuffelgffgheefleffleejvdefheeinecuvehluhhsthgvrhfu
    ihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspg
    hrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:0Gv6Zh44-MFNXxYVUPApqE_AzV74FjxoDmjVUkadW2LR_tmKPl-cnA>
    <xmx:0Gv6Zh6dBpWd0bEHR8H5lX3t4pqyG9884GyyO4krFlesd5u4T2lPdg>
    <xmx:0Gv6Zhh2iMGUa-aY5AxG3pt-0WqffE0icmKU_2EVebmsufbvibGhOw>
    <xmx:0Gv6Zr5p8SEjC5c_yxLOLmIdBcx7DScO_u5aF4aRkOYqXjFZMZxjSg>
    <xmx:0Gv6ZjTphgX8wwRKs2G-FsFXD89axHqJN6Cc6ncc3U3tWqxpMV4CJ9TN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 30 Sep 2024 05:13:51 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 3ed19c60 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 30 Sep 2024 09:13:05 +0000 (UTC)
Date: Mon, 30 Sep 2024 11:13:48 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 13/23] line-log: fix several memory leaks
Message-ID: <d3121c2522cc723ab4df71979fd9194260a6a57e.1727687410.git.ps@pks.im>
References: <cover.1727687410.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1727687410.git.ps@pks.im>

As described in "line-log.c" itself, the code is "leaking like a sieve".
These leaks are all of rather trivial nature, so this commit plugs them
without going too much into details for each of those leaks.

The leaks are hit by t4211, but plugging them alone does not make the
full test suite pass. The remaining leaks are unrelated to the line-log
subsystem.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 line-log.c | 54 +++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 35 insertions(+), 19 deletions(-)

diff --git a/line-log.c b/line-log.c
index 89e0ea4562..ee48988c66 100644
--- a/line-log.c
+++ b/line-log.c
@@ -248,8 +248,10 @@ static void line_log_data_init(struct line_log_data *r)
 static void line_log_data_clear(struct line_log_data *r)
 {
 	range_set_release(&r->ranges);
+	free(r->path);
 	if (r->pair)
 		diff_free_filepair(r->pair);
+	diff_ranges_release(&r->diff);
 }
 
 static void free_line_log_data(struct line_log_data *r)
@@ -571,7 +573,8 @@ parse_lines(struct repository *r, struct commit *commit,
 	struct line_log_data *p;
 
 	for_each_string_list_item(item, args) {
-		const char *name_part, *range_part;
+		const char *name_part;
+		char *range_part;
 		char *full_name;
 		struct diff_filespec *spec;
 		long begin = 0, end = 0;
@@ -615,6 +618,7 @@ parse_lines(struct repository *r, struct commit *commit,
 
 		free_filespec(spec);
 		FREE_AND_NULL(ends);
+		free(range_part);
 	}
 
 	for (p = ranges; p; p = p->next)
@@ -760,15 +764,13 @@ static void parse_pathspec_from_ranges(struct pathspec *pathspec,
 {
 	struct line_log_data *r;
 	struct strvec array = STRVEC_INIT;
-	const char **paths;
 
 	for (r = range; r; r = r->next)
 		strvec_push(&array, r->path);
-	paths = strvec_detach(&array);
 
-	parse_pathspec(pathspec, 0, PATHSPEC_PREFER_FULL, "", paths);
-	/* strings are now owned by pathspec */
-	free(paths);
+	parse_pathspec(pathspec, 0, PATHSPEC_PREFER_FULL, "", array.v);
+
+	strvec_clear(&array);
 }
 
 void line_log_init(struct rev_info *rev, const char *prefix, struct string_list *args)
@@ -781,6 +783,8 @@ void line_log_init(struct rev_info *rev, const char *prefix, struct string_list
 	add_line_range(rev, commit, range);
 
 	parse_pathspec_from_ranges(&rev->diffopt.pathspec, range);
+
+	free_line_log_data(range);
 }
 
 static void move_diff_queue(struct diff_queue_struct *dst,
@@ -1131,10 +1135,18 @@ static int process_all_files(struct line_log_data **range_out,
 			while (rg && strcmp(rg->path, pair->two->path))
 				rg = rg->next;
 			assert(rg);
+			if (rg->pair)
+				diff_free_filepair(rg->pair);
 			rg->pair = diff_filepair_dup(queue->queue[i]);
+			diff_ranges_release(&rg->diff);
 			memcpy(&rg->diff, pairdiff, sizeof(struct diff_ranges));
+			FREE_AND_NULL(pairdiff);
+		}
+
+		if (pairdiff) {
+			diff_ranges_release(pairdiff);
+			free(pairdiff);
 		}
-		free(pairdiff);
 	}
 
 	return changed;
@@ -1212,12 +1224,13 @@ static int process_ranges_merge_commit(struct rev_info *rev, struct commit *comm
 	struct commit_list *p;
 	int i;
 	int nparents = commit_list_count(commit->parents);
+	int ret;
 
 	if (nparents > 1 && rev->first_parent_only)
 		nparents = 1;
 
 	ALLOC_ARRAY(diffqueues, nparents);
-	ALLOC_ARRAY(cand, nparents);
+	CALLOC_ARRAY(cand, nparents);
 	ALLOC_ARRAY(parents, nparents);
 
 	p = commit->parents;
@@ -1229,7 +1242,6 @@ static int process_ranges_merge_commit(struct rev_info *rev, struct commit *comm
 
 	for (i = 0; i < nparents; i++) {
 		int changed;
-		cand[i] = NULL;
 		changed = process_all_files(&cand[i], rev, &diffqueues[i], range);
 		if (!changed) {
 			/*
@@ -1237,13 +1249,10 @@ static int process_ranges_merge_commit(struct rev_info *rev, struct commit *comm
 			 * don't follow any other path in history
 			 */
 			add_line_range(rev, parents[i], cand[i]);
-			clear_commit_line_range(rev, commit);
 			commit_list_append(parents[i], &commit->parents);
-			free(parents);
-			free(cand);
-			free_diffqueues(nparents, diffqueues);
-			/* NEEDSWORK leaking like a sieve */
-			return 0;
+
+			ret = 0;
+			goto out;
 		}
 	}
 
@@ -1251,18 +1260,25 @@ static int process_ranges_merge_commit(struct rev_info *rev, struct commit *comm
 	 * No single parent took the blame.  We add the candidates
 	 * from the above loop to the parents.
 	 */
-	for (i = 0; i < nparents; i++) {
+	for (i = 0; i < nparents; i++)
 		add_line_range(rev, parents[i], cand[i]);
-	}
 
+	ret = 1;
+
+out:
 	clear_commit_line_range(rev, commit);
 	free(parents);
+	for (i = 0; i < nparents; i++) {
+		if (!cand[i])
+			continue;
+		line_log_data_clear(cand[i]);
+		free(cand[i]);
+	}
 	free(cand);
 	free_diffqueues(nparents, diffqueues);
-	return 1;
+	return ret;
 
 	/* NEEDSWORK evil merge detection stuff */
-	/* NEEDSWORK leaking like a sieve */
 }
 
 int line_log_process_ranges_arbitrary_commit(struct rev_info *rev, struct commit *commit)
-- 
2.46.2.852.g229c0bf0e5.dirty

