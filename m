Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6820D20C11
	for <e@80x24.org>; Tue, 28 Nov 2017 02:40:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753408AbdK1CkS (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Nov 2017 21:40:18 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53389 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753241AbdK1CkR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Nov 2017 21:40:17 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0B294C10CC;
        Mon, 27 Nov 2017 21:40:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LzZFIAn6s6MfAqPIJ+fyUHye5E8=; b=KbRyPo
        N18IpNhmkmPDRKMOMxqp1HZucgR3T4rbLYEp1UXCYjSBPv95zmI4abHMQ0cQaZ2g
        ObOM2bBfi4zFP+RZLUGx/0ufyh/KqyMCYQeRgVF+dysXoG401AnferIqSdJQNk+y
        XdNvfNHbpkfARlNA1tbCN7+qmKFj+dKBG7mpU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=YQFm5eL4VZ5mco5cV+NA3bnk5fkhQop3
        1UoU5JdoCMdW1VIjPodpkVnmL9PvWm3hxHYw5qNpWmF3/DoFSsg6bl2qO/mCZof2
        VWVVPk0InctiEsBrPymEQlH8cgwAD+MTcsZGTeBTWdFusBGzViN0xQfJ1Dw9sDhC
        UiKHpEewQ9Q=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 02CCBC10CB;
        Mon, 27 Nov 2017 21:40:17 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 762D0C10CA;
        Mon, 27 Nov 2017 21:40:16 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] Doc/check-ref-format: clarify information about @{-N} syntax
References: <xmqqpo8dn1jd.fsf@gitster.mtv.corp.google.com>
        <20171127172834.6396-1-kaartic.sivaraam@gmail.com>
        <20171127172834.6396-2-kaartic.sivaraam@gmail.com>
Date:   Tue, 28 Nov 2017 11:40:15 +0900
In-Reply-To: <20171127172834.6396-2-kaartic.sivaraam@gmail.com> (Kaartic
        Sivaraam's message of "Mon, 27 Nov 2017 22:58:34 +0530")
Message-ID: <xmqqd14386sw.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 778FAEF2-D3E5-11E7-84CA-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kaartic Sivaraam <kaartic.sivaraam@gmail.com> writes:

> When the N-th previous thing checked out sytax is used with
> '--branch' option of check-ref-format the results might not
> always be a valid branch name

I wonder if you want to rephrase this, because 40-hex object name is
syntactically a valid branch name.  It's (1) cumbersome to type and
(2) may not be what the user expects.

I have a mild suspicion that "git checkout -B @{-1}" would want to
error out instead of creating a valid new branch whose name is
40-hex that happen to be the name of the commit object you were
detached at previously.

I am not sure if "check-ref-format --branch" should the same; it is
more about the syntax and the 40-hex _is_ valid there, so...
