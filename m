Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 70220211B3
	for <e@80x24.org>; Sun,  2 Dec 2018 19:46:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725747AbeLBTqT (ORCPT <rfc822;e@80x24.org>);
        Sun, 2 Dec 2018 14:46:19 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63778 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbeLBTqS (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Dec 2018 14:46:18 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C022219213;
        Sun,  2 Dec 2018 14:46:16 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3X2NijwSwgp2VoOqcP/GYV3w/g8=; b=fEn8di
        SeAQhjuWx2PTjKpGHhB2Fl2sUFF46sJBboXxmPx6gDZHRg6zi3bCOunSgOSt1kR9
        S8IUZg1LLOZWvmCXNDeVy3bSkug411hXh+Fpuoi3YEzsesR8cxTp836K94pBdcsf
        yJWwDB7C7h0IT8Fd2iIe6dInxYN5twhhiYH84=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=iGvOYYChOnJMryFC6iKtUv3kApiih968
        Hnv6Vs346arhs9TVDGZp8ITeWowAH3zST5b2m5j/H18z97hc3BoWdbeEu1+zTl32
        dsD5t0PJQnJJ2DFMNGMUw0vAx4TDUPQO0mICFOtCYaCyZXSA4WcC06C+RF2+AZO3
        dpzVBSFdnAs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B8C7C19212;
        Sun,  2 Dec 2018 14:46:16 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.187.50.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id CF28E19211;
        Sun,  2 Dec 2018 14:46:13 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        avarab@gmail.com, git@vger.kernel.org, sbeller@google.com,
        sxenos@google.com
Subject: Re: [PATCH/RFC v3 00/14] Introduce new commands switch-branch and restore-files
References: <20181127165211.24763-1-pclouds@gmail.com>
        <20181129215850.7278-1-pclouds@gmail.com>
        <xmqqefb3mhrs.fsf@gitster-ct.c.googlers.com>
        <20181202185838.GN4883@hank.intra.tgummerer.com>
Date:   Mon, 03 Dec 2018 04:46:11 +0900
In-Reply-To: <20181202185838.GN4883@hank.intra.tgummerer.com> (Thomas
        Gummerer's message of "Sun, 2 Dec 2018 18:58:38 +0000")
Message-ID: <xmqqbm63iuf0.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: ED0A4806-F66A-11E8-B356-CC883AD79A78-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

> Agreed, I think --{no-,}overlay is a much better name for the option,
> I'll use that for my patch series (I hope to send that soon after 2.20
> is released).

OK.

> I must admit that I was not aware that the mode is called overlay
> mode, before you explained it to me, so I wouldn't expect most users
> to know either.  But as it's easy to explain that probably doesn't
> matter much.

I do not think "the mode is called the overlay mode" is so accurate
a description.  I think I've seen the word 'overlay' used to
describe the behaviour in earlier discussions, but because there is
no 'non-overlay' mode exists in versions of 'git checkout' the
end-users have, the users won't even be aware of the possibility
that mode different from what they are used to see could exist, or
that the mode that they are used to see could be called/explained as
the 'overlay' mode.  IOW, we should pick the best phrase to explain
the behaviour we can use when coming up with the command line
option, and that phrase does not have to be 'overlay'---there is no
"using the word 'overlay' for this is good because the users are
familiar with the existing use of the word", simply because there
isn't such familiarilty ;-)
