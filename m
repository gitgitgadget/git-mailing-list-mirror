Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A53DAC433F5
	for <git@archiver.kernel.org>; Tue, 28 Dec 2021 15:03:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234911AbhL1PDL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Dec 2021 10:03:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232601AbhL1PDK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Dec 2021 10:03:10 -0500
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3D2AC061574
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 07:03:10 -0800 (PST)
Received: by mail-oo1-xc2a.google.com with SMTP id q14-20020a056820028e00b002da9808b90fso6118548ood.7
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 07:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=WEA6h4q9roRZW+5pEFS3mIwU81TGFYyIwbFhJntbt88=;
        b=Upy+g5ndkQWNB3Gps4L4ljllbrFsz+pBPnPrjsGK/0LzQr0U3xZHsrIRd/1Il1l2EH
         swfn4I2BMeOFaeCasWX/bn3d+9CyviMMWNej070f4/JjYTh7mQRIp9T+yA8B8iK70fA9
         t1/Z9t9j54ESdp7YUOnGAwe4osNVRO/WwfvFIqNJZ9kygUg36bNL00U5Dg/Y2PdjjmeD
         k2P/yvNgYRzxoXJlArEP91mI4ZyMyC11jTElmLrKS+xSyABvZmc/I/9yPnYvIv+tY5xF
         i1QlFe9ELhKHCsHsVGr+v6guGpl7iKEhBwMI2j05Feo8ld9/DwthlWlmhRqo7su4cQY1
         lafQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=WEA6h4q9roRZW+5pEFS3mIwU81TGFYyIwbFhJntbt88=;
        b=E4hY2sqVFMKHL6pxr5nCNBWNrexJOmqf3pNh3a/7ZqoL5/tjKZedDs4CTCh1gGWu6e
         IJOtRrcX0cmaphNx9SCzysPNR/TZC05UXd7EODZlLOzZaFk6qas5fIUr3qUET4f1QsRT
         5y2age+uAxKn97BFMPANXSsA55hb1CB+tTZnHcNX1S/cuWf5tcYhruGfo8Qs11HYrucc
         btm/WipaI53xqr4qLlhkmKlyB2dPO8LciPqZ57kmeeqPZUSt4Q5RS/swGIotJrrVjoQF
         mnlBBPyzbprtaT7S9Y28RFpcVTQuWTkBaUfKUvJi48qvyww9MiJvBMNCyuJv+lRxD8Qx
         yfZw==
X-Gm-Message-State: AOAM531DXMrA2XB6oqlH/i8spkIzh8tp2ReJihPmLaPwP5+TweOLG9kI
        fDlLNxwUOS5k2vrmgzItR4M=
X-Google-Smtp-Source: ABdhPJyZEsFfrLEUFhsS9WlyImkVUeclRtajrfhaYKlNgdM91REQkUMudy5Ov+QBEH6QLedrRAnxyw==
X-Received: by 2002:a4a:6f06:: with SMTP id h6mr13557337ooc.92.1640703789680;
        Tue, 28 Dec 2021 07:03:09 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:a8af:d265:ced5:e098? ([2600:1700:e72:80a0:a8af:d265:ced5:e098])
        by smtp.gmail.com with ESMTPSA id g17sm3900245oiy.14.2021.12.28.07.03.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Dec 2021 07:03:09 -0800 (PST)
Message-ID: <53f3531d-29ee-f16e-1d60-21ca7b4a3fbd@gmail.com>
Date:   Tue, 28 Dec 2021 10:03:03 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v2 3/5] worktree: add upgrade_to_worktree_config()
Content-Language: en-US
To:     Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Sean Allred <allred.sean@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.1101.git.1640015844.gitgitgadget@gmail.com>
 <pull.1101.v2.git.1640114048.gitgitgadget@gmail.com>
 <ed8e2a7b19d236642b3b8d3a49d017d29753db56.1640114048.git.gitgitgadget@gmail.com>
 <CAPig+cQrJ9yWjkc8VMu=uyx_qtrXdL3cNnxLVafoxOo6e-r9kw@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <CAPig+cQrJ9yWjkc8VMu=uyx_qtrXdL3cNnxLVafoxOo6e-r9kw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/21/2021 7:45 PM, Eric Sunshine wrote:
