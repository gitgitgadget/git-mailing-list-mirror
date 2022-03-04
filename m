Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AD90C433EF
	for <git@archiver.kernel.org>; Fri,  4 Mar 2022 21:29:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbiCDVaX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Mar 2022 16:30:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiCDVaW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Mar 2022 16:30:22 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F1701C1AD2
        for <git@vger.kernel.org>; Fri,  4 Mar 2022 13:29:33 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id y28-20020aa793dc000000b004e160274e3eso5746966pff.18
        for <git@vger.kernel.org>; Fri, 04 Mar 2022 13:29:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=xYTWZU26jxmV/ccIxEI/yvvA5VlozKuN5/MdKEYgd0w=;
        b=NkQUx8GE4TExM3xJo0jdPP50Qfsi4w56vef2olw0kuixSvTi2j/qBe+nUvflt8fM6s
         TR7Em5QWMFSu7BUjzs3IjA6AqAmvrexCuBf9BgpqqgkE2UYrHX+rfnSBJHlZ492WVN9T
         d2UhIh+UMeiG1OeVB5Cj4rHD4g+26nmeiyyO5FPSnONdGN9VDCBkKhTLhvWqUbuMZe2o
         2ZN04zOamRAuRFevlL9b5CB/RRSXDHDZAqtkTgn+Jm0Bg5MBHOki2FRztzk1mfe0lM+6
         D16ol7ElmoL8eaQ4GUldn8PJ8lKghzEb3XogZQsmjm8qgxinioGuD/G6595g9eNOXQ5+
         Ao3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=xYTWZU26jxmV/ccIxEI/yvvA5VlozKuN5/MdKEYgd0w=;
        b=XPiCiXW5I3Q1bOS4vz1uAR/UuolVzqKFW+RwXHNivD3fzmA9lyG7pGOfM/6tR0cwM3
         d4FoW2B7X2nzXfN1zQE0Lc+C/eEnk9I//UKc1jTUqWEsav8m/xxH/CM4KY9lKWfvOctZ
         yKe2pES7J8YKB4P5W6kXFGjG86soKaGGeYKHqij0/rIU6u1t4dd26F5pk6f8vJQm328C
         1yiFKmng+PagboPBBNx6e5Uw52B9vTZhiGZYaGnnFFMqQ4r31azBS1kSlQy5UGxqRhG7
         FqKYAkTn72WXwXPc2alD7ptjBODlcC2ofr008NpHezDzeVYydQWmR+zThgcpZN34TORG
         I4Ew==
X-Gm-Message-State: AOAM532BRrpFO29Vdu3xD0yQ5dGKY0/ffYmQKMsJzcI1XQQB2z0Fa/Tb
        rD8JFuED/JJDETGbtf+xDX07F+xieMsiWQ==
X-Google-Smtp-Source: ABdhPJxefco12LINxAOAConZXRTQCkZOtuIKQDmswdswnw3R1qBkhl/Yu7USbh1/cASOkJ56C1Yz0vpIY3W98A==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90a:1f4c:b0:1bc:fcbc:1474 with SMTP
 id y12-20020a17090a1f4c00b001bcfcbc1474mr12802526pjy.79.1646429373041; Fri,
 04 Mar 2022 13:29:33 -0800 (PST)
Date:   Fri, 04 Mar 2022 13:29:31 -0800
In-Reply-To: <xmqq4k4eafdf.fsf@gitster.g>
Message-Id: <kl6lczj14dac.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <20220301044132.39474-1-chooglen@google.com> <20220303005727.69270-1-chooglen@google.com>
 <20220303005727.69270-9-chooglen@google.com> <xmqq4k4eafdf.fsf@gitster.g>
Subject: Re: [PATCH v3 08/13] submodule--helper run-update-procedure: learn --remote
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Atharva Raykar <raykar.ath@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        Josh Steadmon <steadmon@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Glen Choo <chooglen@google.com> writes:
>
>> @@ -3033,6 +3004,25 @@ static int update_submodule2(struct update_data *update_data)
>>  		die(_("Unable to find current revision in submodule path '%s'"),
>>  			update_data->displaypath);
>>  
>> +	if (update_data->remote) {
>> +		char *remote_name = get_default_remote_submodule(update_data->sm_path);
>> +		const char *branch = remote_submodule_branch(update_data->sm_path);
>> +		char *remote_ref = xstrfmt("refs/remotes/%s/%s", remote_name, branch);
>> +
>> +		if (!update_data->nofetch) {
>> +			if (fetch_in_submodule(update_data->sm_path, update_data->depth,
>> +					      0, NULL))
>> +				die(_("Unable to fetch in submodule path '%s'"),
>> +				    update_data->sm_path);
>> +		}
>> +
>> +		if (resolve_gitlink_ref(update_data->sm_path, remote_ref, &update_data->oid))
>> +			die(_("Unable to find %s revision in submodule path '%s'"),
>> +			    remote_ref, update_data->sm_path);
>> +
>> +		free(remote_ref);
>> +	}
>
> This, and ...
>
>> @@ -409,21 +395,6 @@ cmd_update()
>>  			just_cloned=
>>  		fi
>>  
>> -		if test -n "$remote"
>> -		then
>> -			branch=$(git submodule--helper remote-branch "$sm_path")
>> -			if test -z "$nofetch"
>> -			then
>> -				# Fetch remote before determining tracking $sha1
>> -				fetch_in_submodule "$sm_path" $depth ||
>> -				die "fatal: $(eval_gettext "Unable to fetch in submodule path '\$sm_path'")"
>> -			fi
>> -			remote_name=$(sanitize_submodule_env; cd "$sm_path" && git submodule--helper print-default-remote)
>> -			sha1=$(sanitize_submodule_env; cd "$sm_path" &&
>> -				git rev-parse --verify "${remote_name}/${branch}") ||
>> -			die "fatal: $(eval_gettext "Unable to find current \${remote_name}/\${branch} revision in submodule path '\$sm_path'")"
>> -		fi
>
> ... this change would "fix" the temporary breakage [05/13] may have
> brought us.  From the series structure's point of view, doing
> [05/13] after this would be more sensible.  If we leave the call to
> "displaypath" still in the script after this series, [05/13] or its
> equivalent should mention that ensure-core-worktree does not matter
> for that particular call when it delays the call to it by moving it
> to the beginning of the update_submodule2() from the much earlier
> part of the script.
>

I should've read this in full before sending my reply on [05/13]. Makes
sense, thanks for the pointer :)

>>  		out=$(git submodule--helper run-update-procedure \
>>  			  ${wt_prefix:+--prefix "$wt_prefix"} \
>>  			  ${GIT_QUIET:+--quiet} \
>> @@ -434,6 +405,7 @@ cmd_update()
>>  			  ${update:+--update "$update"} \
>>  			  ${prefix:+--recursive-prefix "$prefix"} \
>>  			  ${sha1:+--oid "$sha1"} \
>> +			  ${remote:+--remote} \
>>  			  "--" \
>>  			  "$sm_path")
