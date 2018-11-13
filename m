Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 168681F87F
	for <e@80x24.org>; Tue, 13 Nov 2018 03:02:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727551AbeKMM6J (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Nov 2018 07:58:09 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59834 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbeKMM6J (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Nov 2018 07:58:09 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 75EC71F389;
        Mon, 12 Nov 2018 22:02:05 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ev0yQf2ZwEnaXlTlDjTkT6KEQMo=; b=yEcSQ3
        pCbBulNNhMUjhiCvL20DgAEFRaVdyz7yxEu68fFfn5aR3eCu+xT/XVubQ0YxU74U
        rIsz05Ur3vR5BZx6rx4BchkqKkqMHp9zBbek7WMkaTqPy7BqCLXo4brzbXc2zArG
        3+WmFSvKvBpqwGa4qQiWyjbsfvcmwOUhMre1I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=fNXHg1nR1m2OVDtXCfYiooLd43HWkyOP
        AnZgkMgbmdFioeJnj3BCGjD89ynqSpazvw47tbNupvoW2PokVvt4e7gsVqsPGeOr
        JM7oT5+rqgY/ZMhAai0sBCPfm/rgqeozDwqiPWYt0YKXZaXHFS8rDLQgpxXjbWey
        pHP2EmCztRA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6F3CB1F388;
        Mon, 12 Nov 2018 22:02:05 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 806411F383;
        Mon, 12 Nov 2018 22:02:02 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     steadmon@google.com
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] remote-curl: die on server-side errors
References: <9a89e54e79593f6455b52e01d802695362f4ec21.1542062657.git.steadmon@google.com>
Date:   Tue, 13 Nov 2018 12:02:00 +0900
In-Reply-To: <9a89e54e79593f6455b52e01d802695362f4ec21.1542062657.git.steadmon@google.com>
        (steadmon's message of "Mon, 12 Nov 2018 14:44:56 -0800")
Message-ID: <xmqq7ehhy91z.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7E9A5DCC-E6F0-11E8-AB62-F5C31241B9FE-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

steadmon@google.com writes:

> When a smart HTTP server sends an error message via pkt-line,
> remote-curl will fail to detect the error (which usually results in
> incorrectly falling back to dumb-HTTP mode).
>
> This patch adds a check in discover_refs() for server-side error
> messages, as well as a test case for this issue.
>
> Signed-off-by: Josh Steadmon <steadmon@google.com>
> ---

Forgot to mention one procedural comment.

As you can see in the To: line of this reply, your MUA is placing
only the e-mail address without name on your From: line.

Preferrably I'd like to see the same string as your sign-off on the
"From:" line in your messages for a bit of human touch ;-) Can you
tweak your MUA to make that happen?

The second preference is to add an in-body header (i.e. as the first
line of the body of the message) so that the body of the message
starts like this:

    From: Josh Steadmon <steadmon@google.com>

    When a smart HTTP server sends an error message via pkt-line,
    remote-curl will fail to detect the error (which usually results in
    incorrectly falling back to dumb-HTTP mode).

    This patch adds a check in discover_refs() for server-side error
    messages, as well as a test case for this issue.

    Signed-off-by: Josh Steadmon <steadmon@google.com>
    ---
     remote-curl.c                   | 4 +++-
     t/lib-httpd.sh                  | 1 +
     t/lib-httpd/apache.conf         | 4 ++++

Either way would make sure that the resulting patch's author line
will be attributed correctly to the same identity as who is signing
it off first as the author.

Thanks.
