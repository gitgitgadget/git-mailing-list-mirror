From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: git fetch -v not at all verbose?
Date: Thu, 21 Jan 2010 19:30:10 +0200
Message-ID: <20100121173010.GB16707@redhat.com>
References: <be6fef0d1001202247l7467a14ap8181eb3ed830167a@mail.gmail.com> <20100121155136.17b59e8f.rctay89@gmail.com> <20100121140054.GH18213@onerussian.com> <20100121224100.624c9c9d.rctay89@gmail.com> <20100121155637.GA19078@spearce.org> <20100121160707.GA31276@glandium.org> <20100121161016.GA16300@redhat.com> <20100121161858.GC19078@spearce.org> <20100121163518.GA16466@redhat.com> <20100121165737.GG19078@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Jan 21 18:33:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NY0up-0006Ez-KZ
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jan 2010 18:33:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754497Ab0AURdu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jan 2010 12:33:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753834Ab0AURdu
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jan 2010 12:33:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53365 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751636Ab0AURdt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jan 2010 12:33:49 -0500
Received: from int-mx08.intmail.prod.int.phx2.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.21])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id o0LHXE0O023252
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Thu, 21 Jan 2010 12:33:14 -0500
Received: from redhat.com (vpn2-8-112.ams2.redhat.com [10.36.8.112])
	by int-mx08.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with SMTP id o0LHXBZI019489;
	Thu, 21 Jan 2010 12:33:12 -0500
Content-Disposition: inline
In-Reply-To: <20100121165737.GG19078@spearce.org>
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.21
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137675>

On Thu, Jan 21, 2010 at 08:57:37AM -0800, Shawn O. Pearce wrote:
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > On Thu, Jan 21, 2010 at 08:18:58AM -0800, Shawn O. Pearce wrote:
> > > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > > On many of my trees (with linux kernel), git fetch is slower than git clone.
> > > > Even more annoyingly, it would hang sometimes for tens of minutes without any
> > > > output, even if -v is supplied.
> ...
> > > Given the symptom, it sounds to me like your local repository
> > > is some 1,000s of commits ahead of the remote repository you are
> > > fetching from.  Is that true?
> > 
> > Hmm, no, but what is true is that I fetched several remotes
> > that diverged significantly into the same local repository.
> > Would that have same effect?
> 
> Yes.
> 
> > > Are you fetching from a configured remote that has tracking branches,
> > > or are you fetching through a one-shot URL pasted onto the command
> > > line?
> > 
> > Configured remote.
> 
> Hmm.  I wonder if we should try to shortcut the commit walking in
> a case like this and just feed the tracking branches we already have.

Or for the case of 1,000s of commits ahead, git could try to implement a
heuristic to reduce the number of commits sent. Currently all commits
are sent in order, correct?  How about binary search like what git
bisect does?

> -- 
> Shawn.
