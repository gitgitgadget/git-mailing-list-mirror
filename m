Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6652C1F406
	for <e@80x24.org>; Thu, 10 May 2018 14:19:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965600AbeEJOTr (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 10:19:47 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:40013 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965078AbeEJOTl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 10:19:41 -0400
Received: by mail-lf0-f67.google.com with SMTP id p85-v6so3220311lfg.7
        for <git@vger.kernel.org>; Thu, 10 May 2018 07:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DGM9cvU+sOsgBRJD65DkgYkutPoHoFQAnoHs+g5nqwk=;
        b=tPnWDdxTbr9XT2xvcpXQQzWJaoy6R2NTFXtPT8hiFPGLPPpE5p33YsvWYrE3fdjeGe
         HlcGyN2jeMZgDyDwDOGtFEZb5zuJEez2HnW+ZvJfbzxsMIRf+35tgiZ+2O7WOzjU2ave
         AGBpq5KQMfTsc5WIy1bxnYvtaVM93CNK7sHm3/+ZUPgQltsRkmZdGwERYtS/5cJIQw9L
         +y0n6M7pqgEVK8greacjwZYRU7J7s7kdSWbvsfza+hknN0y5xVfWm0raSDKFZPQ6AdeR
         26a1en+HgWYMEcDlGEGXN7O6qQvjieksugbHrU7mj9bhBjJJgHPWxt7duKphQ4TkJbEk
         Dt8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DGM9cvU+sOsgBRJD65DkgYkutPoHoFQAnoHs+g5nqwk=;
        b=Xr6V+LLmDjDp2gakEGQULKZFuiOCt95cIbpTk/jLsGzk9J1ivV1Rm/2I/mlGUCx4kt
         P2siiHBlwNtGbBOuev5G5zyORR1RxZ7HuqLjM6KmYWF+xByBqDS8xjKLGgvnhyyMlUrP
         Eg1q3MiCJU6xtc81L/4VJ/dKLjwlOD/MshvXVaGXTlmqCP6r+bJPOxzig71fFqx6dYzP
         WNHda9T4gmbeEIBNsU7d0iR4neuN/H/x1gwwppJVPWlptSj2S60Tv0i5dBoCRCTpbqyE
         BB+7EO7axqTed4jZ6VJd7nNnm8VMwrGetsHfOb8WNrPDHeoswGoPcsNPp1fKvsKFRTj/
         ul/A==
X-Gm-Message-State: ALKqPwf24usvbI28ipWmTLYzhAqzpmpOrwUeRs3btII7mlEwkNBNxhLv
        zdIVieuRh0s9sbQZC8A5yx2P/w==
X-Google-Smtp-Source: AB8JxZp86shbcrKpe5bbUDYFz/78jJEMtphXDGsKKTQKb0KNg1wZUIzPw+FrJjToRlQwlPfAZNIFoQ==
X-Received: by 2002:a2e:5d57:: with SMTP id r84-v6mr1281544ljb.125.1525961978982;
        Thu, 10 May 2018 07:19:38 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g2-v6sm194296ljj.82.2018.05.10.07.19.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 May 2018 07:19:38 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 7/9] completion: drop the hard coded list of config vars
Date:   Thu, 10 May 2018 16:19:25 +0200
Message-Id: <20180510141927.23590-8-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.705.g3525833791
In-Reply-To: <20180510141927.23590-1-pclouds@gmail.com>
References: <20180510141927.23590-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The new help option --config-for-completion is a machine friendlier
version of --config where all the placeholders and wildcards are
dropped, leaving only the good, completable prefixes for
git-completion.bash to consume.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/help.c                         |  13 +-
 contrib/completion/git-completion.bash | 334 +------------------------
 help.c                                 |  30 ++-
 help.h                                 |   2 +-
 4 files changed, 47 insertions(+), 332 deletions(-)

