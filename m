Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A0065208CD
	for <e@80x24.org>; Tue, 15 Aug 2017 21:41:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752593AbdHOVlV (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Aug 2017 17:41:21 -0400
Received: from mail-pg0-f47.google.com ([74.125.83.47]:37459 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752562AbdHOVlV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Aug 2017 17:41:21 -0400
Received: by mail-pg0-f47.google.com with SMTP id y129so13144626pgy.4
        for <git@vger.kernel.org>; Tue, 15 Aug 2017 14:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=24UzAa0IicPHRwKt55j0Pxn3K5svSwTALku/yObj6+Q=;
        b=FkfVRjTjVJKWiXEd+m1SLaovqXv38i2SX4TtP2Moy165/9FdoUZ95VrMeqvMxu4hxj
         at450sTHT3N7T8vISICxQE6aldVAf44XOsRb8Av4bitQP8M7jb+Hng9V+9efOdx7DzoZ
         xu29meBhySZd3NVUilONOrg6kr1dnOkReQfKMGxhHnXyEoX1k814c9D01rmRRXkeShnV
         dGWF2fZZGYzlFOQM6TOdaY8uAEqGT0gKTMa+nP8xCQgwcGsK+8RRExE2zXwsvJmtQM82
         uENpXdwE5iWeGkkujGupprtNPWophzjmG641N42EB258xXPoPC3upJm6y9H68G/tz2FA
         xw4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=24UzAa0IicPHRwKt55j0Pxn3K5svSwTALku/yObj6+Q=;
        b=fys0IZizzNdo/iTZ5pG4eZLnQTlfx3HFzWagz3ZQWjOX7OSmjX20cm9Sm+D2Cp1Ab0
         yQxcQMhmjpOzdz4RpKY3opZKfRzS04UzN+emaTA1azvpFdZ5HpFqeAQOgZABuWJD7iJg
         AQqtIpbOJwz+bweJgiG2YvoCixNjnv8mCQQK0KX1hgJyXeEBGaQVy5kNuiG8HRT5kVO+
         K4Qb1ffmmcgKxrGg7xJVxZTb5IaLhK4ur6J8crvlfGUFv17h8+L5oG/puGY70WkKiZpI
         CBROONLxZTjX1OQ/vwpmwp0P97jAFkGHggq3akn0HuTC3+oIwcoMtq757Ifat97ebdxW
         bQFg==
X-Gm-Message-State: AHYfb5gokhzFDFZd1NhYIDrvyi6j2gTdzE41xLIv4Z1HhyQWZnImMRSi
        teZV8d4/A2RuP8h5/p/rsAxc+mHT4rDg
X-Received: by 10.99.131.67 with SMTP id h64mr683512pge.310.1502833280370;
 Tue, 15 Aug 2017 14:41:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.132.193 with HTTP; Tue, 15 Aug 2017 14:41:19 -0700 (PDT)
In-Reply-To: <xmqqpobwplde.fsf@gitster.mtv.corp.google.com>
References: <20170815203503.12299-1-asottile@umich.edu> <xmqqpobwplde.fsf@gitster.mtv.corp.google.com>
From:   Anthony Sottile <asottile@umich.edu>
Date:   Tue, 15 Aug 2017 14:41:19 -0700
Message-ID: <CA+dzEBnMOoXYaP7QadQ+gzKKJ7OzJKAPwbW=zr=1fksCQNBVcw@mail.gmail.com>
Subject: Re: [PATCH/RFC] git-grep: correct exit code with --quiet and -L
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ah yes, I didn't intend to include the first hunk (forgot to amend it
out when formatting the patch).

I think git's exit codes for -L actually make more sense than the GNU
exit codes (especially when comparing with `grep` vs `grep -v`) --
that is, produce `0` when the search is successful (producing
*something* on stdout) and `1` when the search fails.

Shall I create a new mail with the adjusted patch as suggested above?
(I'm not familiar with the expected workflow).

Anthony

On Tue, Aug 15, 2017 at 2:33 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Anthony Sottile <asottile@umich.edu> writes:
>
>> The handling of `status_only` no longer interferes with the handling of
>> `unmatch_name_only`.  `--quiet` no longer affects the exit code when using
>> `-L`/`--files-without-match`.
>
> I agree with the above statement of yours that --quiet should not
> affect what the exit status is.
>
> But I am not sure what the exit code from these commands _should_
> be:
>
>     $ git grep -L qfwfq \*.h    ;# no file matches
>     $ git grep -L \# \*.h       ;# some but not all files match
>     $ git grep -L . \*.h        ;# all files match
>
> with or without --quiet.  I seem to get 0, 0, 1, which I am not sure
> is correct.  I do recall writing "git grep" _without_ thinking what
> the exit code should be when we added --files-without-match, so the
> exit status the current code gives out may be just a random garbage.
>
> Asking GNU grep (because --files-without-match is not a POSIX thing):
>
>     $ grep -L qfwfq *.h          ;# no file matches
>     $ grep -L \# *.h             ;# some but not all files match
>     $ grep -L . *.h              ;# all files match
>
> I seem to get 1, 0, 0.  So the exit status should reflect if there
> was _any_ hit from any file that were inspected.
>
>> @@ -1755,7 +1755,7 @@ static int grep_source_1(struct grep_opt *opt, struct grep_source *gs, int colle
>>               }
>>               if (hit) {
>>                       count++;
>> -                     if (opt->status_only)
>> +                     if (!opt->unmatch_name_only && opt->status_only)
>>                               return 1;
>>                       if (opt->name_only) {
>>                               show_name(opt, gs->name);
>
> Does the change in this hunk have any effect?
>
> Just before this hunk there is this code:
>
>                 /* "grep -v -e foo -e bla" should list lines
>                  * that do not have either, so inversion should
>                  * be done outside.
>                  */
>                 if (opt->invert)
>                         hit = !hit;
>                 if (opt->unmatch_name_only) {
>                         if (hit)
>                                 return 0;
>                         goto next_line;
>
> If (opt->unmatch_name_only && hit) then the function would have
> already returned and the control wouldn't have reached here.
>
> Which would mean that when the control reaches the line this hunk
> touches, either one of these must be false, and because we are
> inside "if (hit)", opt->unmatch_name_only must be false.
>
>> @@ -1820,13 +1820,14 @@ static int grep_source_1(struct grep_opt *opt, struct grep_source *gs, int colle
>>       if (collect_hits)
>>               return 0;
>>
>> -     if (opt->status_only)
>> -             return 0;
>>       if (opt->unmatch_name_only) {
>>               /* We did not see any hit, so we want to show this */
>> -             show_name(opt, gs->name);
>> +             if (!opt->status_only)
>> +                     show_name(opt, gs->name);
>>               return 1;
>>       }
>> +     if (opt->status_only)
>> +             return 0;
>
> This hunk makes sense to me (provided if the semantics we want out
> of --files-without-match is sensible, which is dubious), even though
> I would have limited the change to just a single line, i.e.
>
>         if (opt->status_only)
> -               return 0;
> +               return opt->unmatch_name_only;
>         if (opt->unmatch_name_only) {
>                 /* We did not see any hit, ... */
>
> But I suspect we want to fix the exit code not to be affected by
> the "--files-without-match" option in the first place, so all the
> code changes we see in this patch might be moot X-<.
>
>
