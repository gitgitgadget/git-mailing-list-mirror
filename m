From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH v2] bisect--helper: convert a function in shell to C
Date: Tue, 22 Mar 2016 23:15:40 +0530
Message-ID: <CAFZEwPNg8-X5dsBbMfg5ni1XpOVekRd13y-zgwYJpX0fCwg3Ug@mail.gmail.com>
References: <010201539a8d2b8a-9f168d7a-d4c6-4c23-a61f-1ef6ee22f774-000000@eu-west-1.amazonses.com>
	<010201539d57ae98-ce4860a6-f7b6-4e06-b556-3c1340cd7749-000000@eu-west-1.amazonses.com>
	<alpine.DEB.2.20.1603221552100.4690@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Mar 22 18:45:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aiQNF-000504-Tx
	for gcvg-git-2@plane.gmane.org; Tue, 22 Mar 2016 18:45:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753902AbcCVRpn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2016 13:45:43 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:32905 "EHLO
	mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751713AbcCVRpl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2016 13:45:41 -0400
Received: by mail-yw0-f193.google.com with SMTP id a140so13630161ywe.0
        for <git@vger.kernel.org>; Tue, 22 Mar 2016 10:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=+Mp2JYyDR+axlCX9qy247oFpJUuCBOSG/wFe2IxKgk4=;
        b=wARWXQeaSL73FJ3OO0DnOlnb1Uu008qtv7opQWF64q2uXgt4+ClXKBNR5sCTbHDN3g
         DYP4PdhWh39v8g0o+Xk5Bs1TA5E7bDRzgsPHvUAZaA6ZTUsBzq2Hnz6POCrKUZm7D6P3
         Xx5fQPMGuVF8mkZA2wqq1nMKi6gjN1y5H6+XLhURV3mYKrTyjsIx6J8oQhnTuY0mZRO7
         zpQfHFMIE0ou/iJrIE+9tN7XrxCgqWaTlVztJoBms7myYotIOHsAxpw3/F/mSCbixZ1h
         t/rE1ecaA3QRHO3zk+xsuGIk/x2wnZDcDAT2sAcceGImo3+0UdjRL7UQrnCQ20cT1bHW
         uaAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=+Mp2JYyDR+axlCX9qy247oFpJUuCBOSG/wFe2IxKgk4=;
        b=bX99QJefQSxP8XEypFYkjU4EwOi4ohL414uWxsNrWTFfQwToFVuD/AYLfGac14dsKe
         hbHi3Vm5ehSN2C7xgCLzjbDXPC44d7uUxcjZM4pGAzhPGr9RZRujgpocN58mq8T6PeyD
         EJ3DWZIADYJ9g1ZwCIHcGpBjjKHiSj7ChGxte52JHpT3pPiXCIufJGMurqw/BVFz4EH9
         a5zDizB1HjAJywRzKZgzm+t3gS2Di6vVJgcQmrKAZ2bb4jaqRFjD63w0nGVXywkPLevI
         k6ORpV6IgnU2XrYGZeoSTkKmStyr9G7i3P4QiGX3uJeSGrqtc4h4WaIEH5PZ/9v+pPCF
         oAUw==
X-Gm-Message-State: AD7BkJK/H1FZE9Q46X+bzM+DxCmiJW+0vq/Hoxebk2SOfWR+POUxE9d87PmPZAO66Rw3Njjn0YtxdhdDWNRrpQ==
X-Received: by 10.13.252.67 with SMTP id m64mr19132971ywf.67.1458668740794;
 Tue, 22 Mar 2016 10:45:40 -0700 (PDT)
Received: by 10.13.203.137 with HTTP; Tue, 22 Mar 2016 10:45:40 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1603221552100.4690@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289528>

On Tue, Mar 22, 2016 at 8:39 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Tue, 22 Mar 2016, Pranit Bauva wrote:
>
>> Convert the code literally without changing its design even though it
>> seems that its obscure as to the use of comparing revision to different
>
> s/its/it is/

Sure! A typo.

>> bisect arguments which seems like a problem in shell because of the way
>> function arguments are handled.
>
> I agree that it is obscure. That is why I would suggest to fix it during
> the conversion. Using 'new_term' and 'orig_term' (or something similar)
> would make much more sense.
>
> Another good idea would be to include the shell code, or at least to
> provide a link such as:
>
>         https://github.com/git/git/blob/v2.8.0-rc4/git-bisect.sh#L572-L597
>

I will take care about this henceforth.

