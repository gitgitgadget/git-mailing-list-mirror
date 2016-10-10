Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C565F20989
	for <e@80x24.org>; Mon, 10 Oct 2016 17:46:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753015AbcJJRqS (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Oct 2016 13:46:18 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61457 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752870AbcJJRqR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2016 13:46:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CFED644B59;
        Mon, 10 Oct 2016 13:46:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=O4j/4jpib8tgJlmeeXsWWxr0Kgs=; b=ULNGQH
        CqAeu9PbMiasIWtNOIsyohTkYHCuDekEc1OEFbb+AP94n6AahAD9BThWJI/5CCn3
        68tnwC0M8TJb51rwnaWHFJ9/buL7H3Yy3JmrbZ0EoCQKJq0rP9zqLv47Rz6hLeZN
        WNGWo0vKOGvGPGJohOkwinJwht2D+1cQ41HnY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qp5bnX2Us62f4wdcKA2syiIR9fzCa1ke
        wXlQ7xyLccg6aLfzTercue0K6DIjLv0ckgwPDEYsSvdATqKzqVIPxXKvA382SYqa
        bpvUQtUvU//3gYWrQZPXs3pqHNpykiv3qfMdpak7vL/8KHrdkiWYB8fnVYVuH5Ed
        Ox/G4IxA5ro=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C7C2644B58;
        Mon, 10 Oct 2016 13:46:16 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3AD7A44B52;
        Mon, 10 Oct 2016 13:46:16 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeremy Huddleston Sequoia <jeremyhu@freedesktop.org>
Cc:     t.gummerer@gmail.com, git@vger.kernel.org
Subject: Re: git 2.10.1 test regression in t3700-add.sh
References: <A433322C-2B75-4B4B-A8CC-BAC3179EE7A7@freedesktop.org>
        <98EB348E-221D-488C-A466-1FACB1C768FF@freedesktop.org>
        <6CA5F44F-38C1-4C15-9B85-FE84FB93E616@freedesktop.org>
        <49BF26B2-8E6D-40B1-87A2-1FDDF9A76B8E@freedesktop.org>
        <xmqq8ttwgkyo.fsf@gitster.mtv.corp.google.com>
Date:   Mon, 10 Oct 2016 10:46:14 -0700
In-Reply-To: <xmqq8ttwgkyo.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Mon, 10 Oct 2016 10:41:51 -0700")
Message-ID: <xmqq4m4kgkrd.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 717BF828-8F11-11E6-BE29-F99D12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> ...
> I also notice that the problematic test uses "chmod 755"; don't we
> need POSIXPERM prerequisite on this test, too, I wonder?
>
> Thanks.
>
> -- >8 --
> t3700: fix broken test under !SANITY
>
> An "add --chmod=+x" test recently added by 610d55af0f ("add: modify
> already added files when --chmod is given", 2016-09-14) used "xfoo3"
> as a test file.  The paths xfoo[1-3] were used by earlier tests for
> symbolic links but they were expected to have been removed by the
> test script reached this new test.

Eh, "removed by the time test script reached..."
