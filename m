Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8594E1F463
	for <e@80x24.org>; Mon, 16 Sep 2019 20:56:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388422AbfIPU4l (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Sep 2019 16:56:41 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60257 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbfIPU4l (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Sep 2019 16:56:41 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5E1A729000;
        Mon, 16 Sep 2019 16:56:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jOqzRwGN9STze8vKFBO74I/K7yQ=; b=NJQPji
        TmoxnkvBnbsC87ZcJ8yLDvOOw/hchLwUqCMhk1Tjs4PcTi0oQ8TI/UX2bHRmErhb
        TJz+wSbrYP3iRLZ6Ze5ipY9KrfjyXEWjAjCgpXEORq99em3PRwbNh8K96aVeD7Ba
        bMsmnV5J4IUj0s2+TOSsXU4ILh+kF+KJe0LIU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Qok01WSPWEKjeCgT1vILx/trZPdMaDHp
        64lWZqgd3unSmDr5tcapyZFqnj+Q+EPWEHuzVStQ5h4kcZa97SkcQ4q5b5a21flR
        gJ0sc6I3yF0zsIGd3dAscLslPlfeLsZ+99pgG1b3c1lFWzc3z1NYoIbJXwhrNHQv
        5yMUOmLJXSc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5650728FFF;
        Mon, 16 Sep 2019 16:56:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B71DA28FFE;
        Mon, 16 Sep 2019 16:56:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 2/4] Makefile: define THIRD_PARTY_SOURCES
References: <cover.1568309119.git.liu.denton@gmail.com>
        <cover.1568661443.git.liu.denton@gmail.com>
        <a7c855a973db9067c2e30569d86f9b2b2147c6b3.1568661443.git.liu.denton@gmail.com>
Date:   Mon, 16 Sep 2019 13:56:37 -0700
In-Reply-To: <a7c855a973db9067c2e30569d86f9b2b2147c6b3.1568661443.git.liu.denton@gmail.com>
        (Denton Liu's message of "Mon, 16 Sep 2019 12:23:11 -0700")
Message-ID: <xmqqmuf49cze.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7A3F2C78-D8C4-11E9-A63C-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> +# THIRD_PARTY_SOURCES is a list of patterns compatible with
> +# the $(filter) and $(filter-out) family of functions

That defines the format, but does it convey what they want to
achieve to the readers?  "... to catch the list of source files
we borrowed from elsewhere" or something, perhaps?

> +THIRD_PARTY_SOURCES += compat/inet_ntop.c
> +THIRD_PARTY_SOURCES += compat/inet_pton.c
> +THIRD_PARTY_SOURCES += compat/obstack.%
> +THIRD_PARTY_SOURCES += compat/nedmalloc/%
> +THIRD_PARTY_SOURCES += compat/poll/%
> +THIRD_PARTY_SOURCES += compat/regex/%
> +THIRD_PARTY_SOURCES += sha1collisiondetection/%
> +THIRD_PARTY_SOURCES += sha1dc/%
> +
>  GITLIBS = common-main.o $(LIB_FILE) $(XDIFF_LIB)
>  EXTLIBS =
