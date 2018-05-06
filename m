Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9EC02200B9
	for <e@80x24.org>; Sun,  6 May 2018 00:38:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751834AbeEFAiq (ORCPT <rfc822;e@80x24.org>);
        Sat, 5 May 2018 20:38:46 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50940 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751775AbeEFAip (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 May 2018 20:38:45 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EF729DC755;
        Sat,  5 May 2018 20:38:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=sasl; bh=nw1kic+7ULVWiiOdEo/32hsCc+E=; b=uZ0Zqm8
        hnjxklxeyqNyGyGTo530D15x0vvj0DlQkr5Cn2cvKJT2dX2tZ91jOWCLg0FtQKa0
        Q4/eanuBuVa0gz7tX/Tsv5q5D8AkjUwtbCy+GfZeuFrf3v7fh+L9+lwEYKYPfMQG
        X47FcVyFHlR1txWXJbrDTnrghKEg4sWHCv/o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
        :subject:message-id:references:mime-version:content-type
        :in-reply-to; q=dns; s=sasl; b=EThq9fQN0VXwXmiWRTYHbXqea5YyPcBr1
        472YOrGvVKM2KHU2yBXm7Hnm57BsAeCR2sTwtY6kQuSOTnOD3iCVdamk0v6vsJDC
        k9z1tOPYsGGgVo3Axd/bC5DGonwKLGaJP9GLyiGOIgnzEqFus8ez7THY/f2pC5bL
        /ODDUXFbKg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E6A3CDC754;
        Sat,  5 May 2018 20:38:44 -0400 (EDT)
Received: from zaya.teonanacatl.net (unknown [98.111.125.125])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 529A0DC753;
        Sat,  5 May 2018 20:38:44 -0400 (EDT)
Date:   Sat, 5 May 2018 20:38:42 -0400
From:   Todd Zullinger <tmz@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 02/18] Add a new builtin: branch-diff
Message-ID: <20180506003842.GT26695@zaya.teonanacatl.net>
References: <cover.1525361419.git.johannes.schindelin@gmx.de>
 <cover.1525448066.git.johannes.schindelin@gmx.de>
 <a1ea0320b64527ee6ce9856dcf359513d13052b7.1525448066.git.johannes.schindelin@gmx.de>
 <20180505182631.GC17700@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1805052355190.77@tvgsbejvaqbjf.bet>
 <20180506002532.GS26695@zaya.teonanacatl.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180506002532.GS26695@zaya.teonanacatl.net>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Pobox-Relay-ID: D4E46CFC-50C5-11E8-B5F6-44CE1968708C-09356542!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I wrote:
> Would it be possible and reasonable to teach 'git branch' to
> call this as a subcommand, i.e. as 'git branch diff'?  Then
> the completion wouldn't offer git branch-diff.

Of course right after I sent this, it occurred to me that
'git branch diff' would make mask the ability to create a
branch named diff.  Using 'git branch --diff ...' wouldn't
suffer that problem.

It does add a bit more overhead to the 'git branch' command,
in terms of documentation and usage.  I'm not sure it's too
much though.  The git-branch summary wouldn't change much:

-git-branch - List, create, or delete branches
+git-branch - List, create, delete, or diff branches

I hesitate to hit send again, in case I'm once again
overlooking a glaringly obvious problem with this idea. ;)

-- 
Todd
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Quick to judge, quick to anger, slow to understand.
Ignorance and prejudice and fear walk hand in hand.

