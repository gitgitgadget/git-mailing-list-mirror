From: Junio C Hamano <junkio@cox.net>
Subject: Re: git on HP-UX
Date: Thu, 06 Jul 2006 17:20:41 -0700
Message-ID: <7vfyhe465i.fsf@assigned-by-dhcp.cox.net>
References: <200607060950.34558.michal.rokos@nextsoft.cz>
	<1152197629.7720.10.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 07 02:20:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fye5O-0000YZ-70
	for gcvg-git@gmane.org; Fri, 07 Jul 2006 02:20:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751103AbWGGAUn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Jul 2006 20:20:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751104AbWGGAUn
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Jul 2006 20:20:43 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:65245 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1751103AbWGGAUm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jul 2006 20:20:42 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060707002041.TSBM6235.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 6 Jul 2006 20:20:41 -0400
To: Pavel Roskin <proski@gnu.org>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23411>

Pavel Roskin <proski@gnu.org> writes:

>> I needed following changes in order to make git compile on HP-UX:
>> +ifeq ($(uname_S),HP-UX)
>> +	NO_IPV6 = YesPlease
>> +	NO_CURL = YesPlease
>
> Is there any fundamental problem with curl and IPv6 on HP-UX?  I don't
> think so.
>
> Sorry for using your path as a bad example, but the appearance of such
> patches is a perfect argument for a real configure script.  If we
> continue patching Makefile, we'll drown in such conditionals.

Conditionals like 'ifdef NO_IPV6' in Makefile are good, but
conditionals switch on platforms to set/reset them are not.
A configure script to set them in config.mak.gen is the way to
go, I would agree.

> I hope the Autoconf based configure is on its way to git, but I don't
> see in in the "pu" branch yet.  I'm not very keen about reinventing
> Autoconf and hacking a hand-made configure script.

OK, you half-convinced me.  The other half came from a recent
series of patches to try using 'which' to detect executables,
which is another common mistake handcrafted configure script
makes, which autoconf people have solved for us long time ago.
