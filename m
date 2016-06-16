Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.7 required=5.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97B8C1FE4D
	for <e@80x24.org>; Thu, 16 Jun 2016 19:01:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754038AbcFPTBJ (ORCPT <rfc822;e@80x24.org>);
	Thu, 16 Jun 2016 15:01:09 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:33493 "EHLO
	mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754022AbcFPTBH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jun 2016 15:01:07 -0400
Received: by mail-yw0-f193.google.com with SMTP id d137so521006ywe.0
        for <git@vger.kernel.org>; Thu, 16 Jun 2016 12:01:07 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=GEsMlOA4ZBdoThDpQ9SZZ6sliUPXLQ6WQaOn1G12COY=;
        b=m8tU+9MprakW7Yw0pXhwN9t7oCtyR9UNvQxcjXRaz2w4E97CT+KhOW/PVZLf+f1CLH
         5tU1Ec9O9Shu0Mk0wmWMtaKIiBe46aq41JO2UuS9CP4D0LH0ThRXEEcjn+by601YYgJ9
         TT5NRGUg+awKR6XSrBNgRL1gIfIM+T93ozDNHnkG7JzM2liXDpgiC7QkPdtHZwDOROrX
         vjGRh/LxxOaki7K7fLzcxpn0ApM89D5VeKadnkbb5O6ZKgHFQGS9IF5b2VhmZtCYSpAU
         mT9p847+pUXjn9885Gf3lvvbKDUWlHagLcG8ouK5l3Stq58xiKGFytmatb+MUSpaBuld
         uovg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=GEsMlOA4ZBdoThDpQ9SZZ6sliUPXLQ6WQaOn1G12COY=;
        b=WDDYN7w4ROgFojUO8sopCy2p+kQIFvXJevIQCcTqEo9RRnZE/f3rl4Wt9OnqpB50je
         slCBmTyTqtgFPlVDKcM3bv2lgGnjt1A7LjIXv1KfGcm4Jlxgn2muHJBaDlxl42+Oy3l2
         x05xuslOmc7Q7pVa18AEj+Ic/Vb90ZUQm/RMK7xGe8DVqXUuyKAHjo0uyp5Gugr9/dpS
         qofcdpSsNv++Uf1N+o0x6y9A7zZRi+9hLy7yDbQKWJlO1szPYjGyqHJBec9yFtNFxYel
         3+q28lEDTJMlvordYLxy50py4rssH5uQokjN11EwhrIsCctQG1dH0Xqg9d9gOmEPhLdz
         nbvg==
X-Gm-Message-State: ALyK8tLF59DfLOPcdIMOIqx+MKjjKmXLqKwj8MZlP47lmnEPnY/ItqYMPjbP0WnEVcdvhOQvTUh+Lq7V16agfw==
X-Received: by 10.129.50.83 with SMTP id y80mr3536330ywy.305.1466103666701;
 Thu, 16 Jun 2016 12:01:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.129.116.193 with HTTP; Thu, 16 Jun 2016 12:01:06 -0700 (PDT)
In-Reply-To: <CAPig+cQV3FTGJBvS0Kuc3CNPiwZMZtApT6r8+Ojhw3y7O2VTiw@mail.gmail.com>
References: <20160607205454.22576-1-pranit.bauva@gmail.com>
 <20160615140026.10519-1-pranit.bauva@gmail.com> <20160615140026.10519-7-pranit.bauva@gmail.com>
 <CAPig+cQV3FTGJBvS0Kuc3CNPiwZMZtApT6r8+Ojhw3y7O2VTiw@mail.gmail.com>
From:	Pranit Bauva <pranit.bauva@gmail.com>
Date:	Fri, 17 Jun 2016 00:31:06 +0530
Message-ID: <CAFZEwPNpeD3+6kzY7HDH_ZXcL-Nu0B7jGeM5GMjH7PT0eSTLBw@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] bisect--helper: `bisect_write` shell function in C
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

