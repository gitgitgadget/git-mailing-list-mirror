Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EC9EC4741F
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 01:43:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E49B92065D
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 01:43:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="WX2dugd7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730480AbgKJBnq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Nov 2020 20:43:46 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53045 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbgKJBnk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Nov 2020 20:43:40 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 370BD94047;
        Mon,  9 Nov 2020 20:43:38 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KQNA2VipPQlEnbX/eux8L8l3uho=; b=WX2dug
        d7SYfYu/j14b5TGsound3YxIu9jPvlhchJf2eEV6w94eWakfS9Ywf6x6hE4gj8TQ
        T3CteSacPXvX640bYdi+MH1V3KApx8aYRVmXolgD5heHarn9lCcSiCrhelTcB7Dk
        MMdr7Diqy3Rfu61q/UE85mSWuCrA9epgTodCs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=JWMU/+294tRo8jG/6gu5eUj/iJHjP+M6
        ODcMOQBPeWpjBFZ7FngK502mqOoLXRyY0qRqE34y6+psKii982LAoKhI3wsEWowO
        XOz4n2hIP4RrC/RL1lqWcOKl1bi7wJYbcW7vwZblNZHOFi+FQNCRQUOEVYZ1MIIs
        uTPsgPS84fc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2E78694045;
        Mon,  9 Nov 2020 20:43:38 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A607F94040;
        Mon,  9 Nov 2020 20:43:37 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Hu Keping <hukeping@huawei.com>, zhengjunling@huawei.com,
        zhuangbiaowei@huawei.com, Patrick Hemmer <git@stormcloud9.net>,
        Rafael Ascensao <rafa.almas@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v2] format-patch: make output filename configurable
References: <20201105201548.2333425-1-hukeping@huawei.com>
        <20201105150149.GA107127@coredump.intra.peff.net>
        <xmqqimajijwa.fsf@gitster.c.googlers.com>
        <xmqqwnyydxaw.fsf@gitster.c.googlers.com>
        <xmqqo8kadu9j.fsf_-_@gitster.c.googlers.com>
        <CAPig+cQAreDJn_tS_K4sR9HwsSVNoFid9sWSdxzwSqkJLRidgQ@mail.gmail.com>
        <xmqqwnyubagr.fsf@gitster.c.googlers.com>
        <20201110002312.GA1267848@coredump.intra.peff.net>
Date:   Mon, 09 Nov 2020 17:43:37 -0800
In-Reply-To: <20201110002312.GA1267848@coredump.intra.peff.net> (Jeff King's
        message of "Mon, 9 Nov 2020 19:23:12 -0500")
Message-ID: <xmqqzh3q7zqu.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 270744FA-22F6-11EB-B8FC-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Mon, Nov 09, 2020 at 11:23:48AM -0800, Junio C Hamano wrote:
>
>> @@ -1822,6 +1825,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
>>  	init_display_notes(&notes_opt);
>>  	git_config(git_format_config, NULL);
>>  	repo_init_revisions(the_repository, &rev, prefix);
>> +	rev.subject_prefix = fmt_patch_subject_prefix;
>>  	rev.show_notes = show_notes;
>>  	memcpy(&rev.notes_opt, &notes_opt, sizeof(notes_opt));
>>  	rev.commit_format = CMIT_FMT_EMAIL;
>> @@ -1831,7 +1835,6 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
>>  	rev.diff = 1;
>>  	rev.max_parents = 1;
>>  	rev.diffopt.flags.recursive = 1;
>> -	rev.subject_prefix = fmt_patch_subject_prefix;
>>  	memset(&s_r_opt, 0, sizeof(s_r_opt));
>>  	s_r_opt.def = "HEAD";
>>  	s_r_opt.revarg_opt = REVARG_COMMITTISH;
>
> It's not clear to me what these hunks are doing. I'm trying really hard
> to find some subtle reason that we need to init this field sooner, but I
> can't. It really looks like it might be leftover noise.

It indeed was leftover noise and has nothing to do with the output
filename length configurablility (I suspect it is a true no-op).

Thanks.


