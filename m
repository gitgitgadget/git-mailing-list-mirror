Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEEE9C433EF
	for <git@archiver.kernel.org>; Mon, 28 Mar 2022 22:30:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbiC1WcM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Mar 2022 18:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiC1WcK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Mar 2022 18:32:10 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C440247ACA
        for <git@vger.kernel.org>; Mon, 28 Mar 2022 15:30:28 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 4EB3932020B8;
        Mon, 28 Mar 2022 18:30:25 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 28 Mar 2022 18:30:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=u92.eu; h=cc:cc
        :content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm2; bh=CLYH/oukuWiDecwPr8/zJwq4Vp3rAl7QYTPqAWxBQMc=; b=GmBnD
        /qs/+s0QLPangjt3n8w8ieK8vFj78CTVRxvJYqNPTQwYuxKb2JJ89sHNDKwU8Hby
        qnakScFgTFp6dBGZTV0vzDwpPYPlPDT+ij6vjsVGSVE5HtcpFudGGAACTsd2Ixjv
        lEyveKefZZYHZwQdpmsJndKHi7yuOIpWP2/Fz5wjfJDas3SMAN47Ndb//TAiVB9+
        ZypX/mBPSm1wm4NpR9eBQa4AZvRBtUxwBwDULaj+3goizwWugrVjp1P+MH7q0RnU
        aH4X6vx0f67QfLyRIEMoH149zX71tJhK9n8LdpOGe9C5mMTYX5QnVJQnuJG92K0H
        llEHxjzAA7MWi6pdQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=CLYH/oukuWiDecwPr8/zJwq4Vp3rA
        l7QYTPqAWxBQMc=; b=B8NwzFXOqXE83GZCT1pq83lyqE2rHzemcO9N9SWrLWPNX
        SOqAUlQViV3qTNwfzsBIWgrDsKLtYix+hAdvmaCWXdi4k0xvBJtdyStOkvSMSp/b
        PK01J9olSJN+a4BA57Blp5+219Fg26Gl1ctz6o4mKOS6ElSHxMAPmhbLWfjM7PZX
        L09evG8JuSHzWPOrnSAkhWvN7UtcRz+/6VGU0UJRGX7nnXA7B9nvNPNh0f7CCg/D
        9g8lxe0G7uQ5I1qQ3EGuHm+lwNfYPsox4/x00LU8cy/DC3l5Yj/ZvRJvrgeu7aLb
        fueG0VRIsNaVVXcyl3tagtBLLTHALsKXwqVVII3fg==
X-ME-Sender: <xms:ADdCYkRED-D4nseIrh1wzMeJReOeg4S3r3Z1XPwDffoPePSb8xvivw>
    <xme:ADdCYhxFe0whjXJmGtEiEjFEWZWcNdOnrhj9cV6rJlCYqnAQRVDvNHNoCMBwVLyWc
    hsevdvmebmWM3YHMg>
X-ME-Received: <xmr:ADdCYh3tw0X9lAw8xzkhZx8gbnqMNSmm-N6uJh8pi-NRocKvrwCLLZlloN_xxpEAst9AvNM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudehkedguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
    dttdenucfhrhhomhephfgvrhhnrghnughoucftrghmohhsuceoghhrvggvnhhfohhosehu
    ledvrdgvuheqnecuggftrfgrthhtvghrnhepgfeifeduheegudehfeevfffhffelieefte
    effeehgeeileekuefhgeegueethfeinecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdp
    phgrshhtvggsihhnrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepghhrvggvnhhfohhosehuledvrdgvuh
X-ME-Proxy: <xmx:ADdCYoBvE70D_EASLoiiuHWaThrRs01frBgfP90V6LYdHenw8le0iw>
    <xmx:ADdCYtg9t_19Dm8gd3oFw-487VULbs9GdeGfHmH36XZ7P_HQB_p8Aw>
    <xmx:ADdCYkoBnHxkKUIAK0DPJTvR27DHduFVHM_EZeFdRiyW4NdoYgU2cA>
    <xmx:ADdCYoVCphzwz-v6jqLZ-fdInx5QIYhmIxZX2brOyUMYl9DQec_qsQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Mar 2022 18:30:22 -0400 (EDT)
From:   Fernando Ramos <greenfoo@u92.eu>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, davvid@gmail.com, sunshine@sunshineco.com,
        seth@eseth.com, levraiphilippeblain@gmail.com,
        rogi@skylittlesystem.org, bagasdotme@gmail.com
