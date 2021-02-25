Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA74DC433DB
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 07:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 241B464E6C
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 07:15:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233022AbhBYHPL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Feb 2021 02:15:11 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56105 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233961AbhBYHOj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Feb 2021 02:14:39 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B6F4A11702F;
        Thu, 25 Feb 2021 02:13:51 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=L5XmI7MOWefWAUa+7tIFUrp8Wdk=; b=KsQeUR
        1u1acKjDJSehjhHYac+S2xjejdCiS1ZfQ1C+RVje8/LahuI7stOCMcCJqjaIt2D3
        qSsAdl8fh72zkZdCwSFQufPPBBxdfmjASACPlean9Z94qQtie0k8zTfqilEDPNll
        usSGQJ3VjRrVZWemqiTo+tzMu3/9PeV+luJvU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=JwaxP3A0ZgNcb00Vg86GZZLdcZaSIW9c
        JJDAmxopeUGesV1IvaFh9FNXzDN2G9/AFikPMeMwRS0Gndz49BCiy7DPlDDxm0vx
        R+uOQxt3mXXEyXkJz18giMnzFBZ43h9Pn/2YfogAumn+IBzQVDHFD1DVSq6MnZpJ
        Eo1X7cWGTBc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AF35611702D;
        Thu, 25 Feb 2021 02:13:51 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 022C011702C;
        Thu, 25 Feb 2021 02:13:48 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     Yaron Wittenstein <yaron.wittenstein@gmail.com>,
        Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [QUESTION] Tracking HEAD changes?
References: <CAGgn8PdU1GE_CZdGUpJWKzygd0O+Yn2BnAFGmPfKAxFpoVoqUA@mail.gmail.com>
        <YDROhhrM5qJti1ir@coredump.intra.peff.net>
        <YDVo0kGYODP0JjqT@coredump.intra.peff.net>
        <CAGgn8PcPtLNtZTmMqKKTmH3KOezkr-jY7aTEDA-0dvYWuzid9A@mail.gmail.com>
        <YDa/EupbrNa62r+D@coredump.intra.peff.net> <YDc3dinQ37FY8fhD@ncase>
        <CAGgn8PfdGBuB29Gxba6OmhSagjqwH2DNUv9XyJnXUhcKpJZBsA@mail.gmail.com>
        <YDdDUILUUXA1ytva@ncase>
Date:   Wed, 24 Feb 2021 23:13:47 -0800
In-Reply-To: <YDdDUILUUXA1ytva@ncase> (Patrick Steinhardt's message of "Thu,
        25 Feb 2021 07:27:28 +0100")
Message-ID: <xmqqim6gwrf8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 01B28F42-7739-11EB-BB98-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

> So what you're observing is simply mirroring "reality": the order in
> which git does its things here. There can be arbitrarily many
> transactions in a given git command, and the only way this can be
> changed is by changing how the command operating the transcations works.

In other words, ref transaction is only about changes to the refs.
There is no such "transaction" that treats a series of operations
like object creation and index manipulation that may happen before a
group of refs are updated as a single unit and make it atomic.

