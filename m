From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: git fetch -v not at all verbose?
Date: Thu, 21 Jan 2010 18:35:18 +0200
Message-ID: <20100121163518.GA16466@redhat.com>
References: <20100121004756.GA18213@onerussian.com> <20100121050850.GA18896@Knoppix> <be6fef0d1001202247l7467a14ap8181eb3ed830167a@mail.gmail.com> <20100121155136.17b59e8f.rctay89@gmail.com> <20100121140054.GH18213@onerussian.com> <20100121224100.624c9c9d.rctay89@gmail.com> <20100121155637.GA19078@spearce.org> <20100121160707.GA31276@glandium.org> <20100121161016.GA16300@redhat.com> <20100121161858.GC19078@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Jan 21 17:39:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NY03x-0003wa-Ub
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jan 2010 17:39:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752486Ab0AUQjM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jan 2010 11:39:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751650Ab0AUQjM
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jan 2010 11:39:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:10908 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751955Ab0AUQjL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jan 2010 11:39:11 -0500
Received: from int-mx03.intmail.prod.int.phx2.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.16])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id o0LGcMvS010996
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Thu, 21 Jan 2010 11:38:22 -0500
Received: from redhat.com (vpn2-8-112.ams2.redhat.com [10.36.8.112])
	by int-mx03.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with SMTP id o0LGcKkJ026379;
	Thu, 21 Jan 2010 11:38:21 -0500
Content-Disposition: inline
In-Reply-To: <20100121161858.GC19078@spearce.org>
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.16
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137671>

On Thu, Jan 21, 2010 at 08:18:58AM -0800, Shawn O. Pearce wrote:
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > On many of my trees (with linux kernel), git fetch is slower than git clone.
> > Even more annoyingly, it would hang sometimes for tens of minutes without any
> > output, even if -v is supplied.
> 
> Ouch.  I think -v -v boosts the output to be ever more verbose,
> and might actually show you something.
>  
> > stracing it shows a ton of lines like the following:
> > 16324 read(10, "ACK 4bbdfe65d23014f539fec4227260"..., 51) = 51
> > 16324 read(10, "0037", 4)               = 4
> > 16324 read(10, "ACK 322c06560fa314b04a6302ea03c0"..., 51) = 51
> > 16324 read(10, "0037", 4)               = 4
> > 16324 read(10, "ACK 848ea2043b128b5947851866a114"..., 51) = 51
> > 16324 read(10, "0037", 4)               = 4
> 
> That's the peers trying to determine a common base.
>  
> > Is there some way to make got fetch show progress at this stage,
> > or even better, can it be made faster somehow?
> 
> We shouldn't need to show progress here, we should just be faster.
> 
> Given the symptom, it sounds to me like your local repository
> is some 1,000s of commits ahead of the remote repository you are
> fetching from.  Is that true?

Hmm, no, but what is true is that I fetched several remotes
that diverged significantly into the same local repository.
Would that have same effect?

> Are you fetching from a configured remote that has tracking branches,
> or are you fetching through a one-shot URL pasted onto the command
> line?

Configured remote.

> -- 
> Shawn.