Subject: [PATCH v7 0/4] vimdiff: new implementation with layout support
Date:   Tue, 29 Mar 2022 00:30:15 +0200
Message-Id: <20220328223019.271270-1-greenfoo@u92.eu>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Original cover letter (see v7 changes at the end):

A few weeks ago I presented this RFC [1] where I introduced a new variant of the
vimdiff merge tool ("vimdiff4") that creates three tabs (instead of just one)
that look like this:

    ------------------------------------------
    | <TAB #1> |  TAB #2  |  TAB #3  |       |
    ------------------------------------------
    |             |           |              |
    |   LOCAL     |   BASE    |   REMOTE     |
    |             |           |              |   <---- Same information
    ------------------------------------------         presented by the
    |                                        |         "standard" vimdiff
    |                MERGED                  |         merge tool
    |                                        |
    ------------------------------------------
    
    ------------------------------------------
    |  TAB #1  | <TAB #2> |  TAB #3  |       |
    ------------------------------------------
    |                   |                    |
    |                   |                    |
    |                   |                    |
    |     BASE          |    LOCAL           |   <---- Only differences
    |                   |                    |         between BASE and
    |                   |                    |         LOCAL are shown
    |                   |                    |
    ------------------------------------------
    
    ------------------------------------------
    |  TAB #1  |  TAB #2  | <TAB #3> |       |
    ------------------------------------------
    |                   |                    |
    |                   |                    |
    |                   |                    |
    |     BASE          |    REMOTE          |   <---- Only differences
    |                   |                    |         between BASE and
    |                   |                    |         REMOTE are shown
    |                   |                    |
    ------------------------------------------


The motivation behind this was that, for non-trivial merges, the three way diff
presented in the first tab tends to be very confusing and in these cases
individual diffs between BASE and LOCAL and between BASE and REMOTE are very
useful.

I have been using a "custom" merge tool for months to achieve this same result
by adding these lines to my .gitconfig file:

  [mergetool "supermerge"]
        cmd = vim -f -d -c \"4wincmd w | wincmd J | tabnew | edit $LOCAL | vertical diffsplit $BASE | tabnew | edit $REMOTE | vertical diffsplit $BASE | 2tabprevious\" \"$LOCAL\" \"$BASE\" \"$REMOTE\" \"$MERGED\"
        trustExitCode = true

...and, because I found this "trick" very useful, I thought it would be a good
idea to add it as a git built-in merge tool (called "vimdiff4" because  1, 2 and
3 had already been taken) for everyone to use... and that's exactly what the RFC
I published did.

Now... as you can see in the RFC thread [1], David and Juno suggested that
maybe, instead of creating *yet another vimdiff variant*, we should take this
opportunity to:

  * Come up with a more general way of defining arbitrary vim layouts.
  
  * Re-implement "vimdiff1", "vimdiff2" and "vimdiff3" using this new mechanism
    (after all, the only difference among them is that they present different
    layouts to the user)

  * Add documentation to all of this.

And the result of that work is what I'm presenting today :)

