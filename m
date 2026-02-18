Received: from ste-pvt-msa1.bahnhof.se (ste-pvt-msa1.bahnhof.se [213.80.101.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C642333DEF6
	for <git@vger.kernel.org>; Wed, 18 Feb 2026 14:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.80.101.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771426371; cv=none; b=lizDxSTd83CuLq+GlxKDIJNUBVS8qzBTWcwSpZgyjv7f0LOXL7OI4shRrFn57vsifpigMHzPBjzgIF1JKiZIFrwhyy/g6eVM14zmyqqBNBgY+9djgZ1oBvm4NUnXfjW0Fduev2zy9hfOodSHn8kuQU15vllw1NPAhlQuXBYS7cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771426371; c=relaxed/simple;
	bh=cab4zgJTB4S+raOYDnKq/awxdIckwvkR4q414fMyOmA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=faRUS2BksEXaEifW3iq2rwreJ9A6+7Yt2Bf5sQQ1Y87o2nBEvygcogd2K1zMDxNFYfccDvNzG/Q2wVSW+kScvTFiKG0f49GR3YwMoABF9SHh4kALJGg3+9Bnc9ZIU3i2uHVIaWnJTOUTgmaIT6G4eR1BF1z9suoTCkz9I1PWNxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jontes.page; spf=pass smtp.mailfrom=jontes.page; dkim=pass (2048-bit key) header.d=jontes.page header.i=@jontes.page header.b=DCJ66kTR; arc=none smtp.client-ip=213.80.101.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jontes.page
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jontes.page
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jontes.page header.i=@jontes.page header.b="DCJ66kTR"
Received: from localhost (localhost [127.0.0.1])
	by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTP id 882023F8E3;
	Wed, 18 Feb 2026 15:52:41 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Authentication-Results: ste-pvt-msa1.bahnhof.se (amavisd-new);
	dkim=pass (2048-bit key) header.d=jontes.page
Received: from ste-pvt-msa1.bahnhof.se ([127.0.0.1])
	by localhost (ste-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id A_xwizThGAbY; Wed, 18 Feb 2026 15:52:40 +0100 (CET)
Received: 
	by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id AC5BD3F7E4;
	Wed, 18 Feb 2026 15:52:40 +0100 (CET)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 31903B1E70;
	Wed, 18 Feb 2026 15:51:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jontes.page; s=dkim;
	t=1771426292; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=dxCvRpjFt7uFpyqXutxhD65WiLUDWrmrBm2UWcq3Ccw=;
	b=DCJ66kTRVqB3+xFXCdSF4ST+7lrKlj+D/kII7mSAV5XHNjcpGd0EE9Af8r08Nju+eI5c6H
	SDbGlHxSzboltFhvj9bQWwnhgMiWDLpHjjn8OCbhSnCj5xRyHCEpHTkpHjimdOCWRQmFwh
	h7JfqbKbxZGisNwgQmsTcsoR/YtQuch6qQD51hP3Hq0DC69qqAu+Mu/UqBzruxrQzUmzOD
	X1zzek4T/jkPFL/yYc+ArPCAqZlZTAf2kuHFlbOSszqx6POFhTtoiX98+ZG17MZHQSnHxv
	FQ2jdvNhrzOF0/8aPErXF58YffsAXPjpx60/wfIReK9AsZwCFcYjHtv7Yu19LQ==
From: Jonatan Holmgren <jonatan@jontes.page>
To: git@vger.kernel.org
Cc: peff@peff.net,
	gitster@pobox.com,
	"D . Ben Knoble" <benknoble@gmail.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Jonatan Holmgren <jonatan@jontes.page>
Subject: [PATCH v6 4/4] completion: fix zsh alias listing for subsection aliases
Date: Wed, 18 Feb 2026 15:52:14 +0100
Message-ID: <20260218145214.581460-5-jonatan@jontes.page>
X-Mailer: git-send-email 2.53.0.122.g3abf75d576
In-Reply-To: <20260218145214.581460-1-jonatan@jontes.page>
References: <3124b359-2929-4f3f-9ac6-793277fe422b@jontes.page>
 <20260218145214.581460-1-jonatan@jontes.page>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

The zsh completion function __git_zsh_cmd_alias() uses 'git config
--get-regexp' to enumerate aliases and then strips the "alias." prefix
from each key. For subsection-style aliases (alias.name.command), this
leaves "name.command" as the completion candidate instead of just
"name".

The bash completion does not have this problem because it goes through
'git --list-cmds=alias', which calls list_aliases() in C and already
handles both alias syntaxes correctly. However, zsh needs both the
alias name and its value for descriptive completion, which
--list-cmds=alias does not provide.

Add a hidden --aliases-for-completion option to 'git help', following
the existing --config-for-completion pattern. It outputs NUL-separated
"name\nvalue" pairs using list_aliases(), which correctly resolves both
the traditional (alias.name) and subsection (alias.name.command)
formats. Update __git_zsh_cmd_alias() to use it.

Signed-off-by: Jonatan Holmgren <jonatan@jontes.page>
---
 builtin/help.c                        | 13 +++++++++++++
 contrib/completion/git-completion.zsh |  2 +-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/builtin/help.c b/builtin/help.c
index c09cbc8912..2db41d0b55 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -54,6 +54,7 @@ static enum help_action {
 	HELP_ACTION_DEVELOPER_INTERFACES,
 	HELP_ACTION_CONFIG_FOR_COMPLETION,
 	HELP_ACTION_CONFIG_SECTIONS_FOR_COMPLETION,
+	HELP_ACTION_ALIASES_FOR_COMPLETION,
 } cmd_mode;
 
 static char *html_path;
@@ -90,6 +91,8 @@ static struct option builtin_help_options[] = {
 		    HELP_ACTION_CONFIG_FOR_COMPLETION, PARSE_OPT_HIDDEN),
 	OPT_CMDMODE_F(0, "config-sections-for-completion", &cmd_mode, "",
 		    HELP_ACTION_CONFIG_SECTIONS_FOR_COMPLETION, PARSE_OPT_HIDDEN),
+	OPT_CMDMODE_F(0, "aliases-for-completion", &cmd_mode, "",
+		    HELP_ACTION_ALIASES_FOR_COMPLETION, PARSE_OPT_HIDDEN),
 
 	OPT_END(),
 };
@@ -691,6 +694,16 @@ int cmd_help(int argc,
 			       help_format);
 		list_config_help(SHOW_CONFIG_SECTIONS);
 		return 0;
+	case HELP_ACTION_ALIASES_FOR_COMPLETION: {
+		struct string_list alias_list = STRING_LIST_INIT_DUP;
+		opt_mode_usage(argc, "--aliases-for-completion", help_format);
+		list_aliases(&alias_list);
+		for (size_t i = 0; i < alias_list.nr; i++)
+			printf("%s%c%s%c", alias_list.items[i].string, '\0',
+			       (char *)alias_list.items[i].util, '\0');
+		string_list_clear(&alias_list, 1);
+		return 0;
+	}
 	case HELP_ACTION_CONFIG:
 		opt_mode_usage(argc, "--config", help_format);
 		setup_pager(the_repository);
diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index f5877bd7a1..c32186a977 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -202,7 +202,7 @@ __git_zsh_cmd_common ()
 __git_zsh_cmd_alias ()
 {
 	local -a list
-	list=(${${(0)"$(git config -z --get-regexp '^alias\.*')"}#alias.})
+	list=(${(0)"$(git help --aliases-for-completion)"})
 	list=(${(f)"$(printf "%s:alias for '%s'\n" ${(f@)list})"})
 	_describe -t alias-commands 'aliases' list && _ret=0
 }
-- 
2.53.0.122.g591c997fb5.dirty

