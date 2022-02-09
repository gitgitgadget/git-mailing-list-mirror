Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4661C4332F
	for <git@archiver.kernel.org>; Wed,  9 Feb 2022 02:41:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344268AbiBIClB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Feb 2022 21:41:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245157AbiBIC1W (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Feb 2022 21:27:22 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD720C0613CC
        for <git@vger.kernel.org>; Tue,  8 Feb 2022 18:27:21 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id x5so720229qtw.10
        for <git@vger.kernel.org>; Tue, 08 Feb 2022 18:27:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=VbXdUfibz2P0NORh1ap3OT6NpLwKwTyIs1CdInTAUO8=;
        b=VR4Gu39eIyYfWNdQrT1vwl4VQkBCxxiEwf4Z78qdpSueVRY0eNgTYQQwQahXODFDue
         lKrZ+A8cnYzBrp+6T/n1I7hLS1LeW2pU/BT+ltzaZPuFDvpJZs7/KKJq3sWA1gLyI6fX
         R1rW8lvFLk90P25AWa/wZPLKuKwMTCNOnFz1Z4M7NHJpYls3kZOh+Iz4aiT8V+E8WL8l
         OD8/1HmLZZrbb2EXSXn4TS5pFatCCKATi+q+T1GOmGePsgvDyCH7m5/bE53cK31pO5Zv
         C1j3XemlTkEhzeEvxmK/OjX6a4KX7FK9d9VlX86So14IpeyxE+99fqvxcIapUI9jkMdf
         HEAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=VbXdUfibz2P0NORh1ap3OT6NpLwKwTyIs1CdInTAUO8=;
        b=AJ8kvFhE2PWYjB0GARhIUOOxzCwXc4q01rIQUhGUWhl5qW+VEL0J+xJnnzVmITMWfw
         vjlFBOBYmO6VzBvaSIXWrTVcG6rdCov1lJ7Yvsaj7I1uHwy07Tkf1OfEg7ts2IhnGOWA
         2qVzDk8R9Gx6oB5tL5DItHcR+v/UPowWB85D0gRtxS6h2yXecnAlgfrUA/4BWV5kqIso
         sUgbWN+q2ncBTvkO4/WkHOfZe+x0tGfaL1oo3c9AmWa7w6+MmI7Et+qBCdUAJsUdBPKS
         c1QUOBA+YtdALycKfZLRaDBsdJ/EexiBCsmDMSRsiRkMdK32v1vgXJW19A5Ed6VvqL8P
         1PCg==
X-Gm-Message-State: AOAM533TmhQk862KB++jQg64kDp8eJ/C8yEun8imjiWlDAetz8u6op8v
        vrjd1tm8aORLkfTbHoORNhE=
X-Google-Smtp-Source: ABdhPJyoLNrDBq+7EwwA2ZiWmMqwS+30daDMKV/vzWGk5CrQa8znCsmq1XheHlcaDyrfxvnIsQmFnQ==
X-Received: by 2002:a05:622a:199c:: with SMTP id u28mr47674qtc.221.1644373640161;
        Tue, 08 Feb 2022 18:27:20 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:999a:e20e:62a:aacd? ([2600:1700:e72:80a0:999a:e20e:62a:aacd])
        by smtp.gmail.com with ESMTPSA id y5sm8035864qkp.37.2022.02.08.18.27.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Feb 2022 18:27:19 -0800 (PST)
Message-ID: <ab6021a8-cbb9-3261-8e08-bb4a83287473@gmail.com>
Date:   Tue, 8 Feb 2022 21:27:16 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v6 3/6] config: add repo_config_set_worktree_gently()
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, sunshine@sunshineco.com,
        allred.sean@gmail.com, Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?Q?Jean-No=c3=abl_AVILA?= <jn.avila@free.fr>,
        derrickstolee@github.com, Derrick Stolee <dstolee@microsoft.com>
References: <pull.1101.v5.git.1643641259.gitgitgadget@gmail.com>
 <pull.1101.v6.git.1644269583.gitgitgadget@gmail.com>
 <cf9e86fe3a403d0ceaff9fdf484a9bf6b07799ac.1644269583.git.gitgitgadget@gmail.com>
 <xmqqv8xpato3.fsf@gitster.g>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqqv8xpato3.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/8/2022 5:18 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
...
>> @@ -3181,14 +3196,28 @@ void git_config_set_multivar_in_file(const char *config_filename,
>>  int git_config_set_multivar_gently(const char *key, const char *value,
>>  				   const char *value_pattern, unsigned flags)
>>  {
>> -	return git_config_set_multivar_in_file_gently(NULL, key, value, value_pattern,
>> -						      flags);
>> +	return repo_config_set_multivar_gently(the_repository, key, value,
>> +					       value_pattern, flags);
>> +}
> 
> Is this an unrelated "morally no-op" change?

This one is to match the pattern of how "git_*" methods should
depend on their "repo_*" counterparts (with "the_repository" inserted
properly). So, it's part of the standard process for creating these
"repo_*" variants.

>>  void git_config_set_multivar(const char *key, const char *value,
>>  			     const char *value_pattern, unsigned flags)
>>  {
>> -	git_config_set_multivar_in_file(NULL, key, value, value_pattern,
>> +	git_config_set_multivar_in_file(git_path("config"),
>> +					key, value, value_pattern,
>>  					flags);
>>  }
> 
> Is this an unrelated "morally no-op" change?
> 
> It might have value to make caller more explicit by reducing the use
> of "I give NULL, you use 'config' for me", but that doesn't sound
> related to the addition of set_per_worktree_config_gently() helper.

Here, you're right. This one should have followed the same pattern
of having the "git_*" equivalent call the "repo_*" method, but
instead I incorrectly inlined some of the code.

The proper body should be

void git_config_set_multivar(const char *key, const char *value,
			     const char *value_pattern, unsigned flags)
{
	repo_config_set_multivar_gently(the_repository, key, value,
					value_pattern, flags);
}

to follow convention.

Thanks,
-Stolee
