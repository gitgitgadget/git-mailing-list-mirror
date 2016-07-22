Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8DB4420195
	for <e@80x24.org>; Fri, 22 Jul 2016 14:07:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751409AbcGVOHh (ORCPT <rfc822;e@80x24.org>);
	Fri, 22 Jul 2016 10:07:37 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:35591 "EHLO
	mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751130AbcGVOHg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Jul 2016 10:07:36 -0400
Received: by mail-yw0-f196.google.com with SMTP id r9so656287ywg.2
        for <git@vger.kernel.org>; Fri, 22 Jul 2016 07:07:36 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=eT7+atoQo404nJeeRnSgfq4QrUYsku+CSkgMIcDCD8s=;
        b=rMzNXncbrda1AU4dq9wnRS38DBTWOVsMSX9Ar31LtNxLgExExbU1wSDTqRQYi/t63R
         cEWvWKhF/2X3skcm1vXzTpO3sysZdMqC7Nlao3A1vBAIXxi/sWtmkGs9BqDOgN3OoV8u
         whCTohEZIHbbvtTnMZplScZ3OZPFhroPFbucb6HH5X/re2KXf8EFfI/Vu5Zvw5Kt2T63
         3Z3U8K5ZrzbdDacG10eFJ5B8BUM7EZ3fcIRt/ERlVzne4tCWo0Qa2T/ODyd0byJLGXgH
         FXBi3mD34NNCSA28k8KZ7f/W+mk9sL4gKOXlu5FnaeytrJEfgHepntO2IV3lTHcofev2
         BE9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=eT7+atoQo404nJeeRnSgfq4QrUYsku+CSkgMIcDCD8s=;
        b=jPbOYhhtrKE0R8p7BV1CO2dD3t/hvxKwc81Mn+Tx4c/oDnPVkghJI8zTi0go3oI4Iq
         FLJGLk3N3yV+WKcoomjCpXIIZoZxc2u4Sfvk0nYQZoDOWCef/Ci6Kp3hZRbmLLNVqNr/
         yYSudX0UG0qtUUdxNhoZt0qckHepm23FdeqNsAHAwbFtzYkJercOKwq1fGftRXaa4Eb4
         ekRqnse69Q7OGsganvU+FkRXU9FMK8iWv96opD3A/AhZxAmV9pzKvduhSKX6cDZyzl96
         nSVCsihUf/6YnzQm3KqewacPwtAHZXAHXKobE/3iH6sYtUWNMnw0HoSaNakeZgJQOql8
         qgKg==
X-Gm-Message-State: AEkoouvlkst6AAt6QpUE1Bst299cquQgWAlN2wf/qfNts3IuDfSVSgiN8qpI7mttC3cBpRgbKF8PJUOhkgwTOQ==
X-Received: by 10.129.152.15 with SMTP id p15mr3201119ywg.261.1469196455493;
 Fri, 22 Jul 2016 07:07:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.129.89.132 with HTTP; Fri, 22 Jul 2016 07:07:35 -0700 (PDT)
In-Reply-To: <7a408f75-74d9-7e59-35d6-3a931414a7f9@web.de>
References: <010201560a4781be-e8418d6a-5996-45cd-b11b-ca25894ad7f2-000000@eu-west-1.amazonses.com>
 <010201560a4782ce-8d6545f1-2454-492b-a2c6-6e0f2ac824d4-000000@eu-west-1.amazonses.com>
 <7a408f75-74d9-7e59-35d6-3a931414a7f9@web.de>
From:	Pranit Bauva <pranit.bauva@gmail.com>
Date:	Fri, 22 Jul 2016 19:37:35 +0530
Message-ID: <CAFZEwPOH+V+Nfq1KoOBBdVgeFD7YCG5c1PJrUHB50O1DkMg39Q@mail.gmail.com>
Subject: Re: [PATCH v10 12/12] bisect--helper: `get_terms` & `bisect_terms`
 shell function in C
To:	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Cc:	Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hey Torsten,

