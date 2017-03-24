Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 83FA51FC19
	for <e@80x24.org>; Fri, 24 Mar 2017 19:13:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754642AbdCXTN3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Mar 2017 15:13:29 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54281 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751306AbdCXTN1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2017 15:13:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 920BB7659D;
        Fri, 24 Mar 2017 15:13:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RLxjwmANilppIoWn6iWAcO2lakA=; b=TSgcYK
        FZSl0Ezju+DMUWVTI5TX81xVakzEZv2cOwGRmtGf033alzvjC0Vxzbv44/rPDYNI
        0/wjKG+Be5t5WVaApPpRN/yD/JiT9YTvVlfuN59anBT8wp81wdPYZY0sEFSZ9lh1
        FbTeG5CvqQXOV3jr9fRFrXsa90syNGa9KGCus=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vFo7lydku+r1wRplrr6wzyAUC1fg7sho
        /g73Sm8w72KyfJRYg3wS0+6BdKFnJhXf8s4Xbxwizmyjqy+x/E4f3k++O4F1FRSx
        KuA0Eyn5Nn2I+JFgE6nkf1R8zOsLXW5i7Qk6h2xBnC0COY0zj1NZUyHPgmDpQT8C
        rfvlnUeKEG8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 89C737659B;
        Fri, 24 Mar 2017 15:13:25 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E46887659A;
        Fri, 24 Mar 2017 15:13:24 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH] log: if --decorate is not given, default to --decorate=auto
References: <20170321055203.26488-1-alexhenrie24@gmail.com>
        <xmqqinn2sfdw.fsf@gitster.mtv.corp.google.com>
        <xmqqzigemfij.fsf@gitster.mtv.corp.google.com>
        <CAMMLpeQZXzPtN+mmtRS33vbT6hFz8p0qqjFMhz9tUHk747=Z3Q@mail.gmail.com>
        <xmqqmvcdmeuv.fsf@gitster.mtv.corp.google.com>
        <CAMMLpeR-zCpL5Gx=BoK8G9_wL2TBe-wD3VnsAShAuVVzS=Nirg@mail.gmail.com>
        <xmqqfui4f0pp.fsf@gitster.mtv.corp.google.com>
        <CAMMLpeRtzYM3a639DcNbhqAmz3dNkRebvQps-gusEKx+eQqPgQ@mail.gmail.com>
        <20170324185543.uq4clqyvbdkahbzo@sigill.intra.peff.net>
Date:   Fri, 24 Mar 2017 12:13:23 -0700
In-Reply-To: <20170324185543.uq4clqyvbdkahbzo@sigill.intra.peff.net> (Jeff
        King's message of "Fri, 24 Mar 2017 14:55:44 -0400")
Message-ID: <xmqqr31m7ajw.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F42FD2FE-10C5-11E7-8C54-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I see you ended up with a test that uses test_terminal, which is much
> better (and your patch looks good to me).
>
> But I was concerned that there might be a bug in pager_in_use(), so I
> dug into it a little. I think the code there is correct; it's just
> relaying the environment variable's value. Likewise, on the setting
> side, I think the code is correct. We set the environment variable
> whenever we start the pager in setup_pager().
>
> I think what is confusing is that "git -p" does _not_ mean
> "unconditionally use a pager". It means "start a pager if stdout is a
> terminal, even if this command is not usually paged". So something like
> "git -p log >actual" is correct not to trigger pager_in_use().
>
> I also double-checked the documentation, which covers this case
> accurately. So I think all is well, and there's nothing to fix. You
> might want an option for "even though stdout is not a tty pretend like a
> pager is in use", but that is exactly what GIT_PAGER_IN_USE=1 is for.

Thanks ;-).
