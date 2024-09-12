Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E81418BBB5
	for <git@vger.kernel.org>; Thu, 12 Sep 2024 10:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726136283; cv=none; b=toZIhROhrfJzDOG9e9j3Vt87FZzIVX7L7EqwDZma20usdKi51BQn4vBJwIIrsd/DcAnFf47DLpxHkfZoVq3X90HNcQLZ6g5NI2g6wXO7fqoBn08oLp+uPO+7hVZKrq2s1piI7wL+yx1DQE7ckIt68e2TT8luMnnFtYUxzmNaHj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726136283; c=relaxed/simple;
	bh=MY/fQFiSXmLF9NRA9dicawGvZbdq13BJoyle9QMtGhU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=NO0JOHOkQTEtf5hjaTxX1ABpZo6RElMpkXxJmw38rRlI1ofk2wu04ozW+0pgUy/Z5dFMQ21RfY/TzcRGha3sXtjYXJQXAJublFfTuU5w5fNBeIJ+bNyxNhLIzCKfL/1+lkkFhm/i6LMFGLdtJO62Ezf7egP8suUeCa9UhIFvCqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rjaaworl; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rjaaworl"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5c3c3b63135so796348a12.3
        for <git@vger.kernel.org>; Thu, 12 Sep 2024 03:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726136280; x=1726741080; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4CIQFjzeo/YKh3mXIZcqYoLIvS6YvXWQ044yeL1GfoY=;
        b=RjaaworleDDNUdfXWo/3UXzTAQBHvbnaHeAgMXd1HzXcmIe8T91Ea5IpoIKg7HDit1
         iOw8RIpO5jNRq5N028pmXUgroKyxNmCqrBHpM8BibSPii2wk/Chium5ZTL0jN0iKPuhS
         EY8sXVpWEE+CYf1+rqN44FyFKX0iTbcE/hkRAjo/rJNJpAXJtACEDj//RcbM2BcdoXqn
         jlT3ZP1XzmpRV+eisv8x8x3bTH4NO2kFdECYfW2Zl4k9KpXXa0iA3iwEPh9a69YRbnJt
         5JuudrPvwsuMF1LPfNDC3hdLNX5BlABKpeGa7MLd4HUN4QeybYOrZ23UECbauMitx0iI
         zNqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726136280; x=1726741080;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4CIQFjzeo/YKh3mXIZcqYoLIvS6YvXWQ044yeL1GfoY=;
        b=SDGPzFdVMN3vpgMk5PnPldf2lExV7jlPSF5mMGeXIur5H5n2nu5DK0ND3JUIqXXL1s
         54CtELofrZjpLqgEKGjFDqJ2bILrsizvf6zCnYiZUASGxnCYA0dDa0eoY1kmtaZ/OBr/
         1+BdvbuV4FpHvGz2N9PMeAbcgj/pBPKnlFDJcrhsNj49aWTroodeRFJimTJHbBwTzecN
         agbqgOL1dtGqPM9rzjBLCZw3/BwMY71luype7PKOM+fNfflZQXiHgzRkYKfgkijQE3xE
         OvqSaX1G/+w2YWEIdNtAA2oo5sZcUzUGStQ8T/oNIP/TdmVEOWval1ZgjB6oww6Oevpv
         omsQ==
X-Gm-Message-State: AOJu0Ywkq7UM/M/sfm9XbdiYQUszfwRuJvzeMsRNsXC2sEctPg0SimIw
	IyIu5Y0JJ7mBp7hwCQWRAeFAnh2B1v1m2mMkPqwAVSWgGDOwtnDgHFxmbg==
X-Google-Smtp-Source: AGHT+IF+9wSM3XU3/yEJvvmLnOkt58PhREJoQjzfGKrHC9wDglQ8O8WI39/4J5vQH9jJ+Ks5Kz4kHA==
X-Received: by 2002:a17:907:6e9f:b0:a8d:42c3:5f68 with SMTP id a640c23a62f3a-a902947eb28mr182554466b.23.1726136279239;
        Thu, 12 Sep 2024 03:17:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25c62485sm724428066b.104.2024.09.12.03.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 03:17:58 -0700 (PDT)
Message-Id: <pull.1773.v5.git.1726136277300.gitgitgadget@gmail.com>
In-Reply-To: <pull.1773.v4.git.1726064619705.gitgitgadget@gmail.com>
References: <pull.1773.v4.git.1726064619705.gitgitgadget@gmail.com>
From: "ToBoMi via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 12 Sep 2024 10:17:57 +0000
Subject: [PATCH v5] git gui: add directly calling merge tool from
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
    
    Changes since v4:
    
     * Removed trailing whitespace

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1773%2FToBoMi%2Fadd_merge_tool_from_config_file-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1773/ToBoMi/add_merge_tool_from_config_file-v5
Pull-Request: https://github.com/gitgitgadget/git/pull/1773

Range-diff vs v4:

 1:  b5db8997b76 ! 1:  c37db60c218 git gui: add directly calling merge tool from configuration
     @@ git-gui/lib/mergetool.tcl: proc merge_resolve_tool2 {} {
      +			}
      +		} else {
      +			error_popup [mc "Unsupported merge tool '%s'.
     -+							
     ++
      +To use this tool, configure \"mergetool.%s.cmd\" as shown in the git-config\
      +manual page." $tool $tool]
      +			return


 git-gui/lib/mergetool.tcl | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/git-gui/lib/mergetool.tcl b/git-gui/lib/mergetool.tcl
index e688b016ef6..50ed530cbdb 100644
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