diff --git a/builtin/help.c b/builtin/help.c
index a1153cf473..fbd2b0238a 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -45,7 +45,8 @@ static struct option builtin_help_options[] = {
 	OPT_BOOL('a', "all", &show_all, N_("print all available commands")),
 	OPT_HIDDEN_BOOL(0, "exclude-guides", &exclude_guides, N_("exclude guides")),
 	OPT_BOOL('g', "guides", &show_guides, N_("print list of useful guides")),
-	OPT_BOOL('c', "config", &show_config, N_("print list recognized config variables")),
+	OPT_SET_INT('c', "config", &show_config, N_("print list recognized config variables"), 1),
+	OPT_SET_INT_F(0, "config-for-completion", &show_config, "", 2, PARSE_OPT_HIDDEN),
 	OPT_SET_INT('m', "man", &help_format, N_("show man page"), HELP_FORMAT_MAN),
 	OPT_SET_INT('w', "web", &help_format, N_("show manual in web browser"),
 			HELP_FORMAT_WEB),
@@ -446,9 +447,13 @@ int cmd_help(int argc, const char **argv, const char *prefix)
 	}
 
 	if (show_config) {
-		setup_pager();
-		list_config_help();
-		printf("\n%s\n", _("'git help config' for more information"));
+		int for_human = show_config == 1;
+
+		if (for_human)
+			setup_pager();
+		list_config_help(for_human);
+		if (for_human)
+			printf("\n%s\n", _("'git help config' for more information"));
 		return 0;
 	}
 
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index f7ca9a4d4f..8d3257c4de 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2074,6 +2074,13 @@ __git_config_get_set_variables ()
 	__git config $config_file --name-only --list
 }
 
