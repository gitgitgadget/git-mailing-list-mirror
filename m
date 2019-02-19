Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F0C281F453
	for <e@80x24.org>; Tue, 19 Feb 2019 18:01:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbfBSSBh (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Feb 2019 13:01:37 -0500
Received: from egnor-li.ofb.net ([23.92.24.4]:39928 "EHLO egnor-li.ofb.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726110AbfBSSBh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Feb 2019 13:01:37 -0500
Received: from ofb.net (163.242.197.104.bc.googleusercontent.com [104.197.242.163])
        by egnor-li.ofb.net (Postfix) with ESMTP id F24B811801C;
        Tue, 19 Feb 2019 17:54:33 +0000 (UTC)
Received: from localhost.localdomain (unknown [173.239.75.234])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ofb.net (Postfix) with ESMTPSA id B23663EE5A;
        Tue, 19 Feb 2019 09:54:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ofb.net; s=ofb;
        t=1550598873; bh=L6MXgl/PBdei5igHOr7dKmUSglgRwgJSFkxgqTV+gEA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AVx6XIJT2Yk0hGYgfOOqTDYAKQz8w2mHUtdyiop3j3GXR0t48KwWHyCST6+rNDkEa
         32FyoxsXUu78AlakmarrbMqd926X7JxAIYjk7ZibSM1VI+AilB+qFccFJGlhEYRd5j
         kppHKxZJVRcmHci/bk2FZJ7ykJHeJONx5KqsTqmRTtwV0OXQISUM+2HvNGR6p4LbGn
         WGkoQgVz7Fzr+94bzBdiNzJrrQ6cYy7pC0FQTL4aoa4IhRze9syVhpvmT9lA6ZprGH
         RtIChMkdb+MlFnLcRYvBIv/AfHuehvB2ojmglKFxAiN4P1Ncn1TalvDomSG9Cn/1Fg
         TxfXwJVlhyeXg==
Received: from frederik by localhost.localdomain with local (Exim 4.91)
        (envelope-from <frederik@localhost.localdomain>)
        id 1gw9bF-0004lj-5J; Tue, 19 Feb 2019 09:54:33 -0800
From:   Frederick Eaton <frederik@ofb.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Frederick Eaton <frederik@ofb.net>
Subject: [PATCH 0/1] de-alphabetize command list
Date:   Tue, 19 Feb 2019 09:54:12 -0800
Message-Id: <20190219175413.18292-1-frederik@ofb.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <xmqqva8e5dxj.fsf@gitster-ct.c.googlers.com>
References: <xmqqva8e5dxj.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a follow-up to my proposal to de-alphabetize the command
listings in the git(1) manual page, from 6 July 2018.

Some projects have manual page items listed in alphabetical order,
some don't. As I argued in my proposal, I find it easier to learn from
material which is not alphabetized. If this patch is accepted, I hope
that it will make the Git documentation more accessible to myself and
others.

I produced the reordered command list in this patch using several
sources, as indicated by comments in the new command-list.txt file.
First, all the commands in the main part of "gittutorial(7)" appear in
order, then the commands in giteveryday(7). Then appear additional
commands from a friend's shell history, in reverse order of frequency.
Then gittutorial-2(7), then gitcore-tutorial(7). After that there is a
list of "guides", followed by about 100 commands not appearing in the
earlier lists. I kept the guides and the remaining commands in their
category groupings (guide, mainporcelain, ancillarymanipulators,
etc.), but ordered the commands within each category according to my
own judgment after skimming each manual page.

To verify that the new list is a permutation of the most recent list,
I use the following command (it should produce no output and exit 0):

    diff <(git show master:command-list.txt | grep -v '^#' | sort ) <(cat command-list.txt | grep -v '^#' | sort)

Note this patch changes the order of commands appearing in the
generated file "command-list.h", which mostly seems to be used by
"help.c". Probably due to the various occurrences of QSORT in
"help.c", I think this reordering has no visible effect. I am willing
to do any additional testing which may be recommended to ensure that
this patch has no undesired consequences.

Frederick Eaton (1):
  Prioritize list of commands appearing in git(1), via command-list.txt.
    Don't invoke 'sort' in Documentation/cmd-list.perl.

 Documentation/cmd-list.perl |   2 +-
 command-list.txt            | 295 +++++++++++++++++++-----------------
 2 files changed, 158 insertions(+), 139 deletions(-)

-- 
2.20.1

