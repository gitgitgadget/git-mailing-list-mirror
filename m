Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5CB371F462
	for <e@80x24.org>; Thu, 13 Jun 2019 18:23:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbfFMSXi (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jun 2019 14:23:38 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55615 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbfFMSXi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jun 2019 14:23:38 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 37A8C60C95;
        Thu, 13 Jun 2019 14:23:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=JnayyZs8h5O6cO1ia07b/4YVjDg=; b=lC7da0
        oOJ2lV5zWLxtvfI5hk/Ha8cnnd7ICMfbIPXDPGiZ5OrCEFaOkzXsRYhpQD8pwuBo
        TsAZx+fuE9FsueuQ7Cg/SvjzkncOFR+aHjL3Q3d8Xrv+rfc3XznwQ6nFN25kkw4i
        3d5SZUbQE8pu7P9xRtq+wMa9y3lWVMDjgVgUw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=C/IlmR4lIFyeBuhMAVSJH2qOgItjcAh2
        1I/5dLeXc1R7gDKi40b1iRcaSnV2AMTqFTgFZxWnQUaVgeKG0KJCWjiOn28ZQHhd
        bcHgAQwcOfyIScD3AZQ3HCISvZwiKgGFvhlz0Uy5WGve/viq5JddEo5BYZphKXZ7
        xOVNNWFwHqk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3037D60C94;
        Thu, 13 Jun 2019 14:23:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7A95960C90;
        Thu, 13 Jun 2019 14:23:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Paul Smith <paul@mad-scientist.net>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Reducing git size by building libgit.so
References: <21f1f334-755e-3283-d0da-ec0ab9231cfc@ucdenver.edu>
        <20190611234815.GB8616@genre.crustytoothpaste.net>
        <9c488ce8c1e1e6d6d4c343b0b40c8a64c8147a7f.camel@mad-scientist.net>
        <nycvar.QRO.7.76.6.1906130914250.42@tvgsbejvaqbjf.bet>
        <13c40b4b819f702a52f7039177579f87fa90aa50.camel@mad-scientist.net>
Date:   Thu, 13 Jun 2019 11:23:29 -0700
In-Reply-To: <13c40b4b819f702a52f7039177579f87fa90aa50.camel@mad-scientist.net>
        (Paul Smith's message of "Thu, 13 Jun 2019 13:28:10 -0400")
Message-ID: <xmqq1rzxwdi6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 59924412-8E08-11E9-8205-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Paul Smith <paul@mad-scientist.net> writes:

> I assumed that we were discussing providing an _option_ of building
> with shared libraries, rather than removing support for static
> libraries and only supporting shared libraries.  The former is the
> typical model in portable projects.
> ...
> So, the answer to most of the (important) issues you and Brian raise
> is, "if it doesn't work, can't be made to work, is too slow, or is
> annoying for ANY other reason, then don't do it".
>
> Regarding things like publish-ability of the API, I don't know what
> else to say.  It's FOSS, after all: anyone can do whatever they want
> (with respect to building and using the code) regardless of the desires
> of the development team.  All you can do is make clear that the intent
> is that the API is not stable, and if they don't listen and their stuff
> breaks, well, as the saying goes, they get to keep both halves.  Not
> adding any header files to the installation rules and packages is also
> helpful :).
>
> There's a certain amount of cold, hard reality that every FOSS project,
> regardless of how friendly and welcoming they aspire to be, simply
> can't avoid while still making progress (and staying sane).
>
>
> I certainly don't want to minimize the amount of work involved here,
> nor do I want to in any way volunteer myself to undertake any of it: as
> I said, I don't have strong feelings about it.
>
> I'm just saying, there's no technical reason it can't be done while
> maintaining the same features (such as relocatability) as the static
> library installs, at least on the major platforms.
>
> Cheers!
