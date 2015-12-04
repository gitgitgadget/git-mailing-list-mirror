From: John Keeping <john@keeping.me.uk>
Subject: Re: best practices against long git rebase times?
Date: Fri, 4 Dec 2015 17:28:51 +0000
Message-ID: <20151204172851.GQ18913@serenity.lan>
References: <20151204150546.GA17210@inner.h.apk.li>
 <CANgJU+Ums-zg1kDiW4mm_X_zxreb=wBVc1gpHUOFN=44x1TyRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Krey <a.krey@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: demerphq <demerphq@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 04 18:29:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a4uAT-00008l-Aj
	for gcvg-git-2@plane.gmane.org; Fri, 04 Dec 2015 18:29:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751183AbbLDR3I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Dec 2015 12:29:08 -0500
Received: from jackal.aluminati.org ([72.9.247.210]:60581 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750937AbbLDR3H (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Dec 2015 12:29:07 -0500
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 148D3CDA56B;
	Fri,  4 Dec 2015 17:29:05 +0000 (GMT)
X-Quarantine-ID: <w-u3Ak+dgz7Z>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -1
X-Spam-Level: 
X-Spam-Status: No, score=-1 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_20=-0.001, URIBL_BLOCKED=0.001]
	autolearn=no
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id w-u3Ak+dgz7Z; Fri,  4 Dec 2015 17:29:01 +0000 (GMT)
Received: from serenity.lan (banza.aluminati.org [10.0.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 8B260CDA547;
	Fri,  4 Dec 2015 17:28:52 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <CANgJU+Ums-zg1kDiW4mm_X_zxreb=wBVc1gpHUOFN=44x1TyRQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281989>

On Fri, Dec 04, 2015 at 06:09:33PM +0100, demerphq wrote:
> On 4 December 2015 at 16:05, Andreas Krey <a.krey@gmx.de> wrote:
> > Hi all,
> >
> > our workflow is pretty rebase-free for diverse reasons yet.
> >
> > One obstacle now appearing is that rebases simply take
> > very long - once you might want to do a rebase there are
> > several hundred commits on the remote branch, and our tree
> > isn't small either.
> >
> > This produces rebase times in the minute range.
> > I suppose this is because rebase tries to see
> > if there are new commits in the destination
> > branch that are identical to one of the local
> > commits, to be able to skip them. (I didn't
> > try to verify this hypothesis.)
> >
> > What can we do to make this faster?
> 
> I bet you have a lot of refs; tags, or branches.
> 
> git rebase performance along with many operations seems to scale
> proportionately to the number of tags.
> 
> At $work we create a tag every time we "roll out" a "server type".
> 
> This produces many tags a day.
> 
> Over time rebase, and many operations actually, start slowing down to
> the point of painfulness.
> 
> The workaround we ended up using was to set up a cron job and related
> infra that removed old tags.
> 
> Once we got rid of most of our old tags git became nice to use again.

This is quite surprising.  Were you using packed or loose tags?

It would be interesting to run git-rebase with GIT_TRACE_PERFORMANCE to
see which subcommand is slow in this particular scenario.
