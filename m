Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 33B771F4F8
	for <e@80x24.org>; Wed, 28 Sep 2016 22:23:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933696AbcI1WWw (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Sep 2016 18:22:52 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53137 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933633AbcI1WWu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2016 18:22:50 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C9692412AC;
        Wed, 28 Sep 2016 18:22:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=musCntXroi1TLaVeh+Ljupcxmbg=; b=wA0ohp
        F/oU1vYK/ID/h6mCtvt3CpgZKJBfUvCWtZjdb2UIsBpdMIt5XOJdUSzZry1hAQvG
        3T2n7vdSFwIhbt/sRKkD1HuinBDad9m7ohcUi2lzpR8eYWHg7EFRrBGfOQI9YwL1
        OwLFePZDjW9QFUs5bCHTfal1e7zy9wekuAhsM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=upFwQAuIajPc2TCLuzxTpJm9+qU8sswu
        m9B5emIG0Vd28iN/hEXf3YearnNpZbU+ADGaYeR8JpYbwE00k2sV3pEUXZY0E9SQ
        sB8QyjW/8b37/dteQ8bFeTQ3y6oCryKUf24bkAUEi7eq0xe/L/qZY6GmagSi77Qr
        Ucu9tPjY90c=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AEC71412AB;
        Wed, 28 Sep 2016 18:22:48 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 289E4412AA;
        Wed, 28 Sep 2016 18:22:48 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, peff@peff.net
Subject: Re: [PATCH v5 2/4] ls-files: optionally recurse into submodules
References: <1474930003-83750-1-git-send-email-bmwill@google.com>
        <1475099443-145608-1-git-send-email-bmwill@google.com>
        <1475099443-145608-3-git-send-email-bmwill@google.com>
Date:   Wed, 28 Sep 2016 15:22:46 -0700
In-Reply-To: <1475099443-145608-3-git-send-email-bmwill@google.com> (Brandon
        Williams's message of "Wed, 28 Sep 2016 14:50:41 -0700")
Message-ID: <xmqqvaxfhdft.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 16161A72-85CA-11E6-830A-EAAE7A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> +--recurse-submodules::
> +	Recursively calls ls-files on each submodule in the repository.
> +	Currently there is only support for the --cached mode.

Good to describe it, but at this step, there is only support for the
"--cached" mode and it does not take a pathspec.

Also as the series progresses, I would expect this to be updated in
patches $n/4 (2 < $n).

> +	if (recurse_submodules && argc)
> +		die("ls-files --recurse-submodules does not support path "
> +		    "arguments");

Hmm, s/path arguments/pathspec/, perhaps, as the latter is specified
in the glossary?

