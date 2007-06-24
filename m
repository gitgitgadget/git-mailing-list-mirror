From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH][RESEND] Escape some tilde characters causing spurious subscripts in documentation
Date: Sun, 24 Jun 2007 03:07:20 -0700
Message-ID: <7vbqf5wtrb.fsf@assigned-by-dhcp.cox.net>
References: <11826426733115-git-send-email-jasonsewall@gmail.com>
	<Pine.LNX.4.64.0706240109540.4059@racer.site>
	<31e9dd080706231722v760b5a0cnc31e24b83deafb90@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Jason Sewall" <jasonsewall@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 24 12:07:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2P08-0001Xv-6P
	for gcvg-git@gmane.org; Sun, 24 Jun 2007 12:07:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753828AbXFXKHX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Jun 2007 06:07:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753086AbXFXKHX
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Jun 2007 06:07:23 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:50031 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752643AbXFXKHW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jun 2007 06:07:22 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070624100721.BGUO3993.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Sun, 24 Jun 2007 06:07:21 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id FN7L1X0031kojtg0000000; Sun, 24 Jun 2007 06:07:21 -0400
In-Reply-To: <31e9dd080706231722v760b5a0cnc31e24b83deafb90@mail.gmail.com>
	(Jason Sewall's message of "Sat, 23 Jun 2007 17:22:00 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50785>

"Jason Sewall" <jasonsewall@gmail.com> writes:

> On 6/23/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>
>> I just checked with my copy of asciidoc, though, and there is no mangling
>> going on, at least in git-bundle.html (which is the only file I checked).
>> My asciidoc is version 8.2.1. What is yours?
>
> I've got 8.1.0; perhaps that's the problem. I wasn't so surprised to
> hear the asciidoc 7 and 8 don't get along, but I'm surprised to see
> that 8.1 and 8.2 are so different.
>
> Anyway, 8.1.0 is apparently what's in Fedora 7 (the distro I'm using
> right now) so it might be worth hanging on to the patch.

FWIW, 7.1.2, 8.2.1 and 7.0.2 all seem to be Ok (the last one is
used to format the pages in html and man branches of git.git).
It is a bit annoying having to use name\~num at some places and
no backslash all others.

Two requests:

 - Documentation/git-rev-parse.txt has '{tilde}<n>'.  If you
   replace that {tilde} with a "~", how does your AsciiDoc
   format it?  Do you see the same breakage?

 - If it breaks, does it fix the breakage if you prefix the "~"
   with a backslash, instead of using {tilde}?

If the answer to both questions are "yes", then perhaps we
should get rid of the {tilde} macro we define in 
Documentation/asciidoc.conf file, and use your "\~" solution
everywhere.

Also do you see any pattern?  It does not seem that all the
"master~3" are broken for you but only some.  If your commit
message can describe when quoting is needed, that would help
people who would modify the documentation in the future.
