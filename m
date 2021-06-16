Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NORMAL_HTTP_TO_IP,
	NUMERIC_HTTP_ADDR,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B05B4C48BDF
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 01:28:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E3C661159
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 01:28:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbhFPBak (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Jun 2021 21:30:40 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64686 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbhFPBak (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jun 2021 21:30:40 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 23DD3CFD6A;
        Tue, 15 Jun 2021 21:28:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=z5m4zBJImgxe0hYyMU7dlLjqlQbhy9a4IZvxIj
        DB5E4=; b=oF/kkO5nM6JBauVnm+cES2BOZ5rTuDfRt0DkwseE5hivLyPy4SMAor
        l4ZKcDS27qvMCcJzago0R2tMhg5UrMhe+YjQoupk2F44G4JgNBb7I45wzFK6Tke6
        W9btg4a02necZp+dGLevv3G/UkDplTh3k6WQ8A3TJyYrwqU2ra4SY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1BFB0CFD69;
        Tue, 15 Jun 2021 21:28:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6AF10CFD68;
        Tue, 15 Jun 2021 21:28:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Paul Mackerras <paulus@ozlabs.org>
Cc:     "Rostislav Krasny via GitGitGadget" <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Rostislav Krasny <rosti.bsd@gmail.com>
Subject: Re: [PATCH] Add a basic support of SHA256 repositories into Gitk
References: <pull.979.git.1623687519832.gitgitgadget@gmail.com>
Date:   Wed, 16 Jun 2021 10:28:31 +0900
In-Reply-To: <pull.979.git.1623687519832.gitgitgadget@gmail.com> (Rostislav
        Krasny via GitGitGadget's message of "Mon, 14 Jun 2021 16:18:39
        +0000")
Message-ID: <xmqqwnqutx6o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2A1C09DA-CE42-11EB-BDF3-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Rostislav Krasny via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Rostislav Krasny <rosti.bsd@gmail.com>
>
> Signed-off-by: Rostislav Krasny <rosti.bsd@gmail.com>
> ---
>     gitk: Add a basic support of SHA256 repositories into Gitk

Looping-in the gitk maintainer.

>     This PR makes Gitk working on both SHA256 and SHA1 repositories without
>     errors/crashes. I made it by changing and testing the gitk script of Git
>     for Windows [https://gitforwindows.org/] version 2.32.0.windows.1 that
>     is a little bit different than the mainstream 2.32.0 version.
>     
>     Still not fixed functionality: [1] There is the "Auto-select SHA1
>     (length)" configuration preference that affects "Copy commit reference"
>     on both SHA1 and SHA256 repositories.
>     
>     A new "Auto-select SHA256 (length)" configuration preference should be
>     added and used on SHA256 repositories instead of the old one. Since I'm
>     not familiar with Tcl/Tk and this issue isn't critical I didn't
>     implement it.

Thanks, Rostislav; please follow Documentation/SubmittingPatches
next time you touch gitk (or git-gui), as they have their own
repositories and maintainers.

>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-979%2Frosti-il%2Fgitk-sha256-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-979/rosti-il/gitk-sha256-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/979
>
>  gitk-git/gitk | 66 ++++++++++++++++++++++++++++++++++++---------------
>  1 file changed, 47 insertions(+), 19 deletions(-)
>
> diff --git a/gitk-git/gitk b/gitk-git/gitk
> index 23d9dd1fe0d0..2da53604cdc8 100755
> --- a/gitk-git/gitk
> +++ b/gitk-git/gitk
> @@ -290,6 +290,7 @@ proc parseviewargs {n arglist} {
>  
>  proc parseviewrevs {view revs} {
>      global vposids vnegids
> +    global hashlength
>  
>      if {$revs eq {}} {
>          set revs HEAD
> @@ -303,7 +304,7 @@ proc parseviewrevs {view revs} {
>          set badrev {}
>          for {set l 0} {$l < [llength $errlines]} {incr l} {
>              set line [lindex $errlines $l]
> -            if {!([string length $line] == 40 && [string is xdigit $line])} {
> +            if {!([string length $line] == $hashlength && [string is xdigit $line])} {
>                  if {[string match "fatal:*" $line]} {
>                      if {[string match "fatal: ambiguous argument*" $line]
>                          && $badrev ne {}} {
> @@ -507,6 +508,7 @@ proc updatecommits {} {
>      global hasworktree
>      global varcid vposids vnegids vflags vrevs
>      global show_notes
> +    global hashlength
>  
>      set hasworktree [hasworktree]
>      rereadrefs
> @@ -540,7 +542,7 @@ proc updatecommits {} {
>              # take out positive refs that we asked for before or
>              # that we have already seen
>              foreach rev $revs {
> -                if {[string length $rev] == 40} {
> +                if {[string length $rev] == $hashlength} {
>                      if {[lsearch -exact $oldpos $rev] < 0
>                          && ![info exists varcid($view,$rev)]} {
>                          lappend newrevs $rev
> @@ -1418,6 +1420,7 @@ proc getcommitlines {fd inst view updating}  {
>      global parents children curview hlview
>      global idpending ordertok
>      global varccommits varcid varctok vtokmod vfilelimit vshortids
> +    global hashlength
>  
>      set stuff [read $fd 500000]
>      # git log doesn't terminate the last commit with a null...
> @@ -1500,7 +1503,7 @@ proc getcommitlines {fd inst view updating}  {
>              }
>              set ok 1
>              foreach id $ids {
> -                if {[string length $id] != 40} {
> +                if {[string length $id] != $hashlength} {
>                      set ok 0
>                      break
>                  }
> @@ -1780,6 +1783,7 @@ proc readrefs {} {
>      global selecthead selectheadid
>      global hideremotes
>      global tclencoding
> +    global hashlength
>  
>      foreach v {tagids idtags headids idheads otherrefids idotherrefs} {
>          unset -nocomplain $v
> @@ -1789,9 +1793,9 @@ proc readrefs {} {
>          fconfigure $refd -encoding $tclencoding
>      }
>      while {[gets $refd line] >= 0} {
> -        if {[string index $line 40] ne " "} continue
> -        set id [string range $line 0 39]
> -        set ref [string range $line 41 end]
> +        if {[string index $line $hashlength] ne " "} continue
> +        set id [string range $line 0 [expr {$hashlength - 1}]]
> +        set ref [string range $line [expr {$hashlength + 1}] end]
>          if {![string match "refs/*" $ref]} continue
>          set name [string range $ref 5 end]
>          if {[string match "remotes/*" $name]} {
> @@ -2082,6 +2086,7 @@ proc makewindow {} {
>      global have_tk85 use_ttk NS
>      global git_version
>      global worddiff
> +    global hashlength hashalgorithm
>  
>      # The "mc" arguments here are purely so that xgettext
>      # sees the following string as needing to be translated
> @@ -2203,11 +2208,11 @@ proc makewindow {} {
>      set sha1entry .tf.bar.sha1
>      set entries $sha1entry
>      set sha1but .tf.bar.sha1label
> -    button $sha1but -text "[mc "SHA1 ID:"] " -state disabled -relief flat \
> +    button $sha1but -text "[mc "$hashalgorithm ID:"] " -state disabled -relief flat \
>          -command gotocommit -width 8
>      $sha1but conf -disabledforeground [$sha1but cget -foreground]
>      pack .tf.bar.sha1label -side left
> -    ${NS}::entry $sha1entry -width 40 -font textfont -textvariable sha1string
> +    ${NS}::entry $sha1entry -width $hashlength -font textfont -textvariable sha1string
>      trace add variable sha1string write sha1change
>      pack $sha1entry -side left -pady 2
>  
> @@ -3926,6 +3931,7 @@ proc stopblaming {} {
>  
>  proc read_line_source {fd inst} {
>      global blamestuff curview commfd blameinst nullid nullid2
> +    global hashlength
>  
>      while {[gets $fd line] >= 0} {
>          lappend blamestuff($inst) $line
> @@ -3946,7 +3952,7 @@ proc read_line_source {fd inst} {
>      set line [split [lindex $blamestuff($inst) 0] " "]
>      set id [lindex $line 0]
>      set lnum [lindex $line 1]
> -    if {[string length $id] == 40 && [string is xdigit $id] &&
> +    if {[string length $id] == $hashlength && [string is xdigit $id] &&
>          [string is digit -strict $lnum]} {
>          # look for "filename" line
>          foreach l $blamestuff($inst) {
> @@ -5269,13 +5275,14 @@ proc get_viewmainhead {view} {
>  # git rev-list should give us just 1 line to use as viewmainheadid($view)
>  proc getviewhead {fd inst view} {
>      global viewmainheadid commfd curview viewinstances showlocalchanges
> +    global hashlength
>  
>      set id {}
>      if {[gets $fd line] < 0} {
>          if {![eof $fd]} {
>              return 1
>          }
> -    } elseif {[string length $line] == 40 && [string is xdigit $line]} {
> +    } elseif {[string length $line] == $hashlength && [string is xdigit $line]} {
>          set id $line
>      }
>      set viewmainheadid($view) $id
> @@ -7039,10 +7046,11 @@ proc commit_descriptor {p} {
>  # Also look for URLs of the form "http[s]://..." and make them web links.
>  proc appendwithlinks {text tags} {
>      global ctext linknum curview
> +    global hashlength
>  
>      set start [$ctext index "end - 1c"]
>      $ctext insert end $text $tags
> -    set links [regexp -indices -all -inline {(?:\m|-g)[0-9a-f]{6,40}\M} $text]
> +    set links [regexp -indices -all -inline [string map "@@ $hashlength" {(?:\m|-g)[0-9a-f]{6,@@}\M}] $text]
>      foreach l $links {
>          set s [lindex $l 0]
>          set e [lindex $l 1]
> @@ -8716,13 +8724,17 @@ proc incrfont {inc} {
>  
>  proc clearsha1 {} {
>      global sha1entry sha1string
> -    if {[string length $sha1string] == 40} {
> +    global hashlength
> +
> +    if {[string length $sha1string] == $hashlength} {
>          $sha1entry delete 0 end
>      }
>  }
>  
>  proc sha1change {n1 n2 op} {
>      global sha1string currentid sha1but
> +    global hashalgorithm
> +
>      if {$sha1string == {}
>          || ([info exists currentid] && $sha1string == $currentid)} {
>          set state disabled
> @@ -8733,12 +8745,13 @@ proc sha1change {n1 n2 op} {
>      if {$state == "normal"} {
>          $sha1but conf -state normal -relief raised -text "[mc "Goto:"] "
>      } else {
> -        $sha1but conf -state disabled -relief flat -text "[mc "SHA1 ID:"] "
> +        $sha1but conf -state disabled -relief flat -text "[mc "$hashalgorithm ID:"] "
>      }
>  }
>  
>  proc gotocommit {} {
>      global sha1string tagids headids curview varcid
> +    global hashlength hashalgorithm
>  
>      if {$sha1string == {}
>          || ([info exists currentid] && $sha1string == $currentid)} return
> @@ -8748,11 +8761,11 @@ proc gotocommit {} {
>          set id $headids($sha1string)
>      } else {
>          set id [string tolower $sha1string]
> -        if {[regexp {^[0-9a-f]{4,39}$} $id]} {
> +        if {[regexp [string map "@@ [expr $hashlength - 1]" {^[0-9a-f]{4,@@}$}] $id]} {
>              set matches [longid $id]
>              if {$matches ne {}} {
>                  if {[llength $matches] > 1} {
> -                    error_popup [mc "Short SHA1 id %s is ambiguous" $id]
> +                    error_popup [mc "Short $hashalgorithm id %s is ambiguous" $id]
>                      return
>                  }
>                  set id [lindex $matches 0]
> @@ -8769,7 +8782,7 @@ proc gotocommit {} {
>          return
>      }
>      if {[regexp {^[0-9a-fA-F]{4,}$} $sha1string]} {
> -        set msg [mc "SHA1 id %s is not known" $sha1string]
> +        set msg [mc "$hashalgorithm id %s is not known" $sha1string]
>      } else {
>          set msg [mc "Revision %s is not in the current view" $sha1string]
>      }
> @@ -9446,10 +9459,11 @@ proc mktaggo {} {
>  
>  proc copyreference {} {
>      global rowmenuid autosellen
> +    global hashlength
>  
>      set format "%h (\"%s\", %ad)"
>      set cmd [list git show -s --pretty=format:$format --date=short]
> -    if {$autosellen < 40} {
> +    if {$autosellen < $hashlength} {
>          lappend cmd --abbrev=$autosellen
>      }
>      set reference [eval exec $cmd $rowmenuid]
> @@ -9460,6 +9474,7 @@ proc copyreference {} {
>  
>  proc writecommit {} {
>      global rowmenuid wrcomtop commitinfo wrcomcmd NS
> +    global hashlength
>  
>      set top .writecommit
>      set wrcomtop $top
> @@ -9469,7 +9484,7 @@ proc writecommit {} {
>      ${NS}::label $top.title -text [mc "Write commit to file"]
>      grid $top.title - -pady 10
>      ${NS}::label $top.id -text [mc "ID:"]
> -    ${NS}::entry $top.sha1 -width 40
> +    ${NS}::entry $top.sha1 -width $hashlength
>      $top.sha1 insert 0 $rowmenuid
>      $top.sha1 conf -state readonly
>      grid $top.id $top.sha1 -sticky w
> @@ -9549,6 +9564,7 @@ proc mvbranch {} {
>  
>  proc branchdia {top valvar uivar} {
>      global NS commitinfo
> +    global hashlength
>      upvar $valvar val $uivar ui
>  
>      catch {destroy $top}
> @@ -9557,7 +9573,7 @@ proc branchdia {top valvar uivar} {
>      ${NS}::label $top.title -text $ui(title)
>      grid $top.title - -pady 10
>      ${NS}::label $top.id -text [mc "ID:"]
> -    ${NS}::entry $top.sha1 -width 40
> +    ${NS}::entry $top.sha1 -width $hashlength
>      $top.sha1 insert 0 $val(id)
>      $top.sha1 conf -state readonly
>      grid $top.id $top.sha1 -sticky w
> @@ -12320,6 +12336,18 @@ if {$tclencoding == {}} {
>      puts stderr "Warning: encoding $gitencoding is not supported by Tcl/Tk"
>  }
>  
> +set objformat [exec git rev-parse --show-object-format]
> +if {$objformat eq "sha1"} {
> +    set hashlength 40
> +} elseif {$objformat eq "sha256"} {
> +    set hashlength 64
> +} else {
> +    error_popup "[mc "Not supported hash algorithm:"] {$objformat}"
> +    exit 1
> +}
> +set hashalgorithm [string toupper $objformat]
> +unset objformat
> +
>  set gui_encoding [encoding system]
>  catch {
>      set enc [exec git config --get gui.encoding]
>
> base-commit: ebf3c04b262aa27fbb97f8a0156c2347fecafafb
