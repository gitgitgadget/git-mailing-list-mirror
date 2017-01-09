Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 293EE20756
	for <e@80x24.org>; Mon,  9 Jan 2017 10:57:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759126AbdAIK42 (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jan 2017 05:56:28 -0500
Received: from mail-it0-f67.google.com ([209.85.214.67]:36287 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757757AbdAIK4Y (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2017 05:56:24 -0500
Received: by mail-it0-f67.google.com with SMTP id n68so8883420itn.3
        for <git@vger.kernel.org>; Mon, 09 Jan 2017 02:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=jR3p/nMlYHSMw1blglH2D1ZPZYxafr/nkFkTHMlxjOA=;
        b=OfyGadkScoWk8daQjnemNZrC78Tg0NOBjqkducB3Sqkj9TPeaggfaYcK9RF0qgbisG
         1ilCNSXYMd6q4xtTR+leElt99u3vvIFwRQzdb/5caUGnYOfRt0QwjAA5WLM0l5YYE449
         gM9PMT/UFjGSCKTva4wrA4lBgoYkLMS13NhGhWinME9H5LXbuN5tTbvKdV7C2lCzAWlH
         ls1N6/Q4+ioaKTUMNEctPS8kP4Qhhw8veHZDMhDieS3V1TxjyhVYqH6jqKttpMchfKwp
         4kGVJ0KMtRlR/xHZSk/FLhVksvCvswyTkFgeq6p8ya3J4bxhFHoG8kT4HjDQDQOGYtje
         M0CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=jR3p/nMlYHSMw1blglH2D1ZPZYxafr/nkFkTHMlxjOA=;
        b=Y/dEEVPEIVqf/cziGDL7XhRcEqy1WveTJ3t7e+HakgETlyWercweR8m2ql0lMfIZ5D
         nKsm0w118B1GZZrU5QxzmUezMewBy0U+lwgZr6WqQfpk6v+tnIWf1yuPRIq2Qjn2Dzj4
         2vqlnZC4EAi7Vnqic1mn6HOjzHHWWTP7AAcIqQ8fj3htvAGXVJCdUJhQVVeBeEj3beug
         FhxXxzpNDro0GbEF2ij4hb0abhEF3zC9RVRU9FlILY6vAKpeQbDx11fnKJn9168djxGm
         zWcKyNu0K7PmLqzjQXSfOuCV0xN8MkOm81NGSSkNRQhrS52rNPK5xCIMyXiXoMCJSB1g
         PmyA==
X-Gm-Message-State: AIkVDXJ+/FoqhkoFo5W5zyCbLz39S3UMpI9quTlwYfpfgY8UvWwsLFIHoYbhdXeKhR7hHWwBNbACh1cgohcH/w==
X-Received: by 10.36.138.131 with SMTP id v125mr8208804itd.3.1483959383429;
 Mon, 09 Jan 2017 02:56:23 -0800 (PST)
MIME-Version: 1.0
Received: by 10.64.69.3 with HTTP; Mon, 9 Jan 2017 02:55:52 -0800 (PST)
In-Reply-To: <xmqqo9zi35n6.fsf@gitster.mtv.corp.google.com>
References: <20161226102222.17150-1-chriscool@tuxfamily.org>
 <20161226102222.17150-15-chriscool@tuxfamily.org> <xmqqa8bhb32x.fsf@gitster.mtv.corp.google.com>
 <CAP8UFD1EgOxcPi=tpiosKkYMcCZe+b6gwW0CKt2sE1NZ7gQv=A@mail.gmail.com> <xmqqo9zi35n6.fsf@gitster.mtv.corp.google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 9 Jan 2017 17:55:52 +0700
Message-ID: <CACsJy8AR6yNr0y+_JZDkW-HO_yHPkUx_6zbLGoviKQBOVcSg5A@mail.gmail.com>
Subject: Re: [PATCH v3 14/21] read-cache: touch shared index files when used
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jan 8, 2017 at 4:46 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Christian Couder <christian.couder@gmail.com> writes:
>
>> So what should we do if freshen_file() returns 0 which means that the
>> freshening failed?
>
> You tell me ;-)  as you are the one who is proposing this feature.

My answer is, we are not worse than freshening loose objects case
(especially since I took the idea from there). In both cases we
silently ignore utime() error (sha1_file.c does retry, but will do
nothing else if the retry fails). And errors in odb are much more
serious than index files. If we are to improve it, I think we should
do it inside check_and_freshen_file(), maybe with an optional flag to
silence it.

> Isn't a failure to freshen it a grave error?  We are letting a
> base/shared index file that is known to be in-use go stale and
> eventually subject for garbage collection, and the user should be
> notified in some way before the actual GC happens that renders the
> index file unusable?
>
> What is the failure mode after such a premature GC happens?  What
> does the end-user see?  Can you try to (1) split the index (2)
> modify bunch of entries (3) remove the base/shared index with /bin/rm
> and then see how various Git commands fail?  Do they fail gracefully?
>
> I am trying to gauge the seriousness of ignoring such an error here.

If we fail to refresh it and the file is old enough and gc happens,
any index file referenced to it are broken. Any commands that read the
index will die(). The best you could do is delete $GIT_DIR/index and
read-tree HEAD.
-- 
Duy
