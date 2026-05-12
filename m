Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E14346AC4
	for <git@vger.kernel.org>; Tue, 12 May 2026 14:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778597561; cv=none; b=K+oglGHlbeO8K9txiM4rB59JZ4mrlq+yEe+hXw+kkFcxyhe1nBAZa2fT8izgiskdoR/gV74rod38axFDKzd4D3WXVn3Wm1egtPszTJAC7fRvtez4FSWroJKteYsgjEjR0Ys29vDxNApKoIFDcArT5s6sNJsEgTUIcPgYXYvCrjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778597561; c=relaxed/simple;
	bh=tYqfjTWcg//Ejwu89PsYIEmqzaNz2mu4vCWGFgX8UVU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tZ+Rk3wKc+u+V1jeWccgF+yzAH4ldep7n1Jc8cykzaxmN0JZeuCpaY9xuLKuUaejl+0NMY4TwkX+ETNjx8a30p9nGv4zLhpNa8uHQYDTX/P9adoGYm9Acb5+zF4gqWOFfXzZaX7vwsWHxm+z3tQDECyvK9QmIgGRKmA1oIUUVCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kYd/I3pr; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kYd/I3pr"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-90d13fa59e8so83082485a.2
        for <git@vger.kernel.org>; Tue, 12 May 2026 07:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778597559; x=1779202359; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U4F0o6tRjR07gQpJT+QCYd1MmidxJ6x8UzqyphqwqXc=;
        b=kYd/I3prSMYj+48aHwGbnQMAAkc8ZNAEN/uWyycFGfGSGOrclsCxmOQvb73cj2qCE0
         An9UzszeIKRef6eUKM3geRIjbyqOad4WZdQtzYgqEqIXlcCUgjGpX8NJtbqqzh44Ls7+
         vB/lCXJsp9KnOHk1wZHb1cl3W9csXTYv5Nyfhj/VAlzfYb6qILSC9ChJetr3Dg4B6ymu
         IypG/M1gvAadVgegLoHg7aRNacAegHVcB2VR38RSHjETEymYJVElkTX9bYuM5ef5LhtC
         6P0oZU014IheCg0Y84YKqY53nkfrgwPiWjAR+cVkQwvJqddUvfHWbjHWTUQsH+2wAR0i
         B51g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778597559; x=1779202359;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U4F0o6tRjR07gQpJT+QCYd1MmidxJ6x8UzqyphqwqXc=;
        b=b0yy+UhVg3s8jUmrlBSjBzTMO0mzEyLWTva0vaYUbpWk2ujrdvniMeyJyEYYvxIrfV
         qjTyCotWk/Dv0MjViKFGheQ8QO5lQkN3FIUF9vmaFxMAlGKFZGCpq0QAhTyxWMmE6g8n
         fGbIxZMu1ce6GdBGIwwLBTs67r/VOC8/JsS5oyM4sA3LhzJvHka4jOlwCewHlj32Fsi/
         Vs5uQlzJBF/trdGrvrzzW74GTmx6NQ65Pyh41g0nlVRKZNBerUZnbZHQju77vBSxy6MN
         Fm7+sSEetAsvu1P5ZPjVduyViQMczrmK+0nwclnpe3IVqJIiWQyX9d0aeXN9xsOs97lm
         ntnw==
X-Forwarded-Encrypted: i=1; AFNElJ8QqYhXyNS7IDUmkuUuNXrUOfw0g47B98eqAhdJCGLqULtIHETsQYMN58mhLFEPcZuieHM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVagCHhP2Z8X/FqV3o0W704UldSsttBZFQoGprYeKG6BFbZoIo
	npPB3X4PLftuUMl3WuSYUE0GqmTB7XD/zJe8n3y8DGqZ9LcwP2a8zg56
