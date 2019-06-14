Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3EA3E1F462
	for <e@80x24.org>; Fri, 14 Jun 2019 15:58:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725826AbfFNP6M (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Jun 2019 11:58:12 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50641 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbfFNP6M (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jun 2019 11:58:12 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 093CD68744;
        Fri, 14 Jun 2019 11:58:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7Yx5sMxHMCEroF7DjaRb4oBYGfw=; b=P0LGrg
        ZJZ4vdG0Jb+pyalx84vpgwQxELlxGa6ZQNec1Ayw9faV+0Zw4kAPjhmFT9JkWFDh
        spoJUZ/5AH+ZD8lLcbhpcrdANJdz4mkNE7LEYusITSblhlsCrC9D1MGQWEEfAKqV
        oSqDoynXH4fUEubRc1SMiyBxMMkT0YzWhYQ8I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=MV291eeg7jlavcBqHDBNKQZbGrQx1rSh
        RE42tvM11J2+onYj0mi907I6uhtvOZGi8VFdGXTF/Kd4FdZ4Q0DkGuWLmNho39bw
        jtqIVF/PHSpMwyyav507mlM/ANRrDaYGZtc/tcUwugcp7wonOQ3VadHZPbE1I8X9
        ZymRaMzYJGA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 020BC68743;
        Fri, 14 Jun 2019 11:58:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 24BF968742;
        Fri, 14 Jun 2019 11:58:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Cc:     git@vger.kernel.org, newren@gmail.com, phillip.wood123@gmail.com,
        t.gummerer@gmail.com
Subject: Re: [GSoC][PATCH v3 2/3] cherry-pick/revert: add --skip option
References: <xmqqa7elwer9.fsf@gitster-ct.c.googlers.com>
        <20190614034554.19364-1-rohit.ashiwal265@gmail.com>
Date:   Fri, 14 Jun 2019 08:58:04 -0700
In-Reply-To: <20190614034554.19364-1-rohit.ashiwal265@gmail.com> (Rohit
        Ashiwal's message of "Fri, 14 Jun 2019 09:15:54 +0530")
Message-ID: <xmqqd0jgupkj.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 33460554-8EBD-11E9-92D0-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rohit Ashiwal <rohit.ashiwal265@gmail.com> writes:

>> Is this correct, or do we need to enclose these choices inside (),
>> i.e.
>> 
>> 	'git cherry-pick' ( --continue | --skip | --abort | --quit )
>> 
>> ?
>
> Documentation of `git rebase` also lists these options without the
> '('s so, I thought to make it similar to that.

As long as you picked the ones that correctly spell their SYNOPSIS,
it is OK to model yours after them.

Seeing how "git-am.txt", "git-cat-file.txt", "git-checkout.txt", ...
"git-var.txt" etc. all use

	( choice1 | choice2 | choice3 )

when one among the choices MUST be chosen, contrasting with

	[ choice1 | choice2 | choice3 ]

when one can be chosen but not using any is also OK, I am not sure
if the documentation for "git rebase" is done right and should be
used as a model, though.
