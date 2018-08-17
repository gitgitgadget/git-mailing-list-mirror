Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 21C821F954
	for <e@80x24.org>; Fri, 17 Aug 2018 19:42:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728236AbeHQWrb (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Aug 2018 18:47:31 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64580 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727218AbeHQWrb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Aug 2018 18:47:31 -0400
X-Greylist: delayed 538 seconds by postgrey-1.27 at vger.kernel.org; Fri, 17 Aug 2018 18:47:29 EDT
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 890B533806;
        Fri, 17 Aug 2018 15:33:53 -0400 (EDT)
        (envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=sasl; bh=jTLXR2R1mH0281h+V2Ep1vgWlno=; b=ZwgrCEo
        e+en/nSMHv6azXDvkMIHA0UM40A7u0C+c/bT+0Ox8NqPf10oN3L6Qj2U+lQxtCiI
        x2QLsXGrzIpeCWcQV/YmCelsfwEQKPr2JUorIgfscSSDdg7cs5DVSqUf3qhLR1Ic
        EFcObUjrCGHQu1b93CNooxNcr1f1B9CWaK7Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
        :subject:message-id:references:mime-version:content-type
        :in-reply-to; q=dns; s=sasl; b=o39xAzOi1yV97pRN/kycybXZlKEanR/pz
        9fE/WipTTnA3iq0SVAZCeAQymyS3PtiisaILWshIe5UV1zVxpfqoD4tz9//6VZKr
        8LpsUlkEcqRkLsDcBwnAgpDkDatBrAH1UmE+j2nheRInYE7SliOn+8BgDO/yFZWF
        wtn9uogxZM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 826DB33805;
        Fri, 17 Aug 2018 15:33:53 -0400 (EDT)
        (envelope-from tmz@pobox.com)
Received: from zaya.teonanacatl.net (unknown [98.111.125.125])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 43FE9337FD;
        Fri, 17 Aug 2018 15:33:50 -0400 (EDT)
        (envelope-from tmz@pobox.com)
Date:   Fri, 17 Aug 2018 15:33:47 -0400
From:   Todd Zullinger <tmz@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC/PATCH] drop vcs-svn experiment
Message-ID: <20180817193347.GL24629@zaya.teonanacatl.net>
References: <20180817190310.GA5360@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180817190310.GA5360@sigill.intra.peff.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Pobox-Relay-ID: 77C2DD98-A254-11E8-93CA-F5C31241B9FE-09356542!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jeff,

Jeff King wrote:
>  .gitignore                     |   1 -
>  Makefile                       |  22 --
>  contrib/svn-fe/.gitignore      |   4 -
>  contrib/svn-fe/Makefile        | 105 -------
>  contrib/svn-fe/svn-fe.c        |  18 --
>  contrib/svn-fe/svn-fe.txt      |  71 -----
>  contrib/svn-fe/svnrdump_sim.py |  68 -----
>  remote-testsvn.c               | 337 --------------------
>  t/helper/test-line-buffer.c    |  81 -----
>  t/helper/test-svn-fe.c         |  52 ----
>  t/t9020-remote-svn.sh          |  89 ------

Doesn't t/t9010-svn-fe.sh also need to be removed?  It uses
the test-svn-fe helper which is removed.

The Fedora git-svn package has included git-remote-testsvn
for years now but no one has ever filed any bug reports
about it.  I looked at whether it should be packaged last
year.  I came to the conclusion that while it could be used
outside of the test suite it was doubtful it actually was.

-- 
Todd
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
No one ever went broke underestimating the taste of the American
public.
    -- H. L. Mencken

