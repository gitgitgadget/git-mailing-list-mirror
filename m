Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 579001F463
	for <e@80x24.org>; Sat, 21 Sep 2019 10:01:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405581AbfIUJ52 (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Sep 2019 05:57:28 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34992 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405440AbfIUJ51 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Sep 2019 05:57:27 -0400
Received: by mail-wr1-f68.google.com with SMTP id v8so9129757wrt.2
        for <git@vger.kernel.org>; Sat, 21 Sep 2019 02:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=iP+cXBFuM+Am+vmhZkdAeyIJBwFyODXjdVkvhdm07cI=;
        b=c+l+GLrOIATeZ68GyNZoK0yCW3NUL6VX4VPnC9MPUeaSwyW/0OzFaF/7aymduZzv1w
         EnX8QxvNdDLY4WZbRxjOdfi5g3RKPM5Py+E3dyQGJ2aEM7s8wbpf3RjgbMmIMplvsmt4
         PQFCOPYOh5IZH1JIs2tcCzgvmdHi9a6BMMAOO4B6O/z1fPJYcHh0v+YVjVDyv97Q8rdC
         0pVZUxOgTgkBDkpy4bO5jqHIHRJpsxw6O7s6CUdsNFT9hXuKOilEwE7Lp2HA7ubKTsQ4
         APZQsCLBwMYdZODhDrYQNr6C7LorCdiPFNTN7GM3nVxnay6h3WZ11Cpoxjk95+z7EBes
         lOtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=iP+cXBFuM+Am+vmhZkdAeyIJBwFyODXjdVkvhdm07cI=;
        b=n/4oMapC/ftAgfMLhXA2Q0L7YYZBjsBhkqNdubVsqbzvG05xohBSbgoiR6XnCqzyh8
         /ELG/PW70o7Bpw5xvedVhUDSXwoafHiYXbvlkz6bfQBBN+qfu+GzCKVSqiybOwOxALrQ
         JoREO392gyrre9VPxuV0rcyVwbVrhHcmHb2IwUpHonyJbxiZ4SfLcdEBkprLvkKoTQ9U
         dv1JsKGJ3ltfClfqSDR4Mzkz7dAtDpvO0Tur/T973oQjPqqmfflz+inO43Uc8ouBUSya
         Y/9JnryPyBBqiHG2TZS/SkXTPMu7fElrqgZb8dSrACAAO0p4/rpu3SswsQ8D4/aUDRux
         jdYA==
X-Gm-Message-State: APjAAAVfY7p6hevjGU2RYLIHytV+sr2iXNhop9P9m6Sw2Q3eLHJs0QDm
        oy2BbqCj7f8MPGwEaLphzSw=
X-Google-Smtp-Source: APXvYqyfTL7lM0NOE48NOU04tOs121SCbQ8IB3ko2yZIvY/yq3Y4/Lfmhbky7gl1CpXF1/BDTYWOmg==
X-Received: by 2002:a5d:4b46:: with SMTP id w6mr14587950wrs.223.1569059844947;
        Sat, 21 Sep 2019 02:57:24 -0700 (PDT)
Received: from szeder.dev (x4db43ca8.dyn.telefonica.de. [77.180.60.168])
        by smtp.gmail.com with ESMTPSA id x2sm5896901wrn.81.2019.09.21.02.57.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Sep 2019 02:57:24 -0700 (PDT)
Date:   Sat, 21 Sep 2019 11:57:18 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 08/15] name-rev: pull out deref handling from the
 recursion
Message-ID: <20190921095718.GA23203@szeder.dev>
References: <20190919214712.7348-1-szeder.dev@gmail.com>
 <20190919214712.7348-9-szeder.dev@gmail.com>
 <5bf3b958-8c95-ae3d-1ae5-df3d57272d8c@web.de>
 <20190920181302.GA26402@szeder.dev>
 <20190920181407.GB26402@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190920181407.GB26402@szeder.dev>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 20, 2019 at 08:14:07PM +0200, SZEDER Gábor wrote:
