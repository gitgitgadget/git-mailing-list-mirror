Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB4D81F4F8
	for <e@80x24.org>; Thu, 20 Oct 2016 19:27:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932427AbcJTT1B (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Oct 2016 15:27:01 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62338 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755875AbcJTT0v (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2016 15:26:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EA00148474;
        Thu, 20 Oct 2016 15:26:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4N2QQMba+FTCwJOAl7yFNcLAZzI=; b=GX4aDH
        9Jli7a+JcMhZUo/7PMKz/d3Exux8wVYF2bJ0eofasY4IwXC1NtS3T7wbtIkPcniX
        TzktSrVIkRJvWMJnR17txeb8Yr46W2gWF9ZbHFAV3Kx3cCsP/nGgAnJhTCXgxC6K
        CPQkmbPw6ZV3m3+lC+b7h/DrMGv6FOOXe3nN4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=gJyb6DZlym88oxKAbqHnJZk1t2vLWQOZ
        OcPWDwVz+fACaE7zWJW9MavRQ7zKBe3Esa9ndIWCgo/YQDLupsWG+zVCOy4B+OmN
        JcvEoBgxnbmK8OoOmflU3MCIvWrVioYeGzWxU8lMSFfqLNzh6wkcbpvprvfrTbCi
        7uZQq8yn1Qg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E010348471;
        Thu, 20 Oct 2016 15:26:49 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5AEB948470;
        Thu, 20 Oct 2016 15:26:49 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        "Karl A." <venv21@gmail.com>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv3] submodule--helper: normalize funny urls
References: <20161018210623.32696-1-sbeller@google.com>
        <xmqqzim1nyz0.fsf@gitster.mtv.corp.google.com>
        <xmqqshrtnynj.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kZHLVpxbJ_C-dM2LDA64-_TJNyY+52fTWkOvLvvAq2XDg@mail.gmail.com>
        <xmqq60opnolz.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kYrKGLEOO72aWuX5OOM-AecdFZFXRqBkRzhdAM-VbPFxA@mail.gmail.com>
        <xmqqwph5m6th.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kY4u-k8v3g5Jmod4acwJ81AnJYeYMQZ2tarx6UMGj8Xew@mail.gmail.com>
Date:   Thu, 20 Oct 2016 12:26:47 -0700
In-Reply-To: <CAGZ79kY4u-k8v3g5Jmod4acwJ81AnJYeYMQZ2tarx6UMGj8Xew@mail.gmail.com>
        (Stefan Beller's message of "Thu, 20 Oct 2016 12:15:57 -0700")
Message-ID: <xmqqzilyg6tk.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 25AE4EE0-96FB-11E6-8AED-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> Do we actually want to fix git-clone as well?

If I understand correctly, the point of this fix is to make it not
to matter whether the original URL the end user gives or recorded as
the remote by "git clone" in the repository is any one of:

	$any_leading_part/path/to/dir
	$any_leading_part/path/to/dir/
	$any_leading_part/path/to/dir/.

So I do not think there is anything to "fix", as long as "git clone"
that is given any one of the above three records any one of the
above three as the result.  It _may_ be desirable if the result is
identical what was given as input, but I do not offhand think that
is required.

> I tried and then I see breakage in 5603-clone-dirname
> as ssh://host seems to be an invalid url; it has to end with a slash?

That is a separate issue, isn't it?  We shouldn't be touching the
leading "<scheme>://<host>/" part, I would think.  

For example, a URL "../another" relative to "ssh://host/path" may be
"ssh://host/another", but shouldn't it be an error to take
"../../outside" relative to "ssh://host/path"?
