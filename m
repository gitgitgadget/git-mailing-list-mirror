Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D3322FAFD
	for <git@vger.kernel.org>; Tue, 13 Jan 2026 06:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768285726; cv=none; b=RCu6lzcY17urni9IKbnQlXv1etbUsyW/ee7jIV5lALq2AS14QXNmZhwai8hFpYE5j/jNPc6S0QVfZQsmCzq9wCOniA/V/NtkafrgAICjSbM7+JSZt3zF/1QcV3HmPpYPdnLvG1kqOH5vz2A1YCFO31UyjG+kJUcV/1IUngusFJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768285726; c=relaxed/simple;
	bh=+Cf80uOF9k0rA0pwMqkWPJD2olJKsZ3JIHSfM3JqlLw=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=uqbEuRhJ6H8JynlwoJBRJkm3mLS7/wMmC/tImnPXGz4lI3fkypPnndljPPOgcBsgLPpUuEDnBQydkedBKBA0V01ExFCyTwvjDgsgwe+bmjxQIlpJ+gM38EH3oVGlCjIP/WJLbICL+3WJaOZ2692Dkg7SuTMFVKg3TkrHX6fS8o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G455AHyG; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G455AHyG"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2ae2eb49b4bso9109646eec.0
        for <git@vger.kernel.org>; Mon, 12 Jan 2026 22:28:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768285723; x=1768890523; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MoO4Uz4jcjMlOfa2dJ/U3Qc237TULLmAlciw8u1E0B0=;
        b=G455AHyG9fSCmiLlrL+oXhM96dQXazdeu0Wt1hxpw54hnO9l9lO7B5pq+lcAjwCWmt
         SyYcr7qSYdx5SiwGw3ddubEOVlDuzUj9E+PPV8AmirV0Sp/dS3n3TtgT+4vy6e29xkOk
         HK6wUv0SyY057OAIjNLcqwRAy7J96xaJCy4Otnt2Jdb4KHz/Nj2eWvMADMHaXpwK93cL
         +9likefhyBEdAufy7WlzM4x7+ARYmRWzTSe1DWVFcIlYbw4bTIEHXC5iK9owjh5v0Tul
         07REA6AWvoSSBENSdlR4HkZIx9OOhSUdVRERJBSCCgDDT6+bwrI9/AegD6vlk4K6FjWz
         FTKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768285723; x=1768890523;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MoO4Uz4jcjMlOfa2dJ/U3Qc237TULLmAlciw8u1E0B0=;
        b=rLRMvq7DPoJFIQ99eKDXk3majQeB/H+25qhjGcwv5VARGokBRixUPmq9rDE+Pi+WXy
         gEvqiXPNVnEftPi5zR0V//zmQrGfKua1ejJVRWAFDDWuTu9CAkW8OJEl1hHNHnBjlFbj
         DKMzrxsLroAmPPRE621oVG7Tah6lTj4v6Zgl4L1e7hGMA3wZTrLQETkt2fHLk4hdRWCw
         B48hPeDbV1OkuCJqFO6CXYTik1Ha8uhdzUEf89oII+GC8QFgdbpPxxVstLH5BvcspUD6
         Q+P5rgDZCDxztpk2nVHotyKkoX0fNUq3q7VEqLwjY4HWPkbHCzeKRxTNVXVtidvL4AG3
         Z7Ow==
X-Gm-Message-State: AOJu0Yz7nnppCnofd+MhjgG2MfHSQmMg+QKEjOonzGpXolgS+3N8iXa3
	c9ZiCgYKOZ7aoLTjuMjn3KowqQlWY4EiuTxMz5HH0ydAWGK4BHXYi3dBJ7H8Gg==
X-Gm-Gg: AY/fxX7KLV/47uczrbJbtWUz9wm1lX2kEcyTeHEyppKKfnB6VH4ua7A8h4nT/JXXtzP
	CmJ8vitwgSzqNomGOkWs1I1uzlXvvkLNDyugZ3ChfeTP851va1EMYQOh8WsZOPT761FZuN4cF8q
	8uDSRagUFw79ouqEWS189oDGQHGORF4CeT539m0ernXeTtF+J7IPy9bCpgb6OQVzWJAY4vchM7N
	xGQdV09A9kT5+tYyThi8j/euy9+AnAPwvvmVcCevnFfgjaSjrAGF9KTVdoDitKRMiPwtfuRilbO
	1GF4qUbpuZwWGHY660uVJcqJZrFI3qG4i87/z02i6Z1od/hEQ5RLOosHlb6BN3d0a5notn2JsW5
	LSXfn/p8wnU+SqO6m+pgI9IX/rYI3qNZlg4jhzD1kNvZG9wJq2YL9KqvwT5wN3QNSPrg6lOlfGL
	+HNlyJAk1z+f9erw==
