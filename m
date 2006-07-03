From: Junio C Hamano <junkio@cox.net>
Subject: Re: Quick merge status updates.
Date: Sun, 02 Jul 2006 17:06:01 -0700
Message-ID: <7v1wt31riu.fsf@assigned-by-dhcp.cox.net>
References: <7vodwe5dr8.fsf@assigned-by-dhcp.cox.net>
	<1151471040.4940.17.camel@dv>
	<7v7j3164xd.fsf@assigned-by-dhcp.cox.net>
	<1151489103.28036.6.camel@dv> <20060702204906.GG29115@pasky.or.cz>
	<7v64if3d50.fsf@assigned-by-dhcp.cox.net>
	<20060702214931.GJ29115@pasky.or.cz>
	<7vveqf1v05.fsf@assigned-by-dhcp.cox.net>
	<7vejx31sav.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0607021655440.12404@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 03 02:06:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FxBx3-0002yr-5t
	for gcvg-git@gmane.org; Mon, 03 Jul 2006 02:06:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750807AbWGCAGF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Jul 2006 20:06:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750808AbWGCAGF
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Jul 2006 20:06:05 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:16573 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1750807AbWGCAGD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Jul 2006 20:06:03 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060703000602.MYUF22974.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 2 Jul 2006 20:06:02 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0607021655440.12404@g5.osdl.org> (Linus Torvalds's
	message of "Sun, 2 Jul 2006 17:00:40 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23141>

Linus Torvalds <torvalds@osdl.org> writes:

> On Sun, 2 Jul 2006, Junio C Hamano wrote:
>> Yuck; that means we would need to have something evil like this.
>
> That's just disgusting.
>
> How about a _much_ simpler approach.
>
> Just make it do
>
> 	BEGIN { push ENV{'GIT_PERL_EXEC_DIR'}; }
>
> And then simply _require_ that the setup code sets up GIT_PERL_EXEC_DIR.

No, we are not mucking with /usr/bin but are talking about a
directory for platform specific Perl libraries, which we need to
ask Perl at build-time.

And the standard way to say that is to do:

	use lib '@@INSTLIBDIR@@';

but that always prepends the directory to the search path, and
the ugly stuff is to allow test scripts to override it when
needed.
