Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B633A22D7B0
	for <git@vger.kernel.org>; Mon,  5 Jan 2026 19:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767642848; cv=none; b=NlSP3OxUi7LyBp82MzpHXUTo5a6sYhlVc5A0s7qatfyLus2W2CCpv1N50Tgtkqp/SVBNDajB9SIhWcly7Ob8hluQuLddxCPi/FULD4RVj2PfSyoZrVAAGp+HD5eqJGMo1ah4C7o+ARFQuzMyISzVQrDJ7+PDuLRFvivYxpyUZG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767642848; c=relaxed/simple;
	bh=qwEo/deN6oHmX//QPo8cYTkrChLUc2IKYqRtCGnLPSk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m6yRp91TpyXSpaLsokMyuCOOanNEdpmVfmQA/JKFncVZk0oduWe/IJZE9VUN9oIpCsvVSHGufhXisxlBCp1ebvOpEitUUtdmyEwDKNlwqebn/SK+Nv/8kCREFWu1NMKXoAYqpnoQL17C90DECp3SRKAlZ9DNMpcinwZDlMlkyQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=s0/Al932; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RJNDJ5nx; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="s0/Al932";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RJNDJ5nx"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id D7F301D00108;
	Mon,  5 Jan 2026 14:54:05 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 05 Jan 2026 14:54:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1767642845;
	 x=1767729245; bh=jrJslHybgvSncx5GaCI7v+pm1qcgh4C1b1Zaf8cL3UY=; b=
	s0/Al932h7k/qgqOdn5909Op3iMCRNaK+d73SHfg3Fs29oa2dWs6eEMYcZewp8J3
	Jc+eHIzcr6MW+VwPgBQOXLbM47BAZJVc/BBKOD0qpkgak3XmJe5JqlsNA8/WDjTr
	t0XxLzyWbbzhwsqGG84Mj4Bqc87U8e35CPhCUS5MpbBtJK0dLPfhjBxwmVTStt6K
	89pRHYdOGsLl+ZhXsEDgF22NQjFiIYtenGsc2yAJJJdZdufv53EjNQf5NmElWhvT
	o3ZRpC7c9TMUlyZfUVgmcV1afmpfzWTEEeHTM+Tkz05wkxLqlUO4GbXLo4srPySI
	AVkvO6gLZQYA9rHLCQNy+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767642845; x=
	1767729245; bh=jrJslHybgvSncx5GaCI7v+pm1qcgh4C1b1Zaf8cL3UY=; b=R
	JNDJ5nxV5/U1dhzg5CKIbRdkXHu9QM9x+MAwY2lJ2AN77sfmNOoQopuopMCtF5Sb
	Bg3xEU3z8v9ScDTQuT9obH1nHe96xh10AFAKRwzV9cGHRFxXZ0rv9fGWYof7pA7U
	0V9ulSgawdfOdqWTrLdY784G7mFeUiWJQwmIkk3oC1N7JfwUK2swCm5l95UNaUWt
	v7NmqeAVSPu0lf7VdysXlhMPHZ6sRSfFCg8EhmRnXn86qzhdGB93P0FofE/miXyd
	Z+jXYkfks6LIEn2O/ZjPnOxV4+GLDZsw8muF/QwEQXG2k5xOFLvhLF00Yufk8fwZ
	WJ2w3IYc2KuJeDqPWNM/Q==
X-ME-Sender: <xms:3RZcaciMdoIZ2_CJPWjxBPkezPlnZO_bryz1HWMGAH2hVyBk5Au7bL8>
    <xme:3RZcaeUQQytM4BcfraLiwFiFMBnePvj-xoGojqvcOyAXEi-zou-8TjpTx_PvhKouq
    uMV-YTBch4O7vt77a6u6GMZ4u5E2-MTUIKesgoV7ChlK2w6n2dDaA>
X-ME-Received: <xmr:3RZcabW-TTxe-_6OdwgmcpOojK_kb46ZJphHhYrlqt2K-hRBNCrRkDJDKY-HK4RRzRPKMBIL2GXZb91SJHe6crZpnwB3uOZmg_AWh3Lo-Szadf7m4Ek_y2Yx7w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdelkedulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfghrlh
    cuvffnffculddvfedmnecujfgurhephffvvefufffkofgjfhggtgfgsehtkeertdertdej
    necuhfhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilh
    drtghomhenucggtffrrghtthgvrhhnpedulefgueeiueetkeelieefgedufeehteekhfej
    ffekvdeuhedtvefhkeeikefhgfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthho
    fhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtth
    hopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtoheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmh
    gvpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhiug
    guhhgrrhhthhgrshhthhgrnhgrfedusehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhh
    ihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhk
