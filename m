Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21853C001DD
	for <git@archiver.kernel.org>; Mon,  3 Jul 2023 18:46:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbjGCSqH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Jul 2023 14:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbjGCSqG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jul 2023 14:46:06 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D31EE6D
        for <git@vger.kernel.org>; Mon,  3 Jul 2023 11:46:04 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3fbd33a57dcso25850545e9.0
        for <git@vger.kernel.org>; Mon, 03 Jul 2023 11:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688409962; x=1691001962;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xlLpQDrYuCMqO7VXNlhduN8uXXWstsTV+64aERLfcTs=;
        b=luZW1IW41LTaq2FsGXHa7lXHRN/xDYGHjNZx/Gu0n6Q0zQB7lgD73MU0bBCaVTZsG1
         saLxCD+z5aUDkMADUHoVUfIvEKzu8hRIOmJixKIavdE/am50Ind+Bax1YgaSx7C4t3cj
         o+o3qNkfUijGRhoQP/0P2hhwSJtA4sDQC9uD3XY8aO3h37YLFdxh88hDGtmalS9Nexrk
         zttNFMjSyE/qJ6WqUqXfw+dg+IXyf98tEzxqo29byYB3KGr8aaQeE5ethanpSPkGBuMz
         VSZB+ahZutsH+dFrcakkDifvg5W0JKodPxtfnixBaVNNniSFbT8K2mqWYaN5b5PuYIa/
         4HSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688409962; x=1691001962;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xlLpQDrYuCMqO7VXNlhduN8uXXWstsTV+64aERLfcTs=;
        b=OXuEFSpFsGwDdHIjQq8Q/3qZaMoxBEycylzHbEr2UGkRE9ypWiIRMoyHrFMXiVDSPx
         9bMyV2kG8L9qZsKuLBwz94smHjubQbeOvDsJpk51w/+XcjRyqFO30RwIXuBorm7GmYL/
         d46RKVrQ4NkqqnpqwCuxiV04faSsLu4fHi5OgOzgTU8y8drMIsmbNNWVaQqEXmCWo8Zd
         MPgy+uDF0V2nA/1LeDfva1/gmK5YY+DGmMbVcUDv6ku7q7r9SkpyXBJHZjVSVc3RwjIg
         aWIoc8LnxyAASFG1kJI7DjDQwcwX9NOC69JTWhTE8D+kfjrjnpVERfgafAVeqWLODIYH
         9xpg==
X-Gm-Message-State: ABy/qLYt8VnBUO68Eh7i7GqX3AvwZqMJQw5almq8AyJnQYSmMIPaPAnL
        cs+NDYru0ufD+1yPylR4Ustm4xfyPA0=
X-Google-Smtp-Source: APBJJlFPnSgrkjOQCecTe1QVeypc1FzLW03YxIZFMhWmbu3g3QZwhTVDSF87+gIUccp1jKi8T+IzwQ==
X-Received: by 2002:adf:e806:0:b0:314:1e99:32fd with SMTP id o6-20020adfe806000000b003141e9932fdmr8323815wrm.58.1688409961689;
        Mon, 03 Jul 2023 11:46:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t5-20020a05600001c500b00313f7b077fesm19538201wrx.59.2023.07.03.11.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 11:46:00 -0700 (PDT)
Message-Id: <pull.1551.v2.git.1688409958.gitgitgadget@gmail.com>
In-Reply-To: <pull.1551.git.1687876884.gitgitgadget@gmail.com>
References: <pull.1551.git.1687876884.gitgitgadget@gmail.com>
From:   "Jens Lidestrom via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 03 Jul 2023 18:45:48 +0000
Subject: [PATCH v2 00/10] gitk: improve keyboard support
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     "Paul Mackerras [ ]" <paulus@ozlabs.org>,
        Johannes Sixt <j6t@kdbg.org>,
        Jens Lidestrom <jens@lidestrom.se>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It is often convenient to use the keyboard to navigate the gitk GUI and
there are keyboard shortcut bindings for many operations such as searching
and scrolling. There is however no keyboard binding for the most common
operations on branches and commits: Check out, reset, cherry-pick, create
and delete branches.

