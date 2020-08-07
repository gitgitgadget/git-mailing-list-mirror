Return-Path: <SRS0=eX0j=BR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DC83C433E0
	for <git@archiver.kernel.org>; Fri,  7 Aug 2020 22:07:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F449214F1
	for <git@archiver.kernel.org>; Fri,  7 Aug 2020 22:07:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="WjHl2Dnr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbgHGWHr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Aug 2020 18:07:47 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60193 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726015AbgHGWHp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Aug 2020 18:07:45 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C0CBC6C8C1;
        Fri,  7 Aug 2020 18:07:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=La/p/b69dG4+BHoOpn5jrZH+hC0=; b=WjHl2D
        nr5FmOLm/m6jX8DEVY72tGm2ybF+UzxWFp0Kab64HhIErWYbqlrGwyIkYXrSpZEA
        MqAAOFSoCqSQIu9zE01mRAaB2qxO53vrvP0rjS8bT6ewyxvTDgot8VMMnpQB5TMC
        mJwUDvppfnwxqWQYScGdToJNUrU+xErFJsAcY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=GuBaFKKAoZL4nyLTtNPWTVMPaInsX1II
        w/1jlByO5uJ0Y9GjdeNiQSzOI1Wvjk9bUzZS4J2NhnRfAh5j1K4+tvPAL1ELlREI
        oR+4Fl4Kd5QHbwTNPnAAHAUR5aZjldcpDKh9oR/A/1b68igvxcCVyH1taC5Wxzbq
        sYEkiUf5K8Y=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B8A316C8C0;
        Fri,  7 Aug 2020 18:07:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 374FC6C8BF;
        Fri,  7 Aug 2020 18:07:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Aaron Lipman <alipman88@gmail.com>, git <git@vger.kernel.org>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Subject: Re: [PATCH v4 0/5] Introduce --first-parent flag for git bisect
References: <20200801175840.1877-1-alipman88@gmail.com>
        <20200804220113.5909-1-alipman88@gmail.com>
        <CAP8UFD1Z1V6+iPO2CMOqdHhUGkmTdvCK+TDNtoOcX8QvC4coNQ@mail.gmail.com>
        <xmqqmu36f9pv.fsf@gitster.c.googlers.com>
        <CAPig+cT_1JNZOk7wZr3akdCmv7tn2RHieJd+A-usZ49jS0eCmA@mail.gmail.com>
Date:   Fri, 07 Aug 2020 15:07:42 -0700
In-Reply-To: <CAPig+cT_1JNZOk7wZr3akdCmv7tn2RHieJd+A-usZ49jS0eCmA@mail.gmail.com>
        (Eric Sunshine's message of "Fri, 7 Aug 2020 17:17:43 -0400")
Message-ID: <xmqq364yf6tt.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6ABD9A14-D8FA-11EA-83F2-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> Consequently, I'm not in a
> position to say whether or not there are any fundamental issues with
> the changes made by any of these patches.

Sorry, that wasn't what I meant.  A reroll would be done with an
updated test, so I was asking your eyeball once again on that.
