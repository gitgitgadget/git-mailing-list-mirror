Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F4C6FBF
	for <git@vger.kernel.org>; Sat, 20 Dec 2025 19:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766258197; cv=none; b=JriNypkgMV6AZIJ3t4beZda3q7a95J8VtgLnhRZlH7RuGAsdliUDwSQFUhapXciQ8esed5Pm/VUTHMcyvZvTN64zpMewQxlXQoT0Bn9Whc8nQwPmpc5eSAWrV0evUOKi+WVnL18p8VY9Mqt7pJK57cNl16bEc/h0fzy+vJtPbDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766258197; c=relaxed/simple;
	bh=pD10uqj9fatudUTKJMhr831PIArPYIY/BixKjmdWIAM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=UD9Bw9stLuiEy6ESlesy7Wu4HW9ntrEenQNpu0CiFyhBQ14CHQ+VUj5fSGDn7s8lJFWnhA28HcvWnFInwPH7aDuTcyXLUEFWdD6Wxy0q8lM/1q+PptY2+5upDOjTyDYxVvUWWn4Gps++p7B2vXP0rOm6WXD1Tq6Lnnvo1T+Gb6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hTDwXhoi; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hTDwXhoi"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-88a367a1db0so46385866d6.3
        for <git@vger.kernel.org>; Sat, 20 Dec 2025 11:16:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766258194; x=1766862994; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ZTmSVfJfp/iLlPQKGtoCidqI2NKVnTYPsGszr8Rnzg=;
        b=hTDwXhoiFYXvCDuaVxzq/7ZKDgl26iwHBLR+PiGQ1HJSCHQTXqGeFPsGb1N0/sFrf3
         /khZEgzoXdHCYtVVBxQ7eFSuddz43z1f1B6ZQ5yw4EX/H6mz4LRIbX0Swxok3Il2ZcZ7
         8Sw4cRhdVgV9WDR99GGEq85OTJeRRA1VBSysgzFgBBIaH+Y0oXYx6nbLprZJtymiHTiL
         bUq00ZVadjcdGhkthkiZzzYIScS6FVtZoev3xL88UP/mnsyv4I6ZNoLCIceWS8bOSnir
         7uTrzf8fqBqTXarr1fZMr01HaCTaDYn5a7Qou8/SjX29u8g1pwXbeevkqNp5x0by8SOZ
         lKuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766258194; x=1766862994;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2ZTmSVfJfp/iLlPQKGtoCidqI2NKVnTYPsGszr8Rnzg=;
        b=ReS7oM7gzZVDzfl/axidcxyF2TW/41K9XNKvrLHdmQajn+NpIWYfT3nVPONIOTJR2M
         bzNaOH7WiZmGfyvOD0GFlavN1OMjJh9I1HMnZrt/ziWq+tDpPGZkTyL11h7UGnCX52dt
         A7UEWebTxUqeojiE78rRmdHxi+tKxXIVtxGEopau++5Ju7knpcxXgePxs0ZIguAkrte2
         xNTWC3lG601mcL1ve5sIBKcY9rwJC0d5LfZoodGGeR/KZ8ecaXXUdt2uV85LakefBNGW
         KzDK3MC6Ox4NOK0s7H/Pebu8tfnYIuNJJHaYWeTkfb+bOQh/Jb4J6L8T33iXbmaDpwjd
         U9XQ==
X-Gm-Message-State: AOJu0Yxu5CKRM8cEuhoHQdC1GxTJ3Df+ngVcmc3wtMZvKvohaRxTkOv3
	Dhoablstxpx0YEBbU6kOyVhVqHQUlsA+rFp6mLdVaBS/XgsGkHaHymqRuQkp0w==
X-Gm-Gg: AY/fxX7hFCREC94ldvFN0qcCJWh75qhf+L4ZhFst6XDcEcmnyr33uDD3RrPy13wMLmK
	kU5d/wPCf2eWrXBcyrcLGYPs3QO+USmKeT7ROjlx9y+OC5CsWdjn5lRIeipgElZrvd2g1AXnbfk
	B12YwxFpVbS74K8m+nux7p8kWyPBCB7kReZW347C8HUaVrib1WAgy1r9PMjDgjjCUEPSMXBT6L5
	kBOvUQEHBKB+5GajeZMNgRsy+xyMGiUi5lmzL+UlbDLLK1fNV+VclHGBpZoM7DIJIM7tdJDCfnv
	65tAXHcsxrchNw+MFWrc2QzlHwh+VjL5Hj6vbDbFPTft/RQAVZeHnDe0cpu/tyho7XWiS0qsC6q
	tB98OlqT4NLVKkj14Ul+PxgCna8mzrxyBuNxhJ+4+YTgUx+y9ZAxuyWBtVo/2uhqY9NUEupbtoz
	iTfEsQfQR6UZNzag==
