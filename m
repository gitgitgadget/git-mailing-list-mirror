Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E948DC433FE
	for <git@archiver.kernel.org>; Mon,  3 Oct 2022 08:58:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbiJCI6G (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Oct 2022 04:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbiJCI5a (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Oct 2022 04:57:30 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF83F14016
        for <git@vger.kernel.org>; Mon,  3 Oct 2022 01:42:34 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id hy2so20566137ejc.8
        for <git@vger.kernel.org>; Mon, 03 Oct 2022 01:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date;
        bh=3vfhAyXXtBq3MkAKVD/alXmMTFihl3m72BFkbX5aJWI=;
        b=MmNRws7YKIFSUSwC4vnAO1i1hzhx0pmxyz7QzbZxYILT7813BCxKc43ZMrCdj0B5zX
         /3EuezMtcWk2h7qISScqncvkVv3qvpV/CfvpGZ73igWHZaOB0YhYxFzbZIfmU8XD07K7
         Whx9uu2ruGOzySgdRaIMuK04goxnwecqaJ8ADFfmno8KMIVz8YmVVd0H5A/6+sEBgga6
         z3/Bup9+iLJ644CJwSWcoGjkWxsdaibMrW4zFfTbfPZTE4P5rFvUDKlEYQ3Yhhd5xmUz
         vBK6t2s6OeB7IORaYKuo1qmQDgjj0ghvWEtGJZXAJcZOVWmg6k1lfYkeumNJCDLNbmgP
         mgQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date;
        bh=3vfhAyXXtBq3MkAKVD/alXmMTFihl3m72BFkbX5aJWI=;
        b=mMsgeKmTzjoGrovCkZLEIWGXZWLhpS7AbF8TdL4NisqfSgbYy39/WnW5bP08dLPFwV
         1ny36J7UsBBGdb7/VJ/kBoxpQ2BIJ4hMKJGRIkNp7f9ZcAEZwfqBzSNkkeZ32RZlIsNp
         ypI3svvDwsIL3Q1M/Z1NMkH0RKGIiA6LqgjUiWdvIcHDL+6VELjp+iqANWV0wcYyBZKX
         PZhObTNddvtA3MRf0aw3x/gcZ4mL+ZlRS8+lHpDGIp8BiW3FHtOnrZQY8susWNRenMAc
         6hsCUobvmIXl78oh6aRAEqiyWELJoO9uzuh2nL6lCnvTVI9uu2TOndPCXsLvWbKBwTxS
         +VKw==
X-Gm-Message-State: ACrzQf17BuBUJk4Tc2hzlQ12Qts3wovDDuMNhXg3NwbVwEwMKCNvi1Gy
        kW74ax4kdrBPsr3gAgp9eSE=
X-Google-Smtp-Source: AMsMyM6kETzMol092f8JOZYy04XEQbqQk1tBpziCaFulg5eSIZcfHNdWIOPSXbqYw1td+MvuRzHNmQ==
X-Received: by 2002:a17:907:2bd2:b0:78c:6155:cf33 with SMTP id gv18-20020a1709072bd200b0078c6155cf33mr1094356ejc.185.1664786552817;
        Mon, 03 Oct 2022 01:42:32 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id fj14-20020a0564022b8e00b0045720965c7asm6862561edb.11.2022.10.03.01.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 01:42:31 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1ofH1y-001zbD-0m;
        Mon, 03 Oct 2022 10:42:30 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Victoria Dye <vdye@github.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 04/36] blame: use a more detailed usage_msg_optf()
 error on bad -L
Date:   Mon, 03 Oct 2022 10:36:02 +0200
References: <cover-v2-00.35-00000000000-20220928T082458Z-avarab@gmail.com>
 <cover-v3-00.36-00000000000-20220930T180414Z-avarab@gmail.com>
 <patch-v3-04.36-a8312c50f01-20220930T180415Z-avarab@gmail.com>
 <xmqqv8p4a871.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <xmqqv8p4a871.fsf@gitster.g>
Message-ID: <221003.86wn9hti15.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Sep 30 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> Improve the error message emitted when there's a bad -L argument, and
>> do so using the parse-options.c flavor of "usage()", instead of using
>> the non-parse-options.c usage() function. This was the last user of
>> usage() in this file.
>>
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> ---
>>  builtin/blame.c | 7 ++++---
>>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> This may not be incorrect (I didn't spend time to see if this "while
> at it" is truly an improvement) but clearly outside the scome of
> "output from the -h option should match synopsis" theme.

I'll eject this & rewrite a subsequent commit, as a re-roll will make
clear the choice was between "convert this last user of the API" early
on, or in a later commit have the "-h" output be correct for both
usage() and usage_with_options()>

>> diff --git a/builtin/blame.c b/builtin/blame.c
>> index a9fe8cf7a68..8ec59fa2096 100644
>> --- a/builtin/blame.c
>> +++ b/builtin/blame.c
>> @@ -1108,12 +1108,13 @@ int cmd_blame(int argc, const char **argv, const=
 char *prefix)
>>  	anchor =3D 1;
>>  	range_set_init(&ranges, range_list.nr);
>>  	for (range_i =3D 0; range_i < range_list.nr; ++range_i) {
>> +		const char *arg =3D range_list.items[range_i].string;
>>  		long bottom, top;
>> -		if (parse_range_arg(range_list.items[range_i].string,
>> -				    nth_line_cb, &sb, lno, anchor,
>> +		if (parse_range_arg(arg, nth_line_cb, &sb, lno, anchor,
>>  				    &bottom, &top, sb.path,
>>  				    the_repository->index))
>> -			usage(blame_usage);
>> +			usage_msg_optf(_("failed to parse -L argument '%s'"),
>> +				       blame_opt_usage, options, arg);
>
> So, it used to be that it emitted only blame_usage which is a rough
> match to the synopsis,=20
>
>     "git blame [<options>] [<rev-opts>] [<rev>] [--] <file>"
>
> but now we use blame_opt_usage + options, which means that the same
> blame_usage, a blank line, and "<rev-opts> are documented in
> git-rev-list(1)" is given, followed by the list of full options.=20
>
> I do think saying "failed to parse -L" is an improvement, but it is
> dubious it is a good idea to follow it with a wall of text that
> comes from options[].  After all, if the user chose to use "-L 2,8"
> and a typo replaced the comma with a full stop, which caused
> parse_range_arg() to fail, does it make sense to scroll away the
> message that helpfully points out that "-L argument '2.8'" was the
> problem with other option descriptions?

As an aside: This is a good general observation about
usage_with_options(), and usage_msg_opt*() in particular. I.e. it would
be helpful to have a version of it that took a "-L" argument, so we
could know what option we're complaining about.

Then we could either show the usage message just for that option, or
highlight it in the full "-h" output we're showing.

But obviously all for some later date.

> This is why we shouldn't distract a series with "while at it"
> changes that are outside the scope of the theme.  Letting the patch
> authors and reviewers concentrate on doing one thing well would
> avoid mistakes, but mixing unrelated changes distracts them.  Having
> to think about the differences between usage() and usage_msg_optf()
> with this change already distracted me and stopped my review on this
> series in this sitting.  The topic will need to wait for the next
> time I decide to sit with it and start reading it from the next step.
>
> And of course, a series like this, which is supposed to do the same
> thing to many files for consistency, is better written and reviewed
> in one sitting, because that will make it easier in reviewers' mind
> to keep and apply the same review criteria consistently.

Noted, FWIW I was assuming that as other commands make wide use of
usage_msg_opt*() for this sort of thing that the usage here & output
change didn't need too much rationalizing, but live & learn etc. Thanks.