This PR adds keyboard bindings for these 5 commands. It also adjusts some
GUI focus defaults to simplify keyboard navigation.

Some refactoring of the command implementation has been necessary.
Originally the commands was using the mouse context menu to get info about
the head and commit to act on. When using keyboard binds this information
isn't available so instead the row that is selected in the GUI is used. By
adding procedures for doing this the PR lays the groundwork for more similar
keyboard binds in the future.

I'm including Paul Mackerras because he seems to be the maintainer of gitk.
Can you review, Paul?

----------------------------------------------------------------------------

I have updated the PR after suggestions from Hannes. Mainly these changes
have been made:

 * The reset command dialog uses "mixed" as the default, but is more
   convenient to navigate with the keyboard.
 * Remove and checkout branch commands now have branch selection dialogs if
   there is more than one branch head on the selected commit.
 * Remove and checkout branch command patches handles a few more cases
   regarding remote branches and detached heads that I didn't think about
   originally. This has made them larger.
 * I have split one commit, added another and moved some functionality
   around. Because of this the original patch number are no longer in sync
   with GitHub. How should I handle that?

Jens Lidestrom (10):
  gitk: add procedures to get commit info from selected row
  gitk: use term "current branch" in gui
  gitk: add keyboard bind for reset command
  gitk: show branch name in reset dialog
  gitk: add keyboard bind for checkout command
  gitk: add keyboard bind for remove branch command
  gitk: add keyboard bind for cherry-pick command
  gitk: add keyboard bind for create branch command
  gitk: improve keyboard convenience in reset dialog
  gitk: allow checkout of remote branch

 gitk-git/gitk | 343 ++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 278 insertions(+), 65 deletions(-)


base-commit: 94486b6763c29144c60932829a65fec0597e17b3
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1551%2Fjensli%2Fkeyboard-for-gitk-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1551/jensli/keyboard-for-gitk-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1551

