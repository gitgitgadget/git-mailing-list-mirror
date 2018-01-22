Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 10F261F404
	for <e@80x24.org>; Mon, 22 Jan 2018 20:01:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751140AbeAVUBS (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Jan 2018 15:01:18 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51469 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751126AbeAVUBR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Jan 2018 15:01:17 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AE2CCD56D9;
        Mon, 22 Jan 2018 15:01:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Efq4H1cUHz1t
        M1PmR6eyWXwQbkA=; b=jO3zJv10SH+hxGE1zFmWY97TJZLFHlEAYM99E1vTmzfa
        j8y33Exxg/k7DjVlDTFqhsbc9nJqfULIvMn+Mh0rwhM1Ds26++yszwHYVLbkK9cP
        o+mitU2mO36UPU2dSWGfB+rsOG3c9G+KHRduGFDoOs3hCuA30uy1tFPewSYTcio=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=YRaNvp
        /VqCLYehJH0wTYsJiLHucQjf6oTcRLnZyl+yUY6JFmM7hQjy4zmivdXeyqLzITJ/
        /lHJXKCNDGLEFWTWQ3dfXzi+6dmwT6A8sLNtZshWtFWMujL9BBdGncRvtN0M+VfE
        xuVBudgMd+3x0puECHsn9+1hLA/oDdhiX1uR8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A4832D56D8;
        Mon, 22 Jan 2018 15:01:16 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D33B9D56D7;
        Mon, 22 Jan 2018 15:01:15 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Michael Giuffrida <michaelpg@chromium.org>,
        Michael Schubert <mschub@elegosoft.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 07/12] git remote doc: correct dangerous lies about what prune does
References: <20180121000304.32323-1-avarab@gmail.com>
        <20180119000027.28898-1-avarab@gmail.com>
        <20180121000304.32323-8-avarab@gmail.com>
Date:   Mon, 22 Jan 2018 12:01:13 -0800
In-Reply-To: <20180121000304.32323-8-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Sun, 21 Jan 2018 00:02:59 +0000")
Message-ID: <xmqq7es9mzna.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 01029B0A-FFAF-11E7-A627-8EF31968708C-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> +Deletes stale references associated with <name>. By default stale
> +remote-tracking branches under <name>, but depending on global
> +configuration and the configuration of the remote we might even prune
> +local tags....

An optional clarification

    s/prune local tags/& that haven't been pushed there/

> +... Equivalent to `git fetch <name> --prune`, except that no
> +new references will be fetched.

`git fetch --prune <name>` (dashed options first and then non
options), just like you wrote in the previous step.
