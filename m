Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2DA1CB526
	for <git@vger.kernel.org>; Fri,  1 Nov 2024 20:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730491914; cv=none; b=nd6GkTZTwoxhfYNVKrttGrCyECAm86v8f8UcpQmOC8QnzPVLyTD25FDeX4Xa4n5UnoIvcaCCaoPljDDKfbNhkcCX7FhzxxwibNipOZMZhiDWWDS1UQlviWBPAKEnc98NG0G0Gf0gpDAQ0eedO+lkyPYxuX84CcthcGDY+NhTc4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730491914; c=relaxed/simple;
	bh=VmeFUTld8eaUpiGAsQPH+5ywBaMrn5V1Bj3JHMawqo4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=u8XhbnDRToHkqSBXRlz2ybNkE/8626HBy5PdICjQR3Hr2tMX3U4JaWae6nR+BRnqGE9koeKzQW6dYaqvmnIXY0QdxxjmoB1Mg2hyfIUGNcq2ylIlZU4kAi7U8Jt/Wys5Wu4o1E8UMKyhVg9Bc9dOUy9DtFiA3GhwBtbhc8ZxxbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HdhP16CC; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HdhP16CC"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6ea33140094so54388137b3.1
        for <git@vger.kernel.org>; Fri, 01 Nov 2024 13:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730491912; x=1731096712; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MzMy2E+1gXc8ySwRJrMd/I5900UV0XP9AD2+9ASuuds=;
        b=HdhP16CCBViPZa/s8UCYfyTt0xEvykXcPaCssv3ggmZdiiDRPMUt5bnmEm/4fBquOZ
         ObnVXSQLT2Y6EM10DgOzTUU0Uu7SD1644y5XQqg+M3bRE3OpEn6lEmFmLepYHnPJqbwJ
         ETW2HzMqXuHx0c4L/wwyLR81cj7Mc1Qe3otr3Gg3Yn00CHzen2Y3voO12+yzNJOWCCy/
         zsEwYYXglaGi1lzEL0WofgD45Z8Wi58gGMsI4l/7czwE8eyo6qYaaBzG1T4Ua1SnjK5u
         N2pAyVo1aNIv9Ojohf1InSHi7210jI70tO0Nj0FMEsSZLE3ZsrlwgrVManlSjSPSZznX
         G0Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730491912; x=1731096712;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MzMy2E+1gXc8ySwRJrMd/I5900UV0XP9AD2+9ASuuds=;
        b=O7n/okUktrkT9hz2umb3by69Pluo994NfLb0wTtXusNWGq+7HuffbAv69C0VzG+LGy
         u+V8LttcvXlTLv94gyGdqajAWnn0PZ9rBhYGGyhOh6CDUbj2z8Ddv1Jng1rN2J1CKcUB
         JlEIfbmezXgua88/ksQ3VaJzWbzvE/SA9u6VqBcF+q8uZB8aHqb4+GFLT7PhkgfZndfh
         2gYmuxMQyMXuZdBORwwgp81UEUbSw2KY6VUsb3viLezO01qoH95QItOz/jiPisnMtxS9
         LSZtQt4z991V4FtI4DeGj/NEYt0fOsvAYi9HLb20XMTM15a9uHRZKq682nm8Bk/vc5qa
         sO+w==
X-Gm-Message-State: AOJu0Yw2wEuR79EU4iqBuM2dANjIqRSG/Sjf6F974ictUtEc3B/XadIi
	U2aYsicbyZqn4iOZ0kp14n5lWiE7xBt/ZSyTi5KlDLpHk5fF37jpPsiWc2skGszrVv239ItYOHa
	NoWZml24SK7Gsj6LZf3UTq/X5rVX6tFQ5VBJIV162MuBi9e3cgpBRm6np55bpZyZLF4I84dlBnx
	rU26IC8+hMgbhUpftm5aZISnWN7gTtHM81Qwy+0eq/D9D77/9Bmr9bIWqs7LwcFO+BEg==
X-Google-Smtp-Source: AGHT+IFbOgbMHmOyLgrXRINI0U7gZcQeY9JIAk3veRXckI3KpYFrX7MiD6jIycz4vVp5xTA0JvpR7p6XmjX8PcG6G7cE
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:87c0:a56e:d0ff:807f])
 (user=jonathantanmy job=sendgmr) by 2002:a25:e446:0:b0:e28:eee0:aaa1 with
 SMTP id 3f1490d57ef6-e30e5a62084mr4325276.4.1730491911858; Fri, 01 Nov 2024
 13:11:51 -0700 (PDT)
