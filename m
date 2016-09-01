Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB5A31F6BF
	for <e@80x24.org>; Thu,  1 Sep 2016 21:04:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756388AbcIAVEw (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Sep 2016 17:04:52 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57493 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751214AbcIAVEv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2016 17:04:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6A3883A190;
        Thu,  1 Sep 2016 13:48:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3GpHhXzm5NAAKlynQZfFzo0MAF8=; b=wSZWQ5
        LuKnyzKL2mAXYYI19+5q7AAlahBZF3Yt7HX0HL3217KM1eTwfHnH774nTjAlMIEZ
        0Tb7dmEmlZ9ULtctjrU0i6D619MKOXWp9w3l8anIQqvua9RfkdGVeQaXwuwnptZg
        6THF1bfyUix9qSt7uGyM9TEVlMvNrkMwN5Pv8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=e6yg7mb2Hp1gjb3NK36mNwxk8UUCb9Ll
        Uo5/Av/0X8FskYgRtQCx6xa6vgzPnZ7mgdu3add4bYeLdHluZKL1BRB/BS8H0Gq0
        gZzUFrlIZ41fPpdi5t5+Wmk2VaB2XT0MEgT7pCngu1SqQmd14Q9RUMN7IPgUHC0x
        sAuBpkNH7c4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 607CE3A18F;
        Thu,  1 Sep 2016 13:48:22 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DB0533A18A;
        Thu,  1 Sep 2016 13:48:21 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2?= =?utf-8?B?YXIgQXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Sixt <j6t@kdbg.org>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Stefan Naewe <stefan.naewe@atlas-elektronik.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v13 00/14] libify apply and use lib in am, part 3
References: <20160827184547.4365-1-chriscool@tuxfamily.org>
        <xmqq7fazbdmk.fsf@gitster.mtv.corp.google.com>
        <CAP8UFD20GY0h8n-7oJp8zhjHPUeKSkcEkNrOMuyGBrtS8JE6Jg@mail.gmail.com>
        <xmqq1t14zit7.fsf@gitster.mtv.corp.google.com>
        <CAP8UFD3wA32eXYq3F4=KS-9SkV48Yh45TKgFnn3AmGVfpjwWjA@mail.gmail.com>
Date:   Thu, 01 Sep 2016 10:48:19 -0700
In-Reply-To: <CAP8UFD3wA32eXYq3F4=KS-9SkV48Yh45TKgFnn3AmGVfpjwWjA@mail.gmail.com>
        (Christian Couder's message of "Thu, 1 Sep 2016 10:28:53 +0200")
Message-ID: <xmqqzinrwly4.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 464F352A-706C-11E6-87AB-F7BB12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> Following Stefan's review, it looks like I will need to resend at
> least 02/14, 10/14 and 14/14.
> What do you prefer me to resend:
> 1) all the last 40 or so patches
> 2) the last 14 patches
> 3) only the few patches that changed

If this reroll is to be the candidate to be the final one, I'd
prefer to see 1 to give an easy access to more sets of eyes, but if
you just send them without giving these patches one more read-over
before sending them out, it is not as valuable as it would be.

I think 2 is of the least value.

If you do 3., pointing people at where the remainder of the series
can be found is necessary.
