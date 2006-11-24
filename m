X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn: why fetching files is so slow
Date: Fri, 24 Nov 2006 14:14:35 -0800
Message-ID: <20061124221435.GA21072@localdomain>
References: <loom.20061124T143148-286@post.gmane.org> <20061124191609.GA32506@localdomain> <loom.20061124T202153-512@post.gmane.org> <20061124203320.GA21654@soma> <7vy7q0a85p.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 24 Nov 2006 22:14:57 +0000 (UTC)
Cc: git@vger.kernel.org, Pazu <pazu@pazu.com.br>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <7vy7q0a85p.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32241>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GnjJi-0001qx-5D for gcvg-git@gmane.org; Fri, 24 Nov
 2006 23:14:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S935097AbWKXWOj (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 24 Nov 2006
 17:14:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935098AbWKXWOj
 (ORCPT <rfc822;git-outgoing>); Fri, 24 Nov 2006 17:14:39 -0500
Received: from hand.yhbt.net ([66.150.188.102]:17625 "EHLO hand.yhbt.net") by
 vger.kernel.org with ESMTP id S935097AbWKXWOi (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 24 Nov 2006 17:14:38 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1]) by hand.yhbt.net
 (Postfix) with SMTP id B426D7DC098; Fri, 24 Nov 2006 14:14:35 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Fri, 24 Nov 2006
 14:14:35 -0800
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano <junkio@cox.net> wrote:
> Eric Wong <normalperson@yhbt.net> writes:
> 
> > Pazu <pazu@pazu.com.br> wrote:
> >> Eric Wong <normalperson <at> yhbt.net> writes:
> >> 
> >> > git-svn transfers full files, and not deltas.  I'll hopefully have a
> >> > chance to look into improving the situation for slow links this weekend.
> >> 
> >> Yes, but why would that make fetching the first revision slower? In this
> >> situation, both svn and git-svn would have to fetch full files. Maybe git-svn
> >> isn't using gzip compression or http pipelining?
> >
> > Even for the initial transfer, the tree is bundled into one big delta
> > (at least over https).
> 
> Do you mean that "one big delta" saves duplicates across copies
> inside the tree (e.g. svn tags and branches can be expressed as
> a mostly identical copies of each other), or do you mean "one
> full file at a time" requests are killing us, compared to a such
> single transfer of "one big delta"?

One full file at a time requests are definitely killing us (over slow
links, at least).  I'm not sure how/if duplicates inside a requested
tree are optimized on the server side.

-- 
