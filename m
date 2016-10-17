Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 41D8E1F4F8
	for <e@80x24.org>; Mon, 17 Oct 2016 17:51:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934016AbcJQRvy (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Oct 2016 13:51:54 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64911 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932125AbcJQRvx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2016 13:51:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EB7E344DAB;
        Mon, 17 Oct 2016 13:51:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=5whbkvoLAc12DAy6iNOGtn5l21c=; b=P3o7em
        HtCFcZhXJ6gYnSvDCbYAg3Usxb7csnuy+ZmLKXOGSBdzS4Kplyx6wcnW/phzqdqZ
        f9yExPmj9BJrQ6EenaHHA6+Gob/Q3zhWLwlUK5KQCiYNeoCgFoVy/3Ew9B2ZjPWi
        +O9bQEdXlAl6nX1XzLFF+HXZHxrZUf5gp1tus=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=j+5BBG0LsdkP7C05s84Tfe94IF8fh/79
        BETb/XbqeQ2K0Q48o9vK1PKSyL3PXJLb+l3ey1fFne2U5yJ98607YQSRVEqbH939
        vw3/VfBLptM5gxJDEzGt0ONwrKI0X9fTSQXhQen5UMAeup15vnjd7AmTdYN/cLfz
        op82fnfyq10=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E37DA44DAA;
        Mon, 17 Oct 2016 13:51:51 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6557244DA9;
        Mon, 17 Oct 2016 13:51:51 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        me@ttaylorr.com
Subject: Re: Merge conflicts in .gitattributes can cause trouble
References: <248A6E81-8D5C-4183-9756-51A0D5193E3E@gmail.com>
        <alpine.DEB.2.20.1610171803400.197091@virtualbox>
Date:   Mon, 17 Oct 2016 10:51:49 -0700
In-Reply-To: <alpine.DEB.2.20.1610171803400.197091@virtualbox> (Johannes
        Schindelin's message of "Mon, 17 Oct 2016 18:11:00 +0200 (CEST)")
Message-ID: <xmqqvawqvp6y.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6228F46C-9492-11E6-AEE8-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> I would vote for:
>
> 4. We keep letting Git read in the *current* version of .gitattributes
>    *before* the merge, and apply those attributes while performing the
>    merge.

Even though this needs a major surgery to the way the attr subsystem
reads from these files, I think it is conceptually the cleanest.
