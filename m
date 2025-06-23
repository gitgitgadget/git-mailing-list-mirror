Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E6222A7EF
	for <git@vger.kernel.org>; Mon, 23 Jun 2025 22:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750717945; cv=none; b=Rc6TsN9mxQqwAR3JYmY+TXYRNG901J39R3ApWTFy3WsMs1ABaGgWvW5GEPQl5KDwIZZQDjeqLwwlO9ImgU9VGMxbWts1Wg6lRvWWFZESbVl0EZ8jLJxQidnhzlwymXFazVUU2eE6UK0ZsZ33nbGUeiBxMZ9F3isENwKt9Y5dVFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750717945; c=relaxed/simple;
	bh=ecIqwgPvFPvYHWH9ZP7waW0NRVvwe/p7uuVzV9U8LVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GUT2XL5DXNRt1pR1hgOex534N3ztpGdTCi5HvnGADv3jh9ywqAU7fiTCgHkF8qeuillSPyF1UbDPfSK4jBwvPS+cEW9XRnf1LFQShMQ370da2elMq0DCm1aqRUBON1x/RboAL52r7IkJF7lK4A+dG7dHftEQEJBTXa7j6fSI0ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=G+np0umo; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="G+np0umo"
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e733e25bfc7so3998918276.3
        for <git@vger.kernel.org>; Mon, 23 Jun 2025 15:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1750717942; x=1751322742; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OAc3wM8anPh/309AZSuvVkMsZg3ObEwFY8TE/UIsXp8=;
        b=G+np0umomYFYuEU6Au2kZF7uxcYbJj1tIkErmf2j9/GNO5r5Z7QZ+matm11L9GyftY
         JzjzX2flmUkFx29eMRi3Xqn0toDeIS8oI7auMr2uQJScmc3RGpM0sPWblCVkSs//lVFz
         7fheYpc1f3BPh0XDmxzVwvq4nDFwGUq88u/ZVciyFcezTSrDSNnVSH7YFndzvCA9FwLm
         KDq/qOeQh9NqhxNk2WZXZDRbI78tCpoJRIMhKh5/jLopSaqApt+ieEA4efVTOdkZDjlw
         2CwARwlJxAVG9ACebqf+ErqOTY8ERhyLyajvs3C9SZI1m3OupAFQ6Hbd/GIKLifqdh++
         eeIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750717942; x=1751322742;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OAc3wM8anPh/309AZSuvVkMsZg3ObEwFY8TE/UIsXp8=;
        b=TZvmH6mW/+UOJB16fxJj5lWSR1nOXPOciBBa6PvfnB732SJL1Ret3fjN7NPJ4qoDhj
         syjuSUxwp1peCSJRBKFRmlgTdR7Vm5azAbBTU/sJ+BxxioRnqj/hqVuf8dbfrWA3C9nI
         svlOcotY+wrmDoIJ7gdb5V+TwDoml/s1CWm1wT7d2QdqZiehl44A87QLg0Fcb3NQsRqn
         F9zyix1DvnSRKJ2SrNvoBWLPHud4azVW0XmICeurOq8/SjbByQSVOZxQFD6eDCw9Uj6/
         k6it8qfdybPB8gdjjrxnV1o0PVRBQ5Z2P/Z4Lcga7kKrbheePru1P0iNrMSo0+gcQ9Ma
         Pv+A==
X-Gm-Message-State: AOJu0Yw6C5svbMxnYMhqrD7CaEX0nZGhhLHXK/JySgK9WxdKtc7mjMJX
	woCYu8p4ZNvMUaZLH518mYLgIlQqAgvSJ+f1/syRQcDSdn6Gi+XXdQBmNW8ytMHyYkkKGGNYlsp
	9g86q
X-Gm-Gg: ASbGncsjB+V2LVpP18QEqr8MO49SBUInslwki+S12/2lhU13F2LwwWcvri2U8aFcjtd
	dZizimKBixZr4JHb7xz07MZ/JPUsGGNqW1vHD6KmWWTkO0w7MTFhrHFJ2wo2W6R9te5Hq7/YFFJ
	sX6P0DiCE/2L3NoaBt8fMUWOkNhrr8vAQg9E85ZTYV2o7IzeuElCCDvpqgGtz1IvYhke3PHOWaK
	YLYbylsNWR3iGQcAJlYfUvDkjm3NCIRr/OWfVEjKG5EEIcugBRfI87LEtZqhwlnwmfLCqsdCR42
	jfwSFUJZ8QMH1nJYYoKS6nXsa9JQSdX+8cKUnUejOZ3ksBA1lUUFpvIr5Hb7nL+74W+PoSziVlV
	C9nmpauPpPrbG9Aevt64QX1hlbc5AOIcHhA==
