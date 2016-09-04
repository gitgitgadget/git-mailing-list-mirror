Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC1F61FBB0
	for <e@80x24.org>; Sun,  4 Sep 2016 06:48:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752971AbcIDGsh (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Sep 2016 02:48:37 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65104 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752651AbcIDGsh (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Sep 2016 02:48:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D686A2E361;
        Sun,  4 Sep 2016 02:48:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=yduz5zij250Q
        XjDYK3DMOf/g6/M=; b=nDMrdBBc3V9y98JaImdedX6652ukC0fVXONVWXq8+CJa
        SCEqNECG05VIL5ztwKGyE5k9W0qKzIl9jRxs7HqU9XFl6ZdIvU5RRHFCelAyvhDW
        24d1xpizTSdAMvh5VhITW7B2P+mPFwSAgM6YTJsgk19+iEoiDq+CIWTGYSfLQrk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=hSCDWp
        ek9EnAHDZaM9y/9MXkT2dk4D0h7Z6DQW4aDc8F7HLiygA8+or14R80dnZtzY0scs
        w8zRJb+bJvjtr2nREuq+CPP8Ia64YZqsJJBQduVhoFEgAggtgk/loAL9Px7V92fD
        jn+X/ahTgzL759p0abZc0pHFZ2eycVKDORGTs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C3BE22E360;
        Sun,  4 Sep 2016 02:48:35 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4E7032E35E;
        Sun,  4 Sep 2016 02:48:35 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org
Subject: Re: [RFC/PATCH 2/2] WIP xdiff: markup duplicates differently
References: <20160903033120.20511-1-sbeller@google.com>
        <20160903033120.20511-3-sbeller@google.com>
        <eb88af2c-d7b1-295e-5f23-a85045bde753@gmail.com>
Date:   Sat, 03 Sep 2016 23:48:33 -0700
In-Reply-To: <eb88af2c-d7b1-295e-5f23-a85045bde753@gmail.com> ("Jakub
        =?utf-8?Q?Nar=C4=99bski=22's?= message of "Sat, 3 Sep 2016 14:25:08 +0200")
Message-ID: <xmqqlgz8qhxa.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 9A12F074-726B-11E6-BC39-F7BB12518317-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jakub Nar=C4=99bski <jnareb@gmail.com> writes:

> Side note: I wonder if the cousin of unified diff, namely context diff[=
1],
> is something that we can and should support.

Yes, the lack of support for the copied context (instead of the
unified context) diff format has bugged me over the years.  Reading
copied context diff format however is rapidly becoming a lost art,
unfortunately, partly due to our popularity, and the need for the
format has become a lessor issue.

I wonder if a pair of a pre-processor (on the input side, before
running 'git apply') and a post-processor (on the output side,
munging the output from 'git show/diff') would be sufficient.

In any case, I agree with you that it has nothing to do with what
Stefan is doing here.
