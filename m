Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 609C2C4332F
	for <git@archiver.kernel.org>; Wed,  9 Nov 2022 09:07:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbiKIJHV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Nov 2022 04:07:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbiKIJHF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Nov 2022 04:07:05 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1379620BC0
        for <git@vger.kernel.org>; Wed,  9 Nov 2022 01:07:04 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id z26so16144289pff.1
        for <git@vger.kernel.org>; Wed, 09 Nov 2022 01:07:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WKNwNi21DURxI3Uz4TYiHQl3NjrlU+MWw4hIi8iqVMQ=;
        b=Cq1964zVH79eaDvc79uT54LsXOEqxyfdvIe1z/wLrHw3VqN5PZ/xe86al6Jv++NdMU
         0p71KbU5ko5dZqrEup4hnJ7Y1tBOqTzJt1MnGtJihT13zBJTcjRg9tlE4y9CkDxD028u
         kDJ6hH6Zb5emO+8iveO8ZdAbtfqpjb1GeWitiRgVCp829dTiTnaT8rk3/utSRQHz4xdC
         ri0pmAL9zgN6thZ2dFFuzoz+BGcvquvBuJ+Mk2JPAsbPMsR7Q/zvp3pgkQ2uBhRGIdXX
         yVUiMEubZo1lpCx2VvSOK7GCuQ5FEDRpcXlhraBW/ViQuyxD/OcKSXwMpEortC5iTSJX
         +tFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WKNwNi21DURxI3Uz4TYiHQl3NjrlU+MWw4hIi8iqVMQ=;
        b=8IYzOaCnotDARVXPKVBLqp0N/Ek1/ofn8kR4hmtOHfTjGpn06jOQrhXQaneU29q4FO
         q1u8jKEaGk81aioggYKgZ6GdoD5NFQeY0Ru2VRCuEmDlkcytnnEeTfZK7x4yTQdePSBd
         GemxZuYd3o8eVDwxvrI0MOJeYqRfklxt+eqIM2JAvqTnQBO9MgoJ94COH855KAJ8Zn2y
         IOYb6zpZAJ411bSR0KPlS+9KCFohCgituA5qyrxSYMo0a+1W1B9logf+Ie+JnixqyvtY
         OHU38hLpXbd/6NFAtVPGAdLCNDNirsJ2ehWik4knemszdF8IfLD9oE2ppXzkbM6aLBun
         ECDw==
X-Gm-Message-State: ACrzQf2Pmgm9t4d5UQXa3gBaI++TfgbQtWzmJKZsLqMu7ihDPbV2vq1S
        BUq8PQA0DdR4vXTPyVJ/HoA=
X-Google-Smtp-Source: AMsMyM7I2fzmzFZJp2cVBoDRpfv0+9wwFTF6miMWEHeEQwsYG/UG8r+MOvcCZbRtEMMTwYCtdyHY+g==
X-Received: by 2002:a05:6a00:340f:b0:56d:b039:202 with SMTP id cn15-20020a056a00340f00b0056db0390202mr46567345pfb.2.1667984823471;
        Wed, 09 Nov 2022 01:07:03 -0800 (PST)
Received: from localhost.localdomain ([47.246.101.63])
        by smtp.gmail.com with ESMTPSA id mg7-20020a17090b370700b00212d4cbcbfdsm727509pjb.22.2022.11.09.01.07.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Nov 2022 01:07:03 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, git@vger.kernel.org, tenglong.tl@alibaba-inc.com
Subject: [PATCH v3 0/5] notes.c: introduce "--no-blank-line" option 
Date:   Wed,  9 Nov 2022 17:06:51 +0800
Message-Id: <cover.1667980450.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.38.1.386.g196e80358e8
In-Reply-To: <cover.1667828335.git.dyroneteng@gmail.com>
References: <cover.1667828335.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Teng Long <dyroneteng@gmail.com>

Diff since v2:

* [5/5] make "--no-blank-line" in doc.
* [1/5] [2/5][3/5]do some cleanups and split to serval independent commit.
* [3/5] futher explain in commit-msg why we can drop it in "append" but not "add".
* [4/5] [4/5] use "test_when_finished" to cleanup notes in tests.

Thanks.

