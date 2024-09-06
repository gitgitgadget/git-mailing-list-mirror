Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B494314A630
	for <git@vger.kernel.org>; Fri,  6 Sep 2024 07:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725607649; cv=none; b=tCKY0QB1XFDTiE7wKKkD43XXbZ/R3e5uXCEDJixkyrUvhxtLxAzF/wfOiN9cvVmciJC7oYjlQCdLWQlPxsxsdxx0tZcgbRMXuQyXRjZPJHir2v47h4WRbkrOHlI5SVTjw8c8oEjZVKFrBpgK5T+8hccU/EP7u7lUYY64v5/T28g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725607649; c=relaxed/simple;
	bh=o7/4ElhgJx2cit54n3g5GctBWSsdfl1MdKIIVmH3SbQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=QNT+kvKFd1tg4tM4CvuYDL/sAZVtLlC+alMVwDlHZ/p5XpDqRFBjX2Xz6bVPOdGBwPU4Rzxd9WbJpJwC0HBb9VRdU9v0XIyY/5swt+Au1EHq8JPe1cowiNWj8XD+aCMrwgdeq2ta4QNG6qvBtQ6QW7ZaNMMuZtpRTgSBG823R5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=biV/dViB; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="biV/dViB"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a8a6d1766a7so178588666b.3
        for <git@vger.kernel.org>; Fri, 06 Sep 2024 00:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725607646; x=1726212446; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A0FbVKvEILQSC6pRDQwiEyC7FPizLXbQlnFvT+xiHZI=;
        b=biV/dViBQqF61LKZq7+gugSNW/oH6irQhKyLiIIQUTida3IeFjgy4KFYWuzYiDZ63i
         rwP2qaGmYJfKt4jZ6HEFhJsX3XYalcD1NzbQmC9lReLlMfhrFHY1gR1y1bnLJEvjxiWC
         INIRBawHU9dvWb/FBsvCvqY8B8EL6jP39x7zKlRbkhuduceimkyvsVbzW8chLwdEeDCc
         dVRfZF9bfXcEGKhq/Se1Orx+Sk73tWwPifkQqgFTBFB+WNu9YBARdEWlH9jkMzfYjoNQ
         ImTesIAfbAu5AR6Uy9Hedf/V4ncdaJ1MtfswrRiGSDvYR1r/9GfmskjHWoff8gPwkpVT
         GBuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725607646; x=1726212446;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A0FbVKvEILQSC6pRDQwiEyC7FPizLXbQlnFvT+xiHZI=;
        b=q+rcf6VBPMCc22ztDc3vsaMBqkGD4znf9gCtWLq5jnlOuCzb52iFrLa18R4yImasPv
         Bvj54C8kU3gRod6uwRXJP4DZ84Pgj1w/HjI1aGzV7MGC3FbPfjRiHm20QRg3nETlkBQB
         JSU0x3zGuaPGhUAUS+xGxmH+UlVtH+Hwif9Bn9csQ3M75mR+5L/v/985y3KzFSrMGGF0
         7O+iTNvy0mDlq8w5z6InOdCFKJWPVU4wXYsICXadxmz67i1HvjFIDfaw0Fj1ynVLBOyG
         GNJSJ/HKBv0dzsTingdrC3zAdma4iiuALjdO/pvXMFB9qoPFddobMJMNP5qdCqObXvsw
         RRrg==
X-Gm-Message-State: AOJu0Yzmd5J57GsXDGY3SxpMHiVJo4uAB+ASx/k4pc15B5S27V4YX3dM
	pJZr/BrJi4IdF2UVdzftOFbxWRZRx5ZQ9JWkPMtQd4yJXHsmtOuaHeTfeA==
X-Google-Smtp-Source: AGHT+IEWMhbVtDBr/ZrCNr4C0BjQvgomvV2iGCOz9ye9WRGlCf6PNjupK88pNzuvbfrNP2xrbN7H9w==
X-Received: by 2002:a17:907:3e05:b0:a86:8f7b:9f19 with SMTP id a640c23a62f3a-a8a88858b09mr122198966b.52.1725607644971;
        Fri, 06 Sep 2024 00:27:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8a61fbaf2dsm235162166b.30.2024.09.06.00.27.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 00:27:24 -0700 (PDT)
