Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C781D1F437
	for <e@80x24.org>; Fri, 27 Jan 2017 22:02:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751409AbdA0WC4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jan 2017 17:02:56 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60780 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751393AbdA0WCy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jan 2017 17:02:54 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 96E7263F88;
        Fri, 27 Jan 2017 16:59:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8AlmBx7lKmpmW2t44ejrqzTiJYw=; b=hjH4lr
        YiQDJEC2LLZ53MdHbgu3XWYdEXnKl96czCUre1sdYtPaLsnFLSh+dqAdo/f9Q1Xn
        sQszhgZGxdyMRXOT1lXsZSV/pwisFNwf3bIfjH0oZmGuznxeqk1JdJPmApuvOomW
        /AmBk8G+TNry/uLFryLM+i6TaPeIR9lPgP1dg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=eQL2c+YsXEiGG3Q5Vhlxzn265hf4/4wX
        8H5TqWFXzkE6MhRQsjtrnOblsrhHbTypeYdn4yHX5hez2MFvtl+yDHwAbnUM/uJU
        srlnp6tEiM8qYidS1Xs8YUVZAJ6Zei8jrxut5BA44QUuzI/YMBxiI7N4yEiPywS8
        r6aUUtee7BQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8EE4563F87;
        Fri, 27 Jan 2017 16:59:12 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EFD6163F86;
        Fri, 27 Jan 2017 16:59:11 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Samuel Lijin <sxlijin@gmail.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: octopus merge --no-ff claims to fast-forward even though it doesn't
References: <CAJZjrdWdRGZ5DC1XV_YiNt-1sKiNgAtiS-eS9L6H2GJ+_8n08w@mail.gmail.com>
Date:   Fri, 27 Jan 2017 13:59:10 -0800
In-Reply-To: <CAJZjrdWdRGZ5DC1XV_YiNt-1sKiNgAtiS-eS9L6H2GJ+_8n08w@mail.gmail.com>
        (Samuel Lijin's message of "Fri, 27 Jan 2017 14:46:25 -0600")
Message-ID: <xmqqmvecxiz5.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D5F531A0-E4DB-11E6-9853-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Samuel Lijin <sxlijin@gmail.com> writes:

> I was doing an octopus merge earlier and noticed that it claims to
> fast-forward when you specify --no-ff, even though it does actually
> abide by --no-ff.

This was intentional and hasn't changed since it was first designed;
the octopus was to be used only for the simple and obvious merges.

If anything, I think it should error out when the --no-ff option is
given, issuing the same error message as the one given when any step
other than the last one needs manual resolution.
