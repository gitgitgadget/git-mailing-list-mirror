Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18AE132114
	for <git@vger.kernel.org>; Wed, 28 Aug 2024 08:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724833924; cv=none; b=Bri3vcCWM42Ah9Iy94rR1xm2o0oDqnaX8Rgpz4ttGulkxtvwQYLanIHkBCzVth0LZFy982qZwdGhpwvu/nKDz+G4NdSwD4vvgsDZX8uZhVTs+Mm0hmk9fDW5GHniojEp0yimcxFtQSLoz2STwXZQO2BVeawnyVb1c7Ywpx1+oao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724833924; c=relaxed/simple;
	bh=S61laTplL2BIVTLBhLEit6Lh+rbRlNd38aUi5wtkHQ4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=bjVXQRr7Bi1md6Hc+/nC+GRTok+XZ5qGuMSzCkHB8OCvBi8sGDU6WRDsSz+osF/NNrCDpi6IIs2Lzg34B44QM1XBd5xJKczjaFhacKYlAZbhNAuIgW6CTIHVeSz6qHuY5ErbecbI/DtLaM8ZEJwl+gpvHYe4YNYBf4V4gqYdzVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HP+HBvM/; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HP+HBvM/"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2f50966c478so33353471fa.1
        for <git@vger.kernel.org>; Wed, 28 Aug 2024 01:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724833920; x=1725438720; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=prKdvFJksm28TKqxlyvYTUpeq1a8JVc0caafu7xbOJ4=;
        b=HP+HBvM/LTc+lwanSE3rgcDV1lNy5E48GHCgkLlFwuHxydc20dChPpo7wozP18IUuR
         Wi7CLSTAknQLMCAGkga9gaiTUYn2eWXUHimbgACV0MBbWf+dIrO6OApaIWa543MNgxNR
         Cbs12ClzHdhqRNHgsWKLK+VpoVnOLAwJnWEDOWMFCT+t/35goXQsUTdeshXeCZZIW8r2
         NPHkGLO7pZzCv0uEZXJz0qnujUV4WCcbWe8V0jMKawIhIJSjdyHyYp/0p6h29PrAe1qk
         hTiMgTO0XKRjgnQ6JaYowZylvhQ3kRY8knQTt73UGhW/Exv7uO5JpfZhx71hTPPOxY6T
         xYZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724833920; x=1725438720;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=prKdvFJksm28TKqxlyvYTUpeq1a8JVc0caafu7xbOJ4=;
        b=jhv5tY/3lHPW+Z0+txQj4OLLDVWknzOUt7/AzLfxp2dGz4qYytHTuBjzbICGR9G+dW
         3cCzVj7Od3Ozcpv2YzjfLplgGrGa74OQgDAQKuQG83OtyXOEOKOLb8a1nYcJR+VraK5L
         aVFC8IJaH0tby2XrwsyIQZAGrdZrMWAmLd1rSldngBn1WRTFOWLR6EgvhwvzdCdAj9dr
         e0YH+fj95jRZeEet+ScWMoREKS52e+cqmgAE7IiNJpsEjmcIPD1p47+Zg2sJRW0f7Ap1
         R7RnEw4LBbOtHiSkrAVaQRDTksI62eAu40/1rrNsa20/UGld2xxshJl4RlthGbjSlJZ1
         c8Dg==
X-Gm-Message-State: AOJu0Yx2OZT71mtNQvSZRu4pgYDzzcJabtZjl4Jd8/6sRVxa6KQ/CGvm
	YTjAuKGyWDeY1XxuFq/QaRnnjKq4eKtd3bnBaSX/xA6AZOs4FsugQRpT8w==
X-Google-Smtp-Source: AGHT+IG5n4dcoW9J24szkToxdLd2txIkQR7bjyURZDMZn7dSrExXsX/iEU0UQCHGohwSDngpT9THYw==
X-Received: by 2002:a05:651c:b09:b0:2f3:d00f:24ea with SMTP id 38308e7fff4ca-2f55b6bd098mr9039821fa.21.1724833918768;
        Wed, 28 Aug 2024 01:31:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c0bb1c5b39sm1954883a12.20.2024.08.28.01.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 01:31:58 -0700 (PDT)
