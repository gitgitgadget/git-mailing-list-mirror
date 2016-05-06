From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 3/3] test-parse-options: --expect=<string> option to
 simplify tests
Date: Thu, 5 May 2016 17:41:03 -0700
Message-ID: <CAGZ79kY+9BUjcbpSA8sAqd=qZ5niZ2CDsPeGuXhK+yqZY4hL9Q@mail.gmail.com>
References: <xmqq7ff8b99q.fsf@gitster.mtv.corp.google.com>
	<20160505215056.28224-1-gitster@pobox.com>
	<20160505215056.28224-4-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 06 02:41:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayTpP-0007wC-E8
	for gcvg-git-2@plane.gmane.org; Fri, 06 May 2016 02:41:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757609AbcEFAlH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2016 20:41:07 -0400
Received: from mail-ig0-f179.google.com ([209.85.213.179]:37831 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757294AbcEFAlF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2016 20:41:05 -0400
Received: by mail-ig0-f179.google.com with SMTP id s8so28697435ign.0
        for <git@vger.kernel.org>; Thu, 05 May 2016 17:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=tgdRRKT8FSKHiYV397XNOmM2KC/id3FYzfkfUlv0W7A=;
        b=ogeACDa2aHDuNd4XfaVknveouDo6QNWa89njNlVExIxnM1yxJ/56SVA3jaOFDSdxt4
         LNiE6AtBh0pRkPoeYaOdLC6QEyHfuC1ov7skaONRBQJYVc8LAaiapBb6BDT+Ai0vuQip
         lRGMVMfmCCKDKVBmrsGhkoMbBeRrcbbLakQTXgaRQAfAjbjFR80Rs1GP3Z494l/yY9iR
         cIQ1MKfJhqdVoxYieCBX0bc1Tih1InHKDlUkHy2e9Z6CGCp8BeJf6GykenDSH7qf98Iv
         khPZTGXUBI9zdn8Z92HMTy97tFmoEuB9RXHfqJYvNChlAKRDyqNTx6PBlQHaZv9nIg5m
         YuUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=tgdRRKT8FSKHiYV397XNOmM2KC/id3FYzfkfUlv0W7A=;
        b=T5DTDG6VHkZjbQKpyNW6LHs/pEUk/Y8+1AzAq344615SBE2y9cslvDdW6HltAGJuMd
         qewtthDdKvvdDfOEKZF1bnP17jqKghG3q6s1Yj4ae8svU/F/wfekBK6MvMACk9j/p8Bi
         LcD5Ht5Rf0Plla0gPfEHcwvEDQVWahflFv9iw8DYNiiU+Kiu+2lwm8voZGTja9rGKOTL
         6kkPUVIu44KS/FfD6m1E1HET0VJpt3ryQDLeMv2/j9dRh8KhjhwP8JHi5W/NtuQAABJc
         sBNqykGSg+S7fQn2ErIVQ8XvVaS3Q9L8nEKx6hU9yQjBYsQwmvsPQj2rjzQS3Jt2JeAL
         S6KA==
X-Gm-Message-State: AOPr4FXGRGOWAi+Uph6PZpJ+Y0Sp1oJNpMy5I5r24hKFR9TIOuAG+7vvvYsHjd9d4Diijj63OXsareezNg+Rt95c
X-Received: by 10.50.111.15 with SMTP id ie15mr7432203igb.94.1462495263868;
 Thu, 05 May 2016 17:41:03 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Thu, 5 May 2016 17:41:03 -0700 (PDT)
In-Reply-To: <20160505215056.28224-4-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293732>

On Thu, May 5, 2016 at 2:50 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Existing tests in t0040 follow a rather verbose pattern:
>
>         cat >expect <<\EOF
>         boolean: 0
>         integer: 0
>         magnitude: 0
>         timestamp: 0
>         string: (not set)
>         abbrev: 7
>         verbose: 0
>         quiet: 3
>         dry run: no
>         file: (not set)
>         EOF
>
>         test_expect_success 'multiple quiet levels' '
>                 test-parse-options -q -q -q >output 2>output.err &&
>                 test_must_be_empty output.err &&
>                 test_cmp expect output
>         '
>
> But the only thing this test cares about is if "quiet: 3" is in the
> output.  We should be able to write the above 18 lines with just
> four lines, like this:
>
>         test_expect_success 'multiple quiet levels' '
>                 test-parse-options --expect="quiet: 3" -q -q -q
>         '
>
> Teach the new --expect=<string> option to test-parse-options helper.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  t/t0040-parse-options.sh |  1 +
>  test-parse-options.c     | 68 +++++++++++++++++++++++++++++++++++++++++++++---
>  2 files changed, 66 insertions(+), 3 deletions(-)
>
> diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
> index dbaee55..d678fbf 100755
> --- a/t/t0040-parse-options.sh
> +++ b/t/t0040-parse-options.sh
> @@ -45,6 +45,7 @@ Standard options
>      -v, --verbose         be verbose
>      -n, --dry-run         dry run
>      -q, --quiet           be quiet
> +    --expect <string>     expected output in the variable dump
>
>  EOF
>
> diff --git a/test-parse-options.c b/test-parse-options.c
> index 3db4332..010f3b2 100644
> --- a/test-parse-options.c
> +++ b/test-parse-options.c
> @@ -14,6 +14,7 @@ static char *string = NULL;
>  static char *file = NULL;
>  static int ambiguous;
>  static struct string_list list;
> +static struct string_list expect;
>
>  static struct {
>         int called;
> @@ -40,6 +41,62 @@ static int number_callback(const struct option *opt, const char *arg, int unset)
>         return 0;
>  }
>
> +/*
> + * See if expect->string ("label: value") has a line in output that
> + * begins with "label:", and if the line in output matches it.
> + */
> +static int match_line(struct string_list_item *expect, struct strbuf *output)
> +{
> +       const char *label = expect->string;
> +       const char *colon = strchr(label, ':');
> +       const char *scan = output->buf;
> +       size_t label_len, expect_len;
> +
> +       if (!colon)
> +               die("Malformed --expect value: %s", label);
> +       label_len = colon - label;
> +
> +       while (scan < output->buf + output->len) {
> +               const char *next;
> +               scan = memmem(scan, output->buf + output->len - scan,
> +                             label, label_len);
> +               if (!scan)
> +                       return 0;
> +               if (scan == output->buf || scan[-1] == '\n')

Does scan[-1] work for the first line?

> +                       break;
> +               next = strchr(scan + label_len, '\n');
> +               if (!next)
> +                       return 0;
> +               scan = next + 1;
> +       }
> +
> +       /*
> +        * scan points at a line that begins with the label we are
> +        * looking for.  Does it match?
> +        */
> +       expect_len = strlen(expect->string);
> +
> +       if (output->buf + output->len <= scan + expect_len)
> +               return 0; /* value not long enough */
> +       if (memcmp(scan, expect->string, expect_len))
> +               return 0; /* does not match */
> +
> +       return (scan + expect_len < output->buf + output->len &&
> +               scan[expect_len] == '\n');
> +}
> +
> +static int show_expected(struct string_list *list, struct strbuf *output)
> +{
> +       struct string_list_item *expect;
> +       int found_mismatch = 0;
> +
> +       for_each_string_list_item(expect, list) {
> +               if (!match_line(expect, output))
> +                       found_mismatch = 1;
> +       }
> +       return found_mismatch;
> +}
> +
>  int main(int argc, char **argv)
>  {
>         const char *prefix = "prefix/";
> @@ -87,6 +144,8 @@ int main(int argc, char **argv)
>                 OPT__VERBOSE(&verbose, "be verbose"),
>                 OPT__DRY_RUN(&dry_run, "dry run"),
>                 OPT__QUIET(&quiet, "be quiet"),
> +               OPT_STRING_LIST(0, "expect", &expect, "string",
> +                               "expected output in the variable dump"),
>                 OPT_END(),
>         };
>         int i;
> @@ -117,7 +176,10 @@ int main(int argc, char **argv)
>         for (i = 0; i < argc; i++)
>                 strbuf_addf(&output, "arg %02d: %s\n", i, argv[i]);
>
> -       printf("%s", output.buf);
> -
> -       return 0;
> +       if (expect.nr)
> +               return show_expected(&expect, &output);

On a philosophical level this patch series is adding a
trailing "|grep $X" for the test-parse-options.
I think such a grep pattern is a good thing because it is
cheap to implement in unix like environments.

This however is a lot of C code for finding specific subsets
in the output, so it is not quite cheap. Then we could also go
the non-wasteful way and instead check what to add to the strbuf
instead of filtering afterwards, i.e. each strbuf_add is guarded by
an

     if (is_interesting_output(...))
        strbuf_add(...)

> +       else {
> +               printf("%s", output.buf);
> +               return 0;
> +       }
>  }
> --
> 2.8.2-505-gdbd0e1d
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