X-Gm-Gg: Acq92OFaUn14Wk6ajh3YEmLfL80zMSAuJQ88A2hVPsbF0am5gHX5PCYRaDHvPEbds14
	RSw+vsc24vK8CKkHVJ9XeiyfVvxPrSmaUQpg9vKl3giKMtpO+HvUMitekOsEeOPE/tbNKYmBm8P
	1I2xyTHrpfOx78FE3twrjJVxczpoc8DyuGkg9XZORTO/wCJAD+Ye5yQpdK/WiZnqA8OhByxM501
	Bu5Y/fWTkOoUDcLEPt7Z2ys4vQ6IuDYcaEV+jjaqkjBz+yh43BVo78hPbuAEtiRmb7+hJIiC30Q
	WMtSvDe11TFjNTkHTzxp5DHkXIsMQo5EVAmZnwMn0q07mJcg9WPEd4ChlRzZfs4oDNnbBDbl2qL
	4Bd5gqR/O+u3Cw1ul4du0U0EHV4FHVKAw0Gel8IrcbLHF3rHcEwHEBmx0tx2Cz0UDyizYL8CCtc
	CNdE3/Pk2Ik1qDDymS7fm5u2ewoTyOFg8YECy98RzkSrM9dGABIfts7Tzqvjiy/F5BM4QFwXhMl
	37O8GUK4fZqHcldQ/1scXiJ51pmRCG1qqiQC58IKJAXy7MOK9U=
X-Received: by 2002:a05:620a:2907:b0:8f0:10b0:9e5a with SMTP id af79cd13be357-90910c133fbmr2081994985a.50.1778597559036;
        Tue, 12 May 2026 07:52:39 -0700 (PDT)
Received: from ?IPV6:2605:a601:9b88:8300:e033:f3ca:f5b3:2d9c? ([2605:a601:9b88:8300:e033:f3ca:f5b3:2d9c])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-907b9772b87sm1341772685a.5.2026.05.12.07.52.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2026 07:52:38 -0700 (PDT)
Message-ID: <b7df2426-912b-44f0-82b1-d246d5558484@gmail.com>
Date: Tue, 12 May 2026 10:52:38 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/7] remote: add remote.*.negotiationRestrict config
To: Matthew John Cheetham <mjcheetham@outlook.com>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: gitster@pobox.com, ps@pks.im
References: <pull.2085.v2.git.1776266066.gitgitgadget@gmail.com>
 <pull.2085.v3.git.1776871546.gitgitgadget@gmail.com>
 <d2f48b78b5b4c63269b1129865d94fdab9dffd92.1776871546.git.gitgitgadget@gmail.com>
 <VI0PR03MB11634BD90B47B89A7631F5DE5C0392@VI0PR03MB11634.eurprd03.prod.outlook.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <VI0PR03MB11634BD90B47B89A7631F5DE5C0392@VI0PR03MB11634.eurprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/12/26 8:29 AM, Matthew John Cheetham wrote:
> On 2026-04-22 16:25, Derrick Stolee via GitGitGadget wrote:
> 
>> From: Derrick Stolee<stolee@gmail.com>
>>
>> In a previous change, the --negotiation-restrict command-line option of
>> 'git fetch' was added as a synonym of --negotiation-tips. Both of these
>> options restrict the set of 'haves' the client can send as part of
>> negotiation.
> 
> s/tips/tip/ as per the previous patch comments. Not important either
> way.

Thanks.

>> +remote.<name>.negotiationRestrict::
>> +    When negotiating with this remote during `git fetch` and `git push`,
>> +    restrict the commits advertised as "have" lines to only those
>> +    reachable from refs matching the given patterns.  This multi-valued
>> +    config option behaves like `--negotiation-restrict` on the command
>> +    line.
>> ++
>> +Each value is either an exact ref name (e.g. `refs/heads/release`) or a
>> +glob pattern (e.g. `refs/heads/release/*`).  The pattern syntax is the
>> +same as for `--negotiation-restrict`.
>> ++
>> +These config values are used as defaults for the `--negotiation-restrict`
>> +command-line option.  If `--negotiation-restrict` (or its synonym
>> +`--negotiation-tip`) is specified on the command line, then the config
>> +values are not used.
>> ++
>> +Blank values signal to ignore all previous values, allowing a reset of
>> +the list from broader config scenarios.
>> +
>>   remote.<name>.followRemoteHEAD::
>>       How linkgit:git-fetch[1] should handle updates to `remotes/<name>/HEAD`
>>       when fetching using the configured refspecs of a remote.
> 
> 
> You say "during `git fetch` and `git push`", but does `push` actually
> honour the new config?
> 
> When the `push.negotiate` config is on then
> `get_commons_through_negotiation()` from send-pack.c shells out to
> `git fetch --negotiate-only` with one `--negotiation-tip=<oid>` arg per
> ref being pushed, then the URL. This means the CLI restrict list is
> always non-empty in the subprocess so in `prepare_transport()` (in the
> below hunk) the `if (negotiation_restrict.nr)` arm is always taken and the new 
> `else if (remote->negotiation_restrict.nr)` arm is never taken.
> 
> BUT.. reading ahead I see that patch 7 actually wires up negotiation
> config for push - so my commentary here will be moot! Do we want to drop
> the "and `git push`" part from this until patch 7, when it is wired up
> appropriately?

