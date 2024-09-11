Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6F25A117
	for <git@vger.kernel.org>; Wed, 11 Sep 2024 14:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726064626; cv=none; b=iPOL1azzYDv8eUDCr0xGoz9NE5W3QDdY4gnzFSC3CyBJ5kFyMgle5bfRrF7U260fDwuztNEscTJeLW++ZXmZ0/xP3mqFUl2F+MxHZ0c75i/TwpwI13FWJPoHA2wMnh1QoQsiOLe6WW/VA6qzwc7Qq2otMt3IuEoVVYzwXWU1xSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726064626; c=relaxed/simple;
	bh=XQXjAHnjh2gaRbUUsNWrnNZFmqqSUaWTMnt0ITwQg4w=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=uDT/4tcJlA1r6VtCC1w0GwjtjB+L9guTavg+BVES4XNlC8l/zkgUKrLdzZgaHVzEX38LV+SGW19Py/Z86QrBJrI7HdKzNrqrkKX8zwIAkxbT1N2La1CTQhxG5vtODpIwvdCSCIj3aRmC3WpnqgJFNYMCKUF8qYH/G5vWwBAvLiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YZ/9H69K; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YZ/9H69K"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a8b155b5e9eso271016866b.1
        for <git@vger.kernel.org>; Wed, 11 Sep 2024 07:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726064622; x=1726669422; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kJQhSsLLvRtXo+TBamERqjhix1cLycG6FLv6mdNN/gs=;
        b=YZ/9H69KMbJGDgCAPu377qyJmrxuKyP+8XHWZ3qING0oSgTC7HH2J2KH9bfgs/bXfv
         OjOXRrltg6VRhHJWKWVJolTgMsMCYTep5g8gV4o+iJLVPhL3CdRaa3RCev0RmZRASpeG
         Mv/Hmloa/xIUOmXaTvyZFclVrbrUG9/sJLAE/q7WCMW4yiHEv6HeZNK9qJMoMRME90gD
         O8Jcz9kh3FpX991EH8Md6/Fj9JmNVoAmZlMRdcPxU6GhX5wNLNi0AAsKaCYYDCDhENl4
         bupUAW0ZqdKCCruDtF72s4eiRs5ZEift2DSLfQd7s726oBH5AiCyFk/PAwAm0nli1Aow
         EnGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726064622; x=1726669422;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kJQhSsLLvRtXo+TBamERqjhix1cLycG6FLv6mdNN/gs=;
        b=V7Feoq7ypifx4/O71+w83gGcPVlHblO7GZ8o/Tpqt3Q9QluMq8BVsxFpf+5xsdTMTe
         hMrTSeJlqyXOJB2feR4fZwIXZZ/XV4WDzxz7++EB5Otiec92k623jIcSvmbIglLMtWEK
         YkcNoKXnOD3la2wnQwYkjK8rbkcn/9+8Z+KZ6QI4ElUdFWoJzGQWOVJKsO0kj5jutWGr
         PUAeDOUvNUKKyEAmmjIWVn4P2wFSixjzJhnX5D4Spg5TdRUlF9cj5WH7vbF8Mq1LJb4m
         JL0GueYJJVdFVIUu43Uus4MaffenNXUDArJCvtv5Sy9dIZYzA6m3rmt1atBJ4d1rCTtj
         By9g==
X-Gm-Message-State: AOJu0YzFQdWCsL5zIkPNuwxYXz17R6chHCnqR51RpY/Q9OQoTXdWEeqP
	YzGXq1TY1zDSQgwOIltQDR5VX3zu9fklLaIG6zEw3iad/faNeVH2hTmwAg==
X-Google-Smtp-Source: AGHT+IEr26TkMMlBUEuw0utfVuD0ipceX+31RVKoMPmiKNhclz4jBWu653JXnBZgaG5RhZUQnA5/qg==
X-Received: by 2002:a17:907:94c5:b0:a8a:1ffe:70f1 with SMTP id a640c23a62f3a-a9004a46f0amr290727566b.50.1726064621377;
        Wed, 11 Sep 2024 07:23:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25c62511sm622661466b.130.2024.09.11.07.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 07:23:40 -0700 (PDT)
