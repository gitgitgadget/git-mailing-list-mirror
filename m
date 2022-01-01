Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4034BC433F5
	for <git@archiver.kernel.org>; Sat,  1 Jan 2022 11:16:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232314AbiAALQP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Jan 2022 06:16:15 -0500
Received: from mout.web.de ([212.227.15.14]:36529 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232270AbiAALQO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Jan 2022 06:16:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1641035772;
        bh=zj4N06AAbwxCGF58FVZMA799wr4QE+Jen/U3Gmcrj7w=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=QR/77CWe91RJ/xhOKyGAwgA7MQNPghxBIVHG2riTjcrtj3KNZqupp09qxQcvnqo0H
         XVdL0iJY/6G0FIOqV0/ZzUXn+4AxyNklm64oDrS3M4Ky0QUHtgOIbPn1ceCpOirFmw
         ZwvykveexpfcCX3iw14TgmeGddF9jyxuJwjcHzZ4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.22.121]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MZjEJ-1msLvv0wVD-00Wcj6; Sat, 01
 Jan 2022 12:16:12 +0100
Message-ID: <a3db4c74-1c60-5ef5-4865-e0fa9639bc5b@web.de>
Date:   Sat, 1 Jan 2022 12:16:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [PATCH 1/2] builtin/reflog.c: use parse-options for expire
 subcommand
Content-Language: en-US
To:     John Cai <johncai86@gmail.com>,
        John Cai via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
References: <pull.1175.git.git.1640932151.gitgitgadget@gmail.com>
 <9bd3c6672c4232e0a5c0905b834146ca02af8a4b.1640932151.git.gitgitgadget@gmail.com>
 <6C9B7D67-D21C-44EA-B3FB-9605968AD0FF@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <6C9B7D67-D21C-44EA-B3FB-9605968AD0FF@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nvPBb5xQ6aIkS0WsIWfu6x9Ri+0TCAT0eXKBroeHlMLUN2roWGz
 6pekR75BthawKhVMD/e1WN2U340NrQ1KcjiMa27hxVdArYkkXmDV0aKAWbZys4yJb548ic6
 4AhfnQtWqSXUmf5SwnDFUi2rjxIgY2iSkLeEYMCza1Cy7aYraAMoqqgBnVFnLQVwNs5o68X
 v667mNC/+iRQTc1QLg58w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:R39Fbmb5XVc=:TrThee4BLb0VDkjio8KLFI
 0s6UsctSXl1sD7pLNJxjMZHdCcFx5tyG6Knj2ksHdzucArGgBb7uJendwFerwK1cDac9smw65
 qyAOGZ44bVh7p+ZL9do89aKWGbMEC0QrPqRCrAFLK4bb4zPJLs31QWpRzTcedyLL8IEEBZCBa
 yFsaXrWxVS5CGKkoAD5BoynOsgP5sXZKN9OcdyTjMw9bn02MxMEJgNt5ihSezyvY3/APUvYT7
 +v5IkvwnboOQWr/ubMEKEXsGPYln/Ga7AgNht9x8bery/Yc6/o+W+kwQA5S3QB3Jxt0+WJOR1
 dP45D+E+El9ZLRytJwHypwtZarkZb74kts3ckGEotd6ofNttUcDWcj+bulDvQ4RPkLX4EMpuo
 nR20zlFD2H2LZVava6P94NFeJgx5q30Q+U1tlnKM8vmvKWLv/05dk3gc/kgtrsOzof4Ws+EYi
 odSQZ1oVuq5fMSwPH5AVBT6osBtWt8gYYwPak6FrhDT+ge2+wrexu7vUU72FoFYFpslU4tkbN
 aVnAGTXLQD2JAq/FVudmGVDoIehFkr0wDeGNTHrdIrNHjz7dJ5TQnn21uWLl7cMomtqfrG8Ui
 WLF9Nfzh+cfAkzjVmaEwuXomM4ccuKddhmp8dSsDmYCZVtb/zi1ztwYsYqD0uNBp1p2NrCrGW
 2KTsAZhJ/+7lAfVdS3oesjCH2PnoB/FJw88DuXni37iyZbjyCkerXq6szY+q7mgHz8s7Zc04o
 cOpt+Kcue7lVqJerSGH9WXMWk04kSDdvm8w/tO06whf2YdLvvh9B7WZHqCiEJJxFB4WuproVV
 n52/Xoc80h6U2gphKcaPwuNHg9wKjJ4xr+RorSoZqEAPEwPLJDPYrsPu+D+cIWuCwnyxOwKO3
 nLRfrhkVKnck2GNKsfUaN4cRGHIzSe0oC7AEO1Rsx7FrMPH6z6kY01t6S1YmXPfxoIyZdj4SS
 g2btHfE6VG0OPi8P3LxWuFCaZB7zQ0curBp8T77qsx2zASqpc+TvvvfXkhgUTFwMXP5is9U6Z
 Jk+A2LGy/NIDPFsI9k0assmWai/oZ4Yd5zMnlxFHNDkVTqTDyHtpFU4mVmqtsG+RYA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 01.01.22 um 03:06 schrieb John Cai:
