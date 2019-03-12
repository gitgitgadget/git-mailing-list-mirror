Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2DB2F20248
	for <e@80x24.org>; Tue, 12 Mar 2019 17:45:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728194AbfCLRpe (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Mar 2019 13:45:34 -0400
Received: from mail-vk1-f201.google.com ([209.85.221.201]:42076 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbfCLRpd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Mar 2019 13:45:33 -0400
Received: by mail-vk1-f201.google.com with SMTP id q135so1182504vke.9
        for <git@vger.kernel.org>; Tue, 12 Mar 2019 10:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=NqkZNPS/3R9sSy2vIWQIzaePMtKXNrjRpo//AIP0u50=;
        b=LQjk1BugzxoYa7x+6JSf6n0q9PKmGZyzA7u+VzA5OX2vpDbfg0KplXAqIoZW+UjSNj
         0BoVsYQimPNwSouYAwdCcsnz5JBO7Nh6uIryoWyztaqmoIsBHawc0oSVhAoMSRn7pnu2
         PLLJe4KgHC4bt+VGCzxf7KHdGZpQyg7h6tBIgAmJKT5qCjOzfZZMumF76qjjlbJ936ca
         30vo5SljVPiTgufOfmCCclclcQxBKwDIrnouYKqN95PEdH2gdQKspumCKfGz9DAFu31d
         6zalgqOPXcmPjQTGRzFCcnYR0MOCgcaiv/3i/weLEpMBwm6j8Hq9B/gRt10t+H2jk82i
         tydQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=NqkZNPS/3R9sSy2vIWQIzaePMtKXNrjRpo//AIP0u50=;
        b=HZTqSCh/YhVN6pVfbtTDnwef6rbnghRQDc4Pk15xJGFjDcKE0cHpwjtqdLOIpAoWlp
         MWQY9WwIRn4NoWhJ5SYmFoj50B/aAEtnhcs6YMc3Q9PEgCV0CmMp4b+3Ud6hMY75kOEq
         zViByvHv2QP0XWmHlU5qPM7LiU0H70Z3S4AHTAP698desNWFFgM6zKI728IlcicwGllY
         LR7hf3VhJTjzynhPMFQoOzojWO29IfURYXqyTw0GqUued31mzyRid3EcUB5UphL2ImqD
         Hg/LcUvoydMlbpz8rwHfLISMfgY4+koTIDymeZ2iPPKPYsnisodXLXhqPAp3Dr6nUl7W
         IP5w==
X-Gm-Message-State: APjAAAX7fNQghTNQt+oZdTLXpsYbRP3CGyI79aY3iLG9f89zvKWRHwJV
        /+J/azMKFoFL8bT80NntTQm7C3ZrDtZpu6WpT2X2QIFlxwlG8jx8aW15sU/SA0kHJNIrLwWudy+
        BOSrUfnsqK4uJndE6+47rz2WBuxPVZ47EfrU5dSbVuqaW2zsfeVldDY7aZ6fYmmXD56EWMJHZKX
        C/
X-Google-Smtp-Source: APXvYqz1T3ef5QSnDTGeVw7jNw2EcXe7ZDedVfQliQpAqaVrj7n7oD46XtVIvkGVlZPsb/y4ST2aXukCiy9A26zr6kvq
X-Received: by 2002:ab0:20d2:: with SMTP id z18mr4093942ual.24.1552412732393;
 Tue, 12 Mar 2019 10:45:32 -0700 (PDT)
Date:   Tue, 12 Mar 2019 10:45:22 -0700
Message-Id: <20190312174522.89306-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.155.ge902e9bcae.dirty
Subject: [PATCH] submodule: explain first attempt failure clearly
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When cloning with --recurse-submodules a superproject with at least one
submodule with HEAD pointing to an unborn branch, the clone goes
something like this:

	Cloning into 'test'...
	<messages about cloning of superproject>
	Submodule '<name>' (<uri>) registered for path '<submodule path>'
	Cloning into '<submodule path>'...
	fatal: Couldn't find remote ref HEAD
	Unable to fetch in submodule path '<submodule path>'
	<messages about fetching with SHA-1>
	From <uri>
	 * branch            <hash> -> FETCH_HEAD
	Submodule path '<submodule path>': checked out '<hash>'

In other words, first, a fetch is done with no hash arguments (that is,
a fetch of HEAD) resulting in a "Couldn't find remote ref HEAD" error;
then, a fetch is done given a hash, which succeeds.

The fetch given a hash was added in fb43e31f2b ("submodule: try harder
to fetch needed sha1 by direct fetching sha1", 2016-02-24), and the
"Unable to fetch..." message was downgraded from a fatal error to a
notice in e30d833671 ("git-submodule.sh: try harder to fetch a
submodule", 2018-05-16).

This commit improves the notice to be clearer that we are retrying the
fetch, and that the previous messages do not necessarily indicate that
the whole command fails. In other words:

 - If the HEAD-fetch succeeds and we then have the commit we want, no
   extra messages are printed.
 - If the HEAD-fetch succeeds and we do not have the commit we want, but
   the hash-fetch succeeds, no additional messages are printed.
 - If the HEAD-fetch succeeds and we do not have the commit we want, but
   the hash-fetch fails, this is a fatal error.
 - If the HEAD-fetch fails, we print the notice, and if the hash-fetch
   succeeds, no additional messages are printed.
 - If the HEAD-fetch fails, we print the notice, and if the hash-fetch
   fails, this is a fatal error.

It could be said that we should just eliminate the HEAD-fetch
altogether, but that changes some behavior (in particular, some refs
that were opportunistically updated would no longer be), so I have left
that alone for now.

There is an analogous situation with the fetching code in fetch_finish()
and surrounding functions. For now, I have added a NEEDSWORK.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 git-submodule.sh | 2 +-
 submodule.c      | 7 +++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 514ede2596..2c0fb6d723 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -594,7 +594,7 @@ cmd_update()
 				# is not reachable from a ref.
 				is_tip_reachable "$sm_path" "$sha1" ||
 				fetch_in_submodule "$sm_path" $depth ||
-				say "$(eval_gettext "Unable to fetch in submodule path '\$displaypath'")"
+				say "$(eval_gettext "Unable to fetch in submodule path '\$displaypath'; trying to directly fetch \$sha1:")"
 
 				# Now we tried the usual fetch, but $sha1 may
 				# not be reachable from any of the refs
diff --git a/submodule.c b/submodule.c
index 21cf50ca15..b16c0ecc95 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1548,6 +1548,13 @@ static int fetch_finish(int retvalue, struct strbuf *err,
 	struct oid_array *commits;
 
 	if (retvalue)
+		/*
+		 * NEEDSWORK: This indicates that the overall fetch
+		 * failed, even though there may be a subsequent fetch
+		 * by commit hash that might work. It may be a good
+		 * idea to not indicate failure in this case, and only
+		 * indicate failure if the subsequent fetch fails.
+		 */
 		spf->result = 1;
 
 	if (!task || !task->sub)
-- 
2.21.0.155.ge902e9bcae.dirty

