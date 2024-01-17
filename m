Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F442D517
	for <git@vger.kernel.org>; Wed, 17 Jan 2024 08:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705479260; cv=none; b=eOE0loSmFqypMR+RSzlPGpWsQmKbJWsne/DNm0bD7gHrA4OPp9uGbooOhouF3Ggr5lgjblWDuTb9/MrEAqwDl54NSEdE0/ERiCfeQc491ATcD8Sx5LKD4dljMeWIltgwGVlJKMPzX9GV0hpuBfAnB78oW78bTQnR/VNcIJVRALE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705479260; c=relaxed/simple;
	bh=PcKoL2aDnLbeXDne87yhyRey4WbL8nNJzOysrG9n5w4=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:Sender:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding; b=tQrwSeIIMKWlY/aLLtNSmeZVR8ZPeZ4KllIXWAm0dhEUxOEL0qRiZ80sjqIVJjaaf098aulRo5B93HzvxmdFOi0bSg3oHaciPxYaaOEE+mvYkVL0N17FJViVWIuXGk3OpfjhfYiWttT9209h1L43Gs62ZyQKmP4X7elBRDjkcjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kGkI/We2; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kGkI/We2"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-559b3ee02adso1683507a12.3
        for <git@vger.kernel.org>; Wed, 17 Jan 2024 00:14:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705479257; x=1706084057; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rIimWQvACma+my2nVnHH5WMYddN7CLQWyOnm1muLZF4=;
        b=kGkI/We2ipJxLaIErVSnHlISNCtpahndz2PmElOOQfoEeZJIL2nvOLctOXxAA+UYk7
         wT62oBgwz1J+YnYUIbnva/m7ROpvFM3ZPPAu77JqqBXXYLibYaZxyi1pJbSAhXs2XGt6
         dRUM38/idePbsVcKZCqJ8o5RHM6Uj2NCw7+vm4pXvkhy6g7jf9Cr0AvS+Amv3hKPHUOB
         pNlsyECkMrcXsk4TWz6S3wji/5ZV+/NoOjoChEl/4zS3fVh+VyqgmcohJevFQtyO5JVT
         Jp5FhQk5QRUUNB2u6Xl9t1Kf8YEHnCHoiLdCpobDNkIognyavEK2uLCPUrvIpEb+Xqhk
         Xv4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705479257; x=1706084057;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rIimWQvACma+my2nVnHH5WMYddN7CLQWyOnm1muLZF4=;
        b=t5rqWQ9BGjxagKM+chqSCrhn1WTMTrxoPYsao9p1OEu7GZBx3mN3ovIV5E9iw0Woc5
         taIqrFe91P3fg19/L+k8k9GaDhA2+2VKdVxJrgik0NmN2TjQr8oQozmht2mQWPCg03zN
         P9AIyTvwgsAqWb6ToMbRKQsaewob1N43pdvuDkiSegmFuwJYA6D2RL1FVNVV1RZ8zw5N
         ulX5fhYhC+iPMWm/ZvJmPMEV3MJQ/tmk+blFa1zv1kwUwkWSolsz24lp7dmOjgisFMOa
         UYfoANF2zwjXF+00zpTbW9VOcBLUrcPcgXVB5qPc1ZN2tnnuI+8zqq8h2/+19JtR3FNA
         Zflw==
X-Gm-Message-State: AOJu0Yx9oJMBVoXJYCrMMSk/mefOBu3NA/3FTFssYGYJn7iTDsXUej36
	ikbrk9pJHIwSz2dRo+e324s=
X-Google-Smtp-Source: AGHT+IG+23ZKdpn7JVJuf7+ZrGr8D8hKGZ81HTrfemSNJZp6RMOBqIWQniAcX2+YUzbCnATF+OZEwQ==
X-Received: by 2002:a05:6402:3095:b0:559:b72d:92ce with SMTP id de21-20020a056402309500b00559b72d92cemr655956edb.15.1705479257200;
        Wed, 17 Jan 2024 00:14:17 -0800 (PST)