Some things I would like to mention:

  1. There are three commits in this patch series:

     - The first one implements the logic to generate new arbitrary layouts and
       also re-defines "vimdiff1", "vimdiff2" and "vimdiff3" on top of it.

     - The second one adds documentation. It is probably a good idea to start
       reviewing this commit before the first one!

     - The last commit *is not meant to be merged now*. It removes "vimdiff1",
       "vimdiff2" and "vimdiff3", which is something that should only be done
       after one or two releases with a deprecation notice and only if everyone
       agrees to do so :)

  2. "mergetools/vimdiff" is now a ~800 lines bash script, but most of it is
     documentation (which is embedded in the tool itself for easier maintenance)
     and unit tests.
     I have only tested it with bash, but I've tried not to use any command not
     already being used somewhere else, so I expect it to work in the same
     places it was working before (however, let me know if there are some shell
     compatibility requirements and I'll try to check them).

  3. Regarding unit tests, "mergetool/vimdiff" contains instructions on how to
     run them (just call the script without arguments after making changes, to
     make sure you didn't break anything).
     Right now it prints "OK" on all test cases (obviously) [2]

  3. The "git {diff,merge}tool --tool-help" command now also prints the
     documentation for each tool (instead of just its name, as before).
     You can see an example of the output here ([3] and [4])

Finally, let me say that, while I like what this patch series achieves, I would
also *completely* understand if you decide not to merge it due to being a
complex solution to a simple problem that can be solved (as I had been doing up
until today) by just adding three lines to one's .gitconfig.

  [mergetool "supermerge"]
        cmd = vim -f -d -c ...(custom complex sequence of vim commands)...
        trustExitCode = true

Let me know what you think.

Thanks.

References:

  [1] https://lore.kernel.org/git/20211019212020.25385-1-greenfoo@u92.eu/#r
  [2] https://pastebin.com/kuQ5pETG
  [3] https://pastebin.com/yvLWxeiM
  [4] https://pastebin.com/qNc7qymp


New in v2:

  * Remove deprecation of vimdiff{1,2,3} (they will remain for backwards
    compatibility, but built on top of the new generic layout mechanism)

  * Remove unnecessary "IFS="

  * Replace DEBUG --> GIT_MERGETOOL_VIMDIFF_DEBUG

  * Stop using "local" (turns out it was not necessary)

  * Stop using bash arrays (use arrays of variables instead)

  * Stop using bash substring expansion (use a new "substring" function
    instead).

  * Refactor some of the internal loops to make the code faster. This was needed
    because the two previous changes (specially the one where I stop using
    "substring expansion") slowed down the script to a point where I had to wait
    for a few *seconds* before the "layout" string was resolved (recursion +
    bash forks are a recipe for sluggishness). Fortunately we are back to the
    low hundreds of milliseconds range.

  * Change markers:
    - File to save: * --> @
    - New tab     : ; --> +
    - Vert split  : | --> ,
    - Horz split  : - --> /

  * Rewrite examples to use as few parenthesis as possible (typically zero)
    and better explain operators priority.

  * Other fixes to remove problems reported by "shellcheck --shell=sh" (which
    checks syntax agains the POSIX shell spec)

  * Rename "index_..." vars to make more obvious what they do.

  * Use "$" inside arithmetic expressions $((...))
    NOTE: "shellcheck" issues a warning stating that "$" is not needed inside
    arithmetic expressions.

  * Use "test -n" instead of "! test -z"

  * Use "=" instead of "==" in "test"

  * Use "= 0" instead of "-eq 0"

  * Do not use "eval" nor "--" when copying a file to MERGED

  * Do not use "-o" with grep

  * Use <<-\EOF instead of <<\ENDOFMESSAGE and remove extra indent in "here
    docs".

  * Also, let me put here some answers to questions made in the replies to
    version v1 of this patch set:

    > What do backticks do in here?
    >
    >     some_var=(
    >         `# Name`       "Rick Deckard"
    >         `# Age`        "Unknown"
    >         `# Occupation` "Blade runner"
    >     )

    The backticks execute the code inside, which is a comment (everything after
    a "#" is considered a comment by the shell), thus it does nothing.

    The `# ...` trick can be used to insert inline comments in bash. Another
    example:

        $ ls -l `# long format` -h `# human readable` *.txt

    In any case, as you can see in this new revision, because I'm no longer
    using bash arrays, this trick to comment each test case is not needed
    anymore.

    > Why is "eval" needed here:
    >
    >     eval "$merge_tool_path" \
    >              -f "$FINAL_CMD" "$LOCAL" "$BASE" "$REMOTE" "$MERGED"

    Variable "$FINAL_CMD" contains a string that looks like this:

        $ echo $FINAL_CMD
        -c "vim cmd 1 | vim cmd 2 | ..." -c "tabfirst"

    We need to call "vim" exactly like that, but if we do this...

         $ vim $FINAL_CMD

    ...then "vim" will be excev'ed with the following arguments:

        1. -c
        2. "vim
        3. cmd
        4. 1
        ...

    ...instead of the desired scenario:

       1. -c
       2. cmd 1 | cmd 2 | ...
       3. -c
       4. tabfirst

     Using "eval" fixes this. A shorter example shows how this works:

         $ A="1 \"2 3\""

         $ ls $A
         ls: cannot access '1': No such file or directory
         ls: cannot access '"2': No such file or directory
         ls: cannot access '3"': No such file or directory

         $ eval ls $A
         ls: cannot access '1': No such file or directory
         ls: cannot access '2 3': No such file or directory

  * Finally, I think I have addressed all comments to v1 *except for two
    things*:

        1. Moving the documentation to "Documentation/" instead of having it
           embedded inside the "mergetools/vimdiff" script.

        2. Move unit tests to the "test suit"

    For (1) I would like more details. Is the idea not to print any
    documentation when running "git mergetool --tool-help" and have all the
    details included in "git help mergetool" instead?
    Right now "git help mergetool" does not mention any tool specific details
    and, instead, redirects the user to "git mergetool --tool-help" (that's why
    I originally placed the new documentation there).
    In any case, all the doc has been placed on its own commit, so once we
    decide how to proceed its just a matter of reverting it.

    For (2) I still need to investigate how this is done and prepare a "v3" if
    needed :)


New in v3:

  * Rebase on top of latest master

  * Documentation moved to "Documentation/". Running "git mergetool
    --tool-help" now works like before (ie. it just lists all available merge
    tools) except that a one line reference to a "man" entry is also printed for
    those entries providing one (right now, only vimdiff):

        $ git mergetool --tool-help
        'git mergetool --tool=<tool>' may be set to one of the following:
                        araxis
                        meld
                        vimdiff
                                Run 'man git-mergetool--vimdiff' for details
                        vimdiff1
                                Run 'man git-mergetool--vimdiff' for details
                        ...

  * New test file "t/7609-mergetool--lib.sh" created. Right now it only
    contains one test which calls "mergetools/vimdiff" with a special
    environment set, causing layout unit tests to run.