> On Tue, Dec 21, 2021 at 2:14 PM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>> Some features, such as the sparse-checkout builtin, require using the
>> worktree config extension. It might seem simple to upgrade the
>> repository format and add extensions.worktreeConfig, and that is what
>> happens in the sparse-checkout builtin.
>>
>> Transitioning from one config file to multiple has some strange
>> side-effects. In particular, if the base repository is bare and the
>> worktree is not, Git knows to treat the worktree as non-bare as a
>> special case when not using worktree config. Once worktree config is
>> enabled, Git stops that special case since the core.bare setting could
>> apply at the worktree config level. This opens the door for bare
>> worktrees.
> 
> It would be a good idea to drop the final sentence since there is no
> such thing as a bare worktree (either conceptually or practically),
> and end the first sentence at "case": i.e. "... stops that special
> case."

Bare worktrees don't exist, that is correct. But if one existed it
would be a directory where you could operate as if it is a bare repo,
but it has its own HEAD different from the base repo's HEAD. Not sure
why one would want it.

I guess the question is: what happens if someone writes core.bare=true
into their worktree config? A question to resolve another day, perhaps.
 
>> To help resolve this transition, create upgrade_to_worktree_config() to
>> navigate the intricacies of this operation. In particular, we need to
>> look for core.bare=true within the base config file and move that
>> setting into the core repository's config.worktree file.
>>
>> To gain access to the core repository's config and config.worktree file,
>> we reference a repository struct's 'commondir' member. If the repository
>> was a submodule instead of a worktree, then this still applies
>> correctly.
> 
> I'm not sure how much this commit message is going to help someone who
> did not participate in the discussion which led to this patch series.
> I think the entire commit message could be written more concisely like
> this:

Good suggestions to add the necessary context here. Thanks.