X-Google-Smtp-Source: AGHT+IFR4vfH7oh7hHOodR2k1emwMT+43kQ49MldEvbcgrsKBwRyVVnlz2ShtBsaA+P5LEx3EOavFA==
X-Received: by 2002:a05:6214:1768:b0:88a:27ec:746b with SMTP id 6a1803df08f44-88d84c16791mr70069196d6.67.1766258194116;
        Sat, 20 Dec 2025 11:16:34 -0800 (PST)
Received: from [127.0.0.1] ([145.132.100.81])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88d99d7a08asm47509746d6.38.2025.12.20.11.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Dec 2025 11:16:33 -0800 (PST)
Message-Id: <de0deb31cf5537d9c2d2edffc74d5ccda0452602.1766258187.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2020.git.1766258187.gitgitgadget@gmail.com>
References: <pull.2020.git.1766258187.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 20 Dec 2025 19:16:25 +0000
Subject: [PATCH 3/5] doc: convert git-status tables to AsciiDoc format
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
    =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

Instead of plain text tables with hand formatting, take advantage of
asciidoc's table syntax to let the renderer do the heavy lifting and
make the tables more maintainable and translatable.

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/git-status.adoc | 170 +++++++++++++++++-----------------
 1 file changed, 85 insertions(+), 85 deletions(-)

diff --git a/Documentation/git-status.adoc b/Documentation/git-status.adoc
index 37b0453898..9acca52bfb 100644
--- a/Documentation/git-status.adoc
+++ b/Documentation/git-status.adoc
@@ -219,35 +219,32 @@ show tracked paths:
 `C`:: copied (if config option status.renames is set to "copies")
 `U`:: updated but unmerged
 
-....
-X          Y     Meaning
--------------------------------------------------
-	 [AMD]   not updated
-M        [ MTD]  updated in index
-T        [ MTD]  type changed in index
-A        [ MTD]  added to index
-D                deleted from index
-R        [ MTD]  renamed in index
-C        [ MTD]  copied in index
-[MTARC]          index and work tree matches
-[ MTARC]    M    work tree changed since index
-[ MTARC]    T    type changed in work tree since index
-[ MTARC]    D    deleted in work tree
-	    R    renamed in work tree
-	    C    copied in work tree
--------------------------------------------------
-D           D    unmerged, both deleted
-A           U    unmerged, added by us
-U           D    unmerged, deleted by them
-U           A    unmerged, added by them
-D           U    unmerged, deleted by us
-A           A    unmerged, both added
-U           U    unmerged, both modified
--------------------------------------------------
-?           ?    untracked
-!           !    ignored
--------------------------------------------------
-....
+[cols="^1m,^1m,<2",options="header"]
+|===
+|X        |  Y     |Meaning
+|         |[AMD]   |not updated
+|M        |[ MTD]  |updated in index
+|T        |[ MTD]  |type changed in index
+|A        |[ MTD]  |added to index
+|D        |        |deleted from index
+|R        |[ MTD]  |renamed in index
+|C        |[ MTD]  |copied in index
+|[MTARC]  |        |index and work tree matches
+|[ MTARC] |M       |work tree changed since index
+|[ MTARC] |T       |type changed in work tree since index
+|[ MTARC] |D       |deleted in work tree
+|         |R       |renamed in work tree
+|         |C       |copied in work tree
+|D        |D       |unmerged, both deleted
+|A        |U       |unmerged, added by us
+|U        |D       |unmerged, deleted by them
+|U        |A       |unmerged, added by them
+|D        |U       |unmerged, deleted by us
+|A        |A       |unmerged, both added
+|U        |U       |unmerged, both modified
+|?        |?       |untracked
+|!        |!       |ignored
+|===
 
 Submodules have more state and instead report
 
@@ -311,16 +308,15 @@ Branch Headers
 If `--branch` is given, a series of header lines are printed with
 information about the current branch.
 
-....
-Line                                     Notes
-------------------------------------------------------------
-# branch.oid <commit> | (initial)        Current commit.
-# branch.head <branch> | (detached)      Current branch.
-# branch.upstream <upstream-branch>      If upstream is set.
-# branch.ab +<ahead> -<behind>           If upstream is set and
-					 the commit is present.
-------------------------------------------------------------
-....
+[cols="<1,<1",options="header"]
+|===
+|Line                                     |Notes
+|`# branch.oid <commit> \| (initial)`     |Current commit.
+|`# branch.head <branch> \| (detached)`   |Current branch.
+|`# branch.upstream <upstream-branch>`    |If upstream is set.
+|`# branch.ab +<ahead> -<behind>`         |If upstream is set and
+					  the commit is present.
+|===
 
 Stash Information
 ^^^^^^^^^^^^^^^^^
