Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E03B720248
	for <e@80x24.org>; Sun, 14 Apr 2019 10:10:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725805AbfDNKKI (ORCPT <rfc822;e@80x24.org>);
        Sun, 14 Apr 2019 06:10:08 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:41568 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfDNKKI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Apr 2019 06:10:08 -0400
Received: by mail-qk1-f194.google.com with SMTP id o129so8191777qke.8
        for <git@vger.kernel.org>; Sun, 14 Apr 2019 03:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=platin-gs.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CygmdP+BTsLWa4QSgrYhfejnG/ppnzJbMcfoI9V8WKo=;
        b=QeXOOBuaxX6JJUmVeSmvIt3FdCeJICZLC236hubuKPr3Y+hRUE6BuZOr3UFuWrJywv
         2d1r+HIn4Sit6nRyLLNLYNu24iY7xb0f8UF1ezRqeAZ4NT/Z5JvrA613Rcvgj6aeLOcC
         2HBQ7JO3vib7VdIi8686fmUXiH9bT+/3LNIhByDOliFpIPhwptFU72cnxUwC51L54/GT
         mqmopNnOseEf/7DwVggDYO3e3ucVMb5hXScCvlXmdcWM2iRU48a9vGKB1I5Lk9h1b857
         toTGaw1vJbkg7yodiQxic6lvG2tRyYjAodAzlnEPLzSG6d5YD4sU5ZtU745XZqcsE+6O
         KJlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CygmdP+BTsLWa4QSgrYhfejnG/ppnzJbMcfoI9V8WKo=;
        b=ZaeN7lZxOPCiUah90551yzf6zTkvPSioxuKuhvaymst+5iJpELFWz6+Ajzjy0DIfqc
         6w+HvkhZpbskkgWeG3nOvleNhDu+fOSbQWVUXZ9nSd3DA2ChXVoxNd2YP/Shfts5OFQc
         gKXcKVa6tUNYcDLEdVIYSvb5LkQ0xvsEWPrg3Xr5fLtznRnJzjFkHg9Kybo5LKwGYiTs
         uiiB58kgsSGDhAKI7Wu+Rawq5++A21+IGzENZyAQVoeuWOh2nG2LyCLWTuPpSk7SBU3a
         xa4TIGEAb1vlaSKujaeMPI7uyiNKLrMiQkIrAdkUm2IniKrhqO7IuKAGiKQby11YgY5R
         tydA==
X-Gm-Message-State: APjAAAVTu7zwicFxX0kTH/hbdqFn8POOYASQ74G3KVHPOOJleEEvl1/j
        WWi39ygzVaa7Aot+sgUEOftbDKEUKrYGaRi8udE=
X-Google-Smtp-Source: APXvYqzg1V7RLsx0sMd320hXaMIwY4a/u2cDYP8BDmVSdwkQqt3ObKlvlytXo/ZG/NUs5oPLc0Q/u5LWnTDhBM2qbvI=
X-Received: by 2002:ae9:ef07:: with SMTP id d7mr54277109qkg.100.1555236607140;
 Sun, 14 Apr 2019 03:10:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190410162409.117264-1-brho@google.com> <20190410162409.117264-5-brho@google.com>
 <xmqqo959w8pq.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqo959w8pq.fsf@gitster-ct.c.googlers.com>
From:   Michael Platings <michael@platin.gs>
Date:   Sun, 14 Apr 2019 11:09:55 +0100
Message-ID: <CAJDYR9S8XFH=JnQX8WcfgOZ7cr+X6kk45k9g8t3u5aP5wwdu0Q@mail.gmail.com>
Subject: Re: [PATCH v6 4/6] blame: add config options to handle output for
 ignored lines
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Barret Rhoden <brho@google.com>,
        Git mailing list <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        David Kastrup <dak@gnu.org>, Jeff King <peff@peff.net>,
        Jeff Smith <whydoubt@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Stefan Beller <stefanbeller@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, 14 Apr 2019 at 04:45, Junio C Hamano <gitster@pobox.com> wrote:
> Wouldn't this make it impossible to tell between what's done by such
> a commit that was marked to be ignored, and what's done locally only
> in the working tree, which the users have long accustomed to see
> with the ^0*$ object name?  I think it would make a lot more sense
> to show the object name of the "ignored" commit, which would be
> recognizable by the user who fed such an object name to the command
> in the first place.  Alternatively, perhaps the same idea as replacing
> one of the hexdigits with '*' used by the other configuration can be
> applied to this as well?

I had the same objection to zeroing out hashes, but this option is off
by default so I think it's OK.
If you enable both blame.markIgnoredLines and
blame.maskIgnoredUnblamables then the hash does appear as
"*0000000000" like you suggest. I think it's appropriate that the '*'
is only added if you opt in with the markIgnoredLines option.

If you only enable blame.markIgnoredLines then the hash for
"unblamable" lines appears as e.g. "*3252488f5" - this doesn't seem
right to me because the commit *wasn't* ignored, it is in fact the
commit in which that line was added. I think '*' should denote "this
information may be inaccurate" as that's what a typical user needs to
be aware of. However given that "unblamable" lines tend to be either
empty or a single character I'm not going to insist :)
