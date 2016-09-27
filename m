Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E882420986
	for <e@80x24.org>; Tue, 27 Sep 2016 16:37:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934907AbcI0Qhg (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Sep 2016 12:37:36 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59395 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S934922AbcI0Qhe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2016 12:37:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5E0153F1AC;
        Tue, 27 Sep 2016 12:37:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Hbv2vFn1Hrk7gcJjwYnAISUgBNk=; b=GtveFM
        H9Nji2OAn7+hcAZA9d2kciWzVJaznd+qXbcOUH2nMvabCPB86azzNvaMR/zwReDr
        k3FNUHp8L8vXVTtsaDLOHN9fa1S6l6Ia6nxEHqf4OyY0QvJksXVv5h6ie2bwA3Uh
        STisDqt+1Fh12cESIDaA/h8jWEcS4Jp+vPmbg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Ro04gOHAzVLK0bwzViNtGGe5JNs7n5ty
        j+Gz8zuojEZ8WYmwJNCHXmNRY4oiFMkKLpinSlQgraRu3HWJ/JngIfBRg99yPhLc
        Ba6x+6y5kGRyylCItmCjR9+wluZ8E7ShbvRYObIxLEFA6Rz7qDtBLv62MawkaMAD
        XqtdBwPwGQI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4C1F03F1AB;
        Tue, 27 Sep 2016 12:37:28 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AC54C3F1AA;
        Tue, 27 Sep 2016 12:37:27 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Paul Smith <paul@mad-scientist.net>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: git 2.9.2: is RUNTIME_PREFIX supposed to work?
References: <1474925524.4270.35.camel@mad-scientist.net>
        <CAPc5daU_nnHRjtC02bxqRaoU+0Rgi7pS6e912Fqk-Xy=qdKWFA@mail.gmail.com>
        <1474982294.3190.32.camel@mad-scientist.net>
        <xmqqh991qpyn.fsf@gitster.mtv.corp.google.com>
Date:   Tue, 27 Sep 2016 09:37:25 -0700
In-Reply-To: <xmqqh991qpyn.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Tue, 27 Sep 2016 09:15:12 -0700")
Message-ID: <xmqq8tudqoxm.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AD51245E-84D0-11E6-87CF-C26412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Paul Smith <paul@mad-scientist.net> writes:
>
>> On Mon, 2016-09-26 at 14:57 -0700, Junio C Hamano wrote:
>>> On Mon, Sep 26, 2016 at 2:32 PM, Paul Smith <paul@mad-scientist.net> wrote:
>>> > 
>>> > Hi all.  I'm trying to create a relocatable installation of Git 2.9.2,
>>> > so I can copy it anywhere and it continues to run without any problem.
>>> > This is on GNU/Linux systems, FWIW.
>>> 
>>> I had an impression that the setting was only to support MS Windows.
>>
>> Hm.  You may be right.  If so that's too bad, because a relocatable Git
>> is very handy even on UNIX systems.  Is there a reason for invoking the
>> subcommands by providing the plain command ("fetch", "merge-base") as
>> argv[0], rather than giving the fully-qualified path to a Git command?
>
> I do not think of any reason offhand. It just is that we never
> needed it.

If you are talking about invoking "git-fetch", then there is a very
good reason.  Built-in's do not need any actual binary on the
filesystem (they only need "git").

But that does not have any relevance to the part below.

> If you want to add support without making the resulting codebase too
> ugly, without breaking the classic way of installing into a fixed
> locations, and without breaking the existing support of platforms
> that does know the runtime-prefix thing, not just I wouldn't mind
> but I would welcome such an addition ;-)

If you can make runtime-prefix honored on more platforms, that would
be good, though you _might_ have just added another "without" to the
above list: without using full paths e.g. /usr/local/git/bin/git-fetch
unconditionally.

