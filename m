Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D3CA01F4C0
	for <e@80x24.org>; Wed, 23 Oct 2019 02:12:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732032AbfJWCMa (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Oct 2019 22:12:30 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52341 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbfJWCM3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Oct 2019 22:12:29 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CCB43AF910;
        Tue, 22 Oct 2019 22:12:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=02MK2SPpNF5eaXWuVrHJec8jtbA=; b=EKahe4
        zrNJMH1emw9BJovR3dnq9t6f6H6gheV+GDNC9YGgOJVAKKQlG1t75iC+oGPnGuAK
        xvAFHDtbrt5DswwuNqrQ/VtbmKnUKTA9154Dn+y6wOdzHtNuy33GSzQEknENC02O
        W7a4SG4QDvvRsLcENFdAQ5G3YbUYjua5g5qKg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ixp0XmzNTMsjIcm6uoFIbEGiReJZhQnB
        fZ+UdCSG0YSgplAv+1+HfqIKfBbJg/xQUNWuN5DLtzaaafji13Dq8EZ6hcHhS5a+
        wOq/i2pdvwVaBFskh2ZNS37dFEX9RRw+jBi3rUMTC59aYPIBnXeaJgy7K/lE4fNp
        6OVd6r7ihBI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C6B9DAF90F;
        Tue, 22 Oct 2019 22:12:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id EF265AF90D;
        Tue, 22 Oct 2019 22:12:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 2/2] git_path(): handle `.lock` files correctly
References: <pull.401.git.1571209637.gitgitgadget@gmail.com>
        <pull.401.v2.git.1571350077.gitgitgadget@gmail.com>
        <93dba5a3a38d75ba79329383a1d50419a1990c8d.1571350077.git.gitgitgadget@gmail.com>
        <xmqq1rva7sp7.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1910212157350.46@tvgsbejvaqbjf.bet>
Date:   Wed, 23 Oct 2019 11:12:22 +0900
In-Reply-To: <nycvar.QRO.7.76.6.1910212157350.46@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Mon, 21 Oct 2019 22:26:26 +0200 (CEST)")
Message-ID: <xmqqd0eojjll.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8DF311B6-F53A-11E9-938C-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> However, I think this is _really_ ugly and intrusive. The opposite of
> what my goals were.
>
> So I think I'll just bite the bullet and use a temporary copy if the
> argument ends in `.lock`.

Sounds like a quite sensible design decision to me.
