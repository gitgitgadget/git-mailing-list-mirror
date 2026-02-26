Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB772DC79F
	for <git@vger.kernel.org>; Thu, 26 Feb 2026 14:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772116081; cv=none; b=JwTyMrzg05AnTNx1TfoYgiVAz/0BCgF4hkiDNHgx3K3Oi9ymr1vV65LEXQ429QMEnIsupAS8bFPzZcYZiMfpPLwwwTDABSKzGbZv2trZrCCPEC7qpOYRpkhJb8cZ0KndrulpJOmofZEEHkds53VGCcEfSc+pFCmL4Pf08NNqW64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772116081; c=relaxed/simple;
	bh=0I5tMg+JH6uxuvLr8uH9m5r2tYnpkN40Vl+o95gxdhk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pHt1M9CnIn8ADM2pTZk+KH06DVHCuhKbgH1n8RYuEuniT60nBAKRrLS+s+7i5M/sU0qObVHbj135u4NBf6b3yTI//u7Mcn31squvLTglyP9FnbzQLXHKR5i+TY43G+JO8pPIlz36+s/3hkBSeBVdinjJ6SpC9//2iCjb4eEexzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FUrHIJJ+; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FUrHIJJ+"
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-43984d7e49bso836657f8f.2
        for <git@vger.kernel.org>; Thu, 26 Feb 2026 06:27:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772116078; x=1772720878; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=oS3V5s2LCtOb5guzJE3xmyliECCYPRC7F7wplJ5oQkQ=;
        b=FUrHIJJ+wY+v165Ib8obT+gbqZMEE+pKsxpX8cMw3R3muPckObJaUIylhHLkNsNK5J
         /mQHl4u8Z/J2x4V3X6xXaY1aQoWY/bD42eX7gkw1A5wkKl3hin2NKLbxKZrOmSKlPcCg
         HXRdhUfJrUOPQvndlG2zCn2Mq1Onpd+/JJ5ebDi/VrBYAo+vYG7/Me4KEqIwLv2zxNbq
         va3cW6m9UQgw7bJrnmSvZRGArfZtb3/kB663ay8p8cslVLoANar/OV6hJOpayPGTeeKl
         Uz2sVIOMeDC1Y6aL9cH9SUkUYy68kuWuGc9+fdF1+cIxO7nAP2bVfM6w1UTJx1sA2y7F
         w91A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772116078; x=1772720878;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oS3V5s2LCtOb5guzJE3xmyliECCYPRC7F7wplJ5oQkQ=;
        b=fyS+KvJIbpGC6Txm+1obEMQEvNjxeS2bhRWg98ATcMnJaTJGRpL1g38T8VaoYSwpw1
         VjVZ8hC9O12+F3KqFTqKIa2hqxDHOCPS6wm8Ruh9LyKCnKrDwohQDAw+UCQaZviily8I
         Eke+pEArz2Z1KMiR2dchmyf9+QptZcIvwanin68F9V8IpzOhBA1qlp7DfrMZ4c/2HF9T
         3k2QuTHcCV8y9ByFW63ZIPinakL4ca/5fwzzwZt4XU4BQNKh0c5SKZd/0tHhHYwzAEk3
         s/tLTJdTbw+6F1y7RIrfqr9oi1zTYimijzJX2AIVaCJlQTBM1gw4vECohSTCIJQR7EvB
         LfLg==
X-Forwarded-Encrypted: i=1; AJvYcCXaTSug+1rmboq1dgxKjX26rCeBaYlBMjQr+LIKXEL6m95mCMfjFAnSgqR5Bk2T4B3VQx0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmnEzJz2B4F7vBNVv2KT6Dpa1qBOwj2BY2jIdsowv098vDHPpu
	uaR8mbpmTjCRYC0ofVgFCxVe6hrQcAhduRXrSa1VgCTxILfkJiD+fqfu
