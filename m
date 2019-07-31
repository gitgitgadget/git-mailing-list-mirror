Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D8901F731
	for <e@80x24.org>; Wed, 31 Jul 2019 17:15:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729956AbfGaRPM (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jul 2019 13:15:12 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60486 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728879AbfGaRPM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jul 2019 13:15:12 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 19B776AE57;
        Wed, 31 Jul 2019 13:15:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4gOLNhqe8Vy3kIyZTanAsJo9+EY=; b=W0Y18E
        vFanhpXMZZ3LnpKT172gJKFuzdLNyGepatL5czdcndfRpq3TC4z4/g5aP5eroQxb
        tSaoyeuYZuaZZD4UjRqJ3rsKcvflito1cPL8SP+AIdzk6wonY+3C7Hn0K3tMMBPw
        AndGaG9AhD+wfk7sl8UhwDSzOqIWbkvLGisn0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=PvCW4daP6/Ej4PIS18JW7MtaFT1Xfsnj
        KBqA9ez6n8pmL5c8lZmfBMjYhhByANs4YTJlpV7HoycOURvTp/cJHnarWavRF3mw
        DNUXNKCUNsc5EiLSVliS7chFRMlAyqPfgYv2cCxnGF2FJ4G1hoUADUR+3HwOlnh+
        5OwkZOKxZM8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 124BC6AE56;
        Wed, 31 Jul 2019 13:15:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 005D46AE54;
        Wed, 31 Jul 2019 13:15:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Cc:     git@vger.kernel.org
Subject: Re: Support for --stdin-paths in commit, add, etc
References: <a38bc928-7ccd-e2d9-b89b-23298e9fa95d@syntevo.com>
Date:   Wed, 31 Jul 2019 10:15:03 -0700
In-Reply-To: <a38bc928-7ccd-e2d9-b89b-23298e9fa95d@syntevo.com> (Alexandr
        Miloslavskiy's message of "Wed, 31 Jul 2019 17:45:12 +0200")
Message-ID: <xmqqa7cuqg6g.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BDBC8E6A-B3B6-11E9-9624-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com> writes:

> In our git UI, we sometimes run into OS commandline length limit when
> trying to specify a list of pathspecs. For example, this happens when
> user selects a large set of files and wants to commit them. As a
> workaround, we split files and issue multiple git commands.

Yes, for plumbing commands meant for scripting, we really should
strive to give scriptors way(s) to avoid the command line limit,
and --stdin-paths is a very good approach to do so.

