Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C571202A0
	for <e@80x24.org>; Tue, 14 Nov 2017 05:20:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754479AbdKNFUX (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Nov 2017 00:20:23 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53358 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754340AbdKNFUT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Nov 2017 00:20:19 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4257FADC37;
        Tue, 14 Nov 2017 00:20:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4eYA9LrY6WJcFbkVJPT8za8EX8o=; b=Kl7YQ2
        WPXJAlxBAt35vhjHFGErWafm+WHnTvCZlPitUXWYc3VsEsHHOWZMhnvfgQFwwqxz
        pzYhfkZ44xeqGqXgJiGBP0rhP+kecFKENOP2oM+fXlutH90slaE32YDFmcCjU3/b
        TnJrqTMk+gPh8te0hofc/H9ELsOSny35BlvY8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=nLOna8LgWwDrbQ0hNZWwueFqKJLT18Se
        r5CpfnuDwH3XcnWl0M6lvHZTsMSnGVfNrDLyNFjHAUF/DgNHThCvlz9DepzJWA9+
        xnDPx4p+MZ4yegylJMwdHWtheZDk7S67xFxp9IPIv/yWEOoxH5ghF/9g3cbuH6xH
        88RKtStTXr4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3A107ADC36;
        Tue, 14 Nov 2017 00:20:18 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B00B3ADC34;
        Tue, 14 Nov 2017 00:20:17 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 19/30] merge-recursive: Split out code for determining diff_filepairs
References: <20171110190550.27059-1-newren@gmail.com>
        <20171110190550.27059-20-newren@gmail.com>
Date:   Tue, 14 Nov 2017 14:20:16 +0900
In-Reply-To: <20171110190550.27059-20-newren@gmail.com> (Elijah Newren's
        message of "Fri, 10 Nov 2017 11:05:39 -0800")
Message-ID: <xmqqtvxx4esv.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 808FD6CA-C8FB-11E7-895E-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> Create a new function, get_diffpairs() to compute the diff_filepairs
> between two trees.  While these are currently only used in
> get_renames(), I want them to be available to some new functions.  No
> actual logic changes yet.

OK.  

This refactors an easy-to-use (in the context of merge-recursive
code) wrapper to diff-tree out of the existing code, which makes
sense.

