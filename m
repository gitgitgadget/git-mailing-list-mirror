Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 959BFC433EF
	for <git@archiver.kernel.org>; Wed,  9 Feb 2022 02:41:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244771AbiBICk7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Feb 2022 21:40:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244990AbiBICVX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Feb 2022 21:21:23 -0500
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9456FC0613CC
        for <git@vger.kernel.org>; Tue,  8 Feb 2022 18:21:22 -0800 (PST)
Received: by mail-oo1-xc34.google.com with SMTP id o128-20020a4a4486000000b003181707ed40so850945ooa.11
        for <git@vger.kernel.org>; Tue, 08 Feb 2022 18:21:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=u0YPZ0JLC5mnxKAKB4/yD77WvJDL0HcJ1+Zf3LkcBds=;
        b=kO/LccWwfE5xJCqbUeZ9rrbWKMP+jFMDFJIPRu7QhrIl/SXGpVjO1qgU6fSDc3Ua5p
         V649hGnScpJnPLgxfnDZzd0DcoR7Z59jaCXdmb9jathhUf0BGfoWGWIrc1z4Hi3yOgbC
         NoRXCToacnvvEkdewMBYnt6iRHQ6omttGkUKpv8J8PNqYGSdyP1rCvh5ziLZ1XfU863k
         Zgo2HZ3zrnaHLb/ldXFwMu5SF7Gtq+yMBmOWPgy9rIyHZOiBKHFPl0n8XKdvo5SNoJOi
         RtDj6sF7qg4mMyN6CnzZ8TyDuxVK1l64cRb6EJ1Vg0z+ranGF4XizBZ9HLaRw0nkBBtp
         JC4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=u0YPZ0JLC5mnxKAKB4/yD77WvJDL0HcJ1+Zf3LkcBds=;
        b=KrjPfHYkDKyujkXZ3zP1lqw5/tragTTBXfDVgmLo9vFYyShGfO1TwrGysSijN/QSpZ
         Qi0zeimHwms5QypJcKb3YVnKmhM55WoixbB5xOH4oDTiLMgq8YWNGMH+3AeA8M9dzu0M
         RcA7wFEgqRlRRuN2Qnm0hfJ+mBXFDsfvQGbFnVSC8hrZ6YtZIb/gE60DOOXbtZdZrep1
         wziA5dHFlVhP92374W7d2iNwdD6qG0VF4l7opomYHfwuxaLr31HVczjQLGxkdZJAZYB9
         /9AY4ZXV3/7NNCLnHK6i0DHQv2fH8hFNHCgobTHDpe0Oa3lNhu7DSEwPAUrXIbZ6tMdm
         +jmw==
X-Gm-Message-State: AOAM532R1oePqSVlohJk9/U6/zd3igTVroh2/Bwunx7pFHrvm8ZgfN2G
        q4s9UIm//ZJnEPX6nvJ0iho=
X-Google-Smtp-Source: ABdhPJysHLZqfZXDAp3Xdyadx5Dnumn+Y1vj7qoDzLwOiOrOfRzk5mHG78V4Udweyov6mCoPdaOVXg==
X-Received: by 2002:a05:6870:3446:: with SMTP id i6mr253748oah.147.1644373281722;
        Tue, 08 Feb 2022 18:21:21 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:999a:e20e:62a:aacd? ([2600:1700:e72:80a0:999a:e20e:62a:aacd])
        by smtp.gmail.com with ESMTPSA id z4sm5823438otu.24.2022.02.08.18.21.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Feb 2022 18:21:21 -0800 (PST)
