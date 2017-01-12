Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA3981FEB3
	for <e@80x24.org>; Thu, 12 Jan 2017 21:49:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750922AbdALVtT (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jan 2017 16:49:19 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56667 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750824AbdALVtS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2017 16:49:18 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7888B5F909;
        Thu, 12 Jan 2017 16:49:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nI6u/rKD2//1D9SYuTQsUZ/0Fyc=; b=cirv/z
        BlzZCUsgCrm9fXihIS7OOCzw+i/ET6+R7/D8isqmVSc9PC4V/ueTWSs7Rb66v2wu
        FyTzg7TuKetKZADIBNqmA0VvdaAzcu3XwQpD36moKMMhlngh1fa0kHIVBlED2r86
        QRJN1l1yRr1tU3OIaVWWqgXT5S2q7Mht55CjI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=dMBGV/Rp3ZsM4pxCezcM6AUbtJFuV46D
        c6jwjgFcd8bIlHnoehCi0YpLunMIafmil0XFrTqjMGE8pAzqmrw759JrmOgY89Th
        h2/PzwEnn/wwFtJCvHSjj0FzG/3iftCL6vrsx+3na0EWsQAXRNpGEMIb+awpYfRe
        7FDu8x+w3Hw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 707B65F908;
        Thu, 12 Jan 2017 16:49:17 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C0BE05F907;
        Thu, 12 Jan 2017 16:49:16 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Pat Pannuto <pat.pannuto@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
Subject: Re: [PATCH 2/2] Use 'env' to find perl instead of fixed path
References: <20170112055140.29877-1-pat.pannuto@gmail.com>
        <20170112055140.29877-3-pat.pannuto@gmail.com>
        <6fe462dd-929a-671b-a210-36ee38e99115@kdbg.org>
        <CAAnLKaGbf9-GAF19+61=7_RfCOBM0=Ounwf8KkL1jS6HX3pOag@mail.gmail.com>
        <alpine.DEB.2.20.1701121118170.3469@virtualbox>
        <xmqqbmvcj9le.fsf@gitster.mtv.corp.google.com>
        <CAAnLKaGvz4Wzs36gMSdoYCg+tzx6KFCe59FNnk5zNQ-L58ww1g@mail.gmail.com>
Date:   Thu, 12 Jan 2017 13:49:15 -0800
In-Reply-To: <CAAnLKaGvz4Wzs36gMSdoYCg+tzx6KFCe59FNnk5zNQ-L58ww1g@mail.gmail.com>
        (Pat Pannuto's message of "Thu, 12 Jan 2017 16:01:59 -0500")
Message-ID: <xmqqpojshrtw.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F70018AA-D910-11E6-AAFB-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pat Pannuto <pat.pannuto@gmail.com> writes:

> You may still want the 1/2 patch in this series, just to make things
> internally consistent with "-w" vs "use warnings;" inside git's perl
> scripts.

I do not think so.  1/2 is justified as a prerequisite of 2/2 and
needs a different log message, so cannot be used as is.

I vaguely recall hearing arguments for and against the choice
between "#!path-to-perl -w" vs "use warnings;" but do not recall the
details to have a strong opinion either way, so we might even end up
wanting to be "internally consistent" by going the other way.  Please
prepare a standalone patch with an update message to convince people
why "use warnings;" is more preferable than "#!path-to-perl -w" and
explaining that we are making things consistently use the more
preferable form, if you want to go in that direction.

Thanks.


