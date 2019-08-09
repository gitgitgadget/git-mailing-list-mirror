Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9755A1F732
	for <e@80x24.org>; Fri,  9 Aug 2019 21:50:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbfHIVuC (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Aug 2019 17:50:02 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55457 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbfHIVuC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Aug 2019 17:50:02 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 818557B398;
        Fri,  9 Aug 2019 17:50:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=uNL8o+q1qqT0/z1SvJ3Bhuc7Z+Y=; b=R8AodW
        CkUZ5hklYcc2o38BwBTB2pFlP0ERjXP0TLE0XpYumZq3aoUigquN3AZbv1qzOCzr
        VjR3OrDOnuPGwgn6vY0FsjBnNMcQS5hppGy6xf6jWLRbm5PiWUNyCp8qq9IyatMk
        JbwcD4Ru3Qtnov+Kj4mtkx8jCwrt6w+P+jdKA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=SD9EbbJaJCjUM877XvYRA7I5A7AIbi//
        40f2Xf//L58+CbFNS2dXb+0a7fefC2kafzINAJfjp6GRwqZaH0xS2XrkQMBenQx/
        l4UR2MuhY2f+CxwS7VBiIXECiIlEVwvPUjPbZlV1pxOBB/pPG4YYpcmFMvzhlo1E
        ZpEgvS0oH3I=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7A0717B397;
        Fri,  9 Aug 2019 17:50:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A88837B395;
        Fri,  9 Aug 2019 17:49:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Cliff Schomburg <clisc@microsoft.com>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: "git log" does not display refs info when executed via C# Process class on Windows
References: <BN8PR21MB11569DAA8A677BF00113F683B7D60@BN8PR21MB1156.namprd21.prod.outlook.com>
        <20190809195031.GK20404@szeder.dev>
        <BN8PR21MB11566C135B1326AF1B45E4D8B7D60@BN8PR21MB1156.namprd21.prod.outlook.com>
Date:   Fri, 09 Aug 2019 14:49:55 -0700
In-Reply-To: <BN8PR21MB11566C135B1326AF1B45E4D8B7D60@BN8PR21MB1156.namprd21.prod.outlook.com>
        (Cliff Schomburg's message of "Fri, 9 Aug 2019 21:34:06 +0000")
Message-ID: <xmqqblwyc8l8.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A143C114-BAEF-11E9-930A-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Cliff Schomburg <clisc@microsoft.com> writes:

> Strangely, when I run this command:
>
> Git log origin/master --pretty=oneline --decorate -1
>
> I get the format I want from STDOUT.  However, when I try to filter it to show only the tag refs:
>
> Git log origin/master --pretty=oneline --decorate --decorate-refs=^tag* -1
>
> No refs are returned to standard output again.  Only on the command line.
>
> Does --decorate-refs not return to STDOUT?

If you are asking for tags, which does not begin with a caret "^",
perhaps drop "^" from the pattern?

The pattern is supposed to be wildmatch pattern, so it is already
left anchored, e.g. --decorate-refs=ag* won't find any tag.


