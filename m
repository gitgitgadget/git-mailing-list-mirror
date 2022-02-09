Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A876FC433EF
	for <git@archiver.kernel.org>; Wed,  9 Feb 2022 17:19:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238070AbiBIRTi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Feb 2022 12:19:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiBIRTg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Feb 2022 12:19:36 -0500
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5D9CC05CB82
        for <git@vger.kernel.org>; Wed,  9 Feb 2022 09:19:38 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8BB8618DEDC;
        Wed,  9 Feb 2022 12:19:36 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=yp4QCBA9lpS0yk62Y8bUKjt9oNN+WqHer6KKSV
        FamYY=; b=Vkzx/DNftgT9aSWesuixaEM3HPb55bVERzuN0V3hmmne85u/cHEykc
        JRPoOPtSJ49DgZ5MSJZdkI8ZSZFS95uK3p5yxcfUahfgc9Fw0P0Yh16i94HtAKlq
        IPlbbw+2biNnBxJ3OPCtorinI//Gu+YhUu0SfhQgvRuHLhsG7qmlA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8320618DEDB;
        Wed,  9 Feb 2022 12:19:36 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E244918DEDA;
        Wed,  9 Feb 2022 12:19:33 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, sunshine@sunshineco.com,
        allred.sean@gmail.com, Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>,
        derrickstolee@github.com, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v6 1/6] Documentation: add extensions.worktreeConfig
 details
References: <pull.1101.v5.git.1643641259.gitgitgadget@gmail.com>
        <pull.1101.v6.git.1644269583.gitgitgadget@gmail.com>
        <0260ff6cac0c76c6d66187d77defef1edd4c6fb5.1644269583.git.gitgitgadget@gmail.com>
        <xmqqo83hatm1.fsf@gitster.g>
        <11bf1541-c46a-fcf5-f8d4-0d144b942d59@gmail.com>
Date:   Wed, 09 Feb 2022 09:19:32 -0800
In-Reply-To: <11bf1541-c46a-fcf5-f8d4-0d144b942d59@gmail.com> (Derrick
        Stolee's message of "Tue, 8 Feb 2022 21:34:35 -0500")
Message-ID: <xmqqmtj09cuz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 731FE7FA-89CC-11EC-ABD6-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

>> +[[def_work_tree]]worktree::
>> +	A repository can have zero (i.e. bare repository) or one or
>> +	more worktrees attached to it. One "worktree" consists of a
>> +	"working tree" and repository metadata, most of which are
>> +	shared among other worktrees of a single repository, and
>> +	some of which are maintained separately per worktree
>> +	(e.g. the index, HEAD, per-worktree refs and per-worktree
>> +	configuration file)
>
> I like this addition, except that I don't understand the "per-worktree
> refs" (other than HEAD). Are there other thins used by features such
> as merge and rebase that would appear as worktree-specific? Of course,
> some state for these operations is stored per-worktree, I just didn't
> know if any were actually "refs".

"per-worktree ref" is an entry in the glossary.

    [[def_per_worktree_ref]]per-worktree ref::
            Refs that are per-<<def_working_tree,worktree>>, rather than
            global.  This is presently only <<def_HEAD,HEAD>> and any refs
            that start with `refs/bisect/`, but might later include other
            unusual refs.

And those other things are also listed as "pseudoref".

    [[def_pseudoref]]pseudoref::
            Pseudorefs are a class of files under `$GIT_DIR` which behave
            like refs for the purposes of rev-parse, but which are treated
            specially by git...

I think the motivation of special casing refs/bisect/ is to allow
use of a separate worktree for bisecting without affecting other
development or another bisection.  The HEAD is singled out in the
description, but MERGE_HEAD and others (pseudoref) that are declared
here to be files under '$GIT_DIR', when we migrate fully to other
backend that may not want to have files under '$GIT_DIR' to
represent them, ought to become per-worktree, for the same reason as
HEAD should be per-worktree, i.e. it allows worktrees to be
independent from each other and have their checkout at different
commits, growing history of different branches in parallel.


