Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D7A320A40
	for <e@80x24.org>; Sun,  3 Dec 2017 01:52:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752585AbdLCBwG (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Dec 2017 20:52:06 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65006 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752469AbdLCBwF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Dec 2017 20:52:05 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 607DBB424B;
        Sat,  2 Dec 2017 20:52:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=gcmr0yupcyR34dISGklVV0ZQ/zo=; b=QE/Tb4
        wWQ6q3k8Yue5VCsCXNcRQO4dYUWMjZ1pFdEUT1sE9Ih62BMVaJvxDgmTDc1TFW4A
        W9D/Tb+fbhIXNc0DzqgiGiFTdR1TVOceTz5ebds3d4PHYOmYPAaewdUfuZEm2ifY
        pGdODjZsd2fvKfD1ROrP7VUI8fybgPLxcJurY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=NkW62+vd5fFSvAM7MSakSGrwscaBcAi1
        fIiRnRyAzfbayHMpr7s27n2qN6NF8xqKkR7Arn0YVA+cC2pjBhHZ51weXh1dJ3Jb
        eE/r5pf9FXH+QBrDSdxM4IrMV8OZbxf4vZ9SUYyp3nZxx6WhGiqaQlcgeYJeLXFk
        6XKwRzNN2/0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 56346B424A;
        Sat,  2 Dec 2017 20:52:04 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C427FB4249;
        Sat,  2 Dec 2017 20:52:03 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] Doc/check-ref-format: clarify information about @{-N} syntax
References: <xmqqpo8dn1jd.fsf@gitster.mtv.corp.google.com>
        <20171127172834.6396-1-kaartic.sivaraam@gmail.com>
        <20171127172834.6396-2-kaartic.sivaraam@gmail.com>
        <xmqqd14386sw.fsf@gitster.mtv.corp.google.com>
        <1511880237.10193.5.camel@gmail.com>
Date:   Sat, 02 Dec 2017 17:52:02 -0800
In-Reply-To: <1511880237.10193.5.camel@gmail.com> (Kaartic Sivaraam's message
        of "Tue, 28 Nov 2017 20:13:57 +0530")
Message-ID: <xmqqa7z0lgsd.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8F749CD6-D7CC-11E7-AED1-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kaartic Sivaraam <kaartic.sivaraam@gmail.com> writes:

>> I have a mild suspicion that "git checkout -B @{-1}" would want to
>> error out instead of creating a valid new branch whose name is
>> 40-hex that happen to be the name of the commit object you were
>> detached at previously.
>
> I thought this the other way round. Rather than letting the callers
> error out when @{-N} didn't expand to a branch name, I thought we
> should not be expanding @{-N} syntax for "check-ref-format --branch" at
> all to make a "stronger guarantee" that the result is "always" a valid
> branch name. Then I thought it might be too restrictive and didn't
> mention it. So, I dunno.
>
>
>> I am not sure if "check-ref-format --branch" should the same; it is
>> more about the syntax and the 40-hex _is_ valid there, so...
>
> I'm not sure what you were trying to say here, sorry.

The "am not sure if" comes from this question: should these two be
equivalent?

    $ git check-ref-format --branch @{-1}
    $ git check-ref-format --branch $(git rev-parse --verify @{-1})

If they should be equivalent (and I think the current implementation
says they are), then the answer to "if ... should do the same?"
becomes "no, we should not error out".

Stepping back a bit, the mild suspicion above says

    $ git checkout HEAD^0
    ... do things ...
    $ git checkout -b temp
    ... do more things ...
    $ git checkout -B @{-1}

that creates a new branch whose name is 40-hex of a commit that
happens to be where we started the whole dance *is* a bug.  No sane
user expects that to happen, and the last step "checkout -B @{-1}"
should result in an error instead [*1*].

I was wondering if "git check-ref-format --branch @{-1}", when used
in place of "checkout -B @{-1}" in the above sequence, should or
should not fail.  It really boils down to this question: what @{-1}
expands to and what the user wants to do with it.

In the context of getting a revision (i.e. "rev-parse @{-1}") where
we are asking what the object name is, the value of the detached
HEAD we were on previously is a valid answer we are "expanding @{-1}
to".  If we were on a concrete branch and @{-1} yields a concrete
branch name, then rev-parse would turn that into an object name, and
in the end, in either case, the object name is what we wanted to
get.  So we do not want to error this out.

But a user of "git check-ref-format --branch" is not asking about
the object name ("git rev-parse" would have been used otherwise).
Which argues for erroring out "check-ref-format --branch @{-1}" if
we were not on a branch in the previous state.

And that argues for erroring out "check-ref-format --branch @{-1}"
in such a case, i.e. declaring that the first two commands in this
message are not equivalent.


[Footnote]

*1* "It should instead detach HEAD at that commit if @{-1} refers to
    a detached HEAD state" is not a good suggestion (we wouldn't
    have "-B" if a mere branch switching is desired).
    
