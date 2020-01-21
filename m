Return-Path: <SRS0=4+BP=3K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7D40C2D0CE
	for <git@archiver.kernel.org>; Tue, 21 Jan 2020 18:34:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 991FC24655
	for <git@archiver.kernel.org>; Tue, 21 Jan 2020 18:34:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="U9mXn6Cv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729147AbgAUSez (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jan 2020 13:34:55 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54991 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729080AbgAUSez (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jan 2020 13:34:55 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 722CE35D50;
        Tue, 21 Jan 2020 13:34:53 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=AiobTUq3XFbLtLHxQ2jDM9TxJGY=; b=U9mXn6
        CvF+JwxuPmQYgUMSrUS0EXJEt4UE2hxEeCCG3GY3kzo2Z6ScDtN+5IDGBcWfvMz0
        UKSgueMLb7KU2OKYOQaXheKcG+g+aAKYDnChxk6RdxWXSKRjbfGnjLVmGVsQG3ui
        71RxD+8MPPJmTwSbwf8ln/5D/h3xbj/+ct958=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=MakuXcKaxQKtPHQxVEM+FsyjnlNLOS05
        aFu4jgwj9YIniSiayFXMIE6HOME66BhKmz6BO1MRjUvD5naI8IIbEb7snoae0dG+
        yCHA+X6og8KTL9k2H34sKVZpkOoNCG7ewS0h7rrpJh/2I/GURBX2L5VHIgb2pgf2
        4VeyN/q5csk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6983435D4F;
        Tue, 21 Jan 2020 13:34:53 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CF40935D4E;
        Tue, 21 Jan 2020 13:34:52 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     git <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: reftable progress
References: <CAFQ2z_OhNHauK_W1wL7WcOJnm2vCUGXLfYn_ZmLnt2rez+_TDw@mail.gmail.com>
        <xmqq4kx4z8n3.fsf@gitster-ct.c.googlers.com>
        <CAFQ2z_PxumPGpgnTERcu3S+zdTj9PcVMKK9SjYxSDe3qW9q3jA@mail.gmail.com>
Date:   Tue, 21 Jan 2020 10:34:51 -0800
In-Reply-To: <CAFQ2z_PxumPGpgnTERcu3S+zdTj9PcVMKK9SjYxSDe3qW9q3jA@mail.gmail.com>
        (Han-Wen Nienhuys's message of "Mon, 20 Jan 2020 19:22:54 +0100")
Message-ID: <xmqqwo9kacac.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B6CC102C-3C7C-11EA-A669-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han-Wen Nienhuys <hanwen@google.com> writes:

> I asked around, and it looks like we have slight preference for the
> BSD license (https://developers.google.com/open-source/licenses/bsd).
> According to the FSF, this is OK to combine with GPL software, so
> would you be OK with that license?

Sure, I think we are happy with adopting BSD code (and it would keep
it more avaiable for other reimplementation of Git, which is good).

> The API is a little surprising here, because it means that an iterator
> should always dereference a symref, regardless of storage format.

I do not think forcing the callers to dereference is clearly better
(if so, we may want to consider changing the API to do so, but I do
not see such a strong reason).  Only when the vast majority of
callers would want just the name of the underlying ref without
learning the actual object value, such an optimization may make
sense, but it would make the callers more difficult to write
correctly (iow, somebody will forget to teach "this is a symref, so
we need to ignore the incoming oid parameter and call read_ref()
ourselves to learn the name of the object" to their each_ref_fn
callback functions, no?