X-ME-Proxy: <xmx:3RZcaejvfNoiv6565fgILTPXeo-1btUAg1sXt1TPvs89KhplVUpBaA>
    <xmx:3RZcaWYMpa4a7TLd4c_5NcEMlOxeXZ8iu3BmFa5KN8x6GIGhf9IFTA>
    <xmx:3RZcabrvP4ZmCfshHwper5ItbUppWWK1FIb_ssodQiFF9qNwL5W21A>
    <xmx:3RZcaTMKVtEyBe6I5f_bhTX7rAfMJXwaEAHtK3x1qKfRgk_YuqLnEw>
    <xmx:3RZcafqPH9YuPSJUx5Qe5jppI6HLmWpkSt8BIS8YWEUH4JOfpiksPAPa>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Jan 2026 14:54:04 -0500 (EST)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	christian.couder@gmail.com,
	newren@gmail.com,
	Siddharth Asthana <siddharthasthana31@gmail.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v3 1/6] replay: remove dead code and rearrange
Date: Mon,  5 Jan 2026 20:53:17 +0100
Message-ID: <V3_dead_replay_code.1a5@msgid.xyz>
X-Mailer: git-send-email 2.52.0.383.gb1c58d6b301
In-Reply-To: <V3_CV_replay_die_descr.1a4@msgid.xyz>
References: <V2_CV_replay_die_descr.17b@msgid.xyz> <V3_CV_replay_die_descr.1a4@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

22d99f01 (replay: add --advance or 'cherry-pick' mode, 2023-11-24) both
added `--advance` and made one of `--onto` or `--advance` mandatory.
But `determine_replay_mode` claims that there is a third alternative;
neither of `--onto` or `--advance` were given:

    if (onto_name) {
    ...
    } else if (*advance_name) {
    ...
    } else {
    ...
    }

But this is false—the fallthrough else-block is dead code.

Commit 22d99f01 was iterated upon by several people.[1] The initial
author wrote code for a sort of *guess mode*, allowing for shorter
commands when that was possible. But the next person instead made one
of the aforementioned options mandatory. In turn this code was dead on
arrival in git.git.

[1]: https://lore.kernel.org/git/CABPp-BEcJqjD4ztsZo2FTZgWT5ZOADKYEyiZtda+d0mSd1quPQ@mail.gmail.com/

Let’s remove this code. We can also join the if-block with the
condition `!*advance_name` into the `*onto` block since we do not set
`*advance_name` in this function. It only looked like we might set it
since the dead code has this line:

    *advance_name = xstrdup_or_null(last_key);

Let’s also rename the function since we do not determine the
replay mode here. We just set up `*onto` and refs to update.

Note that there might be more dead code caused by this *guess mode*.
We only concern ourselves with this function for now.

Helped-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v3:
    
    Use more terse function rename.[1] Also tweak commit message based on
    this change.
    
    🔗 1: https://lore.kernel.org/git/CABPp-BEJV1XG62_hn_OiZ9q9S3jsyTP0VdOEzS4pME2rrkKFrg@mail.gmail.com/
    
    v2: [new]
    
    See the link in the commit message.
    
    Not strictly needed for this series but I think it makes sense to fix it
    here.

 builtin/replay.c | 70 +++++++++++-------------------------------------
 1 file changed, 16 insertions(+), 54 deletions(-)

diff --git a/builtin/replay.c b/builtin/replay.c
index 6172c8aacc9..6e0fedf1061 100644
--- a/builtin/replay.c
+++ b/builtin/replay.c
@@ -154,16 +154,16 @@ static void get_ref_information(struct repository *repo,
 
 		free(fullname);
 	}
 }
 