Message-Id: <pull.1773.v2.git.1724833917245.gitgitgadget@gmail.com>
In-Reply-To: <pull.1773.git.1724066944786.gitgitgadget@gmail.com>
References: <pull.1773.git.1724066944786.gitgitgadget@gmail.com>
From: "ToBoMi via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 28 Aug 2024 08:31:56 +0000
Subject: [PATCH v2] git gui: add directly calling merge tool from gitconfig
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
Cc: ToBoMi <tobias.boesch@miele.com>,
    deboeto <tobias.boesch@miele.com>

From: deboeto <tobias.boesch@miele.com>

git gui can open a merge tool when conflicts are
detected (Right click in the diff of the file with
conflicts).
The merge tools that are allowed to
use are hard coded into git gui.

If one wants to add a new merge tool it has to be
added to git gui through a source code change.
This is not convenient in comparison to how it
works in git (without gui).

git itself has configuration options for a merge tools
path and command in the git config.
New merge tools can be set up there without a
source code change.

Those options are used only by pure git in
contrast to git gui. git calls the configured
merge tools directly from the config while git
Gui doesn't.

With this change git gui can call merge tools
configured in the gitconfig directly without a
change in git gui source code.
It needs a configured merge.tool and a configured
mergetool.cmd config entry.

gitconfig example:
[merge]
	tool = vscode
[mergetool "vscode"]
	path = the/path/to/Code.exe
	cmd = \"Code.exe\" --wait --merge \"$LOCAL\" \"$REMOTE\" \"$BASE\" \"$MERGED\"

Without the mergetool.cmd configuration and an
unsupported merge.tool entry, git gui behaves
mainly as before this change and informs the user
about an unsupported merge tool, but now also
shows a hint to add a config entry for the tool
in gitconfig.

If a wrong mergetool.cmd is configured by accident
it is beeing handled by git gui already. In this
case git gui informs the user that the merge tool
couldn't be opened. This behavior is preserved by
this change and should not change.

Beyond compare 3 and Visual Studio code were
tested as manually configured merge tools.

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

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1773%2FToBoMi%2Fadd_merge_tool_from_config_file-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1773/ToBoMi/add_merge_tool_from_config_file-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1773

