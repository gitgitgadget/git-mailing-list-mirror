Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 831D81FD99
	for <e@80x24.org>; Mon, 29 Aug 2016 18:09:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755381AbcH2SJ2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Aug 2016 14:09:28 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53558 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755068AbcH2SJ1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2016 14:09:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id ADD553AD9A;
        Mon, 29 Aug 2016 14:09:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qABwdM9DTkRseRJZgkdqZtUANpU=; b=Jk1sF0
        BmYR9XSTRHGhZjEH5PDhXpSxKbW7kwmzBwfzMpRUK/dZplebV7G+H5gA4zxLjhFz
        Cv0NWwFcix1HjKyupw4KeB6SHZpFE1e2QXcqznicwxep63DsqYyxVwYyoN+SFLBd
        LpBrNJ/GztI4dmuMmRzRzZmh28qP3x7rqzewk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xGyyniGqeowF5hL9Hrgy8QRdVPMYGZ9l
        MZqBboD6XmF52L4EoU1wix0qiql/gdM5HfFOicD6tXBuOjgQMlSGis7wXWmpc0/7
        Hx3xsJxmpM5RYGJ+hJHYr+U7WRYWke1YUUHAeBCc7Ak8t6k9wINbVDlQkjEiNUYZ
        /5sq6+I49gY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A40963AD99;
        Mon, 29 Aug 2016 14:09:26 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2587A3AD97;
        Mon, 29 Aug 2016 14:09:26 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Stefan Beller <sbeller@google.com>, Johannes.Schindelin@gmx.de,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        Martin-Louis Bright <mlbright@gmail.com>
Subject: Re: [PATCH v6 00/13] Git filter protocol
References: <20160825110752.31581-1-larsxschneider@gmail.com>
        <D7C1480E-8FF4-4EA5-BA77-7A4672853614@gmail.com>
Date:   Mon, 29 Aug 2016 11:09:24 -0700
In-Reply-To: <D7C1480E-8FF4-4EA5-BA77-7A4672853614@gmail.com> (Lars
        Schneider's message of "Mon, 29 Aug 2016 17:39:31 +0200")
Message-ID: <xmqqtwe3bg6j.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B8A06AD2-6E13-11E6-8114-F7BB12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> writes:

>> On 25 Aug 2016, at 13:07, larsxschneider@gmail.com wrote:
>> 
>> From: Lars Schneider <larsxschneider@gmail.com>
>> 
>> The goal of this series is to avoid launching a new clean/smudge filter
>> process for each file that is filtered.
>> 
>> A short summary about v1 to v5 can be found here:
>> https://git.github.io/rev_news/2016/08/17/edition-18/
>> 
>> This series is also published on web:
>> https://github.com/larsxschneider/git/pull/10
>
> Hi Junio,
>
> I am working on v7 of this patch series and I noticed that is does
> not merge clean anymore (not even with git/git master). Should
> I rebase my patch series? If yes, what would be the most
> convenient base for you?

Depends on what you are conflicting with. I think you want to use
something that has at least 05d1ed61 ("mingw: ensure temporary file
handles are not inherited by child processes", 2016-08-22).  Perhaps
2.10 final?
