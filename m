Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D4E3C433EF
	for <git@archiver.kernel.org>; Sun, 12 Sep 2021 19:02:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04F646103D
	for <git@archiver.kernel.org>; Sun, 12 Sep 2021 19:02:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235283AbhILTDO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Sep 2021 15:03:14 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50392 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234680AbhILTDN (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Sep 2021 15:03:13 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 31C0B157CBF;
        Sun, 12 Sep 2021 15:01:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=izKs1FiBw7ShIvAOdMFHypnTf8okFs4RWk/S7Z
        pwMvQ=; b=UG/KR7XB1AcE/ThgmrY5JoHnPOFd2XurjhUyEZu45/UMd1k5JolCSi
        2RcDLmjtqWO8GkSsIt8jIZGfz2m4tgtA4/sKEAPsBrA0cAYIz8IvUqO5f/jjM4cj
        DOLkIPNSyTOx4YamflNFa0xwNhcsZgGpvSgf6dx4h9IqOoaBgFnEc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2A773157CBE;
        Sun, 12 Sep 2021 15:01:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 72E18157CBD;
        Sun, 12 Sep 2021 15:01:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Daniel Stenberg <daniel@haxx.se>
Subject: Re: [PATCH v3 0/9] post-v2.33 "drop support for ancient curl"
 follow-up
References: <cover-v2-0.8-00000000000-20210910T105523Z-avarab@gmail.com>
        <cover-v3-0.9-00000000000-20210911T092751Z-avarab@gmail.com>
        <YTzBUFY4p6obEqF+@coredump.intra.peff.net>
Date:   Sun, 12 Sep 2021 12:01:54 -0700
In-Reply-To: <YTzBUFY4p6obEqF+@coredump.intra.peff.net> (Jeff King's message
        of "Sat, 11 Sep 2021 10:46:40 -0400")
Message-ID: <xmqqilz5lisd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E6670000-13FB-11EC-9B15-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Probably not worth a re-roll, but maybe worth fixing up while applying:
>
>>  2:  4b653cee2d3 !  3:  dce6520a5c9 INSTALL: mention that we need libcurl 7.19.4 or newer to build
>>     @@ Commit message
>>      
>>       ## INSTALL ##
>>      @@ INSTALL: Issues of note:
>>     - 	- "libcurl" library is used by git-http-fetch, git-fetch, and, if
>>     - 	  the curl version >= 7.34.0, for git-imap-send.
>>     + 	  not need that functionality, use NO_CURL to build without
>>     + 	  it.
>>       
>>     -+	  Git version "7.19.4" of "libcurl" or later to build. This
>>     -+	  version requirement may be bumped in the future.
>>     ++	  Git requires version "7.19.4" or later of "libcurl", to
>>     ++	  build (without NO_CURL). This version requirement may be
>>     ++	  bumped in the future.
>
> The comma after libcurl (before "to build") is extraneous (and IMHO
> makes the sentence harder to read).

Yes.  Also it would make it easier to follow if the parentheses
around "without NO_CURL" are removed, I would think.