X-Google-Smtp-Source: AGHT+IF7ELZ0F8Wl+9hdiLme9XQKUHJqSqS2s4MhiPWkPDGH0+sP/8iswEx59zmpvdu3iEnuKxZEvg==
X-Received: by 2002:a05:7300:ec91:b0:2ae:5b01:bfa5 with SMTP id 5a478bee46e88-2b17d2ba83emr12603864eec.32.1768285723174;
        Mon, 12 Jan 2026 22:28:43 -0800 (PST)
Received: from [127.0.0.1] ([52.159.247.154])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b17078ccf4sm17387481eec.16.2026.01.12.22.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 22:28:42 -0800 (PST)
Message-Id: <pull.2030.git.1768285721660.gitgitgadget@gmail.com>
From: "Shannon Barber via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 13 Jan 2026 06:28:41 +0000
Subject: [PATCH] gitk: use config settings for head/tag colors
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
    Shannon Barber <sgbarber@gmail.com>,
    Shannon Barber <sbarber@dataspeedinc.com>

From: Shannon Barber <sbarber@dataspeedinc.com>

The drawtags procedure currently uses headfgcolor for all label text,
 ignoring the tagfgcolor setting.

The call to create the outline polygon for (non-tag) heads currently
 has the color for headoutlinecolor hardcoded to black.

This patch maintains the variables for the non-tag refs so that heads
 are colored differently from non-head (non-tag) refs.

The outline and fill colors for the non-head refs remain hardcoded to
 the prior values, black & #ddddff.

Signed-off-by: Shannon Barber <sgbarber@gmail.com>
---
    gitk: use headoutlinecolor, headbgcolor, and tagfgcolor config settings
    to change the color of the tags and head outlines and fill
    
    This patch makes the config settings, headoutlinecolor and tagfgcolor,
    work. These are existing config settings but not used in the code.
    
    (I noticed that tagfgcolor was not working while making an extension for
    vscode that exports its color theme to gitk.) (Upon review of the code I
    found that headoutlinecolor was also not used and investigated and fixed
    it.)
    
    This simple patch has them affect the target UI elements while drawing
    refs and their outlined boxes. Tags are drawn in their own code branch
    then heads and non-heads are drawn in another one. Because both head and
    non-head refs are drawn in the same loop the colors used to draw (and
    fill) toggle between the head colors and (still hard-coded) non-head ref
    colors.
    
    Image showing it working, reviewing the patch that made it work.
    gitk-colors
    [https://github.com/user-attachments/assets/0eea207d-0891-41c8-8c6d-1464a96a1c76]

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2030%2FMagmaiKH%2Fsbarber%2Fuse_color_config_variables-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2030/MagmaiKH/sbarber/use_color_config_variables-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2030

 gitk-git/gitk | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index 7f62c8041d..0415abd873 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -6831,16 +6831,18 @@ proc drawtags {id x xt y1} {
         } else {
             # draw a head or other ref
             if {[incr nheads -1] >= 0} {
-                set col $headbgcolor
+                set refoutlinecol $headoutlinecolor
+                set reffillcol $headbgcolor
                 if {$tag eq $mainhead} {
                     set font mainfontbold
                 }
             } else {
-                set col "#ddddff"
+                set refoutlinecol black
+                set reffillcol "#ddddff"
             }
             set xl [expr {$xl - $delta/2}]
             $canv create polygon $x $yt $xr $yt $xr $yb $x $yb \
-                -width 1 -outline black -fill $col -tags tag.$id
+                -width 1 -outline $refoutlinecol -fill $reffillcol -tags tag.$id
             if {[regexp {^(remotes/.*/|remotes/)} $tag match remoteprefix]} {
                 set rwid [font measure mainfont $remoteprefix]
                 set xi [expr {$x + 1}]
@@ -6850,7 +6852,8 @@ proc drawtags {id x xt y1} {
                         -width 0 -fill $remotebgcolor -tags tag.$id
             }
         }
-        set t [$canv create text $xl $y1 -anchor w -text $tag -fill $headfgcolor \
+        set textfgcolor [expr {$ntags >= 0 ? $tagfgcolor : $headfgcolor}]
+        set t [$canv create text $xl $y1 -anchor w -text $tag -fill $textfgcolor \
                    -font $font -tags [list tag.$id text]]
         if {$ntags >= 0} {
             $canv bind $t <1> $tagclick

base-commit: d529f3a197364881746f558e5652f0236131eb86
-- 
gitgitgadget