Range-diff vs v1:

 1:  59e8f454a70 ! 1:  e77d6dec6c5 git gui: add directly calling merge tool from gitconfig
     @@ Metadata
       ## Commit message ##
          git gui: add directly calling merge tool from gitconfig
      
     -    * git Gui can open a merge tool when conflicts are
     -        detected. The merge tools that are allowed to
     -        call have to be hard coded into git Gui
     -        althgough there are configuration options for
     -        merge tools git in the git config. Git calls
     -        the configured merge tools directly from the
     -        config while git Gui doesn't.
     -    * git Gui can now call the tool configured in the
     -        gitconfig directly.
     -    * Can be enabled through setting
     -        gui.mergeToolFromConfig
     -    * Disabled by default, since option is most likely
     -        never set
     -    * bc3 and vscode tested
     -
     -    Signed-off-by: deboeto <tobias.boesch@miele.com>
     -
     - ## Documentation/config/gui.txt ##
     -@@ Documentation/config/gui.txt: gui.blamehistoryctx::
     - 	linkgit:gitk[1] for the selected commit, when the `Show History
     - 	Context` menu item is invoked from 'git gui blame'. If this
     - 	variable is set to zero, the whole history is shown.
     -+
     -+gui.mergeToolFromConfig::
     -+	If true, allow to call the merge tool configured in gitconfig
     -+	in git gui directly.
     - \ No newline at end of file
     +    git gui can open a merge tool when conflicts are
     +    detected (Right click in the diff of the file with
     +    conflicts).
     +    The merge tools that are allowed to
     +    use are hard coded into git gui.
     +
     +    If one wants to add a new merge tool it has to be
     +    added to git gui through a source code change.
     +    This is not convenient in comparison to how it
     +    works in git (without gui).
     +
     +    git itself has configuration options for a merge tools
     +    path and command in the git config.
     +    New merge tools can be set up there without a
     +    source code change.
     +
     +    Those options are used only by pure git in
     +    contrast to git gui. git calls the configured
     +    merge tools directly from the config while git
     +    Gui doesn't.
     +
     +    With this change git gui can call merge tools
     +    configured in the gitconfig directly without a
     +    change in git gui source code.
     +    It needs a configured merge.tool and a configured
     +    mergetool.cmd config entry.
     +
     +    gitconfig example:
     +    [merge]
     +            tool = vscode
     +    [mergetool "vscode"]
     +            path = the/path/to/Code.exe
     +            cmd = \"Code.exe\" --wait --merge \"$LOCAL\" \"$REMOTE\" \"$BASE\" \"$MERGED\"
     +
     +    Without the mergetool.cmd configuration and an
     +    unsupported merge.tool entry, git gui behaves
     +    mainly as before this change and informs the user
     +    about an unsupported merge tool, but now also
     +    shows a hint to add a config entry for the tool
     +    in gitconfig.
     +
     +    If a wrong mergetool.cmd is configured by accident
     +    it is beeing handled by git gui already. In this
     +    case git gui informs the user that the merge tool
     +    couldn't be opened. This behavior is preserved by
     +    this change and should not change.
     +
     +    Beyond compare 3 and Visual Studio code were
     +    tested as manually configured merge tools.
     +
     +    Signed-off-by: Tobias Boesch <tobias.boesch@miele.com>
      
       ## git-gui/lib/mergetool.tcl ##
      @@ git-gui/lib/mergetool.tcl: proc merge_resolve_tool2 {} {
     @@ git-gui/lib/mergetool.tcl: proc merge_resolve_tool2 {} {
       	default {
      -		error_popup [mc "Unsupported merge tool '%s'" $tool]
      -		return
     -+		if {[is_config_true gui.mergetoolfromconfig]} {
     -+			set path [get_config mergetool.$tool.path]
     -+			set cmdline_config [get_config mergetool.$tool.cmd]
     -+			set cmdline_substituted [subst -nobackslashes -nocommands $cmdline_config]
     -+			set cmdline [lreplace $cmdline_substituted 0 0 $path]
     ++		set tool_cmd [get_config mergetool.$tool.cmd]
     ++		if {$tool_cmd ne {}} {
     ++			set tool_cmd_file_vars_resolved [subst -nobackslashes -nocommands $tool_cmd]
     ++			set cmdline [lreplace $tool_cmd_file_vars_resolved 0 0 $merge_tool_path]
      +		} else {
     -+			error_popup [mc "Unsupported merge tool '%s'" $tool]
     ++			error_popup [mc "Unsupported merge tool '%s'. Is the tool command and path configured properly in gitconfig?" $tool]
      +			return
      +		}
       	}


 git-gui/lib/mergetool.tcl | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/git-gui/lib/mergetool.tcl b/git-gui/lib/mergetool.tcl
index e688b016ef6..4c4e8f47bb0 100644
--- a/git-gui/lib/mergetool.tcl
+++ b/git-gui/lib/mergetool.tcl
@@ -272,8 +272,14 @@ proc merge_resolve_tool2 {} {
 		}
 	}
 	default {
-		error_popup [mc "Unsupported merge tool '%s'" $tool]
-		return
+		set tool_cmd [get_config mergetool.$tool.cmd]
+		if {$tool_cmd ne {}} {
+			set tool_cmd_file_vars_resolved [subst -nobackslashes -nocommands $tool_cmd]
+			set cmdline [lreplace $tool_cmd_file_vars_resolved 0 0 $merge_tool_path]
+		} else {
+			error_popup [mc "Unsupported merge tool '%s'. Is the tool command and path configured properly in gitconfig?" $tool]
+			return
+		}
 	}
 	}
 

base-commit: 159f2d50e75c17382c9f4eb7cbda671a6fa612d1
-- 
gitgitgadget
