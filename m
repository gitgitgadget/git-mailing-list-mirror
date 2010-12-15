From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH] completion: add missing configuration variables
Date: Wed, 15 Dec 2010 07:46:53 +0100
Message-ID: <1292395613-12859-1-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 15 13:47:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSql8-0003Xp-33
	for gcvg-git-2@lo.gmane.org; Wed, 15 Dec 2010 13:47:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753660Ab0LOMqr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Dec 2010 07:46:47 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:47668 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753651Ab0LOMqo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Dec 2010 07:46:44 -0500
Received: by vws16 with SMTP id 16so707563vws.19
        for <git@vger.kernel.org>; Wed, 15 Dec 2010 04:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=X4kPBYY7De5S1atafNNYJGzIQlJZme/WPbfCAK0NbNw=;
        b=qFpVT4mEVUgQ+8eOzUq3C0y/QwACUvFbsFrHNjMhmf2zhQ8HTZXgcoz8/cgD2cQRam
         l8qoS7IcA8UUXZ3byE8f7NK9it8MgteaYzlL3I5pbAnQG7B6BXUssTDp58PFSxs228+R
         ebSkYT6tixluf5pVzLAj2DOkw7eju+ad7wnac=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=ZXxG307qFEmg6O0Sa1bogq9ojs5rboIxkeCRFUvCQedbqM6jh6yfAQ1FBhdhviZgnf
         RfPgkWOKVJJFfRRxJBRph7TECkQpw+hxmNbVYq2SjLKO38WyTPHs+HYmPywnfuq//dMI
         eUP3irxpNLys8ar7u9vqGFnnprN3/8zoq1rqc=
Received: by 10.220.201.140 with SMTP id fa12mr2036043vcb.20.1292417202914;
        Wed, 15 Dec 2010 04:46:42 -0800 (PST)