-static void determine_replay_mode(struct repository *repo,
-				  struct rev_cmdline_info *cmd_info,
-				  const char *onto_name,
-				  char **advance_name,
-				  struct commit **onto,
-				  struct strset **update_refs)
+static void set_up_replay_mode(struct repository *repo,
+			       struct rev_cmdline_info *cmd_info,
+			       const char *onto_name,
+			       char **advance_name,
+			       struct commit **onto,
+			       struct strset **update_refs)
 {
 	struct ref_info rinfo;
 
 	get_ref_information(repo, cmd_info, &rinfo);
 	if (!rinfo.positive_refexprs)
@@ -174,69 +174,30 @@ static void determine_replay_mode(struct repository *repo,
 	if (onto_name) {
 		*onto = peel_committish(repo, onto_name);
 		if (rinfo.positive_refexprs <
 		    strset_get_size(&rinfo.positive_refs))
 			die(_("all positive revisions given must be references"));
-	} else if (*advance_name) {
+		*update_refs = xcalloc(1, sizeof(**update_refs));
+		**update_refs = rinfo.positive_refs;
+		memset(&rinfo.positive_refs, 0, sizeof(**update_refs));
+	} else {
 		struct object_id oid;
 		char *fullname = NULL;
 
+		if (!*advance_name)
+			BUG("expected either onto_name or *advance_name in this function");
+
 		*onto = peel_committish(repo, *advance_name);
 		if (repo_dwim_ref(repo, *advance_name, strlen(*advance_name),
 			     &oid, &fullname, 0) == 1) {
 			free(*advance_name);
 			*advance_name = fullname;
 		} else {
 			die(_("argument to --advance must be a reference"));
 		}
 		if (rinfo.positive_refexprs > 1)
 			die(_("cannot advance target with multiple sources because ordering would be ill-defined"));
-	} else {
-		int positive_refs_complete = (
-			rinfo.positive_refexprs ==
-			strset_get_size(&rinfo.positive_refs));
-		int negative_refs_complete = (
-			rinfo.negative_refexprs ==
-			strset_get_size(&rinfo.negative_refs));
-		/*
-		 * We need either positive_refs_complete or
-		 * negative_refs_complete, but not both.
-		 */
-		if (rinfo.negative_refexprs > 0 &&
-		    positive_refs_complete == negative_refs_complete)
-			die(_("cannot implicitly determine whether this is an --advance or --onto operation"));
-		if (negative_refs_complete) {
-			struct hashmap_iter iter;
-			struct strmap_entry *entry;
-			const char *last_key = NULL;
-
-			if (rinfo.negative_refexprs == 0)
-				die(_("all positive revisions given must be references"));
-			else if (rinfo.negative_refexprs > 1)
-				die(_("cannot implicitly determine whether this is an --advance or --onto operation"));
-			else if (rinfo.positive_refexprs > 1)
-				die(_("cannot advance target with multiple source branches because ordering would be ill-defined"));
-
-			/* Only one entry, but we have to loop to get it */
-			strset_for_each_entry(&rinfo.negative_refs,
-					      &iter, entry) {
-				last_key = entry->key;
-			}
-
-			free(*advance_name);
-			*advance_name = xstrdup_or_null(last_key);
-		} else { /* positive_refs_complete */
-			if (rinfo.negative_refexprs > 1)
-				die(_("cannot implicitly determine correct base for --onto"));
-			if (rinfo.negative_refexprs == 1)
-				*onto = rinfo.onto;
-		}
-	}
-	if (!*advance_name) {
-		*update_refs = xcalloc(1, sizeof(**update_refs));
-		**update_refs = rinfo.positive_refs;
-		memset(&rinfo.positive_refs, 0, sizeof(**update_refs));
 	}
 	strset_clear(&rinfo.negative_refs);
 	strset_clear(&rinfo.positive_refs);
 }
 
@@ -384,12 +345,13 @@ int cmd_replay(int argc,
 			  "'%s' bit in 'struct rev_info' will be forced"),
 			"simplify_history");
 		revs.simplify_history = 0;
 	}
 
-	determine_replay_mode(repo, &revs.cmdline, onto_name, &advance_name,
-			      &onto, &update_refs);
+	set_up_replay_mode(repo, &revs.cmdline,
+			   onto_name, &advance_name,
+			   &onto, &update_refs);
 
 	if (!onto) /* FIXME: Should handle replaying down to root commit */
 		die("Replaying down to root commit is not supported yet!");
 
 	if (prepare_revision_walk(&revs) < 0) {
-- 
2.52.0.383.gb1c58d6b301

