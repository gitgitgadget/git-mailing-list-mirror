Return-Path: <SRS0=G+/Y=3C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47083C33CAB
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 08:29:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18C1A21569
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 08:29:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HE/45DfY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728829AbgAMI3f (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jan 2020 03:29:35 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38339 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728699AbgAMI3f (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jan 2020 03:29:35 -0500
Received: by mail-wr1-f65.google.com with SMTP id y17so7559435wrh.5
        for <git@vger.kernel.org>; Mon, 13 Jan 2020 00:29:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=5a2G3SfvnIj4RD9P1vG6UCR8aJq4+46AsRFFIB/Cfec=;
        b=HE/45DfY8kYrvfw3q9b8ewuZgET9KX5qVoHN1pJ/j3cl8PIy+MYkKHNLxAwGRl9THP
         POYsK7gA/BvEPnWOi4OTeaRuIYznWhpsIqR2tst0lqktg0dyiiuh2/xyPylqhRr6edeJ
         QsqRgVsRPfPpYQngUd3L+eT5vFCswmp5LZ5U5lfMS6iPq6Zw++5Mi1hCWp8TALO6KWxN
         o7L75kqrsrROpckDz5aXpEIf5BZulcPQfImtUFKLgcXOp/WgmMqbfTV4QlNkLJLoRnT4
         PgDIaIlF5op31zTNizhfBKLslBX2lEQGGS79W4mA24z9yIxqVIuKj1rU8+QhViaT/rG8
         7jxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=5a2G3SfvnIj4RD9P1vG6UCR8aJq4+46AsRFFIB/Cfec=;
        b=e6rsl3HOHuR+Drj3Pt4XK7dpiBKXc3osb5Ortd4Z7fQsm6G+YzIveAxS4pKbBHe+il
         MXMfdqzlUb0BteUTNF1T6vJ4TmH48lK270s6I/kd0isAmOG2bFIHb71jNBtvmdVk3L4Y
         5RGU7+RMuwNGSruIa77gTGWWxlm5sXOiwUSjhKCkxZw4O0bLJnoboyVtdTgDMqnTQh7y
         W6C2NLLur5V6p2bvL4tK2SY9NkvTRbbI0yT5jcGYW4l4VzxPQZjU8X4xgwRPkeYfpJzO
         RMDW3sHQXTAj4X8BRJZ9PJJhoAPz7cG/ItxB7QKADZl6ux/0LEWOoGkkD8vj8n+4qNz9
         f0LA==
X-Gm-Message-State: APjAAAU+H1vZ56TO4mIYoeSQAujvQ3uf5yv929K2TA9jLCaGxJOz9tIg
        nHXlN5TJTTZsPeEmEHZLlkhMCZrI
X-Google-Smtp-Source: APXvYqwyRSAbi0elGahohJ7ql91uTx8P1VxbqdOFE4mXqyDpFZULcdCYpT9C/ArHlkluSt+vFkNwcg==
X-Received: by 2002:adf:f8c4:: with SMTP id f4mr16696797wrq.243.1578904172694;
        Mon, 13 Jan 2020 00:29:32 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a1sm13249958wmj.40.2020.01.13.00.29.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 00:29:32 -0800 (PST)
Message-Id: <pull.175.v3.git.1578904171.gitgitgadget@gmail.com>
In-Reply-To: <pull.175.v2.git.1577275020.gitgitgadget@gmail.com>
References: <pull.175.v2.git.1577275020.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 13 Jan 2020 08:29:21 +0000
Subject: [PATCH v3 00/10] built-in add -p: add support for the same config settings as the Perl
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

Changes since v2:

 * Fixed the SIGPIPE issue pointed out by Gábor Szeder.

Changes since v1:

 * Fixed the commit message where a copy/paste fail made it talk about
   another GIT_TEST_* variable than the GIT_TEST_ADD_I_USE_BUILTIN one.

Johannes Schindelin (10):
  built-in add -i/-p: treat SIGPIPE as EOF
  built-in add -p: support interactive.diffFilter
  built-in add -p: handle diff.algorithm
  terminal: make the code of disable_echo() reusable
  terminal: accommodate Git for Windows' default terminal
  terminal: add a new function to read a single keystroke
  built-in add -p: respect the `interactive.singlekey` config setting
  built-in add -p: handle Escape sequences in interactive.singlekey mode
  built-in add -p: handle Escape sequences more efficiently
  ci: include the built-in `git add -i` in the `linux-gcc` job

 add-interactive.c         |  22 ++++
 add-interactive.h         |   4 +
 add-patch.c               |  61 +++++++++-
 ci/run-build-and-tests.sh |   1 +
 compat/terminal.c         | 249 +++++++++++++++++++++++++++++++++++++-
 compat/terminal.h         |   3 +
 6 files changed, 332 insertions(+), 8 deletions(-)


base-commit: c480eeb574e649a19f27dc09a994e45f9b2c2622
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-175%2Fdscho%2Fadd-p-in-c-config-settings-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-175/dscho/add-p-in-c-config-settings-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/175

Range-diff vs v2:

  -:  ---------- >  1:  5e258a8d2b built-in add -i/-p: treat SIGPIPE as EOF
  1:  f45ff08bd0 !  2:  2a5951ecfe built-in add -p: support interactive.diffFilter
     @@ -35,9 +35,9 @@
       	strbuf_release(&header);
       	prefix_item_list_clear(&commands);
      +	clear_add_i_state(&s);
     + 	sigchain_pop(SIGPIPE);
       
       	return res;
     - }
      
       diff --git a/add-interactive.h b/add-interactive.h
       --- a/add-interactive.h
     @@ -123,13 +123,14 @@
       		strbuf_release(&s.plain);
       		strbuf_release(&s.colored);
      +		clear_add_i_state(&s.s);
     + 		sigchain_pop(SIGPIPE);
       		return -1;
       	}
     - 
      @@
       	strbuf_release(&s.buf);
       	strbuf_release(&s.plain);
       	strbuf_release(&s.colored);
      +	clear_add_i_state(&s.s);
     + 	sigchain_pop(SIGPIPE);
       	return 0;
       }
  2:  e9c4a13cbf =  3:  a2bce01818 built-in add -p: handle diff.algorithm
  3:  e643554dba =  4:  be40a37c0c terminal: make the code of disable_echo() reusable
  4:  bd2306c5d5 =  5:  233f23791c terminal: accommodate Git for Windows' default terminal
  5:  190fb4f5e9 =  6:  74593b5115 terminal: add a new function to read a single keystroke
  6:  167dfa37dd !  7:  197fe1e14a built-in add -p: respect the `interactive.singlekey` config setting
     @@ -48,9 +48,9 @@
       --- a/add-patch.c
       +++ b/add-patch.c
      @@
     - #include "pathspec.h"
       #include "color.h"
       #include "diff.h"
     + #include "sigchain.h"
      +#include "compat/terminal.h"
       
       enum prompt_mode_type {
  7:  32067bebe8 =  8:  9ab381d539 built-in add -p: handle Escape sequences in interactive.singlekey mode
  8:  703719ffce =  9:  bdb6268b8b built-in add -p: handle Escape sequences more efficiently
  9:  23a3a47b01 = 10:  c4195969a6 ci: include the built-in `git add -i` in the `linux-gcc` job

-- 
gitgitgadget