Teng Long (5):
  notes.c: cleanup 'strbuf_grow' call in 'append_edit'
  notes.c: cleanup for "designated init" and "char ptr init"
  notes.c: drop unreachable code in 'append_edit()'
  notes.c: provide tips when target and append note are both empty
  notes.c: introduce "--no-blank-line" option

 Documentation/git-notes.txt | 10 ++++++++--
 builtin/notes.c             | 20 ++++++++++----------
 t/t3301-notes.sh            | 18 ++++++++++++++++--
 3 files changed, 34 insertions(+), 14 deletions(-)

Range-diff against v2:
-:  ---------- > 1:  8ae58934a1 notes.c: cleanup 'strbuf_grow' call in 'append_edit'
-:  ---------- > 2:  a53576ea88 notes.c: cleanup for "designated init" and "char ptr init"
-:  ---------- > 3:  62a952ba3e notes.c: drop unreachable code in 'append_edit()'
-:  ---------- > 4:  0d8ce0b14b notes.c: provide tips when target and append note are both empty
1:  2381947abd ! 5:  196e80358e notes.c: introduce "--blank-line" option
    @@ Metadata
     Author: Teng Long <dyroneteng@gmail.com>
     
      ## Commit message ##
    -    notes.c: introduce "--blank-line" option
    +    notes.c: introduce "--no-blank-line" option
     
         When appending to a given object which has note and if the appended
         note is not empty too, we will insert a blank line at first. The
    @@ Documentation/git-notes.txt: SYNOPSIS
      'git notes' add [-f] [--allow-empty] [-F <file> | -m <msg> | (-c | -C) <object>] [<object>]
      'git notes' copy [-f] ( --stdin | <from-object> [<to-object>] )
     -'git notes' append [--allow-empty] [-F <file> | -m <msg> | (-c | -C) <object>] [<object>]
    -+'git notes' append [--allow-empty] [--blank-line] [-F <file> | -m <msg> | (-c | -C) <object>] [<object>]
    ++'git notes' append [--allow-empty] [--no-blank-line] [-F <file> | -m <msg> | (-c | -C) <object>] [<object>]
      'git notes' edit [--allow-empty] [<object>]
      'git notes' show [<object>]
      'git notes' merge [-v | -q] [-s <strategy> ] <notes-ref>
    @@ Documentation/git-notes.txt: OPTIONS
      	Allow an empty note object to be stored. The default behavior is
      	to automatically remove empty notes.
      
    -+--blank-line::
     +--no-blank-line::
    -+	Controls if a blank line to split paragraphs is inserted
    -+	when appending (the default is true).
    ++	Do not insert a blank line before the inserted notes (insert
    ++	a blank line is the default).
     +
      --ref <ref>::
      	Manipulate the notes tree in <ref>.  This overrides
    @@ builtin/notes.c: static int append_edit(int argc, const char **argv, const char
      	};
      	int edit = !strcmp(argv[0], "edit");
     @@ builtin/notes.c: static int append_edit(int argc, const char **argv, const char *prefix)
    + 		enum object_type type;
      		char *prev_buf = read_object_file(note, &type, &size);
      
    - 		strbuf_grow(&d.buf, size + 1);
     -		if (d.buf.len && prev_buf && size)
     +		if (blankline && d.buf.len && prev_buf && size)
      			strbuf_insertstr(&d.buf, 0, "\n");
    @@ t/t3301-notes.sh: test_expect_success 'listing non-existing notes fails' '
      '
      
     +test_expect_success 'append to existing note without a beginning blank line' '
    ++	test_when_finished git notes remove HEAD &&
     +	cat >expect <<-\EOF &&
     +		Initial set of notes
     +		Appended notes
    @@ t/t3301-notes.sh: test_expect_success 'listing non-existing notes fails' '
      
      		More notes appended with git notes append
      	EOF
    -+	git notes remove HEAD &&
    ++
      	git notes add -m "Initial set of notes" &&
      	git notes append -m "More notes appended with git notes append" &&
      	git notes show >actual &&
2:  5dbe014a09 < -:  ---------- notes.c: fixed tip when target and append note are both empty
3:  2475ea0c04 < -:  ---------- notes.c: drop unreachable code in "append_edit()"
-- 
2.38.1.386.g196e80358e8