Message-ID: <5f7f10df-f048-a663-a98c-536025be0040@gmail.com>
Date:   Tue, 8 Feb 2022 21:21:17 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v6 2/6] worktree: create init_worktree_config()
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
 <5d0cc242d92c68bf239f9e17eab9c80ec6b2d469.1644269583.git.gitgitgadget@gmail.com>
 <xmqq1r0dc8om.fsf@gitster.g>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqq1r0dc8om.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/8/2022 5:09 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> +static int move_config_setting(const char *key, const char *value,
>> +			       const char *from_file, const char *to_file)
>> +{
>> +	if (git_config_set_in_file_gently(to_file, key, value))
>> +		return error(_("unable to set %s in '%s'"), key, to_file);
>> +	if (git_config_set_in_file_gently(from_file, key, NULL))
>> +		return error(_("unable to unset %s in '%s'"), key, from_file);
>> +	return 0;
>> +}
> 
> Interesting.
> 
> The verb "move" in its name made me expect a "get (and remove)
> whatever value(s) defined out of the old file, and set them
> identically in the new file" sequence, but that is not what is done
> here.  "set to this new single value in the new file and unset from
> the old one".

I think this "copy into the worktree-specific config, then remove
from the common file" is an important sequence of events in case a
concurrent process comes in and reads the two config files in the
intermediate state and does not see the config value anywhere.

But perhaps that's not actually what you are concerned about,
because you're saying that the 'value' being provided does not
actually guarantee that we are moving the setting.

> I can see the need to say "move it only when its value is X",
> so having the caller to extract the value before deciding to call
> the function (hence not "moving from old") does make sense, but then
> the function is misnamed---it is not "moving", it is doing something
> else.

I think the end state is correct for all uses here, since we only
run this after checking to see if the config value exists in the
'from_file', so 'value' is correct (and this is a static method,
not a generally-useful method for config.h).

Perhaps a "write_in_new_and_remove_from_old()" would be a better,
if verbose, name. I struggle to find a less cumbersome name, and
"move" seems to match the intent pretty well in the context of its
use.

>> +	common_config_file = xstrfmt("%s/config", r->commondir);
>> +	main_worktree_file = xstrfmt("%s/config.worktree", r->commondir);
>> +
>> +	git_configset_init(&cs);
>> +	git_configset_add_file(&cs, common_config_file);
>> +
>> +	/*
>> +	 * If core.bare is true in the common config file, then we need to
>> +	 * move it to the main worktree's config file or it will break all
>> +	 * worktrees. If it is false, then leave it in place because it
>> +	 * _could_ be negating a global core.bare=true.
>> +	 */
> 
> Is the assumption that the secondary worktrees are never bare, but
> the primary one could be (iow, adding worktrees to a bare repository
> would leave the original bare repository as the primary "worktree"
> that does not have "working tree")?  I am trying to see what downsides
> it tries to avoid by not moving the core.bare==false setting.  Shouldn't
> core.bare be set to false when "worktree add" creates a new one anyway,
> if the secondaries are never bare?

Secondary worktrees cannot be bare. If Git interprets the worktree config
to have core.bare=true in a secondary worktree, it errors out.

You seem to be suggesting that we should explicitly write core.bare=false
into each of the worktree-specific config files. Is that right? This move
is effectively the same, since 'false' is the default.

>> +	if (!git_configset_get_bool(&cs, "core.bare", &bare) && bare) {
>> +		if ((res = move_config_setting("core.bare", "true",
>> +					       common_config_file,
>> +					       main_worktree_file)))
>> +			goto cleanup;
>> +	}
> 
>> +	/*
>> +	 * If core.worktree is set, then the main worktree is located
>> +	 * somewhere different than the parent of the common Git dir.
> 
> OK.  We do not want to share the working tree for the primary worktree
> among secondary worktrees.  For the primary, common and uncommon are
> the same, so it may not matter, but mention of "common Git dir" here
> may confuse readers?  Unless overridden by the config, the parent of
> the git dir is the root of the working tree, no?

Here, the verbal gymnastics are somewhat necessary because secondary
worktrees have a .git _file_, not a git directory, so using "common
Git dir" is a way to explicitly reference the Git dir. And the
strangeness here is exactly that core.worktree can change this working
tree to be something other than the parent of the (common) Git dir.

>> +	 * Relocate that value to avoid breaking all worktrees with this
>> +	 * upgrade to worktree config.
>> +	 */
> 
> And if it is not set, then working tree of each worktree is the
> parent of the per-worktree Git dir, so they will automatically
> become separate, which makes sense.

Thanks,
-Stolee
