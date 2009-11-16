From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] gitweb: Support for no project list on gitweb front
 page
Date: Mon, 16 Nov 2009 18:52:29 +0100
Message-ID: <20091116175228.GJ17748@machine.or.cz>
References: <1257520265-16699-1-git-send-email-pasky@suse.cz>
 <4AF472E5.1000602@eaglescrag.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "J.H." <warthog19@eaglescrag.net>
X-From: git-owner@vger.kernel.org Mon Nov 16 18:52:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NA5km-0006Dj-B9
	for gcvg-git-2@lo.gmane.org; Mon, 16 Nov 2009 18:52:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751871AbZKPRw1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Nov 2009 12:52:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751825AbZKPRw1
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Nov 2009 12:52:27 -0500
Received: from w241.dkm.cz ([62.24.88.241]:57764 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751777AbZKPRw0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Nov 2009 12:52:26 -0500
Received: by machine.or.cz (Postfix, from userid 2001)
	id 32F2D86201C; Mon, 16 Nov 2009 18:52:29 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4AF472E5.1000602@eaglescrag.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133018>

On Fri, Nov 06, 2009 at 11:03:01AM -0800, J.H. wrote:
> Petr Baudis wrote:
> >On very large sites like repo.or.cz (but maybe also git.debian.org,
> >git.kernel.org, etc.),
> 
> I think between our own caching (which I'll be submitting a cleaned
> up patch for here shortly for mainline inclusion) and our users want
> to *NOT* deal with searching or pagination this actually isn't that
> useful to us, despite having a signifigant number of projects, and
> the front page (at leas for us) only weighing in at 567,710bytes
> means that we are moving less data to show the git.kernel.org page
> than facebook does to show their home screen (I.E. anything modern
> can trivially cope with that)

Sure, you still have much fewer projects than repo.or.cz. :-)
Perhaps others will still find it useful.

> >it is desirable not to have the project list
> >on the front page since generating it is significant overhead and it
> >takes significant data transfer and load time for the user, who might
> >prefer to instead use the search form and possibly content tags to
> >navigate to the target project. A link to the full list of projects is
> >still available on the front page for users who wish to browse it. The
> >whole feature is turned off by default.
> >
> >The patch introduces a new config variable $frontpage_no_project_list,
> >by default 0 keeping the current behavior; if set to 1, no project list
> >will be shown, but all projects will be still scanned if ctags are
> >enabled; if set to 2, no project will be shown and no projects will
> >be scanned while showing the front page. The compromise value of 1 is
> >useful for sites where project scan time is not an issue or which
> >use additional project list caching patches.
> 
> I question the need for 0,1,2.  If the site doesn't want something
> like the tag cloud they are already going to turn it off with the
> normal cloud system.  I think this should be either a bitmask or an
> array to explicitly turn particular things on or off, or a binary
> value that would *ONLY* deal with showing the project listing.

I have no problem with either way, 2 seemed useful so that people can
continue to use ctags but have the front page without any project
scanning whatsoever, but if people think it makes no sense to have it,
I can drop it. I will resend the patch with this being a bitmask
instead, though.

-- 
				Petr "Pasky" Baudis
A lot of people have my books on their bookshelves.
That's the problem, they need to read them. -- Don Knuth