+__git_config_vars=
+__git_compute_config_vars ()
+{
+	test -n "$__git_config_vars" ||
+	__git_config_vars="$(git help --config-for-completion | sort | uniq)"
+}
+
 _git_config ()
 {
 	case "$prev" in
@@ -2232,331 +2239,8 @@ _git_config ()
 		return
 		;;
 	esac
-	__gitcomp "
-		add.ignoreErrors
-		advice.amWorkDir
-		advice.commitBeforeMerge
-		advice.detachedHead
-		advice.implicitIdentity
-		advice.pushAlreadyExists
-		advice.pushFetchFirst
-		advice.pushNeedsForce
-		advice.pushNonFFCurrent
-		advice.pushNonFFMatching
-		advice.pushUpdateRejected
-		advice.resolveConflict
-		advice.rmHints
-		advice.statusHints
-		advice.statusUoption
-		advice.ignoredHook
-		alias.
-		am.keepcr
-		am.threeWay
-		apply.ignorewhitespace
-		apply.whitespace
-		branch.autosetupmerge
-		branch.autosetuprebase
-		browser.
-		clean.requireForce
-		color.branch
-		color.branch.current
-		color.branch.local
-		color.branch.plain
-		color.branch.remote
-		color.decorate.HEAD
-		color.decorate.branch
-		color.decorate.remoteBranch
-		color.decorate.stash
-		color.decorate.tag
-		color.diff
-		color.diff.commit
-		color.diff.frag
-		color.diff.func
-		color.diff.meta
-		color.diff.new
-		color.diff.old
-		color.diff.plain
-		color.diff.whitespace
-		color.grep
-		color.grep.context
-		color.grep.filename
-		color.grep.function
-		color.grep.linenumber
-		color.grep.match
-		color.grep.selected
-		color.grep.separator
-		color.interactive
-		color.interactive.error
-		color.interactive.header
-		color.interactive.help
-		color.interactive.prompt
-		color.pager
-		color.showbranch
-		color.status
-		color.status.added
-		color.status.changed
-		color.status.header
-		color.status.localBranch
-		color.status.nobranch
-		color.status.remoteBranch
-		color.status.unmerged
-		color.status.untracked
-		color.status.updated
-		color.ui
-		commit.cleanup
-		commit.gpgSign
-		commit.status
-		commit.template
-		commit.verbose
-		core.abbrev
-		core.askpass
-		core.attributesfile
-		core.autocrlf
-		core.bare
-		core.bigFileThreshold
-		core.checkStat
-		core.commentChar
-		core.compression
-		core.createObject
-		core.deltaBaseCacheLimit
-		core.editor
-		core.eol
-		core.excludesfile
-		core.fileMode
-		core.fsyncobjectfiles
-		core.gitProxy
-		core.hideDotFiles
-		core.hooksPath
-		core.ignoreStat
-		core.ignorecase
-		core.logAllRefUpdates
-		core.loosecompression
-		core.notesRef
-		core.packedGitLimit
-		core.packedGitWindowSize
-		core.packedRefsTimeout
-		core.pager
-		core.precomposeUnicode
-		core.preferSymlinkRefs
-		core.preloadindex
-		core.protectHFS
-		core.protectNTFS
-		core.quotepath
-		core.repositoryFormatVersion
-		core.safecrlf
-		core.sharedRepository
-		core.sparseCheckout
-		core.splitIndex
-		core.sshCommand
-		core.symlinks
-		core.trustctime
-		core.untrackedCache
-		core.warnAmbiguousRefs
-		core.whitespace
-		core.worktree
-		credential.helper
-		credential.useHttpPath
-		credential.username
-		credentialCache.ignoreSIGHUP
-		diff.autorefreshindex
-		diff.external
-		diff.ignoreSubmodules
-		diff.mnemonicprefix
-		diff.noprefix
-		diff.renameLimit
-		diff.renames
-		diff.statGraphWidth
-		diff.submodule
-		diff.suppressBlankEmpty
-		diff.tool
-		diff.wordRegex
-		diff.algorithm
-		difftool.
-		difftool.prompt
-		fetch.recurseSubmodules
-		fetch.unpackLimit
-		format.attach
-		format.cc
-		format.coverLetter
-		format.from
-		format.headers
-		format.numbered
-		format.pretty
-		format.signature
-		format.signoff
-		format.subjectprefix
-		format.suffix
-		format.thread
-		format.to
-		gc.
-		gc.aggressiveDepth
-		gc.aggressiveWindow
-		gc.auto
-		gc.autoDetach
-		gc.autopacklimit
-		gc.logExpiry
-		gc.packrefs
-		gc.pruneexpire
-		gc.reflogexpire
-		gc.reflogexpireunreachable
-		gc.rerereresolved
-		gc.rerereunresolved
-		gc.worktreePruneExpire
-		gitcvs.allbinary
-		gitcvs.commitmsgannotation
-		gitcvs.dbTableNamePrefix
-		gitcvs.dbdriver
-		gitcvs.dbname
-		gitcvs.dbpass
-		gitcvs.dbuser
-		gitcvs.enabled
-		gitcvs.logfile
-		gitcvs.usecrlfattr
-		guitool.
-		gui.blamehistoryctx
-		gui.commitmsgwidth
-		gui.copyblamethreshold
-		gui.diffcontext
-		gui.encoding
-		gui.fastcopyblame
-		gui.matchtrackingbranch
-		gui.newbranchtemplate
-		gui.pruneduringfetch
-		gui.spellingdictionary
-		gui.trustmtime
-		help.autocorrect
-		help.browser
-		help.format
-		http.lowSpeedLimit
-		http.lowSpeedTime
-		http.maxRequests
-		http.minSessions
-		http.noEPSV
-		http.postBuffer
-		http.proxy
-		http.sslCipherList
-		http.sslVersion
-		http.sslCAInfo
-		http.sslCAPath
-		http.sslCert
-		http.sslCertPasswordProtected
-		http.sslKey
-		http.sslVerify
-		http.useragent
-		i18n.commitEncoding
-		i18n.logOutputEncoding
-		imap.authMethod
-		imap.folder
-		imap.host
-		imap.pass
-		imap.port
-		imap.preformattedHTML
-		imap.sslverify
-		imap.tunnel
-		imap.user
-		init.templatedir
-		instaweb.browser
-		instaweb.httpd
-		instaweb.local
-		instaweb.modulepath
-		instaweb.port
-		interactive.singlekey
-		log.date
-		log.decorate
-		log.showroot
-		mailmap.file
-		man.
-		man.viewer
-		merge.
-		merge.conflictstyle
-		merge.log
-		merge.renameLimit
-		merge.renormalize
-		merge.stat
-		merge.tool
-		merge.verbosity
-		mergetool.
-		mergetool.keepBackup
-		mergetool.keepTemporaries
-		mergetool.prompt
-		notes.displayRef
-		notes.rewrite.
-		notes.rewrite.amend
-		notes.rewrite.rebase
-		notes.rewriteMode
-		notes.rewriteRef
-		pack.compression
-		pack.deltaCacheLimit
-		pack.deltaCacheSize
-		pack.depth
-		pack.indexVersion
-		pack.packSizeLimit
-		pack.threads
-		pack.window
-		pack.windowMemory
-		pager.
-		pretty.
-		pull.octopus
-		pull.twohead
-		push.default
-		push.followTags
-		rebase.autosquash
-		rebase.stat
-		receive.autogc
-		receive.denyCurrentBranch
-		receive.denyDeleteCurrent
-		receive.denyDeletes
-		receive.denyNonFastForwards
-		receive.fsckObjects
-		receive.unpackLimit
-		receive.updateserverinfo
-		remote.pushdefault
-		remotes.
-		repack.usedeltabaseoffset
-		rerere.autoupdate
-		rerere.enabled
-		sendemail.
-		sendemail.aliasesfile
-		sendemail.aliasfiletype
-		sendemail.bcc
-		sendemail.cc
-		sendemail.cccmd
-		sendemail.chainreplyto
-		sendemail.confirm
-		sendemail.envelopesender
-		sendemail.from
-		sendemail.identity
-		sendemail.multiedit
-		sendemail.signedoffbycc
-		sendemail.smtpdomain
-		sendemail.smtpencryption
-		sendemail.smtppass
-		sendemail.smtpserver
-		sendemail.smtpserveroption
-		sendemail.smtpserverport
-		sendemail.smtpuser
-		sendemail.suppresscc
-		sendemail.suppressfrom
-		sendemail.thread
-		sendemail.to
-		sendemail.tocmd
-		sendemail.validate
-		sendemail.smtpbatchsize
-		sendemail.smtprelogindelay
-		showbranch.default
-		status.relativePaths
-		status.showUntrackedFiles
-		status.submodulesummary
-		submodule.
-		tar.umask
-		transfer.unpackLimit
-		url.
-		user.email
-		user.name
-		user.signingkey
-		web.browser
-		branch. remote.
-	"
+	__git_compute_config_vars
+	__gitcomp "$__git_config_vars"
 }
 
 _git_remote ()
