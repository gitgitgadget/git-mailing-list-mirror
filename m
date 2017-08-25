Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F9BC208DB
	for <e@80x24.org>; Fri, 25 Aug 2017 16:53:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754909AbdHYQxk (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Aug 2017 12:53:40 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57286 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754839AbdHYQxi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Aug 2017 12:53:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9D20094496;
        Fri, 25 Aug 2017 12:53:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Z7iou2H1AxgEjmVyu7ZSSz9NNGY=; b=aZHgvE
        TKWfL7GV0iqWXW1Qqw61N1A37jJHnDpAZc7/jHRm0btxR1CJ72cnYWvVpxHGGEHI
        Rk3wCnWPqvYdDEKVtoKTvKYenR1TILLQ9TKmi2Lj6vbmaKhzx6AiHFUGRlM1Cv7L
        e9zNO2C2L6mocrPhk+RHLkK91rVMWe8u31J/g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Yo3C6R/Fagws/zL+YzNwfcV9wQHHOu2x
        QkZ25sCN0cX3vClpQCL7iCiEhd7eKHE/s5vK97kxRY15eFEa1YB+wDRz1Uyql9oT
        zosnyxswW6fnayPCtOo0+yIu+1vqitqhunxJBbb2O6BK145PG5/K2B8BCZ8RuplR
        4a0bz31ArSo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 92E8294495;
        Fri, 25 Aug 2017 12:53:37 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D3E9B94494;
        Fri, 25 Aug 2017 12:53:36 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Heiko Voigt <hvoigt@hvoigt.net>
Cc:     Stefan Beller <sbeller@google.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Submodule regression in 2.14?
References: <CAGZ79kb-ReME6qbDy-Q12-d=B=f6odUW_D1bAmegP4AY2AyntQ@mail.gmail.com>
        <xmqqd17tei7m.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kZdnJ+bATTxKBhsJnKaJWGqcBu3MOQ9eK7m4j3dJPNbTw@mail.gmail.com>
        <xmqq7ey0ddlk.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kap-4k7n48dvBAv2pJjNy2s_LPHS-NdfQD0A-BbWqh4aQ@mail.gmail.com>
        <xmqqpobs9hjy.fsf@gitster.mtv.corp.google.com>
        <20170821160514.GA1618@book.hvoigt.net>
        <CAGZ79kZvcY8hawq1qGfFLm1Ukb-wn8j0e_hN8gF5jrEY20o7YA@mail.gmail.com>
        <20170822153311.GA5697@book.hvoigt.net>
        <CAGZ79kbwJN_XVcAbkyVJTax9F2NR4EO8XjR3U9EH8MLqbAb90Q@mail.gmail.com>
        <20170825091048.GB14872@book.hvoigt.net>
Date:   Fri, 25 Aug 2017 09:53:35 -0700
In-Reply-To: <20170825091048.GB14872@book.hvoigt.net> (Heiko Voigt's message
        of "Fri, 25 Aug 2017 11:10:48 +0200")
Message-ID: <xmqqk21rtwq8.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F020BEE4-89B5-11E7-9A37-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Heiko Voigt <hvoigt@hvoigt.net> writes:

> On Tue, Aug 22, 2017 at 11:10:52AM -0700, Stefan Beller wrote:
>> On Tue, Aug 22, 2017 at 8:33 AM, Heiko Voigt <hvoigt@hvoigt.net> wrote:
>> > On Mon, Aug 21, 2017 at 09:42:54AM -0700, Stefan Beller wrote:
>> >> On Mon, Aug 21, 2017 at 9:05 AM, Heiko Voigt <hvoigt@hvoigt.net> wrote:
>> >> > On Fri, Aug 18, 2017 at 11:51:13PM -0700, Junio C Hamano wrote:
>> >>     # You feel the superproject is in the way?
>> >>     git worktree add --for-submodule <path/to/sub> ...
>> >>     # The new submodule worktree puts the
>> >>     # submodule only UX first. so it feels like its own
>> >>     # repository, no need for specific flags.
>> >
>> > I am not sure I understand this one. What would that do? Put a worktree
>> > for submodule path/to/sub to ...?
>> 
>> Yes, and at "..." you would have the UX of the submodule being
>> its own repository, no interaction with the superproject.
>
> Are you sure that is what Junio meant?

I am sure it was not.  

If adding a separate worktree only for one submodule, you should be
able to "cd $path-to-submodule" and run "git worktree add" to create
a new worktree, and I do not see any reason for the superproject to
get involved in that process.  Does it have more information ready
than the end user has to help the process of creating a new worktree?

While I can understand how --for-submodule above may be implemented,
I do not see the point of adding such an option.




