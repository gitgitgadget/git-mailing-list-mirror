Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DDE121F461
	for <e@80x24.org>; Thu, 22 Aug 2019 21:34:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390782AbfHVVef (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Aug 2019 17:34:35 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57398 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732656AbfHVVef (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Aug 2019 17:34:35 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6AADA715FD;
        Thu, 22 Aug 2019 17:34:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=lPwAex2At+n115zaiSXvWJs8bZE=; b=p+kCXF
        YjjGuxQvjvDOi+DSR+zIJEPYz15wjoY5313XDNWBg9aO5I/qW1pctDFp4uOKM/v2
        fJg/eA6sSXmDdUN0KafYi9V6/JCiNzrZnLxYR3HPbrgNXqffZhbJxySRAbWcOxrr
        hZUnHpHLAwX907sgnzwYw+NVWGNVX5xBoFt1I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=SJeDMObvstp7Ni6HbskumPB3MGwxfj9/
        r9oxnFtjhkgHjMyiZrtKQ9YGqIF4W/yGVdF7p46l6sbGNR0++1TRX5+74hZumlVa
        oo48QIBT5dozROTjgzJNiJ8XGj416AFkFH0+rtb8vogrWUlQMyd5jjeSoSbnKmFt
        OaEN8gqUEY4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 63224715FC;
        Thu, 22 Aug 2019 17:34:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 89404715FB;
        Thu, 22 Aug 2019 17:34:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmo=?= =?utf-8?B?w7Zyw7A=?= Bjarmason 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: RFC: Proposing git-filter-repo for inclusion in git.git
References: <CABPp-BEr8LVM+yWTbi76hAq7Moe1hyp2xqxXfgVV4_teh_9skA@mail.gmail.com>
        <xmqqlfvlne3k.fsf@gitster-ct.c.googlers.com>
        <CABPp-BFK65qL4GCs5bFuiPPYwMCDYrxMyYejacVS89d2GK4nDQ@mail.gmail.com>
Date:   Thu, 22 Aug 2019 14:34:28 -0700
In-Reply-To: <CABPp-BFK65qL4GCs5bFuiPPYwMCDYrxMyYejacVS89d2GK4nDQ@mail.gmail.com>
        (Elijah Newren's message of "Thu, 22 Aug 2019 14:12:42 -0700")
Message-ID: <xmqqd0gwopej.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A006735C-C524-11E9-824D-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> Ooh, if you're going to open this door, then a proposal I assumed
> would be shot down but which I'd be just about as happy with is:
>
>   * Remove git-filter-branch from git.git.  Mention in the release
> notes where people can go to get it.[1]
> ...

Yup, I think, especially given now filter-repo exists and is well
known by Git users, this is a good move in the mid to longer term.

> For as long as git-filter-branch is part of git.git and other tools
> are outside, people will take that as a strong endorsement from us for
> filter-branch and use it regardless of how much other education
> exists...and that causes problems.

Exactly.
