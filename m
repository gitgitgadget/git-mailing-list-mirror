Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A78320964
	for <e@80x24.org>; Sun,  2 Apr 2017 03:30:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750873AbdDBDa0 (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Apr 2017 23:30:26 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50643 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750810AbdDBDaZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Apr 2017 23:30:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7D8F16EEBB;
        Sat,  1 Apr 2017 23:30:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=EeJx47kgxqFUTJYE6ZEP45M2iBc=; b=gFcl3q
        3yMVlB5xTlN6MXcC6evL0AfE5h1wt+fa4/wtS73Ig5aFT08/SU41l6kBs+D1Vwb1
        lJ0bUlvnGoSmkUHaACWWqcMRInf+4z76dHFli3zPXPQAN4Pa33v0OzQ4izGucm9O
        WE5JVqNqCevvJ7doC9MmAOYhmFqVCtdOPzrjg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=py2cbn+ZK7bAHoaOyIU3zh0QkntwSBpC
        WY0LcxahBCNIbflt4V7yIBLwU6CtIgG+uQs+Gt61/LRHqzU8U8zj+0bI/II3JFg2
        AZa4tk9RFBOOt+O1cVjrbF8PLci6Fih+Vr7mINLVCBUN8LP15jfkWL+QBHbn0FJD
        eHhL/9qoHks=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 750976EEBA;
        Sat,  1 Apr 2017 23:30:24 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D8B0A6EEB9;
        Sat,  1 Apr 2017 23:30:23 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Robert Stanca <robert.stanca7@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] [GSOC] show_bisect_vars(): Use unsigned int instead of signed int for flags
References: <20170401153049.21400-1-robert.stanca7@gmail.com>
        <20170401153049.21400-2-robert.stanca7@gmail.com>
        <xmqqtw68szz1.fsf@gitster.mtv.corp.google.com>
        <CAJYcaSNAB+1gth2NkTjrcBV9TXT9bRsBQhwOsQCmnudYz5bTmg@mail.gmail.com>
Date:   Sat, 01 Apr 2017 20:30:22 -0700
In-Reply-To: <CAJYcaSNAB+1gth2NkTjrcBV9TXT9bRsBQhwOsQCmnudYz5bTmg@mail.gmail.com>
        (Robert Stanca's message of "Sat, 1 Apr 2017 22:19:26 +0300")
Message-ID: <xmqqlgrjtrjl.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B4F8E338-1754-11E7-BAE4-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Robert Stanca <robert.stanca7@gmail.com> writes:

> I am used to 1change per patch so it's easier  to redo specific
> patches...if there are small changes(10 lines max) can i send them as
> 1 patch?

It's not number of lines.  One line per patch does not make sense if
you need to make corresponding changes to two places, one line each,
in order to make the end result consistent.  If you change a type of
a structure field, and that field is assigned to a variable
somewhere, you would change the type of both that field and the
variable that receives its value at the same time in a single
commit, as that would be the logical unit of a smallest change that
still makes sense (i.e. either half of that change alone would not
make sense).



