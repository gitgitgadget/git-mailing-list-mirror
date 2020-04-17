Return-Path: <SRS0=xqrk=6B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18F60C2BB1D
	for <git@archiver.kernel.org>; Fri, 17 Apr 2020 23:22:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1D472223D
	for <git@archiver.kernel.org>; Fri, 17 Apr 2020 23:22:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="i45i0ZrG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728010AbgDQXWK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Apr 2020 19:22:10 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64861 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbgDQXWK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Apr 2020 19:22:10 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DDAAD4F4D5;
        Fri, 17 Apr 2020 19:22:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Dlj2+mkTFkuXKqO1zusEAg5wkzE=; b=i45i0Z
        rG26xckB5OM9LQpAuK6cZuq6y/8iGGB/jRVVmzSe25EwxVY3ESN8uwWybmrEuqab
        0ncJFt2qYMktRLtK4HGa+9JYlDcjzZ8Rv3nNQpL/tZsMemUOCjmc8gKX6PnBvsxw
        +LGCGqC4bSGhXHSmd+d0xvEUDOmWZ5R5H3/m0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Hm/L+a8q8qwLaMb8BvK9y8uq6t+hL1fG
        qLXH3AU9avUw/khs+CG+4KnpUXlboeemd6QpZHG1XOhN9U4yniInexic5RX9TaZG
        trLd1YFn8PjFBg+IN3TqYs+Esf8kAglXOl/eCWLprcnr8PhCr8f8huMM2K7bovBO
        o3UYFkp7yKs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D418F4F4D4;
        Fri, 17 Apr 2020 19:22:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E7CAE4F4D2;
        Fri, 17 Apr 2020 19:22:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Damien Robert <damien.olivier.robert@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Apr 2020, #01; Wed, 15)
References: <xmqqr1wo4alb.fsf@gitster.c.googlers.com>
        <20200416211208.xqnnrkvcl2jw3ejr@doriath>
        <20200416213009.GA1721147@coredump.intra.peff.net>
        <xmqqh7xjxeew.fsf@gitster.c.googlers.com>
        <20200416224708.zr4dlrz4hpaqsz2s@doriath>
        <20200416230554.bhk2yfycjwjpxggy@doriath>
        <xmqq4ktjxawx.fsf@gitster.c.googlers.com>
        <20200417125415.6o5avmae3cyvq4fy@feanor>
        <xmqq1romvx2q.fsf@gitster.c.googlers.com>
        <20200417220445.sasjy4rvzonoz7cn@doriath>
Date:   Fri, 17 Apr 2020 16:22:06 -0700
In-Reply-To: <20200417220445.sasjy4rvzonoz7cn@doriath> (Damien Robert's
        message of "Sat, 18 Apr 2020 00:04:45 +0200")
Message-ID: <xmqq8sitvgtd.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 410F7322-8102-11EA-A0D4-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Damien Robert <damien.olivier.robert@gmail.com> writes:

> The difference in remote_get_1 is that
> 	name_given = 1;
> So
> 	if (name_given && !valid_remote(ret))
> 		add_url_alias(ret, name);
> gets called.

Ah, of course ;-) The code in builtin/push.c rely on being able to
pass NULL as the name and rely on current branch getting used; you
have to pass the name of the ref you are trying to format %(push)
for, so you would trigger add_url_alias(), which says as a fallback
that URL for "origin" is "origin" and makes ret->url non-NULL (hence
it no longer is !valid_remote() and gets returned).  

Geez.  This is tricky.

> But I think that means that my fixup is actually wrong when a pushRemote is
> set without a remote while 'origin' do exist.

Thanks.
