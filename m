Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9535C1F4C0
	for <e@80x24.org>; Thu, 17 Oct 2019 07:35:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438132AbfJQHdn (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Oct 2019 03:33:43 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60859 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727257AbfJQHdn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Oct 2019 03:33:43 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1DD3B1CF7C;
        Thu, 17 Oct 2019 03:33:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2UagQtl8SjfHTxIk+6iipjVMvhI=; b=dyOMwA
        eIoZ7zyXebnc1up8hmurxPOKGr2Dhq7zMWEKKusYHfBRTJ8TBQLxq7wCFvU60zn0
        dVO2iTEHoJIE7dKZVRnY+Q6m5HJrs/r4iKFSvOHTEUPiSFl8loAd72TBxBA8YPKk
        QOQw+kIzs4X1Ds6aOJ/2xBUz8AZfmuS0e7s2g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=CiS0sa0q/rNAQShLGNs6LYgVyi/dcDJ0
        uaYk+aL0IIvkx9LYnDGSVlh5KmrdFGVURGfZTiwHFDOdRUNRnY9n4iw7b0XQ6kEk
        bRdTFyJAGPJxz4rIOy6sEsBkHbPxb18fotuwMw5IiLyWf18dDaHwRLDIb2P6Yd7s
        kw0lWgKs+hI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 168D71CF79;
        Thu, 17 Oct 2019 03:33:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7416B1CF78;
        Thu, 17 Oct 2019 03:33:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Hariom Verma via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Hariom Verma <hariom18599@gmail.com>
Subject: Re: [PATCH 0/1] builtin/blame.c: bit field constants into bit shift format
References: <pull.382.git.1571250635.gitgitgadget@gmail.com>
Date:   Thu, 17 Oct 2019 16:33:39 +0900
In-Reply-To: <pull.382.git.1571250635.gitgitgadget@gmail.com> (Hariom Verma
        via GitGitGadget's message of "Wed, 16 Oct 2019 18:30:34 +0000")
Message-ID: <xmqqv9sn7rn0.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 709096F4-F0B0-11E9-BEA9-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Hariom Verma via GitGitGadget" <gitgitgadget@gmail.com> writes:

> we are looking at bitfield constants, and elsewhere in the Git source code,
> such cases are handled via bit shift operators rather than octal numbers,
> which also makes it easier to spot holes in the range (if, say, 1<<5 was
> missing, it is easier to spot it between 1<<4 and 1<<6 than it is to spot a
> missing 040 between a 020 and a 0100). Also, bit shifts lead to low-level
> optimizations because they require fewer calculations for the CPU. 

I think the last sentence is a nonsense for any decent compiler that
turns "1<<5" into 040 at compile time and treats it as literal
integer.  Luckily, it only appears here in the cover letter and does
not appear in the patch proper, so no need to resend the patch to
correct this ;-)

