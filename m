Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F645207EC
	for <e@80x24.org>; Thu, 29 Sep 2016 21:17:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934582AbcI2VRc (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Sep 2016 17:17:32 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58050 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933484AbcI2VRa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Sep 2016 17:17:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2D8B542BE8;
        Thu, 29 Sep 2016 17:17:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=bHm+OIJvIKI7
        W5ybphQtMpbLryQ=; b=eRRcPm5AtXsV1AI+UdCo5u+V2VCuKazeheE/b42t1ueW
        P3/kEX9Jw6bFVb3JT6czUgSgCKK11m3TrAvb+vhe8PsB/+AoWdnd31rz9bVOmql2
        rgUuskj9+ZW0b8EInupmGwAmJOssqTaa4pls1N+DZLHPUReodBn/grKLiqIStTY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=wIgifI
        n9o5w9RHzNlCNOIo1LkX/2DJo8EyUtfBgNh694i9Ms5Lpmih8eUZoBTNw0yBYCCM
        qkY84VMEqWpLNZF1G+4H7rjTyT6PSxqUB3R4DlmWsFvKoHEoiBjHrJaxIkb2lLzJ
        OcsOeJP7iv/hzSqvXU0mhW23tGoUyxuakJ88U=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2299042BE7;
        Thu, 29 Sep 2016 17:17:29 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3EB2242BE6;
        Thu, 29 Sep 2016 17:17:28 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
Cc:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Lars Schneider <larsxschneider@gmail.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Stefan Beller <sbeller@google.com>,
        Martin-Louis Bright <mlbright@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v8 00/11] Git filter protocol
References: <20160920190247.82189-1-larsxschneider@gmail.com>
        <xmqq8tubitjs.fsf@gitster.mtv.corp.google.com>
        <C2C9761E-986F-473D-BFB7-CBEF900D9FA3@gmail.com>
        <f7a4f828-bb1d-0ffa-e369-3b4fa476d9e5@web.de>
        <f9a6dd02-34c0-d48b-3cbc-73202488920c@gmail.com>
Date:   Thu, 29 Sep 2016 14:17:25 -0700
In-Reply-To: <f9a6dd02-34c0-d48b-3cbc-73202488920c@gmail.com> ("Jakub
        =?utf-8?Q?Nar=C4=99bski=22's?= message of "Thu, 29 Sep 2016 22:59:54
 +0200")
Message-ID: <xmqqfuoie78a.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 2025FD32-868A-11E6-B02F-C26412518317-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jakub Nar=C4=99bski <jnareb@gmail.com> writes:

> Or even better: make filter driver write its pid to pidfile, and then
> "wait $(cat rot13-filter.pid)".  That's what we do in lib-git-daemon.sh
> (I think).

I am not sure if "wait"ing on a random process that is not a direct
child is a reasonable thing to do, but I like the direction.

Communicate with a pidfile and wait until "kill -0 $that_pid" fails,
or something like that, would be clean enough.



