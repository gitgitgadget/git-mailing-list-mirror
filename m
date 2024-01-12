Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3150D168AD
	for <git@vger.kernel.org>; Fri, 12 Jan 2024 21:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OufGFck2"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3376ead25e1so4744806f8f.3
        for <git@vger.kernel.org>; Fri, 12 Jan 2024 13:48:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705096116; x=1705700916; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Wqg/7Zb+rBJQnZVRTeBVpQcY1InkhjpYJqY/ONi7ZZU=;
        b=OufGFck2cex44NE7qZDESBO3UGf9UznpWXWSprpVtopMKhkGzqfgxjBeITk8I7R2pZ
         cgs2FHdIRVEOKM1gMRYuY8bx/wb8OI+9r1zaAzwpbWXASuv48+LRXKt0yRix4YpPgJOm
         VklfxZQApu6l1qwbxPzsE4EXly7KypoMXxa8lQDNo7Ovd5ZYSVPGosljiT801TyKkJDL
         8XN5cANP85B3/eflIULQ3ZpRG4QBwevD16Vxy4h0Qej+CytEM9SLhSaKojCo07scvVPW
         P6ffwIw2diyq6Kk1uvWFxkD717ANTz3Yq++AkwJK0SQ1KRXV2F4qp3AwG7AEWJpr/2B/
         15WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705096116; x=1705700916;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wqg/7Zb+rBJQnZVRTeBVpQcY1InkhjpYJqY/ONi7ZZU=;
        b=IbwPx6brBQY/ikIETmhg/nx9HrMmsc5L9TM+ZUUBHvpS7YiNnjsvuCYnlmPxU1YhyO
         OSUQArgaCcAexEwQ/aYVoCPQttNANNVwd//Vkuw5hb3702v8jRIzKjL9sND5dmZt2gEZ
         cJXMBG44PBv/OJR5ZFahJbSsTo9+/0uTS2ejg4+MrJQ2SOKFfTli1swggR5U7vLQTwL4
         1rWkC9cMFoYsLyo4qg7LT1/I+79flLnPlONti5FPStemh8Xdzhox1WyhUCEarjEk15Y5
         tf1VbYVZpcBvbhEHssGrstTqqRh2Hans1+SX2VLqMmi7Ss2E8LHs1KCZnFD0rYqhj2O3
         p3FQ==
X-Gm-Message-State: AOJu0YySvEpws+BKLK71tEipTGzAGcptaJ4rQBzvWd4dPKvRcsETVozX
	Z4dCSME+AnBoKidsK3aE0wBrn6TpjHw=
X-Google-Smtp-Source: AGHT+IG7r3ZrpuwtWpYPFQMZiqpwMMUrHdRjYLeNNUOWl/SN/socS0Y1iOMS+qMDSgalsADDacO9RQ==
X-Received: by 2002:a05:600c:1885:b0:40d:5b0c:736c with SMTP id x5-20020a05600c188500b0040d5b0c736cmr1191758wmp.127.1705096115662;
        Fri, 12 Jan 2024 13:48:35 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a8-20020a5d5088000000b003364a0e6983sm4866917wrt.62.2024.01.12.13.48.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 13:48:35 -0800 (PST)
Message-ID: <pull.1629.git.1705096114752.gitgitgadget@gmail.com>
From: "Ulrich Hornung via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 12 Jan 2024 21:48:34 +0000
Subject: [PATCH] add ctx menu for tags, impl "remove tag" and "copy tag name"
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
Cc: Ulrich Hornung <hornunguli@gmx.de>,
    Ulrich Hornung <hornunguli@gmx.de>

From: Ulrich Hornung <hornunguli@gmx.de>

