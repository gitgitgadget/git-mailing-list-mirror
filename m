Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 827351F404
	for <e@80x24.org>; Tue, 10 Apr 2018 20:28:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753179AbeDJU2Z (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Apr 2018 16:28:25 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:48765 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752676AbeDJU2X (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Apr 2018 16:28:23 -0400
Received: from furore ([82.194.150.97]) by mrelayeu.kundenserver.de (mreue103
 [212.227.15.183]) with ESMTPSA (Nemesis) id 0Lpyfn-1eaUPl1kvP-00fgoy; Tue, 10
 Apr 2018 22:28:18 +0200
Date:   Tue, 10 Apr 2018 22:28:16 +0200
From:   Florian =?utf-8?Q?Gamb=C3=B6ck?= <mail@floga.de>
To:     git@vger.kernel.org
Cc:     Szeder =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH v2 1/1] completion: load completion file for external
 subcommand
Message-ID: <20180410202758.5877-2-mail@floga.de>
Mail-Followup-To: git@vger.kernel.org,
        Szeder =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>
References: <20180410202758.5877-1-mail@floga.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180410202758.5877-1-mail@floga.de>
X-Mailer: git-send-email 2.16.1
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Provags-ID: V03:K1:tTlw0hGJ2lRUhPALnY42aDExb+1TeqYj56xABgIIUa9BHa6RX9B
 vlFCJSsaxKhMmlXjcR1qZWtnnzYDFif98hAoobdOTm2UGSlhwswwjWabAwzwAe8wshtTvTB
 CoEQbyM4N9xNvW8jxWEp7v6wHuLLDzO/AG+yadcgzgOI7u/fNDYyZlepH4XGoMfofXnI2Yk
 5UgV9vkNPU/IyvM2iHzrQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:YkiTCXQDsgk=:eDtNp2rTDWvmpQBz+t28Hx
 3gJdfFBoaVkJM6M1nML93erg0P3csUevTe0AdqGbtVtn7SIKZ72JlxzPf41TznmulodVwgcYl
 rYxPGua5rEF9EJ34tqmqHyfq54vJLesAlmSdB1ZOo17XDqLTEXjEcfg7V4ZQtrRoZM6olm9xx
 UIYrlJ0GWUDi1YCSgM6hhjpIpSvCxsWLSXbkWJ60gU+O76jOwb1tfkdq52TzXW1uHYE0ky8bN
 BJ8L704iB+j1IxEgYVHzEkOovNg3OAxmI/SCcDAkIRVNud8hoB+LmFxqwWogtinJYdp4N6x7E
 iJIqjFdB4U21/x51xMB984KSZg0iy91P2BW1A0ByXsHibRFx/KM7C8zw1CLbOwrUWQ7/x7mvX
 nsr4LDwLm3+Zu9/SdlI7g+9p4bNnxDtsgYZ5pAgOqOXdO2wmbZ+GFq5z2RlXXCAdTMelWOXDJ
 TPxDQGNiBUfWAJyngx/K960pkrJX1EV0h9BkSx1FF77yHzaCODxf708CHmWQmICOHi31+DMKb
 VkX4XPaChPAvh5Yzv/bU/011fEKZVYfj70ytEEB2a7d/2ry4CSGrOPV5HeB9bfRWkz5hSzExM
 QAfUhE3qnBPjTJUbh7BFYA6ux+XMEnuchikAlFDChldsRTFUnjZTY6lPt+gWJgwRIee+rH8wX
 +/elLz8btGgQWGI5bjQGAQF5j1xAOQsmGkWUOjKGZYR7Ot2VhP5iVg6Lm7MdALRKvsjXzz7Jv
 R3IjOXfPLp2s3tX6gPVpVyIiuBB1lUtpT/4BOw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adding external subcommands to Git is as easy as to put an executable
file git-foo into PATH. Packaging such subcommands for a Linux
distribution can be achieved by unpacking the executable into /usr/bin
of the user's system. Adding system-wide completion scripts for new
subcommands, however, can be a bit tricky.

Since bash-completion started to use dynamical loading of completion
scripts since v1.90 (preview of v2.0), it is no longer sufficient to
drop a completion script of a subcommand into the standard completions
path, /usr/share/bash-completion/completions, since this script will not
be loaded if called as a git subcommand.

For example, look at https://bugs.gentoo.org/544722. To give a short
summary: The popular git-flow subcommand provides a completion script,
which gets installed as /usr/share/bash-completion/completions/git-flow.

If you now type into a Bash shell:

    git flow <TAB>

You will not get any completions, because bash-completion only loads
completions for git and git has no idea that git-flow is defined in
another file. You have to load this script manually or trigger the
dynamic loader with:

    git-flow <TAB> # Please notice the dash instead of whitespace

This will not complete anything either, because it only defines a Bash
function, without generating completions. But now the correct completion
script has been loaded and the first command can use the completions.

So, the goal is now to teach the git completion script to consider the
possibility of external completion scripts for subcommands, but of
course without breaking current workflows.

I think the easiest method is to use a function that is defined by
bash-completion v2.0+, namely __load_completion. It will take care of
loading the correct script if present. Afterwards, the git completion
script behaves as usual.

This way we can leverage bash-completion's dynamic loading for git
subcommands and make it easier for developers to distribute custom
completion scripts.

Signed-off-by: Florian Gamböck <mail@floga.de>
---
 contrib/completion/git-completion.bash | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index b09c8a236..09a820990 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -3096,12 +3096,22 @@ __git_main ()
 	fi
 
 	local completion_func="_git_${command//-/_}"
+	if ! declare -f $completion_func >/dev/null 2>/dev/null &&
+		declare -f __load_completion >/dev/null 2>/dev/null
+	then
+		__load_completion "git-$command"
+	fi
 	declare -f $completion_func >/dev/null 2>/dev/null && $completion_func && return
 
 	local expansion=$(__git_aliased_command "$command")
 	if [ -n "$expansion" ]; then
 		words[1]=$expansion
 		completion_func="_git_${expansion//-/_}"
+		if ! declare -f $completion_func >/dev/null 2>/dev/null &&
+			declare -f __load_completion >/dev/null 2>/dev/null
+		then
+			__load_completion "git-$expansion"
+		fi
 		declare -f $completion_func >/dev/null 2>/dev/null && $completion_func
 	fi
 }
-- 
2.16.1