@@ -349,37 +345,42 @@ Renamed or copied entries have the following format:
 [synopsis]
 2 <XY> <sub> <mH> <mI> <mW> <hH> <hI> <X><score> <path><sep><origPath>
 
-....
-Field       Meaning
---------------------------------------------------------
-<XY>        A 2 character field containing the staged and
-	    unstaged XY values described in the short format,
-	    with unchanged indicated by a "." rather than
-	    a space.
-<sub>       A 4 character field describing the submodule state.
-	    "N..." when the entry is not a submodule.
-	    "S<c><m><u>" when the entry is a submodule.
-	    <c> is "C" if the commit changed; otherwise ".".
-	    <m> is "M" if it has tracked changes; otherwise ".".
-	    <u> is "U" if there are untracked changes; otherwise ".".
-<mH>        The octal file mode in HEAD.
-<mI>        The octal file mode in the index.
-<mW>        The octal file mode in the worktree.
-<hH>        The object name in HEAD.
-<hI>        The object name in the index.
-<X><score>  The rename or copy score (denoting the percentage
-	    of similarity between the source and target of the
-	    move or copy). For example "R100" or "C75".
-<path>      The pathname.  In a renamed/copied entry, this
-	    is the target path.
-<sep>       When the `-z` option is used, the 2 pathnames are separated
-	    with a NUL (ASCII 0x00) byte; otherwise, a tab (ASCII 0x09)
-	    byte separates them.
-<origPath>  The pathname in the commit at HEAD or in the index.
-	    This is only present in a renamed/copied entry, and
-	    tells where the renamed/copied contents came from.
---------------------------------------------------------
-....
+[cols="<1,<1a",options="header"]
+|===
+|Field       | Meaning
+
+|_<XY>_
+|A 2 character field containing the staged and
+unstaged XY values described in the short format,
+with unchanged indicated by a "." rather than
+a space.
+|_<sub>_
+|A 4 character field describing the submodule state.
+"N..." when the entry is not a submodule.
+`S<c><m><u>` when the entry is a submodule.
+
+* _<c>_ is "C" if the commit changed; otherwise ".".
+* _<m>_ is "M" if it has tracked changes; otherwise ".".
+* _<u>_ is "U" if there are untracked changes; otherwise ".".
+|_<mH>_       |The octal file mode in HEAD.
+|_<mI>_       |The octal file mode in the index.
+|_<mW>_       |The octal file mode in the worktree.
+|_<hH>_       |The object name in HEAD.
+|_<hI>_       |The object name in the index.
+|_<X><score>_ |The rename or copy score (denoting the percentage
+of similarity between the source and target of the
+move or copy). For example "R100" or "C75".
+|_<path>_
+|The pathname.  In a renamed/copied entry, this is the target path.
+|_<sep>_
+|When the `-z` option is used, the 2 pathnames are separated
+with a _NUL_ (ASCII 0x00) byte; otherwise, a _TAB_ (ASCII 0x09)
+byte separates them.
+|_<origPath>_
+|The pathname in the commit at HEAD or in the index.
+This is only present in a renamed/copied entry, and
+tells where the renamed/copied contents came from.
+|===
 
 Unmerged entries have the following format; the first character is
 a "u" to distinguish from ordinary changed entries.
@@ -387,23 +388,22 @@ a "u" to distinguish from ordinary changed entries.
 [synopsis]
 u <XY> <sub> <m1> <m2> <m3> <mW> <h1> <h2> <h3> <path>
 
-....
-Field       Meaning
---------------------------------------------------------
-<XY>        A 2 character field describing the conflict type
+[cols="<1,<1a",options="header"]
+|===
+|Field       |Meaning
+|_<XY>_      |A 2 character field describing the conflict type
 	    as described in the short format.
-<sub>       A 4 character field describing the submodule state
+|_<sub>_     |A 4 character field describing the submodule state
 	    as described above.
-<m1>        The octal file mode in stage 1.
-<m2>        The octal file mode in stage 2.
-<m3>        The octal file mode in stage 3.
-<mW>        The octal file mode in the worktree.
-<h1>        The object name in stage 1.
-<h2>        The object name in stage 2.
-<h3>        The object name in stage 3.
-<path>      The pathname.
---------------------------------------------------------
-....
+|_<m1>_      |The octal file mode in stage 1.
+|_<m2>_      |The octal file mode in stage 2.
+|_<m3>_      |The octal file mode in stage 3.
+|_<mW>_      |The octal file mode in the worktree.
+|_<h1>_      |The object name in stage 1.
+|_<h2>_      |The object name in stage 2.
+|_<h3>_      |The object name in stage 3.
+|_<path>_    |The pathname.
+|===
 
 Other Items
 ^^^^^^^^^^^
-- 
gitgitgadget