> On Fri, Sep 20, 2019 at 08:13:02PM +0200, SZEDER Gábor wrote:
> > > If the (re)introduced leak doesn't impact performance and memory
> > > usage too much then duplicating tip_name again in name_rev() or
> > > rather your new create_or_update_name() would likely make the
> > > lifetimes of those string buffers easier to manage.
> > 
> > Yeah, the easiest would be when each 'struct rev_name' in the commit
> > slab would have its own 'tip_name' string, but that would result in
> > a lot of duplicated strings and increased memory usage.
> 
> I didn't measure how much more memory would be used, though.

So, I tried the patch below to give each 'struct rev_name' instance
its own copy of 'tip_name', and the memory usage of 'git name-rev
--all' usually increased.

The increase depends on how many merges and how many refs there are
compared to the number of commits: the fewer merges and refs, the
higher the more the memory usage increased:

  linux:         +4.8%
  gcc:           +7.2% 
  gecko-dev:     +9.2%
  webkit:       +12.4%
  llvm-project: +19.0%

git.git is the exception with its unusually high number of merge
commits (about 25%), and the memory usage decresed by 4.4%.


 --- >8 ---

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 6969af76c4..62ab78242b 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -88,6 +88,7 @@ static struct rev_name *create_or_update_name(struct commit *commit,
 		set_commit_rev_name(commit, name);
 		goto copy_data;
 	} else if (is_better_name(name, taggerdate, distance, from_tag)) {
+		free((char*) name->tip_name);
 copy_data:
 		name->tip_name = tip_name;
 		name->taggerdate = taggerdate;
@@ -106,21 +107,19 @@ static void name_rev(struct commit *start_commit,
 {
 	struct commit_list *list = NULL;
 	const char *tip_name;
-	char *to_free = NULL;
 
 	parse_commit(start_commit);
 	if (start_commit->date < cutoff)
 		return;
 
 	if (deref) {
-		tip_name = to_free = xstrfmt("%s^0", start_tip_name);
-		free((char*) start_tip_name);
+		tip_name = xstrfmt("%s^0", start_tip_name);
 	} else
-		tip_name = start_tip_name;
+		tip_name = strdup(start_tip_name);
 
 	if (!create_or_update_name(start_commit, tip_name, taggerdate, 0, 0,
 				   from_tag)) {
-		free(to_free);
+		free((char*) tip_name);
 		return;
 	}
 
@@ -139,7 +138,6 @@ static void name_rev(struct commit *start_commit,
 			struct commit *parent = parents->item;
 			const char *new_name;
 			int generation, distance;
-			const char *new_name_to_free = NULL;
 
 			parse_commit(parent);
 			if (parent->date < cutoff)
@@ -159,11 +157,10 @@ static void name_rev(struct commit *start_commit,
 					new_name = xstrfmt("%.*s^%d", (int)len,
 							   name->tip_name,
 							   parent_number);
-				new_name_to_free = new_name;
 				generation = 0;
 				distance = name->distance + MERGE_TRAVERSAL_WEIGHT;
 			} else {
-				new_name = name->tip_name;
+				new_name = strdup(name->tip_name);
 				generation = name->generation + 1;
 				distance = name->distance + 1;
 			}
@@ -174,7 +171,7 @@ static void name_rev(struct commit *start_commit,
 				last_new_parent = commit_list_append(parent,
 						  last_new_parent);
 			else
-				free((char*) new_name_to_free);
+				free((char*) new_name);
 		}
 
 		*last_new_parent = list;
@@ -313,7 +310,7 @@ static int name_ref(const char *path, const struct object_id *oid, int flags, vo
 		if (taggerdate == TIME_MAX)
 			taggerdate = commit->date;
 		path = name_ref_abbrev(path, can_abbreviate_output);
-		name_rev(commit, xstrdup(path), taggerdate, from_tag, deref);
+		name_rev(commit, path, taggerdate, from_tag, deref);
 	}
 	return 0;
 }
-- 
2.23.0.331.g4e51dcdf11

