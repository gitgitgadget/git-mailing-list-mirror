Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F3F420229
	for <e@80x24.org>; Fri, 21 Oct 2016 00:18:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754717AbcJUASz (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Oct 2016 20:18:55 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63140 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754060AbcJUASy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2016 20:18:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8D4F848D82;
        Thu, 20 Oct 2016 20:18:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=NTZkuR7EhIlsRIYefOX1b2xNZ0E=; b=ZQc9XE
        B5syzOmeom4NhoEuGWr6V5MlisDucEqEMAU5x0FTk5ycpfBUPpJyXKA30Td3R1aD
        XXoya83mD5k1ypDyR7P47OFPNa10ip37rkZdyv6V4aq5r/q7BzULeUhDnhAUwlOV
        cCmHr8o+6DlVdltcMzVyCBcOzLVkV0yGuWPzc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=PGwjFOEExI2B29cHX2cipvh66RrYcnjB
        aCw9HDA8PStSMpJgsD7fIUYdToLWgCPCI370CNodPDkwvZNmL2kCZSrmJSoWWXd5
        enlTMm4pJYKEWlf0y1xARRq7mUpvGBAzg1DSjOUjBskkVJkH//UWSjkFDbDlX7R3
        nPh+GRV+2Dg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 856BD48D81;
        Thu, 20 Oct 2016 20:18:52 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0916D48D80;
        Thu, 20 Oct 2016 20:18:51 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Stefan Beller <sbeller@google.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v4 5/8] trailer: clarify failure modes in parse_trailer
References: <cover.1476232683.git.jonathantanmy@google.com>
        <cover.1476998988.git.jonathantanmy@google.com>
        <8aa456a551bf5cf44cea5ea7e33f32e190c45658.1476998988.git.jonathantanmy@google.com>
        <CAGZ79kYi=+JUqmFyR+Xapwy2bLHtmCX7ZFxd9bGkNHS5tjEdOw@mail.gmail.com>
        <xmqqvawmekhk.fsf@gitster.mtv.corp.google.com>
        <22e4b88b-5273-99c9-bcb3-0748c17a7229@google.com>
        <xmqqr37aej26.fsf@gitster.mtv.corp.google.com>
        <5656444f-14ba-b58c-4ad6-e72cc15a13cb@google.com>
Date:   Thu, 20 Oct 2016 17:18:49 -0700
In-Reply-To: <5656444f-14ba-b58c-4ad6-e72cc15a13cb@google.com> (Jonathan Tan's
        message of "Thu, 20 Oct 2016 15:49:33 -0700")
Message-ID: <xmqqeg3aeeqe.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F1F6F204-9723-11E6-A0E3-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> That is true - I think we can take the allowed separators as an
> argument (meaning that we can have different behavior for file parsing
> and command line parsing), and since we already have that string, we
> can use strcspn. I'll try this out in the next reroll.

Sounds good.  Thanks.


The following is a tangent that I think this topic should ignore,
but we may want to revisit it sometime later.

I think the design of the "separator" mechanism is one of the things
we botched in the current system.  If I recall correctly, this was
introduced to allow people write "Bug# 538" in the trailer section
and get it recognised as a valid trailer.

When I say that this was a botched design, I do not mean to say that
we should have instead forced projects to adopt "Bug: 538" format.
The design is botched because the users' wish to allow "Bug# 538" or
"Bug #538" by setting separators to ":#" from the built-in ":" does
not mean that they would want "Signed-off-by# me <my@addre.ss>" to
be accepted.

If I were guiding a topic that introduce this feature from scratch
today, I would probably suggest a pattern based approach, e.g.  a
built-in "[-A-Za-z0-9]+:" [*1*] may be the default prefix that is
used to recognize the beginning of a trailer, and a user or a
project that wants "Bug #538" would be allowed to add an additional
pattern, e.g. "Bug *#", that recognises a custom trailer line that
is used by the project.


[Footnote]

*1* Or more lenient "[A-Za-z0-9][- A-Za-z0-9]*:".
