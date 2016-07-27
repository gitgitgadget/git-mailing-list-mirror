Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7CF97203EA
	for <e@80x24.org>; Wed, 27 Jul 2016 06:15:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751504AbcG0GPM (ORCPT <rfc822;e@80x24.org>);
	Wed, 27 Jul 2016 02:15:12 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34119 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751049AbcG0GPJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jul 2016 02:15:09 -0400
Received: by mail-wm0-f68.google.com with SMTP id q128so4855239wma.1
        for <git@vger.kernel.org>; Tue, 26 Jul 2016 23:15:08 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=bd/Uo8+BXtyhbGYwwHOJUOvqDYAJqAIy36fLMlq2OFk=;
        b=d0z10wvFw35JDJDfTXBExoCTO3xfCDzc4qmyoPmB3/paG18WeKn9kyy0e19mCGRoLn
         3vSG5wk7aWla6vF9BCSCy/JGIEYA+8Hq978GA/8FSbNA7frzj+dA8AA6Bhqx7CYi5HKT
         fbacSOJezh+ztaTIGyS0IETzQVGRr9sGyoIxnAS0NDQwRcWrX9nylPyar4TSuH/2ZWOD
         q6P98l9cFZeOQ7W7MplxLo6rMxmPL+RbgyG7BtHkeTnILfkfH5Zvb0+jebUuan48IAH0
         kSikKVV4iH4SLnpEOJJ8kPybcPaQIb0BmBXyCRgVqdkZzhYoyJbad+boEDamALnBL4PD
         ZKAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=bd/Uo8+BXtyhbGYwwHOJUOvqDYAJqAIy36fLMlq2OFk=;
        b=nDZ1nNy/SqpwmDoX7v0+whmumgdJK2l9HGynNJinJJ0+tP9+E/SKcAyNIRMURleDSY
         nq39YWsNsbAV4DJY53qgtbfM9wRtntbn02vGUUM9IlbQFT+IlZZX/K6ii0ZjMr7o3svm
         vXiQ2DGTV++pHMAP3sNY0x/nAeZ0QKNufmneohwf4hk8Yu19fuOtz+BfCLpDQA4bA/Xj
         Sr1lotYut6ZeMafnVmkoHWIUddNge0GGaLFKzq1cvTAKpPF9urmctdCMoqUKW8CFhGa9
         ymTUJEFweN/9UFBLDIVBUDodSlR6+TirbblTkg8D5b/4+eI26eMhEeQ31RHYsSQQe+Bl
         Ah6Q==
X-Gm-Message-State: AEkoouvUHrXtmQpcFv5zTWJsZQHWsil9Syhqj+ASmuUJ2N/3BFFY4JM5R+SL3irom4QahtJLNZw+AlQcMNgMRQ==
X-Received: by 10.194.87.101 with SMTP id w5mr27440911wjz.94.1469600107984;
 Tue, 26 Jul 2016 23:15:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.194.70.167 with HTTP; Tue, 26 Jul 2016 23:15:07 -0700 (PDT)
In-Reply-To: <xmqqzip4xfmz.fsf@gitster.mtv.corp.google.com>
References: <20160627182429.31550-1-chriscool@tuxfamily.org> <xmqqzip4xfmz.fsf@gitster.mtv.corp.google.com>
From:	Christian Couder <christian.couder@gmail.com>
Date:	Wed, 27 Jul 2016 08:15:07 +0200
Message-ID: <CAP8UFD0tcPnqBcxC5-4tnGMT4W5b7L=C_riwpTvDfeMUjQzpjA@mail.gmail.com>
Subject: Re: [PATCH v8 00/41] libify apply and use lib in am, part 2
To:	Junio C Hamano <gitster@pobox.com>
Cc:	git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Jul 26, 2016 at 11:18 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Christian Couder <christian.couder@gmail.com> writes:
>
>> Sorry if this patch series is still long. I can split it into two or
>> more series if it is prefered.
>> ...
>> Christian Couder (41):
>>   apply: make some names more specific
>>   apply: move 'struct apply_state' to apply.h
>>   builtin/apply: make apply_patch() return -1 or -128 instead of
>>     die()ing
>>   builtin/apply: read_patch_file() return -1 instead of die()ing
>>   builtin/apply: make find_header() return -128 instead of die()ing
>>   builtin/apply: make parse_chunk() return a negative integer on error
>>   builtin/apply: make parse_single_patch() return -1 on error
>>   builtin/apply: make parse_whitespace_option() return -1 instead of
>>     die()ing
>>   builtin/apply: make parse_ignorewhitespace_option() return -1 instead
>>     of die()ing
>>   builtin/apply: move init_apply_state() to apply.c
>>   apply: make init_apply_state() return -1 instead of exit()ing
>>   builtin/apply: make check_apply_state() return -1 instead of die()ing
>>   builtin/apply: move check_apply_state() to apply.c
>>   builtin/apply: make apply_all_patches() return 128 or 1 on error
>>   builtin/apply: make parse_traditional_patch() return -1 on error
>>   builtin/apply: make gitdiff_*() return 1 at end of header
>>   builtin/apply: make gitdiff_*() return -1 on error
>>   builtin/apply: change die_on_unsafe_path() to check_unsafe_path()
>>   builtin/apply: make build_fake_ancestor() return -1 on error
>>   builtin/apply: make remove_file() return -1 on error
>>   builtin/apply: make add_conflicted_stages_file() return -1 on error
>>   builtin/apply: make add_index_file() return -1 on error
>>   builtin/apply: make create_file() return -1 on error
>>   builtin/apply: make write_out_one_result() return -1 on error
>>   builtin/apply: make write_out_results() return -1 on error
>>   builtin/apply: make try_create_file() return -1 on error
>>   builtin/apply: make create_one_file() return -1 on error
>>   builtin/apply: rename option parsing functions
>>   apply: rename and move opt constants to apply.h
>>   Move libified code from builtin/apply.c to apply.{c,h}
>>   apply: make some parsing functions static again
>>   environment: add set_index_file()
>>   write_or_die: use warning() instead of fprintf(stderr, ...)
>>   apply: add 'be_silent' variable to 'struct apply_state'
>>   apply: make 'be_silent' incompatible with 'apply_verbosely'
>>   apply: don't print on stdout when be_silent is set
>>   usage: add set_warn_routine()
>>   usage: add get_error_routine() and get_warn_routine()
>>   apply: change error_routine when be_silent is set
>>   builtin/am: use apply api in run_apply()
>>   apply: use error_errno() where possible
>
> I finally found time to get back to finish reviewing this.

Great, thanks!

> The early part up to and including "apply: make some parsing
> functions static again" looked good and we could treat them as a
> continuation of the earlier cc/apply-introduce-state topic, which
> has been merged to the 'master' already.

Ok, is it ok for you to just pick up this early part, or do you prefer
me to resend it (maybe with the last patch on top of it)?

> I got an impression that the patches in the remainder of the series
> were not as polished as the earlier ones, except for the last one,
> which should be reordered and be part of the early preparation step
> if possible.

I can resend just the last patch rebased on top of the early part once
you have picked up the early part.

And yeah the remainder has not been reviewed much. I will rework it as
you suggest in your other emails about specific pathes, and then
resend it in a "part 3" patch series.

Thanks,
Christian.
