Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F30CD20958
	for <e@80x24.org>; Wed, 29 Mar 2017 16:46:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751603AbdC2Qq1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Mar 2017 12:46:27 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51803 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751216AbdC2Qq0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Mar 2017 12:46:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 369F38526B;
        Wed, 29 Mar 2017 12:46:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=sZv3OBhY6micYjyLjx/avLDgyEA=; b=bHTEc7
        aJJ3G9qOtvFz/05NXiSl32urhXS6FL6fUgeUfCk5aZElzBPtXVHjKF+sFJ1qTVcj
        E6eh4Lzbf9g3p621DZ/BjGggL6hjRkMHr49RMKClYFpFZ5FTuVI3pEa4cgbo2iQT
        CMHsN2tYGhxNGo3wnhgTZQDxTOK0W/0fwEzGY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=RB+cS+cCpp76jzvr6IlGZrRfMpfZRcja
        hZd38CASZ0CA2dERXv528wkCTlpCol68A3cDy1cM6dw7Lc4KZK2g44NaZNPe3J5H
        RO8XE6Zto1CLggOUeRcA0aDj/E/cAaC9/K/67VimOA37nScpDE50ByOa4MiGY9v/
        BxunJjYu3jg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2FA6F8526A;
        Wed, 29 Mar 2017 12:46:24 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 99B6C85269;
        Wed, 29 Mar 2017 12:46:23 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Daniel Ferreira <bnmvco@gmail.com>, git@vger.kernel.org,
        sbeller@google.com, pclouds@gmail.com
Subject: Re: [PATCH v4 2/5] dir_iterator: iterate over dir after its contents
References: <1490747533-89143-1-git-send-email-bnmvco@gmail.com>
        <1490747533-89143-3-git-send-email-bnmvco@gmail.com>
        <7a665631-da6a-4b9f-b9e7-750f2504eccd@alum.mit.edu>
Date:   Wed, 29 Mar 2017 09:46:22 -0700
In-Reply-To: <7a665631-da6a-4b9f-b9e7-750f2504eccd@alum.mit.edu> (Michael
        Haggerty's message of "Wed, 29 Mar 2017 11:56:00 +0200")
Message-ID: <xmqqk278av4x.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3E58B580-149F-11E7-8412-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael Haggerty <mhagger@alum.mit.edu> writes:

> I also realize that I made a goof in my comments about v3 of this patch
> series. Your new option is not choosing between "depth-first" and
> "breadth-first". Both types of iteration are depth-first. Really it is
> choosing between pre-order and post-order traversal. So I think it would
> be better to name the option `DIR_ITERATOR_POST_ORDER`. Sorry about that.

That solicits a natural reaction from a bystander.  Would an
IN_ORDER option also be useful?  I am not demanding it to be added
to this series, especially if there is no immediate need, but if we
foresee that it would also make sense for some other callers, we
would at least want to make sure that the code after this addition
of POST_ORDER is in a shape that is easy to add such an option
later.
