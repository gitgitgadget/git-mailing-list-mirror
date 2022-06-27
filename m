Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6F84C43334
	for <git@archiver.kernel.org>; Mon, 27 Jun 2022 17:34:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238703AbiF0Rem (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jun 2022 13:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231809AbiF0Rel (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jun 2022 13:34:41 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 359DAAE7B
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 10:34:39 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id h11-20020a17090a130b00b001eca05382e7so3872163pja.9
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 10:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=TbK0NTfQyDmpaeRV4rHROLVzfaksnEF9aDtuDOLF/ng=;
        b=lxOJ3hdwSrXCDIVfyCDZ65VUj4Kxq53BxxwAc2Fr7b3rlz6nRm2e77BBHUbc+FfWqt
         WXgTqnZ5hZrTc4U8DkXTs9wiRjnnieIEoNDw5n3JTW3Nqggpggu48tiuWFTjk4GNr5Bx
         ojZ82SdR6POeMmmiw4hcaUmbnl7ts3I2xp7xjgVt0T5z4G2w1Yv+bqIfgD/as+v/eO0y
         Vy3GpeiGjrE1KMKHC/ff4L3k2XGjVl8/UPK4tpNg98VIzY1WWHPhFT3BX4KrqspYI0fi
         8HB7Kn8X3O2W7PhKNEXVJ3xs3sTqFG3HXOGTzdxvvhCyyxVF/pb/9ZkTFQdMg1gRAvPS
         JQJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=TbK0NTfQyDmpaeRV4rHROLVzfaksnEF9aDtuDOLF/ng=;
        b=J/Ml6tyyqcOiUe2krz2xZzLNDJui5fPrIL2LaaA+95HCt33ms5OKKXKgeHV8MILu8D
         9fAOPu+bvi6jvINjJ00nC/Hrzl3qbIrKUbUK53lD3E3d+KJAkox+Gj/U10x8WScLkWd1
         Xi2q1KJAeKwfpQaG9Zv0V85ER9wvI4dqEBg7tQEnhMl7JoSwyFwHJ7utURB+TzmnX1HK
         DFZIBenZ3WYfwCPAy+6RyWD8C6iaOiHLmExsIH4VuDRXukz3gaEf9pG7IWqfwPtzchs/
         PWPKqGVTOc9rqzJ2wm3BQG5OomJhQPmaafBO03j58lD6BOXEkA027B03ewLoqe2HngFt
         wpNw==
X-Gm-Message-State: AJIora8kkXxe22zEMwr1lAlqgxXS94WQEcZ1rD1vN7Nsn6WQ2leF6tiT
        o/DKkczN3TB683G1NKqSvCSs9PdBcx4htw==
X-Google-Smtp-Source: AGRyM1vBOijv5wy4K4KViLPrXbNpfh2Pvc4gzbYVKA79TMPte9QVYPJtSvsV0o5j8ii8c2WoyxZDUojyfRia/g==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90b:3147:b0:1ee:d3a3:f24f with SMTP
 id ip7-20020a17090b314700b001eed3a3f24fmr538509pjb.1.1656351278310; Mon, 27
 Jun 2022 10:34:38 -0700 (PDT)
Date:   Mon, 27 Jun 2022 10:34:36 -0700
In-Reply-To: <xmqqo7yjz0w4.fsf@gitster.g>
Message-Id: <kl6lbkuehuxf.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <20220622220331.3734584-1-jonathantanmy@google.com>
 <kl6lr13fi9qn.fsf@chooglen-macbookpro.roam.corp.google.com> <xmqqo7yjz0w4.fsf@gitster.g>
Subject: Re: [PATCH v4 0/5] config: introduce discovery.bare and protected config
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Glen Choo via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Glen Choo <chooglen@google.com> writes:
>
>> Jonathan Tan <jonathantanmy@google.com> writes:
>>
>>> "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>>> Glen Choo (5):
>>>>   Documentation/git-config.txt: add SCOPES section
>>>>   Documentation: define protected configuration
>>>
>>> Forgot to mention when I was sending my comments on patch 2: we should
>>> standardize on "protected config" and not use "protected configuration"
>>> anywhere.
>>
>> Makes sense.
>
> Using a single word consistently does make sense, but why favor a
> non-word over a proper word ;-)?

Hm, I guess there's an argument that "config" is a term of art that
specifically refers to things from "git config". From that lens, it's much less
confusing to see the CONFIGURATION section in
Documentation/git-config.txt. But the argument is a little flimsy
because I don't think that's something we've stuck to anywhere.

I'll use "configuration" if it's not too unwieldy.

>> I suppose that the idea behind this is that we only parse and store each
>> config file exactly once. It's a good goal, but the whole point of the
>> configset is that we can query a single struct to figure out the value
>> of a config variable. Having multiple configsets starts to shift more of
>> the burden to the callers because they now have to query multiple
>> configsets to find their desired config value, and we already start to
>> see some of this unpleasantness in this series.
>
> Yes, I was worried about this, too.  "parse and store exactly once"
> may merely be a performance thing, but it still matters, even though
> it is not worse than making duplicate callbacks to overwrite globals
> that have been already set earlier, which will affect correctness ;-)

