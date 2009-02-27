From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH 0/3] git remote: set-head and new show output (UPDATED)
Date: Fri, 27 Feb 2009 14:10:03 -0500
Message-ID: <cover.1235759631.git.jaysoffian@gmail.com>
References: <cover.1235546707.git.jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jay Soffian <jaysoffian@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 27 20:11:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ld87f-0000L0-CM
	for gcvg-git-2@gmane.org; Fri, 27 Feb 2009 20:11:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756296AbZB0TKP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Feb 2009 14:10:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755804AbZB0TKN
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Feb 2009 14:10:13 -0500
Received: from qw-out-2122.google.com ([74.125.92.27]:43671 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754472AbZB0TKL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Feb 2009 14:10:11 -0500
Received: by qw-out-2122.google.com with SMTP id 5so2090607qwi.37
        for <git@vger.kernel.org>; Fri, 27 Feb 2009 11:10:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=Iq+p4O5UolnDhjdsduvhXhX8SKnUONEJ+pY2XO+P+fs=;
        b=IHxYIIbe4YoDjnzH8uh85KFEGn7Sm75VwTWlqWOeuO33UsRX2Ykmcfj1jEN29hoGPO
         1ZA1a3gOSQ8Wk+G+1ObTLbNFGtvUCSCjSftMKWloILV3F7KcTZczkZ4CXvY8NqDqKw9S
         +WpLofPkx2MEVsmhyJGoHW5QPLCPFt1gbSBQc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=HtndDAWhWiYinwA9xrbb6f63iROF8U5vPQXPXmc6gizJEgW+RS/zxmcINBRH+GSNGd
         aJ2XYXkqNAXrd+/jLdWf0aOr63qMoTCVFSqE3D2TbwATeVhGGsbbm9Pb18qcwG/gTIzC
         CMV2QwYPVaRbN9k7ZfAiuJLe6J9C1icLbSe0U=
Received: by 10.224.74.84 with SMTP id t20mr4609404qaj.332.1235761809625;
        Fri, 27 Feb 2009 11:10:09 -0800 (PST)
Received: from localhost (cpe-075-182-093-216.nc.res.rr.com [75.182.93.216])
        by mx.google.com with ESMTPS id 2sm536992qwi.58.2009.02.27.11.10.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 27 Feb 2009 11:10:08 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc1.309.g5f417
In-Reply-To: <20090227114308.GA20776@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111696>

Jeff, Junio,

I didn't want to resend the whole series (gmane 111394), so what I did was
create a new patch which comes after patch 7 in that series. Call it patch 7a.
The rest of that series is then identical (modulo line number offsets in
patches touching remote.c) except for patches 8 and 19. Patches 7a, and the
new 8 and 19 follow this email.

You should be able to do this:

$ git checkout js/remote-improvements
$ git format-patch master
$ git reset --hard $(git merge-base master HEAD)

Copy new "[PATCH 07a/21] remote: make copy_ref() perform a deep copy"
to 0007a-remote-make-copy_ref-perform-a-deep-copy.patch

Copy new "[PATCH 08/21] remote: let guess_remote_head() optionally return all matches"
to 0008-remote-let-guess_remote_head-optionally-return-al.patch

Copy new "[PATCH 19/21] remote: make guess_remote_head() use exact HEAD lookup if it is available"
to 0019-remote-make-guess_remote_head-use-exact-HEAD-look.patch

$ git am -3 *.patch

For those playing along at home, js/remote-improvements is currently
commits 661763a..5e4c90a.

Which should give you a new js/remote-improvements that looks like this:

  1  test scripts: refactor start_httpd helper
  2  add basic http clone/fetch tests
  3  refactor find_ref_by_name() to accept const list
  4  move duplicated get_local_heads() to remote.c
  5  move duplicated ref_newer() to remote.c
  6  move locate_head() to remote.c
  7  remote: simplify guess_remote_head()
  8  remote: make copy_ref() perform a deep copy
  9  remote: let guess_remote_head() optionally return all matches
 10  remote: make match_refs() copy src ref before assigning to peer_ref
 11  remote: make match_refs() not short-circuit
 12  string-list: new for_each_string_list() function
 13  builtin-remote: refactor duplicated cleanup code
 14  builtin-remote: remove unused code in get_ref_states
 15  builtin-remote: rename variables and eliminate redundant function call
 16  builtin-remote: make get_remote_ref_states() always populate states.tracked
 17  builtin-remote: fix two inconsistencies in the output of "show <remote>"
 18  builtin-remote: teach show to display remote HEAD
 19  builtin-remote: add set-head subcommand
 20  remote: make guess_remote_head() use exact HEAD lookup if it is available
 21  builtin-remote: new show output style
 22  builtin-remote: new show output style for push refspecs

Here's the new diff stat:

 Documentation/git-remote.txt           |   28 ++-
 Makefile                               |    1 +
 builtin-clone.c                        |   41 +---
 builtin-remote.c                       |  561 ++++++++++++++++++++++++++------
 builtin-send-pack.c                    |   79 +-----
 cache.h                                |    2 +-
 contrib/completion/git-completion.bash |    2 +-
 http-push.c                            |   72 +----
 refs.c                                 |    4 +-
 remote.c                               |  145 ++++++++-
 remote.h                               |   12 +
 string-list.c                          |   10 +
 string-list.h                          |    5 +
 t/lib-httpd.sh                         |    9 +-
 t/t5505-remote.sh                      |  114 +++++--
 t/t5540-http-push.sh                   |    9 +-
 t/t5550-http-fetch.sh                  |   57 ++++
 17 files changed, 821 insertions(+), 330 deletions(-)
 create mode 100755 t/t5550-http-fetch.sh

And here's the inter-diff:

diff --git a/remote.c b/remote.c
index 1c09cf0..9b8522d 100644
--- a/remote.c
+++ b/remote.c
@@ -779,10 +779,18 @@ struct ref *alloc_ref(const char *name)
 
 static struct ref *copy_ref(const struct ref *ref)
 {
-	struct ref *ret = xmalloc(sizeof(struct ref) + strlen(ref->name) + 1);
-	memcpy(ret, ref, sizeof(struct ref) + strlen(ref->name) + 1);
-	ret->next = NULL;
-	return ret;
+	struct ref *cpy;
+	size_t len;
+	if (!ref)
+		return NULL;
+	len = strlen(ref->name);
+	cpy = xmalloc(sizeof(struct ref) + len + 1);
+	memcpy(cpy, ref, sizeof(struct ref) + len + 1);
+	cpy->next = NULL;
+	cpy->symref = ref->symref ? xstrdup(ref->symref) : NULL;
+	cpy->remote_status = ref->remote_status ? xstrdup(ref->remote_status) : NULL;
+	cpy->peer_ref = copy_ref(ref->peer_ref);
+	return cpy;
 }
 
 struct ref *copy_ref_list(const struct ref *ref)
@@ -801,6 +809,7 @@ static void free_ref(struct ref *ref)
 {
 	if (!ref)
 		return;
+	free_ref(ref->peer_ref);
 	free(ref->remote_status);
 	free(ref->symref);
 	free(ref);
@@ -811,7 +820,6 @@ void free_refs(struct ref *ref)
 	struct ref *next;
 	while (ref) {
 		next = ref->next;
-		free(ref->peer_ref);
 		free_ref(ref);
 		ref = next;
 	}
@@ -1457,13 +1465,6 @@ struct ref *get_local_heads(void)
 	return local_refs;
 }
 
-struct ref *copy_ref_with_peer(const struct ref *src)
-{
-	struct ref *dst = copy_ref(src);
-	dst->peer_ref = copy_ref(src->peer_ref);
-	return dst;
-}
-
 struct ref *guess_remote_head(const struct ref *head,
 			      const struct ref *refs,
 			      int all)
@@ -1480,22 +1481,20 @@ struct ref *guess_remote_head(const struct ref *head,
 	 * where HEAD points; if that is the case, then
 	 * we don't have to guess.
 	 */
-	if (head->symref) {
-		r = find_ref_by_name(refs, head->symref);
-		return r ? copy_ref_with_peer(r) : NULL;
-	}
+	if (head->symref)
+		return copy_ref(find_ref_by_name(refs, head->symref));
 
 	/* If refs/heads/master could be right, it is. */
 	if (!all) {
 		r = find_ref_by_name(refs, "refs/heads/master");
 		if (r && !hashcmp(r->old_sha1, head->old_sha1))
-			return copy_ref_with_peer(r);
+			return copy_ref(r);
 	}
 
 	/* Look for another ref that points there */
 	for (r = refs; r; r = r->next) {
 		if (r != head && !hashcmp(r->old_sha1, head->old_sha1)) {
-			*tail = copy_ref_with_peer(r);
+			*tail = copy_ref(r);
 			tail = &((*tail)->next);
 			if (!all)
 				break;
