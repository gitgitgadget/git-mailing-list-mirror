Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 344FA20C31
	for <e@80x24.org>; Fri,  8 Dec 2017 16:24:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753564AbdLHQYu (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Dec 2017 11:24:50 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52546 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752840AbdLHQYt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Dec 2017 11:24:49 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0C761D0DD7;
        Fri,  8 Dec 2017 11:24:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=aff8JpE1w0Fldi8hT81eAs8A5iU=; b=MHqkBg
        GM0Y0j7rlUaor2gfQYSE/JKVWaNBUME4wNRs3pPTDWYUAWyjMXpSJcNvzK6RFhns
        9as3agVlPotT2JEIV1DY/nyQbT0UBUNQcDmfBgFad/7lwkvLF1UJYrw2JC7hHd1o
        5AdyNVUJ+vp0fOtSxbvqh/Hymxnrr77mqeasw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=JrgZr+0fbXIbe88UQmPkuNLkMxTYhb+9
        EifCiciA/nsUVEDmTzSNlkjaqYWWgEb+LHK0n2CckKFgreqU854JFdEQPKetA+yU
        tgzHLf0L8iW94Pcav/ND2hRbS3nTnnPO9miMqx68Dicw/aJv7uh+WwJiBa3b8JdW
        RHQERZON9QE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0385DD0DD6;
        Fri,  8 Dec 2017 11:24:49 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5D05FD0DD3;
        Fri,  8 Dec 2017 11:24:48 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Igor Djordjevic <igor.d.djordjevic@gmail.com>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Git Mailing List <git@vger.kernel.org>,
        Nikolay Shustov <nikolay.shustov@gmail.com>,
        Johannes Schneider <mailings@cedarsoft.com>,
        Patrik Gornicz <patrik-git@mail.pgornicz.com>,
        Martin Waitz <tali@admingilde.org>,
        Shawn Pearce <spearce@spearce.org>,
        Sam Vilain <sam@vilain.net>, Jakub Narebski <jnareb@gmail.com>
Subject: Re: [SCRIPT/RFC 0/3] git-commit --onto-parent (three-way merge, no working tree file changes)
References: <8998e832-f49f-4de4-eb8d-a7934fba97b5@gmail.com>
        <d5f243a5-6e35-f3fc-4daf-6e1376bef897@kdbg.org>
        <203a75c8-0c58-253c-2c18-05450f7ae49b@gmail.com>
        <ea156b8b-29d8-7501-b5a5-a29cfbd7d1d6@kdbg.org>
        <741dfedc-07f8-24fb-ebe2-940f8b2639d4@gmail.com>
        <33e97533-716b-e1cc-6aa0-bf8941225319@kdbg.org>
        <7ae3ffd5-147d-55d2-9630-da12c429d631@gmail.com>
        <39323748-282c-5881-2bfa-de622bb8b765@kdbg.org>
        <CAPc5daWupO6DMOMFGn=XjUCG-JMYc4eyo8+TmAsdWcAOHXzwWg@mail.gmail.com>
        <f9a94a62-9541-e019-8ab3-9fc9cfe2c43f@gmail.com>
Date:   Fri, 08 Dec 2017 08:24:47 -0800
In-Reply-To: <f9a94a62-9541-e019-8ab3-9fc9cfe2c43f@gmail.com> (Igor
        Djordjevic's message of "Fri, 8 Dec 2017 01:15:25 +0100")
Message-ID: <xmqqo9n99ohc.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4F48579E-DC34-11E7-A0C4-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Igor Djordjevic <igor.d.djordjevic@gmail.com> writes:

> To get back on track, and regarding what`s already been said, would 
> having something like this(1) feel useful?
>
> (1) git commit --onto <commit>

Are you asking me if _I_ find it useful?  It is not a very useful
question to ask, as I've taken things that I do not find useful
myself.

Having said that, I do not see me personally using it.  You keep
claiming that committing without ever materializing the exact state
that is committed in the working tree is a good thing.

I do not subscribe to that view.  

I'd rather do a quick fix-up on top (which ensures that at least the
fix-up works in the context of the tip), and then "rebase -i" to
move it a more appropriate place in the history (during which I have
a chance to ensure that the fix-up works in the context it is
intended to apply to).

I know that every time I say this, people who prefer to commit
things that never existed in the working tree will say "but we'll
test it later after we make these commit without having their state
in the working tree".  But I also know better that "later" often do
not come, ever, at least for people like me ;-).

The amount of work _required_ to record the fix-up at its final
resting place deeper in the history would be larger with "rebase -i"
approach, simply because approaches like "commit --onto" and "git
post" that throw a new commit deep in the history would not require
ever materializing it in the working tree.  But because I care about
what I am actually committing, and because I am just lazy as any
other human (if not more), I'd prefer an apporach that _forces_ me
to have a checkout of the exact state that I'd be committing.  That
would prod me to actually looking at and testing the state after the
change in the context it is meant to go.
