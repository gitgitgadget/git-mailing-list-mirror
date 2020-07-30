Return-Path: <SRS0=t8Cj=BJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2527DC433E1
	for <git@archiver.kernel.org>; Thu, 30 Jul 2020 16:18:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3C5B20829
	for <git@archiver.kernel.org>; Thu, 30 Jul 2020 16:18:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="jibgxrrU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729811AbgG3QSI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jul 2020 12:18:08 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54196 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbgG3QSH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jul 2020 12:18:07 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 639A9D96DF;
        Thu, 30 Jul 2020 12:18:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=daJVlyhclSlAHHsex6//xnzQUkI=; b=jibgxr
        rUFLWQ7CbTvh7laxdKr+vpwrUbs9cp1rByPrskEERAijjJCiEO0+H82i/CkD9PS0
        40Jwuf0pyISu0nUfauJ769RHKRDOsmB2ZcmWfVit0zs5B8YWTgI0FgRJ3RH/kt/m
        p5Gnfs3Cp+CdBHOkBsbcmhbYbslKB8V795mVA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=AxzsKLkIZyX2ENSJSN0Els5iArnlCu6W
        qEWh9BDg6l+votIBXmlnjvgQAh7XaRW2r1UKsZVVsbMpC0XKIEHPawXaoqSSmn30
        a1/sue41WDC+Np+Nde81r+rh127N89g3NfjT3aXZ5NyKfMtiq+d3MuY7a6gta6mI
        G7mRQYkQ4QE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5BB6AD96DE;
        Thu, 30 Jul 2020 12:18:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0ED35D96DB;
        Thu, 30 Jul 2020 12:18:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH v6 00/39] SHA-256, part 3/3
References: <20200728233446.3066485-1-sandals@crustytoothpaste.net>
        <20200729231428.3658647-1-sandals@crustytoothpaste.net>
        <CAPig+cTxfheSPHJvC3_=jQjef0S7FiMEWCQ71ER7epfpeD_5OQ@mail.gmail.com>
Date:   Thu, 30 Jul 2020 09:18:00 -0700
In-Reply-To: <CAPig+cTxfheSPHJvC3_=jQjef0S7FiMEWCQ71ER7epfpeD_5OQ@mail.gmail.com>
        (Eric Sunshine's message of "Wed, 29 Jul 2020 22:48:24 -0400")
Message-ID: <xmqqmu3h6kp3.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3DAE9300-D280-11EA-BFFD-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Wed, Jul 29, 2020 at 7:15 PM brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
>> Changes from v5:
>> * Remove useless test_oid_init invocations throughout the series.
>> * Fix a commit message for grammar and style.
>> * Fix a typo in a shell case statement.
>> * Fix http-fetch to allow parsing options before failing on a missing
>>   git directory.
>
> Thanks, I think this version addresses all the comments from my
> reviews of the last several versions of this patch series.
>
> I've read through the entire series a couple times and paid close
> attention to the range-diffs, so FWIW, I'm reasonably comfortable
> giving v6 my:
>
> Reviewed-by: Eric Sunshine <sunshine@sunshineco.com>

Thanks, both.

