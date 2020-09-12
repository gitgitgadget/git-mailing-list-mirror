Return-Path: <SRS0=gF6X=CV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FF6BC43461
	for <git@archiver.kernel.org>; Sat, 12 Sep 2020 18:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DCD721531
	for <git@archiver.kernel.org>; Sat, 12 Sep 2020 18:22:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="HLmt4VnV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725878AbgILSWS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Sep 2020 14:22:18 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59995 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbgILSWM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Sep 2020 14:22:12 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BE2A0F44DB;
        Sat, 12 Sep 2020 14:22:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=chFGpqjPt7sxZ827Eg9fvxdy/mU=; b=HLmt4V
        nVzd5Iy+DQ3wqWDRrST0RowBzCOKlFnzqY6WdmbSMOo3PH6giCyK8LLNRMaSXoWw
        tWW0IAEPK78IbmPEG0uO57Q/gYFlfqzESLt49GFqhPrI8yr6uakk5CPebGpezuy2
        3/UYeGqNC14jMYm6zwZZZfEU3qw4nBWrQgHS0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=E6s23WDS1wRLoDnmQt3MQTj/YwEMm35e
        EANmgkaJdIxl/LEmKBb9+lrp9se1piLuwjZ6D0uT3I8MngSJo8s7A+SW1kNzg7EY
        jnPL/nPF0iObtpHTewtQjQPysCfszOO+D8zkNxN4X2r+uWOTXAkL/CAY21AZC8Jd
        3xk1W7yiYjo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B63D1F44DA;
        Sat, 12 Sep 2020 14:22:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 01634F44CF;
        Sat, 12 Sep 2020 14:22:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 2/2] push: enable "forceIfIncludesWithLease" by default
References: <20200904185147.77439-1-shrinidhi.kaushik@gmail.com>
        <20200912150459.8282-1-shrinidhi.kaushik@gmail.com>
        <20200912150459.8282-3-shrinidhi.kaushik@gmail.com>
Date:   Sat, 12 Sep 2020 11:22:05 -0700
In-Reply-To: <20200912150459.8282-3-shrinidhi.kaushik@gmail.com> (Srinidhi
        Kaushik's message of "Sat, 12 Sep 2020 20:34:59 +0530")
Message-ID: <xmqq1rj6onxu.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DD64BA84-F524-11EA-9003-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Srinidhi Kaushik <shrinidhi.kaushik@gmail.com> writes:

> Set `push.forceIfIncludesWithLease` to `true` if experimental
> features are enabled.

Why?  

We enable something to the guinea-pig audience if we consider that
it should become the default eventually for everybody.  I did not
see enough justification why this should be on for everybody
someday.
