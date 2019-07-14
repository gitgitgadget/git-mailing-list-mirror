Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AEC0C1F461
	for <e@80x24.org>; Sun, 14 Jul 2019 18:59:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728442AbfGNS7U (ORCPT <rfc822;e@80x24.org>);
        Sun, 14 Jul 2019 14:59:20 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60718 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728125AbfGNS7U (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Jul 2019 14:59:20 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 22988156A73;
        Sun, 14 Jul 2019 14:59:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=j+sq0slf7056uINlvuvCQoADMdQ=; b=GCvK1q
        fY4TOn4LDAQReZXUFzcYVvr2tvm0NROQ1GBoEvkfnVPL5393F3w/2GIYvkd49qMs
        CkBN6bIYSQhh3RwhwKx/zs+dGNVd7YOdAAXDOefXK1X+lELe04y6qQGTAuzlP72O
        dy+KQzBSSBWLj8rkaPchQedcy00aXNdVW+87Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=uVuX8C9xuePB5KxUAj1pVuk8GehWlZQa
        DXkCDjOC7h4G1eK+ljvSMPw0BqGptnUyB7fTA8D+2MOsz9wc605RFt57yuGAelEd
        i3mqDPBI9JhFsjlZ0fjPQt8ykJiY9w6/SFBn546XMPs2qUNoIVWqbknySnXDO8Jd
        lgWy+aKG2FU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1C70A156A72;
        Sun, 14 Jul 2019 14:59:16 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 881AA156A71;
        Sun, 14 Jul 2019 14:59:15 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Edmundo Carmona Antoranz <eantoranz@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH v2] builtin/merge: allow --squash to commit if there are no conflicts
References: <20190713051804.12893-1-eantoranz@gmail.com>
        <CAOc6etb_XFbQWDHg3YRNiskkntS0ro2MYgXCfp6oPv4LutQFGA@mail.gmail.com>
Date:   Sun, 14 Jul 2019 11:59:14 -0700
In-Reply-To: <CAOc6etb_XFbQWDHg3YRNiskkntS0ro2MYgXCfp6oPv4LutQFGA@mail.gmail.com>
        (Edmundo Carmona Antoranz's message of "Fri, 12 Jul 2019 23:27:06
        -0600")
Message-ID: <xmqqblxw5tod.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 79BCCE8C-A669-11E9-822C-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Edmundo Carmona Antoranz <eantoranz@gmail.com> writes:

> One question that I have is if it makes sense to set option_commit
> to 0 if the user didn't specify --commit when using --squash, so
> that the current behavior of git is not broken.  

If you mean that "git merge --squash <other args but not
--[no-]commit>" should behave identically with or without your
patch, then I think the answer is definitely yes.

> Like you run merge --squash, git will stop as it currently
> does... but it would be possible to run with --squash --commit so
> that the revision is created if there are no issues to take care
> of (currently impossible, you would see that message saying "You
> cannot combine --squash with --commit.").

That is exactly a safe way to extend the system by adding a new mode
of operation in a backward compatible fashion.  Good thinking.

