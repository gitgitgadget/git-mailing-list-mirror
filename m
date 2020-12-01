Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28C68C64E8A
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 04:47:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A304B206E3
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 04:47:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ga1WvAJ4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728229AbgLAEql (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Nov 2020 23:46:41 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54899 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbgLAEql (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Nov 2020 23:46:41 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BA3CC108560;
        Mon, 30 Nov 2020 23:45:58 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=9fgOXs9uicxooLYyFp6pE6iL/hI=; b=Ga1WvAJ4LUKYE0IBTZ5a
        rdBjwbhOpKyVrnNoyd77up0BSyrgRSWZvSNr/EHfq3zPMRHVOCo/jB5Fbb3lXiQc
        AvwoNLUnNvVQrvBQtuenpbOBE75BChBabOFNN3n4XcghyNx4WrqTt+J7AvMBiJP+
        JTVraJ3xAdqtebqoKOxoTTU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=lvtiQu1+cO+j1uJPe7PQSMvtQbjnJU8soa1X27yHKVap9p
        djAQkF+VaCt6c3gpH5fZwzzKXiTcBNrg2QDqLOQzCp4cMNDUs+5fco2/WOZ4uSIP
        G9KgCIKYTwGq1TKGGVjx+h7DcYqOLqr+9Y+iRefctE81tV7bdtkq6vXrwjzns=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A337310855F;
        Mon, 30 Nov 2020 23:45:58 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E103A10855E;
        Mon, 30 Nov 2020 23:45:55 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v3 0/8] config: add --fixed-value option
References: <pull.796.v2.git.1606147507.gitgitgadget@gmail.com>
        <pull.796.v3.git.1606342376.gitgitgadget@gmail.com>
        <xmqq7dq9ca94.fsf@gitster.c.googlers.com>
        <94cabd0e-004c-f3fc-315f-f984abce51e6@gmail.com>
Date:   Mon, 30 Nov 2020 20:45:54 -0800
Message-ID: <xmqqy2iirv5p.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 19661196-3390-11EB-870D-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> On 11/25/2020 6:00 PM, Junio C Hamano wrote:
>
>> Thanks.  The only thing that still stand out, after the first 7
>> patches (queued as its own "add --fixed-value option to config"
>> topic) are queued, is that the early part of the documentation,
>> namely, a paragraph where it mentions value-pattern, still lives
>> in the world where it can only be a regexp.
>> 
>> Perhaps insert the following between step 7 and 8?
>
> This patch LGTM. Thanks!

Thanks.