Exactly.

>> An alternative that I'd been thinking about is to make a few changes to
>> the git_config_* + configset API to allow us to use a single configset
>> for all of our needs:
>>
>> 1. Keep track of what config we've read when reading into
>>    the_repository->config, i.e. instead of a boolean "all config has
>>    been [un]read", we can express "system and global config has been
>>    read, but not local or command config". Then, use this information to
>>    load config from sources as they become available. This will allow us
>>    to read incomplete config for trace2 and setup.c (discovery.bare and
>>    safe.directory), and only read what we need later on.
>
> That is not a bad direction to go, but are we sure that we always
> read in the right order (and there is one single right order) and
> stop at the right step?
>
> config.c::do_git_config_sequence() reads the system and then the
> global before the local, the worktree, and the command line.  We
> would allow the values of "protected" configuration variables to be
> inspected by stopping after the first two and inspecting the result
> before the local and the rest overrides them, but will we need
> *only* that kind of partial configuration reading that stops exactly
> there?  Even with the proposed "protected" scheme, I thought we plan
> to honor the command line ones, so we may need to read
> system+global+command without reading anything else to grab the
> values only from the protected sources (ah, I like the application
> of the adjective "protected" to the source, not variables, because
> that is what we are really talking about---alternatively we could
> call it "safe").  But if we later read local and worktree ones
> lazily, unless we _insert_ them before what we read from the command
> line, we'll break the last-one-wins property, so we need to be
> careful.  I guess each configuration value in the configset knows
> where it came from, so it probably is possible to insert the ones
> you read lazily later in the right spot.

Yeah, last-one-wins makes this a lot trickier. I thought that it would
be nice to have insert-with-priority because that also eliminates some
of the correctness concerns in this series, i.e. that ensures protected
config has the same priority as regular config, but that's a bigger
undertaking and I'm not certain about the performance.

>> 2. Add an additional argument that specifies what scopes to respect when
>>    reading config (maybe as a set of flags). This gives us extra
>>    specificity when using the git_config*() functions, so we could get
>>    rid of git_protected_config() like so:
>>
>>     /* Change enum config_scope into flags first... */
>>
>>     #define WIP_SCOPES_PROTECTED = CONFIG_SCOPE_SYSTEM & \
>>       CONFIG_SCOPE_GLOBAL & CONFIG_SCOPE_COMMAND
>>
>>     static enum discovery_bare_allowed get_discovery_bare(void)
>>     {
>>       enum discovery_bare_allowed result = DISCOVERY_BARE_ALWAYS;
>>       git_config(discovery_bare_cb, &result, WIP_SCOPES_PROTECTED);
>>       return result;
>>     }
>
> Alternatively, we could make the callback aware of the scope for
> each var-value it is called and have it filter, but that would be a
> bigger surgery.
>
> I think a new iterator git_config_in_scope(), instead of updating
> git_config(), would make sense.  By definition, all existing
> git_config() callers do not need the scope specifiers, and
> "protected" may be the first one but will not be the last one that
> needs to read from particular scopes.

Makes sense. The signature of git_config() could stay the same, but we
could refactor it to use git_config_in_scope().
