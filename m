Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 002F11FC96
	for <e@80x24.org>; Tue,  6 Dec 2016 23:02:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751953AbcLFXCR (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Dec 2016 18:02:17 -0500
Received: from mail-io0-f193.google.com ([209.85.223.193]:34347 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932115AbcLFXCO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2016 18:02:14 -0500
Received: by mail-io0-f193.google.com with SMTP id r94so9729024ioe.1
        for <git@vger.kernel.org>; Tue, 06 Dec 2016 15:02:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=PtzEN7DxczfMDrxcwm1IF998cPENrmuFGAZI5wTU0po=;
        b=JyfJTtz9Saa+HVPnZP6ICWcyDaIglruAhRSvRONflZON9mBwGdvhznp508Q+sxa5JC
         M6WF3xNmSu7E6/drPgGi3XLnS6m/Hocr69HouXyMiLAZQFrlGRAP/KHtdWJLvtyBNdOr
         eBROqCVci41+6C1cFEZbAZ3G+9R95PxjF2kgxhZtTM4Ah2nOr94wMjDR2p7tMdC9T3Nk
         w/VIDlsQ7PeAwfs0iP0ZEpQgmNfsUKyuBtxM3MW26sPsgxyYQgXsnRGHimiA/Uijzrbb
         EDUzI7l1eEPGyUhNc62FAAowf9FgEFTHMRWBJlJdoRUJF+Id9nf9IKFfWT6c3in7/v3Z
         Sovg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=PtzEN7DxczfMDrxcwm1IF998cPENrmuFGAZI5wTU0po=;
        b=Re9NElqb3BpQyFHdgH5IN7/24taEeKO6pXvDaDRnPM4hjGZfch8WmDlGYLzRMnkccy
         S7KuHf95ymsUkPYwHaFLj08SdYFT9/uKv5WnTAl6xke8BLfFUZ1Vs1mmpgJXZIH5j5+W
         iVXttcCn0Cx/U65wmX/Rg4+Q6dVqQJDTtkLPHS0xQfephfmetkxys/gkCUgdrWrVmfKG
         ZiTp0smvRULUcgZXNR3Q06x09JDneN4OAnl7iGi8JtoaWhpoGjGL+ZY4KB6V1RbHXyOB
         Ox9FqSlsZz5rZJ7vFTAsTbFxAwGtZPZRfc972aVfLnulo4RKJNQcpEOvP2wAcqENXZ0I
         uSwA==
X-Gm-Message-State: AKaTC03GYSQww1fvIqXi8hSkKVR1YgA2hh1E09TOo5Dcvo8MueKoKUoYuFjqQ/qJNrd6FNkYAPusF7bufADE8w==
X-Received: by 10.107.141.211 with SMTP id p202mr53315819iod.47.1481065333747;
 Tue, 06 Dec 2016 15:02:13 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.142.137 with HTTP; Tue, 6 Dec 2016 15:02:13 -0800 (PST)
In-Reply-To: <1816d5b4-a4c1-7c97-09ff-b11001501423@gmx.net>
References: <01020157c38b19e0-81123fa5-5d9d-4f64-8f1b-ff336e83ebe4-000000@eu-west-1.amazonses.com>
 <01020157c38b1b29-65f79716-42c6-4327-acda-8c8d0fe05471-000000@eu-west-1.amazonses.com>
 <1816d5b4-a4c1-7c97-09ff-b11001501423@gmx.net>
From:   Pranit Bauva <pranit.bauva@gmail.com>
Date:   Wed, 7 Dec 2016 04:32:13 +0530
Message-ID: <CAFZEwPNmB7rYvUTPy6dvfqfbUsjDeEcteLBBH5Wk-G_suE+YTw@mail.gmail.com>
Subject: Re: [PATCH v15 23/27] bisect--helper: `bisect_replay` shell function
 in C
To:     Stephan Beyer <s-beyer@gmx.net>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Stephan,

On Tue, Nov 22, 2016 at 6:19 AM, Stephan Beyer <s-beyer@gmx.net> wrote:
> Okay Pranit,
>
> this is the last patch for me to review in this series.
>
> Now that I have a coarse overview of what you did, I have the general
> remark that imho the "terms" variable should simply be global instead of
> being passed around all the time.

In a personal conversation with my mentors, we thought it is the best
fit to keep it in a struct and pass it around so that it is easier in
libification.

> I also had some other remarks but I forgot them... maybe they come to my
> mind again when I see patch series v16.
>
> I also want to remark again that I am not a Git developer and only
> reviewed this because of my interest in git-bisect. So some of my
> suggestions might conflict with other beliefs here. For example, I
> consider it very bad style to leak memory... but Git is rather written
> as a scripting tool than a genuine library, so perhaps many people here
> do not care about it as long as it works...

Thanks for taking out your time to review my series extremely
carefully. I will try to post a v16 next week probably.

> On 10/14/2016 04:14 PM, Pranit Bauva wrote:
>> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
>> index c18ca07..b367d8d 100644
>> --- a/builtin/bisect--helper.c
>> +++ b/builtin/bisect--helper.c
>> @@ -601,7 +602,6 @@ static int bisect_start(struct bisect_terms *terms, int no_checkout,
>>                       terms->term_good = arg;
>>               } else if (!strcmp(arg, "--term-bad") ||
>>                        !strcmp(arg, "--term-new")) {
>> -                     const char *next_arg;
>
> This should already have been removed in patch 15/27, not here.
>
>> @@ -875,6 +875,117 @@ static int bisect_log(void)
>>       return status;
>>  }
>>
>> +static int get_next_word(const char *line, int pos, struct strbuf *word)
>> +{
>> +     int i, len = strlen(line), begin = 0;
>> +     strbuf_reset(word);
>> +     for (i = pos; i < len; i++) {
>> +             if (line[i] == ' ' && begin)
>> +                     return i + 1;
>> +
>> +             if (!begin)
>> +                     begin = 1;
>> +             strbuf_addch(word, line[i]);
>> +     }
>> +
>> +     return i;
>> +}
>> +
>> +static int bisect_replay(struct bisect_terms *terms, const char *filename)
>> +{
>> +     struct strbuf line = STRBUF_INIT;
>> +     struct strbuf word = STRBUF_INIT;
>> +     FILE *fp = NULL;
>
> (The initialization is not necessary here.)

Um. I think it is. Otherwise if it goes to the finish block before you
try to operate on fp, it will cause a seg fault.

>> +     int res = 0;
>> +
>> +     if (is_empty_or_missing_file(filename)) {
>> +             error(_("no such file with name '%s' exists"), filename);
>
> The error message is misleading if the file exists but is empty.
> Maybe something like "cannot read file '%s' for replaying"?

Okay will change.

>> +             res = -1;
>> +             goto finish;
>
>                 goto fail;
> :D
>
>> +     }
>> +
>> +     if (bisect_reset(NULL)) {
>> +             res = -1;
>> +             goto finish;
>
>                 goto fail;
>
>> +     }
>> +
>> +     fp = fopen(filename, "r");
>> +     if (!fp) {
>> +             res = -1;
>> +             goto finish;
>
>                 goto fail;
>
>> +     }
>> +
>> +     while (strbuf_getline(&line, fp) != EOF) {
>> +             int pos = 0;
>> +             while (pos < line.len) {
>> +                     pos = get_next_word(line.buf, pos, &word);
>> +
>> +                     if (!strcmp(word.buf, "git")) {
>> +                             continue;
>> +                     } else if (!strcmp(word.buf, "git-bisect")) {
>> +                             continue;
>> +                     } else if (!strcmp(word.buf, "bisect")) {
>> +                             continue;
>> +                     } else if (!strcmp(word.buf, "#")) {
>> +                             break;
>
> Maybe it is more robust to check whether word.buf begins with #

Assuming that you meant "# ", yes.

>> +                     }
>> +
>> +                     get_terms(terms);
>> +                     if (check_and_set_terms(terms, word.buf)) {
>> +                             res = -1;
>> +                             goto finish;
>
>                                 goto fail;
>
>> +                     }
>> +
>> +                     if (!strcmp(word.buf, "start")) {
>> +                             struct argv_array argv = ARGV_ARRAY_INIT;
>> +                             sq_dequote_to_argv_array(line.buf+pos, &argv);
>> +                             if (bisect_start(terms, 0, argv.argv, argv.argc)) {
>> +                                     argv_array_clear(&argv);
>> +                                     res = -1;
>> +                                     goto finish;
>
>                                         goto fail;
>
>> +                             }
>> +                             argv_array_clear(&argv);
>> +                             break;
>> +                     }
>> +
>> +                     if (one_of(word.buf, terms->term_good,
>> +                         terms->term_bad, "skip", NULL)) {
>> +                             if (bisect_write(word.buf, line.buf+pos, terms, 0)) {
>> +                                     res = -1;
>> +                                     goto finish;
>
>                                         goto fail;
>
>> +                             }
>> +                             break;
>> +                     }
>> +
>> +                     if (!strcmp(word.buf, "terms")) {
>> +                             struct argv_array argv = ARGV_ARRAY_INIT;
>> +                             sq_dequote_to_argv_array(line.buf+pos, &argv);
>> +                             if (bisect_terms(terms, argv.argv, argv.argc)) {
>> +                                     argv_array_clear(&argv);
>> +                                     res = -1;
>> +                                     goto finish;
>
>                                         goto fail;
>
>> +                             }
>> +                             argv_array_clear(&argv);
>> +                             break;
>> +                     }
>> +
>> +                     error(_("?? what are you talking about?"));
>
> I know this string is taken from the original source. However, even
> something like error(_("Replay file contains rubbish (\"%s\")"),
> word.buf) is more informative.

Okay will change.

>> +                     res = -1;
>> +                     goto finish;
>
>                         goto fail;
>
>> +             }
>> +     }
>> +     goto finish;
>
> +fail:
> +       res = -1;
>
> I just wanted to make finally clear what I was referring to by the
> "goto fail" trick. :D

I got it. Will update accordingly.

> Also I think the readability could be improved by extracting the body of
> the outer while loop into an extra function replay_line(). Then most of
> my suggested "goto fail;" lines simply become "return -1;" :)
>
>> @@ -998,6 +1112,13 @@ int cmd_bisect__helper(...)
>>                       die(_("--bisect-log requires 0 arguments"));
>>               res = bisect_log();
>>               break;
>> +     case BISECT_REPLAY:
>> +             if (argc != 1)
>> +                     die(_("--bisect-replay requires 1 argument"));
>
> I'd keep the (already translated) string from the original source:
> "No logfile given"

Sure

Regards.
Pranit Bauva
