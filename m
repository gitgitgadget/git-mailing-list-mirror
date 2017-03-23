Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5613620958
	for <e@80x24.org>; Thu, 23 Mar 2017 19:02:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932743AbdCWTCS (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 15:02:18 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58407 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932166AbdCWTCR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 15:02:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C55A665089;
        Thu, 23 Mar 2017 15:02:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=JIRF1pzK6DykiCMConS0utdWbys=; b=VIEnbU
        dA4pfJfgXO3ejX5gQlPWsA8sHwpYfV3Mhf60nz8Tx86+uJWOoNfGmAXZyTjqSlwN
        sZ8RjtVYpIFZFzlM5ZK5tcKF0ozAs2HEDISp6DuX+FxugKt09HWGZYMYOcU1rVE4
        bEWi0X4JgI2wVj7ZfEvcgvX7vIR2XR7LHXYsM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=yUpJt+eebOHuiRaxFHgue6XfNNei3Cwy
        +N+UR608uf+Kmx66xUoelo1/vVxcQfut3DKS0LZPZ/wh4NzgaJd4l6wlKLN1f2Et
        lphRMg05Q8bvrBXVJN+itjOxafO22b5t4+VuirvfH5m0XrrpZbk5okam29MTxfRI
        Bkr8iXR1p4k=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BDF1765088;
        Thu, 23 Mar 2017 15:02:15 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 21A0765087;
        Thu, 23 Mar 2017 15:02:15 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: USE_SHA1DC is broken in pu
References: <CA+55aFzJ3NFVoN6K9__nM_LWYfegxGo_YxB0OudTNBCG+qq+3Q@mail.gmail.com>
        <2B1DE627-11C8-4FA5-A354-76B6C475666A@gmail.com>
        <FFC0EFBD-C4D9-4FB8-A45D-7B10689724A1@gmail.com>
        <alpine.DEB.2.20.1703212105030.3767@virtualbox>
        <xmqqh92mo06a.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1703221530040.3767@virtualbox>
        <20170322220246.GD26108@aiede.mtv.corp.google.com>
        <alpine.DEB.2.20.1703231724350.3767@virtualbox>
        <CA+55aFyFS2r6isdQU_i5FUQnrzjvWhZdmEVE=KmBVTrMukBbkw@mail.gmail.com>
        <20170323174750.xyucxmfhuc6dbrzc@sigill.intra.peff.net>
Date:   Thu, 23 Mar 2017 12:02:14 -0700
In-Reply-To: <20170323174750.xyucxmfhuc6dbrzc@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 23 Mar 2017 13:47:50 -0400")
Message-ID: <xmqqk27fddft.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3A964B90-0FFB-11E7-BCDA-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>   Side note: I also have a feeling that any operation that cares about
>   non-object sha1 performance is probably ripe for other, bigger
>   optimizations. If you update 300MB worth of index entries, then the
>   cost of computing a checksum over it isn't a big deal. But if you have
>   a 300MB index file and you update one entry (or you just want to read
>   one entry), maybe we ought to consider solutions that don't involve
>   the whole 300MB in the first place. I know that's a much harder change
>   because it may involve new on-disk formats. But it seems like that's
>   the right long-term path forward.

Yes ;-)
