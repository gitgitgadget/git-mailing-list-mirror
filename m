Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 39CB21FEB3
	for <e@80x24.org>; Thu, 12 Jan 2017 23:32:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750845AbdALXcu (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jan 2017 18:32:50 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52821 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750827AbdALXct (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2017 18:32:49 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9411D5F5FE;
        Thu, 12 Jan 2017 18:32:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=geeiWCO14T4Q
        aMTuC7AVTEMhTwY=; b=nHk2lgkJOsazdkTVDaTeGIA09fTWrkMvsqv8O/8xUBM2
        1TshwQjEv3abU0xD7BcauUaTCI8iOXlMQ5eegNef7f4ExVd4wTYicnXWz4c/y0ug
        qx0TOyajzHGJnRTsGGw7w1uj8tYe1AbGqxGEzb09BnPLzPJZTHXdIvfwroF0Dw0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=IbCp6n
        dApnDUKpyQQJwWxbZOKGJQulTTkoQzvMXqpLwFybYSolk/BwlYmbAwfHu153QBZO
        2ZlJPhidPK7hcqF3uN7y3flF9g+xhfS17ZPhWUeO5p3R6pPLiehxzX71Wtfsu2+N
        3deC6naA/7U9wqUIThLlM76xlBNCAFE/U9Uvw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8B9AF5F5FD;
        Thu, 12 Jan 2017 18:32:48 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E7DA85F5FB;
        Thu, 12 Jan 2017 18:32:47 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Manuel Ullmann <ullman.alias@posteo.de>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
Subject: Re: Bug report: Documentation error in git-bisect man description
References: <87r347swz1.fsf@sonnengebleicht.fritz.box>
Date:   Thu, 12 Jan 2017 15:32:46 -0800
In-Reply-To: <87r347swz1.fsf@sonnengebleicht.fritz.box> (Manuel Ullmann's
        message of "Fri, 13 Jan 2017 00:02:42 +0100")
Message-ID: <xmqqd1frj1lt.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 6D240330-D91F-11E6-83EF-FE3F13518317-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Manuel Ullmann <ullman.alias@posteo.de> writes:

> Hi,
>
> there is a mistake in the git-bisect description.
> The second paragraph of it says =E2=80=98the terms "old" and "new" can =
be used
> in place of "good" and "bad"=E2=80=99. So from a logical point of view =
the
> description part stating the usage syntax should be:
>
> git bisect (bad|good) [<rev>]
> git bisect (old|new) [<rev>...]
>
> instead of
>
> git bisect (bad|new) [<rev>]
> git bisect (good|old) [<rev>...]
>
> Checked man page version of 2.11.0, but it is in my local 2.10.2 git as=
 well.

Hmmm, I tend to agree, modulo a minor fix.

If the description were in a context inside a paragraph like this:

	When you want to tell 'git bisect' that a <rev> belongs to
	the newer half of the history, you say

		git bisect (bad|new) [<rev>]

	On the other hand, when you want to tell 'git bisect' that a
	<rev> belongs to the older half of the history, you can say

		git bisect (good|old) [<rev>]

then the pairing we see in the current text makes quite a lot of
sense.

But in the early part of the description section, listing the
information that logically belongs to the synopsis section, I think
the current one is misleading.  You are painting commits with two
colors, and if you are from the "older vs newer" school, you say
either 'old' or 'new' as the names of these two colors, and do not
use 'bad' or 'good'.  A line with "git bisect (old|new) [<rev>]" in
the list would make more sense.

Similarly, if you are from the "still good vs already bad" school,
you would either say 'good' or 'bad' so you would want to see a line
with "git bisect (good|bad) [<rev>]" in the list (not "bad|good" in
that order, but opposite).

Christian, am I talking nonsense?
