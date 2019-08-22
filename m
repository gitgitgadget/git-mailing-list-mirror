Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98D041F461
	for <e@80x24.org>; Thu, 22 Aug 2019 20:24:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388019AbfHVUYG (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Aug 2019 16:24:06 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61710 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732055AbfHVUYG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Aug 2019 16:24:06 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4FCDA6C8F8;
        Thu, 22 Aug 2019 16:24:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=uWpgQO53oO0i2uPgBXt80fANHG8=; b=YIKctesbyHgfbzGlevQZ
        HFWx0lFk8hC5nHqF6GIqwPkeKqfQjH9YIc5vIreEVh+l7nFA4LMEnVPDwe74Y8v2
        xPLqhcYNjt0jff6qfMpIW5XwuDnPNwUfjo5U3zG94pgdXJKvTGK7qJnmZJxsxewd
        hcU5ERS7mhN6S6fDBh/v3+s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=AMYKr56+j/vp+U2hFj93I4yG4WAIZA2ahUzVVx6Lnr2nG2
        WQKHyqUCY3FtH5iTZhZOO8r+NgGk0AhpSOiI/CQkb/m+UW0joeakPgM3EammLe77
        uO9sx9wEh4UwqwwKUDI0uUIVGv8cIch/PZnJt7i8NbWCSIf/L4oQEdv9PsYwE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4802F6C8F7;
        Thu, 22 Aug 2019 16:24:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6E4356C8F5;
        Thu, 22 Aug 2019 16:24:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmo=?= =?utf-8?B?w7Zyw7A=?= Bjarmason 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: RFC: Proposing git-filter-repo for inclusion in git.git
References: <CABPp-BEr8LVM+yWTbi76hAq7Moe1hyp2xqxXfgVV4_teh_9skA@mail.gmail.com>
Date:   Thu, 22 Aug 2019 13:23:59 -0700
Message-ID: <xmqqlfvlne3k.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C747943C-C51A-11E9-8465-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> Questions, comments, or concerns with this proposal?  Alternative
> proposals?  If inclusion is acceptable, are there any other tasks that
> need to be completed first?

I do not want a discussion to begin with a Devil's Advocate
response, but anyway...

Are we planning to go to all batteries included approach?  I have a
feeling that there are other tools (hello, "git imerge") that
equally deserve attention by Git users; are we in the business of
absorbing them all?  How big a project will our tree become, and how
much more activity would have to be haneld by the readership of the
Git mailing list?

I'd rather see us shed non-core tools we already have (e.g. git-svn,
cvs import/export) out of git.git and have them as independent
projects.  But that may be just me.

The benefits I see in the "leave as much as possible out" approach
are (not in particular order):

 - Distributed development and integration.  The release schedule of
   Git-core does not have to be constrained by the readiness of
   non-core part.

 - Choice of development tools, language, etc.  The core part will
   stay in C, but peripheral tools do not have to be constrained by
   our choice.  Those who run their own project can choose what they
   want to use and how they want to structure their development
   process.

The primary downside I would want to avoid from absorbing non-core
stuff is that such peripheral tools (git-cvsimport, I am looking at
you) can go stale when their development stalls, and nobody would be
bold enough to suggest removing them.
