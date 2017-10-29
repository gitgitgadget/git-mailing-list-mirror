Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 46C5D2055E
	for <e@80x24.org>; Sun, 29 Oct 2017 00:05:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751460AbdJ2AFu (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Oct 2017 20:05:50 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55534 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751209AbdJ2AFt (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Oct 2017 20:05:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3C74EAC86E;
        Sat, 28 Oct 2017 20:05:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jtbFfuFi+DOen+r6Vtf8o9EVQGA=; b=YT68Qx
        Y6CiGBMNNPQf4JYY8yKvsZsInY1dWbXGqp2n60lqKy58abFS38k3k1/GhWyFCyJA
        rE7OK+7IaV95NS1v1nyuZ8FINz22h+OktczKma9Hb+KQmO/WDOUj849N0VqcaFcA
        evDit0HoK5Bajshr06qD/6sSkRxWDumFNIhYc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=a5tipShMc9ZCTP1jTNh+BXaNzUE6GNUV
        hRij6iICzFRIREvpWIZvUfgXM20uDupc9doc706ZqwHOtRhJascgHSrFl4TZ7SY/
        /lFR8xlg/Jdjr/uYJKGsH+s7zxe8PUfwGiR1FCm0HgpqUCPNawSwu68bMLUEYEdA
        xTEw+pknF74=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 33B6FAC86D;
        Sat, 28 Oct 2017 20:05:46 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A9D4DAC86C;
        Sat, 28 Oct 2017 20:05:45 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH 1/2] t1404: add a bunch of tests of D/F conflicts
References: <cover.1508856679.git.mhagger@alum.mit.edu>
        <be088bd57e61f4ea0dc974a65829a928ecd30534.1508856679.git.mhagger@alum.mit.edu>
        <CAPig+cRLB=dGD=+Af=yYL3M709LRpeUrtvcDLo9iBKYy2HAW-w@mail.gmail.com>
        <20171024194634.pigmvgoqtdexvjhc@sigill.intra.peff.net>
        <e66694a3-98e2-33aa-4cdd-dac41d2a89d5@alum.mit.edu>
        <20171026063250.dckc22ocr3zjmsxv@sigill.intra.peff.net>
        <20171028164249.ufro5weobwadfonv@genre.crustytoothpaste.net>
Date:   Sun, 29 Oct 2017 09:05:44 +0900
In-Reply-To: <20171028164249.ufro5weobwadfonv@genre.crustytoothpaste.net>
        (brian m. carlson's message of "Sat, 28 Oct 2017 16:42:49 +0000")
Message-ID: <xmqqk1zebyxz.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E9596570-BC3C-11E7-9313-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> There is discussion in the Austin Group issue tracker about adding this
> feature to POSIX, but it's gotten bogged down over lexical versus
> dynamic scoping.  Everyone agrees that it's a desirable feature, though.
> ...

In short, unless you are a binary packager on a platform whose
native shell is ksh and who refuses to depend on tools that are not
default/native on the platform, you'd be OK?

> I'd recommend an explicit test for this.  It's much easier to track down
> that way than seeing other failure scenarios.  People will also usually
> complain about failing tests.

Hopefully.  

Starting from an explicit test, gradually using more "local" in
tests that cover more important parts of the system, and then start
using "local" as appropriate in the main tools would be a good way
forward.  

By that time, we might have a lot less scripted Porcelains, though
;-)