Date: Fri,  1 Nov 2024 13:11:44 -0700
In-Reply-To: <cover.1729792911.git.jonathantanmy@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1729792911.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <cover.1730491845.git.jonathantanmy@google.com>
Subject: [PATCH v2 0/4] When fetching from a promisor remote, repack local
 objects referenced
From: Jonathan Tan <jonathantanmy@google.com>
To: git@vger.kernel.org
Cc: Jonathan Tan <jonathantanmy@google.com>, steadmon@google.com, 
	hanyang.tony@bytedance.com, me@ttaylorr.com
Content-Type: text/plain; charset="UTF-8"

Thanks everyone for looking at it. Here's version 2.

Jonathan Tan (4):
  t0410: make test description clearer
  t0410: use from-scratch server
  t5300: move --window clamp test next to unclamped
  index-pack: repack local links into promisor packs

 Documentation/git-index-pack.txt |   5 ++
 builtin/index-pack.c             | 110 ++++++++++++++++++++++++++++++-
 builtin/pack-objects.c           |  28 ++++++++
 t/t0410-partial-clone.sh         |   6 +-
 t/t5300-pack-object.sh           |  10 +--
 t/t5616-partial-clone.sh         |  30 +++++++++
 6 files changed, 179 insertions(+), 10 deletions(-)

Range-diff against v1:
1:  b2c76c207d < -:  ---------- pack-objects: make variable non-static
2:  c220e77ccf = 1:  f405c9c9aa t0410: make test description clearer
3:  08750988e0 = 2:  ce9d5af42a t0410: use from-scratch server
4:  85fc3fa77e = 3:  1526a59e2d t5300: move --window clamp test next to unclamped
5:  5dd7fdc16d ! 4:  c51fac33fb index-pack: repack local links into promisor packs
    @@ builtin/index-pack.c: int cmd_index_pack(int argc,
      	 */
     
      ## builtin/pack-objects.c ##
    +@@ builtin/pack-objects.c: static enum {
    + static uint16_t write_bitmap_options = BITMAP_OPT_HASH_CACHE;
    + 
    + static int exclude_promisor_objects;
    ++static int exclude_promisor_objects_best_effort;
    + 
    + static int use_delta_islands;
    + 
     @@ builtin/pack-objects.c: static int option_parse_cruft_expiration(const struct option *opt UNUSED,
      	return 0;
      }
      
    -+static int should_include_obj(struct object *obj, void *data UNUSED)
    ++static int is_not_in_promisor_pack_obj(struct object *obj, void *data UNUSED)
     +{
     +	struct object_info info = OBJECT_INFO_INIT;
     +	if (oid_object_info_extended(the_repository, &obj->oid, &info, 0))
    @@ builtin/pack-objects.c: static int option_parse_cruft_expiration(const struct op
     +	return info.whence != OI_PACKED || !info.u.packed.pack->pack_promisor;
     +}
     +
    -+static int should_include(struct commit *commit, void *data) {
    -+	return should_include_obj((struct object *) commit, data);
    ++static int is_not_in_promisor_pack(struct commit *commit, void *data) {
    ++	return is_not_in_promisor_pack_obj((struct object *) commit, data);
     +}
     +
      int cmd_pack_objects(int argc,
      		     const char **argv,
      		     const char *prefix,
    -@@ builtin/pack-objects.c: int cmd_pack_objects(int argc,
    - 	struct list_objects_filter_options filter_options =
    - 		LIST_OBJECTS_FILTER_INIT;
    - 	int exclude_promisor_objects = 0;
    -+	int exclude_promisor_objects_best_effort = 0;
    - 
    - 	struct option pack_objects_options[] = {
    - 		OPT_CALLBACK_F('q', "quiet", &progress, NULL,
     @@ builtin/pack-objects.c: int cmd_pack_objects(int argc,
      		  option_parse_missing_action),
      		OPT_BOOL(0, "exclude-promisor-objects", &exclude_promisor_objects,
    @@ builtin/pack-objects.c: int cmd_pack_objects(int argc,
      		repo_init_revisions(the_repository, &revs, NULL);
      		list_objects_filter_copy(&revs.filter, &filter_options);
     +		if (exclude_promisor_objects_best_effort) {
    -+			revs.include_check = should_include;
    -+			revs.include_check_obj = should_include_obj;
    ++			revs.include_check = is_not_in_promisor_pack;
    ++			revs.include_check_obj = is_not_in_promisor_pack_obj;
     +		}
      		get_object_list(&revs, rp.nr, rp.v);
      		release_revisions(&revs);
-- 
2.47.0.163.g1226f6d8fa-goog

