Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D72D7CCA47C
	for <git@archiver.kernel.org>; Thu, 23 Jun 2022 17:53:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232851AbiFWRx6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jun 2022 13:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235440AbiFWRwg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jun 2022 13:52:36 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ED13517DC
        for <git@vger.kernel.org>; Thu, 23 Jun 2022 10:13:23 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id f13-20020a170902ce8d00b0016a408cbf3bso3636756plg.7
        for <git@vger.kernel.org>; Thu, 23 Jun 2022 10:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=EeFvhCFO+giyylrQ1DFU9CQkVmMtyIPzxoZgdqxrGLs=;
        b=SvH7+B2f5BdA/Y4noURlBA8mTGVk32pEtRsJysr4K+etHWsk25d9SdNooSdO9T9bKW
         rttTLHzbQHnCR76umlClX/8DwSmWOFfBY6bzlcK/58d0pcUlsacDvoxSLjjYr375T1xp
         UiysEh1233T9t4KaDafTN4Mki+kShaqcHj4kmMms03540uAT2oLVQhuYn/hQ4GfiJd+B
         HrEg17VZe/kb7r/RyvhMXxNSRUuwJ2gIKBxD4A2/JzMoTSd1dJ9Ta+v7wsZzruoWZ8+h
         x+mKug6oogNzXL4n3VwCrwTwdjK145xgzO40jZm93Cc9xLwn+M3oYvbjDGmkBET7wq5M
         svIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=EeFvhCFO+giyylrQ1DFU9CQkVmMtyIPzxoZgdqxrGLs=;
        b=qVzGjT4rqlrv8u7ATBJSD+EVSdd05+raxkHxSAYYPUR68+dbP4zS6yHFpB023T0OCF
         rixcnxmOMcvb2yWE/fIPox9O6lCxN5fLTovTqYyrabaPrhi+vHNW5DYNvt0gYC7k9m5m
         /Ol9fxj7C93cNQl0A8ED/Hm/GbzvfqH2BBnTv9a+6MgKYnubMThY41i+MRR3RdTbhNAv
         AJJ5owAYkN+dJWL4bugAQV0KqXLiEZ17GpabppWlG7jjRmgV4YrApxLrvWQg9swycrgz
         8Q2sZBgo0CL1/fimrtQjlWqlWhFRsPps68i8Z+gCnMJ49/B2+4aBG9ChVEhi4b69tggf
         4gnw==
X-Gm-Message-State: AJIora+laQi6xfpOGqdbZD3Oecw6tEdJOkR18D6YPEn26s/bqjUlXl9O
        PTbdyyFLV7P2SBVSAHG3tMnwFFpagd2wgQ==
X-Google-Smtp-Source: AGRyM1voMPeQVzkcr1vyCIwrbxEqraXJyD8X7WlbVECMCXPSua8J74qbaiYQWSOAlyUhdG2+CUP4M5QyaY6Z3A==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90a:f8d2:b0:1ec:b55b:2fdc with SMTP
 id l18-20020a17090af8d200b001ecb55b2fdcmr4972656pjd.115.1656004402563; Thu,
 23 Jun 2022 10:13:22 -0700 (PDT)
Date:   Thu, 23 Jun 2022 10:13:20 -0700
In-Reply-To: <20220622220331.3734584-1-jonathantanmy@google.com>
Message-Id: <kl6lr13fi9qn.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <20220622220331.3734584-1-jonathantanmy@google.com>
Subject: Re: [PATCH v4 0/5] config: introduce discovery.bare and protected config
From:   Glen Choo <chooglen@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>,
        Glen Choo via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Taylor Blau <me@ttaylorr.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com> writes:
>> Glen Choo (5):
>>   Documentation/git-config.txt: add SCOPES section
>>   Documentation: define protected configuration
>
> Forgot to mention when I was sending my comments on patch 2: we should
> standardize on "protected config" and not use "protected configuration"
> anywhere.

Makes sense.

> One alternative design would have been to have separate configsets for
> protected config and non-protected config (or even better, separate
> configsets for trace2 config, protected config minus trace2 config, and
> non-protected config) but that doesn't have to block the submission of
> this patch set.

I suppose that the idea behind this is that we only parse and store each
config file exactly once. It's a good goal, but the whole point of the
configset is that we can query a single struct to figure out the value
of a config variable. Having multiple configsets starts to shift more of
the burden to the callers because they now have to query multiple
configsets to find their desired config value, and we already start to
see some of this unpleasantness in this series.

An alternative that I'd been thinking about is to make a few changes to
the git_config_* + configset API to allow us to use a single configset
for all of our needs:

1. Keep track of what config we've read when reading into
   the_repository->config, i.e. instead of a boolean "all config has
   been [un]read", we can express "system and global config has been
   read, but not local or command config". Then, use this information to
   load config from sources as they become available. This will allow us
   to read incomplete config for trace2 and setup.c (discovery.bare and
   safe.directory), and only read what we need later on.

   This assumes that when Git reads config, that config is always valid
   later on. So this is broken if, e.g. we read global config file A
   during setup, but when we discover the repo, we discard A and read
   global config file B instead. I don't know if we do this or if we are
   planning to in the future.

2. Add an additional argument that specifies what scopes to respect when
   reading config (maybe as a set of flags). This gives us extra
   specificity when using the git_config*() functions, so we could get
   rid of git_protected_config() like so:

    /* Change enum config_scope into flags first... */

    #define WIP_SCOPES_PROTECTED = CONFIG_SCOPE_SYSTEM & \
      CONFIG_SCOPE_GLOBAL & CONFIG_SCOPE_COMMAND

    static enum discovery_bare_allowed get_discovery_bare(void)
    {
      enum discovery_bare_allowed result = DISCOVERY_BARE_ALWAYS;
      git_config(discovery_bare_cb, &result, WIP_SCOPES_PROTECTED);
      return result;
    }

   And as an added bonus, this gives us an easy way to implement the
   constant time git_config_*() functions for protected config. We could
   even do this without doing 1. first. I haven't looked into whether
   we could turn the enum into flags, but otherwise, I think this is
   pretty feasible.
