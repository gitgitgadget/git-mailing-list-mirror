Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0AC6B20373
	for <e@80x24.org>; Mon, 13 Mar 2017 23:15:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754719AbdCMXPS (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Mar 2017 19:15:18 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57244 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752554AbdCMXPQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2017 19:15:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3DA6784761;
        Mon, 13 Mar 2017 19:15:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=JpF3g/vyHTRZp/KEC/o7Ydw5Ins=; b=gFKpPy
        92L/5L7JUkISpuZGTlPYMHu08DAUdrSRUirqRJPZYQrhgCUcB/CRrs7tK74hJpn1
        X2+WQR61PaP2OPxGTPNb6FKlZ+A1DBk4kJeMh8ov0TvZMhiZQUvaeV2DhSXe7wuE
        P0f4ZAWBUZpoltwuMn0keX2cfEBlHSQGVvk1g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=SKBbYEF/38OF8rdGrS0Ry+9ItIG8W7TW
        rPt2b6vzIzCeFs4eCemTqAWXeIfCk+5bs7eYlLZOUDTxl+5SRntiUYgNMERZUp/n
        4B+N/1madl1kzHHzQ8NGx8jhNWjrswimQGjzBRfFK2t0OXh6vkCNDC3cclqFU7BF
        YVgb3mxwLeY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3643C84760;
        Mon, 13 Mar 2017 19:15:09 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 963B08475F;
        Mon, 13 Mar 2017 19:15:08 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Domagoj Stolfa <domagoj.stolfa@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: Possible git blame bug?
References: <20170313201104.GA32821@workstation>
        <xmqqmvcorjyo.fsf@gitster.mtv.corp.google.com>
        <CAPc5daVRX_-bJ_2reDLKJin9PNfy6EjbD14T=Mpx=9P8xzdmuw@mail.gmail.com>
        <20170313214400.GA98717@workstation>
        <xmqqfuign7jw.fsf@gitster.mtv.corp.google.com>
        <20170313230810.GA80865@workstation>
Date:   Mon, 13 Mar 2017 16:15:07 -0700
In-Reply-To: <20170313230810.GA80865@workstation> (Domagoj Stolfa's message of
        "Tue, 14 Mar 2017 00:08:10 +0100")
Message-ID: <xmqqtw6wlqf8.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E682A7E8-0842-11E7-8DCF-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Domagoj Stolfa <domagoj.stolfa@gmail.com> writes:

> Thanks for clearing this up. Is this documented somewhere, so that if it happens
> again I can point people to the docs that explain this behaviour?

Is this from "git blame --help" sufficient?

    When you are not interested in changes older than version
    v2.6.18, or changes older than 3 weeks, you can use revision
    range specifiers  similar to 'git rev-list':

            git blame v2.6.18.. -- foo
            git blame --since=3.weeks -- foo

    When revision range specifiers are used to limit the annotation,
    lines that have not changed since the range boundary (either the
    commit v2.6.18 or the most recent commit that is more than 3
    weeks old in the above example) are blamed for that range
    boundary commit.

