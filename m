From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Document check option to git diff.
Date: Fri, 26 Jan 2007 19:05:39 -0800
Message-ID: <7vps91p3ss.fsf@assigned-by-dhcp.cox.net>
References: <1169833372823-git-send-email-rael@zopyra.com>
	<7vodoltkqt.fsf@assigned-by-dhcp.cox.net>
	<17850.45971.918929.314082@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Sat Jan 27 04:05:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAdt1-0000Ln-Or
	for gcvg-git@gmane.org; Sat, 27 Jan 2007 04:05:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751884AbXA0DFq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Jan 2007 22:05:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752158AbXA0DFq
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jan 2007 22:05:46 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:38106 "EHLO
	fed1rmmtao07.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751884AbXA0DFp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jan 2007 22:05:45 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070127030540.HIMZ3976.fed1rmmtao07.cox.net@fed1rmimpo01.cox.net>;
          Fri, 26 Jan 2007 22:05:40 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id G34i1W00g1kojtg0000000; Fri, 26 Jan 2007 22:04:43 -0500
In-Reply-To: <17850.45971.918929.314082@lisa.zopyra.com> (Bill Lear's message
	of "Fri, 26 Jan 2007 20:06:11 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37914>

Bill Lear <rael@zopyra.com> writes:

> I believe that an accurate and concise statement would be:
>
>     Warn if changes introduce trailing whitespace
>     or an indent that uses a space before a tab.
>
> I think it should be explicitly limited to "space" and not
> "whitespace" before the tab, as "whitespace" really includes tab.
>
> Do I really need to say "trailing whitespace at the end of the line"?
> That seems overly verbose: trailing whitespace is, I think, understood
> to trail at the end of the line.

All true.  Thanks for rewording.

> Also: I suppose I am wondering about the motivation for this switch.
> It seems to reflect the aesthetics of the git project.  Whitespace at
> the end of a line is meaningless and wasteful, so I understand and
> sympathize with the judgment that this is undesirable.  Spaces
> preceding tabs are somewhat murkier: two tabs, a space, and text pass
> the check, but a tab, space, tab and text do not.  Why is this bad?

The trailing space removal comes from the kernel project
aesthetics:

	http://www.zip.com.au/~akpm/linux/patches/stuff/tpp.txt
	linux-2.6/Documentation/CodingStyle (end of Chapter 1)

"TAB SP TAB blah" visually is the same as "TAB TAB blah".  It is
bad for the same reason as "fofofofo SP TAB EOL" (which is
visually the same as "fofofofo EOL") is bad.  This is not from
the kernel project, so if the above reasoning is flawed, it is
my fault.  I once considered saying 8 spaces are bad and should
be replaced with a tab, but I refrained from going that far ;-).

> I'm sure there is a better way to categorize these violations other
> than "funny".  Should we not say "wasteful and inelegant, and
> therefore anathema to any decent, self-respecting person"?

"Wasteful" is probably better than "funny"; I do not think of a
good wording.

Sometimes we do want to keep the trailing whitespaces (the patch
that came over e-mail to produce commit c7c24889, for example),
so getting warnings from "git-diff --check" (or its counterpart,
"git-apply --whitespace=warn") is not a crime.  But most of the
time, they only waste space and bandwidth and many people who
are conscious about hygiene of their sources seem to avoid them
like the plague.
