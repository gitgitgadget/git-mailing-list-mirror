From: Petr Baudis <pasky@suse.cz>
Subject: Re: Merging commits together into a super-commit
Date: Thu, 10 May 2007 21:21:06 +0200
Message-ID: <20070510192106.GB4489@pasky.or.cz>
References: <1178794261.5806.98.camel@murta.transitives.com> <4643049C.3D5F30D8@eudaptics.com> <alpine.LFD.0.98.0705100857450.3986@woody.linux-foundation.org> <87wszg39cp.wl%cworth@cworth.org> <20070510171457.GK13719@fieldses.org> <87vef0350y.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "J. Bruce Fields" <bfields@fieldses.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Sixt <J.Sixt@eudaptics.com>, git@vger.kernel.org
To: Carl Worth <cworth@cworth.org>
X-From: git-owner@vger.kernel.org Thu May 10 21:21:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmECT-0002xP-GP
	for gcvg-git@gmane.org; Thu, 10 May 2007 21:21:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756145AbXEJTVL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 May 2007 15:21:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755894AbXEJTVK
	(ORCPT <rfc822;git-outgoing>); Thu, 10 May 2007 15:21:10 -0400
Received: from w241.dkm.cz ([62.24.88.241]:57619 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755528AbXEJTVJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2007 15:21:09 -0400
Received: (qmail 19509 invoked by uid 2001); 10 May 2007 21:21:06 +0200
Content-Disposition: inline
In-Reply-To: <87vef0350y.wl%cworth@cworth.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46886>

On Thu, May 10, 2007 at 08:30:37PM CEST, Carl Worth wrote:
> stg - This probably works great if you're using it as a primary
>       interface. But trying to use it as a quick one-off when
>       generally using core git does not work well at all. Instead of
>       the two "git tag" commands in my recipe above, an stg recipe
>       would involve a lot of additional bookkeeping with stg init, stg
>       uncommit [N times for fixing a commit N steps back in the
>       history], stg goto, stg push, etc.

I think you are underestimating stg here. You can stg init just once per
branch (ever), I think. Then,

	stg uncommit -n N
	stg pop -n N-1
	..hack..
	stg refresh
	stg push -a

It seems to be a bit shorter than the sequence you've presented above,
and overally working with volatile commits using StGIT feels much more
natural to me - and I haven't even ever used quilt seriously! (I have
special antipathy to the git reset UI, too.)

Few days ago Santi Bejar has sent me a bundle with some updates to the
Git homepage (thanks again a lot!). Since I didn't want some of the
patches and wanted to tweak others, what I eventually did was pretty
much this: I fast-forwarded my master to his bundle's head, then
uncommitted the patches, popped them all and repeated the sequence

	stg push
	..review..
		stg refresh
		stg commit
	..or..
		stg delete `stg top`

for each patch.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Ever try. Ever fail. No matter. // Try again. Fail again. Fail better.
		-- Samuel Beckett