On Fri, Jul 22, 2016 at 7:59 AM, Torsten Bögershausen <tboegi@web.de> wrote:
>
>
> On 07/20/2016 11:47 PM, Pranit Bauva wrote:
>>
>> Reimplement the `get_terms` and `bisect_terms` shell function in C and
>> add `bisect-terms` subcommand to `git bisect--helper` to call it from
>> git-bisect.sh .
>>
>> In the shell version, the terms were identified by strings but in C
>> version its done by bit manipulation and passing the integer value to
>> the function.
>>
>> Using `--bisect-terms` subcommand is a temporary measure to port shell
>> function in C so as to use the existing test suite. As more functions
>> are ported, this subcommand will be retired and will be called by some
>> other methods.
>>
>> Mentored-by: Lars Schneider <larsxschneider@gmail.com>
>> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
>> Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
>> ---
>>  builtin/bisect--helper.c | 74
>> +++++++++++++++++++++++++++++++++++++++++++++++-
>>  git-bisect.sh            | 35 ++---------------------
>>  2 files changed, 75 insertions(+), 34 deletions(-)
>>
>> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
>> index 001096a..185a8ad 100644
>> --- a/builtin/bisect--helper.c
>> +++ b/builtin/bisect--helper.c
>> @@ -8,6 +8,13 @@
>>  #include "run-command.h"
>>  #include "prompt.h"
>>
>> +enum terms_defined {
>> +       TERM_BAD = 1,
>> +       TERM_GOOD = 2,
>> +       TERM_NEW = 4,
>> +       TERM_OLD = 8
>> +};
>> +
>
> What does TERM stand for  ?
> It could be TERMinal, TERMinator or just TERM.
> Something like BIS_TERM_DEF_BAD .. may be more intuitive,
> and may avoid name clashes in the long run.
>
> And why are the defines 1,2,4,8 ?
> It looks as if a #define bitmap may be a better choice here ?
> How do we do these kind of bit-wise opions otherwise ?

I am not sure as why bitmaps would be a better choice except for git's
source code. I saw the source code (especially config.c) and it uses
"#defines" bitmap style. I haven't been able to find this method
before. Also it uses "(1<<2)" instead of "4".