>     worktree: add helper to upgrade repository to per-worktree config
> 
>     Changing a repository to use per-worktree configuration is a
>     somewhat involved manual process, as described in the
>     `git-worktree` documentation, but it's easy to get wrong if the
>     steps are not followed precisely, which could lead to odd
>     anomalies such as Git thinking that a worktree is "bare" (which
>     conceptually makes no sense). Therefore, add a utility function to
>     automate the process of switching to per-worktree configuration
>     for modules which require such configuration. (In the future, it
>     may make sense to also expose this convenience as a `git-worktree`
>     command to automate the process for end-users, as well.)
> 
>     To upgrade the repository to per-worktree configuration, it performs
>     these steps:
> 
>     * enable `extensions.worktreeConfig` in .git/config
> 
>     * relocate `core.bare` from .git/config to .git/config.worktree
>       (if key exists)
> 
>     * relocate `core.worktree` from .git/config to
>       .git/config.worktree (if key exists)
> 
>     It also upgrades the repository format to 1 if necessary since
>     that is a prerequisite of using `extensions`.
> 
>> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
>> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
>> ---
>> diff --git a/worktree.c b/worktree.c
>> @@ -830,3 +831,49 @@ int should_prune_worktree(const char *id, struct strbuf *reason, char **wtpath,
>> +int upgrade_to_worktree_config(struct repository *r)
>> +{
>> +       int res;
>> +       int bare = 0;
>> +       struct config_set cs = { 0 };
> 
> This function is doing a lot of unnecessary work if per-worktree
> configuration is already enabled. The very first thing it should be
> doing is checking whether or not it actually needs to do that work,
> and short-circuit if it doesn't. I would think that simply checking
> whether `extensions.worktreeConfig` is true and returning early if it
> is would be sufficient.

That would be good. I originally erred on the side of least complicated
but slower because this is not run very often.

>> +       char *base_config_file = xstrfmt("%s/config", r->commondir);
> 
> If we look at path.c:strbuf_worktree_gitdir(), we see that this should
> be using `r->gitdir`, not `r->commondir`.
> 
>> +       char *base_worktree_file = xstrfmt("%s/config.worktree", r->commondir);
> 
> Per path.c:strbuf_worktree_gitdir(), this use of `r->commondir` is
> correct. Good.
> 
> Can we use more meaningful variable names? It's not at all clear what
> "base" means in this context (I don't think it has any analog in Git
> terminology). Perhaps name these `shared_config` and `repo_config`,
> respectively.

'repo_config' is too generic, because I want the worktree config for
the "original" repo. I chose to call that the "base" repo and its
worktree config. Shared_config is a good name, though.

>> +       git_configset_init(&cs);
>> +       git_configset_add_file(&cs, base_config_file);
>> +
>> +       /*
>> +        * If the base repository is bare, then we need to move core.bare=true
>> +        * out of the base config file and into the base repository's
>> +        * config.worktree file.
>> +        */
> 
> Here, too, it's not clear what "base" means. I think you want to say
> that it needs to "move `core.bare` from the shared config to the
> repo-specific config".

Yes, but specific to the original/root/bare repo. I'm open to preferences
here, but "repo" isn't specific enough.

>> +       if (!git_configset_get_bool(&cs, "core.bare", &bare) && bare) {
>> +               if ((res = git_config_set_in_file_gently(base_worktree_file,
>> +                                                       "core.bare", "true"))) {
>> +                       error(_("unable to set core.bare=true in '%s'"), base_worktree_file);
>> +                       goto cleanup;
>> +               }
>> +
>> +               if ((res = git_config_set_in_file_gently(base_config_file,
>> +                                                       "core.bare", NULL))) {
>> +                       error(_("unable to unset core.bare=true in '%s'"), base_config_file);
>> +                       goto cleanup;
>> +               }
>> +       }
> 
> This seems unnecessarily complicated and overly specific, thus
> potentially confusing. The requirements laid out in git-worktree.txt
> say only to move the configuration key from .git/config to
> .git/config.worktree; it doesn't add any qualifiers about the value
> being "true". And, indeed, we should not care about the value; it's
> immaterial to this operation. Instead, we should just treat it
> opaquely and relocate the key and value from .git/config (if it
> exists) to .git/config.worktree without interpretation.
> 
> The error messages are too specific, as well, by mentioning "true".
> They could instead be:
> 
>     unable to set `core.bare` in '%s'
> 
> and
> 
>     unable to remove `core.bare` from '%s'
> 
> However, there is a much more _severe_ problem with this
> implementation: it is incomplete. As documented in git-worktree.txt
> (and mentioned several times during this discussion), this utility
> function _must_ relocate both `core.bare` _and_ `core.worktree` (if
> they exist) from .git/config to .git/config.worktree. This
> implementation neglects to relocate `core.worktree`, which can leave
> things in quite a broken state (just as neglecting to relocate
> `core.bare` can).

It took me a long time to actually understand the purpose of
core.worktree, since it seems in conflict with the 'git worktree'
feature. Indeed, it is special-cased the same way core.bare is, so
this relocation is required.

>> +       if (upgrade_repository_format(r, 1) < 0) {
>> +               res = error(_("unable to upgrade repository format to enable worktreeConfig"));
>> +               goto cleanup;
>> +       }
>> +       if ((res = git_config_set_gently("extensions.worktreeConfig", "true"))) {
>> +               error(_("failed to set extensions.worktreeConfig setting"));
>> +               goto cleanup;
>> +       }
> 
> The order in which this function performs its operations can leave the
> repository in a broken state if any of the steps fails. For instance,
> if setting `extensions.worktreeConfig=true` fails _after_ you've
> relocated `core.bare` (and `core.worktree`) to .git/config.worktree,
> then those configuration values will no longer be "active" since the
> config system won't consult .git/config.worktree without
> `extensions.worktreeConfig` enabled.
> 
> To be resilient against this sort of problem, you should perform the
> operations in this order:
> 
> (1) upgrade repository format to 1
> (2) enable `extensions.worktreeConfig`
> (3) relocate `core.bare` and `core.worktree`

This order can still cause some issues, specifically the worktree will
still think it is bare or the core.worktree value is incorrect, but that
is less serious than a broken base repo.

>> +cleanup:
>> +       git_configset_clear(&cs);
>> +       free(base_config_file);
>> +       free(base_worktree_file);
>> +       trace2_printf("returning %d", res);
> 
> Is this leftover debugging or intentional?

Leftover debugging. Thanks for catching.

Thanks,
-Stolee
