Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B364E1F45A
	for <e@80x24.org>; Sat, 17 Aug 2019 00:39:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726097AbfHQAj6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Aug 2019 20:39:58 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:40271 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbfHQAj5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Aug 2019 20:39:57 -0400
Received: by mail-qt1-f202.google.com with SMTP id e32so7776067qtc.7
        for <git@vger.kernel.org>; Fri, 16 Aug 2019 17:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=WI9TDv4J8lKrJ+rHRxltg+3ncKPvBzLLOUMu0v7E6NY=;
        b=uSWnfIayM1i9HsxUCRk/vVfO8EuTS0DIhxURt44PuUhHEOTocMDKep9oZfy18eyssm
         sMRitn0pM18Ax25V7PR+QpUeiI5taxjp9XKrWWe6CWA3DPX3B7U5dTOx6H+kiqo2oiY4
         eZyKslsw42sml3q/evidSgcgcpiXa+oTwvcNuOaUvQjkgrW+hIX647dr2Gabdmg01XzG
         s22X4TRvH62UjgxvpLg8xW0ic/ScMvw9aVJxEyiy2bXhXszTaKbttdmRWTlVxPk3Cxh+
         0hBNP8IDbAawgmE90YaxjmdRzfqFxJgNvy/w+Avo/b6Y4LWMrrNn2EF2oTWFZ8jjcoNf
         RS/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=WI9TDv4J8lKrJ+rHRxltg+3ncKPvBzLLOUMu0v7E6NY=;
        b=K5Dfv5I7LmDa0iH9uyzcoJDeniaxjVGlhTj8mIlkPlo2KhKSTycW6Y3H4Pv9BkKMT4
         197KRGG4yyls8UcBydPrFxZD7mU1wnuh7U+SMMrbpogY1FUCtc8DIQPS/C5GLi75UERs
         JrzxGDHjRgYPpuh/KKTVxj3UQdn73bZ12lkJ6m580EbNBsRAwlqGYhlBG+I+ikVep2+w
         Q+9YbzCalv3eMUEHnr7J7885Wzouxr3gOgU/V+6m77sXX5aipP/jCY7Lwne5VJIVCQnm
         eucnUnlPv9enSPl1h3m0q0AHjrnWTwJtyYRishj98KpvzJWkGd6lAQkGNW8XMpT/eA4s
         DBHQ==
X-Gm-Message-State: APjAAAV+Y1vYNjcz5yXXvrG943SkvLo1iCciJYDIBQbbxsyf5AopaZ9s
        qy3iB6hwpOTLZC6SfKMrWDhphyQMPH+VtXf7+rMubajbeL9yLqkvVv6GDuc341/OIEivKfCfSbz
        MWWX8LO9Te/6E+Qr6Tg41hC1HMXX+Mi2k0R5R+VNEaGC53Yvcszc6pfEw9BJ+GR4MkZhm0sn9JQ
        ==
X-Google-Smtp-Source: APXvYqwJgE8R5y4IkVZTFuKMA0PaYu0tdKqFPbDN9RleB5wwY6TDrsTMC5Rz1wmlQgPXKI8D0bVcdCxVzy+y0RXDiVQ=
X-Received: by 2002:a0c:c93c:: with SMTP id r57mr3540792qvj.226.1566002396012;
 Fri, 16 Aug 2019 17:39:56 -0700 (PDT)
Date:   Fri, 16 Aug 2019 17:39:26 -0700
In-Reply-To: <20190817003926.102944-1-emilyshaffer@google.com>
Message-Id: <20190817003926.102944-3-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20190817003926.102944-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH v2 2/2] bugreport: generate config whitelist based on docs
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a new step to the build to generate a whitelist of git-config
variables which are appropriate to include in the output of
git-bugreport. New variables can be added to the whitelist by annotating
their documentation in Documentation/config with the line
"// bugreport-include".

Some configs are private in nature, and can contain remote URLs,
passwords, or other sensitive information. In the event that a user
doesn't notice their information while reviewing a bugreport, that user
may leak their credentials to other individuals, mailing lists, or bug
tracking tools inadvertently. Heuristic blacklisting of configuration
keys is imperfect and prone to false negatives; given the nature of the
information which can be leaked, a whitelist is more reliable.

In order to prevent staleness of the whitelist, add a mechanism to
generate the whitelist from annotations in the config documentation,
where contributors are already used to documenting their new config
keys.

