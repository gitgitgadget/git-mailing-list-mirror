Return-Path: <SRS0=o1/V=3D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00E0FC33CB3
	for <git@archiver.kernel.org>; Tue, 14 Jan 2020 18:44:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6CCC24670
	for <git@archiver.kernel.org>; Tue, 14 Jan 2020 18:43:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aexwRJmn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728773AbgANSn6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jan 2020 13:43:58 -0500
Received: from mail-wr1-f45.google.com ([209.85.221.45]:42087 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726450AbgANSn5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jan 2020 13:43:57 -0500
Received: by mail-wr1-f45.google.com with SMTP id q6so13198840wro.9
        for <git@vger.kernel.org>; Tue, 14 Jan 2020 10:43:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=b01smkcgDUzUOeMy6h/wJNFqVi4MYNYOW3uYsxeiD1I=;
        b=aexwRJmn1NgzH96N1S5deMp0yKOn424erKc1oB+FDfhZGSXr92336We3RjIr9x73Ao
         cDkkusnSEOfB6ROsIZ6a9W/1nNxnqD9A+Gb5uuBTokznlIX/1RgPt+MUGBB+VPV1Tk1P
         WLTxZ7EJgZqHQjx5idMXUAY2B2tg+l0MIrtaXLaJ96YHC6jUWg+F54ht9MlzSi/AZd3q
         I+8sMtaI6dQAvGm8PKrz3T1IFOum9N5267mYOqxs9/5ViqZI1X/Vq8eiFABw/9sESw5/
         0B17snXEhBcRVw/5fheI1U9RhFLBvOOQVhmP3OG8cplub+NYVLz9OmBhA9UbtpvtGHE7
         vUqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=b01smkcgDUzUOeMy6h/wJNFqVi4MYNYOW3uYsxeiD1I=;
        b=YR0E+QXGgyYPeVgSOVd3LRdpTmvbAaxaFyZnwPsyEgrxslM0veUhwSnq6mqhOLS4TA
         B5YGF2h5FOD6O3miA6mi+IaHdq/cWLv/IJsOaYmxwOSo8Fm4ijDnqJ84J8qvEJJ0vzls
         bZnqBh9lMGvSJ8Uslcg5qHMPZ3T8jLZSvV7GtkESlqH3ts8TNUked/Wz0YVK/3UoAOMg
         s49JzBCliafRORQihp34wPsoJOIpRNLitZCpmuoDk1Yt2E2p7OkNbOIzZ2qIcfjXYllE
         /AuPL2do0InzZtsLV02SJnRjfFg3Pc2Ze7lGj4UXmK/ag73YrO7hvZ0/K3Eah73Q816J
         58ow==
X-Gm-Message-State: APjAAAXbIgpHSDq5Xv7zpcRcb/ci4iC1vGWh5bTk+9wh8BL6b/SZbWiv
        IW/n/mHP45lM1F2Fh71uvBVP1EYJ
X-Google-Smtp-Source: APXvYqw8VljhCr78Q7B8m1AQGncj3a1gn0EcCD9V9os3NcNOLAUkVCIwv2KXOUVX9bsVevO/BnBlSg==
X-Received: by 2002:a5d:53c1:: with SMTP id a1mr25829472wrw.373.1579027435280;
        Tue, 14 Jan 2020 10:43:55 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i16sm20858729wmb.36.2020.01.14.10.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 10:43:54 -0800 (PST)
Message-Id: <pull.175.v4.git.1579027433.gitgitgadget@gmail.com>
In-Reply-To: <pull.175.v3.git.1578904171.gitgitgadget@gmail.com>
References: <pull.175.v3.git.1578904171.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 14 Jan 2020 18:43:43 +0000
Subject: [PATCH v4 00/10] built-in add -p: add support for the same config settings as the Perl
 version
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the final leg of the journey to a fully built-in git add: the git
add -i and git add -p modes were re-implemented in C, but they lacked
support for a couple of config settings.

The one that sticks out most is the interactive.singleKey setting: it was
particularly hard to get to work, especially on Windows.

It also seems to be the setting that is incomplete already in the Perl
version of the interactive add command: while the name of the config setting
suggests that it applies to all of the interactive add, including the main
loop of git add --interactive and to the file selections in that command, it
does not. Only the git add --patch mode respects that setting.

As it is outside the purpose of the conversion of git-add--interactive.perl 
to C, we will leave that loose end for some future date.

Changes since v3:

 * Reverted that heavy-handed SIGPIPE handling.
 * Instead, changed the diffFilter test case to process the standard input
   instead of ignoring it.

(The range diff between v2 and v4 actually only shows the new patch 1/10
"t3701: adjust difffilter test".)

Changes since v2:

 * Fixed the SIGPIPE issue pointed out by Gábor Szeder.

Changes since v1:

 * Fixed the commit message where a copy/paste fail made it talk about
   another GIT_TEST_* variable than the GIT_TEST_ADD_I_USE_BUILTIN one.

Johannes Schindelin (10):
  t3701: adjust difffilter test
  built-in add -p: support interactive.diffFilter
  built-in add -p: handle diff.algorithm
  terminal: make the code of disable_echo() reusable
  terminal: accommodate Git for Windows' default terminal
  terminal: add a new function to read a single keystroke
  built-in add -p: respect the `interactive.singlekey` config setting
  built-in add -p: handle Escape sequences in interactive.singlekey mode
  built-in add -p: handle Escape sequences more efficiently
  ci: include the built-in `git add -i` in the `linux-gcc` job

 add-interactive.c          |  19 +++
 add-interactive.h          |   4 +
 add-patch.c                |  57 ++++++++-
 ci/run-build-and-tests.sh  |   1 +
 compat/terminal.c          | 249 ++++++++++++++++++++++++++++++++++++-
 compat/terminal.h          |   3 +
 t/t3701-add-interactive.sh |   2 +-
 7 files changed, 326 insertions(+), 9 deletions(-)


base-commit: c480eeb574e649a19f27dc09a994e45f9b2c2622
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-175%2Fdscho%2Fadd-p-in-c-config-settings-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-175/dscho/add-p-in-c-config-settings-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/175

Range-diff vs v3:

  1:  5e258a8d2b <  -:  ---------- built-in add -i/-p: treat SIGPIPE as EOF
  -:  ---------- >  1:  e12df77e8a t3701: adjust difffilter test
  2:  2a5951ecfe !  2:  413a87bd79 built-in add -p: support interactive.diffFilter
     @@ -35,9 +35,9 @@
       	strbuf_release(&header);
       	prefix_item_list_clear(&commands);
      +	clear_add_i_state(&s);
     - 	sigchain_pop(SIGPIPE);
       
       	return res;
     + }
      
       diff --git a/add-interactive.h b/add-interactive.h
       --- a/add-interactive.h
     @@ -123,14 +123,13 @@
       		strbuf_release(&s.plain);
       		strbuf_release(&s.colored);
      +		clear_add_i_state(&s.s);
     - 		sigchain_pop(SIGPIPE);
       		return -1;
       	}
     + 
      @@
       	strbuf_release(&s.buf);
       	strbuf_release(&s.plain);
       	strbuf_release(&s.colored);
      +	clear_add_i_state(&s.s);
     - 	sigchain_pop(SIGPIPE);
       	return 0;
       }
  3:  a2bce01818 =  3:  062c624547 built-in add -p: handle diff.algorithm
  4:  be40a37c0c =  4:  09a8946303 terminal: make the code of disable_echo() reusable
  5:  233f23791c =  5:  a81304cb76 terminal: accommodate Git for Windows' default terminal
  6:  74593b5115 =  6:  8d9c703f3b terminal: add a new function to read a single keystroke
  7:  197fe1e14a !  7:  8ed4487ae4 built-in add -p: respect the `interactive.singlekey` config setting
     @@ -48,9 +48,9 @@
       --- a/add-patch.c
       +++ b/add-patch.c
      @@
     + #include "pathspec.h"
       #include "color.h"
       #include "diff.h"
     - #include "sigchain.h"
      +#include "compat/terminal.h"
       
       enum prompt_mode_type {
  8:  9ab381d539 =  8:  cdc609f8fa built-in add -p: handle Escape sequences in interactive.singlekey mode
  9:  bdb6268b8b =  9:  80b0f2528d built-in add -p: handle Escape sequences more efficiently
 10:  c4195969a6 = 10:  7ab7ec62d0 ci: include the built-in `git add -i` in the `linux-gcc` job

-- 
gitgitgadget
