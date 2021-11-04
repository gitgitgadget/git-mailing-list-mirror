Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91E6BC433F5
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 16:10:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FCB26113B
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 16:10:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231639AbhKDQMr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Nov 2021 12:12:47 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:34079 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231613AbhKDQMr (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 4 Nov 2021 12:12:47 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 847515C014F;
        Thu,  4 Nov 2021 12:10:08 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 04 Nov 2021 12:10:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=u92.eu; h=from
        :to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm3; bh=qVse1xDsDcj+HqY7eThkAUuiba
        yaGswvt87SCHWKNA4=; b=fkTWXKm7zK/ppKS4/XHk2vpfrJRoT+5UzdszRvS9x1
        SVEDhAGWyncWNBU1TNm0UuSq/CkzN+zDp46HsqV8zrJ9ItEYHe1tEaiUUjfXvHNS
        l9btS/sWO1XDNYFK1kzqHUnIeZCmdTVrqfw0f1tWe2aKiKga/0EWkfSpk0PxV0sA
        f546doZSTybbLlln+6p6/8t5RPH12ITUnhwfIzgsqiZn5kiuSOzCYgY1pxa4+Ayn
        ywKMLVcIzM/Yw0YTfBB0TKnYYnDmcMQ4hsNoYMupd2lGd2DyYgzWcjUWNRi/8Y3N
        6J8iXUCEGpb4kytmo31HvG+o8PGHiKnlmrmvahErPdDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=qVse1xDsDcj+HqY7e
        ThkAUuibayaGswvt87SCHWKNA4=; b=R/zmbZLua9O0j/gjojIaO0OglpxCu20yn
        Rvx0iWh+TJikw6h91IdXUZgSux5UsDy/X55WvX1pi9iTqKBMri4EY5jBBp3+WlUe
        Y5ikKIr1FdpXIuQQaLZfdnmnVZ0HYh1sCtvAeRKS4H/0Z38nW09WIeDzTUw3FI98
        Lo38AHxXnHzBqjgn68wbgDkn2e4lJdWNKYIX67CnlBDPEbn5msKhvc4D3lmu8e2W
        ol+AXbdCR0FYu4orIz5XTV0N9K0y/AwtsS7V3JXcEl+RtUJZaJNJv+f5bssrCUam
        IRTxubwpcPT9QtPaqICQIrxzLBorebUaVzFhOyRyWRbZl1r2RI59g==
X-ME-Sender: <xms:3wWEYXF5XLgRPUArURtp30mI1g480iKQm6VDcjA7wDzDBBpTLi3IwA>
    <xme:3wWEYUVXnc6PTSg24-55R5XncgW_-uyNVRDss2GA4laudV6Lo4XLqGIgJiLmJG-QA
    UWUwuwWtkGBtlcmXw>
X-ME-Received: <xmr:3wWEYZJ-YpYFVlzEcGC0O45lufI1Oa0XxJJicm5Dbq9aYLxa2VNW9WOaDbOnvvn4aHn6ljeqtHo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrtdeggdektdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertdertd
    dtnecuhfhrohhmpefhvghrnhgrnhguohcutfgrmhhoshcuoehgrhgvvghnfhhoohesuhel
    vddrvghuqeenucggtffrrghtthgvrhhnpefgieefudehgeduheefveffhfffleeifeetfe
    efheegieelkeeuhfeggeeutefhieenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhp
    rghsthgvsghinhdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehgrhgvvghnfhhoohesuhelvddrvghu
X-ME-Proxy: <xmx:3wWEYVF8IhXLA0vnteX4lcwlu9Plvr18b0HcWJ5JQ0fz797wWC6oWQ>
    <xmx:3wWEYdV4TxCDk7othb577egEUskWut1C72Lfvv-2M41WQm9w-ANnhQ>
    <xmx:3wWEYQNtqPMLrpUE4b_j2HLXfRzgR7LWU4CVUuZoIjQeG58yFL1FPQ>
    <xmx:4AWEYTxJo0frSkQRtfwb64OXM91IP1nGeJhBjjVUlE8o23sh31S4gw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Nov 2021 12:10:05 -0400 (EDT)
From:   Fernando Ramos <greenfoo@u92.eu>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, davvid@gmail.com, seth@eseth.com,
        levraiphilippeblain@gmail.com, rogi@skylittlesystem.org
Subject: [PATCH 0/3] vimdiff: new layout option + docs
Date:   Thu,  4 Nov 2021 17:09:56 +0100
Message-Id: <20211104160959.183402-1-greenfoo@u92.eu>
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


Fernando Ramos (3):
  vimdiff: new implementation with layout support
  vimdiff: add tool documentation
  vimdiff: remove deprecated {,g,n}vimdiff{1,2,3} variants

 git-mergetool--lib.sh |  12 +
 mergetools/vimdiff    | 697 ++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 677 insertions(+), 32 deletions(-)


base-commit: 876b1423317071f43c99666f3fc3db3642dfbe14
-- 
2.33.1

