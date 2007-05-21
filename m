From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH v2] Submodule merge support
Date: Mon, 21 May 2007 03:37:58 -0400
Message-ID: <20070521073758.GP3141@spearce.org>
References: <20070520154227.GG5412@admingilde.org> <20070521062005.GK3141@spearce.org> <20070521073253.GU5412@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Martin Waitz <tali@admingilde.org>
X-From: git-owner@vger.kernel.org Mon May 21 09:38:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hq2T1-0000nS-Oe
	for gcvg-git@gmane.org; Mon, 21 May 2007 09:38:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754910AbXEUHiE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 May 2007 03:38:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754934AbXEUHiE
	(ORCPT <rfc822;git-outgoing>); Mon, 21 May 2007 03:38:04 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:58395 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754933AbXEUHiD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2007 03:38:03 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1Hq2St-00081W-Gi; Mon, 21 May 2007 03:37:59 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 18FD520FBAE; Mon, 21 May 2007 03:37:59 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20070521073253.GU5412@admingilde.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47984>

Martin Waitz <tali@admingilde.org> wrote:
> On Mon, May 21, 2007 at 02:20:05AM -0400, Shawn O. Pearce wrote:
> > > @@ -574,6 +575,21 @@ static void update_file_flags(const unsigned char *sha,
> > >  		void *buf;
> > >  		unsigned long size;
> > >  
> > > +		if (S_ISDIRLNK(mode)) {
> > > +			/* defer dirlinks to another process, don't try to */
> > > +			/* read the object "sha" here */
> > > +			const char *dirlink_checkout[] = {
> > > +				"dirlink-checkout", path, sha1_to_hex(sha), NULL
> > > +			};
> > > +			struct child_process cmd = {
> > > +				.argv = dirlink_checkout,
> > > +				.git_cmd = 1,
> > > +			};
> > 
> > My Solaris 9 system cannot compile this syntax, even though it is
> > a clean way to initalize the child_process.
> 
> any special thing it does not like in the above code or does it just
> not support structs that are initialized that way?

Its a very old Sun C compiler, and it doesn't like structs to be
initialized that way.  Yes, newer compilers are better, and gcc is
also better, but I'm unable to get our UNIX admins to actually do
their job and keep systems usable by the users.

/me starts to wonder why he continues with this day-job thing...

-- 
Shawn.
