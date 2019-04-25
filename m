Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0BDC51F453
	for <e@80x24.org>; Thu, 25 Apr 2019 00:59:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728601AbfDYA72 (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Apr 2019 20:59:28 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51181 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726455AbfDYA71 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Apr 2019 20:59:27 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id ADB4C5DC48;
        Wed, 24 Apr 2019 20:59:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=rN0eReVuVLgGryzhZikXnCCt4Fw=; b=TmL3yz
        8YhxMBe9TpzUIHdZWkHUOvwRxgt5aTew5WzBjgV1qAP52G2HHU9J+HAneQ8mkCH3
        uK1q9A0d5KZn/iW9yVgi0T1rAskWo/olB71ta5aJ1x0g2usgIagA4Z6RqDpepr7r
        oDf4LYAC1ZKlZBodICee1+rhCqN3zRcFtOhGA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XvsD4lOUIlL/8h9NbPUW6UAxD0ESVk/W
        cR2dICSjp15xE7VvZ9BDdg6Ci4p408MWwhJJvo2BR0xGQnbjtVKIJgv5ZHJajfAN
        AAwUUQaZ2qDnngKYCJHlVagrvLd+IWNaN5Vjzek/8sQLpj53OyBwzVgBebAVNS/2
        qWtFt7+C3hs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A4B285DC47;
        Wed, 24 Apr 2019 20:59:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id DAE205DC46;
        Wed, 24 Apr 2019 20:59:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>
Subject: Re: [PATCH/RFC] Makefile: dedup list of files obtained from ls-files
References: <xmqqy343a43b.fsf@gitster-ct.c.googlers.com>
        <20190422144927.GA6519@sigill.intra.peff.net>
        <20190423202109.GA8695@szeder.dev>
        <xmqqlg0043km.fsf@gitster-ct.c.googlers.com>
        <20190424112550.GC8695@szeder.dev>
        <CAPig+cSU5L2NDgMPJ4PG2nd8j9=Pe_LXxukDsFmZTiV2wf-4EA@mail.gmail.com>
Date:   Thu, 25 Apr 2019 09:59:20 +0900
In-Reply-To: <CAPig+cSU5L2NDgMPJ4PG2nd8j9=Pe_LXxukDsFmZTiV2wf-4EA@mail.gmail.com>
        (Eric Sunshine's message of "Wed, 24 Apr 2019 13:19:40 -0400")
Message-ID: <xmqqk1fizyqf.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5D41F128-66F5-11E9-AA92-D01F9763A999-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> As a person who rarely, if ever, uses git-ls-files, I'm having trouble
> understanding why de-duping isn't the default behavior when the
> listing is otherwise not annotated (that is, when -t/-v/-f/--debug are
> not used).

It was because the implementor of the original was bold enough to
say "if it hurts, don't do it" to those who try to combine flags
that may produce overlapping result that lead to duplicates.



