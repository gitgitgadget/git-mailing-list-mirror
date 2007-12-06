From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Git and GCC
Date: Thu, 6 Dec 2007 17:11:48 -0500
Message-ID: <9e4733910712061411y77f800dcx46bb8fdd5d97941f@mail.gmail.com>
References: <4aca3dc20712051947t5fbbb383ua1727c652eb25d7e@mail.gmail.com>
	 <9e4733910712052247x116cabb4q48ebafffb93f7e03@mail.gmail.com>
	 <20071206071503.GA19504@coredump.intra.peff.net>
	 <alpine.LFD.0.99999.0712060915590.555@xanadu.home>
	 <20071206173946.GA10845@sigill.intra.peff.net>
	 <alpine.LFD.0.9999.0712061030560.13796@woody.linux-foundation.org>
	 <9e4733910712061055p353775d8wd0321bc9c81297b7@mail.gmail.com>
	 <alpine.LFD.0.99999.0712061403000.555@xanadu.home>
	 <9e4733910712061339n3aef023r22e5b73aac120c8a@mail.gmail.com>
	 <alpine.LFD.0.99999.0712061645120.555@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	"Jeff King" <peff@peff.net>, "Daniel Berlin" <dberlin@dberlin.org>,
	"Harvey Harrison" <harvey.harrison@gmail.com>,
	"David Miller" <davem@davemloft.net>, ismail@pardus.org.tr,
	gcc@gcc.gnu.org, git@vger.kernel.org
To: "Nicolas Pitre" <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu Dec 06 23:12:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0Ox6-0006vE-CI
	for gcvg-git-2@gmane.org; Thu, 06 Dec 2007 23:12:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752586AbXLFWLu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Dec 2007 17:11:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752701AbXLFWLu
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Dec 2007 17:11:50 -0500
Received: from wa-out-1112.google.com ([209.85.146.178]:6843 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752361AbXLFWLt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Dec 2007 17:11:49 -0500
Received: by wa-out-1112.google.com with SMTP id v27so906308wah
        for <git@vger.kernel.org>; Thu, 06 Dec 2007 14:11:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=rSXanSll/uCNh/PqX1qi3maD9GL8khnM3+j9mI6SvSs=;
        b=qCWcLG/IcfygbYAmOaX5/Ox1RBQ/jgTQI7eOOvc9GE2JsSLWzdA42bMkizIyTi5RX8tI/TUoQF+SL6nNaa6S6q0bkItknuU4MgCzdqmKEpEGTGjZjTAcb/+GW8HRjWpCRhNrg+Z5Sa/4rbYqkOhzIKVNj7yfbw9IWezkQM4MhFE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=l4o2vzCC3cI2KpGzlaxyUIi24yS2AbbnzamHAjnZBnEk2D7lwKRv6s8uUpozCOOtsa6/wbeE3l2bgum5+N9yvxzPJ+Ol6HlMNmCV9JWcMPYw0GWalJxhAqaQvRyTPqGJH0QFFx0pNhPt+OI5WHvyg7WUZiJx67+JRS7rtW2WlAM=
Received: by 10.115.22.1 with SMTP id z1mr2099251wai.1196979109066;
        Thu, 06 Dec 2007 14:11:49 -0800 (PST)
Received: by 10.114.208.17 with HTTP; Thu, 6 Dec 2007 14:11:48 -0800 (PST)
In-Reply-To: <alpine.LFD.0.99999.0712061645120.555@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67346>

On 12/6/07, Nicolas Pitre <nico@cam.org> wrote:
> On Thu, 6 Dec 2007, Jon Smirl wrote:
>
> > On 12/6/07, Nicolas Pitre <nico@cam.org> wrote:
> > > > When I lasted looked at the code, the problem was in evenly dividing
> > > > the work. I was using a four core machine and most of the time one
> > > > core would end up with 3-5x the work of the lightest loaded core.
> > > > Setting pack.threads up to 20 fixed the problem. With a high number of
> > > > threads I was able to get a 4hr pack to finished in something like
> > > > 1:15.
> > >
> > > But as far as I know you didn't try my latest incarnation which has been
> > > available in Git's master branch for a few months already.
> >
> > I've deleted all my giant packs. Using the kernel pack:
> > 4GB Q6600
> >
> > Using the current thread pack code I get these results.
> >
> > The interesting case is the last one. I set it to 15 threads and
> > monitored with 'top'.
> > For 0-60% compression I was at 300% CPU, 60-74% was 200% CPU and
> > 74-100% was 100% CPU. It never used all for cores. The only other
> > things running were top and my desktop. This is the same load
> > balancing problem I observed earlier.
>
> Well, that's possible with a window 25 times larger than the default.
>
> The load balancing is solved with a master thread serving relatively
> small object list segments to any work thread that finished with its
> previous segment.  But the size for those segments is currently fixed to
> window * 1000 which is way too large when window == 250.
>
> I have to find a way to auto-tune that segment size somehow.

That would be nice. Threading is most important on the giant
pack/window combinations. The normal case is fast enough that I don't
real notice it. These giant pack/window combos can run 8-10 hours.

>
> But with the default window size there should not be any such noticeable
> load balancing problem.

I only spend 30 seconds in the compression phase without making the
window larger. It's not long enough to really see what is going on.

>
> Note that threading only happens in the compression phase.  The count
> and write phase are hardly paralleled.
>
>
> Nicolas
>


-- 
Jon Smirl
jonsmirl@gmail.com
