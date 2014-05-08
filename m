From: Jeff Sipek <jeffpc@josefsipek.net>
Subject: Re: [GUILT 07/28] Added test cases for "guilt fold".
Date: Thu, 8 May 2014 15:59:43 -0400
Message-ID: <20140508195942.GC1619@meili.valhalla.31bits.net>
References: <1395387126-13681-1-git-send-email-cederp@opera.com>
 <1395387126-13681-8-git-send-email-cederp@opera.com>
 <20140506194026.GK1655@meili.valhalla.31bits.net>
 <CAP=KgsQ2fvVWZG7OwwWac+tMeWaPTEdSrgFqE5gVfSAqNn-VCQ@mail.gmail.com>
 <20140507210601.GA1459@meili.valhalla.31bits.net>
 <CAP=KgsR2CD39XeC+UsPU_Oh2GDBg-WrF=+Q33jhfYvToZz7UwA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Per Cederqvist <cederp@opera.com>
X-From: git-owner@vger.kernel.org Thu May 08 21:59:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WiUTn-0001bV-AL
	for gcvg-git-2@plane.gmane.org; Thu, 08 May 2014 21:59:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755594AbaEHT7j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2014 15:59:39 -0400
Received: from josefsipek.net ([64.9.206.49]:1754 "EHLO josefsipek.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755214AbaEHT7j (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2014 15:59:39 -0400
Received: from meili.valhalla.31bits.net (c-98-209-117-250.hsd1.mi.comcast.net [98.209.117.250])
	by josefsipek.net (Postfix) with ESMTPSA id CAB9155654;
	Thu,  8 May 2014 15:59:37 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <CAP=KgsR2CD39XeC+UsPU_Oh2GDBg-WrF=+Q33jhfYvToZz7UwA@mail.gmail.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248437>

On Thu, May 08, 2014 at 09:41:22PM +0200, Per Cederqvist wrote:
> On Wed, May 7, 2014 at 11:06 PM, Jeff Sipek <jeffpc@josefsipek.net> wrote:
> > On Wed, May 07, 2014 at 10:59:56PM +0200, Per Cederqvist wrote:
> >> On Tue, May 6, 2014 at 9:40 PM, Jeff Sipek <jeffpc@josefsipek.net> wrote:
> >> > On Fri, Mar 21, 2014 at 08:31:45AM +0100, Per Cederqvist wrote:
> >> >> Test that we can combine any combination of patches with empty and
> >> >> non-empty messages, both with and without guilt.diffstat.  (All
> >> >> patches are empty.)
> >> >
> >> > I feel like we should have *some* content there - most of the time, I care
> >> > more about the diffs getting folded than the commit message :)
> >>
> >> I added these tests for a reason: the reproduce a bug in guilt that I found.
> >>
> >> I'm afraid that having some content might hide the bug I found. (I'm also
> >> equally afraid that it might uncover other bugs in guilt, which would delay
> >> integration of this patch series. So adding more test cases with content
> >> is a good thing to do, but maybe not in this patch series.)
> >
> > Fair enough.  I use guilt-fold all the time and it hasn't lost any of my
> > diffs, so I'm happy to defer this until some point in the future.
> >
> > ...
> >> > for using_diffstat in true false ; do
> >> >         for patcha in empty nonempty ; do
> >> >                 for patchb in empty nonempty ; do
> >> >                         echo "%% $patcha + $patchb (diffstat=$using_diffstat)"
> >> >                         ${patcha}_patch $patcha
> >> >                         ${patchb}_patch $patchb
> >> >                         cmd guilt pop $patchb
> >> >                         cmd guilt fold $patchb
> >> >                         fixup_time_info $patcha
> >> >                         cmd list_files
> >> >                         cleanup $patcha
> >> >                         cmd list_files
> >> >                 done
> >> >         done
> >> > done
> >> >
> >> > Aha!  That's better, IMO.
> >>
> >> I'll try that and post a version 2 of the series. It might take a few
> >> days, though.
> >
> > No problem.  I'm still the slower one of the two of us. :/
> >
> > Jeff.
> 
> There were a few details that made it a bit more complex than that,
> but I think the end result was still an improvement.

The devil's in the details :)

> The most obvious detail is that if you add two empty patches, you
> cannot name them both "empty", so when $patcha and $patchb is the same
> you have to add suffixes.
> 
> The other detail is that my tests used different commit messages when
> both commits contained a message.  I want to retain that behaviour, so
> that added a few lines of complexity.
> 
> I'll post an updated patch series once I've gone through all your
> comments.  In the meantime, you can see my new implementation here:
> 
> http://repo.or.cz/w/guilt/ceder.git/commitdiff/3107dc73eaff020da18024c3b5f5f92b94d17852?hp=6df110c95133d6e557ce3dbcb6fd39bc797f877b#patch2

Much better than the original, IMO.

Thanks,

Jeff.

-- 
We have joy, we have fun, we have Linux on a Sun...
