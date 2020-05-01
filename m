Return-Path: <SRS0=YBbL=6P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA74BC4724C
	for <git@archiver.kernel.org>; Fri,  1 May 2020 15:11:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85FD5216FD
	for <git@archiver.kernel.org>; Fri,  1 May 2020 15:11:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="OTR8twae"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729679AbgEAPLm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 May 2020 11:11:42 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63500 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728896AbgEAPLm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 May 2020 11:11:42 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 29373C1A5D;
        Fri,  1 May 2020 11:11:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wS4I/FMWRsFmQkyZ6NP/yT7ebuU=; b=OTR8tw
        ae3A1c890THPq8+Ht9Ea6f7WF8szOfA75ks7/BGbt+4E9hagGT2fw3TLXTluDnlI
        lQbv1OXTkMlvgggOJkuqldgjHBepyZgowHN1a90VWb39YGclYtPJhTZITwJP3665
        eB0KRtU+2fH4vucUCZzdCZ6AELl7ZO3/E0ezY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=WBfNOtOTKSd5eKeygLWryvh51cAmbc9h
        KVRj17VgynupYHkryfLHN7GCnb5xIwjYV7pKBJjPtvlVrPmtiD5/Y1AD+9U7uJmX
        qizHy1NeNesX3Tx2MadqNSu29eAPDRISCMkI4jLxteHcsh4s9KWrOt+klaD6x20v
        05NBQtvkhes=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 20D02C1A5C;
        Fri,  1 May 2020 11:11:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 54ECFC1A59;
        Fri,  1 May 2020 11:11:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     douglas.fuller@gmail.com, git@vger.kernel.org
Subject: Re: [PATCH 2/2] gitcredentials(7): make shell-snippet example more realistic
References: <20200501061917.GC23665@coredump.intra.peff.net>
        <20200501062316.GB25603@coredump.intra.peff.net>
        <xmqqy2qcnpb4.fsf@gitster.c.googlers.com>
        <20200501063207.GA26128@coredump.intra.peff.net>
        <20200501063513.GB26128@coredump.intra.peff.net>
Date:   Fri, 01 May 2020 08:11:35 -0700
In-Reply-To: <20200501063513.GB26128@coredump.intra.peff.net> (Jeff King's
        message of "Fri, 1 May 2020 02:35:13 -0400")
Message-ID: <xmqqr1w3ofko.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0D6EF2C4-8BBE-11EA-AA20-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> I can add back in the quoted \", though it does make the code slightly
>> harder to read.
>
> Or did you mean passing $1 in the test call? It definitely isn't good
> shell practice, but we know that we're getting a single-word action from
> Git, per the protocol.

I meant former.  I actually am having a second thought.

I do not think this page should be the canonical place for config
and shell syntax lessons, but the value we have been using as an
example is a good candidate that an end user would encounter in the
real life and has need to do so.  

Perhaps it deserves some comment next to it?

; For the specified site, use "your_user" as the username, and
; invoke the helper, which is a short shell script.  Note that the
; value of the helper variable is enclosed in a double-quote pair,
; because it has a semicolon, which will cause the rest of the line
; discarded as a comment unless quoted.  The shell script in turn
; needs to quote various pieces of it in double quotes, each of
; which needs to be escaped with a backslash.

[credential "https://example.com"]
    username = your_user
    helper = "!f() { test \"$1\" = get && echo \"password=$(cat $HOME/.secret)\"; }; f"


The more I think about it, the worse it becomes X-<

Do we expect that most of our users are comfortable editing
~/.gitconfig in their editor, or do they mostly work with the "git
config --global" command?

I have a feeling that my wishful-thinking answer, which is "former",
is not true in the real world.  Which means they not only need to
quote for the parser of the configuration file, but they then need
to quote that for the shell X-<.

    $ git config --global credential.https://example.com.helper \
	'"!f() { test \"$1\" = get && echo \"password=$(cat $HOME/.secret)\"; }; f"'

I wonder if it helps the users to have something that guides them to
figure out how they do the above.

> Fully quoting, it looks like this:
>
>   helper = "!f() { test \"$1\" = get && echo \"password=$(cat $HOME/.secret)\"; }; f"
>
> which IMHO is getting a little hard to read. I think that's part of why
> I gave such an unfinished example in the first place. :)

Yes, "these are values, go quote them as necessary" is certainly a
lot more attractive position to take.  But apparently that wasn't
all that helpful.

Thanks.

