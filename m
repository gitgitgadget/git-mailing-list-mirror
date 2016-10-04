Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 22D5120987
	for <e@80x24.org>; Tue,  4 Oct 2016 21:01:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754204AbcJDVBD (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 17:01:03 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64815 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753303AbcJDVBD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 17:01:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B44BF430B4;
        Tue,  4 Oct 2016 17:01:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nHoLgVIITO9tLvWByB8irDowSOA=; b=AQ+eJi
        ussDsV985SVOQa2RCpmDzloQ70OId0T8guqsINSv7BIn7MSKnXZm88vQqyjD7LIz
        07eRolCi7ymn1WFw/nTy7lQQR3hj8Xqs1JYCdk68Sh5VSi9LbflcqsfXYtk1lFmT
        caJeGY73Pd1Js33oQ4sGckVWhzXkZwaaf/U7g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Evc+t12TQGeUsBGXlRFrj6qoY3HltdG0
        0MxJ0l4+phAb9wMxX2xr0k4hP00P2Jld2zVoXCvi6U7UY+pN4m4keVUnJ2J8hbDL
        fCNsXO/aibhvaDnCLVaTDjbpfRX8bYhTTtRlfklZVhUtwf3V3yptMWTPs2UoDoFu
        rn1k2PdMGZE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 80ED6430B3;
        Tue,  4 Oct 2016 17:01:01 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 98F76430B2;
        Tue,  4 Oct 2016 17:01:00 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 05/18] t5613: do not chdir in main process
References: <20161003203321.rj5jepviwo57uhqw@sigill.intra.peff.net>
        <20161003203408.qnakqgcninzty3sr@sigill.intra.peff.net>
Date:   Tue, 04 Oct 2016 14:00:58 -0700
In-Reply-To: <20161003203408.qnakqgcninzty3sr@sigill.intra.peff.net> (Jeff
        King's message of "Mon, 3 Oct 2016 16:34:08 -0400")
Message-ID: <xmqqwphnsub9.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A7719276-8A75-11E6-B3A2-5F377B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Our usual style when working with subdirectories is to chdir
> inside a subshell or to use "git -C", which means we do not
> have to constantly return to the main test directory. Let's
> convert this old test, which does not follow that style.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  t/t5613-info-alternate.sh | 92 +++++++++++++++++------------------------------
>  1 file changed, 33 insertions(+), 59 deletions(-)

Whew.  Quite a lot of cleanups on this ancient script.  Thanks.