X-Google-Smtp-Source: AGHT+IHZvVvsjP+wJfYWXZLNfUjhRqycrE3l3v67rXOmU/FEM6WNJvExkDxsv7km7wgFu9XG02535A==
X-Received: by 2002:a05:6902:688d:b0:e84:37e7:490a with SMTP id 3f1490d57ef6-e8437e749f9mr10522562276.33.1750717942467;
        Mon, 23 Jun 2025 15:32:22 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 3f1490d57ef6-e842ac8dc23sm2684885276.41.2025.06.23.15.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 15:32:22 -0700 (PDT)
Date: Mon, 23 Jun 2025 18:32:21 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v6 5/9] pack-objects: perform name-hash traversal for
 unpacked objects
Message-ID: <6b0149a32d300268d4ad870c7cb6597a95e0410b.1750717921.git.me@ttaylorr.com>
References: <cover.1744413969.git.me@ttaylorr.com>
 <cover.1750717921.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1750717921.git.me@ttaylorr.com>

With '--unpacked', pack-objects adds loose objects (which don't appear
in any of the excluded packs from '--stdin-packs') to the output pack
without considering them as reachability tips for the name-hash
traversal.

This was an oversight in the original implementation of '--stdin-packs',
since the code which enumerates and adds loose objects to the output
pack (`add_unreachable_loose_objects()`) did not have access to the
'rev_info' struct found in `read_packs_list_from_stdin()`.

Excluding unpacked objects from that traversal doesn't affect the
correctness of the resulting pack, but it does make it harder to
discover good deltas for loose objects.

Now that the 'rev_info' struct is declared outside of
`read_packs_list_from_stdin()`, we can pass it to
`add_objects_in_unpacked_packs()` and add any loose objects as tips to
the above-mentioned traversal, in theory producing slightly tighter
packs as a result.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/pack-objects.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 4258ac1792..3437dbd7f1 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3879,7 +3879,7 @@ static void read_packs_list_from_stdin(struct rev_info *revs)
 	string_list_clear(&exclude_packs, 0);
 }
 
-static void add_unreachable_loose_objects(void);
+static void add_unreachable_loose_objects(struct rev_info *revs);
 
 static void read_stdin_packs(int rev_list_unpacked)
 {
@@ -3906,7 +3906,7 @@ static void read_stdin_packs(int rev_list_unpacked)
 	ignore_packed_keep_in_core = 1;
 	read_packs_list_from_stdin(&revs);
 	if (rev_list_unpacked)
-		add_unreachable_loose_objects();
+		add_unreachable_loose_objects(&revs);
 
 	if (prepare_revision_walk(&revs))
 		die(_("revision walk setup failed"));
@@ -4025,7 +4025,7 @@ static void enumerate_cruft_objects(void)
 						_("Enumerating cruft objects"), 0);
 
 	add_objects_in_unpacked_packs();
-	add_unreachable_loose_objects();
+	add_unreachable_loose_objects(NULL);
 
 	stop_progress(&progress_state);
 }
@@ -4303,8 +4303,9 @@ static void add_objects_in_unpacked_packs(void)
 }
 
 static int add_loose_object(const struct object_id *oid, const char *path,
-			    void *data UNUSED)
+			    void *data)
 {
+	struct rev_info *revs = data;
 	enum object_type type = oid_object_info(the_repository, oid, NULL);
 
 	if (type < 0) {
@@ -4325,6 +4326,10 @@ static int add_loose_object(const struct object_id *oid, const char *path,
 	} else {
 		add_object_entry(oid, type, "", 0);
 	}
+
+	if (revs && type == OBJ_COMMIT)
+		add_pending_oid(revs, NULL, oid, 0);
+
 	return 0;
 }
 
@@ -4333,11 +4338,10 @@ static int add_loose_object(const struct object_id *oid, const char *path,
  * add_object_entry will weed out duplicates, so we just add every
  * loose object we find.
  */
-static void add_unreachable_loose_objects(void)
+static void add_unreachable_loose_objects(struct rev_info *revs)
 {
 	for_each_loose_file_in_objdir(repo_get_object_directory(the_repository),
-				      add_loose_object,
-				      NULL, NULL, NULL);
+				      add_loose_object, NULL, NULL, revs);
 }
 
 static int has_sha1_pack_kept_or_nonlocal(const struct object_id *oid)
@@ -4684,7 +4688,7 @@ static void get_object_list(struct rev_info *revs, int ac, const char **av)
 	if (keep_unreachable)
 		add_objects_in_unpacked_packs();
 	if (pack_loose_unreachable)
-		add_unreachable_loose_objects();
+		add_unreachable_loose_objects(NULL);
 	if (unpack_unreachable)
 		loosen_unused_packed_objects();
 
-- 
2.50.0.61.g1981e40f2d