>>  static GIT_PATH_FUNC(git_path_bisect_terms, "BISECT_TERMS")
>>  static GIT_PATH_FUNC(git_path_bisect_expected_rev, "BISECT_EXPECTED_REV")
>>  static GIT_PATH_FUNC(git_path_bisect_ancestors_ok, "BISECT_ANCESTORS_OK")
>> @@ -26,6 +33,7 @@ static const char * const git_bisect_helper_usage[] = {
>>         N_("git bisect--helper --bisect-write <state> <revision>
>> <TERM_GOOD> <TERM_BAD> [<nolog>]"),
>>         N_("git bisect--helper --bisect-check-and-set-terms <command>
>> <TERM_GOOD> <TERM_BAD>"),
>>         N_("git bisect--helper --bisect-next-check [<term>] <TERM_GOOD>
>> <TERM_BAD"),
>> +       N_("git bisect--helper --bisect-terms [--term-good | --term-old |
>> --term-bad | --term-new]"),
>>         NULL
>>  };
>>
>> @@ -359,6 +367,43 @@ static int bisect_next_check(const struct
>> bisect_terms *terms,
>>         return 0;
>>  }
>>
>> +static int get_terms(struct bisect_terms *terms)
>> +{
>> +       FILE *fp;
>> +       int res;
>> +       fp = fopen(git_path_bisect_terms(), "r");
>> +       if (!fp)
>> +               return -1;
>> +
>> +       bisect_terms_reset(terms);
>> +       res = strbuf_getline(&terms->term_bad, fp) == EOF ||
>> +             strbuf_getline(&terms->term_good, fp) == EOF;
>> +
>> +       fclose(fp);
>> +       return res ? -1 : 0;
>> +}
>> +
>> +static int bisect_terms(struct bisect_terms *terms, int term_defined)
>> +{
>> +       if (get_terms(terms)) {
>> +               fprintf(stderr, "no terms defined\n");
>> +               return -1;
>> +       }
>> +       if (!term_defined) {
>> +               printf("Your current terms are %s for the old state\nand "
>> +                      "%s for the new state.\n", terms->term_good.buf,
>> +                      terms->term_bad.buf);
>> +               return 0;
>> +       }
>> +
>> +       if (term_defined == TERM_GOOD || term_defined == TERM_OLD)
>> +               printf("%s\n", terms->term_good.buf);
>> +       if (term_defined == TERM_BAD || term_defined == TERM_NEW)
>> +               printf("%s\n", terms->term_bad.buf);
>
> May be a switch-case ?
> Or at least "else if" ?

Yes. I will use a "else if". Thanks!

>> +
>> +       return 0;
>> +}
>> +
>>  int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
>>  {
>>         enum {
>> @@ -369,9 +414,11 @@ int cmd_bisect__helper(int argc, const char **argv,
>> const char *prefix)
>>                 CHECK_EXPECTED_REVS,
>>                 BISECT_WRITE,
>>                 CHECK_AND_SET_TERMS,
>> -               BISECT_NEXT_CHECK
>> +               BISECT_NEXT_CHECK,
>> +               BISECT_TERMS
>>         } cmdmode = 0;
>>         int no_checkout = 0, res = 0;
>> +       enum terms_defined term_defined = 0;
>>         struct option options[] = {
>>                 OPT_CMDMODE(0, "next-all", &cmdmode,
>>                          N_("perform 'git bisect next'"), NEXT_ALL),
>> @@ -389,6 +436,16 @@ int cmd_bisect__helper(int argc, const char **argv,
>> const char *prefix)
>>                          N_("check and set terms in a bisection state"),
>> CHECK_AND_SET_TERMS),
>>                 OPT_CMDMODE(0, "bisect-next-check", &cmdmode,
>>                          N_("check whether bad or good terms exist"),
>> BISECT_NEXT_CHECK),
>> +               OPT_CMDMODE(0, "bisect-terms", &cmdmode,
>> +                        N_("print out the bisect terms"), BISECT_TERMS),
>> +               OPT_BIT(0, "term-bad", &term_defined,
>> +                        N_("show the bad term"), TERM_BAD),
>> +               OPT_BIT(0, "term-good", &term_defined,
>> +                        N_("show the good term"), TERM_GOOD),
>> +               OPT_BIT(0, "term-new", &term_defined,
>> +                        N_("show the new term"), TERM_NEW),
>> +               OPT_BIT(0, "term-old", &term_defined,
>> +                        N_("show the old term"), TERM_OLD),
>>                 OPT_BOOL(0, "no-checkout", &no_checkout,
>>                          N_("update BISECT_HEAD instead of checking out
>> the current commit")),
>>                 OPT_END()
>> @@ -399,6 +456,16 @@ int cmd_bisect__helper(int argc, const char **argv,
>> const char *prefix)
>>         argc = parse_options(argc, argv, prefix, options,
>>                              git_bisect_helper_usage, 0);
>>
>> +       if (cmdmode != BISECT_TERMS && term_defined)
>> +               die(_("--term-bad, --term-good, --term-new and --term-old
>> "
>> +                     "can be used only with --bisect-terms"));
>> +
>> +       if (term_defined != 0 && term_defined != TERM_BAD &&
>> +           term_defined != TERM_GOOD && term_defined != TERM_NEW &&
>> +           term_defined != TERM_OLD)
>> +               die(_("only one option among --term-bad, --term-good, "
>> +                     "--term-new and --term-old can be used."));
>> +
>
> []

However I suspect handling "--term-good/--term-bad" is creating
problems in bisect_start(). I am finding a way around. If not then I
will have to get back to using "OPT_ARGUMENT" and handling it in the
individual function.

Regards,
Pranit Bauva
