Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE02BC433EF
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 16:14:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB0AD60EDF
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 16:14:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233908AbhJYQQl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Oct 2021 12:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233883AbhJYQQc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Oct 2021 12:16:32 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F435C061745
        for <git@vger.kernel.org>; Mon, 25 Oct 2021 09:14:10 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id l7so13550082iln.8
        for <git@vger.kernel.org>; Mon, 25 Oct 2021 09:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=s0O83sZNGIkxeKjPAXw99outgAfVh9sIg30OMdb5X/Q=;
        b=jZLNc304ZELsB5s2v/WaET+GmjvnMXSsaoXsOPjBjpZ93nZffMH0CIRgY5NftqkaY8
         JAvqgZW/PFVRQjrcKSL8Fkd+8GSdbKukSotYrHbuk6sRu396oUE/WN/LtYuCBHUT+uxR
         IIa8oEqc0cd5A9ipyDw62rFnxjbFHElTtzHijAi4kC94VM0ifVssIeAl7/OisAavHOF5
         aTfZKVOUHKhmsO734A9xztHEhclh8Z1gugZGm3vD0iu/oNpIfCy5dSLbtVpRbQL9lztY
         EOU59tvQ723xG8sIpLPuRBot2W58oARDcFLRYc+WKUZ4k3RvuSJI2PgwxItOcWXJnIdv
         GlMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=s0O83sZNGIkxeKjPAXw99outgAfVh9sIg30OMdb5X/Q=;
        b=IJDKDYoXsIO6he/Jytmf0POSEPJEyMNAAY1DaYvsNQm5VG0et+xzL+ogtXfcIVbNmI
         D4E4MJhpzmwy828I3EysXJLHdhHY9t21/e3uwPtU9PcoZh1WQfx1wIz8IJhxBv2PwE7b
         juMOb1nzodBfZnetFdAnpEoHHMYYGl2SgOHlGQLSh62hP94kh16crCkhooGx9I68yw3U
         t/g7gVwHg1/o2iLDOYVHd4QRU2V8xvFqPsi7Q2t+KSXTpVvPWKV0pWPqrzf7npq7IVsF
         DKwF6cW72pld6xWLds8Emu26dZDOXCopijabVz6FKEpB0LWOOzojY6qwTMqBFIIhOUGt
         2Wxg==
X-Gm-Message-State: AOAM530OJeonyHRZXvkyq2A5p00GgSZUYZ1WqyArbW9DnMCcjl/cSMaC
        eClQSRFf+AhAFeFtPZ2zCo8Zg5A2OgI=
X-Google-Smtp-Source: ABdhPJyS7Ub2EW15CO/Q5cc/oYFerRdfqvoaVoZpTfbHtWZChOhbPvCfhv/l6fOly55Xo7RKtooQpQ==
X-Received: by 2002:a05:6e02:1c0c:: with SMTP id l12mr10835072ilh.69.1635178449767;
        Mon, 25 Oct 2021 09:14:09 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:b594:8626:d264:bb0? ([2600:1700:e72:80a0:b594:8626:d264:bb0])
        by smtp.gmail.com with ESMTPSA id g6sm3197482ilq.68.2021.10.25.09.14.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Oct 2021 09:14:09 -0700 (PDT)
Message-ID: <b208eb06-21c7-2199-0bc8-597669a165a1@gmail.com>
Date:   Mon, 25 Oct 2021 12:14:07 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH v4 3/4] submodule: record superproject gitdir during
 absorbgitdirs
Content-Language: en-US
To:     Jonathan Tan <jonathantanmy@google.com>, emilyshaffer@google.com
Cc:     git@vger.kernel.org
References: <20211014203416.2802639-4-emilyshaffer@google.com>
 <20211018231818.89219-1-jonathantanmy@google.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <20211018231818.89219-1-jonathantanmy@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/18/2021 7:18 PM, Jonathan Tan wrote:
>> Already during 'git submodule add' we record a pointer to the
>> superproject's gitdir. However, this doesn't help brand-new
>> submodules created with 'git init' and later absorbed with 'git
>> submodule absorbgitdir'. Let's start adding that pointer during 'git
>> submodule absorbgitdir' too.
> 
> s/absorbgitdir/absorbgitdirs/ (note the "s" at the end)
> 
>> @@ -2114,6 +2115,15 @@ static void relocate_single_git_dir_into_superproject(const char *path)
>>  
>>  	relocate_gitdir(path, real_old_git_dir, real_new_git_dir);
>>  
>> +	/* cache pointer to superproject's gitdir */
>> +	/* NEEDSWORK: this may differ if experimental.worktreeConfig is enabled */
>> +	strbuf_addf(&config_path, "%s/config", real_new_git_dir);
>> +	git_config_set_in_file(config_path.buf, "submodule.superprojectGitdir",
>> +			       relative_path(absolute_path(get_git_dir()),
>> +					     real_new_git_dir, &sb));
>> +
>> +	strbuf_release(&config_path);
>> +	strbuf_release(&sb);
>>  	free(old_git_dir);
>>  	free(real_old_git_dir);
>>  	free(real_new_git_dir);
> 
> Here [1] you mention that you'll delete the NEEDSWORK, but it's still
> there.
> 
> Having said that, it might be better to make a test in which we call
> this command while in a worktree of a superproject. The test might
> reveal that (as pointed out to me internally) you might need to use the
> common dir functions instead of the git dir functions to point to the
> directory that you want (git-worktree.txt distinguishes the 2 if you
> search for GIT_COMMON_DIR).

I came here to say the same thing. It's a bit too direct to compute
the location of a config file this way, so we should expose a method
that can create one for a given Git directory.

Since you're setting this config value inside the submodule's config,
what does it mean for a submodule to also be a worktree (and hence
require config.worktree)? What happens in this rough scenario?

  1. git init sub
  2. git init super
  3. git -C sub worktree add super/sub
  4. git -C super submodule absorbgitdir sub

I haven't actually tried running these things, but it seems unusual
and unexpected. This doesn't even account for cases where the repo
root and a worktree are both submodules within the superproject.

If we already have protections preventing these worktrees as
submodules, then perhaps there is no need for work here. I'm not
familiar enough with the area to make a claim one way or another.

Thanks,
-Stolee
