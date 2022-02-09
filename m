Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FA1CC433F5
	for <git@archiver.kernel.org>; Wed,  9 Feb 2022 18:43:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240416AbiBISnC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Feb 2022 13:43:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240480AbiBISmS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Feb 2022 13:42:18 -0500
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B435C0401EA
        for <git@vger.kernel.org>; Wed,  9 Feb 2022 10:41:53 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 96479FCEE9;
        Wed,  9 Feb 2022 13:41:52 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Z7SuEpoxbTNPmr1Cgwpcfyg2ld49hCQdax1yPh
        rRIxc=; b=njBpoE5hEw1KYuxJtK/yOehMgpHvZedB2ARRvckWrDSpY6t9jx3Iog
        LDsTizTWq9crP2h3wBuw4zoy0cB+8aTLQuEe2bIdGy4BnqNnFuXdiI8EMYmC7xhn
        OPooRATnzqGJNPI5zgcxOxcAfCzG2893EiJS8xuEdwyyOTliZkh34=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8DEF7FCEE8;
        Wed,  9 Feb 2022 13:41:52 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 03F5BFCEE7;
        Wed,  9 Feb 2022 13:41:51 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Sean Allred <allred.sean@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v6 1/6] Documentation: add extensions.worktreeConfig
 details
References: <pull.1101.v5.git.1643641259.gitgitgadget@gmail.com>
        <pull.1101.v6.git.1644269583.gitgitgadget@gmail.com>
        <0260ff6cac0c76c6d66187d77defef1edd4c6fb5.1644269583.git.gitgitgadget@gmail.com>
        <xmqqo83hatm1.fsf@gitster.g>
        <CABPp-BGj7DZY8D-Ps3fhcRik_gSGoDyoFokuUMRN_Q7Z2cbEfw@mail.gmail.com>
Date:   Wed, 09 Feb 2022 10:41:50 -0800
In-Reply-To: <CABPp-BGj7DZY8D-Ps3fhcRik_gSGoDyoFokuUMRN_Q7Z2cbEfw@mail.gmail.com>
        (Elijah Newren's message of "Wed, 9 Feb 2022 10:04:07 -0800")
Message-ID: <xmqqr18b7uhd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F2759170-89D7-11EC-AAFB-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

>>  [[def_per_worktree_ref]]per-worktree ref::
>> -       Refs that are per-<<def_working_tree,worktree>>, rather than
>> +       Refs that are per-<<def_worktree,worktree>>, rather than
>>         global.  This is presently only <<def_HEAD,HEAD>> and any refs
>>         that start with `refs/bisect/`, but might later include other
>>         unusual refs.
>> @@ -669,3 +669,12 @@ The most notable example is `HEAD`.
>>         The tree of actual checked out files.  The working tree normally
>>         contains the contents of the <<def_HEAD,HEAD>> commit's tree,
>>         plus any local changes that you have made but not yet committed.
>> +
>> +[[def_work_tree]]worktree::
>> +       A repository can have zero (i.e. bare repository) or one or
>> +       more worktrees attached to it. One "worktree" consists of a
>> +       "working tree" and repository metadata, most of which are
>> +       shared among other worktrees of a single repository, and
>> +       some of which are maintained separately per worktree
>> +       (e.g. the index, HEAD, per-worktree refs and per-worktree
>> +       configuration file)
>
> We could also add pseudorefs to the list of things maintained
> separately in the final parenthetical comment, but otherwise looks
> good.

I think what needs updating is the per_worktree_ref section.  Before
we say "later include other unusual refs", not so unusual pseudorefs
can be mentioned there.
