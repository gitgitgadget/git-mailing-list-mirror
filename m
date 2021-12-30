Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C2E4C433F5
	for <git@archiver.kernel.org>; Thu, 30 Dec 2021 17:30:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231386AbhL3RaA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Dec 2021 12:30:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241485AbhL3R37 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Dec 2021 12:29:59 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3D9FC06173E
        for <git@vger.kernel.org>; Thu, 30 Dec 2021 09:29:59 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id r10-20020a056830080a00b0055c8fd2cebdso33077373ots.6
        for <git@vger.kernel.org>; Thu, 30 Dec 2021 09:29:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=D/LhJA0xbWiofHPTFQ99VOb+dFxE49jVcPR+0Q+R67g=;
        b=qGA5NujYor6xqbfLVdcln5VgAGklP/+JCO0wgAr7LsfHEyasW9Wp+rlffBIeT3cnDV
         2VvO+mwgbHmmQxnS/pEvvxlsmw41cZQy0jH71ujfGysmTGyxWU4+n46E4ipTd50rN0sH
         r40pUdKzrdfR68a1FFxv6MUar6o/so8mI6lAK4JkWBoph9TsJ7M6joRLqs3D8n5NM2iD
         HkdLDMFqitdhiOBsP3C44vovr3W7sUFniqKgcOl3AJEDIGGYabgIOC4Wci+tQC4ULHyq
         kGdjwo1uo1w/4GTdmhE9YU+zC4wLPFHyXwSlXPBuAEgitZeD93sw9aloK5eErxwEFFjN
         6evA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=D/LhJA0xbWiofHPTFQ99VOb+dFxE49jVcPR+0Q+R67g=;
        b=73/uR3vVUE1Zz0PaJ0PPygh//PXL57ImG5TLlW/MOBN4bbT+KLcwbGRNYcVJydyYbH
         q7F0yrCUOZ6BeWYcXsfwsrMtSvfcu2jBHsTTFCeRgz4A/kyBOgAyo0mWLE0UiRRzpL4z
         ZMKqzbWQvpRFRTpeHB6yth2r+RasmNHm0iGy2Fn0RzoXbQNhJ+kYU/iDzpZn2GuZ4qvH
         ls87xjTihuPBZaO4FWAlY8D3nKz3jlAlzeTnBpUwQ9Gw7Qg4KGYPhRtBPe6XrN6IQKiU
         aBJvuqWw6Lc28jwqxrbclDe2eOjBFwIFRWp8M8LAhdQHXrZ9JRFv2TaT4Gh1imb5ARpO
         073w==
X-Gm-Message-State: AOAM5335nu7Li8g0RxW8Co2mwx0bqydvfjX7ywVMw9CIYCNqCWy2oVmN
        Ui16UvpaBYa0jJj76YzmsTE=
X-Google-Smtp-Source: ABdhPJwxhI3bgRToxcREG2wAtws5hNGAd+wE33Vj2gGrMc8TyEIfDe3bsgvF8wQz3TYFb64BmHyb0g==
X-Received: by 2002:a05:6830:1498:: with SMTP id s24mr21823932otq.309.1640885398958;
        Thu, 30 Dec 2021 09:29:58 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:cd5c:4260:de91:c496? ([2600:1700:e72:80a0:cd5c:4260:de91:c496])
        by smtp.gmail.com with ESMTPSA id s13sm4970522otv.34.2021.12.30.09.29.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Dec 2021 09:29:58 -0800 (PST)
Message-ID: <940635e7-ff92-d87d-5dfb-a61b6320c30b@gmail.com>
Date:   Thu, 30 Dec 2021 12:29:57 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v3 3/6] worktree: add 'init-worktree-config' subcommand
Content-Language: en-US
To:     Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Sean Allred <allred.sean@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.1101.v2.git.1640114048.gitgitgadget@gmail.com>
 <pull.1101.v3.git.1640727143.gitgitgadget@gmail.com>
 <e2a0a458115a26cfb855f7040f15e5198072b3a5.1640727143.git.gitgitgadget@gmail.com>
 <CAPig+cTn1049oZQwcLk82LPoOZ9N3mYQifSDObejdcvZwo6ZJg@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <CAPig+cTn1049oZQwcLk82LPoOZ9N3mYQifSDObejdcvZwo6ZJg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/30/2021 3:41 AM, Eric Sunshine wrote:
> On Tue, Dec 28, 2021 at 4:32 PM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>> [...]
>> To gain access to the core repository's config and config.worktree file,
>> we reference a repository struct's 'commondir' member. If the repository
>> was a submodule instead of a worktree, then this still applies
>> correctly.
> 
> In [1], I suggested that you should be using `repository->gitdir`
> rather than `repository->commondir` to access the `.git/config` file.
> Is the above paragraph saying that my suggestion was incorrect? Or is
> it incorrect only in the case of submodules? Or what is it saying?
> 
>> diff --git a/builtin/worktree.c b/builtin/worktree.c
>> @@ -1031,6 +1032,85 @@ static int repair(int ac, const char **av, const char *prefix)
>> +static int init_worktree_config(int ac, const char **av, const char *prefix)
>> +{
>> +       struct repository *r = the_repository;
>> +       char *common_config_file = xstrfmt("%s/config", r->commondir);
>> +       char *main_worktree_file = xstrfmt("%s/config.worktree", r->commondir);
> 
> Specifically, in [1], I said that `common_config_file` should be using
> `r->gitdir` (and that the use of `r->commondir` was correct for
> `main_worktree_file`).

Since you agree that "{r->commondir}/config.worktree" is the main
worktree's config file, then "{r->commondir}/config" should be the
repo-wide config file. If r->commondir and r->gitdir are different,
then using r->gitdir would be wrong, as far as I understand it.

Indeed, tracing these two values when run in a worktree, I see:

  gitdir: /home/stolee/_git/git/.git/worktrees/git-upstream
  commondir: /home/stolee/_git/git/.git

So we definitely want commondir here.

>> +       /*
>> +        * If the format and extension are already enabled, then we can
>> +        * skip the upgrade process.
>> +        */
>> +       if (repository_format_worktree_config)
>> +               return 0;
> 
> Rather than `return 0`, should this be `goto cleanup`...

Right, or move the 'if' to before the configset is initialized. The
goto is simple enough.
 
>> +       if (upgrade_repository_format(r, 1) < 0) {
>> +               res = error(_("unable to upgrade repository format to enable worktreeConfig"));
>> +               goto cleanup;
>> +       }
>> +       if ((res = git_config_set_gently("extensions.worktreeConfig", "true"))) {
>> +               error(_("failed to set extensions.worktreeConfig setting"));
>> +               goto cleanup;
>> +       }
> 
> ... as is done for these two cases?
> 
>> +cleanup:
>> +       git_configset_clear(&cs);
>> +       free(common_config_file);
>> +       free(main_worktree_file);
>> +       return res;

Thanks,
-Stolee
