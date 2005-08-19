From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: Questions on 'cvs migration guide''
Date: Fri, 19 Aug 2005 17:58:07 +1200
Message-ID: <46a038f9050818225865deb7ee@mail.gmail.com>
References: <46a038f9050818201717f9ed93@mail.gmail.com>
	 <Pine.LNX.4.58.0508182130050.3412@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 19 07:58:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E5ztQ-0002So-7X
	for gcvg-git@gmane.org; Fri, 19 Aug 2005 07:58:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932565AbVHSF6N (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 Aug 2005 01:58:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932566AbVHSF6N
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Aug 2005 01:58:13 -0400
Received: from rproxy.gmail.com ([64.233.170.193]:54395 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932565AbVHSF6M convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Aug 2005 01:58:12 -0400
Received: by rproxy.gmail.com with SMTP id i8so447760rne
        for <git@vger.kernel.org>; Thu, 18 Aug 2005 22:58:07 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=P2/RXJumaAheasUBL7yhaX9MbXRNe62SH/bisQBNK3b6bIATW51JFFH2Cc41aoS8M887NE+QJTx5aNKP4af74WfbY2IQ9PgX8bZXQO70NOYlENiUiJueLKWt6KWpRmCH70pPF7Km9YeYW1GuXg77nAjo032F47RX6mxYN4rOXVY=
Received: by 10.38.104.44 with SMTP id b44mr5340rnc;
        Thu, 18 Aug 2005 22:58:07 -0700 (PDT)
Received: by 10.38.101.8 with HTTP; Thu, 18 Aug 2005 22:58:07 -0700 (PDT)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0508182130050.3412@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On 8/19/05, Linus Torvalds <torvalds@osdl.org> wrote:
> > And yet another question: the teammember who is pulling must 'switch'
> > the merging repo to the right branch, pull from the corresponding
> > remote repos of each teammember, and push to the public view of the
> > repo. Is that right?
> 
> .. yes. Or alternatively, just keep the repo at that branch (and if such a
> person works on multiple branches, he/she can thus just keep multiple
> repos).

I'm keen on keeping my 'merge & publish' step in a single repo that
has all the 'team' branches. The person running this repo will
probably actually code in separate repos, and merge in there too.

Right now I'm switching 'heads' (I'm getting used to cogito's use of
'branch' for 'remote head') using this quick'n'dirty bit of shell:

#!/bin/bash 

HEADNAME=$1

if [ -e .git/refs/heads/$HEADNAME ]; then
	cd .git/
	ln -s -f .git/refs/heads/$HEADNAME HEAD
	cd ..
	cg-reset
	cg-restore -f

fi;

but I want to prevent the action if the checkout is 'dirty'. Is there
any way to check whether cg-diff thinks anything has changed?

cheers,


martin
