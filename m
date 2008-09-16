From: Jing Xue <jingxue@digizenstudio.com>
Subject: Re: [PATCH] Optional shrinking of RCS keywords in git-p4
Date: Tue, 16 Sep 2008 08:58:56 -0400
Message-ID: <20080916125856.GB3069@jabba.hq.digizenstudio.com>
References: <16219.81556.qm@web95005.mail.in2.yahoo.com> <20080915063521.GA1533@linode.davidb.org> <7vy71tetvt.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.00.0809151354040.19665@iabervon.org> <20080916041201.GA25033@linode.davidb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <gitster@pobox.com>,
	dhruva <dhruva@ymail.com>, GIT SCM <git@vger.kernel.org>,
	Simon Hausmann <simon@lst.de>
To: David Brown <git@davidb.org>
X-From: git-owner@vger.kernel.org Tue Sep 16 15:07:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfaAH-0004Rh-1J
	for gcvg-git-2@gmane.org; Tue, 16 Sep 2008 15:00:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753590AbYIPM7K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2008 08:59:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753204AbYIPM7J
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Sep 2008 08:59:09 -0400
Received: from k2smtpout03-01.prod.mesa1.secureserver.net ([64.202.189.171]:59508
	"HELO k2smtpout03-01.prod.mesa1.secureserver.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753074AbYIPM7I (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Sep 2008 08:59:08 -0400
Received: (qmail 26476 invoked from network); 16 Sep 2008 12:59:03 -0000
Received: from unknown (HELO ip-72-167-33-213.ip.secureserver.net) (72.167.33.213)
  by k2smtpout03-01.prod.mesa1.secureserver.net (64.202.189.171) with ESMTP; 16 Sep 2008 12:59:03 -0000
Received: from localhost (unknown [127.0.0.1])
	by ip-72-167-33-213.ip.secureserver.net (Postfix) with ESMTP id BC6B6100A22;
	Tue, 16 Sep 2008 12:59:03 +0000 (UTC)
Received: from ip-72-167-33-213.ip.secureserver.net ([127.0.0.1])
	by localhost (ip-72-167-33-213.ip.secureserver.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id g1BMkvMVQhNu; Tue, 16 Sep 2008 08:58:58 -0400 (EDT)
Received: from jabba.hq.digizenstudio.com (ip70-174-133-176.dc.dc.cox.net [70.174.133.176])
	by ip-72-167-33-213.ip.secureserver.net (Postfix) with ESMTP id DE68110008B;
	Tue, 16 Sep 2008 08:58:57 -0400 (EDT)
Received: by jabba.hq.digizenstudio.com (Postfix, from userid 1000)
	id B187348E9A; Tue, 16 Sep 2008 08:58:56 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20080916041201.GA25033@linode.davidb.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95999>

On Mon, Sep 15, 2008 at 09:12:01PM -0700, David Brown wrote:
> A simple way to be paranoid would be something (shell-ish) like:
>
>   p4 print filename | collapse-keywords | git hash-object --stdin
>
> and make sure that is the version we think the file should have
> started with.  I think we're really just making sure we didn't miss a
> P4 change that someone else made underneath, and we're about to back
> out.
> Even this isn't robust from p4's point of view.  The p4 model is to do
> a 'p4 edit' on the file, and then the later 'p4 submit' will give an
> error if someone else has updated the file.  This would require using
> p4's conflict resolution, and I'm guessing someone using git-p4 would
> rather abort the submit and rebase.

How about collapsing the keywords in the _p4_ version after "p4 edit"
but before applying the patch, and just "p4 submit" the collapsed
version if patching succeeds? As pointed out earlier in this thread, p4
submit doesn't care about whether keywords are expanded or not anyway.

Cheers.
-- 
Jing Xue
