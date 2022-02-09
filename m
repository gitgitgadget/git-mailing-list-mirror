Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC863C433F5
	for <git@archiver.kernel.org>; Wed,  9 Feb 2022 07:53:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239792AbiBIHxX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Feb 2022 02:53:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234850AbiBIHxW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Feb 2022 02:53:22 -0500
Received: from smtp5-g21.free.fr (smtp5-g21.free.fr [IPv6:2a01:e0c:1:1599::14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C186C0613CB
        for <git@vger.kernel.org>; Tue,  8 Feb 2022 23:53:25 -0800 (PST)
Received: from [192.168.3.156] (unknown [92.173.128.58])
        (Authenticated sender: jn.avila@free.fr)
        by smtp5-g21.free.fr (Postfix) with ESMTPSA id 76EF15FF88;
        Wed,  9 Feb 2022 08:53:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
        s=smtp-20201208; t=1644393203;
        bh=pClC3Hs3rv6YXBVIDmMvoSzFXfbwIbmIjg/qS/puyc8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=dxp+Uhof0vJvSQKRojrb/OiabpoI3UD+sejdqWISVCB76gGlWNoDUs6F9jG/AQf5l
         05/pAqYVQCicQD0qelBCoyEwmSvMDBvcP+W5tmYBPACS6ULS2jCIVf+5/xl0pnN4kq
         cJq/2cTmLcoViAXqJqSr//B9suIgacoCc4QAb1+SLAMzB4/VJvwfUtSIKU6tMr5BIR
         F03gABijx2ad7u7t5aOD+uJJmj6E3iSmX4Z+Ymjpi2bTVBoxnHHCzRVMiHFYNUfBWy
         K/DRvkUM7k7kvsI3kLQk+Tw2XCE/b/JZ+yqFVX01SEH3zkJ1pD4DrwNTfHcCoPxZlA
         QjlhYsey2XoVw==
Message-ID: <9656f568-f5a4-0810-90a2-2ae1ced0e74f@free.fr>
Date:   Wed, 9 Feb 2022 08:53:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v5 5/5] worktree: copy sparse-checkout patterns and config
 on add
Content-Language: fr
To:     Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     sunshine@sunshineco.com, allred.sean@gmail.com, gitster@pobox.com,
        Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.1101.v4.git.1643136134.gitgitgadget@gmail.com>
 <pull.1101.v5.git.1643641259.gitgitgadget@gmail.com>
 <85779dfaed39220e18129e823aff9c95ade5985b.1643641259.git.gitgitgadget@gmail.com>
 <2328375.k9UJiU4Qo1@cayenne> <7d1d3cb5-2bfc-4f82-5230-d4c8d5896649@gmail.com>
From:   =?UTF-8?Q?Jean-No=c3=abl_Avila?= <jn.avila@free.fr>
In-Reply-To: <7d1d3cb5-2bfc-4f82-5230-d4c8d5896649@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Le 07/02/2022 à 15:10, Derrick Stolee a écrit :
> On 2/6/2022 5:36 AM, Jean-Noël AVILA wrote:
>> On Monday, 31 January 2022 16:00:59 CET Derrick Stolee via GitGitGadget wrote:
> 
> Hi Jean-Noël. Thanks for your attention to the translatable messages
> here:
> 
>>> error(_("failed to copy '%s' to '%s'; sparse-checkout may not work correctly"),
>>>        from_file, to_file);
> 
>>> die(_("failed to copy worktree config from '%s' to '%s'"),
>>>      from_file, to_file);
> 
>>> error(_("failed to unset 'core.bare' in '%s'"), to_file);
> 
>>> error(_("failed to unset 'core.worktree' in '%s'"), to_file);
> 
>> In the first patch of this series, you use _("unable to set '%s' in'%s'). Does it make sense to reuse this string here?
> 
> I would argue that "unable to set" is not appropriate for any of these
> messages. Perhaps the "failed to copy" messages might be able to use
> "unable to set", but the information that the config setting is coming
> from settings the user controlled is valuable.
> 
> The "failed to unset" means "we are trying to _remove_ this setting
> from the config file", so "unable to set" does not seem to work here.
> 
> I'm open to revisiting this if you disagree.
> 
> Thanks,
> -Stolee
> 

Hi Derrick,

Sorry for not being more precise. The first two errors were not the 
subject of this remark.

For the last two, this is quite surprising that the same function 
failing (git_config_set_in_file_gently) can lead to different error 
messages.

In any case, I would argue at least for  shifting to :

     error(_("failed to unset '%s' in '%s'"), 'core.bare", to_file);
and
     error(_("failed to unset '%s' in '%s'"), "core.worktree", to_file);

in order to factorize the message and get the option name out of the way.

Thanks,

Jean-Noël
