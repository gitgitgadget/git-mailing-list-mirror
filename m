From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] refs: mark some symbols static
Date: Sat, 12 Dec 2015 14:33:19 +0000
Message-ID: <566C302F.8090103@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Sat Dec 12 15:34:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a7lFZ-0003pP-8h
	for gcvg-git-2@plane.gmane.org; Sat, 12 Dec 2015 15:34:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751573AbbLLOeM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Dec 2015 09:34:12 -0500
Received: from avasout07.plus.net ([84.93.230.235]:57756 "EHLO
	avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751134AbbLLOeM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Dec 2015 09:34:12 -0500
Received: from [10.0.2.15] ([146.200.5.254])
	by avasout07 with smtp
	id seZK1r0015UqX4q01eZLkY; Sat, 12 Dec 2015 14:33:21 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=fs4hHwMf c=1 sm=1 tr=0
 a=GKs3PHufgjMgxBavMeQJCg==:117 a=GKs3PHufgjMgxBavMeQJCg==:17 a=0Bzu9jTXAAAA:8
 a=EBOSESyhAAAA:8 a=IkcTkHD0fZMA:10 a=KzNrydiS0EN1Fb4DM_UA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.4.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282301>


Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi David,

If you need to re-roll your 'dt/refs-backend-lmdb' branch, could
you please squash the relevant parts of this patch into yours.

[yes, I didn't reference the movement of the external declaration
in the commit message! :-D ]

Thanks!

ATB,
Ramsay Jones

 refs.c               | 7 +++----
 refs/files-backend.c | 2 +-
 refs/refs-internal.h | 2 ++
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/refs.c b/refs.c
index 0be7065..c0faa97 100644
--- a/refs.c
+++ b/refs.c
@@ -9,7 +9,7 @@
 #include "object.h"
 #include "tag.h"
 
-const char split_transaction_fail_warning[] =
+static const char split_transaction_fail_warning[] =
 	"A ref transaction was split across two refs backends.  Part of the "
 	"transaction succeeded, but then the update to the per-worktree refs "
 	"failed.  Your repository may be in an inconsistent state.";
@@ -17,12 +17,11 @@ const char split_transaction_fail_warning[] =
 /*
  * We always have a files backend and it is the default.
  */
-extern struct ref_be refs_be_files;
-struct ref_be *the_refs_backend = &refs_be_files;
+static struct ref_be *the_refs_backend = &refs_be_files;
 /*
  * List of all available backends
  */
-struct ref_be *refs_backends = &refs_be_files;
+static struct ref_be *refs_backends = &refs_be_files;
 
 const char *refs_backend_type;
 
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 0efc507..e8181ae 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3280,7 +3280,7 @@ static int ref_present(const char *refname,
 	return string_list_has_string(affected_refnames, refname);
 }
 
-void files_init_backend(void *data)
+static void files_init_backend(void *data)
 {
 	/* do nothing */
 }
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 9c17fdf..8fb360d 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -313,4 +313,6 @@ struct ref_be {
 	for_each_replace_ref_fn *for_each_replace_ref;
 };
 
+extern struct ref_be refs_be_files;
+
 #endif /* REFS_REFS_INTERNAL_H */
-- 
2.6.0
