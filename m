Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C6AEC56201
	for <git@archiver.kernel.org>; Thu, 26 Nov 2020 00:01:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DC7C20872
	for <git@archiver.kernel.org>; Thu, 26 Nov 2020 00:01:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="vU1vSS4w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728595AbgKZAB0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Nov 2020 19:01:26 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56185 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727315AbgKZAB0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Nov 2020 19:01:26 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3C6B0A0536;
        Wed, 25 Nov 2020 19:01:24 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=f1yxcx3LvZGe9j5ofb2vu7qSSHE=; b=vU1vSS
        4w2LroSJnRl9xWwEEJhU6S0MFIyU48pgzKN9OXFIMa3Xmj5sigrp3LP/hg4B5zUX
        DeFtnH5DoUeGjyfIMXDBMGAgEZhxkz8YtoHgXRBFl9w7u55G9xeQgNMIu4waF40m
        Rutvs3SjHGjpIy9uP56tw6rZ+bDteFizckqEg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=OUPz3W6IXqciesu9psbmom6oGRC8r1HP
        YjWvB7+eAG7iPcO4KjOhwBkzZ+E0g1Ab0AKyJQgGsi9CDclspnJjRukT6LZh7GKa
        EHFgtAKJhcwpeVNPYUtlTUgJZbmilwqAxZUvN+BsSI54rEZ6fIg8YGQawhrKZk9X
        H5Kv3sKL564=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 34413A0535;
        Wed, 25 Nov 2020 19:01:24 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B293EA0534;
        Wed, 25 Nov 2020 19:01:23 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Brandon Williams <bwilliams.eng@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Tomo Krajina <tkrajina@gmail.com>
Subject: Re: [PATCH v2] refspec: make @ a synonym of HEAD
References: <20201125001102.111025-1-felipe.contreras@gmail.com>
        <xmqqblfmgtlg.fsf@gitster.c.googlers.com>
        <CAMP44s2ChcCjhjksS0s5BoYznqLAoXyFvSkP4GxSCh_ALusOtQ@mail.gmail.com>
        <xmqq360ygq2g.fsf@gitster.c.googlers.com>
        <CAMP44s2cpPgg55XHTr=cRqRcrMOkU=qcrM=RpWYwVJJdd9V4JA@mail.gmail.com>
Date:   Wed, 25 Nov 2020 16:01:23 -0800
In-Reply-To: <CAMP44s2cpPgg55XHTr=cRqRcrMOkU=qcrM=RpWYwVJJdd9V4JA@mail.gmail.com>
        (Felipe Contreras's message of "Wed, 25 Nov 2020 17:48:29 -0600")
Message-ID: <xmqqlfepasvg.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 85842C10-2F7A-11EB-978D-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Tue, Nov 24, 2020 at 7:53 PM Junio C Hamano <gitster@pobox.com> wrote:
>> ...
>> we care about both of these forms working, not just the singleton
>> form, so it is not just "not hurt", but is actively a good thing, to
>> protect both forms from future breakage.  After all, that is why we
>> have tests.
>
> Both forms were already tested.

Yeah, I did realize it in my review of reviews I do after sending
all the messages yesterday (not just on this topic), so there is no
strong reason to duplicate all the tests that involve HEAD.

Thanks for pushing back on this point.