>
>
>> On Dec 30, 2021, at 10:29 PM, John Cai via GitGitGadget <gitgitgadget@g=
mail.com> wrote:
>>
>> From: John Cai <johncai86@gmail.com>
>>
>> Switch out manual argv parsing for the reflog expire subcommand to use
>> the parse-options API.
>>
>> Signed-off-by: "John Cai" <johncai86@gmail.com>
>> ---
>> builtin/reflog.c | 72 ++++++++++++++++++++++++------------------------
>> 1 file changed, 36 insertions(+), 36 deletions(-)
>>
>> diff --git a/builtin/reflog.c b/builtin/reflog.c
>> index 175c83e7cc2..afaf5ba67e2 100644
>> --- a/builtin/reflog.c
>> +++ b/builtin/reflog.c
>> @@ -11,13 +11,8 @@
>> #include "revision.h"
>> #include "reachable.h"
>> #include "worktree.h"
>> +#include "parse-options.h"
>>
>> -/* NEEDSWORK: switch to using parse_options */
>> -static const char reflog_expire_usage[] =3D
>> -N_("git reflog expire [--expire=3D<time>] "
>> -   "[--expire-unreachable=3D<time>] "
>> -   "[--rewrite] [--updateref] [--stale-fix] [--dry-run | -n] "
>> -   "[--verbose] [--all] <refs>...");
>> static const char reflog_delete_usage[] =3D
>> N_("git reflog delete [--rewrite] [--updateref] "
>>    "[--dry-run | -n] [--verbose] <refs>...");
>> @@ -539,6 +534,14 @@ static void set_reflog_expiry_param(struct cmd_ref=
log_expire_cb *cb, int slot, c
>> 		cb->expire_unreachable =3D default_reflog_expire_unreachable;
>> }
>>
>> +static const char * reflog_expire_usage[] =3D {
>> +	N_("git reflog expire [--expire=3D<time>] "
>> +   "[--expire-unreachable=3D<time>] "
>> +   "[--rewrite] [--updateref] [--stale-fix] [--dry-run | -n] "
>> +   "[--verbose] [--all] <refs>..."),
>> +	NULL
>> +};
>> +
>> static int cmd_reflog_expire(int argc, const char **argv, const char *p=
refix)
>> {
>> 	struct expire_reflog_policy_cb cb;
>> @@ -547,6 +550,29 @@ static int cmd_reflog_expire(int argc, const char =
**argv, const char *prefix)
>> 	int explicit_expiry =3D 0;
>> 	unsigned int flags =3D 0;
>>
>> +	const struct option options[] =3D {
>> +		OPT_BIT(0, "dry-run", &flags, N_("do not actually prune any entries"=
),
>> +				EXPIRE_REFLOGS_DRY_RUN),
>> +		OPT_BIT(0, "rewrite", &flags,
>> +				N_("rewrite the old SHA1 with the new SHA1 of the entry that now p=
recedes it"),
>> +				EXPIRE_REFLOGS_REWRITE),
>> +		OPT_BIT(0, "updateref", &flags,
>> +				N_("update the reference to the value of the top reflog entry"),
>> +				EXPIRE_REFLOGS_UPDATE_REF),
>> +		OPT_BIT(0, "verbose", &flags, N_("print extra information on screen.=
"),
>> +				EXPIRE_REFLOGS_VERBOSE),
>> +		OPT_EXPIRY_DATE(0, "expire", &cb.cmd.expire_total,
>> +				N_("prune entries older than the specified time")),
>> +		OPT_EXPIRY_DATE(0, "expire-unreachable", &cb.cmd.expire_unreachable,
>> +			N_("prune entries older than <time> that are not reachable from the=
 current tip of the branch")),
>> +		OPT_BOOL(0, "stale-fix", &cb.cmd.stalefix,
>> +				N_("prune any reflog entries that point to broken commits")),
>> +		OPT_BOOL(0, "all", &do_all, N_("process the reflogs of all reference=
s")),
>> +		OPT_BOOL(1, "single-worktree", &all_worktrees,
>> +				N_("limits processing to reflogs from the current worktree only.")=
),
>> +		OPT_END()
>> +	};
>> +
>> 	default_reflog_expire_unreachable =3D now - 30 * 24 * 3600;
>> 	default_reflog_expire =3D now - 90 * 24 * 3600;
>> 	git_config(reflog_expire_config, NULL);
>> @@ -560,41 +586,15 @@ static int cmd_reflog_expire(int argc, const char=
 **argv, const char *prefix)
>>
>> 	for (i =3D 1; i < argc; i++) {
>
> I was hoping we could get rid of this for loop altogether, but I
> couldn=E2=80=99t figure out a clean way since --expire and
> expire-unreachable take a value __and__ set a flag bit. So I kept
> this for loop for the sole purpose of setting the explicit_expiry bit
> flag. Any suggestions?

The problem is that the default value can vary between reflogs and we
only know which ones are to be expired after option parsing, right?

The easiest way is probably to initialize the date variables to a
magic value that is unlikely to be specified explicitly.
parse_expiry_date() already uses two such magic values: 0 for "never"
and TIME_MAX for "now".  Perhaps 1 for "default"?

	cb.cmd.expire_total =3D cb.cmd.expire_unreachable =3D 1;

	argc =3D parse_options(...);

	if (cb.cmd.expire_total =3D=3D 1)
		cb.cmd.expire_total =3D default_reflog_expire;
	else
		explicit_expiry |=3D EXPIRE_TOTAL;
	if (cb.cmd.expire_unreachable =3D=3D 1)
		cb.cmd.expire_unreachable =3D default_reflog_expire_unreachable;
	else
		explicit_expiry |=3D EXPIRE_UNREACH;

A somewhat cleaner approach would be to store that bit separately:

	struct expire_date {
		unsigned is_explicitly_set:1;
		timestamp_t at;
	};

... and add a callback function that wraps parse_opt_expiry_date_cb(),
expects the new struct (instead of timestamp_t directlly) and sets
that bit.

>
>> 		const char *arg =3D argv[i];
>> -
>> -		if (!strcmp(arg, "--dry-run") || !strcmp(arg, "-n"))
>> -			flags |=3D EXPIRE_REFLOGS_DRY_RUN;
>> -		else if (skip_prefix(arg, "--expire=3D", &arg)) {
>> -			if (parse_expiry_date(arg, &cb.cmd.expire_total))
>> -				die(_("'%s' is not a valid timestamp"), arg);
>> +		if (starts_with(arg, "--expire=3D")) {
>> 			explicit_expiry |=3D EXPIRE_TOTAL;
>> -		}
>> -		else if (skip_prefix(arg, "--expire-unreachable=3D", &arg)) {
>> -			if (parse_expiry_date(arg, &cb.cmd.expire_unreachable))
>> -				die(_("'%s' is not a valid timestamp"), arg);
>> +		} else if (starts_with(arg, "--expire-unreachable=3D")) {
>> 			explicit_expiry |=3D EXPIRE_UNREACH;
>> 		}
>> -		else if (!strcmp(arg, "--stale-fix"))
>> -			cb.cmd.stalefix =3D 1;
>> -		else if (!strcmp(arg, "--rewrite"))
>> -			flags |=3D EXPIRE_REFLOGS_REWRITE;
>> -		else if (!strcmp(arg, "--updateref"))
>> -			flags |=3D EXPIRE_REFLOGS_UPDATE_REF;
>> -		else if (!strcmp(arg, "--all"))
>> -			do_all =3D 1;
>> -		else if (!strcmp(arg, "--single-worktree"))
>> -			all_worktrees =3D 0;
>> -		else if (!strcmp(arg, "--verbose"))
>> -			flags |=3D EXPIRE_REFLOGS_VERBOSE;
>> -		else if (!strcmp(arg, "--")) {
>> -			i++;
>> -			break;
>> -		}
>> -		else if (arg[0] =3D=3D '-')
>> -			usage(_(reflog_expire_usage));
>> -		else
>> -			break;
>> 	}
>>
>> +	argc =3D parse_options(argc, argv, prefix, options, reflog_expire_usa=
ge, 0);
>> +
>> 	/*
>> 	 * We can trust the commits and objects reachable from refs
>> 	 * even in older repository.  We cannot trust what's reachable
>> --
>> gitgitgadget
>>
>