X-Gm-Gg: ATEYQzyBE3Y/YjkKv/kg/SeAHCLR0WVVjk6YrUYgkyqt18hWRBD4LDwRzQbBCzKjH5r
	G7xeHCfRJfuW902Md8mocUlvsmtXxO2RNQVYJ6/2I1Rv/LT/5GnnaWfTBb2S91E19pJVrEss706
	pm4sPYxFBJ1o9rxaWqJBht80L/dpN++mJGmGzOGdOCnSXY9k4VsISleowh6HvWn40jaG7MLeY/I
	0veb97COnB+X5SOyo2Y7Uj3YHgcnTAPuYvkIs912Ii9ZjCts2A1nfFHwcDgrIASE4H7+CZgdOg5
	A1fbVyvim2CkRQeiwt6d1D1fqrQaY/rKy1n5xfvv/fD/qiVk7MHatL+RkaJis+Lp/+XXacMyDKH
	4sRyVraXTAw15R7gwZuvhqBfsrKHoJKROfkPlciOznX1ZvBciULOO+6M8LjKOYefUZZ8qOYkf9j
	q4sTdhoTDgr5TKbPk2uTtPIhuaRZUrpxlzRN1CvqzsoqNecPS3SQfgeMxbfq0HNFR5F6oNKesKG
	ksUHkfGqPYzZLb5