You're right that this documentation is premature about 'git push'.

> One other suggestion: perhaps we should clarify that `push.negotiate`
> needs to be set for `remote.<name>.negotiationRestrict` to be honoured
> during pushes?

Yes. I'll rewrite this to focus on 'git fetch'. Then in patch 7 I can
add a new detail about how to make this behavior be respected in 'git push'.

>>       if (deepen_relative) {
>>           if (deepen_relative < 0)
>>               die(_("negative depth in --deepen is not supported"));
>> @@ -2749,6 +2758,10 @@ int cmd_fetch(int argc,
>>           if (!remote)
>>               die(_("must supply remote when using --negotiate-only"));
>>           gtransport = prepare_transport(remote, 1, &filter_options);
>> +        if (!gtransport->smart_options ||
>> +            !gtransport->smart_options->negotiation_restrict_tips)
>> +            die(_("%s needs one or more %s"), "--negotiate-only",
>> +                "--negotiation-restrict=*");
>>           if (gtransport->smart_options) {
>>               gtransport->smart_options->acked_commits = &acked_commits;
>>           } else {
> 
> 
> This new condition fires whenever `gtransport->smart_options` is NULL,
> i.e. the transport doesn't support smart options. Before this case was
> handled three lines after this hunk by:
> 
>    } else {
>        warning(_("protocol does not support --negotiate-only, exiting"));
>        result = 1;
>        trace2_region_leave("fetch", "negotiate-only", the_repository);
>        goto cleanup;
>    }
> 
> What happens now if a user runs --negotiate-only against a non-smart
> transport is they see an odd message:
> 
>    fatal: --negotiate-only needs one or more --negotiation-restrict=*
> 
> ..but they may have specified --negotiation-restrict options.
> 
> Do we instead want &&?
> 
>       if (gtransport->smart_options &&
>           !gtransport->smart_options->negotiation_restrict_tips)
>           die(_("%s needs one or more %s"), "--negotiate-only",
>               "--negotiation-restrict=*");
You are right that we want to say "we have smart options but haven't
specified restrict arguments" so we can leave the later if/else to
handle the null smart_options case. But actually, I think that it
would be better to reorganize the conditions altogether:

	if (!gtransport->smart_options) {
		warning(_("protocol does not support --negotiate-only, "exiting"));
		result = 1;
		trace2_region_leave("fetch", "negotiate-only", the_repository);
		goto cleanup;
	}
	if (!gtransport->smart_options->negotiation_restrict_tips)
		die(_("%s needs one or more %s"), "--negotiate-only",
		    "--negotiation-restrict=*");

	gtransport->smart_options->acked_commits = &acked_commits;

This is easier to reason about:

* If we don't have smart options, then skip out of the negotiation logic.
* If we don't have restrict tips, then die().
* Do the negotiation logic only if the previous two conditions didn't hold.

>> @@ -562,6 +564,12 @@ static int handle_config(const char *key, const char *value,
>>       } else if (!strcmp(subkey, "serveroption")) {
>>           return parse_transport_option(key, value,
>>                             &remote->server_options);
>> +    } else if (!strcmp(subkey, "negotiationrestrict")) {
>> +        /* reset list on empty value. */
>> +        if (!value || !*value)
>> +            string_list_clear(&remote->negotiation_restrict, 0);
>> +        else
>> +            string_list_append(&remote->negotiation_restrict, value);
>>       } else if (!strcmp(subkey, "followremotehead")) {
>>           const char *no_warn_branch;
>>           if (!strcmp(value, "never"))
> 
> 
> Here we use the 'empty value means reset the list' pattern, but I notice
> that the `parse_transport_option()` function already supports this reset
> pattern (and used by serveroption above), with a small difference:
> 
>    if (!value)
>        return config_error_nonbool(var);
>    if (!*value)
>        string_list_clear(transport_options, 0);
> 
> So NULL is an error, but empty string is 'reset'. Is it worth being
> consistent with other options that use `parse_transport_options`?

Thanks for catching this! Let's be consistent. NULL is likely
impossible in this case, but let's be consistent. It also needs
to return.

Thanks,
-Stolee

