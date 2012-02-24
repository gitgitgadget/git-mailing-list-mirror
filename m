From: Ian Kumlien <pomac@vapor.com>
Subject: Re: [FYI] very large text files and their problems.
Date: Fri, 24 Feb 2012 13:55:52 +0100
Message-ID: <20120224125552.GB9526@pomac.netswarm.net>
References: <20120222154926.GC11202@pomac.netswarm.net>
 <CACsJy8Bdbegs7QdztvsFnKPcpAX5UL7s7uc37wF3_nF4kJQjrQ@mail.gmail.com>
 <20120224101121.GA9526@pomac.netswarm.net>
 <CACsJy8Aq=ofaHo3RkOBWTYP3eehZAU0E=HeDoUpR0nh+seKxzA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 24 13:56:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0uh2-0007cR-0s
	for gcvg-git-2@plane.gmane.org; Fri, 24 Feb 2012 13:56:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755133Ab2BXM4G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Feb 2012 07:56:06 -0500
Received: from mail.vapor.com ([83.220.149.2]:33395 "EHLO nitrogen.vapor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753916Ab2BXM4F (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Feb 2012 07:56:05 -0500
Received: from twilight.demius.net (c-387a71d5.013-195-6c756e10.cust.bredbandsbolaget.se [213.113.122.56])
	by nitrogen.vapor.com (Postfix) with ESMTPSA id 3D9D540C674;
	Fri, 24 Feb 2012 13:55:53 +0100 (CET)
Received: by twilight.demius.net (Postfix, from userid 1000)
	id 14B858E06C1; Fri, 24 Feb 2012 13:55:53 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <CACsJy8Aq=ofaHo3RkOBWTYP3eehZAU0E=HeDoUpR0nh+seKxzA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191433>

On Fri, Feb 24, 2012 at 06:14:46PM +0700, Nguyen Thai Ngoc Duy wrote:
> On Fri, Feb 24, 2012 at 5:11 PM, Ian Kumlien <pomac@vapor.com> wrote:
> > I'm uncertain if you got my reply since i did it out of bounds - so i'll
> > repeat myself - sorry... =)
> 
> yes I received it, just too busy this week.

Ah good, you never know what anti-spam measures people applies these
days... =)

And i have the same, so i totally understand.

> >> > git needs to have atleast the same ammount of memory as the largest
> >> > file free... Couldn't this be worked around?
> >> >
> >> > On a (32 bit) machine with 4GB memory - results in:
> >> > fatal: Out of memory, malloc failed (tried to allocate 3310214313 bytes)
> >> >
> >> > (and i see how this could be a problem, but couldn't it be mitigated? or
> >> > is it bydesign and intended behaviour?)
> >>
> >> I think that it's delta resolving that hogs all your memory. If your
> >> files are smaller than 512M, try lower core.bigFileThreshold. The
> >> topic jc/split-blob, which stores a big file are several smaller
> >> pieces, might solve your problem. Unfortunately the topic is not
> >> complete yet.
> >
> > Well, in this case it's just stream unpacking gzip data to disk, i
> > understand if delta would be a problem... But wouldn't delta be a
> > problem in the sence of <size_of_change>+<size_of_subdata>+<result> ?
> >
> > Ie, if the file is mmapped - it shouldn't have to be allocated, right?
> 
> We should not delta large files. I was worried that the large file
> check could go wrong, But I guess your blob's not deltified in this
> case.

That would be correct

> When you receive a pack during a clone, the pack is streamed to
> index-pack, not mmapped, and index-pack checks every object in there
> in uncompressed form. I think I have found a way to avoid allocating
> that much. Need some more check, then send out.

Ah! That explains alot - do you have a publicly available version i
could look at?

> -- 
> Duy