Additionally, add annotations to the sendemail config documentation in
order to demonstrate a proof of concept.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 .gitignore                             |  1 +
 Documentation/config/sendemail.txt     | 68 +++++++++++++-------------
 Makefile                               |  9 +++-
 bugreport-generate-config-whitelist.sh |  4 ++
 git-bugreport-config-whitelist         | 22 ---------
 5 files changed, 47 insertions(+), 57 deletions(-)
 create mode 100755 bugreport-generate-config-whitelist.sh
 delete mode 100644 git-bugreport-config-whitelist

diff --git a/.gitignore b/.gitignore
index b4f5433084..65cc74c748 100644
--- a/.gitignore
+++ b/.gitignore
@@ -26,6 +26,7 @@
 /git-blame
 /git-branch
 /git-bugreport
+/git-bugreport-config-whitelist
 /git-bundle
 /git-cat-file
 /git-check-attr
diff --git a/Documentation/config/sendemail.txt b/Documentation/config/sendemail.txt
index 0006faf800..69f3e4f219 100644
--- a/Documentation/config/sendemail.txt
+++ b/Documentation/config/sendemail.txt
@@ -1,63 +1,63 @@
-sendemail.identity::
+sendemail.identity:: // bugreport-exclude
 	A configuration identity. When given, causes values in the
 	'sendemail.<identity>' subsection to take precedence over
 	values in the 'sendemail' section. The default identity is
 	the value of `sendemail.identity`.
 
-sendemail.smtpEncryption::
+sendemail.smtpEncryption:: // bugreport-include
 	See linkgit:git-send-email[1] for description.  Note that this
 	setting is not subject to the 'identity' mechanism.
 
-sendemail.smtpssl (deprecated)::
+sendemail.smtpssl (deprecated):: // bugreport-exclude
 	Deprecated alias for 'sendemail.smtpEncryption = ssl'.
 
-sendemail.smtpsslcertpath::
+sendemail.smtpsslcertpath:: // bugreport-exclude
 	Path to ca-certificates (either a directory or a single file).
 	Set it to an empty string to disable certificate verification.
 
-sendemail.<identity>.*::
+sendemail.<identity>.*:: // bugreport-exclude
 	Identity-specific versions of the 'sendemail.*' parameters
 	found below, taking precedence over those when this
 	identity is selected, through either the command-line or
 	`sendemail.identity`.
 
-sendemail.aliasesFile::
-sendemail.aliasFileType::
-sendemail.annotate::
-sendemail.bcc::
-sendemail.cc::
-sendemail.ccCmd::
-sendemail.chainReplyTo::
-sendemail.confirm::
-sendemail.envelopeSender::
-sendemail.from::
-sendemail.multiEdit::
-sendemail.signedoffbycc::
-sendemail.smtpPass::
-sendemail.suppresscc::
-sendemail.suppressFrom::
-sendemail.to::
-sendemail.tocmd::
-sendemail.smtpDomain::
-sendemail.smtpServer::
-sendemail.smtpServerPort::
-sendemail.smtpServerOption::
-sendemail.smtpUser::
-sendemail.thread::
-sendemail.transferEncoding::
-sendemail.validate::
-sendemail.xmailer::
+sendemail.aliasesFile:: // bugreport-exclude
+sendemail.aliasFileType:: // bugreport-exclude
+sendemail.annotate:: // bugreport-include
+sendemail.bcc:: // bugreport-include
+sendemail.cc:: // bugreport-include
+sendemail.ccCmd:: // bugreport-include
+sendemail.chainReplyTo:: // bugreport-include
+sendemail.confirm:: // bugreport-include
+sendemail.envelopeSender:: // bugreport-include
+sendemail.from:: // bugreport-include
+sendemail.multiEdit:: // bugreport-include
+sendemail.signedoffbycc:: // bugreport-include
+sendemail.smtpPass:: // bugreport-exclude
+sendemail.suppresscc:: // bugreport-include
+sendemail.suppressFrom:: // bugreport-include
+sendemail.to:: // bugreport-include
+sendemail.tocmd:: // bugreport-include
+sendemail.smtpDomain:: // bugreport-include
+sendemail.smtpServer:: // bugreport-include
+sendemail.smtpServerPort:: // bugreport-include
+sendemail.smtpServerOption:: // bugreport-include
+sendemail.smtpUser:: // bugreport-exclude
+sendemail.thread:: // bugreport-include
+sendemail.transferEncoding:: // bugreport-include
+sendemail.validate:: // bugreport-include
+sendemail.xmailer:: // bugreport-include
 	See linkgit:git-send-email[1] for description.
 