Message-Id: <pull.1773.v3.git.1725607643479.gitgitgadget@gmail.com>
In-Reply-To: <pull.1773.v2.git.1724833917245.gitgitgadget@gmail.com>
References: <pull.1773.v2.git.1724833917245.gitgitgadget@gmail.com>
From: "ToBoMi via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 06 Sep 2024 07:27:23 +0000
Subject: [PATCH v3] git gui: add directly calling merge tool from gitconfig
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
in the git config.
New merge tools can be set up there without a source code change.

Those options are used only by pure git in contrast to git gui. git calls
the configured merge tools directly from the config while git Gui doesn't.

With this change git gui can call merge tools configured in the gitconfig
directly without a change in git gui source code.
It needs a configured merge.tool and a configured mergetool.cmd config
entry.

gitconfig example:
[merge]
	tool = vscode
[mergetool "vscode"]
	path = the/path/to/Code.exe
	cmd = \"Code.exe\" --wait --merge \"$LOCAL\" \"$REMOTE\" \"$BASE\" \"$MERGED\"

Without the mergetool.cmd configuration and an unsupported merge.tool
entry, git gui behaves mainly as before this change and informs the user
about an unsupported merge tool. In addtition it also shows a hint to add
a config entry to use the tool as an unsupported tool with degraded
support.

If a wrong mergetool.cmd is configured by accident, it gets handled
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

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1773%2FToBoMi%2Fadd_merge_tool_from_config_file-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1773/ToBoMi/add_merge_tool_from_config_file-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1773

