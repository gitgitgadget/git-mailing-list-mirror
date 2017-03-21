Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC7C22095B
	for <e@80x24.org>; Tue, 21 Mar 2017 18:55:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933411AbdCUSzA (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Mar 2017 14:55:00 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59824 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932641AbdCUSxs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2017 14:53:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 918336EFEA;
        Tue, 21 Mar 2017 14:48:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ErPQMvgCMTA+
        va1heFxXijtj5pA=; b=vAORW7D5ks3QSLaca54f9GaTZ0tC/q6P5bYVdK9OIH/e
        sKi1u9auOk+Wl9OV0dY14zolPmtRBq11xC2yaoMDtZ3R3K6MXtCSgPGFLnoI5yZr
        7eixOwHQi64uyjxEGuJ6vPLGaC58t9CfB+SHR1o7BY7CY803nwbJUecFo6mORtM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=mOIWvx
        LnmXr+mlLajaHgoxP9mM44CntumNvVbn842UYI+IPkte9I2p8e803DBfZtQxSnL/
        fZ9Vs5hOibNlzXPWchjIZJ65hJ+ddWpi3JsTPXenD1ZBE5+jnnaLK5JJBvcJIztN
        ecU8Y/qDeyMUNHo/Tzi7N1NzO/dNKjz1gnzZc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 893E46EFE9;
        Tue, 21 Mar 2017 14:48:13 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E0A7F6EFE8;
        Tue, 21 Mar 2017 14:48:12 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Lars Hjemli <hjemli@gmail.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Carlos Rica <jasampler@gmail.com>,
        Samuel Tardieu <sam@rfc1149.net>,
        Tom Grennan <tmgrennan@gmail.com>,
        Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 11/16] tag: implicitly supply --list given another list-like option
References: <20170321125901.10652-1-avarab@gmail.com>
        <20170321125901.10652-12-avarab@gmail.com>
Date:   Tue, 21 Mar 2017 11:48:11 -0700
In-Reply-To: <20170321125901.10652-12-avarab@gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Tue, 21 Mar 2017 12:58:56 +0000")
Message-ID: <xmqqk27ipitw.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: EFC1B52C-0E66-11E7-8360-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Spelunking through the history via:
>
>     git log --reverse -p -G'only allowed with' -- '*builtin*tag*c'
>
> Reveals that there was no good reason for not allowing this in the
> first place. The --contains option added in 32c35cfb1e ("git-tag: Add
> --contains option", 2009-01-26) made this an error,. All the other

s/,././

> subsequent list-like options that were added copied its pattern of
> making this usage an error.

Good digging, and I do agree that this is a good change.

Thanks.