>> The argument handling is kind of hard coded right now because it is not
>> really be meant to be used like this and this is just for testing
>> purposes whether this new method is as functional as its counter part.
>> The shell counter part of the method has been retained for historical
>> purposes.
>
> Still, it would make more sense (both in terms of readability and in terms
> of code safety) to introduce and use a function like
>
> static int one_of(const char *term, ...)
> {
>         va_list matches;
>         const char *match;
>
>         va_start(matches, term);
>         while ((match = va_arg(matches, const char *)))
>                 if (!strcmp(term, match))
>                         return 1;
>         va_end(matches);
>
>         return 0;
> }
>

>> +static int check_term_format(const char *term, const char *revision, int flags);
>> +
>> +static int check_term_format(const char *term, const char *revision, int flag) {
>
> Since you define the check_term_format() function here, the declaration
> above is unnecessary. Let's just delete it.

Yes. We could just add functions below this so that it would not
create a problem.

>
>> +     if (check_refname_format(term, flag))
>> +             die("'%s' is not a valid term", term);
>> +
>> +     if (!strcmp(term, "help") || !strcmp(term, "start") ||
>> +             !strcmp(term, "skip") || !strcmp(term, "next") ||
>> +             !strcmp(term, "reset") || !strcmp(term, "visualize") ||
>> +             !strcmp(term, "replay") || !strcmp(term, "log") ||
>> +             !strcmp(term, "run"))
>> +             die("can't use the builtin command '%s' as a term", term);
>
> This would look so much nicer using the one_of() function above.

one_of() will definitely make it clean.

> Please also note that our coding convention (as can be seen from the
> existing code in builtin/*.c) is to indent the condition differently than
> the block, either using an extra tab, or by using 4 spaces instead of the
> tab.
>

I
>> +     if (!strcmp(term, "bad") || !strcmp(term, "new"))
>> +             if(strcmp(revision, "bad"))
>> +                     die("can't change the meaning of term '%s'", term);
>> +
>> +     if (!strcmp(term, "good") || !strcmp(term, "old"))
>> +             if (strcmp(revision, "good"))
>> +                     die("can't change the meaning of term '%s'", term);
>
> These two can be combined. Actually, these *four* can easily be combined:
>
>         if ((one_of(term, "bad", "new", NULL) && strcmp(orig, "bad")) ||
>             (one_of(term, "good", "old", NULL) && strcmp(orig, "good")))
>                 die("can't change the meaning of term '%s'", term);
>
>>  int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
>>  {
>>       int next_all = 0;
>>       int no_checkout = 0;
>> +     const char *term;
>
> Better use the existing convention:
>
>         int check_term_format = 0;
>
>>       struct option options[] = {
>>               OPT_BOOL(0, "next-all", &next_all,
>>                        N_("perform 'git bisect next'")),
>>               OPT_BOOL(0, "no-checkout", &no_checkout,
>>                        N_("update BISECT_HEAD instead of checking out the current commit")),
>> +             OPT_STRING(0, "check-term-format", &term, N_("term"),
>> +                      N_("check the format of the ref")),
>
> Hmm. The existing code suggests to use OPT_BOOL instead.
>
>>               OPT_END()
>>       };
>>
>>       argc = parse_options(argc, argv, prefix, options,
>>                            git_bisect_helper_usage, 0);
>>
>> +
>> +     if (term != NULL) {
>> +             if (argc > 0)
>
> Here you need to test for a precise argc, not for a range.

True.

>> +                     return check_term_format(term, argv[0], 0);
>> +             else
>> +                     die("no revision provided with check_for_term");
>> +     }
>> +
>>       if (!next_all)
>>               usage_with_options(git_bisect_helper_usage, options);
>>
>> diff --git a/git-bisect.sh b/git-bisect.sh
>> index 5d1cb00..ea237be 100755
>> --- a/git-bisect.sh
>> +++ b/git-bisect.sh
>> @@ -564,8 +564,8 @@ write_terms () {
>>       then
>>               die "$(gettext "please use two different terms")"
>>       fi
>> -     check_term_format "$TERM_BAD" bad
>> -     check_term_format "$TERM_GOOD" good
>> +     git bisect--helper --check-term-format="$TERM_BAD" bad
>> +     git bisect--helper --check-term-format="$TERM_GOOD" good
>
> The existing convention is to make the first argument *not* a value of the
> "option", i.e. `--check-term-format "$TERM_BAD"` without an equal sign.

Will change this.

> Did you also run the test suite after compiling, to verify that the
> documented expectations are still met after the conversion?

Yes I did run the tests. They produce the same results as they did before.
To ease review I will next time include these the output of the tests
in the commented section.

t6002-rev-list-bisect.sh : http://paste.ubuntu.com/15473728/
t6030-bisect-porcelain.sh : http://paste.ubuntu.com/15473734/
t6041-bisect-submodule.sh : http://paste.ubuntu.com/15473743/

Is there any other test I would need to run?

Regards,
Pranit Bauva