New in v4:

  * Rebase on top of latest master

  * Stop using "$" inside arithmetic expressions.

  * Remove "!/bin/bash" from the top of the "vimdiff" script.

  * Update comment explaining how the "vimdiff" script can be run.

  * Fix spaces/tabs.

  * Change the way unit tests are run (now the script is directly sourced
    instead of calling bash)

  * Remove unnecessary "case/esac" structure.

  * Fix typo in documentation


New in v5:

  * Rebase on top of latest master


New in v6:

  * Syntax corrections (spaces around parenthesis)

  * Fix layout definition of "vimdiff1"

  * Make clear how the old behaviour of the different variants (vimdiffN) is
    tested in the built in unit tests

  * Move doc into a subsection inside "git help mergetool"


New in v7:

  * Rebase on top of latest master

  * Fix some comments that had not being updated to reflect the latest changes

  * `git mergetool --tool-help` now shows the information associated to each
    entry in the same line. It also briefly explains what each variant does.

  * Apply patch from Philippe Blain that fixes HTML formatting (thanks!)

  * Add asccidoc directive to hide references to `git-mergetool` when we are
    already reading documentation from the `git-mergetool` entry

  * Fix "Vim", "Neovim", "gVim" and "Git" capitalization in docs

  * Change double and single quotes into backticks in docs where applicable

  * Fix typos in docs

  * Remove "mergetool.gvimdiff.layout" and "mergetool.nvimdiff.layout". The
    only one remaining now is "mergetool.vimdiff.layout" which defines the
    layout in all cases, no matter the vim variant we are using.

  * Remove trailing spaces

  * Only list appropiate variants ("vimdiff", "nvim" and "gvim") when running
    `git difftool --tool-help`

  * Add a short description to all other (already existing) merge/diff tools
    (Beyond Compare, xxdiff, etc...)


Fernando Ramos (4):
  vimdiff: new implementation with layout support
  vimdiff: integrate layout tests in the unit tests framework ('t'
    folder)
  vimdiff: add tool documentation
  vimdiff: add description to already existing diff/merge tools

 Documentation/config/mergetool.txt   |   9 +
 Documentation/git-mergetool.txt      |   8 +
 Documentation/mergetools/vimdiff.txt | 189 +++++++++
 git-mergetool--lib.sh                |  10 +-
 mergetools/araxis                    |   8 +
 mergetools/bc                        |   8 +
 mergetools/codecompare               |   8 +
 mergetools/deltawalker               |   8 +
 mergetools/diffmerge                 |   8 +
 mergetools/diffuse                   |   8 +
 mergetools/ecmerge                   |   8 +
 mergetools/emerge                    |   8 +
 mergetools/examdiff                  |   8 +
 mergetools/guiffy                    |   8 +
 mergetools/kdiff3                    |   8 +
 mergetools/kompare                   |   8 +
 mergetools/meld                      |   8 +
 mergetools/opendiff                  |   8 +
 mergetools/p4merge                   |   8 +
 mergetools/smerge                    |   8 +
 mergetools/tkdiff                    |   8 +
 mergetools/tortoisemerge             |   8 +
 mergetools/vimdiff                   | 607 +++++++++++++++++++++++++--
 mergetools/winmerge                  |   8 +
 mergetools/xxdiff                    |   8 +
 t/t7609-mergetool--lib.sh            |  14 +
 26 files changed, 969 insertions(+), 28 deletions(-)
 create mode 100644 Documentation/mergetools/vimdiff.txt
 create mode 100755 t/t7609-mergetool--lib.sh

-- 
2.35.1

