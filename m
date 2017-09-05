Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C93A8208E3
	for <e@80x24.org>; Tue,  5 Sep 2017 21:56:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752520AbdIEV4q (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Sep 2017 17:56:46 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61755 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752075AbdIEV4q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Sep 2017 17:56:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D0FD2ACD94;
        Tue,  5 Sep 2017 17:56:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xCcPWf/SA/Te2P5b0SGwvEtMKIE=; b=lalR1M
        trBP8a+fA9Grm8SucOXnNz69MuEPW6obphfGjpnfdjOVWBEQ4ZiZGShqDHR4W1J+
        6vGyESUNKfz/MkVgjgvsancxMHls5SwBEVubd58mdCb4PmLjuvvItbrx8043Fo1c
        s7yFO2a2Ij3+U32nF4/A11uvzyzHdHeNGucWQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XvCNT1+Rfk0v3d+m/crQuOno/p0OJnyf
        Hq1d6HPRSt/BMiRjRr5y7UDMgKsJ+m477fL7PCrioVICZ3i7xDw1DkVZm4Xr5eBp
        2blcpAEqAyqrVshUXK/NZJ37M05SBzbUSAcHwb6Zx+aWnl455hG83K0v5rBYqxis
        Y7K1EDs8VI0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C687AACD93;
        Tue,  5 Sep 2017 17:56:45 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 079E0ACD91;
        Tue,  5 Sep 2017 17:56:44 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Ross Kabus <rkabus@aerotech.com>, git@vger.kernel.org
Subject: Re: [Bug] commit-tree shouldn't append an extra newline to commit messages
References: <CAEVs+za9do_wXC12SSRznF9v9oGw3_Grq2EFDVf8nH1CRgM-Qw@mail.gmail.com>
        <20170902083319.lcugfpkkk5lahieb@sigill.intra.peff.net>
        <CAEVs+zbbWQuM-=5d04bkpTu38Mr4PyczskNhni5K1u_nzh-2Qw@mail.gmail.com>
        <20170905153636.tsmlq3wv7ztpc67z@sigill.intra.peff.net>
        <CAEVs+zbCj0Zv0t4_WG6y2jcLoXwHy-Mu-LH31c_QgFaE9i3HtQ@mail.gmail.com>
        <20170905170311.yhcksrw2bxevd3hk@sigill.intra.peff.net>
Date:   Wed, 06 Sep 2017 06:56:43 +0900
In-Reply-To: <20170905170311.yhcksrw2bxevd3hk@sigill.intra.peff.net> (Jeff
        King's message of "Tue, 5 Sep 2017 13:03:12 -0400")
Message-ID: <xmqq3780byhw.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1BA9851E-9285-11E7-89DD-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Tue, Sep 05, 2017 at 12:57:21PM -0400, Ross Kabus wrote:
>
>> On Tue, Sep 5, 2017 at 11:36 AM, Jeff King <peff@peff.net> wrote:
>> 
>> > So I'd argue that "git commit -F" is doing a reasonable
>> > thing, and "commit-tree -F" should probably change to match it (because
>> > it's inconsistent, and because if anything the plumbing commit-tree
>> > should err more on the side of not touching its input than the porcelain
>> > commit command).
>> 
>> I would agree that "commit-tree -F" should change to match the behavior of
>> "git commit -F --cleanup=verbatim". I feel pretty strongly that this type of
>> cleanup logic shouldn't be done in a plumbing command, though I'm not sure
>> it is a big enough deal to change behavior/compatibility for everyone.
>
> OK. Do you want to try your hand at a patch?
>
>> Yup, confusion #2. I was using "-F -" which I see now is a different code
>> path. Reading via stdin without "-F -" _is_ the verbatim option. This
>> difference burned someone else on the mailing list as well. See:
>
> Ah, OK, your confusion makes more sense now.

Yeah, my initial knee-jerk reaction when I started reading the early
part of the thread was that the use of strbuf_complete_line() is a
strong enough sign that this was intended behaviour, but the "we get
different results between reading from standard input and pretending
'-' is a file and reading from it" made me change my mind.  I agree
that dropping strbuf_complete_line() call from that codepath (and
nowhere else, especially the "-m" oneline thing [*1*]) would be a
backward incompatible change that is acceptable.

Here is what I am preparing to add to the What's cooking report when
such a patch materializes ;-)

 * "git commit-tree -F $file" used to add terminating newline if the
   input ends with an incomplete line, but when the command reads
   the input from its standard input, we recorded what was given
   verbatim.  The former has been changed to record the input with
   an incomplete line to make them consistent.

Something like that probably needs to be added to the release notes
but I am way being ahead of myself ;-)

Thanks, both, for sensible discussion.



[Footnote]

*1* The message from Ross you are responding to talks about
    "cleanup", but I tend to view the calls to *_complete_line() as
    more for "the end-user convenience".  "-m" meant to take a
    one-liner from the command line should have it because exactly
    as you said, having to pass the terminating newline from the
    command line with "-m" is awkward.  On the other hand, if the
    user/caller prepared the exact message in a file and wants to
    feed it either via "-F" or from the standard input, I agree that
    "the end-user convenience" would get in the way and it is
    preferrable to avoid it in the plumbing layer.
