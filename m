From: "Matthew D. Fuller" <fullermd@over-yonder.net>
Subject: Re: VCS comparison table
Date: Thu, 19 Oct 2006 12:06:38 -0500
Message-ID: <20061019170638.GB75501@over-yonder.net>
References: <45357411.20500@utoronto.ca> <200610180246.18758.jnareb@gmail.com>
	<45357CC3.4040507@utoronto.ca> <871wp6e7o9.wl%cworth@cworth.org>
	<45359B2A.1070102@utoronto.ca> <87y7rdd47j.wl%cworth@cworth.org>
	<20061019091045.GV75501@over-yonder.net>
	<20061019112759.GA31066@diana.vm.bytemark.co.uk>
	<20061019114639.GD20017@pasky.or.cz>
	<20061019160103.GZ75501@over-yonder.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: bazaar-ng@lists.canonical.com,
	Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Carl Worth <cworth@cworth.org>, Andreas Ericsson <ae@op5.se>,
	git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
X-From: bazaar-ng-bounces@lists.canonical.com Thu Oct 19 19:07:17 2006
Return-path: <bazaar-ng-bounces@lists.canonical.com>
Envelope-to: gcvbg-bazaar-ng@m.gmane.org
Received: from esperanza.ubuntu.com ([82.211.81.173])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GabM5-0007J6-Uc
	for gcvbg-bazaar-ng@m.gmane.org; Thu, 19 Oct 2006 19:06:54 +0200
Received: from localhost ([127.0.0.1] helo=esperanza.ubuntu.com)
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <bazaar-ng-bounces@lists.canonical.com>)
	id 1GabM0-000627-N0; Thu, 19 Oct 2006 18:06:48 +0100
Received: from ns.centralmiss.com ([206.156.254.79]
	helo=optimus.centralmiss.com)
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <fullermd@over-yonder.net>) id 1GabLw-00061t-KN
	for bazaar-ng@lists.canonical.com; Thu, 19 Oct 2006 18:06:44 +0100
Received: from draco.over-yonder.net
	(adsl-072-148-013-213.sip.jan.bellsouth.net [72.148.13.213])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by optimus.centralmiss.com (Postfix) with ESMTP id 76AE22842A;
	Thu, 19 Oct 2006 12:06:39 -0500 (CDT)
Received: by draco.over-yonder.net (Postfix, from userid 100)
	id 72A7061C52; Thu, 19 Oct 2006 12:06:38 -0500 (CDT)
To: Petr Baudis <pasky@suse.cz>
Content-Disposition: inline
In-Reply-To: <20061019160103.GZ75501@over-yonder.net>
X-Editor: vi
X-OS: FreeBSD <http://www.freebsd.org/>
User-Agent: Mutt/1.5.11-fullermd.3
X-BeenThere: bazaar-ng@lists.canonical.com
X-Mailman-Version: 2.1.8
Precedence: list
List-Id: bazaar-ng discussion <bazaar-ng.lists.canonical.com>
List-Unsubscribe: <https://lists.ubuntu.com/mailman/listinfo/bazaar-ng>,
	<mailto:bazaar-ng-request@lists.canonical.com?subject=unsubscribe>
List-Archive: <https://lists.ubuntu.com/archives/bazaar-ng>
List-Post: <mailto:bazaar-ng@lists.canonical.com>
List-Help: <mailto:bazaar-ng-request@lists.canonical.com?subject=help>
List-Subscribe: <https://lists.ubuntu.com/mailman/listinfo/bazaar-ng>,
	<mailto:bazaar-ng-request@lists.canonical.com?subject=subscribe>
Sender: bazaar-ng-bounces@lists.canonical.com
Errors-To: bazaar-ng-bounces@lists.canonical.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29374>

On Thu, Oct 19, 2006 at 11:01:03AM -0500 I heard the voice of
Matthew D. Fuller, and lo! it spake thus:
>
> Now, the question of "is that merge commit E really necessary, when
> you could just attach D to the end of the graph and create something
> like [...] is perhaps a useful question (and one that there's
> obviously disagreement on).  And it may be a fruitful one to
> discuss, if we're not way off in the weeds already.
>
> But, it's also not QUITE the same question as "Is the left-vs-other
> path distinction meaningful and to be preserved?"

Let me elaborate a little on this.

bzr COULD create

>   a-.
>   |\ \
>   b c |
>   |/ /
>   D-'

instead of

>   a-.
>   |\ \
>   b c |
>   |\|/
>   | D
>   |/ 
>   E

for the previously discussed merge, basically duplicating
'fast-forward' behavior.  It doesn't currently, but it could just as
well without disturbing the attributes it gains from assigning meaning
to the left-most parent.  The choice to create E is the result of an
independent decision from the choice to treat the left path as
special.


What the leftmost discussion impacts is the case of 

    a-.
    |\ \
    | b c
    |/ /
    D-'

vs

    a-.-.
     \ \ \
      b c |
     / / /
    D-'-'

Now, the branches are distinct to bzr, but they're not different.  If
you try to merge one from the other, merge will quite rightly tell you
there's nothing to do, since you both have all the same revs.  git
doesn't recognize the distinction at all, of course.  The difference
is mostly cosmetic.  But, it's a cosmetic difference that bzr devs
(and users, I venture) find _useful_, which is why it's fought for.
And everything else seems to follow from that.

If you don't think the distinction is meaningful or useful, you can
ignore it, and the tool should work just fine.  The main place the
distinction would show up is in the cosmetics of how "log" looks (and
probably similarly in any tool that graphically describes ancestry),
and a custom log output formatter could probably be very easily
written to obviate even that.
