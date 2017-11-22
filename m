Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 94A5C20954
	for <e@80x24.org>; Wed, 22 Nov 2017 16:03:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751472AbdKVQDD (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Nov 2017 11:03:03 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60316 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751259AbdKVQDC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Nov 2017 11:03:02 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4498BB9AF1;
        Wed, 22 Nov 2017 11:03:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=yHaK+DbZUWrc5Z8M91JyWTXYreE=; b=XpLN2q
        l53PLdMLrAj3pcZ4yitF46hMjNLBpSUfKZ6DOk80Uk1JYT1liJiAIm1K2lftoqw9
        +W0VQYE+UH1N3e+rOQS0lFJZsdt4QtbzKn9lCETQxAlHUROQiW/sek1MVG4Dyr3T
        xX0WquS6Z9u7AqN+1YrPcDdeDBYs+Qc55+0Sg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=I0uMmNXCtfIAAn6D3J3vBauy12Pa1Zre
        gb04km2ttVESepWDh/Ba5ko6BV8cfNlv2I9FB+TRK65h6nJlR7R8jQaVGJ+Zeuon
        QHWLfT7MOK3rfUvf9IuWrHfXKKQnuh8yyLLiCq7Al6tQVfQp10eTPGD1Ry+XS0Jx
        d7nU9NlHI/Y=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3D857B9AF0;
        Wed, 22 Nov 2017 11:03:02 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8FD29B9AEE;
        Wed, 22 Nov 2017 11:03:01 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: [PATCH v2] doc: Add missing "-n" (dry-run) option to reflog man page
References: <alpine.LFD.2.21.1711211038410.8568@DESKTOP-1GPMCEJ>
        <xmqqh8tnvvom.fsf@gitster.mtv.corp.google.com>
        <alpine.LFD.2.21.1711220249020.31052@localhost.localdomain>
        <xmqqy3mysii0.fsf@gitster.mtv.corp.google.com>
        <alpine.LFD.2.21.1711220543450.10299@DESKTOP-1GPMCEJ>
Date:   Thu, 23 Nov 2017 01:03:00 +0900
In-Reply-To: <alpine.LFD.2.21.1711220543450.10299@DESKTOP-1GPMCEJ> (Robert
        P. J. Day's message of "Wed, 22 Nov 2017 05:45:22 -0500 (EST)")
Message-ID: <xmqqine2s3m3.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9DC2E404-CF9E-11E7-802F-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Robert P. J. Day" <rpjday@crashcourse.ca> writes:

>   i don't believe "git reflog" supports "-v", only "--verbose", or am
> i misreading the source?

Ah, then at least you are being (locally) consistent.  Sorry for a
remembo.

As to (global) consistency, in the oldest time we tried to list
every options (but only in the fully spelled form, IIRC) in the
synopsis section, but later with the proliferation of options, it
became more common to use the generic "git subcmd <options>..." form
in synopsis and leave not just the description but also the
enumeration of the options to the description part of the docs, so
we ended up with a mixture in the documentation set.  Aiming for
global consistency is a very good thing, and we need to decide what
model to adhere to and stick to it to the end.  If you want to carry
the torch and declare that we would list every option and every
short-hand (but not "--v", "--ve", "--ver", ..."--verbose" for
obvious reasons), I personally am fine with that.
