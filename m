From: Willy Tarreau <w@1wt.eu>
Subject: Re: [PATCH] sequencer.c: fix detection of duplicate s-o-b
Date: Thu, 7 Apr 2016 22:16:36 +0200
Message-ID: <20160407201636.GA29322@1wt.eu>
References: <20160312130844.GA25639@1wt.eu>
 <xmqqr3eizsxu.fsf@gitster.mtv.corp.google.com>
 <20160406163726.GG28596@1wt.eu>
 <CAP8UFD2OQfcogZj-hELxBB+-rWSW1YwPBCOXK1+oM2kKGaMwaA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
	Brandon Casey <drafnel@gmail.com>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 07 22:16:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoGMB-0003bh-90
	for gcvg-git-2@plane.gmane.org; Thu, 07 Apr 2016 22:16:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757380AbcDGUQn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Apr 2016 16:16:43 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:2048 "EHLO 1wt.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753180AbcDGUQm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Apr 2016 16:16:42 -0400
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id u37KGaRl029326;
	Thu, 7 Apr 2016 22:16:36 +0200
Content-Disposition: inline
In-Reply-To: <CAP8UFD2OQfcogZj-hELxBB+-rWSW1YwPBCOXK1+oM2kKGaMwaA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290981>

Hi Christian,

On Thu, Apr 07, 2016 at 04:06:59PM -0400, Christian Couder wrote:
> On Wed, Apr 6, 2016 at 12:37 PM, Willy Tarreau <w@1wt.eu> wrote:
> > On Wed, Apr 06, 2016 at 07:57:01AM -0700, Junio C Hamano wrote:
> >> This seems to have been lost, perhaps because the top part that was
> >> quite long didn't look like a patch submission message or something.
> >
> > Don't worry, we all know it's the submitter's responsibility to retransmit,
> > I apply the same principle :-)
> >
> >> Git 1.7.12 is a quite ancient release and I wouldn't be surprised if
> >> we made the behaviour change during the period leading to v2.6 on
> >> purpose, but nothing immediately comes to mind. Christian (as the
> >> advocate for the trailer machinery) and Brandon ("git shortlog
> >> sequencer.c" suggests you), can you take a look?
> 
> Ok, I will try to have a look at that next week.
> 
> > FWIW it wad changed in 1.8.3 by commit bab4d10 ("sequencer.c: teach
> > append_signoff how to detect duplicate s-o-b").
> 
> So the change is quite old and was made before I started working on
> the trailer machinery.
> 
> > The change made a lot of sense but it didn't assume that this practice
> > was common. And indeed I think this practice only happens in maintenance
> > branches where people have to make a lot of adaptations to existing
> > patches that they're cherry-picking. We do that a lot in stable kernels
> > to keep track of what we may need to revisit if we break something.
> 
> Yeah, we know for some time, but after the above patch breakage
> happened and after I worked on interpret-trailers, that some lines
> inside [] are added by kernel people in the trailer part and that the
> trailer machinery doesn't work properly with such lines.
> 
> Anyway if you want your patch to be applied, it will probably need tests.

Thanks. I've discussed with Junio yesterday who notified me that my patch
broke some existing tests that I hadn't updated (I didn't know they existed)
namely one supposed to make the distinction between a normal footer and a
special case where the s-o-b is in fact part of the last paragraph. So I
said I'll rework the patch to only consider the parts between brackets
above a footer. Thus no need to waste your time testing the current patch
next week.

Thanks,
Willy
