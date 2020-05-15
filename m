Return-Path: <SRS0=YoUm=65=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05829C433E1
	for <git@archiver.kernel.org>; Fri, 15 May 2020 16:52:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA2E0206C0
	for <git@archiver.kernel.org>; Fri, 15 May 2020 16:52:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eNfI2oku"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbgEOQwC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 May 2020 12:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726302AbgEOQwC (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 15 May 2020 12:52:02 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7FA8C061A0C
        for <git@vger.kernel.org>; Fri, 15 May 2020 09:52:01 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id l11so4387426wru.0
        for <git@vger.kernel.org>; Fri, 15 May 2020 09:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KhJbVfS5MnQe1fa20K5vtFSuALw1fea1+e8yal1vUXI=;
        b=eNfI2okuYGQwW3h0v2yIfkkfkzFIRLSFzpb9N10/otcd0Xy9nw+A1lsJiTPEp2oU+g
         wqUnS4EtMXd4U08EpVM+QDvVYu4vp1J9aDXB9yStTAnx6KraPOOapKpZB2I7kCcdAAC+
         NSa/Qqkq6LMJ+1FKZchfX+WwZTKJyijk1cVZ9gci27lKAuKh3Pka0VtOYVdSm1XTAhV0
         FfhAXr+2mD6TRgJAgA/fh2OL1CuoZH8xofVKuP/VcU3PknIGd+9DgVjUhO/nIX4Ehf1X
         4V+DjSelaDjZCGzt1hdInh1mtd9vzqaLMxeSEHB4bCt2DVb8NCqnSAbHNOWlj5EcjTnx
         icAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KhJbVfS5MnQe1fa20K5vtFSuALw1fea1+e8yal1vUXI=;
        b=cI19j+P3tE77k0oNyRZcD889lbBhGrSi1rJz+CWoVRqIzmwuTI8/VgvxecaAJ400gt
         1+DsORyW33WC9fj8xpwRen6+oG+cJnjYeCLUcwHzAT390CZ/pqMhWJmtCtwdDER17W60
         YySofOmVk8FyoHe7sXFzBCWc2WAL9oAOzCqwud8FvatG/wrchf4CMdYGeMzS9SZFO0mj
         ccSvdqQ20zLz8bW/N7liE52Yk9QyHmaLQssfJ9WOA9zfly2sMCAqc/6Aq35Z9sbaA1n+
         TTf2cgEp8SFHBRpqhfwtv3auzXmQ26ni4maS2RMQcGra5xkj2eYKFPWYR/4S2JM64HBD
         5UBA==
X-Gm-Message-State: AOAM532dByKU6TKYDDrpgfrdVc9Iab2qbdZulCfV/1NM5WCRVaHctKE+
        yBCGVer/Hqz1TUFQPKJiYShKexwXSf4=
X-Google-Smtp-Source: ABdhPJxB5Orx4QMuA8v4DgNSOzCfiTVe/hWBQlpTnbqr6g4fm0TmIIjNDuonpRnNZSyLCgbbeyLzYg==
X-Received: by 2002:a5d:4006:: with SMTP id n6mr5302098wrp.27.1589561520600;
        Fri, 15 May 2020 09:52:00 -0700 (PDT)
Received: from [192.168.1.21] (xdsl-31-164-191-108.adslplus.ch. [31.164.191.108])
        by smtp.gmail.com with ESMTPSA id m3sm4384098wrn.96.2020.05.15.09.51.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2020 09:52:00 -0700 (PDT)
Subject: Re: [PATCH] submodule--helper.c: add only-active to foreach
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com,
        liu.denton@gmail.com, gitster@pobox.com
References: <pull.631.git.1589099162707.gitgitgadget@gmail.com>
 <20200510164424.GA11784@konoha>
 <CAOEXN9yyL8T8kDmpHKTjjaG9tVS1kh34B-=PuH1hRaA7jF_K6A@mail.gmail.com>
 <20200512141520.GA8133@konoha>
From:   Guillaume Galeazzi <guillaume.galeazzi@gmail.com>
Message-ID: <b45268b1-de5f-051c-f956-8a17c067f4c6@gmail.com>
Date:   Fri, 15 May 2020 18:51:57 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200512141520.GA8133@konoha>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Le 12.05.2020 à 16:15, Shourya Shukla a écrit :
> On 10/05 11:51, Guillaume Galeazzi wrote:
> 
> 
>> Defining some macro to hold possible value:
>>          #define FOREACH_ACTIVE 1
>>          #define FOREACH_INACTIVE 0
>>          #define FOREACH_ACTIVE_NOT_SET -1
>>
>> Changing the FOREACH_CB_INIT to
>>          #define FOREACH_CB_INIT { 0, NULL, NULL, 0, 0, FOREACH_ACTIVE_NOT_SET }
> 
> Do we really need to include the last macro here?

After a cross check, yes it is the correct place to initialise the new 
active_only member of foreach_cb. But it will be changed to use 
designated initializers.

>> The filter become:
>> int is_active;
>> if (FOREACH_ACTIVE_NOT_SET != info->active) {
>>          is_active = is_submodule_active(the_repository, path);
>>          if ((is_active && (FOREACH_ACTIVE != info->active)) ||
>>              (!is_active && (FOREACH_ACTIVE == info->active)))
>>                  return;
>> }
> 
> Is it okay to compare a macro directly? I have not actually seen it
> happen so I am a bit skeptical. I am tagging along some people who
> will be able to weigh in a solid opinion regarding this.

Yes it is okay, a `#define SOMETHING WHATEVER` will just inform the c 
preprocessor to replace the `SOMETHING` by `WHATEVER`. The only thing 
the final c compiler will see is `WHATEVER`. In our case a integer value.

Goal here was to avoid magic number, but after looking to the code it 
seem accepted that true is 1 and false is 0. To comply with that, in 
next version it will be replace it with:

	if (FOREACH_BOOL_FILTER_NOT_SET != info->active_only) {
		is_active = is_submodule_active(the_repository, path);
		if (is_active != info->active_only)
			return;
	}

> 
>> It need two additionnal function to parse the argument:
>> static int parse_active(const char *arg)
>> {
>>          int active = git_parse_maybe_bool(arg);
>>
>>          if (active < 0)
>>                  die(_("invalid --active option: %s"), arg);
>>
>>          return active;
>> }
> 
> Alright, this one is used for parsing out the active submodules right
As suggested on other mail of this patch, it will be removed and take 
the shortcut `--no-active`.

>> And the option OPT_BOOL become a OPT_CALLBACK_F:
>> OPT_CALLBACK_F(0, "active", &info.active, "true|false",
>>          N_("Call command depending on submodule active state"),
>>          PARSE_OPT_OPTARG | PARSE_OPT_NONEG,
>>          parse_opt_active_cb),
>>
>> The help git_submodule_helper_usage:
>> N_("git submodule--helper foreach [--quiet] [--recursive]
>> [--active[=true|false]] [--] <command>"),
> 
> What I have inferred right now is that we introduce the `--active`
> option which will take a T/F value depending on user input. We have 3
> macros to check for the value of `active`, but I don't understand the
> significance of changing the FOREACH_CB_INIT macro to accomodate the
> third option. And we use a function to parse out the active
> submodules.

The change on `FOREACH_CB_INIT` are to keep original behaviour of the 
command if new flags are not given.

> Instead of the return statement you wrote, won't it be better to call
> parse_active() depending on the case? Meaning that we call
> parse_active() when `active=true`.
> 
> Regards,
> Shourya Shukla
> 

The code to parse command T/F will be removed.

Regards,

Guillaume