Received: from localhost.localdomain (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id o6sm284535vcr.27.2010.12.15.04.46.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 15 Dec 2010 04:46:41 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.864.gbbb96
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163754>

Quite a few configuration variables have been added since 226b343
(completion: add missing configuration variables to _git_config(),
2009-05-03). Add these variables to the Bash completion script.

Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
---

The color.grep.external option has been deleted. Should it be deleted
from here or do we want to help users run e.g.
'git config --unset color.grep.external'? Same goes for
add.ignore-errors.

I didn't find any references to 'diff.renameLimit.' even in 98171a0
(bash completion: Sync config variables with their man pages,
2008-12-15) in which it was introduced in the completions script. I
hope it was safe to remove it.

Some variables are documented with camelCase but read in all
lowercase in the code. Not worth updating the code just for that, is
it?

I hope none of the added variables are deprecated. After having a
quick look in git-config(1), I think they should not be.

 contrib/completion/git-completion.bash |   67 +++++++++++++++++++++++++++++++-
 1 files changed, 65 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 604fa79..1e2e864 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1865,29 +1865,51 @@ _git_config ()
 	esac
 	__gitcomp "
 		add.ignore-errors
+		add.ignoreErrors
+		advice.commitBeforeMerge
+		advice.detachedHead
+		advice.implicitIdentity
+		advice.pushNonFastForward
+		advice.resolveConflict
+		advice.statusHints
 		alias.
+		am.keepcr
 		apply.ignorewhitespace
 		apply.whitespace
 		branch.autosetupmerge
 		branch.autosetuprebase
+		browser.
 		clean.requireForce
 		color.branch
 		color.branch.current
 		color.branch.local
 		color.branch.plain
 		color.branch.remote
+		color.decorate.HEAD
+		color.decorate.branch
+		color.decorate.remoteBranch
+		color.decorate.stash
+		color.decorate.tag
 		color.diff
 		color.diff.commit
 		color.diff.frag
+		color.diff.func
 		color.diff.meta
 		color.diff.new
 		color.diff.old
 		color.diff.plain
 		color.diff.whitespace
 		color.grep
+		color.grep.context
 		color.grep.external
+		color.grep.filename
+		color.grep.function
+		color.grep.linenumber
 		color.grep.match
+		color.grep.selected
+		color.grep.separator
 		color.interactive
+		color.interactive.error
 		color.interactive.header
 		color.interactive.help
 		color.interactive.prompt
@@ -1901,21 +1923,29 @@ _git_config ()
 		color.status.untracked
 		color.status.updated
 		color.ui
+		commit.status
 		commit.template
+		core.abbrevguard
+		core.askpass
+		core.attributesfile
 		core.autocrlf
 		core.bare
+		core.bigFileThreshold
 		core.compression
 		core.createObject
 		core.deltaBaseCacheLimit
 		core.editor
+		core.eol
 		core.excludesfile
 		core.fileMode
 		core.fsyncobjectfiles
 		core.gitProxy
 		core.ignoreCygwinFSTricks
 		core.ignoreStat
+		core.ignorecase
 		core.logAllRefUpdates
 		core.loosecompression
+		core.notesRef
 		core.packedGitLimit
 		core.packedGitWindowSize
 		core.pager
@@ -1925,6 +1955,7 @@ _git_config ()
 		core.repositoryFormatVersion
 		core.safecrlf
 		core.sharedRepository
+		core.sparseCheckout
 		core.symlinks
 		core.trustctime
 		core.warnAmbiguousRefs
@@ -1932,9 +1963,10 @@ _git_config ()
 		core.worktree
 		diff.autorefreshindex
 		diff.external
+		diff.ignoreSubmodules
 		diff.mnemonicprefix
+		diff.noprefix
 		diff.renameLimit
-		diff.renameLimit.
 		diff.renames
 		diff.suppressBlankEmpty
 		diff.tool
@@ -1952,6 +1984,8 @@ _git_config ()
 		format.subjectprefix
 		format.suffix
 		format.thread
+		format.to
+		gc.
 		gc.aggressiveWindow
 		gc.auto
 		gc.autopacklimit
@@ -1989,15 +2023,20 @@ _git_config ()
 		http.lowSpeedLimit
 		http.lowSpeedTime
 		http.maxRequests
+		http.minSessions
 		http.noEPSV
+		http.postBuffer
 		http.proxy
 		http.sslCAInfo
 		http.sslCAPath
 		http.sslCert
+		http.sslCertPasswordProtected
 		http.sslKey
 		http.sslVerify
+		http.useragent
 		i18n.commitEncoding
 		i18n.logOutputEncoding
+		imap.authMethod
 		imap.folder
 		imap.host
 		imap.pass
@@ -2006,6 +2045,7 @@ _git_config ()
 		imap.sslverify
 		imap.tunnel
 		imap.user
+		init.templatedir
 		instaweb.browser
 		instaweb.httpd
 		instaweb.local
@@ -2013,19 +2053,29 @@ _git_config ()
 		instaweb.port
 		interactive.singlekey
 		log.date
+		log.decorate
 		log.showroot
 		mailmap.file
 		man.
 		man.viewer
+		merge.
 		merge.conflictstyle
 		merge.log
 		merge.renameLimit
+		merge.renormalize
 		merge.stat
 		merge.tool
 		merge.verbosity
 		mergetool.
 		mergetool.keepBackup
+		mergetool.keepTemporaries
 		mergetool.prompt
+		notes.displayRef
+		notes.rewrite.
+		notes.rewrite.amend
+		notes.rewrite.rebase
+		notes.rewriteMode
+		notes.rewriteRef
 		pack.compression
 		pack.deltaCacheLimit
 		pack.deltaCacheSize
@@ -2036,31 +2086,42 @@ _git_config ()
 		pack.window
 		pack.windowMemory
 		pager.
+		pretty.
 		pull.octopus
 		pull.twohead
 		push.default
+		rebase.autosquash
 		rebase.stat
+		receive.autogc
 		receive.denyCurrentBranch
+		receive.denyDeleteCurrent
 		receive.denyDeletes
 		receive.denyNonFastForwards
 		receive.fsckObjects
 		receive.unpackLimit
+		receive.updateserverinfo
+		remotes.
 		repack.usedeltabaseoffset
 		rerere.autoupdate
 		rerere.enabled
+		sendemail.
 		sendemail.aliasesfile
-		sendemail.aliasesfiletype
+		sendemail.aliasfiletype
 		sendemail.bcc
 		sendemail.cc
 		sendemail.cccmd
 		sendemail.chainreplyto
 		sendemail.confirm
 		sendemail.envelopesender
+		sendemail.from
+		sendemail.identity
 		sendemail.multiedit
 		sendemail.signedoffbycc
+		sendemail.smtpdomain
 		sendemail.smtpencryption
 		sendemail.smtppass
 		sendemail.smtpserver
+		sendemail.smtpserveroption
 		sendemail.smtpserverport
 		sendemail.smtpuser
 		sendemail.suppresscc
@@ -2071,6 +2132,8 @@ _git_config ()
 		showbranch.default
 		status.relativePaths
 		status.showUntrackedFiles
+		status.submodulesummary
+		submodule.
 		tar.umask
 		transfer.unpackLimit
 		url.
-- 
1.7.3.2.864.gbbb96
