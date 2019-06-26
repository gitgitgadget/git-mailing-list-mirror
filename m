Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F8861F461
	for <e@80x24.org>; Wed, 26 Jun 2019 18:05:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbfFZSFC (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Jun 2019 14:05:02 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54111 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbfFZSFC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jun 2019 14:05:02 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8F39416B293;
        Wed, 26 Jun 2019 14:04:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/RYBqBp8YaKOqcZTqoVj/6VuFUM=; b=cBSU2d
        /nsloqPYLVKa+/GXYJzdjVjwRds1QnX4Xhbgxg0N2GVRl/j3K8463xjS0Vd+T6WF
        hCZ4utpccUph3b6YbOtCiLAfIi1vnT4unf2p/a9uMtJbVR9/S68838zQTcvspU6a
        WWZ+OVyRHM3bUecmyuBoAk+N9sqT+E0+o6G8I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=JtAa8YWK5FIdHkUchmGA6YVknmQ9LyhJ
        yEjJlV85w3MAmjVCkyPUm0yJ1nfBktqEYTYZh1GqzpRbzhAZmSw9ZY4hGwVVWM5W
        6MJ82zYjSzuPJCNBwhvv8BmEdOcP9WcEl7c1yF6uUh+jJinSMfLOpzr1UAeK+S5O
        1Q7lotS6u08=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 85B6F16B292;
        Wed, 26 Jun 2019 14:04:57 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E546916B291;
        Wed, 26 Jun 2019 14:04:56 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Matheus Tavares <matheus.bernardino@usp.br>, git@vger.kernel.org,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnI=?= =?utf-8?B?w7A=?= Bjarmason 
        <avarab@gmail.com>, Christian Couder <christian.couder@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Olga Telezhnaya <olyatelezhnaya@gmail.com>,
        kernel-usp@googlegroups.com,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Daniel Ferreira <bnmvco@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [GSoC][PATCH v7 06/10] dir-iterator: add flags parameter to dir_iterator_begin
References: <cover.1560898723.git.matheus.bernardino@usp.br>
        <5a678ee74de42f1373deeed718fa24d368347d13.1560898723.git.matheus.bernardino@usp.br>
        <nycvar.QRO.7.76.6.1906261528360.44@tvgsbejvaqbjf.bet>
Date:   Wed, 26 Jun 2019 11:04:55 -0700
In-Reply-To: <nycvar.QRO.7.76.6.1906261528360.44@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Wed, 26 Jun 2019 15:34:52 +0200 (CEST)")
Message-ID: <xmqqwoh8cjeg.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E805070A-983C-11E9-B496-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Matheus,
>
> On Tue, 18 Jun 2019, Matheus Tavares wrote:
>
>>[...]
>> +/*
>> + * Look for a recursive symlink at iter->base.path pointing to any directory on
>> + * the previous stack levels. If it is found, return 1. If not, return 0.
>> + */
>> +static int find_recursive_symlinks(struct dir_iterator_int *iter)
>> +{
>> +	int i;
>> +
>> +	if (!(iter->flags & DIR_ITERATOR_FOLLOW_SYMLINKS) ||
>> +	    !S_ISDIR(iter->base.st.st_mode))
>> +		return 0;
>>
>> +	for (i = 0; i < iter->levels_nr; ++i)
>> +		if (iter->base.st.st_ino == iter->levels[i].ino)
>
> This does not work on Windows. [[ Windows port does not have
> usable st_ino field ]]]

And if you cross mountpoint, st_ino alone does not guarantee
uniqueness; you'd need to combine it with st_dev, I would think,
even on POSIX systems.