Message-Id: <pull.1773.v4.git.1726064619705.gitgitgadget@gmail.com>
In-Reply-To: <pull.1773.v3.git.1725607643479.gitgitgadget@gmail.com>
References: <pull.1773.v3.git.1725607643479.gitgitgadget@gmail.com>
From: "ToBoMi via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 11 Sep 2024 14:23:39 +0000
Subject: [PATCH v4] git gui: add directly calling merge tool from
 configuration
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Johannes Sixt <j6t@kdbg.org>,
    ToBoMi <tobias.boesch@miele.com>,
    Tobias Boesch <tobias.boesch@miele.com>

From: Tobias Boesch <tobias.boesch@miele.com>

git gui can open a merge tool when conflicts are detected (Right click
in the diff of the file with conflicts).
The merge tools that are allowed to use are hard coded into git gui.

If one wants to add a new merge tool it has to be added to git gui
through a source code change.
This is not convenient in comparison to how it works in git (without gui).

git itself has configuration options for a merge tools path and command
in the git configuration.
New merge tools can be set up there without a source code change.

Those options are used only by pure git in contrast to git gui. git calls
the configured merge tools directly from the configuration while git Gui
doesn't.

With this change git gui can call merge tools configured in the
configuration directly without a change in git gui source code.
It needs a configured "merge.tool" and a configured
"mergetool.<mergetool name>.cmd" configuration entry as shown in the
git-config manual page.

Configuration example:
[merge]
	tool = vscode
[mergetool "vscode"]
	path = the/path/to/Code.exe
	cmd = \"Code.exe\" --wait --merge \"$LOCAL\" \"$REMOTE\" \"$BASE\" \"$MERGED\"

Without the "mergetool.cmd" configuration and an unsupported "merge.tool"
entry, git gui behaves mainly as before this change and informs the user
about an unsupported merge tool. In addtition it also shows a hint to add
a configuration entry to use the tool as an unsupported tool with degraded
support.

If a wrong "mergetool.cmd" is configured by accident, it gets handled
by git gui already. In this case git gui informs the user that the merge
tool couldn't be opened. This behavior is preserved by this change and
should not change.

"Beyond Compare 3" and "Visual Studio Code" were tested as manually
configured merge tools.

Signed-off-by: Tobias Boesch <tobias.boesch@miele.com>
---
    git gui: add directly calling merge tool from gitconfig
    
    cc: Johannes Sixt j6t@kdbg.org
    
    Changes since v1:
    
     * Used existing option mergetool.cmd in gitconfig to trigger the direct
       call of the merge tool configured in the config instead adding a new
       option mergeToolFromConfig
     * Removed assignment of merge tool path to a variable and reused the
       already existing one: merget_tool_path
     * Changed formatting of the commit message
     * Added more context and an examples to the commit message
    
    Changes since v2:
    
     * Changed commit ident
     * Added hint to add a mergetool as an unsupprted tool
     * Minor typos
     * Highlighted proper nouns in commit message
     * Only using mergetool.cmd now - not using mergetool.path anymore
     * Removed gitconfig term in user message
     * Changed lines length of commit message
     * tcl commands in mergetool.cmd are now detected and not executed
       anymore
     * mergetool.cmd string parts are now substituted as list, not as a
       whole string
     * Made a more clear user hint on how to configure an unsupported
       mergetool
    
    Changes since v3:
    
     * Corrected wrong configuration option in commit message
     * Replaced "config" and "gitconfig" with "configuration" in commit
       message
     * Initialised cmdline list before appending values in loop
     * Removed hint that unsupported tools have degraded support
     * Changed popup message formatting in the popup and in the source code

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1773%2FToBoMi%2Fadd_merge_tool_from_config_file-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1773/ToBoMi/add_merge_tool_from_config_file-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/1773

