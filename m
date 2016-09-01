Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8710E1FBB0
	for <e@80x24.org>; Thu,  1 Sep 2016 10:31:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932849AbcIAKb2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Sep 2016 06:31:28 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35824 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932817AbcIAKbY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2016 06:31:24 -0400
Received: by mail-wm0-f65.google.com with SMTP id c133so3092966wmd.2
        for <git@vger.kernel.org>; Thu, 01 Sep 2016 03:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=jVeXyIgRxIo/Y37woQSl8tgxFqqm7hT4X26bXISRMBQ=;
        b=v5IkudsLn1FLw8XPahF8awDp212e8SYfLPlefvx4xjuZlf/YJriRFVVd7UqXB+NHGY
         wsXoN5Z9+0vj7EcdBXoPBGRUJij13ktbUC+TESf7XwP+w0gHwmpuHMiEZ61yOXxAo+/d
         L6G670br1XTJbGRzrwW5Rt/4ogXPW7Hciv6eABAHSu+i3Prf509pleyLg/FZC7Bu4T8H
         ySo61kdFBYa5bKERpDv7WADEOETBH6Jt/TPIu2WXRMctkIPSizpjv5+mujTQKitbMAdN
         eiUdRMiALVCoaFfIleQIfsjcwNCgr7bTO7eAeqplPGXTDh4JKmHVgKfbnr53yT1hagcP
         ec8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=jVeXyIgRxIo/Y37woQSl8tgxFqqm7hT4X26bXISRMBQ=;
        b=aXIvH8pKjq1yJ7QBsK+qfxLHLUiZQk/BKH/lUgazrQJQOBKq7GLZ9lx8quA7iqpD0k
         clw2pvo6F1zAvotiEK83pISuH7we7D6CqdmDNjJfCg8mZUYNCzT9avM4Cm6ZQgqXaYlp
         cz9io5DAJEr+7KstC5hP+OVUVdWojiM7x/2rRkvEpWHC/yXxaPJPvncnvSL3AitenpC8
         3JpeQeMv1TDVYgy2ZdJG9UZS5UMRrmNhHkHGm3FzskAE6Pb4bds4aV/e2uV9iysgQCnw
         jncTp+IFJuyw9fpVXSHNd9JVOSLunKMaMaDtOadkV52TpqZkN93Tz4/TvPX3ZGRw+XNd
         aB2g==
X-Gm-Message-State: AE9vXwOdXylJf25YhY5D1XsGRbr+3sFm+pern/v51wwprlPAvBVJ0vYi72c/4JmOf4cyTg==
X-Received: by 10.28.194.195 with SMTP id s186mr14882837wmf.48.1472725883029;
        Thu, 01 Sep 2016 03:31:23 -0700 (PDT)
Received: from [192.168.1.26] (enu134.neoplus.adsl.tpnet.pl. [83.20.10.134])
        by smtp.googlemail.com with ESMTPSA id s6sm4538634wjm.25.2016.09.01.03.31.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Sep 2016 03:31:22 -0700 (PDT)
Subject: Re: [PATCH 19/22] sequencer: support cleaning up commit messages
To:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
References: <cover.1472457609.git.johannes.schindelin@gmx.de>
 <eeb3d11d235a0220a9a125a21d1b09a73d2c61dc.1472457609.git.johannes.schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <9f2cbc74-3e4d-e7f1-d2dd-e85e0b9168b1@gmail.com>
Date:   Thu, 1 Sep 2016 12:31:18 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <eeb3d11d235a0220a9a125a21d1b09a73d2c61dc.1472457609.git.johannes.schindelin@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Johannes,

W dniu 29.08.2016 o 10:06, Johannes Schindelin pisze:

> The sequencer_commit() function already knows how to amend commits, and
> with this new option, it can also clean up commit messages (i.e. strip
> out commented lines). This is needed to implement rebase -i's 'fixup'
> and 'squash' commands as sequencer commands.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  sequencer.c | 10 +++++++---
>  sequencer.h |  3 ++-
>  2 files changed, 9 insertions(+), 4 deletions(-)

This looks like nice little piece of enhancement, building scaffolding
for sequencer-izing interactive rebase bit by bit.

> 
> diff --git a/sequencer.c b/sequencer.c
> index 20f7590..5ec956f 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -478,7 +478,8 @@ static char **read_author_script(void)
>   * (except, of course, while running an interactive rebase).
>   */
>  int sequencer_commit(const char *defmsg, struct replay_opts *opts,
> -			  int allow_empty, int edit, int amend)
> +			  int allow_empty, int edit, int amend,
> +			  int cleanup_commit_message)

All right, though it slowly begins coming close to the threshold
where using bitfield flags would be sensible.

>  {
>  	char **env = NULL;
>  	struct argv_array array;
> @@ -515,9 +516,12 @@ int sequencer_commit(const char *defmsg, struct replay_opts *opts,
>  		argv_array_push(&array, "-s");
>  	if (defmsg)
>  		argv_array_pushl(&array, "-F", defmsg, NULL);
> +	if (cleanup_commit_message)
> +		argv_array_push(&array, "--cleanup=strip");

Good.

>  	if (edit)
>  		argv_array_push(&array, "-e");
> -	else if (!opts->signoff && !opts->record_origin &&
> +	else if (!cleanup_commit_message &&

All right, explicit cleanup=strip overrides "commit.cleanup" config,
and turns off passing commit verbatim (incompatible with stripping)...

> +		 !opts->signoff && !opts->record_origin &&

...adding signoff and recording origin requires not passing commit
verbatim,...

>  		 git_config_get_value("commit.cleanup", &value))

..., and in other cases are check the "commit.cleanup"...

>  		argv_array_push(&array, "--cleanup=verbatim");

... and pass commit verbatim if it is not set.


Ah, well, the change you made looks good.

>  
> @@ -781,7 +785,7 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
>  	}
>  	if (!opts->no_commit)
>  		res = sequencer_commit(opts->edit ? NULL : git_path_merge_msg(),
> -			opts, allow, opts->edit, 0);
> +			opts, allow, opts->edit, 0, 0);

The calling convention begins to look unwieldy, but we have only
a single such callsite, and there are quite a bit callsites in
Git code that have similar API ("git grep ', 0, 0' -- '*.c'").
So we don't need to think about alternatives.  Yet.

It's a pity that emulation of named parameters in C requires
relying on designated inits from C99

  typedef struct {
    double pressure, moles, temp;
  } ideal_struct;

  #define ideal_pressure(...) ideal_pressure_base((ideal_struct){.pressure=1,   \
                                        .moles=1, .temp=273.15, __VA_ARGS__})

  double ideal_pressure_base(ideal_struct in)
  {
    return 8.314 * in.moles*in.temp/in.pressure;
  }

  ... ideal_pressure(.moles=2, .temp=373.15) ...

>  
>  leave:
>  	free_message(commit, &msg);
> diff --git a/sequencer.h b/sequencer.h
> index 2106c0d..e272549 100644
> --- a/sequencer.h
> +++ b/sequencer.h
> @@ -50,7 +50,8 @@ int sequencer_rollback(struct replay_opts *opts);
>  int sequencer_remove_state(struct replay_opts *opts);
>  
>  int sequencer_commit(const char *defmsg, struct replay_opts *opts,
> -			  int allow_empty, int edit, int amend);
> +			  int allow_empty, int edit, int amend,
> +			  int cleanup_commit_message);
>  
>  extern const char sign_off_header[];
>  
> 

