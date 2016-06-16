Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.7 required=5.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C14F61FE4D
	for <e@80x24.org>; Thu, 16 Jun 2016 19:05:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753945AbcFPTFJ (ORCPT <rfc822;e@80x24.org>);
	Thu, 16 Jun 2016 15:05:09 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:34483 "EHLO
	mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752587AbcFPTFI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jun 2016 15:05:08 -0400
Received: by mail-yw0-f194.google.com with SMTP id b75so6422761ywe.1
        for <git@vger.kernel.org>; Thu, 16 Jun 2016 12:05:07 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=efcxKr90llWxIV+EZj6XezCjVROyzsF3rqb6kbLOp1o=;
        b=rogsdGyl4ky1chJkme4P+J7rWwlAUkaLeu6pDboAlfvBXn+80UxfrjaZWDRsmcWv9j
         7lmRRT316u2n7q1MItiroaI0MCSYMiqBslPNpm3a2yK1FozvpUVduuk8RNGatXvkBVVK
         L97FbPF48Ax8wvmqaeplvRBkMI7+s15v5KRQseOnNzFNGeSC4RW0vrYpEP6P4DOztI+H
         m+RMuP+fhki/OshVbzOHnR5LdLc5u51CTxB8U0QJvYyDdCKkism3l21Ksp4IrEBABrYI
         7/stntTg27vxM84Mpq74SkOoAD65N5bkWKzF3l3M6TW4J4iF6pxm7ReHhYUiwsx6IudU
         SOPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=efcxKr90llWxIV+EZj6XezCjVROyzsF3rqb6kbLOp1o=;
        b=A/PPJfqpH/3lTlPkSH7YdiXttF1vz7uxvct+EOfxFa9CHd0g/fX5grJORUkc5vghCl
         8gROJ4jALbRkqSmxA0BWoM452mxApCl++NHp2/1QGYCOIn3TUIz4/64/YqoAMBX4H4kK
         AGfRnISTDG77zEg4nfwZGqiPhrCFu/fOBEAkdHs9HGl68kywQzfTmkIKlpakNrruYhu4
         XJuPryZwCeAkxJ8qojHHQ7EKkyK8ux3cSwVUslBU/jUfMI4hMVDLxEZ3TW1Y63W8AccF
         Ft33CYAs9OO/qeCGnYmAjq12Fr6NEAWEl0kmuKVbg2pE54NH/sIKJ+T60kqa2C5CiPOK
         QoRA==
X-Gm-Message-State: ALyK8tIw+JRjW/w2zpjwFGJ81ljpEeLHM5bWtJUbU7krpvPJxe1s+W3RQSAMYmIQIf09ISAuu3V5su4EEnngdw==
X-Received: by 10.13.227.69 with SMTP id m66mr3695874ywe.302.1466103906548;
 Thu, 16 Jun 2016 12:05:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.129.116.193 with HTTP; Thu, 16 Jun 2016 12:05:06 -0700 (PDT)
In-Reply-To: <CAPig+cRNcg496Ty2SJ1ojm1n3OpHzX0obMAD2bY3AzoyrKdA9w@mail.gmail.com>
References: <20160607205454.22576-1-pranit.bauva@gmail.com>
 <20160615140026.10519-1-pranit.bauva@gmail.com> <20160615140026.10519-6-pranit.bauva@gmail.com>
 <CAPig+cRNcg496Ty2SJ1ojm1n3OpHzX0obMAD2bY3AzoyrKdA9w@mail.gmail.com>
From:	Pranit Bauva <pranit.bauva@gmail.com>
Date:	Fri, 17 Jun 2016 00:35:06 +0530
Message-ID: <CAFZEwPP0-9rHOKFZBoE55pv4V-+okSLh4M5grNKWnq831Ug4+w@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] bisect--helper: `is_expected_rev` &
 `check_expected_revs` shell function in C
To:	Eric Sunshine <sunshine@sunshineco.com>
Cc:	Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Lars Schneider <larsxschneider@gmail.com>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hey Eric,

On Thu, Jun 16, 2016 at 2:44 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Wed, Jun 15, 2016 at 10:00 AM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
>> Reimplement `is_expected_rev` & `check_expected_revs` shell function in
>> C and add a `--check-expected-revs` subcommand to `git bisect--helper` to
>> call it from git-bisect.sh .
>> [...]
>> Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
>> ---
>> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
>> @@ -162,13 +162,44 @@ static int bisect_reset(const char *commit)
>> +static int is_expected_rev(const char *expected_hex)
>> +{
>> +       struct strbuf actual_hex = STRBUF_INIT;
>> +       int res;
>> +
>> +       if (strbuf_read_file(&actual_hex, git_path_bisect_expected_rev(), 0) < 0) {
>> +               strbuf_release(&actual_hex);
>> +               return 0;
>> +       }
>> +
>> +       strbuf_trim(&actual_hex);
>> +       res = !strcmp(actual_hex.buf, expected_hex);
>> +       strbuf_release(&actual_hex);
>> +       return res;
>> +}
>
> Not worth a re-roll, but this could be re-structured to avoid having
> to remember to release the strbuf at all exits:
>
>     struct strbuf actual_hex = ...;
>     int res = 0;
>
>     if (strbuf_read_file(...) >= 0) {
>         strbuf_trim(...);
>         res = !strcmp(...);
>     }
>     strbuf_release(...);
>     return res;
>
> Alternately:
>
>     if (strbuf_read_file(...) < 0)
>         goto done;
>
>     strbuf_trim(...);
>     res = !strcmp(...);
>
> done:
>     strbuf_release(...);
>     return res;
>
> which is a bit less compact.

I will avoid this for the reason that I will have to create a label
for a lot of functions. If I choose to do this for one function, I
think it would be more appropriate to do the same for other functions.
There would be a lot of functions in future which would be in the same
scenario and creating a separate label for each of them would be quite
tedious. What do you think?

>> +static int check_expected_revs(const char **revs, int rev_nr)
>> +{
>> +       int i;
>> +
>> +       for (i = 0; i < rev_nr; i++) {
>> +               if (!is_expected_rev(revs[i])) {
>> +                       remove_path(git_path_bisect_ancestors_ok());
>> +                       remove_path(git_path_bisect_expected_rev());
>> +                       return 0;
>> +               }
>> +       }
>> +       return 0;
>> +}
>
> Hmm, all execution paths return 0, so it feels a bit pointless to have
> this function return a value at all.
>
> You could also use a 'break' inside the loop rather than 'return'
> since the return value is the same inside or outside the loop and
> nothing else happens after the loop.

Sure!
