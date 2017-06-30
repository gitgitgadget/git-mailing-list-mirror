Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 08A89201A0
	for <e@80x24.org>; Fri, 30 Jun 2017 22:49:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753172AbdF3Wt0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Jun 2017 18:49:26 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35674 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752019AbdF3WtZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jun 2017 18:49:25 -0400
Received: by mail-pg0-f65.google.com with SMTP id f127so16628339pgc.2
        for <git@vger.kernel.org>; Fri, 30 Jun 2017 15:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=S+QCSDGNHmFHI23RE1iC0L5sZrrqB2jXw9En3bWC3MM=;
        b=lSNCHPOi1WtR3P3U7wLZPsAbkTbAZsc2YE8eKwR7yJQVxeVsCVg//xeCQuOdoeCH9v
         PdTkLiyjRc6L3IJtBf6clpHajBBaE+guw60QAOLjq2PCaSMfItFDEjXL7OwYSICvRC2J
         9f6G7WJX3kyP93PXz4R7Fxj9lsAgN1pTLKF0Cngnrq0b1rlDO1JByy/oBkle253bCb46
         uSAEVCKlpL11T11fm0/byutCDGZ2u4w4522WgA9PS3YVhaa6ExgpaeOZGzkNU3EDwDmK
         Rljd9/SesvV7GuKW7oqjo5epaikUxifjqH9QnzcUOYGBZcZT/0Y8qJp83rQSb+sKJaPh
         kc4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=S+QCSDGNHmFHI23RE1iC0L5sZrrqB2jXw9En3bWC3MM=;
        b=kvnHsRURE3qJQLsNMxAbZIMt6MiR5z1k+Uu97YYxqddmCYEfacgT1ImNuOgnWPYckk
         5JrEsgKAsqwhxImUbbY8uDQFLaevhp7V08DtGlZImxOs0MzeO6O7pf3cc1Mmg2cZ5JnL
         K4TkoHhQKmKvLj+hlxwbsw/BJeAPnxnP07bE1kleYWK4LSKO6NSTE61kdRLJBw7gAuyD
         mGqqIDGuZjN4nV2OcahlVVJHbD6bNSUo2cLn9ktc9N7HUr7UZd2V258oXrm3ax+G28O7
         iRtFAB4uY5sO2PKfXlMi7IBCCbqEDt4RVoBvs9C4asjK/SweUM16tCpdaGRFgJ6Aebus
         3Jgg==
X-Gm-Message-State: AKS2vOw9LVkhfSv7YHgQjFgf5Sr5Whd67p9F3h9oBzC9C5ZoNh0HHuBw
        HT9CD7Dxrr1OBg==
X-Received: by 10.84.129.14 with SMTP id 14mr27327195plb.106.1498862964719;
        Fri, 30 Jun 2017 15:49:24 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:54f:b41d:dd9d:3de0])
        by smtp.gmail.com with ESMTPSA id c63sm22699094pfk.79.2017.06.30.15.49.23
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 30 Jun 2017 15:49:24 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Prathamesh Chavan <pc44800@gmail.com>
Cc:     git@vger.kernel.org, sbeller@google.com, christian.couder@gmail.com
Subject: Re: [GSoC][PATCH 3/5 v3] submodule: port set_name_rev() from shell to C
References: <CAME+mvUrr8EA-6jbCZdpB7dMZ5CN3RyY7yoRoUBoiZw=sH6Ysw@mail.gmail.com>
        <20170630194727.29787-1-pc44800@gmail.com>
        <20170630194727.29787-3-pc44800@gmail.com>
Date:   Fri, 30 Jun 2017 15:49:23 -0700
In-Reply-To: <20170630194727.29787-3-pc44800@gmail.com> (Prathamesh Chavan's
        message of "Sat, 1 Jul 2017 01:17:25 +0530")
Message-ID: <xmqqbmp5ozv0.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Prathamesh Chavan <pc44800@gmail.com> writes:

> Function set_name_rev() is ported from git-submodule to the
> submodule--helper builtin. The function get_name_rev() generates the
> value of the revision name as required, and the function
> print_name_rev() handles the formating and printing of the obtained
> revision name.
>
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Stefan Beller <sbeller@google.com>
> Signed-off-by: Prathamesh Chavan <pc44800@gmail.com>
> ---
>  builtin/submodule--helper.c | 69 +++++++++++++++++++++++++++++++++++++++++++++
>  git-submodule.sh            | 16 ++---------
>  2 files changed, 71 insertions(+), 14 deletions(-)
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index c4286aac5..4103e40e4 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -244,6 +244,74 @@ static char *get_submodule_displaypath(const char *path, const char *prefix)
>  	}
>  }
>  
> +enum describe_step {
> +	step_bare,
> +	step_tags,
> +	step_contains,
> +	step_all_always,
> +	step_end
> +};

Hmph.

The only difference between the steps being what subcommand is run,
a better implementation might be to do

	static const char *describe_bare[] = {
		NULL
	};

	...

	static const char **describe_argv[] = {
		describe_bare, describe_tags, describe_contains, 
                describe_all_always, NULL
	};

	const char ***d;

	for (d = describe_argv; *d; d++) {
		argv_array_pushl(&cp.args, "describe");
		argv_array_pushv(&cp.args, *d);
		... do the thing ...
	}

but unfortunately C is a bit klunky to do so; we cannot easily make
the contents of describe_argv[] as anonymous arrays.  An otherwise
useless enum stil bothers me, but I do not think of anything better
offhand.

> +
> +static char *get_name_rev(const char *sub_path, const char* object_id)
> +{
> +	struct strbuf sb = STRBUF_INIT;
> +	enum describe_step cur_step;
> +
> +	for (cur_step = step_bare; cur_step < step_end; cur_step++) {
> +		struct child_process cp = CHILD_PROCESS_INIT;
> +		prepare_submodule_repo_env(&cp.env_array);
> +		cp.dir = sub_path;
> +		cp.git_cmd = 1;
> +		cp.no_stderr = 1;
> +
> +		switch (cur_step) {
> +			case step_bare:
> +				argv_array_pushl(&cp.args, "describe",
> +						 object_id, NULL);
> +				break;
> +			case step_tags:	
> +				argv_array_pushl(&cp.args, "describe",
> +						 "--tags", object_id, NULL);
> +				break;
> +			case step_contains:
> +				argv_array_pushl(&cp.args, "describe",
> +						 "--contains", object_id,
> +						 NULL);
> +				break;
> +			case step_all_always:
> +				argv_array_pushl(&cp.args, "describe",
> +						 "--all", "--always",
> +						 object_id, NULL);
> +				break;
> +			default:
> +				BUG("unknown describe step '%d'", cur_step);
> +		}

Dedent the body of switch() by one level, i.e.

	switch (var) {
	case val1:
		do_this();
		break;
	case val2:
		do_that();
		...
	}

Otherwise looking good.

> @@ -1042,14 +1030,14 @@ cmd_status()
>  		fi
>  		if git diff-files --ignore-submodules=dirty --quiet -- "$sm_path"
>  		then
> -			set_name_rev "$sm_path" "$sha1"
> +			revname=$(git submodule--helper print-name-rev "$sm_path" "$sha1")
>  			say " $sha1 $displaypath$revname"
>  		else
>  			if test -z "$cached"
>  			then
>  				sha1=$(sanitize_submodule_env; cd "$sm_path" && git rev-parse --verify HEAD)
>  			fi
> -			set_name_rev "$sm_path" "$sha1"
> +			revname=$(git submodule--helper print-name-rev "$sm_path" "$sha1")
>  			say "+$sha1 $displaypath$revname"
>  		fi
