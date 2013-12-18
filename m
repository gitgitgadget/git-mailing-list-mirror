From: Roberto Tyley <roberto.tyley@gmail.com>
Subject: [PATCH v2] docs: add filter-branch notes on The BFG
Date: Wed, 18 Dec 2013 14:25:16 +0000
Message-ID: <1387376716-72615-2-git-send-email-roberto.tyley@gmail.com>
References: <xmqqr49ak8fi.fsf@gitster.dls.corp.google.com>
 <1387376716-72615-1-git-send-email-roberto.tyley@gmail.com>
Cc: gitster@pobox.com, jrnieder@gmail.com,
	Roberto Tyley <roberto.tyley@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 18 15:25:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VtI4L-0004L9-Qj
	for gcvg-git-2@plane.gmane.org; Wed, 18 Dec 2013 15:25:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754738Ab3LROZo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Dec 2013 09:25:44 -0500
Received: from mail-wi0-f177.google.com ([209.85.212.177]:60945 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754636Ab3LROZn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Dec 2013 09:25:43 -0500
Received: by mail-wi0-f177.google.com with SMTP id cc10so694711wib.10
        for <git@vger.kernel.org>; Wed, 18 Dec 2013 06:25:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FygPach5ccS81bYJB/TV/7YlFD8waNyS8lwntmb3hmg=;
        b=P1t7sjuIOsUH8pRNvnNplcoUxAtzkq+ry67HH4HRsQDxSuMNjUayBtOklHTY0ZhgeJ
         NHW/bVaVYKcYEc/zpvCdLLPda5+T8TEVX1nrq3EekUxmOMtZY3c1k9XI86p5DUJd/7sm
         pOJ7pXOBg7XNgmu/JQCJLKh3ZzPODchE6i8u7WGO1jGSrnlerx1XFnGMTNB7jrA1S0BP
         hkFYcT8ohoTvH4XOMty5YouM3bYfNXgwuVkdVr3QkMVpfwUxymO2eazYmJnqCt2xNzec
         aG3rfqr45nYolCN3UdcMRk1yhD3II4Xd2frJrqmtVo17QE8SR+3WBOt+IL9ncRpTPQag
         Jkkg==
X-Received: by 10.194.23.201 with SMTP id o9mr18119866wjf.67.1387376740574;
        Wed, 18 Dec 2013 06:25:40 -0800 (PST)
Received: from localhost.localdomain (nat-123-249.guardian.co.uk. [77.91.249.123])
        by mx.google.com with ESMTPSA id o9sm4277293wib.10.2013.12.18.06.25.38
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 18 Dec 2013 06:25:39 -0800 (PST)
X-Mailer: git-send-email 1.8.3.4 (Apple Git-47)
In-Reply-To: <1387376716-72615-1-git-send-email-roberto.tyley@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239437>

The BFG is a tool specifically designed for the task of removing
unwanted data from Git repository history - a common use-case for which
git-filter-branch has been the traditional workhorse.

It's beneficial to let users know that filter-branch has an alternative
here:

* speed : The BFG is 10-50x faster
  http://rtyley.github.io/bfg-repo-cleaner/#speed
* complexity of configuration : filter-branch is a very flexible tool,
  but demands very careful usage in order to get the desired results
  http://rtyley.github.io/bfg-repo-cleaner/#examples

Obviously, filter-branch has it's advantages too - it permits very
complex rewrites, and doesn't require a JVM - but for the common
use-case of deleting unwanted data, it's helpful to users to be aware
that an alternative exists.

The BFG was released under the GPL in February 2013, and has since seen
widespread production use (The Guardian, RedHat, Google, UK Government
Digital Service), been tested against large repos (~300K commits, ~5GB
packfiles) and received significant positive feedback from users:

http://rtyley.github.io/bfg-repo-cleaner/#feedback

Signed-off-by: Roberto Tyley <roberto.tyley@gmail.com>
---
 Documentation/git-filter-branch.txt | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
index e4c8e82..2eba627 100644
--- a/Documentation/git-filter-branch.txt
+++ b/Documentation/git-filter-branch.txt
@@ -393,7 +393,7 @@ git filter-branch --index-filter \
 Checklist for Shrinking a Repository
 ------------------------------------
 
-git-filter-branch is often used to get rid of a subset of files,
+git-filter-branch can be used to get rid of a subset of files,
 usually with some combination of `--index-filter` and
 `--subdirectory-filter`.  People expect the resulting repository to
 be smaller than the original, but you need a few more steps to
@@ -429,6 +429,37 @@ warned.
   (or if your git-gc is not new enough to support arguments to
   `--prune`, use `git repack -ad; git prune` instead).
 
+Notes
+-----
+
+git-filter-branch allows you to make complex shell-scripted rewrites
+of your Git history, but you probably don't need this flexibility if
+you're simply _removing unwanted data_ like large files or passwords.
+For those operations you may want to consider
+link:http://rtyley.github.io/bfg-repo-cleaner/[The BFG Repo-Cleaner],
+a JVM-based alternative to git-filter-branch, typically at least
+10-50x faster for those use-cases, and with quite different
+characteristics:
+
+* Any particular version of a file is cleaned exactly _once_. The BFG,
+  unlike git-filter-branch, does not give you the opportunity to
+  handle a file differently based on where or when it was committed
+  within your history. This constraint gives the core performance
+  benefit of The BFG, and is well-suited to the task of cleansing bad
+  data - you don't care _where_ the bad data is, you just want it
+  _gone_.
+
+* By default The BFG takes full advantage of multi-core machines,
+  cleansing commit file-trees in parallel. git-filter-branch cleans
+  commits sequentially (ie in a single-threaded manner), though it
+  _is_ possible to write filters that include their own parallellism,
+  in the scripts executed against each commit.
+
+* The link:http://rtyley.github.io/bfg-repo-cleaner/#examples[command options]
+  are much more restrictive than git-filter branch, and dedicated just
+  to the tasks of removing unwanted data- e.g:
+  `--strip-blobs-bigger-than 1M`.
+
 GIT
 ---
 Part of the linkgit:git[1] suite
-- 
1.8.3.4 (Apple Git-47)