On Fri, Jun 17, 2016 at 12:25 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Wed, Jun 15, 2016 at 10:00 AM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
>> Reimplement the `bisect_write` shell function in C and add a
>> `bisect-write` subcommand to `git bisect--helper` to call it from
>> git-bisect.sh
>>
>> Using `--bisect-write` subcommand is a temporary measure to port shell
>> function in C so as to use the existing test suite. As more functions
>> are ported, this subcommand will be retired and will be called by some
>> other methods.
>>
>> Note: bisect_write() uses two variables namely TERM_GOOD and TERM_BAD
>> from the global shell script thus we need to pass it to the subcommand
>> using the arguments. After the whole conversion, we can remove the extra
>> arguments and make the method use the two variables from the global scope
>> within the C code.
>
> You could do this now rather than waiting for later. Instead of
> passing these arguments to bisect_write(), create global variables in
> this patch and assign them in the BISECT_WRITE case of
> cmd_bisect__helper() before calling bisect_write().
>
> Not necessarily worth a re-roll, but would save you the effort of
> having to explain it here and then change it in some later patch.

I have actually done it in my next conversion which is converting
check_and_set_terms()[1] which also sets those variables to some value
so its more appropriate there.

>> Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
>> ---
>> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
>> @@ -192,6 +193,55 @@ static int check_expected_revs(const char **revs, int rev_nr)
>> +static int bisect_write(const char *state, const char *rev,
>> +                       const char *term_good, const char *term_bad,
>> +                       int nolog)
>> +{
>> +       struct strbuf tag = STRBUF_INIT;
>> +       struct strbuf commit_name = STRBUF_INIT;
>> +       struct object_id oid;
>> +       struct commit *commit;
>> +       struct pretty_print_context pp = {0};
>> +       FILE *fp;
>> +
>> +       if (!strcmp(state, term_bad))
>> +               strbuf_addf(&tag, "refs/bisect/%s", state);
>> +       else if(one_of(state, term_good, "skip", NULL))
>> +               strbuf_addf(&tag, "refs/bisect/%s-%s", state, rev);
>> +       else
>> +               return error(_("Bad bisect_write argument: %s"), state);
>> +
>> +       if (get_oid(rev, &oid)) {
>> +               strbuf_release(&tag);
>> +               return error(_("couldn't get the oid of the rev '%s'"), rev);
>> +       }
>
> Minor: If you move the get_oid() conditional before the one above it,
> then you won't have to worry about releasing 'strbuf tag' at this
> point.

Nice. I will do that. :)

>> +       if (update_ref(NULL, tag.buf, oid.hash, NULL, 0,
>> +                      UPDATE_REFS_MSG_ON_ERR)) {
>> +               strbuf_release(&tag);
>> +               return -1;
>> +       }
>
> If you release 'strbuf tag' right here, after it's final use, then you
> won't have to worry about releasing it anywhere below (particularly in
> the error cases).

True.

>> +       fp = fopen(git_path_bisect_log(), "a");
>> +       if (!fp) {
>> +               strbuf_release(&tag);
>> +               return error_errno(_("couldn't open the file '%s'"), git_path_bisect_log());
>> +       }
>> +
>> +       commit = lookup_commit_reference(oid.hash);
>> +       format_commit_message(commit, "%s", &commit_name, &pp);
>> +       fprintf(fp, "# %s: [%s] %s\n", state, sha1_to_hex(oid.hash),
>> +               commit_name.buf);
>> +
>> +       if (!nolog)
>> +               fprintf(fp, "git bisect %s %s\n", state, rev);
>> +
>> +       strbuf_release(&commit_name);
>> +       strbuf_release(&tag);
>> +       fclose(fp);
>> +       return 0;
>> +}
>> @@ -241,6 +295,11 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
>> +       case BISECT_WRITE:
>> +               if (argc != 4 && argc != 5)
>> +                       die(_("--bisect-write requires either 4 or 5 arguments"));
>> +               nolog = (argc == 5) && !strcmp(argv[4], "nolog");
>
> This is minor and won't matter in the long run when this code goes
> away later in the C conversion, but this differs from the shell code
> which only cared that a (non-empty) fifth argument was provided but
> didn't care about the actual value, whereas this code expects the
> argument to be exactly "nolog".

We currently have tight control over the arguments we are passing as
they are only programmer defined.

>> +               return bisect_write(argv[0], argv[1], argv[2], argv[3], nolog);
>>         default:
>>                 die("BUG: unknown subcommand '%d'", cmdmode);
>>         }

[1]: https://github.com/pranitbauva1997/git/pull/16

Regards,
Pranit Bauva