Range-diff vs v1:

  1:  cbbc1462f58 !  1:  063b5652c0e gitk: add procedures to get commit info from selected row
     @@ gitk-git/gitk: proc commitonrow {row} {
      +    return [commitonrow $selectedline]
      +}
      +
     -+# Gets the first branch name of the row that is selected in the GUI, or the
     -+# empty string if there is no branches on that commit.
     -+proc selected_line_head {} {
     ++# Gets all branche names on the commit that is selected in the GUI, or the
     ++# empty list if there is no branches on that commit.
     ++proc selected_line_heads {} {
      +    global idheads
      +    set id [selected_line_id]
      +    if {[info exists idheads($id)]} {
     -+        return [lindex $idheads($id) 0]
     ++        return $idheads($id)
      +    } else {
     -+        return ""
     ++        return {}
      +    }
      +}
      +
  2:  863fa3ee311 =  2:  f4ec77c1586 gitk: use term "current branch" in gui
  3:  2ba695bf94f !  3:  ca042ded0bb gitk: add keyboard bind for reset
     @@ Metadata
      Author: Jens Lidestrom <jens@lidestrom.se>
      
       ## Commit message ##
     -    gitk: add keyboard bind for reset
     +    gitk: add keyboard bind for reset command
      
          Signed-off-by: Jens Lidestrom <jens@lidestrom.se>
      
  4:  8594e2cc68a !  4:  bd261e702f6 gitk: show branch name in reset dialog
     @@ Commit message
          Signed-off-by: Jens Lidestrom <jens@lidestrom.se>
      
       ## gitk-git/gitk ##
     -@@ gitk-git/gitk: proc selected_line_head {} {
     +@@ gitk-git/gitk: proc selected_line_heads {} {
           }
       }
       
  5:  53e5a2e40ab !  5:  aaca07db597 gitk: add keyboard bind for checkout
     @@ Metadata
      Author: Jens Lidestrom <jens@lidestrom.se>
      
       ## Commit message ##
     -    gitk: add keyboard bind for checkout
     +    gitk: add keyboard bind for checkout command
      
          This also introduces the ability to check out detatched heads. This
          shouldn't result any problems, because gitk already works with
     @@ gitk-git/gitk: proc makewindow {} {
           bind $ctext <Button-1> {focus %W}
           bind $ctext <<Selection>> rehighlight_search_results
           bind . <$M1B-t> {resethead [selected_line_id]}
     -+    bind . <$M1B-o> {checkout [selected_line_head] [selected_line_id]}
     ++    bind . <$M1B-o> {checkout [selected_line_heads] [selected_line_id]}
           for {set i 1} {$i < 10} {incr i} {
               bind . <$M1B-Key-$i> [list go_to_parent $i]
           }
      @@ gitk-git/gitk: proc makewindow {} {
     -         {mc "Create tag" command mktag}
     -         {mc "Copy commit reference" command copyreference}
     -         {mc "Write commit to file" command writecommit}
     --        {mc "Create new branch" command mkbranch}
     -+        {mc "Create new branch" command {mkbranch $rowmenuid}}
     -         {mc "Cherry-pick this commit" command cherrypick}
     -         {mc "Reset current branch to here" command {resethead $rowmenuid}}
     -         {mc "Mark this commit" command markhere}
     -@@ gitk-git/gitk: proc makewindow {} {
       
           set headctxmenu .headctxmenu
           makemenu $headctxmenu {
      -        {mc "Check out this branch" command cobranch}
     -+        {mc "Check out this branch" command {checkout $headmenuhead $headmenuid}}
     ++        {mc "Check out this branch" command {checkout [list $headmenuhead] $headmenuid}}
               {mc "Rename this branch" command mvbranch}
               {mc "Remove this branch" command rmbranch}
               {mc "Copy branch name" command {clipboard clear; clipboard append $headmenuhead}}
     @@ gitk-git/gitk: proc headmenu {x y id head} {
       
      -proc cobranch {} {
      -    global headmenuid headmenuhead headids
     -+proc checkout {newhead newheadid} {
     -+    global headids
     ++proc checkout {heads_on_commit id_to_checkout} {
     ++    global headids mainhead
           global showlocalchanges
     ++    global sel_ix confirm_ok NS
       
           # check the tree is clean first??
      -    set newhead $headmenuhead
      +
     -+    # The ref is either the head, if it exists, or the ID
     -+    set newheadref [expr {$newhead ne "" ? $newhead : $newheadid}]
     ++    # Filter out remote branches if local branch is also present
     ++    foreach remote_ix [lsearch -all $heads_on_commit "remotes/*"] {
     ++        set remote_head [lindex $heads_on_commit $remote_ix]
     ++        set local_head [string range $remote_head [expr [string last / $remote_head] + 1] end]
     ++        if {$local_head in $heads_on_commit} {
     ++            set heads_on_commit [lreplace $heads_on_commit $remote_ix $remote_ix]
     ++        }
     ++    }
     ++
     ++    if {[llength $heads_on_commit] == 1 && [lindex $heads_on_commit 0] eq $mainhead} {
     ++        # Only the currently active branch
     ++        return
     ++    }
     ++
     ++    # Filter out mainhead
     ++    set mainhead_ix [lsearch $heads_on_commit $mainhead]
     ++    if {$mainhead_ix != -1} {
     ++        set heads_on_commit [lreplace $heads_on_commit $mainhead_ix $mainhead_ix]
     ++    }
     ++    set nr_heads_on_commit [llength $heads_on_commit]
     ++
     ++    # The number of heads on the commit determines how to select what to checkout
     ++    if {$nr_heads_on_commit == 0} {
     ++        set head_to_checkout ""
     ++        set ref_to_checkout $id_to_checkout
     ++    } elseif {$nr_heads_on_commit == 1} {
     ++        set head_to_checkout [lindex $heads_on_commit 0]
     ++        set ref_to_checkout $head_to_checkout
     ++    } else {
     ++        # Branch selection dialog
     ++
     ++        set confirm_ok 0
     ++
     ++        set w ".selectbranch"
     ++        ttk_toplevel $w
     ++        make_transient $w .
     ++        wm title $w [mc "Check out branch"]
     ++        ${NS}::label $w.m -text [mc "Check out which branch?"]
     ++        pack $w.m -side top -fill x -padx 20 -pady 20
     ++        ${NS}::frame $w.f
     ++
     ++        set sel_ix 0
     ++        for {set i 0} {$i < $nr_heads_on_commit} {incr i} {
     ++            ${NS}::radiobutton $w.f.id_$i -value $i -variable sel_ix \
     ++                -text [lindex $heads_on_commit $i]
     ++            bind $w.f.id_$i <Key-Up> "set sel_ix [expr ($i - 1) % $nr_heads_on_commit]"
     ++            bind $w.f.id_$i <Key-Down> "set sel_ix [expr ($i + 1) % $nr_heads_on_commit]"
     ++            grid $w.f.id_$i -sticky w -padx 20
     ++        }
      +
     ++        pack $w.f -side top -fill x -padx 4
     ++        ${NS}::button $w.ok -text [mc OK] -command "set confirm_ok 1; destroy $w"
     ++        bind $w <Key-Return> "set confirm_ok 1; destroy $w"
     ++        pack $w.ok -side left -fill x -padx 20 -pady 20
     ++        ${NS}::button $w.cancel -text [mc Cancel] -command "destroy $w"
     ++        bind $w <Key-Escape> [list destroy $w]
     ++        pack $w.cancel -side right -fill x -padx 20 -pady 20
     ++        bind $w <Visibility> "grab $w; focus $w.f.id_$sel_ix"
     ++
     ++        tkwait window $w
     ++
     ++        if {!$confirm_ok} return
     ++
     ++        set head_to_checkout [lindex $heads_on_commit $sel_ix]
     ++        set ref_to_checkout $head_to_checkout
     ++    }
     ++
     ++    # Handle remote branches
           set command [list | git checkout]
     -     if {[string match "remotes/*" $newhead]} {
     -         set remote $newhead
     -         set newhead [string range $newhead [expr [string last / $newhead] + 1] end]
     +-    if {[string match "remotes/*" $newhead]} {
     +-        set remote $newhead
     +-        set newhead [string range $newhead [expr [string last / $newhead] + 1] end]
      -        # The following check is redundant - the menu option should
      -        # be disabled to begin with...
     -         if {[info exists headids($newhead)]} {
     -             error_popup [mc "A local branch named %s exists already" $newhead]
     +-        if {[info exists headids($newhead)]} {
     +-            error_popup [mc "A local branch named %s exists already" $newhead]
     ++    if {[string match "remotes/*" $head_to_checkout]} {
     ++        set remote $head_to_checkout
     ++        set head_to_checkout [string range $head_to_checkout [expr [string last / $head_to_checkout] + 1] end]
     ++        set ref_to_checkout $head_to_checkout
     ++        if {[info exists headids($head_to_checkout)]} {
     ++            error_popup [mc "A local branch named %s exists already" $head_to_checkout]
                   return
               }
     -         lappend command -b $newhead --track $remote
     +-        lappend command -b $newhead --track $remote
     ++        lappend command -b $head_to_checkout --track $remote
           } else {
      -        lappend command $newhead
     -+        lappend command $newheadref
     ++        lappend command $ref_to_checkout
           }
           lappend command 2>@1
           nowbusy checkout [mc "Checking out"]
     @@ gitk-git/gitk: proc cobranch {} {
               }
           } else {
      -        filerun $fd [list readcheckoutstat $fd $newhead $headmenuid]
     -+        filerun $fd [list readcheckoutstat $fd $newhead $newheadref $newheadid]
     ++        filerun $fd [list readcheckoutstat $fd $head_to_checkout $ref_to_checkout $id_to_checkout]
           }
       }
       
      -proc readcheckoutstat {fd newhead newheadid} {
     -+proc readcheckoutstat {fd newhead newheadref newheadid} {
     ++proc readcheckoutstat {fd head_to_checkout ref_to_checkout id_to_checkout} {
           global mainhead mainheadid headids idheads showlocalchanges progresscoords
           global viewmainheadid curview
       
      @@ gitk-git/gitk: proc readcheckoutstat {fd newhead newheadid} {
     +         error_popup $err
               return
           }
     -     set oldmainid $mainheadid
     +-    set oldmainid $mainheadid
      -    if {! [info exists headids($newhead)]} {
     +-        set headids($newhead) $newheadid
     +-        lappend idheads($newheadid) $newhead
     +-        addedhead $newheadid $newhead
     +-    }
     +-    set mainhead $newhead
     +-    set mainheadid $newheadid
     +-    set viewmainheadid($curview) $newheadid
     +-    redrawtags $oldmainid
     +-    redrawtags $newheadid
     +-    selbyid $newheadid
     ++    set old_main_id $mainheadid
      +
     -+    if {$newhead ne "" && ! [info exists headids($newhead)]} {
     -         set headids($newhead) $newheadid
     -         lappend idheads($newheadid) $newhead
     -         addedhead $newheadid $newhead
     ++    if {$head_to_checkout ne "" && ! [info exists headids($head_to_checkout)]} {
     ++        set headids($head_to_checkout) $id_to_checkout
     ++        lappend idheads($id_to_checkout) $head_to_checkout
     ++        addedhead $id_to_checkout $head_to_checkout
     ++    }
     ++    set mainhead $ref_to_checkout
     ++    set mainheadid $id_to_checkout
     ++    set viewmainheadid($curview) $id_to_checkout
     ++    redrawtags $old_main_id
     ++    redrawtags $id_to_checkout
     ++    selbyid $id_to_checkout
     +     if {$showlocalchanges} {
     +         dodiffindex
           }
     --    set mainhead $newhead
     -+    set mainhead $newheadref
     -     set mainheadid $newheadid
     -     set viewmainheadid($curview) $newheadid
     -     redrawtags $oldmainid
  6:  661f098d882 !  6:  ad6617a7bad gitk: add keyboard bind for create and remove branch
     @@ Metadata
      Author: Jens Lidestrom <jens@lidestrom.se>
      
       ## Commit message ##
     -    gitk: add keyboard bind for create and remove branch
     +    gitk: add keyboard bind for remove branch command
      
          Signed-off-by: Jens Lidestrom <jens@lidestrom.se>
      
     @@ gitk-git/gitk
      @@ gitk-git/gitk: proc makewindow {} {
           bind $ctext <<Selection>> rehighlight_search_results
           bind . <$M1B-t> {resethead [selected_line_id]}
     -     bind . <$M1B-o> {checkout [selected_line_head] [selected_line_id]}
     -+    bind . <$M1B-m> {rmbranch [selected_line_head] [selected_line_id] 1}
     +     bind . <$M1B-o> {checkout [selected_line_heads] [selected_line_id]}
     ++    bind . <$M1B-m> {rmbranch [selected_line_heads] [selected_line_id] 1}
      +    bind . <$M1B-b> {mkbranch [selected_line_id]}
           for {set i 1} {$i < 10} {incr i} {
               bind . <$M1B-Key-$i> [list go_to_parent $i]
           }
      @@ gitk-git/gitk: proc makewindow {} {
           makemenu $headctxmenu {
     -         {mc "Check out this branch" command {checkout $headmenuhead $headmenuid}}
     +         {mc "Check out this branch" command {checkout [list $headmenuhead] $headmenuid}}
               {mc "Rename this branch" command mvbranch}
      -        {mc "Remove this branch" command rmbranch}
     -+        {mc "Remove this branch" command {rmbranch $headmenuhead $headmenuid 0}}
     ++        {mc "Remove this branch" command {rmbranch [list $headmenuhead] $headmenuid 0}}
               {mc "Copy branch name" command {clipboard clear; clipboard append $headmenuhead}}
           }
           $headctxmenu configure -tearoff 0
     @@ gitk-git/gitk: proc keys {} {
       [mc "<F5>		Update"]
       [mc "<%s-T>		Reset current branch to selected commit" $M1T]
       [mc "<%s-O>		Check out selected commit" $M1T]
     -+[mc "<%s-C>		Create branch on selected commit" $M1T]
     ++[mc "<%s-B>		Create branch on selected commit" $M1T]
      +[mc "<%s-M>		Remove selected branch" $M1T]
       " \
                   -justify left -bg $bgcolor -border 2 -relief groove
           pack $w.m -side top -fill both -padx 2 -pady 2
     -@@ gitk-git/gitk: proc wrcomcan {} {
     -     unset wrcomtop
     - }
     - 
     --proc mkbranch {} {
     --    global NS rowmenuid
     -+proc mkbranch {id} {
     -+    global NS
     - 
     -     set top .branchdialog
     - 
     -     set val(name) ""
     --    set val(id) $rowmenuid
     -+    set val(id) $id
     -     set val(command) [list mkbrgo $top]
     - 
     -     set ui(title) [mc "Create branch"]
     -@@ gitk-git/gitk: proc readcheckoutstat {fd newhead newheadref newheadid} {
     +@@ gitk-git/gitk: proc readcheckoutstat {fd head_to_checkout ref_to_checkout id_to_checkout} {
           }
       }
       
      -proc rmbranch {} {
      -    global headmenuid headmenuhead mainhead
     -+proc rmbranch {head id shouldComfirm} {
     ++proc rmbranch {heads_on_commit id shouldComfirm} {
      +    global mainhead
           global idheads
     --
     ++    global confirm_ok sel_ix NS
     + 
      -    set head $headmenuhead
      -    set id $headmenuid
     -     # this check shouldn't be needed any more...
     -+    if {$head eq ""} {
     +-    # this check shouldn't be needed any more...
     +-    if {$head eq $mainhead} {
     ++    if {[llength $heads_on_commit] == 0} {
      +        error_popup [mc "Cannot delete a detached head"]
      +        return
      +    }
     -     if {$head eq $mainhead} {
     ++
     ++    if {[llength $heads_on_commit] == 1 && [lindex $heads_on_commit 0] eq $mainhead} {
               error_popup [mc "Cannot delete the currently checked-out branch"]
               return
     -@@ gitk-git/gitk: proc rmbranch {} {
     -         # the stuff on this branch isn't on any other branch
     -         if {![confirm_popup [mc "The commits on branch %s aren't on any other\
     -                         branch.\nReally delete branch %s?" $head $head]]} return
     -+    } elseif {$shouldComfirm} {
     -+        if {![confirm_popup [mc "Really delete branch %s?" $head]]} return
           }
     +-    set dheads [descheads $id]
     +-    if {[llength $dheads] == 1 && $idheads($dheads) eq $head} {
     +-        # the stuff on this branch isn't on any other branch
     +-        if {![confirm_popup [mc "The commits on branch %s aren't on any other\
     +-                        branch.\nReally delete branch %s?" $head $head]]} return
     ++
     ++    # Filter out mainhead
     ++    set mainhead_ix [lsearch $heads_on_commit $mainhead]
     ++    if {$mainhead_ix != -1} {
     ++        set heads_on_commit [lreplace $heads_on_commit $mainhead_ix $mainhead_ix]
     ++    }
     ++
     ++    # Filter out remote branches
     ++    foreach head_ix [lsearch -all $heads_on_commit "remotes/*"] {
     ++        set heads_on_commit [lreplace $heads_on_commit $head_ix $head_ix]
     ++    }
     ++
     ++    if {[llength $heads_on_commit] == 0} {
     ++        # Probably only current branch and its remote branch on commit
     ++        error_popup [mc "Cannot delete branch"]
     ++        return
     +     }
     ++
     ++    set nr_heads_on_commit [llength $heads_on_commit]
     ++    set first_head [lindex $heads_on_commit 0]
     ++
     ++    if {$nr_heads_on_commit == 1} {
     ++        # Only a single head, simple comfirm dialogs
     ++
     ++        set head_to_remove $first_head
     ++        set dheads [descheads $id]
     ++
     ++        if {[llength $dheads] == 1 && $idheads($dheads) eq $head_to_remove} {
     ++            # the stuff on this branch isn't on any other branch
     ++            if {![confirm_popup [mc "The commits on branch %s aren't on any other\
     ++                            branch.\nReally delete branch %s?" $head_to_remove $head_to_remove]]} return
     ++        } elseif {$shouldComfirm} {
     ++            if {![confirm_popup [mc "Really delete branch %s?" $head_to_remove]]} return
     ++        }
     ++    } else {
     ++        # Select branch dialog
     ++
     ++        set confirm_ok 0
     ++
     ++        set w ".selectbranch"
     ++        ttk_toplevel $w
     ++        make_transient $w .
     ++        wm title $w [mc "Delete branch"]
     ++        ${NS}::label $w.m -text [mc "Which branch to delete?"]
     ++        pack $w.m -side top -fill x -padx 20 -pady 20
     ++        ${NS}::frame $w.f
     ++
     ++        set sel_ix 0
     ++        for {set i 0} {$i < $nr_heads_on_commit} {incr i} {
     ++            ${NS}::radiobutton $w.f.id_$i -value $i -variable sel_ix \
     ++                -text [lindex $heads_on_commit $i]
     ++            bind $w.f.id_$i <Key-Up> "set sel_ix [expr ($i - 1) % $nr_heads_on_commit]"
     ++            bind $w.f.id_$i <Key-Down> "set sel_ix [expr ($i + 1) % $nr_heads_on_commit]"
     ++            grid $w.f.id_$i -sticky w -padx 20
     ++        }
     ++
     ++        pack $w.f -side top -fill x -padx 4
     ++        ${NS}::button $w.ok -text [mc OK] -command "set confirm_ok 1; destroy $w"
     ++        bind $w <Key-Return> "set confirm_ok 1; destroy $w"
     ++        pack $w.ok -side left -fill x -padx 20 -pady 20
     ++        ${NS}::button $w.cancel -text [mc Cancel] -command "destroy $w"
     ++        bind $w <Key-Escape> [list destroy $w]
     ++        pack $w.cancel -side right -fill x -padx 20 -pady 20
     ++        bind $w <Visibility> "grab $w; focus $w.f.id_$sel_ix"
     ++
     ++        tkwait window $w
     ++        if {!$confirm_ok} return
     ++
     ++        set head_to_remove [lindex $heads_on_commit $sel_ix]
     ++    }
     ++
     ++    # Perform the command
     ++
           nowbusy rmbranch
           update
     +-    if {[catch {exec git branch -D $head} err]} {
     ++    if {[catch {exec git branch -D $head_to_remove} err]} {
     +         notbusy rmbranch
     +         error_popup $err
     +         return
     +     }
     +-    removehead $id $head
     +-    removedhead $id $head
     ++    removehead $id $head_to_remove
     ++    removedhead $id $head_to_remove
     +     redrawtags $id
     +     notbusy rmbranch
     +     dispneartags 0
  7:  46cbbaa6fe2 !  7:  54afa8fe9e8 gitk: add keyboard bind to cherry-pick
     @@ Metadata
      Author: Jens Lidestrom <jens@lidestrom.se>
      
       ## Commit message ##
     -    gitk: add keyboard bind to cherry-pick
     +    gitk: add keyboard bind for cherry-pick command
      
          Signed-off-by: Jens Lidestrom <jens@lidestrom.se>
      
     @@ gitk-git/gitk: proc makewindow {} {
           bind $ctext <<Selection>> rehighlight_search_results
      +    bind . <$M1B-p> {cherrypick [selected_line_id]}
           bind . <$M1B-t> {resethead [selected_line_id]}
     -     bind . <$M1B-o> {checkout [selected_line_head] [selected_line_id]}
     -     bind . <$M1B-m> {rmbranch [selected_line_head] [selected_line_id] 1}
     +     bind . <$M1B-o> {checkout [selected_line_heads] [selected_line_id]}
     +     bind . <$M1B-m> {rmbranch [selected_line_heads] [selected_line_id] 1}
      @@ gitk-git/gitk: proc makewindow {} {
     +         {mc "Create tag" command mktag}
               {mc "Copy commit reference" command copyreference}
               {mc "Write commit to file" command writecommit}
     -         {mc "Create new branch" command {mkbranch $rowmenuid}}
     +-        {mc "Create new branch" command mkbranch}
      -        {mc "Cherry-pick this commit" command cherrypick}
     ++        {mc "Create new branch" command {mkbranch $rowmenuid}}
      +        {mc "Cherry-pick this commit" command {cherrypick $rowmenuid}}
               {mc "Reset current branch to here" command {resethead $rowmenuid}}
               {mc "Mark this commit" command markhere}
     @@ gitk-git/gitk: proc keys {} {
       [mc "<%s-T>		Reset current branch to selected commit" $M1T]
      +[mc "<%s-P>		Cherry-pick selected commit to current branch" $M1T]
       [mc "<%s-O>		Check out selected commit" $M1T]
     - [mc "<%s-C>		Create branch on selected commit" $M1T]
     + [mc "<%s-B>		Create branch on selected commit" $M1T]
       [mc "<%s-M>		Remove selected branch" $M1T]
      @@ gitk-git/gitk: proc exec_citool {tool_args {baseid {}}} {
           array set env $save_env
  -:  ----------- >  8:  bd498f5b326 gitk: add keyboard bind for create branch command
  8:  49cdbff270f !  9:  a37a677036d gitk: focus ok button in reset dialog
     @@ Metadata
      Author: Jens Lidestrom <jens@lidestrom.se>
      
       ## Commit message ##
     -    gitk: focus ok button in reset dialog
     +    gitk: improve keyboard convenience in reset dialog
      
     -    This is more convenient for users, especially when using keyboard
     -    commands.
     +    Make it more convenient to use the reset dialog using keyboard.
     +
     +    * Set focus to the combo box.
     +    * Accept with Return key.
     +    * Auto-select combo items when navigating in menu with up/down keys.
      
          Signed-off-by: Jens Lidestrom <jens@lidestrom.se>
      
       ## gitk-git/gitk ##
      @@ gitk-git/gitk: proc resethead {reset_target_id} {
     +     ttk_toplevel $w
     +     make_transient $w .
     +     wm title $w [mc "Confirm reset"]
     ++
     +     ${NS}::label $w.m -text \
     +         [mc "Reset branch %s to %s?" $mainhead [commit_name $reset_target_id 1]]
     +     pack $w.m -side top -fill x -padx 20 -pady 20
     +     ${NS}::labelframe $w.f -text [mc "Reset type:"]
     ++
     +     set resettype mixed
     ++
     +     ${NS}::radiobutton $w.f.soft -value soft -variable resettype \
     +         -text [mc "Soft: Leave working tree and index untouched"]
     ++    bind $w.f.soft <Key-Up> "set resettype hard"
     ++    bind $w.f.soft <Key-Down> "set resettype mixed"
     +     grid $w.f.soft -sticky w
     ++
     +     ${NS}::radiobutton $w.f.mixed -value mixed -variable resettype \
     +         -text [mc "Mixed: Leave working tree untouched, reset index"]
     ++    bind $w.f.mixed <Key-Up> "set resettype soft"
     ++    bind $w.f.mixed <Key-Down> "set resettype hard"
     +     grid $w.f.mixed -sticky w
     ++
     +     ${NS}::radiobutton $w.f.hard -value hard -variable resettype \
     +         -text [mc "Hard: Reset working tree and index\n(discard ALL local changes)"]
     ++    bind $w.f.hard <Key-Up> "set resettype mixed"
     ++    bind $w.f.hard <Key-Down> "set resettype soft"
     +     grid $w.f.hard -sticky w
     +     pack $w.f -side top -fill x -padx 4
     ++
     +     ${NS}::button $w.ok -text [mc OK] -command "set confirm_ok 1; destroy $w"
     ++    bind $w <Key-Return> "set confirm_ok 1; destroy $w"
     +     pack $w.ok -side left -fill x -padx 20 -pady 20
           ${NS}::button $w.cancel -text [mc Cancel] -command "destroy $w"
           bind $w <Key-Escape> [list destroy $w]
           pack $w.cancel -side right -fill x -padx 20 -pady 20
      -    bind $w <Visibility> "grab $w; focus $w"
     -+    bind $w <Visibility> "grab $w; focus $w.ok"
     ++    bind $w <Visibility> "grab $w; focus $w.f.mixed"
           tkwait window $w
           if {!$confirm_ok} return
           if {[catch {set fd [open \
  9:  97857c3509f <  -:  ----------- gitk: default select reset hard in dialog
  -:  ----------- > 10:  3f0438fc027 gitk: allow checkout of remote branch

-- 
gitgitgadget