Signed-off-by: Ulrich Hornung <hornunguli@gmx.de>
---
    gitk: add ctx menu for tags, impl "remove tag" and "copy tag name"
    
    Hello,
    
    I'm currently using git gui and gitk quite strongly. It happens to me
    once in a while that I accidentially create a tag instead of a new
    branch when using the GUI of gitk for this. Sadly, in this situation I
    needed to go to the console to remove this tag again, because the latest
    version of gitk doesn't have a "remove tag" button.
    
    Lukily I was able to implement that button (and the copy name button) by
    myself. I would be happy if you could integrate the new feature into the
    official sources.
    
    Bildschirmfoto vom 2024-01-01 17-26-07
    [https://github.com/gitgitgadget/git/assets/252806/079c28dd-b4a0-486c-ad1e-27f7f2fde814]
    
    Thanks.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1629%2Fcre4ture%2Ffeature%2Ftag_ctx_menu_remove_tag-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1629/cre4ture/feature/tag_ctx_menu_remove_tag-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1629

 gitk-git/gitk | 67 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 66 insertions(+), 1 deletion(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index 7a087f123d7..7a70e1fba31 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -1894,6 +1894,21 @@ proc removehead {id name} {
     unset headids($name)
 }
 
+# update things when a tag has been removed
+proc removetag {id name} {
+    global tagids idtags
+
+    if {$idtags($id) eq $name} {
+        unset idtags($id)
+    } else {
+        set i [lsearch -exact $idtags($id) $name]
+        if {$i >= 0} {
+            set idtags($id) [lreplace $idtags($id) $i $i]
+        }
+    }
+    unset tagids($name)
+}
+
 proc ttk_toplevel {w args} {
     global use_ttk
     eval [linsert $args 0 ::toplevel $w]
@@ -2096,7 +2111,7 @@ proc makewindow {} {
     global uifgcolor uifgdisabledcolor
     global filesepbgcolor filesepfgcolor
     global mergecolors foundbgcolor currentsearchhitbgcolor
-    global headctxmenu progresscanv progressitem progresscoords statusw
+    global headctxmenu tagctxmenu progresscanv progressitem progresscoords statusw
     global fprogitem fprogcoord lastprogupdate progupdatepending
     global rprogitem rprogcoord rownumsel numcommits
     global have_tk85 use_ttk NS
@@ -2705,6 +2720,13 @@ proc makewindow {} {
     }
     $headctxmenu configure -tearoff 0
 
+    set tagctxmenu .tagctxmenu
+    makemenu $tagctxmenu {
+        {mc "Remove this tag" command rmtag}
+        {mc "Copy tag name" command {clipboard clear; clipboard append $tagmenutag}}
+    }
+    $tagctxmenu configure -tearoff 0
+
     global flist_menu
     set flist_menu .flistctxmenu
     makemenu $flist_menu {
@@ -6701,6 +6723,7 @@ proc drawtags {id x xt y1} {
                    -font $font -tags [list tag.$id text]]
         if {$ntags >= 0} {
             $canv bind $t <1> $tagclick
+            $canv bind $t $ctxbut [list tagmenu %X %Y $id $tag_quoted]
         } elseif {$nheads >= 0} {
             $canv bind $t $ctxbut [list headmenu %X %Y $id $tag_quoted]
         }
@@ -9938,6 +9961,20 @@ proc headmenu {x y id head} {
     tk_popup $headctxmenu $x $y
 }
 
+# context menu for a tag
+proc tagmenu {x y id head} {
+    global tagmenuid tagmenutag tagctxmenu
+
+    stopfinding
+    set tagmenuid $id
+    set tagmenutag $head
+    array set state {0 normal 1 normal}
+    foreach i {0 1} {
+        $tagctxmenu entryconfigure $i -state $state($i)
+    }
+    tk_popup $tagctxmenu $x $y
+}
+
 proc cobranch {} {
     global headmenuid headmenuhead headids
     global showlocalchanges
@@ -10042,6 +10079,27 @@ proc rmbranch {} {
     run refill_reflist
 }
 
+proc rmtag {} {
+    global tagmenuid tagmenutag
+
+    set tag $tagmenutag
+    set id $tagmenuid
+
+    nowbusy rmtag
+    update
+    if {[catch {exec git tag -d $tag} err]} {
+        notbusy rmtag
+        error_popup $err
+        return
+    }
+    removetag $id $tag
+    removedtag $id $tag
+    redrawtags $id
+    notbusy rmtag
+    dispneartags 0
+    run refill_reflist
+}
+
 # Display a list of tags and heads
 proc showrefs {} {
     global showrefstop bgcolor fgcolor selectbgcolor NS
@@ -11273,6 +11331,13 @@ proc removedhead {hid head} {
     unset -nocomplain cached_dheads
 }
 
+proc removedtag {hid head} {
+    global cached_dtags cached_atags
+
+    unset -nocomplain cached_dtags
+    unset -nocomplain cached_atags
+}
+
 proc movedhead {hid head} {
     global arcnos arcout cached_dheads
 

base-commit: a26002b62827b89a19b1084bd75d9371d565d03c
-- 
gitgitgadget
