Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4CCF62070F
	for <e@80x24.org>; Sun, 18 Sep 2016 18:40:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756625AbcIRSk0 (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Sep 2016 14:40:26 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:36243 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755123AbcIRSkZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Sep 2016 14:40:25 -0400
Received: by mail-wm0-f43.google.com with SMTP id w84so42528866wmg.1
        for <git@vger.kernel.org>; Sun, 18 Sep 2016 11:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=EcXQ38KIFnWsxfHcBqjfWlCyqZnZtMpwIeZKxaWMLDc=;
        b=MfYYGyLYB0LO0Mq6LyV5SnEbUIjzUDd1QpsLgGbMbtzAzAI11ZxZlikPMhTQNWMRLV
         Xj1O9K0nYNMg4lYr71tlFvzARD9wuoxu19nIcd3+tMyE7v68wMvk4Oim2xxDQpJVTY1m
         UF7Q4aRxoKJLzDIS4O/HTghBqrvZm7bFFci/TKZAydoHtjM4wtWzfw4OUO2hdz+cWieX
         w75JVGo2rhXiuXmaa02U+U+82QnuybNzXhawKE4ehFkoRwo/4CqVi8Tqut4GQ+dkgLlK
         /kKbbz32Hpq63OL3a8hyz2Ni+Yqui+ck1u7ONpSCEsjgu/jKVy2y5gEZogeVVs3iqbPw
         LMHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=EcXQ38KIFnWsxfHcBqjfWlCyqZnZtMpwIeZKxaWMLDc=;
        b=gTdfegPBdY9WCZIt8lQfdyIcCIi+3BZdY6LNdS3rF93EfHxHKKOVfuGptoB/YvHfl/
         fOE+pL+f8QlEBhPudZ5kBiuCXxN9kj8mXc2vg4zZPTe2FCJqErQG+d0l1FLHN7ESUJ1f
         f+5G0pR6DDjSVTG8etW6R7yCVuhwWbnie/CbHdR6GXWd27C0o7TXonxGhOEb1fz409lp
         Mflx7cuE6LBHtnHkcsRaD/T0WDKxYIer+HOhZd+q/+jIHS/9b4NJVXOdNSA5GwRe6wtd
         iqo4HW+yUoZagUHte6jRh1a1lvnQ9IxUO3q6ONtkahXqwoWimUwr1FUWnv8BdDqaHg7l
         W+uA==
X-Gm-Message-State: AE9vXwPziRd+DTvgAEshh7O7hrYifujSX219H0xhRmK6GwC2KDQrRwRpzOMgpns4oRqTJsA8+bK/JyN9gmtwXyVB
X-Received: by 10.194.178.130 with SMTP id cy2mr20380108wjc.138.1474224023300;
 Sun, 18 Sep 2016 11:40:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.69.25 with HTTP; Sun, 18 Sep 2016 11:40:22 -0700 (PDT)
In-Reply-To: <xmqqtwdfgpd0.fsf@gitster.mtv.corp.google.com>
References: <CAKoko1pewoxD4=_9M45pchdDg03K8fc73raJOsf4A+=KKw_EMw@mail.gmail.com>
 <1474073981-96620-1-git-send-email-bmwill@google.com> <xmqqtwdfgpd0.fsf@gitster.mtv.corp.google.com>
From:   Brandon Williams <bmwill@google.com>
Date:   Sun, 18 Sep 2016 11:40:22 -0700
Message-ID: <CAKoko1r6cfv-2HVCJPgGbXyCVe-wdUBS+2nXtaTHO3jshVg8MA@mail.gmail.com>
Subject: Re: [PATCH] ls-files: add pathspec matching for submodules
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Heiko Voigt <hvoigt@hvoigt.net>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 16, 2016 at 8:46 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> As the previous one that used a wrong (sorry) argument is not even
> in 'next' yet, let's pretend that it never happened.  It is OK to
> still keep it and this patch as two separate steps, i.e. a topic
> with two patches in it.

Yeah since I've been using what I built in the last patch to test the pathspecs
I based this patch off of what you have in bw/ls-files... branch.

>
>> +     /* Add pathspec args */
>> +     argv_array_push(&cp.args, "--");
>> +     for (i = 0; i < pathspec.nr; ++i)
>> +             argv_array_push(&cp.args, pathspec.items[i].original);
>
> OK, so as discussed previously with Heiko and Stefan, the idea is to
>
>  - pass the original pathspec as-is,
>
>  - when --submodule-prefix is given, a path discovered in a
>    submodule repository is first prefixed with that string before
>    getting checked to see if it matches the original pathspec.
>
> And this loop is about relaying the original pathspec.

Exactly.  Perhaps I should have made this more clear either with a
detailed comment or
more information in the commit msg.

>> @@ -192,57 +210,63 @@ static void show_gitlink(const struct cache_entry *ce)
>>
>>  static void show_ce_entry(const char *tag, const struct cache_entry *ce)
>>  {
>> +     struct strbuf name = STRBUF_INIT;
>>       int len = max_prefix_len;
>> +     if (submodule_prefix)
>> +             strbuf_addstr(&name, submodule_prefix);
>> +     strbuf_addstr(&name, ce->name);
>>
>>       if (len >= ce_namelen(ce))
>> -             die("git ls-files: internal error - cache entry not superset of prefix");
>> +             die("git ls-files: internal error - cache entry not "
>> +                 "superset of prefix");
>
> This is not such a great thing to do.  Upon a bug report, we can no
> longer do
>
>         git grep 'cache entry not superset'
>
> to see where the error message is coming from.

Oh i wasn't really thinking about that.  I simply noticed that the
line was longer than
80 characters and figured I should break it to adhere to style guidelines.

>
>> -     if (!match_pathspec(&pathspec, ce->name, ce_namelen(ce),
>> -                         len, ps_matched,
>> -                         S_ISDIR(ce->ce_mode) || S_ISGITLINK(ce->ce_mode)))
>> -             return;
>> -     if (recurse_submodules && S_ISGITLINK(ce->ce_mode)) {
>> +     if (recurse_submodules && S_ISGITLINK(ce->ce_mode) &&
>> +         submodule_path_match(&pathspec, name.buf, ps_matched)) {
>>               show_gitlink(ce);
>> -             return;
>> -     }
>> +     } else if (match_pathspec(&pathspec, name.buf, name.len,
>> +                               len, ps_matched,
>> +                               S_ISDIR(ce->ce_mode) ||
>> +                               S_ISGITLINK(ce->ce_mode))) {
>> +             if (tag && *tag && show_valid_bit &&
>> + ...
>
> Argh.  If we had a preparatory clean-up step, would it have helped
> to avoid this big re-indentation that makes the patch harder to read
> than necessary, I wonder?
>
> Another way would have been to "goto" from the end of this block
>
>> +     if (recurse_submodules && S_ISGITLINK(ce->ce_mode) &&
>> +         submodule_path_match(&pathspec, name.buf, ps_matched)) {
>
> where we used to "return" out to the central clean-up location, i.e.
> here.
>
>> +     strbuf_release(&name);
>>  }

Yeah, the lack of destructors in C makes this a bit of a challenge when we need
to free up memory.  I've also always been taught to avoid using goto's
as they can
be error prone and lead to making the code more difficult to read.
Hence why I did
 some adjustments to make it so the function had a single exit point
to make it easy
 for cleanup.


>
>
>>       parse_pathspec(&pathspec, 0,
>>                      PATHSPEC_PREFER_CWD |
>>                      PATHSPEC_STRIP_SUBMODULE_SLASH_CHEAP,
>>                      prefix, argv);
>>
>> -     /* Find common prefix for all pathspec's */
>> -     max_prefix = common_prefix(&pathspec);
>> +     /*
>> +      * Find common prefix for all pathspec's
>> +      * This is used as a performance optimization which violates correctness
>> +      * in the recurse_submodules mode
>> +      */
>
> The two new lines phrase it overly negatively and also misleading.
> I thought you were saying "We do this as optimization anyway; damn
> the correctness in the submodule case!" in my first reading before
> reading the statements the comment talks about.  "This optimization
> unfortunately cannot be done when recursing into submodules" would
> have been better.

haha yeah, I wasn't trying to be overly negative!  I agree that your
wording makes more sense.

>
>> +     if (recurse_submodules)
>> +             max_prefix = NULL;
>> +     else
>> +             max_prefix = common_prefix(&pathspec);
>>       max_prefix_len = max_prefix ? strlen(max_prefix) : 0;
>
>> diff --git a/dir.c b/dir.c
>> index 0ea235f..630dc7a 100644
>> --- a/dir.c
>> +++ b/dir.c
>> @@ -63,6 +63,30 @@ int fspathncmp(const char *a, const char *b, size_t count)
>>       return ignore_case ? strncasecmp(a, b, count) : strncmp(a, b, count);
>>  }
>>
>> +static int prefix_fnmatch(const struct pathspec_item *item,
>> +                const char *pattern, const char *string,
>> +                int prefix)
>> +{
>
> Is this meant to be free of false positives, free of false
> negatives, or exact?  I think you use it to decide, without knowing
> what kind of paths the submodule contains, if it is worth descending
> into it, so as long as you definitively say "The pathspec can never
> match anything in the submodule" with WM_NOMATCH, it is OK if you
> returned WM_MATCH when it actually couldn't match anything.  I.e. it
> is OK to give false positive but it is a bug to give false negative.
>
> The answer to the above question should be a good explanation to
> prepend as /* comment */ before the function.

Yeah the idea is the parent project has no knowledge of the file
structure of the
child so if the submodule name matches a prefix of the pathspec then it could
potentially apply to a file inside the submodule.  So it can
definitely give false
positives since we could descend into the submodule and discover that it doesn't
match anything there.  I can add a comment to that effect.

>
>> +     if (prefix > 0) {
>> +             if (ps_strncmp(item, pattern, string, prefix))
>> +                     return WM_NOMATCH;
>
> This says: when we have a set prefix that must literally match, and
> that part does not match what we have, it cannot possibly match.
>
> Is that correct?  What do we have in "name" and "item" at this
> point?  We disable the common-prefix optimization, so we do not have
> to worry about a pathspec with two elements "sub/dir1/*" and "sub/dir2/*"
> giving you "sub/dir" as the common prefix, when you are wondering if
> it is worth descending into "sub/" without knowing what it contains.
> Is that what guarantees why this part is correct?

I adopted this structure from another part of the code.  The caller
uses a field in
the pathspec item which indicates the location of the first wildcard character.
So the prefix (everything prior to the wildcard char) must match
literally before
we drop into a more expensive wildmatch function.


>
>> +             pattern += prefix;
>> +             string += prefix;
>> +     }
>> +
>> +     if (item->flags & PATHSPEC_ONESTAR) {
>> +             return WM_MATCH;
>
> We have a pathspec that has a segment without wildcard letters,
> followed by a '*', and there is no wildcard letters after that
> asterisk.  We punt and assume it might match, which is OK for the
> purpose of not giving a false negative.

Exactly.  Currently if you give *.txt as a pathspec it can match every
txt file no
matter which directory its in.  Because of this if we hit a * we can
punt and hand
it off to the submodule to perform more accurate matching.

>
>> +     } else if (item->magic & PATHSPEC_GLOB) {
>> +             return wildmatch(pattern, string,
>> +                              WM_PATHNAME |
>> +                              (item->magic & PATHSPEC_ICASE ?
>> +                               WM_CASEFOLD : 0),
>> +                              NULL);
>
> What does this say?  If we are using the :(glob) semantics, which is
> the default, we'll ask wildmatch() to see the remainder of the
> pattern (after stripping the fixed prefix part if necessary) matches
> the string (which also may have lost the prefix that we already know
> matches).
>
> Is that correct?  I think it depends on what "string" is being fed,
> but I am assuing that you are working in the top-level project here
> to decide if it is worth descending into a submodule.  If the item
> is sub/dir?/*.c and we are considering "sub/" submodule, wildmatch
> would not say "It could match" if "string" is "sub/".  Perhaps I am
> reading the patch incorrectly.  Let me read on to see what the caller
> does later.

Actually thinking on this we may need to add in a special case to the
wildmatch function.
Since right now I believe that a string must completely match against
the pattern passed
in to wildmatch as apposed to wanting the string to match a prefix of
the pattern.

-Brandon
