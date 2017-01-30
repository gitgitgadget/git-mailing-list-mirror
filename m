Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9CA4820D11
	for <e@80x24.org>; Mon, 30 Jan 2017 20:49:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754378AbdA3Ut2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jan 2017 15:49:28 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59239 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754447AbdA3UtV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jan 2017 15:49:21 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AD1A3653B8;
        Mon, 30 Jan 2017 15:48:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=PfKPrpq84XuPp+5g/xp7tmR9W3A=; b=SkmW1LOoBmnL7435OxHp
        5PWnW+AGUsO8Eit0oE/OSrwTtXdIkLthwrWIIyvoOmZc2fT8EvozFg1I/Dt070N7
        l1XIArAqsq23TpbDwhE28BObYhamZJIyjcbUGCqYeI0r8+3FQRyeMtyHSrpIfdzM
        Y+gRGuEpx/ZHy6WEUw2h1Z0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=G22HQo9V0OX8csL47X990inkNiB6HC6yQYxWBXB6vtiuTk
        Xr09goAop7HFbR7oQYJdWvmir1+Zkq2NkoRcQBqIYl7AEGkcQWCiCOj24m7W0Eq6
        T42R/ZlIGcUQO1rH4VoByn5mWhu9NTAuZn5qez1STbVL+Xpd+M3svnNv7rw6w=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A3C15653B7;
        Mon, 30 Jan 2017 15:48:54 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id ED91E653B6;
        Mon, 30 Jan 2017 15:48:53 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Cornelius Schumacher <schumacher@kde.org>,
        git <git@vger.kernel.org>, Josh Triplett <josh@joshtriplett.org>
Subject: Re: [RFC] Proof of concept: Support multiple authors
References: <1485713194-11782-1-git-send-email-schumacher@kde.org>
        <CAP8UFD3=vaFupEDay-5vrMBwK_YJezysUUvySxnUUZxuW7m_WQ@mail.gmail.com>
Date:   Mon, 30 Jan 2017 12:48:52 -0800
Message-ID: <xmqqinowuvd7.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 83120C3E-E72D-11E6-A6B4-FE3F13518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> I am just wondering if you have read and taken into account the
> previous threads on this mailing list about the same subject, like for
> example this one:
>
> https://public-inbox.org/git/CAOvwQ4i_HL7XGnxZrVu3oSnsbnTyxbg8Vh6vzi4c1isSrrexYQ@mail.gmail.com/

Thanks for a starting-point link.

In that discussion, another discussion in the debian BTS is
mentioned,

  https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=451880

which in turn has links to other, even earlier, discussions, but
they are all gmane links so it would be harder for those who do not
use its NNTP interface (which still works).  Here are their modern
counterparts ;-)

  https://public-inbox.org/git/?q=gmane:83880
  https://public-inbox.org/git/?q=gmane:146223
  https://public-inbox.org/git/?q=gmane:146886

The older discussions already cited the cost to update both in-tree
and out-of-tree tools not to barf when they see such a commit object
and one of the reason why we would not want to do this, and Ted Ts'o
gave us another excellent reason why not to do multiple author
header lines in a commit object header, i.e. "How often is that all
of the authors are completely equal?"

Another thing that I didn't see brought up was that it is not enough
to ensure all existing tools are updated not to barf on a commit
with multiple "author" line.  You need to define what it means to
have multiple authors and how they are treated by tools in a
consistent way.  Think "shortlog", for example.  The tool may be
able to be tweaked not to barf, and you may be able to add a random
definition of which of the multiple authors to group a single commit
under (the "random definition" could be "show that same commit
multiple times, once for each author" or it could be "concatenate
the authors to create a single header to list co-authored commits
under, as if they were a single person", or it could be something
equally bogus), but I do not think any single solution satisfies
people's needs, and my gut feeling is that it is not worth to add
tons of options and explain them to the end-users to support these
random things that happen when there are multiple authors.

Incidentally, there recently was a discussion on extending
request-pull by adding a summary of commits by reviewers and
testers.

https://public-inbox.org/git/20170115183051.3565-1-wsa@the-dreams.de/

I would imagine, if it is to be implemented, it would boil down to
teaching shortlog that the "author" line in the commit object header
is not the only thing that matters, and that it should optionally
take notice of lines in the trailer block of the log message (e.g.
perhaps "Co-Authored-by: " trailer suggested by $gmane/146223 above
would help there).

My advice to those who want to record credit to multiple authors is
to treat the commit author line as recording the primary contact
when there is a question on the commit and nothing else.  Anything
with richer semantics is better done in the trailer by enriching the
support of trailer lines with interpret-trailers framework.
