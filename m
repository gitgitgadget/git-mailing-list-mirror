Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C0F6209FA
	for <e@80x24.org>; Thu, 13 Apr 2017 19:12:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753105AbdDMTML (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Apr 2017 15:12:11 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:35089 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751626AbdDMTMK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2017 15:12:10 -0400
Received: by mail-pf0-f177.google.com with SMTP id i5so32412721pfc.2
        for <git@vger.kernel.org>; Thu, 13 Apr 2017 12:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=63k4wYC0fpL0uSpz6jJGnzm1oTeLt7yTcKUCQP3S84c=;
        b=F1b7D+218Nif04DMcfGafa4UF7ln1AIQzX5zKGdQRlNykgI5AUsoXC9FhGBMV+Aw1T
         KX9K2zJdPWrge9Y1HG1N77Tfa3LekH9R+E73NwL0fBCI7o2+yTkxD7/tSXCDTV2cP1ET
         aYTzE9jrtucN0HKSFAaAQft/fQW8WvzBAoUros4quLvIZub9nlBU9amziRQ7k0H3TIgA
         osGo6xZ6rP1FywuRM1hICDI1u7gOELoJ/ujDqaK0HarVVSGcIvo4fGaVKL3wcSDElH9I
         i0/b69u9iKCgPDEmsFXxfHeaNFCXbkxuI0PJCbfvxzJ79vrhxGbXU8Ybec0H2WAKFOJ+
         1THg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=63k4wYC0fpL0uSpz6jJGnzm1oTeLt7yTcKUCQP3S84c=;
        b=Oo3Szih2lg9N6b+y+sXdPFNKc+wmzY7ivzLh2Wf29piM/Fie6bRDD+gdRIf9QFfyfS
         oTqQbAevYPS2Gvcf0tabmWUNGVZMXqgXfN4COBP0oC68kXl7l3lmJTtJ3P18eEGR/+80
         2ZYUn75RsJKh0ynArpSH1pdrUGuXe5qIcxpffJBZVsz1OulQAOBFz0Fj3YtOTBDkoZN4
         PpyUhh564BkZGmOZI8La++CIiSGNTyvN6R6L9pQJzWGmaDsMvgsZHodDZ59Advo7N6Ul
         2Raeg939kV54/5gHpvj+AAkSYpxfAy3uwlCISftdsiaTS4fzr4kHILG1wh1oy+3mb9ZR
         RsiA==
X-Gm-Message-State: AN3rC/66+0/nooy9qB3NGG/t8//vQhE323aXYPgxTWt5vYcKvszjycHC
        FxYcwSpejDu/yuBzgMH2BU8zH5KRBlBK
X-Received: by 10.84.248.74 with SMTP id e10mr5369543pln.76.1492110729259;
 Thu, 13 Apr 2017 12:12:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.163.239 with HTTP; Thu, 13 Apr 2017 12:12:08 -0700 (PDT)
In-Reply-To: <20170413190541.GD96917@google.com>
References: <20170411234923.1860-1-sbeller@google.com> <20170411234923.1860-3-sbeller@google.com>
 <20170413190541.GD96917@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 13 Apr 2017 12:12:08 -0700
Message-ID: <CAGZ79kZybFNPPAuw4GmVUSmQVBcCG402uCur8M9hSoY3CbhbXw@mail.gmail.com>
Subject: Re: [PATCH 2/4] submodule.c: uninitialized submodules are ignored in
 recursive commands
To:     Brandon Williams <bmwill@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 13, 2017 at 12:05 PM, Brandon Williams <bmwill@google.com> wrote:
> On 04/11, Stefan Beller wrote:
>> This was an oversight when working on the working tree modifying commands
>> recursing into submodules.
>>
>> To test for uninitialized submodules, introduce another submodule, that is
>> uninitialized in the actual tests. By adding it to the branch "add_sub1",
>> which is the starting point of all other branches, we have wide coverage.
>>

...

>
> The 'submodule add' command will make the submodule active, so you'll
> need to add in a line to subsequently make the submodule inactive for
> this to work, unless you do in at a later point in time.

Yes, it will make it active, but that doesn't matter here, because at this
point (in create_lib_submodule_repo) we prepare an upstream
in submodule_update_repo

Any later test follows the structure of

    prolog &&
    reset_work_tree_to no_submodule &&
    (
        cd submodule_update &&
        # do actual test here, in submodule_update
    )

Note that 'prolog' performs a clone of submodule_update_repo
to submodule_update, manually setting 'sub1' to active.

'uninitialized_sub' is not active.

I tried to explain it via
    To test for uninitialized submodules, introduce another submodule,
    that is uninitialized in the actual tests.
in the commit message, but that is too concise apparently.
So the resend will explain that a bit more.

Thanks,
Stefan
