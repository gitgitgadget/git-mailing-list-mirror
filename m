Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 93D391F935
	for <e@80x24.org>; Wed, 21 Sep 2016 16:24:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757305AbcIUQYw (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Sep 2016 12:24:52 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60620 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752360AbcIUQYv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Sep 2016 12:24:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2E1293C4FA;
        Wed, 21 Sep 2016 12:19:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hPAxYDEIwmD83YxMmewlPeeDRGU=; b=CR9OTq
        rEsCnnbcz4to71ERURv45mLgIxJTGZZdbeZcHQCo9RsPqamMvw08XwztfywoI0qT
        pSOWaWz5EvBNZzxjq3q7+8hf95ylnWFVn/9Srgou29tEIdubpmpBHzMARXblxv1t
        l5MnbolAJZpecpsaeFEMUpyNzVEV5smjpR25o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wwx2aJ2foZn0UoksuRb6EaX3y2sSUw6e
        AWKPpvf6IiwNHuoxPEVGNDtUvsE1M8wMb0i/9pO7f56JfGy3h+5dI2R+Rw3uLqwN
        jVqq1mz0h4etk6io4fgaMHZFYq+EtU3gw7Vfi33+HrodW6+BBcCv+oR4ZTdVj/E1
        rx+gauo3ov0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 258183C4F8;
        Wed, 21 Sep 2016 12:19:07 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 99BCC3C4F2;
        Wed, 21 Sep 2016 12:19:06 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Leandro Lucarella <leandro.lucarella@sociomantic.com>
Cc:     <git@vger.kernel.org>
Subject: Re: 2.10.0: git log --oneline prints gpg signatures in 4 lines
References: <20160920170954.38b24284@labs-064.localdomain>
Date:   Wed, 21 Sep 2016 09:19:04 -0700
In-Reply-To: <20160920170954.38b24284@labs-064.localdomain> (Leandro
        Lucarella's message of "Tue, 20 Sep 2016 17:09:54 +0200")
Message-ID: <xmqqh999b4zr.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1E8B813C-8017-11E6-AE66-C26412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Leandro Lucarella <leandro.lucarella@sociomantic.com> writes:

> Hi, starting from 2.10.0 I noticed that when using git log --oneline,
> if commits are signed with GPG, now the signatures are printed too, and
> it takes 3 lines for the signature information + 1 line for the title
> of the commit, so suddenly --oneline became --fourline :)
>
> Is this really intended?

I think so.  The documentation for --oneline may say "one line per
commit" but in reality, some things cannot be expressed on one line.
It should probably be described as "commit object name and its log
message is formatted to be on a single line" without limiting other
things that the user may have asked to be shown.

And show-signature is an example of what the user additionally can
ask that cannot be fit on a single line.  There probably are others.




