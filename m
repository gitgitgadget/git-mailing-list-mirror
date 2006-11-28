X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 1.2/2 (fixed)] git-svn: fix output reporting from the delta fetcher
Date: Tue, 28 Nov 2006 12:16:05 -0800
Message-ID: <20061128201605.GA1369@localdomain>
References: <loom.20061124T143148-286@post.gmane.org> <20061128054448.GA396@soma> <20061128102958.GA5207@soma> <20061128105017.GA20366@soma> <9e7ab7380611280445r4ebe344cw69cbc18a74c6122f@mail.gmail.com> <9e7ab7380611280732k4e940380tbf2a96146807d671@mail.gmail.com> <m2bqmr1rnw.fsf@ziti.fhcrc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 28 Nov 2006 20:17:03 +0000 (UTC)
Cc: Pazu <pazu@pazu.com.br>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <m2bqmr1rnw.fsf@ziti.fhcrc.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32571>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gp9Nl-0002I2-Gf for gcvg-git@gmane.org; Tue, 28 Nov
 2006 21:16:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965828AbWK1UQK (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 28 Nov 2006
 15:16:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965918AbWK1UQK
 (ORCPT <rfc822;git-outgoing>); Tue, 28 Nov 2006 15:16:10 -0500
Received: from hand.yhbt.net ([66.150.188.102]:238 "EHLO hand.yhbt.net") by
 vger.kernel.org with ESMTP id S965828AbWK1UQH (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 28 Nov 2006 15:16:07 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1]) by hand.yhbt.net
 (Postfix) with SMTP id CAE722DC035; Tue, 28 Nov 2006 12:16:05 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Tue, 28 Nov 2006
 12:16:05 -0800
To: Seth Falcon <sethfalcon@gmail.com>
Sender: git-owner@vger.kernel.org

Seth Falcon <sethfalcon@gmail.com> wrote:
> Pazu <pazu@pazu.com.br> writes:
> > Notice that there's no "CamelEar" directory. For some reason, it
> > wasn't fetched in the initial revision. Now, just to make sure this
> > isn't svn fault:
> >
> > mini:~/devel/camel-git pazu$ svn ls -r11143
> > https://tech.bga.bunge.com/BungeHomeExt/GLS/trunk/java/bg-cam
> > .cvsignore
> > BungeIntegrationEar/
> > BungeIntegrationService/
> > BungeIntegrationServiceClient/
> > CamelEar/
> 
> Is CamelEar an empty directory (or was it an empty directory in the
> first fetch) by any chance?
> 
> I think that presently git-svn does not create empty dirs when pulling
> from svn.  It would be nice to have such directories created since
> some projects will expect the empty dir to be there (no need to track
> it in git, IMO).

Git itself cannot easily track empty directories (at least as far as
update-index and checkout) goes.

What I *can* do is run mktree and to force the creation of tree objects
with a 4b825dc642cb6eb9a060e54bf8d69288fbee4904 (empty) sub tree and run
commit-tree on it, but checkout/checkout-index would still need to be
modified to support it.

Is that something the git community wants?

-- 
