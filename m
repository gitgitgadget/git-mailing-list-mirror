Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 65B4B1F97E
	for <e@80x24.org>; Sat, 24 Nov 2018 02:27:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729919AbeKXNOT (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Nov 2018 08:14:19 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62688 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726505AbeKXNOT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Nov 2018 08:14:19 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 21888346E2;
        Fri, 23 Nov 2018 21:27:39 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=59djNns9utzj
        Evmeks2kJdEi5ck=; b=W1jyk3h2xfgioA3pt6rSpXtH+UinJciHGUnTRT782QN7
        Q+aijvgIarX88FLUb7TXzNfiVkgIc0RMJU0DGllPAVNgd/EXCfJxVEMAAIRTY4eA
        gek2PpbWCZFoCyRBf4iGz042vMyODsQA3CYtyOSj6QQcvFdlChEsky0kQ7BVNi0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=bFftVm
        5Wg/nly437P1VFDOphm7MQOwe3as0AdNDX4d5DSpUzpleNebCR76opJmmDz6cPXH
        nlDG3qeWeVAH+8TfZh1V/f4/TZaFYQhKSvRvillOObrfvhcoWCH4NCYveKBRd7gN
        iJMPALJc4QjIrDECjXb60+c2nLi9oi9PDm0VU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1A364346E1;
        Fri, 23 Nov 2018 21:27:39 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2BA33346E0;
        Fri, 23 Nov 2018 21:27:36 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Thomas Braun <thomas.braun@virtuell-zuhause.de>,
        git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH v1 2/2] log -S: Add test which searches in binary files
References: <590f2ca6b5323c17365a1645b5d10e9ab30623c4.1542833244.git.thomas.braun@virtuell-zuhause.de>
        <84cbbfbd213b358d1e2d7cce8b4685b09efac3de.1542833244.git.thomas.braun@virtuell-zuhause.de>
        <87lg5lzd7i.fsf@evledraar.gmail.com>
Date:   Sat, 24 Nov 2018 11:27:34 +0900
In-Reply-To: <87lg5lzd7i.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Thu, 22 Nov 2018 10:14:09 +0100")
Message-ID: <xmqq5zwn43c9.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 81823156-EF90-11E8-8A59-F5C31241B9FE-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Wed, Nov 21 2018, Thomas Braun wrote:
>
>> The -S <regex> option of log looks for differences that changes the
>> number of occurrences of the specified string (i.e. addition/deletion)
>> in a file.
>>
> ...
> This should just be part of 1/2 since the behavior is changed there &
> the commit message should describe both cases.

Sensible suggestion.  Thanks.
