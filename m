Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40F7020373
	for <e@80x24.org>; Mon, 13 Mar 2017 19:47:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752455AbdCMTrb (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Mar 2017 15:47:31 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58024 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750859AbdCMTr3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2017 15:47:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E1DD681ECE;
        Mon, 13 Mar 2017 15:47:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HicClmFZWAaO5bypXSisSgaSjrY=; b=rzpyNn
        H3Jea1Lo1W8zUAsFiZQmIr5UAvDEVppJzWcy5mNNnvBJhufPzwor1lrWCPAXdfcW
        48YOBNVRjHPv2grI113GUCVgi3z8IVwArtPiCAuzf+qnwDEE3zEl93vOEDxtiIw8
        kVr6yaL/OseqGHM+oa5qK0a2xOpOZ7ocBrUMI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wN6KnvQWU4W/W20/H7irjr7l1Wjl7nGq
        +oc8xDRAAKB2nkYRXyFgO30NGlA3qGdreIVtq4LxdvrjbwC7XfHMVJhecxYekiAd
        WRAd3Dl7xOO/Bi9QAzel/4KrbmKHolrw1EwgD3p6C5IH4JUKnEwcqmGGlhnj6ZJa
        Z5dU9XYE+5s=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DA2F681ECD;
        Mon, 13 Mar 2017 15:47:27 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 486DF81ECC;
        Mon, 13 Mar 2017 15:47:27 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Brandon Williams <bmwill@google.com>
Subject: Re: [PATCH v5 10/11] setup_git_directory_gently_1(): avoid die()ing
References: <cover.1488897111.git.johannes.schindelin@gmx.de>
        <cover.1489098170.git.johannes.schindelin@gmx.de>
        <a1e24f1b31773f4d2f7f06ab7d5870e920211d51.1489098170.git.johannes.schindelin@gmx.de>
        <xmqqefy5yn4k.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1703131826330.3767@virtualbox>
Date:   Mon, 13 Mar 2017 12:47:26 -0700
In-Reply-To: <alpine.DEB.2.20.1703131826330.3767@virtualbox> (Johannes
        Schindelin's message of "Mon, 13 Mar 2017 20:38:41 +0100 (CET)")
Message-ID: <xmqqzigpq7qp.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E305B80C-0825-11E7-91B3-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> PLEASE NOTE: the purpose of this patch series is to allow the same
> function (setup_git_directory_gently_1()) to be the work horse for
> setup_git_directory() as before, but also for the new
> discover_git_directory() function that is introduced to fix
> read_early_config() to avoid hardconfig .git/config.
>
> The purpose is *not* to change any current behavior. Please do not ask me
> to do that in this patch series.

Please note that pointing out potential problems is only asking for
confirmation ("yes that is bad") or for enlightenment ("no, you are
reading the code wrong and that bad thing does not happen
because...").  Even in the former case, unless the badness is
introduced by the change, pointing out potential problems is *NOT*
asking to change the patch to fix existing issues.

The former case may split into two.  "Yes I agree that is bad and it
is the same badness as the version without this change", in which
case we may want to leave a "NEEDSWORK" comment in-code so that
people can notice when browsing the code (but fixing the badness
would be outside the scope of the series), and "yes that is bad and
we shouldn't introduce that badness", in which case we do want to
fix it in the patch.

So do not read my (or anybody else's) reviews as _asking_ changes
and making further fixes, and you'll do better.
