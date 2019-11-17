Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 039BE1F4B5
	for <e@80x24.org>; Sun, 17 Nov 2019 23:16:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726325AbfKQXQO (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Nov 2019 18:16:14 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39605 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbfKQXQN (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Nov 2019 18:16:13 -0500
Received: by mail-wm1-f68.google.com with SMTP id t26so16757204wmi.4
        for <git@vger.kernel.org>; Sun, 17 Nov 2019 15:16:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=ul3RPd9zaDHyrBJtkK8pneHZJ4GWlbSIjaoWBeVbWSQ=;
        b=vNapp1xVSmwjsG6ePHejVuDB/cf/7FBVdUMd7GikTYKUVNyWF1HN88k1Ke/5XKnrTh
         o979kXYYgVO3AhBlQZURtwoMA/lBFbuzoOxlSkVJN5a2MbrUalBOSbuyvU/RTR7oskz6
         Ky6f3Pz70yNG0C4zuAp7VAtbCVpQ54LaED/EXyWcVeOJcB2jXvgfFVtsy62BxyspjMFZ
         SH6V9q31oo3vkdklSCxGyKGt3zU3ApGSsAMnewZJXT+0Ust9p23fWXUD7aRr17/zA8WN
         6dBxKpmuXuEAO8DHUtNvfsQD5HaLuQy/tPH6IATviJo0wZ4ulMzkVJZZAvU0yLSujOvd
         svCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=ul3RPd9zaDHyrBJtkK8pneHZJ4GWlbSIjaoWBeVbWSQ=;
        b=U+nmqq+9Tz3ViovTuUBUKiWfzb76QmuOGb+R3HQf3PwxYkVHOXvFra1VWRZHC4a6HJ
         MO18i3mz5Am+xrIfz/dzrZcf76i7kXqq4x9+Lxs/nspgSnVOaup9bB4OEVWioTY+DG0c
         jO/RJ24YK/MFuVZfC93R3pPclOF7KEqNWLk3YpHFcEFEAo4hJHsnqlIPMHSxWEscTBRh
         f/jNaZUpEfhLiX0vG74jtYdu2ARd532dHJPc1QwEm+hNR3r9fFyqQLihPnhpzDhoGrIQ
         pv4C4jUTgAYYsbUC99aX5STEhM8Wh7RJUpncja6BJXsqnFITB/6zMGTeqosUHaAVONis
         wyBw==
X-Gm-Message-State: APjAAAW/l9brzagAA0xhyw03U3RwZvQxBn/faNa8oeCMKM9Hbhsudt2K
        AGdsWfsPkYJiiin2M5EtHxDpP/xRaJE=
X-Google-Smtp-Source: APXvYqxwX1vnXTpomNTnOJBk4qqtaG+FT3iwO4HRxOpa0yuPeierjouHDz5zfJ9m31OGp2IKdRWYgw==
X-Received: by 2002:a7b:c098:: with SMTP id r24mr26750090wmh.63.1574032571474;
        Sun, 17 Nov 2019 15:16:11 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g11sm18511890wmh.27.2019.11.17.15.16.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Nov 2019 15:16:10 -0800 (PST)
Message-Id: <pull.327.v2.git.1574032570.gitgitgadget@gmail.com>
In-Reply-To: <pull.327.git.gitgitgadget@gmail.com>
References: <pull.327.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 17 Nov 2019 23:16:08 +0000
Subject: [PATCH v2 0/2] Make git rebase -r's label generation more resilient
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Those labels must be valid ref names, and therefore valid file names. The
initial patch came in via Git for Windows.

Change since v1:

 * moved the entire sanitizing logic to label_oid(), as a preparatory step.

Johannes Schindelin (1):
  rebase-merges: move labels' whitespace mangling into `label_oid()`

Matthew Rogers (1):
  rebase -r: let `label` generate safer labels

 sequencer.c              | 72 +++++++++++++++++++++++++---------------
 t/t3430-rebase-merges.sh |  6 ++++
 2 files changed, 51 insertions(+), 27 deletions(-)


base-commit: d9f6f3b6195a0ca35642561e530798ad1469bd41
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-327%2Fdscho%2Ffix-rebase-r-labels-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-327/dscho/fix-rebase-r-labels-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/327

Range-diff vs v1:

 -:  ---------- > 1:  3f4d086e80 rebase-merges: move labels' whitespace mangling into `label_oid()`
 1:  4a02c38442 ! 2:  adc22c8ba2 rebase -r: let `label` generate safer labels
     @@ -1,14 +1,15 @@
     -Author: Matt R <mattr94@gmail.com>
     +Author: Matthew Rogers <mattr94@gmail.com>
      
          rebase -r: let `label` generate safer labels
      
          The `label` todo command in interactive rebases creates temporary refs
          in the `refs/rewritten/` namespace. These refs are stored as loose refs,
          i.e. as files in `.git/refs/rewritten/`, therefore they have to conform
     -    with file name limitations on the current filesystem.
     +    with file name limitations on the current filesystem in addition to the
     +    accepted ref format.
      
     -    This poses a problem in particular on NTFS/FAT, where e.g. the colon
     -    character is not a valid part of a file name.
     +    This poses a problem in particular on NTFS/FAT, where e.g. the colon,
     +    double-quote and pipe characters are disallowed as part of a file name.
      
          Let's safeguard against this by replacing not only white-space
          characters by dashes, but all non-alpha-numeric ones.
     @@ -23,8 +24,8 @@
       --- a/sequencer.c
       +++ b/sequencer.c
      @@
     - 		else
     - 			strbuf_addbuf(&label, &oneline);
     + 	} else {
     + 		struct strbuf *buf = &state->buf;
       
      +		/*
      +		 * Sanitize labels by replacing non-alpha-numeric characters
     @@ -36,18 +37,26 @@
      +		 * in file names. We do not validate the UTF-8 here, that's not
      +		 * the job of this function.
      +		 */
     - 		for (p1 = label.buf; *p1; p1++)
     --			if (isspace(*p1))
     -+			if (!(*p1 & 0x80) && !isalnum(*p1))
     - 				*(char *)p1 = '-';
     + 		for (; *label; label++)
     +-			strbuf_addch(buf, isspace(*label) ? '-' : *label);
     ++			if ((*label & 0x80) || isalnum(*label))
     ++				strbuf_addch(buf, *label);
     ++			/* avoid leading dash and double-dashes */
     ++			else if (buf->len && buf->buf[buf->len - 1] != '-')
     ++				strbuf_addch(buf, '-');
     ++		if (!buf->len) {
     ++			strbuf_addstr(buf, "rev-");
     ++			strbuf_add_unique_abbrev(buf, oid, default_abbrev);
     ++		}
     + 		label = buf->buf;
       
     - 		strbuf_reset(&buf);
     + 		if ((buf->len == the_hash_algo->hexsz &&
      
       diff --git a/t/t3430-rebase-merges.sh b/t/t3430-rebase-merges.sh
       --- a/t/t3430-rebase-merges.sh
       +++ b/t/t3430-rebase-merges.sh
      @@
     - 	test_path_is_missing .git/MERGE_HEAD
     + 	test_cmp expect G.t
       '
       
      +test_expect_success '--rebase-merges with commit that can generate bad characters for filename' '
     @@ -55,4 +64,5 @@
      +	git merge -m "colon: this should work" G &&
      +	git rebase --rebase-merges --force-rebase E
      +'
     ++
       test_done

-- 
gitgitgadget