Range-diff vs v3:

 1:  c8c0107ddc5 ! 1:  b5db8997b76 git gui: add directly calling merge tool from gitconfig
     @@ Metadata
      Author: Tobias Boesch <tobias.boesch@miele.com>
      
       ## Commit message ##
     -    git gui: add directly calling merge tool from gitconfig
     +    git gui: add directly calling merge tool from configuration
      
          git gui can open a merge tool when conflicts are detected (Right click
          in the diff of the file with conflicts).
     @@ Commit message
          This is not convenient in comparison to how it works in git (without gui).
      
          git itself has configuration options for a merge tools path and command
     -    in the git config.
     +    in the git configuration.
          New merge tools can be set up there without a source code change.
      
          Those options are used only by pure git in contrast to git gui. git calls
     -    the configured merge tools directly from the config while git Gui doesn't.
     +    the configured merge tools directly from the configuration while git Gui
     +    doesn't.
      
     -    With this change git gui can call merge tools configured in the gitconfig
     -    directly without a change in git gui source code.
     -    It needs a configured merge.tool and a configured mergetool.cmd config
     -    entry.
     +    With this change git gui can call merge tools configured in the
     +    configuration directly without a change in git gui source code.
     +    It needs a configured "merge.tool" and a configured
     +    "mergetool.<mergetool name>.cmd" configuration entry as shown in the
     +    git-config manual page.
      
     -    gitconfig example:
     +    Configuration example:
          [merge]
                  tool = vscode
          [mergetool "vscode"]
                  path = the/path/to/Code.exe
                  cmd = \"Code.exe\" --wait --merge \"$LOCAL\" \"$REMOTE\" \"$BASE\" \"$MERGED\"
      
     -    Without the mergetool.cmd configuration and an unsupported merge.tool
     +    Without the "mergetool.cmd" configuration and an unsupported "merge.tool"
          entry, git gui behaves mainly as before this change and informs the user
          about an unsupported merge tool. In addtition it also shows a hint to add
     -    a config entry to use the tool as an unsupported tool with degraded
     +    a configuration entry to use the tool as an unsupported tool with degraded
          support.
      
     -    If a wrong mergetool.cmd is configured by accident, it gets handled
     +    If a wrong "mergetool.cmd" is configured by accident, it gets handled
          by git gui already. In this case git gui informs the user that the merge
          tool couldn't be opened. This behavior is preserved by this change and
          should not change.
     @@ git-gui/lib/mergetool.tcl: proc merge_resolve_tool2 {} {
      +		set tool_cmd [get_config mergetool.$tool.cmd]
      +		if {$tool_cmd ne {}} {
      +			if {([string first {[} $tool_cmd] != -1) || ([string first {]} $tool_cmd] != -1)} {
     -+				error_popup [mc "Unable to process square brackets in mergetool.cmd configuration option.\
     -+								Please remove the square brackets."]
     ++				error_popup [mc "Unable to process square brackets in mergetool.$tool.cmd configuration option.
     ++
     ++Please remove the square brackets."]
      +				return
      +			} else {
     ++				set cmdline {}
      +				foreach command_part $tool_cmd {
      +					lappend cmdline [subst -nobackslashes -nocommands $command_part]
      +				}
      +			}
      +		} else {
     -+			error_popup [mc "Unsupported merge tool '%s'.\n
     -+							Currently unsupported tools can be added and used as unsupported tools with degraded support\
     -+							by adding the command of the tool to the \"mergetool.cmd\" option in the config.
     -+							See the configuration documentation for more details." $tool]
     ++			error_popup [mc "Unsupported merge tool '%s'.
     ++							
     ++To use this tool, configure \"mergetool.%s.cmd\" as shown in the git-config\
     ++manual page." $tool $tool]
      +			return
      +		}
       	}


 git-gui/lib/mergetool.tcl | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/git-gui/lib/mergetool.tcl b/git-gui/lib/mergetool.tcl
index e688b016ef6..2afc875ea0a 100644
--- a/git-gui/lib/mergetool.tcl
+++ b/git-gui/lib/mergetool.tcl
@@ -272,8 +272,26 @@ proc merge_resolve_tool2 {} {
 		}
 	}
 	default {
-		error_popup [mc "Unsupported merge tool '%s'" $tool]
-		return
+		set tool_cmd [get_config mergetool.$tool.cmd]
+		if {$tool_cmd ne {}} {
+			if {([string first {[} $tool_cmd] != -1) || ([string first {]} $tool_cmd] != -1)} {
+				error_popup [mc "Unable to process square brackets in mergetool.$tool.cmd configuration option.
+
+Please remove the square brackets."]
+				return
+			} else {
+				set cmdline {}
+				foreach command_part $tool_cmd {
+					lappend cmdline [subst -nobackslashes -nocommands $command_part]
+				}
+			}
+		} else {
+			error_popup [mc "Unsupported merge tool '%s'.
+							
+To use this tool, configure \"mergetool.%s.cmd\" as shown in the git-config\
+manual page." $tool $tool]
+			return
+		}
 	}
 	}
 

base-commit: c5ee8f2d1c9d336e0a46139bd35236d4a0bb93ff
-- 
gitgitgadget
