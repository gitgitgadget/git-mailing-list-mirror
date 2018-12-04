Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D82B8211B3
	for <e@80x24.org>; Tue,  4 Dec 2018 03:16:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725980AbeLDDQX (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Dec 2018 22:16:23 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50932 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725953AbeLDDQX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Dec 2018 22:16:23 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EDABF10DD7D;
        Mon,  3 Dec 2018 22:16:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=f1Z8Q1VDVkBEsos7dY1Y/IgzGkQ=; b=aTsUpo
        zP4Wkze9tEtKGRzex7TKJjUd8EIGVJLjARiTW6iiyxFD8NLqiO2GZcpjDPPX7LjG
        VC4jEZ8MPCvcHPdwWvD79ir05cpoe2Ow6UE5NRuIVLqx2dWLsJxLBwGBG9N8N7mf
        ccHOssRYhJFOOdCNbZw2qt15SA7pC8vq3S9FA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qlcTmQxyyUDsipCssyzJ6s7esWpkhHHp
        PE0tiSXDHml25UTDjgbFg/I40I8PT5wybl+/icPNpHaaX/9QJG6BvSG4UXP8KFKC
        amDNbw7bEAljDd3Z85Ig16R65d6UTFDC6DigkcgTCeyLF1NVexFNcSgiuD69M+ng
        LCLd8zaS/yI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E583610DD7C;
        Mon,  3 Dec 2018 22:16:21 -0500 (EST)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5BFA410DD7A;
        Mon,  3 Dec 2018 22:16:21 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH] sideband: color lines with keyword only
References: <20181203223713.158394-1-sbeller@google.com>
        <20181203232353.GA157301@google.com>
        <CAGZ79kY0w7Zt0Z4KNu7qL4Lz8fFpv2p51D-w_MgZBYPqPFbZKw@mail.gmail.com>
        <20181203234257.GC157301@google.com>
Date:   Tue, 04 Dec 2018 12:16:20 +0900
In-Reply-To: <20181203234257.GC157301@google.com> (Jonathan Nieder's message
        of "Mon, 3 Dec 2018 15:42:57 -0800")
Message-ID: <xmqq5zwaf0cb.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F9319842-F772-11E8-96EF-063AD72159A7-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> Stefan Beller wrote:
>> On Mon, Dec 3, 2018 at 3:23 PM Jonathan Nieder <jrnieder@gmail.com> wrote:
>
>>> I was curious about what versions of Gerrit this is designed to
>>> support (or in other words whether it's a bug fix or a feature).

Well, bf1a11f0 ("sideband: highlight keywords in remote sideband
output", 2018-08-07) clearly wanted to allow a keyword followed by
anything !isalnum() to be painted, and we accepted that change
because we thought it was a good idea, so anything that made a
keyword alone not to be painted is a bug, isn't it?  Whether output
lines from Gerrit benefits from this fix is a different matter, of
course.

> No worries.  Can't hurt for Junio to have a few patches to apply to
> "pu" or "next" to practice using the release candidates. :)

This change falls into "an obvious and small fix to a bug that went
unnoticed and is in an older release (2.19)" category, which is not
eligible for the upcoming release this late in the cycle.  I think
enough eyeballs looked at the change already, so let's not waste the
already-spent review braincycle and mark it as "Will merge to 'next'".