-sendemail.signedoffcc (deprecated)::
+sendemail.signedoffcc (deprecated):: // bugreport-exclude
 	Deprecated alias for `sendemail.signedoffbycc`.
 
-sendemail.smtpBatchSize::
+sendemail.smtpBatchSize:: // bugreport-include
 	Number of messages to be sent per connection, after that a relogin
 	will happen.  If the value is 0 or undefined, send all messages in
 	one connection.
 	See also the `--batch-size` option of linkgit:git-send-email[1].
 
-sendemail.smtpReloginDelay::
+sendemail.smtpReloginDelay:: // bugreport-include
 	Seconds wait before reconnecting to smtp server.
 	See also the `--relogin-delay` option of linkgit:git-send-email[1].
diff --git a/Makefile b/Makefile
index 69801a1c45..a62bbefb8f 100644
--- a/Makefile
+++ b/Makefile
@@ -639,6 +639,10 @@ SCRIPT_PYTHON += git-p4.py
 SCRIPT_SH_GEN = $(patsubst %.sh,%,$(SCRIPT_SH))
 SCRIPT_PERL_GEN = $(patsubst %.perl,%,$(SCRIPT_PERL))
 SCRIPT_PYTHON_GEN = $(patsubst %.py,%,$(SCRIPT_PYTHON))
+SCRIPT_DEPENDENCIES = git-bugreport-config-whitelist
+
+$(SCRIPT_DEPENDENCIES): Documentation/config/*.txt
+	sh bugreport-generate-config-whitelist.sh
 
 # Individual rules to allow e.g.
 # "make -C ../.. SCRIPT_PERL=contrib/foo/bar.perl build-perl-script"
@@ -656,17 +660,20 @@ install-perl-script: $(SCRIPT_PERL_GEN)
 install-python-script: $(SCRIPT_PYTHON_GEN)
 	$(INSTALL) $^ '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
 
-.PHONY: clean-perl-script clean-sh-script clean-python-script
+.PHONY: clean-perl-script clean-sh-script clean-python-script clean-script-dependencies
 clean-sh-script:
 	$(RM) $(SCRIPT_SH_GEN)
 clean-perl-script:
 	$(RM) $(SCRIPT_PERL_GEN)
 clean-python-script:
 	$(RM) $(SCRIPT_PYTHON_GEN)
+clean-script-dependencies:
+	$(RM) $(SCRIPT_DEPENDENCIES)
 
 SCRIPTS = $(SCRIPT_SH_GEN) \
 	  $(SCRIPT_PERL_GEN) \
 	  $(SCRIPT_PYTHON_GEN) \
+	  $(SCRIPT_DEPENDENCIES) \
 	  git-instaweb
 
 ETAGS_TARGET = TAGS
diff --git a/bugreport-generate-config-whitelist.sh b/bugreport-generate-config-whitelist.sh
new file mode 100755
index 0000000000..ca6b232024
--- /dev/null
+++ b/bugreport-generate-config-whitelist.sh
@@ -0,0 +1,4 @@
+#!/bin/sh
+
+grep -RhPo ".*(?=:: \/\/ bugreport-include)" Documentation/config \
+  >git-bugreport-config-whitelist
diff --git a/git-bugreport-config-whitelist b/git-bugreport-config-whitelist
deleted file mode 100644
index e4f07f7175..0000000000
--- a/git-bugreport-config-whitelist
+++ /dev/null
@@ -1,22 +0,0 @@
-http.version
-protocol.version
-protocol.persistent-https.allow
-protocol.rpc.allow
-protocol.sso.allow
-submodule.repolike
-trace2.eventtarget
-trace2.configparams
-color.ui
-core.pager
-sendemail.smtpencryption
-sendemail.smtpserver
-sendemail.smtpserverport
-sendemail.smtpsslcertpath
-credential.helper
-merge.tool
-grep.linenumber
-rerere.enabled
-core.repositoryformatversion
-core.filemode
-core.bare
-core.logallrefupdates
-- 
2.23.0.rc1.153.gdeed80330f-goog

