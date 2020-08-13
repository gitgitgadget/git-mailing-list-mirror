Return-Path: <SRS0=IFun=BX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62B9FC433DF
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 17:46:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F291320675
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 17:46:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="xZk4pfzr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbgHMRqo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Aug 2020 13:46:44 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63380 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbgHMRqn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Aug 2020 13:46:43 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9920879621;
        Thu, 13 Aug 2020 13:46:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=arN8BwTJQzbNBXX+ii8nuIYmQck=; b=xZk4pf
        zr7nSEMBeHHNt7xtWHMbF+hiG0SRtKHn+BJlXzQpEY5wXI0Kl4igx+pvK4ANtbYK
        Gk73kT9Rcs0xUOgz0vBeWbI2QjH1lqXlhrJiGHCT/4Q+uI1G1ev8xXq4AJuw1abG
        BdajakzutF9r/Pc54Rq+LZO7vCupreufuCzZU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xHITgSFIMsznNu9Gnjxk7sLjWQ9MX1MZ
        jSDM2wTySbScX9QlkF6HWDKbN4BTalWU7Cg/E8zGzE6E82FmOwJeOoYn4WsGT6Ji
        +Eilbwka1FaJYB7AjG/SLS0wV7bmMFqoGOlioUBssncwtFlOuQ0b2dX+ZidVvQal
        aYf/dtbstJA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9194A79620;
        Thu, 13 Aug 2020 13:46:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1E03E7961E;
        Thu, 13 Aug 2020 13:46:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Elijah Newren <newren@gmail.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Alban Gruin <alban.gruin@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v7 0/5] cleanup ra/rebase-i-more-options
References: <20200407141125.30872-1-phillip.wood123@gmail.com>
        <20200716173221.103295-1-phillip.wood123@gmail.com>
        <nycvar.QRO.7.76.6.2008131608240.54@tvgsbejvaqbjf.bet>
Date:   Thu, 13 Aug 2020 10:46:40 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2008131608240.54@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Thu, 13 Aug 2020 16:24:45 +0200 (CEST)")
Message-ID: <xmqqzh6y30cf.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F1E0471C-DD8C-11EA-BBBF-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> I offered three small suggestions how I think it could be improved, still,
> but I would be pretty happy with seeing the patches moving to `next`
> as-are.

I tend to agree with those points I saw you mentioned.

The unconditional exporting of the committer-date without undoing
looked like a bad pattern waiting to be copied and pasted.  I
have not yet fully followed the codepath but I tend to agree with
your suspicion that commit_tree_extended() might be a better place
to do this.

Thanks.
