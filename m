Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DF351F404
	for <e@80x24.org>; Fri, 16 Feb 2018 18:27:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751456AbeBPS1h (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Feb 2018 13:27:37 -0500
Received: from mail-qk0-f177.google.com ([209.85.220.177]:38052 "EHLO
        mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751265AbeBPS1W (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Feb 2018 13:27:22 -0500
Received: by mail-qk0-f177.google.com with SMTP id s198so4912854qke.5
        for <git@vger.kernel.org>; Fri, 16 Feb 2018 10:27:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=gPMQiG1v/KD8m5TVR77Q9PSpfS7XuMbPw6yh0v48748=;
        b=B/Ggs2vi+cWFb+tDkIa36FYLxaSOIJjG4odQ/3jyQRBWGehk9albRItJ2d04R9wzoc
         MKusgZOieLLCXlxdRodl3jTe1TgasYJ5eNeu+osLBKeDmFdL8/aW46qNIph6WbbrzBps
         1SI9hym7PZ96frDtC8GVrlRdIybsVSmGVBQbG7SiRNDXUherIawn/ZMLSMTGm06PwmbL
         znowtYmhyaMvVl3hGI+rLj+kKs6USV3hxOhMuXHWY+VzYDPT96wl02cPclzr9eNgGPmY
         D3qNU93e39WoJAwRkEmK003ItNu21qs5kx3gpqEvmVFof4bEyJaI+PRmVk/8VR1moU5x
         8RBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=gPMQiG1v/KD8m5TVR77Q9PSpfS7XuMbPw6yh0v48748=;
        b=pjJm+1WdtKoCQvHKsZVCpJ304Xo7gJ5YM6tA4gSLI2qRPt+g3IMNOOXPLvgAZj1c8L
         lBXhWQWtoKCVHYnc43xUNlBcHIU3cAhkMFHkO1QdYoKC12zQutZA6QswA0q74cz43WtD
         TDrBkTEwxa9i9eoRFvg636kTDf3rbsJEF2uPDCLGBn/7Qb/QSCuQuyI6BUstAcgYMMWP
         uwyae4xBS5TkJClt5Pq4GdfJs89mUHTn8lbH/yz6RJtZIc+Wc2y1k2asCBd0KDHPblw7
         CM21zezJs4eaIE6GiskbcOKwosSa4ddKE/pmbkM3uhG6AQD2KEVByNWKBQCHv2T6NC2l
         V5yg==
X-Gm-Message-State: APf1xPBqElwVChAdNbADiciIMS/YgNerE/DNEN7oX1XVuZcWHVhPClrr
        9t5dxaPfNHHDuRjqR+fOSe9rHDk+pfKaQegd3+0=
X-Google-Smtp-Source: AH8x227a9jjnjQUex6lz1WQgEdlodzr/oknb0/ftrZ9ybkEb2koxQw6667FkUX00dYgTK12KX0wxBNZ90yGxSg6MSAI=
X-Received: by 10.55.132.67 with SMTP id g64mr10585507qkd.28.1518805641912;
 Fri, 16 Feb 2018 10:27:21 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.128.40 with HTTP; Fri, 16 Feb 2018 10:27:21 -0800 (PST)
In-Reply-To: <E978DDBD-AD31-41EC-969B-E6AAC7D4FAF3@gmail.com>
References: <20180215191841.40848-1-sunshine@sunshineco.com>
 <20180215230952.51887-1-sunshine@sunshineco.com> <E978DDBD-AD31-41EC-969B-E6AAC7D4FAF3@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 16 Feb 2018 13:27:21 -0500
X-Google-Sender-Auth: ZLGRZ97uS5CCwud3fkQAcDH12Bs
Message-ID: <CAPig+cS5NRAY7jgnKzcZNciF9-s3jo8m=YCh+MU23S-yFu1ZNA@mail.gmail.com>
Subject: Re: [PATCH v3] worktree: add: fix 'post-checkout' not knowing new
 worktree location
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     git <git@vger.kernel.org>,
        "Gumbel, Matthew K" <matthew.k.gumbel@intel.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 16, 2018 at 11:55 AM, Lars Schneider
<larsxschneider@gmail.com> wrote:
>> On 16 Feb 2018, at 00:09, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> The hook is run manually, rather than via run_hook_le(), since it needs
>> to change the working directory to that of the worktree, and
>> run_hook_le() does not provide such functionality. As this is a one-off
>> case, adding 'run_hook' overloads which allow the directory to be set
>> does not seem warranted at this time.
>
> Although this is an one-off case, I would still prefer it if all hook
> invocations would happen in a central place to avoid future surprises.

A number of other places in the codebase run hooks manually, so this
is not unprecedented. Rather than adding 'run_hook' overload(s)
specific to this particular case, it would make sense to review all
such places and design the API of the new overloads to handle _all_
those cases (with the hope of avoiding adding new ad-hoc overloads
each time). But, that's outside the scope of this bug fix.

>> post_checkout_hook () {
>> +     gitdir=${1:-.git}
>> +     test_when_finished "rm -f $gitdir/hooks/post-checkout" &&
>> +     mkdir -p $gitdir/hooks &&
>> +     write_script $gitdir/hooks/post-checkout <<-\EOF
>> +     {
>> +             echo $*
>> +             git rev-parse --git-dir --show-toplevel
>
> I also checked `pwd` here in my suggested test case.
> I assume you think this check is not necessary?

I do think it's a good idea, and it is still being tested but not in
quite the same way. I removed the explicit 'pwd' from the output
because I didn't want to deal with potential fallout on Windows. In
particular, your test used raw 'pwd' for the "actual" file but
'$(pwd)' for "expect", which I think would have run afoul on Windows
since '$(pwd)' is meant only to compare output of _Git_ commands,
whereas raw 'pwd' is not a Git command. So, I think the test would
have needed to use raw 'pwd' for the "expect" file, as well. But,
since I don't have Windows on which to test, I decided to avoid that
potential mess by checking 'pwd' in a different way. Details below.

>> +     } >hook.actual
>>       EOF
>> }
>>
>> test_expect_success '"add" invokes post-checkout hook (branch)' '
>>       post_checkout_hook &&
>> -     printf "%s %s 1\n" $_z40 $(git rev-parse HEAD) >hook.expect &&
>> +     {
>> +             echo $_z40 $(git rev-parse HEAD) 1 &&
>> +             echo $(pwd)/.git/worktrees/gumby &&
>> +             echo $(pwd)/gumby
>> +     } >hook.expect &&
>>       git worktree add gumby &&
>> -     test_cmp hook.expect hook.actual
>> +     test_cmp hook.expect gumby/hook.actual
>> '

The explicit 'pwd' check from your test is still here, but is now
implicit, so more subtle. Specifically, the hook now emits "actual"
within the current working directory (the location 'pwd' would
report), and 'test_cmp' looks for the "actual" file at that location.
The net result is 'pwd' is effectively, though implicitly, recorded by
the location of the "actual" file itself. If 'pwd' is wrong (that is,
if the chdir() was wrong or missing), then "actual" would not end up
at the correct location and the 'test_cmp' would fail.
