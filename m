Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ACA7E20D0A
	for <e@80x24.org>; Thu,  1 Jun 2017 21:37:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751135AbdFAVhA (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Jun 2017 17:37:00 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:35116 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751050AbdFAVg7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2017 17:36:59 -0400
Received: by mail-io0-f195.google.com with SMTP id o12so6609398iod.2
        for <git@vger.kernel.org>; Thu, 01 Jun 2017 14:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=v5F7J99SNb/zWlIij5gJClhqm6xA7nrukMgIsaZXWXw=;
        b=tXOzjoNxTWV7zgGH2neiTCwneN/mL/s3bSsrA42O2VGxQHujaHSpIuRU3EQ64kAa3S
         yq69thSlqV9mT3PqzoYBnAgBgvzHkBE7K9BYbNMZLk5pqRTdzWmTAFEVprBQ8/NkJ79U
         hUV5OW/5gZAv9xNqt0O8gqvDtRzJeM3IiJ0w/riJ6wfZ10fz8csRea33tUd8lbJ0RPqh
         e2+qDJTp0LRBMonSuFxgLcO57G+aerlThx1jL97Ez1D9KudkPwF+5snOO2ChmHEr03Tr
         /gNLlMEMBjkaNXYbd61ei25jogpyGGbTQ6rOM5ssGZkqN8yBMzaww48dpRRskptzwJf4
         y/Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=v5F7J99SNb/zWlIij5gJClhqm6xA7nrukMgIsaZXWXw=;
        b=BSjFeT9wZ8jGhXE2/zBohbvjBF3fjSEgW2usWD2Ea7pg7+YKahHB6nwovKPyiA8OEb
         a5JGNa0OzDYosHjM5KLpv2g1CKe36RPYoCi64hkQksaRME+TNIb3arRrCyFizIqGToA+
         AyY0ryOJub/0Gj+c2C6uiA7TCkLWYeEQkLi8KS+nMFRltFMnkdSd9BbNuaMuJGe5HIoH
         bQ5KQAkDM3qX/LLCw+QUT36V8TFH4tauyblq3+iGlNuQ1x4Mj5Ut6C8PI8mC0tDO1NsD
         GNzkTumQs5EYw1sYMco5+VWB6oL6diOL2yxiig9Lr2Zwilcmh1qRxkEgz68i5c53o9Z8
         QD9A==
X-Gm-Message-State: AODbwcBF06t9GxPRdPPcrfd6HRZLXQAAe16/qHbvFvnGQUerqFol4OaJ
        gwB6k8FRUiOwxEgn/UmIsTY9gLuf7w==
X-Received: by 10.107.138.21 with SMTP id m21mr4589452iod.80.1496353018425;
 Thu, 01 Jun 2017 14:36:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Thu, 1 Jun 2017 14:36:37 -0700 (PDT)
In-Reply-To: <CAGZ79kb6O7hraY4caY8tdFn1d0Fi+LRr9cHk2UuXf79LbnPdhw@mail.gmail.com>
References: <20170601182056.31142-1-avarab@gmail.com> <20170601182056.31142-3-avarab@gmail.com>
 <CAGZ79kb6O7hraY4caY8tdFn1d0Fi+LRr9cHk2UuXf79LbnPdhw@mail.gmail.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Thu, 1 Jun 2017 23:36:37 +0200
Message-ID: <CACBZZX7hffa3iGndzyJMKYAwDqjjYO6XacWLrHnSo29xYSKAsQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/8] grep: skip pthreads overhead when using one thread
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Jeffrey Walton <noloader@gmail.com>,
        =?UTF-8?Q?Micha=C5=82_Kiedrowicz?= <michal.kiedrowicz@gmail.com>,
        J Smith <dark.panda@gmail.com>,
        Victor Leschuk <vleschuk@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Fredrik Kuivinen <frekui@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 1, 2017 at 11:20 PM, Stefan Beller <sbeller@google.com> wrote:
> On Thu, Jun 1, 2017 at 11:20 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>
>> +       if (num_threads =3D=3D 1)
>> +               num_threads =3D 0;
>
> I would think that it is easier to maintain the code when keep the 1
> hard coded, and apply the following diff instead. If we encounter
> a 0 later on, it is not clear what the original user input was.
> (Did the user ask for 0 as a proxy for GREP_NUM_THREADS_DEFAULT ?
> do they care about the number of threads?)
> It is less complexity in the decision logic here.
>
> --8<-- (white space broken)
> diff --git a/builtin/grep.c b/builtin/grep.c
> index c6c26e9b9e..6ad9b3da20 100644
> --- a/builtin/grep.c
> +++ b/builtin/grep.c
> @@ -1231,7 +1231,7 @@ int cmd_grep(int argc, const char **argv, const
> char *prefix)
>  #endif
>
>  #ifndef NO_PTHREADS
> -       if (num_threads) {
> +       if (num_threads > 1) {
>                 if (!(opt.name_only || opt.unmatch_name_only || opt.count=
)
>                     && (opt.pre_context || opt.post_context ||
>                         opt.file_break || opt.funcbody))
> @@ -1295,7 +1295,7 @@ int cmd_grep(int argc, const char **argv, const
> char *prefix)
>                 hit =3D grep_objects(&opt, &pathspec, &list);
>         }
>
> -       if (num_threads)
> +       if (num_threads > 1)
>                 hit |=3D wait_all();
>         if (hit && show_in_pager)
>                 run_pager(&opt, prefix);
> --8<--

If I've understood you correctly (what I applied on top of this based
on the above at the end of the mail) this segfaults because now we
won't compile the pattern.

I agree that this logic is a bit tricky, but it must be considered
with the "!num_threads" logic in preceding "grep: don't redundantly
compile throwaway patterns under threading" patch.

I.e. we already have num_threads being assigned to 0 under
NO_PTHREADS, doing the same for the PTHREADS codepath seemed like the
simplest solution to me.

diff --git a/builtin/grep.c b/builtin/grep.c
index a0a3922f92..6d16df2526 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -1238,25 +1238,23 @@ int cmd_grep(int argc, const char **argv,
const char *prefix)
                num_threads =3D GREP_NUM_THREADS_DEFAULT;
        else if (num_threads < 0)
                die(_("invalid number of threads specified (%d)"), num_thre=
ads);
-       if (num_threads =3D=3D 1)
-               num_threads =3D 0;
 #else
        if (num_threads)
                warning(_("no threads support, ignoring --threads"));
-       num_threads =3D 0;
+       num_threads =3D 0; /* If we have no threads... */
 #endif

-       if (!num_threads)
+       if (num_threads) /* Or if we've decided not to use them... */
                /*
                 * The compiled patterns on the main path are only
                 * used when not using threading. Otherwise
                 * start_threads() below calls compile_grep_patterns()
                 * for each thread.
                 */
-               compile_grep_patterns(&opt);
+               compile_grep_patterns(&opt); /* We'll compile the
pattern here */
 #ifndef NO_PTHREADS
-       if (num_threads) {
+       if (num_threads > 1) {
                if (!(opt.name_only || opt.unmatch_name_only || opt.count)
                    && (opt.pre_context || opt.post_context ||
                        opt.file_break || opt.funcbody))
@@ -1320,7 +1318,7 @@ int cmd_grep(int argc, const char **argv, const
char *prefix)
                hit =3D grep_objects(&opt, &pathspec, &list);
        }

-       if (num_threads)
+       if (num_threads > 1)
                hit |=3D wait_all();
        if (hit && show_in_pager)
                run_pager(&opt, prefix);