Received: from Michaels-MBP.fritz.box (2001-4dd4-dfc5-0-e407-3f73-62bc-9c57.ipv6dyn.netcologne.de. [2001:4dd4:dfc5:0:e407:3f73:62bc:9c57])
        by smtp.gmail.com with ESMTPSA id 7-20020a0564021f4700b00557de30e1f1sm7671803edz.74.2024.01.17.00.14.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 17 Jan 2024 00:14:16 -0800 (PST)
Sender: Michael L <mial.lohmann@gmail.com>
From: Michael Lohmann <mi.al.lohmann@gmail.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org,
	mi.al.lohmann@gmail.com,
	newren@gmail.com,
	phillip.wood123@gmail.com,
	Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH v3 2/2] revision: Implement `git log --merge` also for rebase/cherry_pick/revert
Date: Wed, 17 Jan 2024 09:14:05 +0100
Message-Id: <20240117081405.14012-2-mi.al.lohmann@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20240117081405.14012-1-mi.al.lohmann@gmail.com>
References: <xmqqzfxa9usx.fsf@gitster.g>
 <20240117081405.14012-1-mi.al.lohmann@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Co-authored-by: Johannes Sixt <j6t@kdbg.org>
Signed-off-by: Michael Lohmann <mi.al.lohmann@gmail.com>
---

On 12. Jan 2024, at 21:18, Junio C Hamano <gitster@pobox.com> wrote:
> I like the way your other_merge_candidate() loops over an array of
> possible candidates, which makes it a lot easier to extend, though,
> admittedly the "die()" message needs auto-generating if we really
> wanted to make it maintenance free ;-)

I would certainly like that but I did not find an easy way of achieving
this in C. Help wanted.

Changes with respect to v2:
- use read_ref_full instead of refs_resolve_ref_unsafe
- check for symbolic ref
- extract "other_name" in this patch, instead of patch 1

 revision.c | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/revision.c b/revision.c
index aa4c4dc778..c778413c7d 100644
--- a/revision.c
+++ b/revision.c
@@ -1961,11 +1961,31 @@ static void add_pending_commit_list(struct rev_info *revs,
 	}
 }
 
+static const char *lookup_other_head(struct object_id *oid)
+{
+	int i;
+	static const char *const other_head[] = {
+		"MERGE_HEAD", "REBASE_HEAD", "CHERRY_PICK_HEAD", "REVERT_HEAD"
+	};
+
+	for (i = 0; i < ARRAY_SIZE(other_head); i++)
+		if (!read_ref_full(other_head[i],
+				RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
+				oid, NULL)) {
+			if (is_null_oid(oid))
+				die("%s is a symbolic ref???", other_head[i]);
+			return other_head[i];
+		}
+
+	die("--merge without MERGE_HEAD, REBASE_HEAD, CHERRY_PICK_HEAD or REVERT_HEAD?");
+}
+
 static void prepare_show_merge(struct rev_info *revs)
 {
 	struct commit_list *bases;
 	struct commit *head, *other;
 	struct object_id oid;
+	const char *other_name;
 	const char **prune = NULL;
 	int i, prune_num = 1; /* counting terminating NULL */
 	struct index_state *istate = revs->repo->index;
@@ -1973,15 +1993,10 @@ static void prepare_show_merge(struct rev_info *revs)
 	if (repo_get_oid(the_repository, "HEAD", &oid))
 		die("--merge without HEAD?");
 	head = lookup_commit_or_die(&oid, "HEAD");
-	if (read_ref_full("MERGE_HEAD",
-			RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
-			&oid, NULL))
-		die("--merge without MERGE_HEAD?");
-	if (is_null_oid(&oid))
-		die("MERGE_HEAD is a symbolic ref???");
-	other = lookup_commit_or_die(&oid, "MERGE_HEAD");
+	other_name = lookup_other_head(&oid);
+	other = lookup_commit_or_die(&oid, other_name);
 	add_pending_object(revs, &head->object, "HEAD");
-	add_pending_object(revs, &other->object, "MERGE_HEAD");
+	add_pending_object(revs, &other->object, other_name);
 	bases = repo_get_merge_bases(the_repository, head, other);
 	add_rev_cmdline_list(revs, bases, REV_CMD_MERGE_BASE, UNINTERESTING | BOTTOM);
 	add_pending_commit_list(revs, bases, UNINTERESTING | BOTTOM);
-- 
2.39.3 (Apple Git-145)