diff --git a/help.c b/help.c
index b10c8b0230..a4157a3512 100644
--- a/help.c
+++ b/help.c
@@ -416,7 +416,7 @@ struct slot_expansion {
 	int found;
 };
 
-void list_config_help(void)
+void list_config_help(int for_human)
 {
 	struct slot_expansion slot_expansions[] = {
 		{ "advice", "*", list_advices },
@@ -435,6 +435,7 @@ void list_config_help(void)
 
 	for (p = config_name_list; *p; p++) {
 		const char *var = *p;
+		const char *wildcard, *tag, *cut;
 
 		for (e = slot_expansions; e->prefix; e++) {
 			struct strbuf sb = STRBUF_INIT;
@@ -447,8 +448,33 @@ void list_config_help(void)
 			e->found++;
 			break;
 		}
-		if (!e->prefix)
+		if (e->prefix)
+			continue;
+		if (for_human) {
 			puts(var);
+			continue;
+		}
+
+		wildcard = strchr(var, '*');
+		tag = strchr(var, '<');
+
+		if (!wildcard && !tag) {
+			puts(var);
+			continue;
+		}
+
+		if (wildcard && !tag)
+			cut = wildcard;
+		else if (!wildcard && tag)
+			cut = tag;
+		else
+			cut = wildcard < tag ? wildcard : tag;
+
+		/*
+		 * We may produce duplicates, but that's up to
+		 * git-completion.bash to handle
+		 */
+		printf("%.*s\n", (int)(cut - var), var);
 	}
 
 	for (e = slot_expansions; e->prefix; e++)
diff --git a/help.h b/help.h
index d7d1409718..04df559c64 100644
--- a/help.h
+++ b/help.h
@@ -21,7 +21,7 @@ static inline void mput_char(char c, unsigned int num)
 extern void list_common_cmds_help(void);
 extern void list_all_cmds_help(void);
 extern void list_common_guides_help(void);
-extern void list_config_help(void);
+extern void list_config_help(int for_human);
 
 extern void list_all_main_cmds(struct string_list *list);
 extern void list_all_other_cmds(struct string_list *list);
-- 
2.17.0.705.g3525833791

