Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B8541F403
	for <e@80x24.org>; Wed,  6 Jun 2018 20:01:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752403AbeFFUBl (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Jun 2018 16:01:41 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65239 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751546AbeFFUBk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jun 2018 16:01:40 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3919BE9282;
        Wed,  6 Jun 2018 16:01:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=sasl; bh=GG5uxMmCAqDgXzjWDwVgG43eZsI=; b=X5biZI+
        CFvCxvE3orH7hHRBwwNxnfKykjRybtJVbYJqLRQPFkywlX/jsoyTDy0ixG2ql+Vr
        ryPs74ai3s0TWuDbDgu4owBf/FFzVbsCOXmPpASCCW05N0BK0Z0ugtViwGZld/za
        jt82V7JTMtGpvfa57SGDJKtSTUrYfzKXCui4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
        :subject:message-id:references:mime-version:content-type
        :in-reply-to; q=dns; s=sasl; b=g1CO2e5Yvz6Aa734t/IchwTaFxgenn6rq
        9f22pPmzWU9p9NF7Ry1DyXkVzsPqfb7Mq2VRzY9A6BfKF8Lz7zArYi9go/IU7SRW
        4jIFfKWTVZq5KawZ8uqGXazhpinmj/EXKy4pD8/TMa/AYcRJ4PTlijG3O7CyqPnb
        /BfqYLTPFw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 320C4E9281;
        Wed,  6 Jun 2018 16:01:40 -0400 (EDT)
Received: from zaya.teonanacatl.net (unknown [98.111.125.125])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B634CE927E;
        Wed,  6 Jun 2018 16:01:39 -0400 (EDT)
Date:   Wed, 6 Jun 2018 16:01:38 -0400
From:   Todd Zullinger <tmz@pobox.com>
To:     Thomas Fischer <thomasfischer@fastmail.com>
Cc:     "Robert P. J. Day" <rpjday@crashcourse.ca>, git@vger.kernel.org
Subject: Re: git rm bug
Message-ID: <20180606200137.GJ3094@zaya.teonanacatl.net>
References: <1528313557.2662346.1398855328.3E0F8023@webmail.messagingengine.com>
 <alpine.LFD.2.21.1806061532420.9259@localhost.localdomain>
 <1528314421.2665575.1398886712.579F37CE@webmail.messagingengine.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528314421.2665575.1398886712.579F37CE@webmail.messagingengine.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Pobox-Relay-ID: 6CFE0266-69C4-11E8-A6ED-44CE1968708C-09356542!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Fischer wrote:
> I agree that the entire chain of empty directories should not be tracked, as git tracks content, not files.
> 
> However, when I run 'rm path/to/some/file', I expect path/to/some/ to still exist.
> 
> Similarly, when I run 'git rm path/to/some/file', I expect path/to/some/ to exist, *albeit untracked*.
> 
> I do NOT expect git to *track* empty directories. But I also do NOT expect it to remove untracked directories.

It looks like this behavior has been in place for many
years, since d9b814cc97 ("Add builtin "git rm" command",
2006-05-19).  Interestingly, Linus noted in the commit
message that the removal of leading directories was
different than when git-rm was a shell script.  And he
wondered if it might be worth having an option to control
that behavior.

I imagine that most users either want the current behavior
or they rarely run across this and are surprised, given how
long git rm has worked this way.

It does seem like something which could be noted in the git
rm docs.  Perhaps you'd care to take a stab at a patch to
add a note to Documentation/git-rm.txt Thomas?  Maybe a note
at the end of the DISCUSSION section?

-- 
Todd
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
If everything seems to be going well, you have obviously overlooked
something.

