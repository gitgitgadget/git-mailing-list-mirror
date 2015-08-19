From: Dave Borowitz <dborowitz@google.com>
Subject: Re: [PATCH v2 7/9] builtin/send-pack.c: Use option parsing API
Date: Wed, 19 Aug 2015 15:46:25 -0400
Message-ID: <CAD0k6qSp5af+N9QvjAxw1M19ytzh_n4repFA1+5Nq6v+px+fPw@mail.gmail.com>
References: <1439998007-28719-1-git-send-email-dborowitz@google.com>
 <1439998007-28719-8-git-send-email-dborowitz@google.com> <CAGZ79kYSNAqsaj-rWvt1fSbNd+LPpeSSACcX5kHNZPe9+brLiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Aug 19 21:46:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZS9K2-0004VP-If
	for gcvg-git-2@plane.gmane.org; Wed, 19 Aug 2015 21:46:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751827AbbHSTqr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Aug 2015 15:46:47 -0400
Received: from mail-ig0-f171.google.com ([209.85.213.171]:36461 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751498AbbHSTqq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Aug 2015 15:46:46 -0400
Received: by igxp17 with SMTP id p17so113747996igx.1
        for <git@vger.kernel.org>; Wed, 19 Aug 2015 12:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=gJs7P7Kl4Rh9x+Oi/tiBqatpYUP1jFF3XmqF+oX0Azo=;
        b=hlruSGyR7f5He99SmktidnazJi7sn91x8fR/AEJS9DrwpOazywzb3P4Xq1Lz5luVXe
         N+qrI9t6VAGEmUS8G4rSP7Ve5l7VoIUjA1NcIkvJbqHatR8yEhfkP+4xovIl2WXkMFLg
         6+2XSzIIhvTpBTfE2THLR1QcDktam/m5F7DEkOFB2VV5jX4vpI0YUFeoHonv0ce3oVb5
         jGyJkgD3Iu1dkzYR2jlaQ/0OKceil1pbFUheOeULk68jrbG/37l0MIVVrCZimYn3JDrN
         bf3UVson7i/rGti2kcuiKQCdrp3BZyYbKa9CazV2M4A6C2UT9/Lyqnm+XdFruSzPNp76
         bqtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=gJs7P7Kl4Rh9x+Oi/tiBqatpYUP1jFF3XmqF+oX0Azo=;
        b=JGZvgejpKLwfCigtzZrYJgCCaWc/qxOsDXnJ5d7pSEIGofwxMtA1jdcI1S8Xh+stZa
         JwWont+tuM3ekf6EUtRLv+3xC0VAUlwV7/R3WYHpVL1hjBAoAfamjcRlsjtJ1zjhPiqL
         n5qi6sZ9aVRBTlmFMh/cg+CmUm/F51EJnaDoW1XPAWtzTUf5pc4nGnM1TnbYMkxpgKTL
         ASR9hkKcgY2J5HApl3iPV3/sDI5QTN1do6ZU8ib/W/Wv58Q6gyXrMdH8JL319WfNZTJL
         GurQFDR2l9GNhaGARjzojlvZwZDNUIpUF68wGE+vSU+wFkfK/R8acmSlislm8ci1rTzY
         vmLg==
X-Gm-Message-State: ALoCoQkRaWE19+twT9G2s26ZUN0WNOtJxBa28iVtfJ+nIWZ+xtqrMvO8tFdR8E87sid3L/jmn2dN
X-Received: by 10.50.43.197 with SMTP id y5mr28262528igl.27.1440013606069;
 Wed, 19 Aug 2015 12:46:46 -0700 (PDT)
Received: by 10.107.4.201 with HTTP; Wed, 19 Aug 2015 12:46:25 -0700 (PDT)
In-Reply-To: <CAGZ79kYSNAqsaj-rWvt1fSbNd+LPpeSSACcX5kHNZPe9+brLiw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276216>

On Wed, Aug 19, 2015 at 2:00 PM, Stefan Beller <sbeller@google.com> wrote:
> On Wed, Aug 19, 2015 at 8:26 AM, Dave Borowitz <dborowitz@google.com> wrote:
>> The old option parsing code in this plumbing command predates this
>> API, so option parsing was done more manually. Using the new API
>> brings send-pack more in line with push, and accepts new variants
>> like --no-* for negating options.
>>
>> Signed-off-by: Dave Borowitz <dborowitz@google.com>
>> ---
>>  builtin/send-pack.c | 163 +++++++++++++++++++---------------------------------
>>  1 file changed, 59 insertions(+), 104 deletions(-)
>>
>> diff --git a/builtin/send-pack.c b/builtin/send-pack.c
>> index 23b2962..5f2c744 100644
>> --- a/builtin/send-pack.c
>> +++ b/builtin/send-pack.c
>> @@ -12,10 +12,15 @@
>>  #include "version.h"
>>  #include "sha1-array.h"
>>  #include "gpg-interface.h"
>> +#include "gettext.h"
>>
>> -static const char send_pack_usage[] =
>> -"git send-pack [--all | --mirror] [--dry-run] [--force] [--receive-pack=<git-receive-pack>] [--verbose] [--thin] [--atomic] [<host>:]<directory> [<ref>...]\n"
>> -"  --all and explicit <ref> specification are mutually exclusive.";
>> +static const char * const send_pack_usage[] = {
>> +       N_("git send-pack [--all | --mirror] [--dry-run] [--force] "
>> +         "[--receive-pack=<git-receive-pack>] [--verbose] [--thin] [--atomic] "
>> +         "[<host>:]<directory> [<ref>...]\n"
>> +         "  --all and explicit <ref> specification are mutually exclusive."),
>> +       NULL,
>> +};
>>
>>  static struct send_pack_args args;
>>
>> @@ -107,116 +112,66 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
>>         int ret;
>>         int helper_status = 0;
>>         int send_all = 0;
>> +       int verbose = 0;
>>         const char *receivepack = "git-receive-pack";
>> +       unsigned dry_run = 0;
>> +       unsigned send_mirror = 0;
>> +       unsigned force_update = 0;
>> +       unsigned quiet = 0;
>> +       unsigned push_cert = 0;
>> +       unsigned use_thin_pack = 0;
>> +       unsigned atomic = 0;
>> +       unsigned stateless_rpc = 0;
>
> First I thought:
>     You could write to the args flags directly from the options. No
> need to have (most of)
>     the variables around here and copy over the values. You'd need to
> use OPT_BIT instead
>     for setting a specific bit though
> but then I realized we do not have a direct bit field in args, which
> would make it a bit unreadable.

Right, and &args->push_cert etc. is invalid, and I didn't know if it
was ok to expand the args struct to be several words longer. But I'm
not a C programmer so I'm happy to take suggestions how to make this
more idiomatic.

>>         int flags;
>>         unsigned int reject_reasons;
>>         int progress = -1;
>>         int from_stdin = 0;
>>         struct push_cas_option cas = {0};
>>
>> -       git_config(git_gpg_config, NULL);
>> +       struct option options[] = {
>> +               OPT__VERBOSITY(&verbose),
>> +               OPT_STRING(0, "receive-pack", &receivepack, "receive-pack", N_("receive pack program")),
>> +               OPT_STRING(0, "exec", &receivepack, "receive-pack", N_("receive pack program")),
>> +               OPT_STRING(0, "remote", &remote_name, "remote", N_("remote name")),
>> +               OPT_BOOL(0, "all", &send_all, N_("push all refs")),
>> +               OPT_BOOL('n' , "dry-run", &dry_run, N_("dry run")),
>> +               OPT_BOOL(0, "mirror", &send_mirror, N_("mirror all refs")),
>> +               OPT_BOOL('f', "force", &force_update, N_("force updates")),
>
> -f and -n are new here now?

Yeah, I was going for consistency with push.c (and also just copy/pasted ;)

>> +               OPT_BOOL(0, "signed", &push_cert, N_("GPG sign the push")),
>> +               OPT_BOOL(0, "progress", &progress, N_("force progress reporting")),
>> +               OPT_BOOL(0, "thin", &use_thin_pack, N_("use thin pack")),
>> +               OPT_BOOL(0, "atomic", &atomic, N_("request atomic transaction on remote side")),
>> +               OPT_BOOL(0, "stateless-rpc", &stateless_rpc, N_("use stateless RPC protocol")),
>> +               OPT_BOOL(0, "stdin", &from_stdin, N_("read refs from stdin")),
>> +               OPT_BOOL(0, "helper-status", &helper_status, N_("print status from remote helper")),
>> +               { OPTION_CALLBACK,
>> +                 0, CAS_OPT_NAME, &cas, N_("refname>:<expect"),
>> +                 N_("require old value of ref to be at this value"),
>> +                 PARSE_OPT_OPTARG, parseopt_push_cas_option },
>> +               OPT_END()
>> +       };
>>
>> -       argv++;
>> -       for (i = 1; i < argc; i++, argv++) {
>> -               const char *arg = *argv;
>> -
>> -               if (*arg == '-') {
>> -                       if (starts_with(arg, "--receive-pack=")) {
>> -                               receivepack = arg + 15;
>> -                               continue;
>> -                       }
>> -                       if (starts_with(arg, "--exec=")) {
>> -                               receivepack = arg + 7;
>> -                               continue;
>> -                       }
>> -                       if (starts_with(arg, "--remote=")) {
>> -                               remote_name = arg + 9;
>> -                               continue;
>> -                       }
>> -                       if (!strcmp(arg, "--all")) {
>> -                               send_all = 1;
>> -                               continue;
>> -                       }
>> -                       if (!strcmp(arg, "--dry-run")) {
>> -                               args.dry_run = 1;
>> -                               continue;
>> -                       }
>> -                       if (!strcmp(arg, "--mirror")) {
>> -                               args.send_mirror = 1;
>> -                               continue;
>> -                       }
>> -                       if (!strcmp(arg, "--force")) {
>> -                               args.force_update = 1;
>> -                               continue;
>> -                       }
>> -                       if (!strcmp(arg, "--quiet")) {
>> -                               args.quiet = 1;
>> -                               continue;
>> -                       }
>> -                       if (!strcmp(arg, "--verbose")) {
>> -                               args.verbose = 1;
>> -                               continue;
>> -                       }
>> -                       if (!strcmp(arg, "--signed")) {
>> -                               args.push_cert = 1;
>> -                               continue;
>> -                       }
>> -                       if (!strcmp(arg, "--progress")) {
>> -                               progress = 1;
>> -                               continue;
>> -                       }
>> -                       if (!strcmp(arg, "--no-progress")) {
>> -                               progress = 0;
>> -                               continue;
>> -                       }
>> -                       if (!strcmp(arg, "--thin")) {
>> -                               args.use_thin_pack = 1;
>> -                               continue;
>> -                       }
>> -                       if (!strcmp(arg, "--atomic")) {
>> -                               args.atomic = 1;
>> -                               continue;
>> -                       }
>> -                       if (!strcmp(arg, "--stateless-rpc")) {
>> -                               args.stateless_rpc = 1;
>> -                               continue;
>> -                       }
>> -                       if (!strcmp(arg, "--stdin")) {
>> -                               from_stdin = 1;
>> -                               continue;
>> -                       }
>> -                       if (!strcmp(arg, "--helper-status")) {
>> -                               helper_status = 1;
>> -                               continue;
>> -                       }
>> -                       if (!strcmp(arg, "--" CAS_OPT_NAME)) {
>> -                               if (parse_push_cas_option(&cas, NULL, 0) < 0)
>> -                                       exit(1);
>> -                               continue;
>> -                       }
>> -                       if (!strcmp(arg, "--no-" CAS_OPT_NAME)) {
>> -                               if (parse_push_cas_option(&cas, NULL, 1) < 0)
>> -                                       exit(1);
>> -                               continue;
>> -                       }
>> -                       if (starts_with(arg, "--" CAS_OPT_NAME "=")) {
>> -                               if (parse_push_cas_option(&cas,
>> -                                                         strchr(arg, '=') + 1, 0) < 0)
>> -                                       exit(1);
>> -                               continue;
>> -                       }
>> -                       usage(send_pack_usage);
>> -               }
>> -               if (!dest) {
>> -                       dest = arg;
>> -                       continue;
>> -               }
>> -               refspecs = (const char **) argv;
>> -               nr_refspecs = argc - i;
>> -               break;
>> +       git_config(git_gpg_config, NULL);
>> +       argc = parse_options(argc, argv, prefix, options, send_pack_usage, 0);
>> +       if (argc > 0) {
>> +               dest = argv[0];
>> +               refspecs = (const char **)(argv + 1);
>> +               nr_refspecs = argc - 1;
>>         }
>> +
>>         if (!dest)
>> -               usage(send_pack_usage);
>> +               usage_with_options(send_pack_usage, options);
>> +
>> +       args.verbose = verbose;
>> +       args.dry_run = dry_run;
>> +       args.send_mirror = send_mirror;
>> +       args.force_update = force_update;
>> +       args.quiet = quiet;
>> +       args.push_cert = push_cert;
>> +       args.progress = progress;
>> +       args.use_thin_pack = use_thin_pack;
>> +       args.atomic = atomic;
>> +       args.stateless_rpc = stateless_rpc;
>>
>>         if (from_stdin) {
>>                 struct argv_array all_refspecs = ARGV_ARRAY_INIT;
>> @@ -245,7 +200,7 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
>>          */
>>         if ((refspecs && (send_all || args.send_mirror)) ||
>>             (send_all && args.send_mirror))
>> -               usage(send_pack_usage);
>> +               usage_with_options(send_pack_usage, options);
>>
>>         if (remote_name) {
>>                 remote = remote_get(remote_name);
>> --
>> 2.5.0.276.gf5e568e
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
