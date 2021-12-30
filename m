Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACC54C433EF
	for <git@archiver.kernel.org>; Thu, 30 Dec 2021 17:41:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241469AbhL3Rl6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Dec 2021 12:41:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231386AbhL3Rl5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Dec 2021 12:41:57 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C0FC061574
        for <git@vger.kernel.org>; Thu, 30 Dec 2021 09:41:57 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id t204so34980109oie.7
        for <git@vger.kernel.org>; Thu, 30 Dec 2021 09:41:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=HeHp0Ux651J/K2KV+U0yy7M3de5ZnV4X7tzsdI/NfkY=;
        b=RaWvlCJ7epxHCgNI+75eV1GbiN4pDpYht7INE17MrHr9LeTbnzuVVF7T1or1PfUjL/
         DKyqgrlUPZFScK4uadnyXiG30rOTzqPIE44IhHc/ImVQMMAD+oiSVynM0U3WcuVOH+Sk
         6BTOd8qWaOKTktF1WWKoVlQffEFCgXN3+oqhBizJXsvvKt9pZXS8JE1E+pLP/1P9ZIM1
         yfxPEM7czTU6NuzjZ9Zu8ciqw55Ykdx0ywa44HTPcHQTbIiq+HF4lLgUgl2e+udEhz3b
         lv6mdsI6YGmptr5DP6z/AxR98VP9GEf41hkv9KlqZtMEfro2s1x4oKDHk9nTOjW/a9Cf
         WEqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=HeHp0Ux651J/K2KV+U0yy7M3de5ZnV4X7tzsdI/NfkY=;
        b=KlALMSMnT/3ns7VQArl3kYagj0hxWKE+6+RoOuVlRTifojFUuBx3dtbCmg1txHKhwp
         E/D0fsPOQtnjs5xFNg2rF6vrprRNpAatRDnpZE57luhh/8EUdsu8bS6HlkpMuOVO/GcG
         U1gf5mgwPa6ck+m9sqrAk7dvJABcELRu57w0lc8jvAqMqFAIV363e5KcMdXyTJckfo8D
         tPCU6CpNhZVoRT019E2vprW6yJdPuuSOz0EGM3R8dLsZSwaiewMiV+5Z13UU0MxYu3bj
         DtRrbhw+IOYOGcA6Efn/bfDWtWbxpIb96xmChSFb4dGVtr9OlWS3EBm/M4/9tv3ozGFS
         N7CA==
X-Gm-Message-State: AOAM531qWi5ZdIlhL10SfR0zKOlCgC8uC25X5N2XWeG/dUReDnySbL2u
        1sbRPa5EEAwrrpxw4q3p++i3ZR5nL/8=
X-Google-Smtp-Source: ABdhPJzCoaRJwbc8SkNZeDKWSlU99q2WeCu6XD2Vo6XmU/GQXPpMVT3/9oW9QICJ6F5WdLaVq1vZWw==
X-Received: by 2002:aca:ea88:: with SMTP id i130mr24246854oih.140.1640886116145;
        Thu, 30 Dec 2021 09:41:56 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:cd5c:4260:de91:c496? ([2600:1700:e72:80a0:cd5c:4260:de91:c496])
        by smtp.gmail.com with ESMTPSA id u40sm5837723oiw.56.2021.12.30.09.41.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Dec 2021 09:41:55 -0800 (PST)
Message-ID: <f62709d5-a0d4-dc0c-461a-c4c75c810340@gmail.com>
Date:   Thu, 30 Dec 2021 12:41:54 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v3 0/6] Sparse checkout: fix bug with worktree of bare
 repo
Content-Language: en-US
To:     Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Sean Allred <allred.sean@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>
References: <pull.1101.v2.git.1640114048.gitgitgadget@gmail.com>
 <pull.1101.v3.git.1640727143.gitgitgadget@gmail.com>
 <CABPp-BHuO3B366uJuODMQo-y449p8cAMVn0g2MTcO5di3Xa7Zg@mail.gmail.com>
 <CAPig+cQ8Y2FC8=d7DaZ46YwPCrzM6RzutiZ3ghhrHsg6y8KWoQ@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <CAPig+cQ8Y2FC8=d7DaZ46YwPCrzM6RzutiZ3ghhrHsg6y8KWoQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/30/2021 2:40 AM, Eric Sunshine wrote:
> On Wed, Dec 29, 2021 at 4:40 AM Elijah Newren <newren@gmail.com> wrote:>

Taking time to focus only on this outline here:

>> So, I'd like to reiterate my earlier suggestion which would avoid
>> these regressions while also fixing the reported bug:

>>   * If core.bare=true or core.worktree is set, then at `git worktree
>> add` time, automatically run the logic you have here for
>> init-worktree-config.  Having either of those config settings with
>> multiple worktrees is currently broken in all git versions and likely
>> in most all external tools.  As such, being aggressive in the new
>> config settings to allow new versions of git to work seems totally
>> safe to me -- we can't be any more broken than we already were.

I'm not sure I agree with the "currently broken in all git versions"
because when extensions.worktreeConfig is not enabled, the core.bare
and core.worktree settings are ignored by the worktrees. This upgrade
during 'add' is the only thing I am not so sure about.

>>   * If core.bare=false and core.worktree is not set, then:

>>     * `git sparse-checkout {init,set}` should set
>> extensions.worktreeConfig if not already set, and always set the
>> core.sparse* and index.sparse settings in worktree-specific files.

This should happen no matter the case of core.bare and core.worktree
existing, right?

>>     * `git worktree add`, if extensions.worktreeConfig is already set,
>> will copy both the info/sparse-checkout file and the config.worktree
>> settings (module core.bare and core.worktree, if present) to the new
>> worktree

and here, 'git worktree add' should always copy the info/sparse-checkout
file (if core.sparseCheckout is enabled) and copy the config.worktree
settings if extensions.worktreeConfig is enabled (and filter out
core.bare and core.worktree in the process).

> Thanks for the clearly written enumeration of how you expect this to
> work. This summary pretty well (or entirely) captures the conclusions
> I arrived at, as well, after devoting a chunk of time today thinking
> through the cases. If I'm understanding everything correctly, the
> approach outlined here solves the bare-worktree problem in the least
> invasive and least dangerous way (for older Git versions and foreign
> tools). And we don't even need the `git worktree init-worktree-config`
> subcommand (though we need the underlying functionality).

I'm happy to drop the subcommand in favor of some documentation in
git-config.txt (Documentation/config/extensions.txt to be exact).

Thanks,
-Stolee
