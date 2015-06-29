From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 0/7] refs backend preamble
Date: Mon, 29 Jun 2015 12:11:14 -0700
Message-ID: <xmqqfv5a9vot.fsf@gitster.dls.corp.google.com>
References: <1435600468-21710-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Mon Jun 29 21:11:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9eSh-00042i-9D
	for gcvg-git-2@plane.gmane.org; Mon, 29 Jun 2015 21:11:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752197AbbF2TLT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jun 2015 15:11:19 -0400
Received: from mail-ig0-f172.google.com ([209.85.213.172]:33582 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751080AbbF2TLR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jun 2015 15:11:17 -0400
Received: by igcur8 with SMTP id ur8so45111767igc.0
        for <git@vger.kernel.org>; Mon, 29 Jun 2015 12:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=Up5Fjv1xUpMOi5dOUaLe7s5Y/2HSSTINXS6TDuZIsus=;
        b=w2hvU3Ro/rQf5lBvSpDlfDq1HXyYtRlpTb8xYhHdp+gioCCW/q3HOLy5IVTdnEzbsF
         kU1zE1GmElCJEM5Rj0dnZm5yCcSF1zmS+erFfZoo2j8RLXmygLTJXFchhoagFlMCKFSz
         X1n5ciecBdnnOCiMuEiTw0gWl4P4JLpZPBdaYgS5UJ+qtV1SkUJGJV1F1nvf5eLspj7Y
         NuexVdADkC5yUcSojhsH/RHCrQsOndKKPv4lr5uflzInXuQYzib2HQTyAc94JTXmHKLU
         uh4Plo+oV2GMcMCnw3Z4fsCiuXkWoRpic+CFQke1piWr3hXAJBRv8zobuSMWnswzeCBw
         Q+qw==
X-Received: by 10.107.25.15 with SMTP id 15mr23011273ioz.11.1435605076843;
        Mon, 29 Jun 2015 12:11:16 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:946c:210:22fc:378d])
        by mx.google.com with ESMTPSA id o19sm6068597igi.14.2015.06.29.12.11.15
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 29 Jun 2015 12:11:16 -0700 (PDT)
In-Reply-To: <1435600468-21710-1-git-send-email-dturner@twopensource.com>
	(David Turner's message of "Mon, 29 Jun 2015 13:54:21 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272994>

There might be other issues but from cursory read, at least the
following needs to be split and squashed into patches that introduce
them.

Otherwise, it was a very pleasant read.

Thanks.

 Documentation/git-reflog.txt | 4 ++--
 builtin/reflog.c             | 2 +-
 refs.c                       | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-reflog.txt b/Documentation/git-reflog.txt
index 7ab2c42..2bf8aa6 100644
--- a/Documentation/git-reflog.txt
+++ b/Documentation/git-reflog.txt
@@ -23,8 +23,8 @@ depending on the subcommand:
 	[--dry-run] [--verbose] [--all | <refs>...]
 'git reflog delete' [--rewrite] [--updateref]
 	[--dry-run] [--verbose] ref@\{specifier\}...
-'git reflog create <refs>...
-'git reflog exists <ref>
+'git reflog create' <refs>...
+'git reflog exists' <ref>
 
 Reference logs, or "reflogs", record when the tips of branches and
 other references were updated in the local repository. Reflogs are
diff --git a/builtin/reflog.c b/builtin/reflog.c
index 1ecbfb6..3080865 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -742,7 +742,7 @@ static int cmd_reflog_create(int argc, const char **argv, const char *prefix)
 
 static int cmd_reflog_exists(int argc, const char **argv, const char *prefix)
 {
-	int i, status = 0, start = 0;
+	int i, start = 0;
 
 	for (i = 1; i < argc; i++) {
 		const char *arg = argv[i];
diff --git a/refs.c b/refs.c
index 55235cf..831d31c 100644
--- a/refs.c
+++ b/refs.c
@@ -2911,7 +2911,7 @@ static int rename_ref_available(const char *oldname, const char *newname)
 }
 
 static int write_ref_to_lockfile(struct ref_lock *lock,
-				 const unsigned char *sha1, struct strbuf* err);
+				 const unsigned char *sha1, struct strbuf *err);
 static int commit_ref_update(struct ref_lock *lock,
 			     const unsigned char *sha1, const char *logmsg,
 			     struct strbuf *err);
-- 
2.5.0-rc0-169-ge0d9173
