X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-svn: why fetching files is so slow
Date: Fri, 24 Nov 2006 12:42:26 -0800
Message-ID: <7vy7q0a85p.fsf@assigned-by-dhcp.cox.net>
References: <loom.20061124T143148-286@post.gmane.org>
	<20061124191609.GA32506@localdomain>
	<loom.20061124T202153-512@post.gmane.org>
	<20061124203320.GA21654@soma>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 24 Nov 2006 20:42:51 +0000 (UTC)
Cc: git@vger.kernel.org, Pazu <pazu@pazu.com.br>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061124203320.GA21654@soma> (Eric Wong's message of "Fri, 24
	Nov 2006 12:33:20 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32237>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GnhsV-0005PL-N1 for gcvg-git@gmane.org; Fri, 24 Nov
 2006 21:42:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S935053AbWKXUm2 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 24 Nov 2006
 15:42:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935056AbWKXUm2
 (ORCPT <rfc822;git-outgoing>); Fri, 24 Nov 2006 15:42:28 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:18073 "EHLO
 fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP id S935053AbWKXUm2
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 24 Nov 2006 15:42:28 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao11.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061124204227.VVXQ296.fed1rmmtao11.cox.net@fed1rmimpo02.cox.net>; Fri, 24
 Nov 2006 15:42:27 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id qkib1V0021kojtg0000000; Fri, 24 Nov 2006
 15:42:35 -0500
To: Eric Wong <normalperson@yhbt.net>
Sender: git-owner@vger.kernel.org

Eric Wong <normalperson@yhbt.net> writes:

> Pazu <pazu@pazu.com.br> wrote:
>> Eric Wong <normalperson <at> yhbt.net> writes:
>> 
>> > git-svn transfers full files, and not deltas.  I'll hopefully have a
>> > chance to look into improving the situation for slow links this weekend.
>> 
>> Yes, but why would that make fetching the first revision slower? In this
>> situation, both svn and git-svn would have to fetch full files. Maybe git-svn
>> isn't using gzip compression or http pipelining?
>
> Even for the initial transfer, the tree is bundled into one big delta
> (at least over https).

Do you mean that "one big delta" saves duplicates across copies
inside the tree (e.g. svn tags and branches can be expressed as
a mostly identical copies of each other), or do you mean "one
full file at a time" requests are killing us, compared to a such
single transfer of "one big delta"?

