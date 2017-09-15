Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 520FA20281
	for <e@80x24.org>; Fri, 15 Sep 2017 20:53:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751616AbdIOUxQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Sep 2017 16:53:16 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56403 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751556AbdIOUxP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Sep 2017 16:53:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 25099AD34F;
        Fri, 15 Sep 2017 16:53:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=t6JRbpxHNGfZtKF7N1OPPRe2TZk=; b=dLvIwG
        Roeio/T/nBCMqWmu1dHhayudBroajs5zsO1jZOVG+Xs2VmzchHPaNhVsO7PMXXLG
        73KyBlOmQbAlG9te48Z3Z92FZMqUNAF2fY7flUquySaS5UkuJ/Yrouv68pdonaKx
        UIYCdXNzWSOKBXoMdpKA0qwEv9SVsLt8u6Gho=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=D3SJ1u3u+bK4TexSWcjso9gCwm9LHVJ+
        5IZzpDZBMpYs5xxz2NT2CGuPGQLJeLNyHjTTmG3drU23fOVaBSTildvyL6vudVVi
        0lqyIDOW2OaCzhqayzqP7N1O3u09ymNEOe9mWCwhDTbiFHaYO0HVAFhMJRoYeXC+
        54j9JwkqYp0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1D326AD34E;
        Fri, 15 Sep 2017 16:53:15 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7C1DCAD34D;
        Fri, 15 Sep 2017 16:53:14 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Joseph Dunne <jdunne525@gmail.com>
Cc:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: commit-msg hook does not run on merge with --no-ff option
References: <CAC7pkbQhwLFQQjqBwaW=0j4iKFcLdKDucCMck-PsSAeCs0rqpw@mail.gmail.com>
        <CAGZ79kZLvAgSgckQ7Doo_E7aY+L6xtv2Kq0xbO6GSZL5ZAb7TQ@mail.gmail.com>
        <CAC7pkbQwn8pvLLCtjsEkKo7PJozycdDbnq2XLWbmOm_KHEjU-w@mail.gmail.com>
        <1505440235.1862.9.camel@gmail.com>
        <CAC7pkbREUZxG0drWVpV43TFv7AVi2agJkRtXZgNsLErk3iBc-w@mail.gmail.com>
Date:   Sat, 16 Sep 2017 05:53:13 +0900
In-Reply-To: <CAC7pkbREUZxG0drWVpV43TFv7AVi2agJkRtXZgNsLErk3iBc-w@mail.gmail.com>
        (Joseph Dunne's message of "Fri, 15 Sep 2017 08:19:08 -0500")
Message-ID: <xmqq7ewzwuo6.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E48ACB76-9A57-11E7-8BF7-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Joseph Dunne <jdunne525@gmail.com> writes:

> Valid point.  The way my project is set up I always get a conflict on
> merge operations, so technically all my merges (except fast forward
> merges) end with a git-commit, which of course runs the commit-msg
> hook.  It seems everything is working as designed.  Shame there isn't
> a merge-msg hook.
>
> It seems I have no choice but to work around this issue.  Thanks for your help.

I think Stefan wanted to say in his message upthread that with an
update still in flight you may not need a workaround.
