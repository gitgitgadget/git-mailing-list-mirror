Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,LONGWORDS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3589C432BE
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 11:58:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B990961152
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 11:58:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236572AbhH3L7d (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Aug 2021 07:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236535AbhH3L7c (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Aug 2021 07:59:32 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC639C061575
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 04:58:38 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id x11so30679042ejv.0
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 04:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E8aOtjy/ud6IkSomuGU5pAdTOPUswiMgPfP5rMZAK3A=;
        b=NvjPFUe4QXmBiiZ84s0JA/h8xb9B8lotMKn1BnXFldSX9rbxIiDFVFAWXw2zCkAzDY
         B1rgYMqkCx4applhqM49OvlCzhkU+mTsUNkUf4mYZ8WZM+WSMboZIrxPjR2ouPIib0W3
         dmUB/aZf9oiMXUEhWEO6mpHJR5xLvYbKeuWXypK8J+6pMYvK5Ie2Vu2He+YAY3aENAyb
         1R5p8XD2DQrw1f6ip0KyI468xkwThHJi+ndQK1oqCPc82RUcxfFSNJjf5ZRu2LFY2bkd
         YbeFbK54Tq20u+9NbajYlW4gLIDrftQKkyrXPGsLlYa9O7sobjbcC2ztDVJj+X0RBb6L
         HGpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E8aOtjy/ud6IkSomuGU5pAdTOPUswiMgPfP5rMZAK3A=;
        b=YYnY0an9AHLoKvZLDjL/4g+ItV4Bz6wNOAHyRGKlM0sB6OKvvcyjk5focJkb1WGhb9
         vtmZb+7OgvYXKbI19DDs1QB8EFVTC+bsL/o9UIZ7X7lDGdcuaO6b8NfoWhg/2VpimQ5c
         BKBfGE5NbujuKYOcTuIxb8UvLYREYzKuUD3ko3FscZhCF+2PbIehH+x062EqR8xx43lX
         oeFUzYCUckHf2nylH0mio9JY7wynCTbGJUJnKMvJ+xg7jHkoruy005FxidA9zQP2r8Dr
         1eJmPMgfxFZn9C3+oc4eDPFJ3biXDij9/6w9sOAP0JqvlIdk/EB+8LL4yckgfJyIQiwQ
         cO6A==
X-Gm-Message-State: AOAM531r4T+FVfMZWpudFKMznOioUDhQjxK0Cm6jtPLy4Kz9HrFPJy0W
        zoU0rhFYgcaHH4DbR6tisDXLFG+Zrmip8doEzt6CoFbF05Y=
X-Google-Smtp-Source: ABdhPJy8n8seEHKOSBJnOx8w3Ok8BL1vtwUEM7wGSF9BzMrb0f3UvxHzPRYTaHD7MhbDlu+SdDAw8j/rb6ndstzB7To=
X-Received: by 2002:a17:906:3146:: with SMTP id e6mr24475129eje.296.1630324717348;
 Mon, 30 Aug 2021 04:58:37 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1023.git.1629807301494.gitgitgadget@gmail.com>
In-Reply-To: <pull.1023.git.1629807301494.gitgitgadget@gmail.com>
From:   Tal Kelrich <hasturkun@gmail.com>
Date:   Mon, 30 Aug 2021 14:58:26 +0300
Message-ID: <CADWRo2pN9PrCdDVBWb9CN4SrB-JKNqZw9cZAUtqd5xp8y7f9PQ@mail.gmail.com>
Subject: [PATCH v2] gitk: new option to hide prefetch refs
To:     git@vger.kernel.org
Cc:     Paul Mackerras <paulus@ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The maintenance 'prefetch' task creates refs that mirror remote refs,
and in repositories with many branches this can clutter the commit list.

Add a new option to ignore any prefetch refs, enabled by default.

Signed-off-by: Tal Kelrich <hasturkun@gmail.com>
---
Changes since v1:
 - Patch made relative to gitk tree.

 gitk | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/gitk b/gitk
index 23d9dd1..4e44da5 100755
--- a/gitk
+++ b/gitk

@@ -1780,6 +1780,7 @@ proc readrefs {} {
     global selecthead selectheadid
     global hideremotes
     global tclencoding
+    global hideprefetch

     foreach v {tagids idtags headids idheads otherrefids idotherrefs} {
         unset -nocomplain $v
@@ -1814,6 +1815,7 @@ proc readrefs {} {
             }
             set tagids($name) $id
             lappend idtags($id) $name
+        } elseif {[string match "prefetch/*" $name] && $hideprefetch} {
         } else {
             set otherrefids($name) $id
             lappend idotherrefs($id) $name
@@ -11548,7 +11550,7 @@ proc create_prefs_page {w} {
 proc prefspage_general {notebook} {
     global NS maxwidth maxgraphpct showneartags showlocalchanges
     global tabstop limitdiffs autoselect autosellen extdifftool perfile_attrs
-    global hideremotes want_ttk have_ttk maxrefs web_browser
+    global hideremotes want_ttk have_ttk maxrefs web_browser hideprefetch

     set page [create_prefs_page $notebook.general]

@@ -11572,6 +11574,9 @@ proc prefspage_general {notebook} {
     ${NS}::checkbutton $page.hideremotes -text [mc "Hide remote refs"] \
         -variable hideremotes
     grid x $page.hideremotes -sticky w
+    ${NS}::checkbutton $page.hideprefetch -text [mc "Hide prefetch refs"] \
+        -variable hideprefetch
+    grid x $page.hideprefetch -sticky w

     ${NS}::label $page.ddisp -text [mc "Diff display options"]
     grid $page.ddisp - -sticky w -pady 10
@@ -11696,7 +11701,7 @@ proc doprefs {} {
     global oldprefs prefstop showneartags showlocalchanges
     global uicolor bgcolor fgcolor ctext diffcolors selectbgcolor markbgcolor
     global tabstop limitdiffs autoselect autosellen extdifftool perfile_attrs
-    global hideremotes want_ttk have_ttk
+    global hideremotes want_ttk have_ttk hideprefetch

     set top .gitkprefs
     set prefstop $top
@@ -11705,7 +11710,8 @@ proc doprefs {} {
         return
     }
     foreach v {maxwidth maxgraphpct showneartags showlocalchanges \
-                   limitdiffs tabstop perfile_attrs hideremotes want_ttk} {
+                   limitdiffs tabstop perfile_attrs hideremotes want_ttk \
+                   hideprefetch} {
         set oldprefs($v) [set $v]
     }
     ttk_toplevel $top
@@ -11831,7 +11837,8 @@ proc prefscan {} {
     global oldprefs prefstop

     foreach v {maxwidth maxgraphpct showneartags showlocalchanges \
-                   limitdiffs tabstop perfile_attrs hideremotes want_ttk} {
+                   limitdiffs tabstop perfile_attrs hideremotes want_ttk \
+                   hideprefetch} {
         global $v
         set $v $oldprefs($v)
     }
@@ -11845,7 +11852,7 @@ proc prefsok {} {
     global oldprefs prefstop showneartags showlocalchanges
     global fontpref mainfont textfont uifont
     global limitdiffs treediffs perfile_attrs
-    global hideremotes
+    global hideremotes hideprefetch

     catch {destroy $prefstop}
     unset prefstop
@@ -11891,7 +11898,8 @@ proc prefsok {} {
           $limitdiffs != $oldprefs(limitdiffs)} {
         reselectline
     }
-    if {$hideremotes != $oldprefs(hideremotes)} {
+    if {$hideremotes != $oldprefs(hideremotes) ||
+          $hideprefetch != $oldprefs(hideprefetch)} {
         rereadrefs
     }
 }
@@ -12365,6 +12373,7 @@ set cmitmode "patch"
 set wrapcomment "none"
 set showneartags 1
 set hideremotes 0
+set hideprefetch 1
 set maxrefs 20
 set visiblerefs {"master"}
 set maxlinelen 200
@@ -12477,7 +12486,7 @@ set config_variables {
     filesepbgcolor filesepfgcolor linehoverbgcolor linehoverfgcolor
     linehoveroutlinecolor mainheadcirclecolor workingfilescirclecolor
     indexcirclecolor circlecolors linkfgcolor circleoutlinecolor diffbgcolors
-    web_browser
+    web_browser hideprefetch
 }
 foreach var $config_variables {
     config_init_trace $var
--
2.33.0
