From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH v2] completion: add missing configuration variables
Date: Mon, 20 Dec 2010 16:18:25 +0100
Message-ID: <1292858305-7679-1-git-send-email-martin.von.zweigbergk@gmail.com>
References: <1292395613-12859-1-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 20 22:18:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PUn7d-0003sn-SL
	for gcvg-git-2@lo.gmane.org; Mon, 20 Dec 2010 22:18:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933241Ab0LTVSQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Dec 2010 16:18:16 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:33999 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933219Ab0LTVSP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Dec 2010 16:18:15 -0500
Received: by qyj19 with SMTP id 19so4494756qyj.19
        for <git@vger.kernel.org>; Mon, 20 Dec 2010 13:18:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=2ECzDbPNeutbxKmQKOiNSZ5/ROeNOd+OJInIIe9gGAM=;
        b=Wj4/Wx/muCU0XziTffG1RocVf7XPJYd9DwA5mZqjSerrhvT3ApP26MlMFjn/yLj6R1
         CBYq87VTeIPub+a+Trj44OhZ2NCoQTkuI1iLc6K9vL6NElrSEUM4S8V3BVtemPlzliX1
         7ETdMQ310P3EcGbLbfZ6kEQvHXixO6l8M9D6w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=EFp7ZW9OMXkXaPZqv4urOIZfE327BrxXwo0xB6njcUSiXB7KXkpubjwJviK+IDlR6l
         9Qanq9sBkmhRSXm6jQyTrcA1mc4jHq2qUd5Ma4CaZ2c20RBPdHaKqTyoH05nYIEcDFRJ
         nOwwd3ZeDXIjpcoO2/f3ckqB1kw4B+mwUH1e8=
Received: by 10.229.225.199 with SMTP id it7mr4334145qcb.7.1292879894562;
        Mon, 20 Dec 2010 13:18:14 -0800 (PST)
Received: from localhost.localdomain (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id s10sm956810qco.11.2010.12.20.13.18.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 20 Dec 2010 13:18:13 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.864.gbbb96
In-Reply-To: <1292395613-12859-1-git-send-email-martin.von.zweigbergk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164011>

Quite a few configuration variables have been added since 226b343
(completion: add missing configuration variables to _git_config(),
2009-05-03). Add these variables to the Bash completion script.

Also remove the obsolete 'add.ignore-errors' and
'color.grep.external', as well as 'diff.renameLimit.', which never
existed and rename the misspelled 'sendemail.aliasesfiletype'.

Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
---
Changes since previous version:

Removed 'add.ignore-errors' and 'color.grep.external'.

Added 'fetch.recurseSubmodules', which has entered master since last
round.

(Still based on master.)

 contrib/completion/git-completion.bash |   70 ++++++++++++++++++++++++++++++--
 1 files changed, 66 insertions(+), 4 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 604fa79..25c4314 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1864,30 +1864,50 @@ _git_config ()
 		;;
 	esac
 	__gitcomp "
-		add.ignore-errors
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
-		color.grep.external
+		color.grep.context
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
@@ -1901,21 +1921,29 @@ _git_config ()
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
@@ -1925,6 +1953,7 @@ _git_config ()
 		core.repositoryFormatVersion
 		core.safecrlf
 		core.sharedRepository
+		core.sparseCheckout
 		core.symlinks
 		core.trustctime
 		core.warnAmbiguousRefs
@@ -1932,15 +1961,17 @@ _git_config ()
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
 		diff.wordRegex
 		difftool.
 		difftool.prompt
+		fetch.recurseSubmodules
 		fetch.unpackLimit
 		format.attach
 		format.cc
@@ -1952,6 +1983,8 @@ _git_config ()
 		format.subjectprefix
 		format.suffix
 		format.thread
+		format.to
+		gc.
 		gc.aggressiveWindow
 		gc.auto
 		gc.autopacklimit
@@ -1989,15 +2022,20 @@ _git_config ()
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
@@ -2006,6 +2044,7 @@ _git_config ()
 		imap.sslverify
 		imap.tunnel
 		imap.user
+		init.templatedir
 		instaweb.browser
 		instaweb.httpd
 		instaweb.local
@@ -2013,19 +2052,29 @@ _git_config ()
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
@@ -2036,31 +2085,42 @@ _git_config ()
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
@@ -2071,6 +2131,8 @@ _git_config ()
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