Range-diff vs v2:

 1:  e77d6dec6c5 ! 1:  c8c0107ddc5 git gui: add directly calling merge tool from gitconfig
     @@
       ## Metadata ##
     -Author: deboeto <tobias.boesch@miele.com>
     +Author: Tobias Boesch <tobias.boesch@miele.com>
      
       ## Commit message ##
          git gui: add directly calling merge tool from gitconfig
      
     -    git gui can open a merge tool when conflicts are
     -    detected (Right click in the diff of the file with
     -    conflicts).
     -    The merge tools that are allowed to
     -    use are hard coded into git gui.
     +    git gui can open a merge tool when conflicts are detected (Right click
     +    in the diff of the file with conflicts).
     +    The merge tools that are allowed to use are hard coded into git gui.
      
     -    If one wants to add a new merge tool it has to be
     -    added to git gui through a source code change.
     -    This is not convenient in comparison to how it
     -    works in git (without gui).
     +    If one wants to add a new merge tool it has to be added to git gui
     +    through a source code change.
     +    This is not convenient in comparison to how it works in git (without gui).
      
     -    git itself has configuration options for a merge tools
     -    path and command in the git config.
     -    New merge tools can be set up there without a
     -    source code change.
     +    git itself has configuration options for a merge tools path and command
     +    in the git config.
     +    New merge tools can be set up there without a source code change.
      
     -    Those options are used only by pure git in
     -    contrast to git gui. git calls the configured
     -    merge tools directly from the config while git
     -    Gui doesn't.
     +    Those options are used only by pure git in contrast to git gui. git calls
     +    the configured merge tools directly from the config while git Gui doesn't.
      
     -    With this change git gui can call merge tools
     -    configured in the gitconfig directly without a
     -    change in git gui source code.
     -    It needs a configured merge.tool and a configured
     -    mergetool.cmd config entry.
     +    With this change git gui can call merge tools configured in the gitconfig
     +    directly without a change in git gui source code.
     +    It needs a configured merge.tool and a configured mergetool.cmd config
     +    entry.
      
          gitconfig example:
          [merge]
     @@ Commit message
                  path = the/path/to/Code.exe
                  cmd = \"Code.exe\" --wait --merge \"$LOCAL\" \"$REMOTE\" \"$BASE\" \"$MERGED\"
      
     -    Without the mergetool.cmd configuration and an
     -    unsupported merge.tool entry, git gui behaves
     -    mainly as before this change and informs the user
     -    about an unsupported merge tool, but now also
     -    shows a hint to add a config entry for the tool
     -    in gitconfig.
     +    Without the mergetool.cmd configuration and an unsupported merge.tool
     +    entry, git gui behaves mainly as before this change and informs the user
     +    about an unsupported merge tool. In addtition it also shows a hint to add
     +    a config entry to use the tool as an unsupported tool with degraded
     +    support.
      
     -    If a wrong mergetool.cmd is configured by accident
     -    it is beeing handled by git gui already. In this
     -    case git gui informs the user that the merge tool
     -    couldn't be opened. This behavior is preserved by
     -    this change and should not change.
     +    If a wrong mergetool.cmd is configured by accident, it gets handled
     +    by git gui already. In this case git gui informs the user that the merge
     +    tool couldn't be opened. This behavior is preserved by this change and
     +    should not change.
      
     -    Beyond compare 3 and Visual Studio code were
     -    tested as manually configured merge tools.
     +    "Beyond Compare 3" and "Visual Studio Code" were tested as manually
     +    configured merge tools.
      
          Signed-off-by: Tobias Boesch <tobias.boesch@miele.com>
      
     @@ git-gui/lib/mergetool.tcl: proc merge_resolve_tool2 {} {
      -		return
      +		set tool_cmd [get_config mergetool.$tool.cmd]
      +		if {$tool_cmd ne {}} {
     -+			set tool_cmd_file_vars_resolved [subst -nobackslashes -nocommands $tool_cmd]
     -+			set cmdline [lreplace $tool_cmd_file_vars_resolved 0 0 $merge_tool_path]
     ++			if {([string first {[} $tool_cmd] != -1) || ([string first {]} $tool_cmd] != -1)} {
     ++				error_popup [mc "Unable to process square brackets in mergetool.cmd configuration option.\
     ++								Please remove the square brackets."]
     ++				return
     ++			} else {
     ++				foreach command_part $tool_cmd {
     ++					lappend cmdline [subst -nobackslashes -nocommands $command_part]
     ++				}
     ++			}
      +		} else {
     -+			error_popup [mc "Unsupported merge tool '%s'. Is the tool command and path configured properly in gitconfig?" $tool]
     ++			error_popup [mc "Unsupported merge tool '%s'.\n
     ++							Currently unsupported tools can be added and used as unsupported tools with degraded support\
     ++							by adding the command of the tool to the \"mergetool.cmd\" option in the config.
     ++							See the configuration documentation for more details." $tool]
      +			return
      +		}
       	}


 git-gui/lib/mergetool.tcl | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/git-gui/lib/mergetool.tcl b/git-gui/lib/mergetool.tcl
index e688b016ef6..ccbc1a46554 100644
--- a/git-gui/lib/mergetool.tcl
+++ b/git-gui/lib/mergetool.tcl
@@ -272,8 +272,24 @@ proc merge_resolve_tool2 {} {
 		}
 	}
 	default {
-		error_popup [mc "Unsupported merge tool '%s'" $tool]
-		return
+		set tool_cmd [get_config mergetool.$tool.cmd]
+		if {$tool_cmd ne {}} {
+			if {([string first {[} $tool_cmd] != -1) || ([string first {]} $tool_cmd] != -1)} {
+				error_popup [mc "Unable to process square brackets in mergetool.cmd configuration option.\
+								Please remove the square brackets."]
+				return
+			} else {
+				foreach command_part $tool_cmd {
+					lappend cmdline [subst -nobackslashes -nocommands $command_part]
+				}
+			}
+		} else {
+			error_popup [mc "Unsupported merge tool '%s'.\n
+							Currently unsupported tools can be added and used as unsupported tools with degraded support\
+							by adding the command of the tool to the \"mergetool.cmd\" option in the config.
+							See the configuration documentation for more details." $tool]
+			return
+		}
 	}
 	}
 

base-commit: 2e7b89e038c0c888acf61f1b4ee5a43d4dd5e94c
-- 
gitgitgadget
