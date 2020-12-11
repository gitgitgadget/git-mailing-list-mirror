Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 506C1C433FE
	for <git@archiver.kernel.org>; Fri, 11 Dec 2020 06:56:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0363C23F2B
	for <git@archiver.kernel.org>; Fri, 11 Dec 2020 06:56:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436605AbgLKGzU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Dec 2020 01:55:20 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51726 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436596AbgLKGyr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Dec 2020 01:54:47 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1A14C96125;
        Fri, 11 Dec 2020 01:54:07 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=pA7mpZOwC2rMXvOQN/KscGtB4Ns=; b=GT/mg0Urp6zIfwJw3G4E
        F6RAecUdfIwe32mw/8ps2GDDfqiaNqW2ggfyh1HbdXGiqEmCBTX1AFGYoCbdINQU
        PnnA7bcbIa8bPg9do/zdidzFJ3kwWVn+Xr1w+l0MxSzpdan78U8+kpgSF6yF64CV
        yCiOzWGEVjg1N2/HKuZkDVg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=n3Uz/suhVO23NADx1wF96FdLy2MTvUVjp9mLlDzQBt4PnZ
        j3lqN27vzPyDkFN/YNOGrFTfORYsAmslAkQ+Kaeaa8hjALiippv5WJOgeaF56Btg
        +JT+8bAGKMipILwUdiYiohHt1EqkdVvmBayghaUl51SHDGiSBUIOlFIKzUOYk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EFBAF96124;
        Fri, 11 Dec 2020 01:54:06 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 592E896123;
        Fri, 11 Dec 2020 01:54:06 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Jeff King <peff@peff.net>,
        =?utf-8?Q?V=C3=ADt?= Ondruch <vondruch@redhat.com>
Subject: Re: [PATCH v5 1/3] pull: refactor fast-forward check
References: <20201210100538.696787-1-felipe.contreras@gmail.com>
        <20201210100538.696787-2-felipe.contreras@gmail.com>
Date:   Thu, 10 Dec 2020 22:54:05 -0800
Message-ID: <xmqq5z58n88i.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A964B9D8-3B7D-11EB-965F-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> It's much cleaner this way.

It is obvious that a focused single purpose helper with less
indentation is easier to follow both at the calling site and the
implementation itself.

"It's much cleaner" is not something you need to say.

If you were making it uglier, but other benefits outweigh the
ugliness, that may deserve to be said, but that is not the case
here.

> Also, we would like to be able to make this check before the decision to
> rebase is made.

... in a future step.

That is something we want to say upfront, not "Also".

The patch itself looks quite straightforward.

Thanks.
