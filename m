Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8AA83206A4
	for <e@80x24.org>; Mon, 12 Dec 2016 19:35:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752760AbcLLTfr (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Dec 2016 14:35:47 -0500
Received: from mail-qk0-f172.google.com ([209.85.220.172]:33634 "EHLO
        mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752366AbcLLTfp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2016 14:35:45 -0500
Received: by mail-qk0-f172.google.com with SMTP id x190so94130561qkb.0
        for <git@vger.kernel.org>; Mon, 12 Dec 2016 11:35:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=HWSmxqQ2E3wRZbi6nJ2izSkK6TiqNf7/XR16RngzcIA=;
        b=AuSwRlSYBIJxUkeiPTc6RkOtY/CuAOZY3W7L/THlmDS0pbVgx5nsT56MaN72fkhBxi
         EiqhqDzRpous/fegE23afPq58e62Sah38zSDu/lmLaTl1+WUxIPfWpDo5T51ns192c/S
         GqnT/xU+hXId91YkW2fRnojKdzG28S8OA8bFrS/XmI9rFOVmhgmLEY1ZlKe4ORTG2KSD
         JKel3evygK/nayQGtbY+FHnLRDOXt6mrsrzicn0ZMM9HbwRWbIlokqLucLTYnaQgjBX7
         YkFiZNJ/YljL2UDIPvsb+XihpKNG4oNgvVjGKwrkx2oCTqcgpkgVgAbwtxjL080rhuQg
         kWpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=HWSmxqQ2E3wRZbi6nJ2izSkK6TiqNf7/XR16RngzcIA=;
        b=mE+UW8o5LcTXBb7jSN+4F+3UR2FuH2LcsuFU/vquyp4JWCPT8gbdzIZbMVI737AIjQ
         KgiG/gYlHdG+p75UBwmieGrCpruj2fka+bfkojLHKJoNlAgOF6MAcsa/737WdbxP7G9z
         P9JQ/3NV9bzLOsCLXbAPYiCV9WF5V0njNcLuRyy17+AfRnj/FaCoOVcDvBK1b7SExaVA
         880JLb+y+dtr5u/bsdWglbiS2mPB1p0/MMP+b3+RezuxuwSw2G5LW1c6UKdUadTU1r7e
         kg/ltM8+K8bPp81ft7jfjX6S65nsmNAckKO5J7Rl58KXLnK77L77GztCEdXnUUupdkR/
         cYNA==
X-Gm-Message-State: AKaTC02iLSsFPe5Lfv/GlsBnoLEogQ155+Ojh2lTNrwMtKfLfM57oZ6HvXIQhyeY3bAQjKwWEeL538Vw9sf3sGxG
X-Received: by 10.55.105.129 with SMTP id e123mr87948456qkc.173.1481571344203;
 Mon, 12 Dec 2016 11:35:44 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.147.188 with HTTP; Mon, 12 Dec 2016 11:35:43 -0800 (PST)
In-Reply-To: <20161210091333.rhssskrvzjqnzelb@sigill.intra.peff.net>
References: <20161209203449.17940-1-sbeller@google.com> <20161210091333.rhssskrvzjqnzelb@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 12 Dec 2016 11:35:43 -0800
Message-ID: <CAGZ79kZVjsJjreKJgnOH1T-k-zfpfqivxw1gGm_dx4GU4tte2Q@mail.gmail.com>
Subject: Re: [RFC PATCH] send-email: allow a custom hook to prevent sending email
To:     Jeff King <peff@peff.net>
Cc:     Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 10, 2016 at 1:13 AM, Jeff King <peff@peff.net> wrote:
> On Fri, Dec 09, 2016 at 12:34:49PM -0800, Stefan Beller wrote:
>
>> My first perl contribution to Git. :)
>
> Yes, I have some style suggestions below. :)
>
>> Marked as RFC to gauge general interest before writing tests and
>> documentation.
>
> It's hard to evaluate without seeing an example of what you'd actually
> want to put into a hook.
>
>> diff --git a/git-send-email.perl b/git-send-email.perl
>> index da81be40cb..d3ebf666c3 100755
>> --- a/git-send-email.perl
>> +++ b/git-send-email.perl
>> @@ -815,6 +815,15 @@ if (!$force) {
>>                               . "Pass --force if you really want to send.\n";
>>               }
>>       }
>> +     my @hook = ( $ENV{GIT_DIR}.'hooks/send-email', $f )
>
> It's awkward to use a list here, when you just end up accessing
> $hook[0]. You can form the list on the fly when you call system(). You
> also probably are missing a trailing "/".
>
> I'm not sure that $GIT_DIR is consistently set; you probably want to
> look at "git rev-parse --git-dir" here. But I think we make a Git
> repository object earlier, and you can just do:
>
>   my $hook = join('/', $repo->repo_path(), 'hooks/send-email');
>
> Or you can just do string concatenation:
>
>   my $hook = $repo->repo_path() . '/hooks/send-email';
>
> If I were writing repo_path myself, I'd probably allow:
>
>   my $hook = $repo->repo_path('hooks/send-email');
>
> like we do with git_path() in the C code. It wouldn't be hard to add.
>
>> +     if( -x $hook[0] ) {
>
> Funny whitespace. I think:
>
>   if (-x $hook)
>
> would be more usual for us.
>
>> +             unless( system( @hook ) == 0 )
>> +             {
>> +                     die "Refusing to send because the patch\n\t$f\n"
>> +                             . "was refused by the send-email hook."
>> +                             . "Pass --force if you really want to send.\n";
>> +             }
>
> I like "unless" as a trailing one-liner conditional for edge cases,
> like:
>
>    do_this($foo) unless $foo < 5;
>
> but I think here it just makes things more Perl-ish than our code base
> usually goes for. Probably:
>
>   if (system($hook, $f) != 0) {
>         die ...
>   }
>
> would be more usual for us (in a more Perl-ish code base I'd probably
> write "system(...) and die ...").
>
> -Peff

Oh, that is quite some feedback on how not to write perl.
Thanks for pointing out how you would do it. My patch was heavily inspired
by git-cvsserver.perl:1720 so maybe that is not the best example to follow.

While trying to figure out the right place, where to put the actual code, I was
wondering about the possible interaction with it, e.g. looking at
output like this

$ git send-email 00* --cc=list --cc=bmwill --cc=duy --to=jch
0000-cover-letter.patch
0001-submodule-use-absolute-path-for-computing-relative-p.patch
0002-submodule-helper-support-super-prefix.patch
0003-test-lib-functions.sh-teach-test_commit-C-dir.patch
0004-worktree-check-if-a-submodule-uses-worktrees.patch
0005-move-connect_work_tree_and_git_dir-to-dir.h.patch
0006-submodule-add-absorb-git-dir-function.patch
(mbox) Adding cc: Stefan Beller <sbeller@google.com> from line 'From:
Stefan Beller <sbeller@google.com>'

From: Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org,
bmwill@google.com,
pclouds@gmail.com,
Stefan Beller <sbeller@google.com>
Subject: [PATCHv7 0/6] submodule absorbgitdirs
Date: Mon, 12 Dec 2016 11:04:29 -0800
Message-Id: <20161212190435.10358-1-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.rc2.49.ge1f3b0c.dirty

Send this email? ([y]es|[n]o|[q]uit|[a]ll):

---
This is usually where I just say "a" and carry on with life.
The hook would ideally reformat the last lines to be
---
    X-Mailer: git-send-email 2.11.0.rc2.49.ge1f3b0c.dirty
    send-email hook thinks it is a bad idea to send out this series:
    <output of hook, e.g.
    referencing a typo in patch 5.
    or a mismatch of patch version numbers>

    Send this email? ([y]es|[n]o|[q]uit|[a]ll):
---

So I still need to look around to see the big picture for this
patch to be implemented ideal.
