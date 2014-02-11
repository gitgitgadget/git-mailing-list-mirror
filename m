From: John Keeping <john@keeping.me.uk>
Subject: Re: Profiling support?
Date: Tue, 11 Feb 2014 15:14:52 +0000
Message-ID: <20140211151451.GA15032@serenity.lan>
References: <87d2itc2zv.fsf@fencepost.gnu.org>
 <CACsJy8BAD3cm2BLSapJ2fhkGiYjDKqW1TQ1yu0XPwTyEfL2oLQ@mail.gmail.com>
 <878uthbtjg.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Tue Feb 11 16:15:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WDF3e-0002h7-MC
	for gcvg-git-2@plane.gmane.org; Tue, 11 Feb 2014 16:15:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752056AbaBKPPS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Feb 2014 10:15:18 -0500
Received: from jackal.aluminati.org ([72.9.247.210]:52157 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752047AbaBKPPR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Feb 2014 10:15:17 -0500
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 22EC7CDA5CD;
	Tue, 11 Feb 2014 15:15:16 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -1
X-Spam-Level: 
X-Spam-Status: No, score=-1 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1] autolearn=disabled
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ed4xeyujY8OI; Tue, 11 Feb 2014 15:15:15 +0000 (GMT)
Received: from coyote.aluminati.org (coyote.aluminati.org [10.0.16.51])
	by jackal.aluminati.org (Postfix) with ESMTP id CA08ACDA5AF;
	Tue, 11 Feb 2014 15:15:14 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id DD58B6064A7;
	Tue, 11 Feb 2014 15:15:14 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xhCMOuSZS7pK; Tue, 11 Feb 2014 15:15:14 +0000 (GMT)
Received: from serenity.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id EE6E06064E6;
	Tue, 11 Feb 2014 15:15:08 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <878uthbtjg.fsf@fencepost.gnu.org>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241947>

On Tue, Feb 11, 2014 at 03:41:55PM +0100, David Kastrup wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
> 
> > On Tue, Feb 11, 2014 at 6:17 PM, David Kastrup <dak@gnu.org> wrote:
> >>
> >> Looking in the Makefile, I just find support for coverage reports using
> >> gcov.  Whatever is there with "profile" in it seems to be for
> >> profile-based compilation rather than using gprof.
> >>
> >> Now since I've managed to push most of the runtime for basic git-blame
> >> operation out of blame.c proper, it becomes important to figure out
> >> where most of the remaining runtime (a sizable part of that being system
> >> time) is being spent.  Loop counts like that provided by gcov (or am I
> >> missing something here?) are not helpful for that, I think I rather need
> >> the kind of per-function breakdown that gprof provides.
> >>
> >> Is there a reason there are no prewired recipes or advice for using
> >> gprof on git?  Is there a way to get the work done, namely seeing the
> >> actual distribution of call times (rather than iterations) using gcov so
> >> that this is not necessary?
> >
> > Would perf help? No changes required, and almost no overhead, I think.
> 
> Not useful.  It would be probably nice for nailing down the performance
> gains when the work is finished so that future regressions will be
> noticeable.  It's reasonable easy to create a test case that will take
> hours with the current git-blame and would finish in seconds with the
> improved one.
> 
> But it's not useful at all for figuring out the hotspots within the
> git-blame binary.

I would have thought the annotation described at [1] is exactly what
you're looking for, isn't it?

Alternatively, I've had some success with callgrind and kCachegrind in
the past.

[1] https://perf.wiki.kernel.org/index.php/Tutorial#Source_level_analysis_with_perf_annotate
