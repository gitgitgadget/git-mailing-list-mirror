Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ACB40207EC
	for <e@80x24.org>; Thu, 29 Sep 2016 17:20:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934212AbcI2RUd (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Sep 2016 13:20:33 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59484 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933853AbcI2RUb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Sep 2016 13:20:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0679540989;
        Thu, 29 Sep 2016 13:20:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=B9bKLk9k57P3
        PM85Ab3Ju37J8h4=; b=TZky29GNMk5uEDDDvOU6jF8sEYdhQZi08O6qh3O8lcIB
        gWDnF4nzGnGzj9fosO5W2UFb7K34Vgz4UyPRB+kSQrCS6DwCIPUnybXofqKqx0c1
        ecQuqkl7ClBbdspI0GrNzrpdbmQfbhXqpLCoQOKTAhS13FXx+AyvhWUMSf0g9h8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=JJ9yoU
        cZRvQRk7wfZK3RIYjoSDagbCuC0yJOJZg1TOB1jGydb2kIdgf2Mje1n2QRH3D38P
        pdtQ7Sdvmy3vHTk6T5nQvHzaLHrQEqBkbY5DTTsaACEFd04AH+ZmH0FTSyIANwvu
        B1GXdWYOiKiYq6ZOgUIvD7oyB4MhvvlIRVQtc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F151540988;
        Thu, 29 Sep 2016 13:20:29 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 760DF40987;
        Thu, 29 Sep 2016 13:20:29 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 1/4] config: allow customizing /etc/gitconfig location
References: <CA+55aFy0_pwtFOYS1Tmnxipw9ZkRNCQHmoYyegO00pjMiZQfbg@mail.gmail.com>
        <20160928233047.14313-1-gitster@pobox.com>
        <20160928233047.14313-2-gitster@pobox.com>
        <f239b2eb-d122-9c4b-187b-fbd40a94bcf4@gmail.com>
Date:   Thu, 29 Sep 2016 10:20:27 -0700
In-Reply-To: <f239b2eb-d122-9c4b-187b-fbd40a94bcf4@gmail.com> ("Jakub
        =?utf-8?Q?Nar=C4=99bski=22's?= message of "Thu, 29 Sep 2016 11:53:10
 +0200")
Message-ID: <xmqq7f9uhbc4.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 05004A88-8669-11E6-A0CC-EAAE7A1B28F4-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jakub Nar=C4=99bski <jnareb@gmail.com> writes:

> W dniu 29.09.2016 o 01:30, Junio C Hamano pisze:
>> With a new environment variable GIT_ETC_GITCONFIG, the users can
>> specify a file that is used instead of /etc/gitconfig to read (and
>> write) the system-wide configuration.
>
> Why it is named GIT_ETC_GITCONFIG (which is Unix-ism), and not
> GIT_CONFIG_SYSTEM / GIT_CONFIG_SYSTEM_PATH, that is something
> OS-neutral?

Isn't "environment variable" something that came from POSIX world?
