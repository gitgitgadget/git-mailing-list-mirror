Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3655120989
	for <e@80x24.org>; Mon, 10 Oct 2016 20:20:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752362AbcJJUT5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Oct 2016 16:19:57 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56442 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751743AbcJJUT4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2016 16:19:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9CBF0451FB;
        Mon, 10 Oct 2016 16:19:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=r0EXr4ZJwXjt
        mR+IIDTyIrf+qCY=; b=nDOiYMOVknO+mM7mBQ9do5OH/ItX+rLkIwCtjCC1unmH
        EtjX0KrPGtJQpXhdYJuxNDAhK0/Yp6x6+tFZnhtsAQYkZZSlibA5QG/zeFWRHOBS
        YCvBtasXf4uvmJESUOARJ2Zjri9Mf1PDDL5Vy+fP+8rdg23lDUySk+/+Y88/AGA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=h3BFwf
        sfmdgPeEavN2ZgVLnWOPBvwumc463bHicGQU8kDT/XjeUOo7glMQbMf2OV4CVBbu
        Utw6geCTEE7tVyrSUe57qRSEPiaeSGZfuiV2rRngl76+F4oqOL2cOeJ3oHR0ToHZ
        qf6EBiiVpUXy/q66OPLHiE2dt4qXfmTD+ek6o=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 96442451FA;
        Mon, 10 Oct 2016 16:19:55 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1D04A451F9;
        Mon, 10 Oct 2016 16:19:55 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     tboegi@web.de
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v1 0/2] convert: stream and early out
References: <20161009095649.1886-1-tboegi@web.de>
Date:   Mon, 10 Oct 2016 13:19:53 -0700
In-Reply-To: <20161009095649.1886-1-tboegi@web.de> (tboegi@web.de's message of
        "Sun, 9 Oct 2016 11:56:49 +0200")
Message-ID: <xmqq8ttwdkie.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: E85D27B8-8F26-11E6-A362-5F377B1B28F4-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

tboegi@web.de writes:

> From: Torsten B=C3=B6gershausen <tboegi@web.de>
>
> An optimization when autocrlf is used and the binary/text detection is =
run.
> Or git ls-files --eol is run to analyze the content of files or blobs.

This looks like a worthwhile thing to do.  Please sign-off the
patches when they are finalized.

Thanks.

>
> Torsten B=C3=B6gershausen (2):
>   read-cache: factor out get_sha1_from_index() helper
>   convert.c: stream and early out
>
>  cache.h      |   3 +
>  convert.c    | 195 +++++++++++++++++++++++++++++++++++++++------------=
--------
>  read-cache.c |  29 +++++----
>  3 files changed, 151 insertions(+), 76 deletions(-)