X-Received: by 2002:a05:6000:1883:b0:439:8a14:ba2f with SMTP id ffacd0b85a97d-43997f3a510mr4819452f8f.48.1772116077981;
        Thu, 26 Feb 2026 06:27:57 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:1785:c801:9102:504:16e7:c44e? ([2a0a:ef40:1785:c801:9102:504:16e7:c44e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43990c388acsm12974923f8f.28.2026.02.26.06.27.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Feb 2026 06:27:57 -0800 (PST)
Message-ID: <c2048ddf-ced4-425d-af6e-14e9442e9d99@gmail.com>
Date: Thu, 26 Feb 2026 14:27:54 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 1/2] sequencer: extract revert message formatting into
 shared function
To: Siddharth Asthana <siddharthasthana31@gmail.com>, git@vger.kernel.org
Cc: christian.couder@gmail.com, ps@pks.im, newren@gmail.com,
 gitster@pobox.com, phillip.wood@dunelm.org.uk, karthik.188@gmail.com,
 johannes.schindelin@gmx.de, toon@iotcl.com
References: <20251202201611.22137-1-siddharthasthana31@gmail.com>
 <20260218234215.89326-1-siddharthasthana31@gmail.com>
 <20260218234215.89326-2-siddharthasthana31@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <20260218234215.89326-2-siddharthasthana31@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Siddharth

On 18/02/2026 23:42, Siddharth Asthana wrote:
> The logic for formatting revert commit messages (handling "Revert" and
> "Reapply" cases) is currently duplicated between sequencer.c and will be
> needed by builtin/replay.c.
> 
> Extract this logic into a new sequencer_format_revert_header() function
> that can be shared. The function handles both regular reverts ("Revert
> "<subject>"") and revert-of-revert cases ("Reapply "<subject>"").
> When an oid is provided, the function appends the full commit hash and
> period; otherwise the caller should append the commit reference.
> 
> Update do_pick_commit() to use the new helper, eliminating code
> duplication while preserving the special handling for commit_use_reference.

I agree with the other comments that this ends up being a bit awkward, I think
something like the diff below which moves all of the revert message formatting
into a helper function would be a better approach. Note that I've also added a
repository argument to refer_to_commit(). You might want to do that in a
separate commit, but I think it is worth doing if we're adding more callers.
I've also just used a bool for the use_commit_reference flag, if we want to add
more flags in the future we can convert it to an unsigned int when we do that.

Thanks

Phillip


---- 8< ----
diff --git a/sequencer.c b/sequencer.c
index a3eb39bb252..30f6da6f959 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2198,21 +2198,55 @@ static int should_edit(struct replay_opts *opts) {
  	return opts->edit;
  }
  
-static void refer_to_commit(struct replay_opts *opts,
-			    struct strbuf *msgbuf, struct commit *commit)
+static void refer_to_commit(struct repository*r, struct strbuf *msgbuf,
+		const struct commit *commit, bool use_commit_reference)
  {
-	if (opts->commit_use_reference) {
+	if (use_commit_reference) {
  		struct pretty_print_context ctx = {
  			.abbrev = DEFAULT_ABBREV,
  			.date_mode.type = DATE_SHORT,
  		};
-		repo_format_commit_message(the_repository, commit,
+		repo_format_commit_message(r, commit,
  					   "%h (%s, %ad)", msgbuf, &ctx);
  	} else {
  		strbuf_addstr(msgbuf, oid_to_hex(&commit->object.oid));
  	}
  }
  
+void sequencer_format_revert_message(struct repository *r, const char *subject,
+			const struct commit *commit, const struct commit *parent,
+			bool use_commit_reference, struct strbuf *message)
+{
+	const char *orig_subject;
+
+	if (use_commit_reference) {
+			strbuf_commented_addf(message, comment_line_str,
+				"*** SAY WHY WE ARE REVERTING ON THE TITLE LINE ***");
+		} else if (skip_prefix(subject, "Revert \"", &orig_subject) &&
+			   /*
+			    * We don't touch pre-existing repeated reverts, because
+			    * theoretically these can be nested arbitrarily deeply,
+			    * thus requiring excessive complexity to deal with.
+			    */
+			   !starts_with(orig_subject, "Revert \"")) {
+			strbuf_addstr(message, "Reapply \"");
+			strbuf_addstr(message, orig_subject);
+			strbuf_addstr(message, "\n");
+		} else {
+			strbuf_addstr(message, "Revert \"");
+			strbuf_addstr(message, subject);
+			strbuf_addstr(message, "\"\n");
+		}
+		strbuf_addstr(message, "\nThis reverts commit ");
+		refer_to_commit(r, message, commit, use_commit_reference);
+
+		if (commit->parents && commit->parents->next) {
+			strbuf_addstr(message, ", reversing\nchanges made to ");
+			refer_to_commit(r, message, parent, use_commit_reference);
+		}
+		strbuf_addstr(message, ".\n");
+}
+
  static const char *sequencer_reflog_action(struct replay_opts *opts)
  {
  	if (!opts->reflog_action) {
@@ -2356,38 +2390,13 @@ static int do_pick_commit(struct repository *r,
  	 */
  
  	if (command == TODO_REVERT) {
-		const char *orig_subject;
-
  		base = commit;
  		base_label = msg.label;
  		next = parent;
  		next_label = msg.parent_label;
-		if (opts->commit_use_reference) {
-			strbuf_commented_addf(&ctx->message, comment_line_str,
-				"*** SAY WHY WE ARE REVERTING ON THE TITLE LINE ***");
-		} else if (skip_prefix(msg.subject, "Revert \"", &orig_subject) &&
-			   /*
-			    * We don't touch pre-existing repeated reverts, because
-			    * theoretically these can be nested arbitrarily deeply,
-			    * thus requiring excessive complexity to deal with.
-			    */
-			   !starts_with(orig_subject, "Revert \"")) {
-			strbuf_addstr(&ctx->message, "Reapply \"");
-			strbuf_addstr(&ctx->message, orig_subject);
-			strbuf_addstr(&ctx->message, "\n");
-		} else {
-			strbuf_addstr(&ctx->message, "Revert \"");
-			strbuf_addstr(&ctx->message, msg.subject);
-			strbuf_addstr(&ctx->message, "\"\n");
-		}
-		strbuf_addstr(&ctx->message, "\nThis reverts commit ");
-		refer_to_commit(opts, &ctx->message, commit);
-
-		if (commit->parents && commit->parents->next) {
-			strbuf_addstr(&ctx->message, ", reversing\nchanges made to ");
-			refer_to_commit(opts, &ctx->message, parent);
-		}
-		strbuf_addstr(&ctx->message, ".\n");
+		sequencer_format_revert_message(r,msg.subject, commit, parent,
+						opts->commit_use_reference,
+						&ctx->message);
  	} else {
  		const char *p;
  
diff --git a/sequencer.h b/sequencer.h
index 719684c8a9f..a61ec6d81d4 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -271,4 +271,8 @@ int sequencer_determine_whence(struct repository *r, enum commit_whence *whence)
   */
  int sequencer_get_update_refs_state(const char *wt_dir, struct string_list *refs);
  
+void sequencer_format_revert_message(struct repository *r, const char *subject,
+				     const struct commit *commit, const struct commit *parent,
+				     bool use_commit_reference, struct strbuf *message);
+
  #endif /* SEQUENCER_H */

