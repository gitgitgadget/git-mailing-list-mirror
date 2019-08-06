Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D208C1F731
	for <e@80x24.org>; Tue,  6 Aug 2019 19:45:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726133AbfHFTpj (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Aug 2019 15:45:39 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61707 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbfHFTpi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Aug 2019 15:45:38 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DFE8B6E2B1;
        Tue,  6 Aug 2019 15:45:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7TBTp4iFJ3ABdB2WUKyP9ga7vyU=; b=xDOh1N
        SrTdO2BdN1t5CwBF2LPi8B27gw61ZXN07LdLjAvRLnvbdySD1N439MaI6JlMb84X
        HjIp11msk4uxj/+qNNfn0+0g10fyZq6D4V2ChmEbRM03dGrppdnFeBaAeE0TxCRr
        qJF0cWJ5JNAPv5yf/ooSjAzkpa78Fd+7KNGzY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=HIYjpGRxlDC7MyQ23X4CUvrJ3O7WhNTy
        xI1ozDaPCBx7NSvSzGA/QuP1QTKUKemP6FfNyLaI1H+UblNmsuA0gaVNC9/YpA0F
        CUuM/zuN7f8gkLwwHVKiMdfYWfYkKY1j4d/U3piNcyYhhIuAQODnQRteE92aXpsL
        pN7FgEliteY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D79406E2B0;
        Tue,  6 Aug 2019 15:45:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id DF6D76E2AF;
        Tue,  6 Aug 2019 15:45:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Cc:     git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v3] l10n: reformat some localized strings for v2.23.0
References: <20190730033512.7226-1-worldhello.net@gmail.com>
        <20190806171952.15588-1-jn.avila@free.fr>
        <xmqqo912ji1k.fsf@gitster-ct.c.googlers.com>
Date:   Tue, 06 Aug 2019 12:45:29 -0700
In-Reply-To: <xmqqo912ji1k.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Tue, 06 Aug 2019 10:54:47 -0700")
Message-ID: <xmqq7e7qjcx2.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C0AD337E-B882-11E9-8617-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> +static char warn_show_forced_updates[] =
>> +N_("Fetch normally indicates which branches had a forced update,\n"
>> +   "but that check has been disabled. To re-enable, use '--show-forced-updates'\n"
>> +   "flag or run 'git config fetch.showForcedUpdates true'.");
>> ...
>> +                  warning(_(warn_show_forced_updates));

This unfortunately triggers a false positive format-security
violation.   Turning it into "static const char var[]" would
squelch it, which I did for today's integration.

