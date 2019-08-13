Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8983F1F45A
	for <e@80x24.org>; Tue, 13 Aug 2019 21:46:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbfHMVqA (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Aug 2019 17:46:00 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54938 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbfHMVqA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Aug 2019 17:46:00 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 15FC115C829;
        Tue, 13 Aug 2019 17:45:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Ea9R4Qu9onfXthQLkhfCNi8Bvyc=; b=wYzsKr
        BXh9CWNVNoIddSjrrUSRhzD1oRt6LHjJaG/kp0PhXwqgr2EEmfJxLe3bqrYBP5/s
        l0eq+UJHHU5rRtui9Wi3it6kZuxMftDdVD822JjiEel13yu6lUsr9dSGF6IqzXkW
        dJ46g+/XuLK6ZcSiOuozRw/sXJEvd1Bm6F0+E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=dxs0AG2ddlM+DfzToogXq+grlTGrjzOS
        CvAw8vkcOYuINd4sOh5Ycf1wUWd5t/7rU4Vq8RNx2pMCXN/sS6ueG14KBgGwA8z6
        WfNW36oovqwvrGONEvnBpZRm4m9VQg/JqAbF7GfuGidHj5E3krxWcGFwcMaZgYuB
        x3RPV+KMNlQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0A73815C828;
        Tue, 13 Aug 2019 17:45:58 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6B12415C827;
        Tue, 13 Aug 2019 17:45:57 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org,
        martin.agren@gmail.com, newren@gmail.com,
        phillip.wood123@gmail.com, t.gummerer@gmail.com
Subject: Re: [GSoC][PATCH v2 5/6] rebase -i: support --ignore-date
References: <20190806173638.17510-1-rohit.ashiwal265@gmail.com>
        <20190812194301.5655-1-rohit.ashiwal265@gmail.com>
        <20190812194301.5655-6-rohit.ashiwal265@gmail.com>
Date:   Tue, 13 Aug 2019 14:45:56 -0700
In-Reply-To: <20190812194301.5655-6-rohit.ashiwal265@gmail.com> (Rohit
        Ashiwal's message of "Tue, 13 Aug 2019 01:12:59 +0530")
Message-ID: <xmqqblws7n8r.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BBB84872-BE13-11E9-A081-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rohit Ashiwal <rohit.ashiwal265@gmail.com> writes:

>  --ignore-date::
> -	This flag is passed to 'git am' to change the author date
> -	of the rebased commits (see linkgit:git-am[1]).
> +	Instead of using the given author date, re-set it to the value
> +	same as committer (current) date. This implies --force-rebase.

s/to the value same as .* date\./the current time./;

The more important thing is that we record the current timestamp as
the author date; that timestamp being very close to the committer
date of the resulting commit is a mere consequence of the fact that
we use the current time for committer date and much less important.

Again, I think reset-author-date would be a better synonym to this
one.

