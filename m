Return-Path: <SRS0=G+/Y=3C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A21FC33CA9
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 22:03:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FE792072B
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 22:03:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="t7pC3zT7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728953AbgAMWD0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jan 2020 17:03:26 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60944 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728950AbgAMWDZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jan 2020 17:03:25 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4011F18ED1;
        Mon, 13 Jan 2020 17:03:22 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+cc87UypT0ohI0sjsz7rnXPvsRQ=; b=t7pC3z
        T76O6DuX0O28Q7H6Tsro5EN5X6mewo147kDwXU8eX2nRN3IwC3AsGEPuJvJkrNHk
        i8lWx6xsqX9SzEhnz5VPGsBHyCOwAJD6XVWfvc7WOflL0iJbIycpmc8cabGOd/jg
        XQkUPgHFoFfzcxHC9F7/OaTJnWHVhgJt+cWbY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=TuyMEt/o7qBZ1jmIJpr5OgIhcrPsorFh
        RO8D6t4Dx8CVBREZHz6C00O0/QFdpvxuStrZUttFzg6An6wIURAv+lBc1wnxiFeG
        3pox99oeDcN+iQoKOLXqCUHHsNemv48HAV5kGx3k9Hdn/BhDusaD0kCdX1BiF4qh
        PP+9lp16p/o=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 31E6B18ED0;
        Mon, 13 Jan 2020 17:03:22 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 99F3018ECF;
        Mon, 13 Jan 2020 17:03:21 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: "rebase -ri" (was Re: Problems with ra/rebase-i-more-options - should we revert it?)
References: <f2fe7437-8a48-3315-4d3f-8d51fe4bb8f1@gmail.com>
        <089637d7-b4b6-f6ba-cce1-29e22ce47521@gmail.com>
        <xmqqeew4l6qf.fsf@gitster-ct.c.googlers.com>
        <xmqq5zhgkwxx.fsf@gitster-ct.c.googlers.com>
        <xmqqy2ubjkeo.fsf@gitster-ct.c.googlers.com>
Date:   Mon, 13 Jan 2020 14:03:20 -0800
In-Reply-To: <xmqqy2ubjkeo.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Mon, 13 Jan 2020 10:11:59 -0800")
Message-ID: <xmqqpnfnj9p3.fsf_-_@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 834E7690-3650-11EA-97CB-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> I will push out what I wish to be able to tag as the final [*1*]
>> shortly but without actually tagging, so that it can get a bit wider
>> exposure than just the usual "Gitster tested locally and then did
>> let Travis try them" testing.
>
> I haven't heard from any failure report so (taking no news as good
> news) I'll cut the final today based on what is already on the
> public repositories everywhere.

By the way, as one of the methods to double check that my result of
reverting the merge made sense, I ran "git rebase -ri v2.24.0 pu"
and excised the merge and the problematic topic out of the todo
list.  With the rerere database populated beforehand, it was more or
less a painless exercise (except for one topic, en/rebase-backend,
which is one of the topics that was queued forking 'master' after
the topic got merged *and* actually depended on what the topic did)
and after about 1700+ steps (which did not take more than 20
minutes, including the time spent for the manual rebasing of
en/rebase-backend topic) I got the same tree for 'pu' I pushed out
last night.

One thing I noticed that "rebase -ri" could be taught to handle
better was that the side branches that were merged to the final
result did not get relabeled.  Those merges that appear on the first
parent chain leading to 'pu' call themselves as "Merge branch 'blah'"
and many of them (i.e. the ones that forked before the merge of the
topic getting excised from the mainline) did just merge the tip of
the named branch without touching the commits on the side branch,
but some branches did have to be rebased, but their tips did not get
updated (only the tentative rewritten/<topic> labels were pointing
at the updated tip during the rebase, which are of course discarded
after we are done).

But other than that, it was quite nice.

It is less transparent (at least to me) and probably less efficient
than the current workflow to rebuild 'pu' for a few times every day
("less efficient" is primarily because the established workflow is
quite optimized to the way I work), so it is not likely for me to
switch to "rebase -ri" any time soon.  But it makes me feel safe to
know that there is another tool I can use to double-check the result
of everyday workflow.

Thanks.
