Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD5001F6C1
	for <e@80x24.org>; Wed, 24 Aug 2016 18:09:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754958AbcHXSJi (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Aug 2016 14:09:38 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59179 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754699AbcHXSJh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2016 14:09:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BC98C374B1;
        Wed, 24 Aug 2016 14:08:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3hOgovXFQHKmNdVpMd3dTQGpLrA=; b=fBZ9A0
        VYUVYgCImbSO1qPwOr8rjPqeTydi69/PTwuTRMtyFj8czMlKS9kbViWQajVEwq4n
        S5IUSxHu3I8zaKlSzABcuCGNEDSfYpgvi0mmtsciotFOEq+tYaisUeP/JeoVST5I
        83W3WQ/9eJ+fo+qvbGa5Qfjm5YoBgWgx6R680=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=giSc7d5Jo+K2eqLLWtQZjBQzGbmxAIRP
        Q5cczgrIoTC+7gicchKhMF3LJrIHIHowJuJN81Bc7S0AAJ1NyHM3LDmJdbkeqFWF
        H5wCiRoBP+hHwmQ4Cn9mKBI9LyZYSJt0gLoEANLHQMwozqFQp9XfMLTDHeR05tJ9
        bV55jQQlxb0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B26E7374B0;
        Wed, 24 Aug 2016 14:08:59 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2BBC0374AF;
        Wed, 24 Aug 2016 14:08:59 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Heiko Voigt <hvoigt@hvoigt.net>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        Jens Lehmann <Jens.Lehmann@web.de>,
        Fredrik Gustafsson <iveqy@iveqy.com>
Subject: Re: [PATCH] push: change submodule default to check
References: <20160817204848.8983-1-sbeller@google.com>
        <xmqqmvkb85sw.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kbb=oL7b93W-x=dxVh2aBN-H+tg9y5o4RwbepYtijQTXg@mail.gmail.com>
        <20160818140922.GA5925@sandbox>
        <CAGZ79kYxu_x2qA9fq4qAWt7GgCY3Nz51TMGQS7EbGnbm9c+kqQ@mail.gmail.com>
Date:   Wed, 24 Aug 2016 11:08:57 -0700
In-Reply-To: <CAGZ79kYxu_x2qA9fq4qAWt7GgCY3Nz51TMGQS7EbGnbm9c+kqQ@mail.gmail.com>
        (Stefan Beller's message of "Wed, 24 Aug 2016 09:46:42 -0700")
Message-ID: <xmqq1t1eqbt2.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D4721E8C-6A25-11E6-9D39-FCB17B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> I guess we can postpone it until 3.0, though I currently think it is not a big
> issue as it helps avoiding "bugs in your workflow".
>
> On the other hand if you really want to push out the superproject without
> the submodules, you need to adapt your behavior (i.e. set an option or
> give a command line flag), and such breaking things we should delay
> until 3.0.
>
> I think I'll resend it with a proper commit message, such that we can just pick
> it up when 3.0 comes around.

A change that needs to wait until a major version bump implies that
it is possibly compatibility breaking.  So "resend IT", implying one
single step, sounds like a bad sign that the users won't have any
transition period.  Shouldn't we do the usual two-step deprecation
process, i.e. warn when an unconfigured user pushes a superproject
that may be ahead of a submodule about upcoming planned default
change with the first patch, and then flip the default in the second
patch while dropping the warning?
