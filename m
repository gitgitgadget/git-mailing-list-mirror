Return-Path: <SRS0=nsHh=4C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC1BC35242
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 04:17:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D114222C2
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 04:17:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="x5G18Ux6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728486AbgBNERm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Feb 2020 23:17:42 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54580 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728336AbgBNERm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Feb 2020 23:17:42 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 390EC426B9;
        Thu, 13 Feb 2020 23:17:41 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=oyD6uY2uU8xo+kY/zxDOu2ZFCA8=; b=x5G18U
        x6FUv7ABd2fBBve7b7yJIMwe4Kj8HyxOFkziOvUPU93TKLYDn2ZoMXLMMoBeBIxd
        8HiI2QuwDTyft/uGdtwTAD/WQIbI45jl6s9KSOmTswRc0Ks7zV9c1TbFwolQDD1I
        PwLmwIkiiqr+N1pqfGH/uqaMYG9+9jot7J6yw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=m+4K/lTBti/Y8Nn87/7OP51ukIHC3QJy
        fwKxn6p74j6ml6tTKJ65kTG6LwCyIdLDqeyg5qp2b948fCTZeXALi7b7+PjFwPy+
        uJM3hWPsQ+oqC5FhTGIOJhB+J6CfbfIDFMzrP1VbDvKej2YPJ3bePqFKF2pcdLjw
        7zFEHrakS6c=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2FE92426B8;
        Thu, 13 Feb 2020 23:17:41 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9A656426B7;
        Thu, 13 Feb 2020 23:17:40 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Yang Zhao <yang.zhao@skyboxlabs.com>
Cc:     git@vger.kernel.org,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Emily Shaffer <emilyshaffer@google.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: yz/p4-py3, was Re: What's cooking in git.git (Feb 2020, #03; Wed, 12)
References: <xmqqo8u3tqly.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.2002131401130.46@tvgsbejvaqbjf.bet>
        <xmqq7e0qtqsm.fsf@gitster-ct.c.googlers.com>
        <xmqqk14qqj7n.fsf@gitster-ct.c.googlers.com>
Date:   Thu, 13 Feb 2020 20:17:39 -0800
In-Reply-To: <xmqqk14qqj7n.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Thu, 13 Feb 2020 13:18:52 -0800")
Message-ID: <xmqqtv3tpzto.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F0B8D9FC-4EE0-11EA-B018-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> So the diff was taken from <20200123175645.GF6837@szeder.dev>; with
> Szeder's SoB (and possibly wordsmithing the log message) let's tie
> this loose end.

Now we are running some tests under py3, we seem to be failing the
tip of 'pu'

    https://travis-ci.org/git/git/jobs/650160479

that is getting a SyntaxError.

    if message.find(separatorLine) <> -1:

There are other breakages whose causes are already identified in the
recent list messages, e.g.

    https://travis-ci.org/git/git/jobs/650160481

is due to a non-portable sed invocation in the bugreport topic,

    https://travis-ci.org/git/git/jobs/650160486

is also due to the same topic, and

    https://travis-ci.org/git/git/jobs/650160483

is due to the forbidden "for (type var = init; ...)" construct in
new C code.
