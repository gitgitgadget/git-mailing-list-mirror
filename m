Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58702C433EF
	for <git@archiver.kernel.org>; Sun, 14 Nov 2021 17:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C0AA61027
	for <git@archiver.kernel.org>; Sun, 14 Nov 2021 17:42:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235272AbhKNRlX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Nov 2021 12:41:23 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:46831 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229725AbhKNRlW (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 14 Nov 2021 12:41:22 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 32C3E32009DB;
        Sun, 14 Nov 2021 12:38:26 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Sun, 14 Nov 2021 12:38:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=u92.eu; h=from
        :to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm3; bh=zEsuyLnllRGic7k0TSvV00eKHN
        eR0g5GXhwIriYmORM=; b=Q03iqMEJE5GKFO49dy24FXR5c6DQD8o+IT2fZBiUcK
        phBn/mw2zFG1WlUDM5fhGyPJ1F4nKQrLjsSaYvFErcooxfpuuiSU45NuMbR3ex0A
        F3/6YtCDQ0Ltxyi3D/rWJtutsiVpUAq5wKonWb2ZpSGK9KFiHzeBPSGRs3CFPR3W
        WbAqeokPTwLFKr7de2vAwe9bPWCS++V4fdOcQ9BkDXPlTy0ETb10hgMvTNmk9yzH
        c4l68wN0Ecb7P3Vx2lThEsTntS9dZQ04NrWX2J3/RE7dTUrvMxiLsGRbE5avrhpm
        jM+9Rf4130tGiDpnRsFGlpmnSjii9jd1wwiFKe2V78Lg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=zEsuyLnllRGic7k0T
        SvV00eKHNeR0g5GXhwIriYmORM=; b=RWYsYi0r5uoZ+0tiCj0s+/VgRGz9sWcqq
        GVeHGbbY/OMI7zLbgFEvZjZqJMS6wFHZu7I9j6krnWGb1y4Xgz1hbYW//Y46GjtA
        WFNSm8MAtquxhMWBhhjVocRBG88Qq/BbZTf1eYKNMTpR3K5M5p+hD/w1IYkzWRTZ
        OuTzZn4OjqTx/l3KKRwa54lhYvVWljE28TxnfEolHCN/jIaLDEJRsA2AyKQb7SN9
        D3eJLlf6BbJQFohjqLEYbhBb+5P59CxoQFtopFgT450DQRTOUEiJB+63umhxEHMK
        yUW9SQm0GByPyD+e5HHeTC/+JcqYBgX1rL6ZTzUEo4Dv+jeGzGYmA==
X-ME-Sender: <xms:kUmRYS952p6PyT3d7z4LyaFH59Js8unnBeEZ5eoiW0pnD4q2ZcqNPg>
    <xme:kUmRYSvvL63zmMrsUzdb9fLytmGnayJVaudFuUvjfmTVdePnXJujZCBRSWG5YhKN_
    Mqg7_A0a0Drm7hmoQ>
X-ME-Received: <xmr:kUmRYYDPTYt9U8GRnYDjxtTgEDEJsdIjldTvId6UJbsOd2EHidcwrfQSUKcLPToOdvBB>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrvdejgddutddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
    dttdenucfhrhhomhephfgvrhhnrghnughoucftrghmohhsuceoghhrvggvnhhfohhosehu
    ledvrdgvuheqnecuggftrfgrthhtvghrnhepgfeifeduheegudehfeevfffhffelieefte
    effeehgeeileekuefhgeegueethfeinecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdp
    phgrshhtvggsihhnrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepghhrvggvnhhfohhosehuledvrdgvuh
X-ME-Proxy: <xmx:kUmRYafFcccYn--u1EPIij-vq_TiuWgGdSCrRmsQxAYKcuJpmMEIoQ>
    <xmx:kUmRYXP2PGfar7QoUpI-q0tqiVByqoLWvgHawekfIMu_eeJpjACqYA>
    <xmx:kUmRYUndSicgpSh64kxI0moMvMOf0pIUUbkFILhWxXnn2GVp1sLMGw>
    <xmx:kUmRYS32fVvDW_FdOvWyAgwzaMqftnRX08fKpF9CaD7vIBuq9RfPxQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 14 Nov 2021 12:38:23 -0500 (EST)
From:   Fernando Ramos <greenfoo@u92.eu>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, davvid@gmail.com, sunshine@sunshineco.com,
        seth@eseth.com, levraiphilippeblain@gmail.com,
        rogi@skylittlesystem.org
Subject: [PATCH v2 0/2] vimdiff: new layout option + docs
Date:   Sun, 14 Nov 2021 18:38:18 +0100
Message-Id: <20211114173820.687467-1-greenfoo@u92.eu>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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
indivial diffs between BASE and LOCAL and between BASE and REMOTE are very
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
until today) by just adding three line to one's .gitconfig.

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

  * Rewrite examples to use as many parenthesis as possible (typically zero)
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


Fernando Ramos (2):
  vimdiff: new implementation with layout support
  vimdiff: add tool documentation

 git-mergetool--lib.sh |  14 +
 mergetools/vimdiff    | 820 ++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 809 insertions(+), 25 deletions(-)


base-commit: 5a73c6bdc717127c2da99f57bc630c4efd8aed02
-- 
2.33.1

