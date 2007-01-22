From: Junio C Hamano <junkio@cox.net>
Subject: Re: Meaning of "fatal: protocol error: bad line length character"?
Date: Mon, 22 Jan 2007 12:15:13 -0800
Message-ID: <7vr6tmstri.fsf@assigned-by-dhcp.cox.net>
References: <17842.1385.366750.915767@lisa.zopyra.com>
	<7vk5zh7b7d.fsf@assigned-by-dhcp.cox.net>
	<7vfya57ast.fsf@assigned-by-dhcp.cox.net>
	<17842.29542.229557.460473@lisa.zopyra.com>
	<7vbqkt78n7.fsf@assigned-by-dhcp.cox.net>
	<7v7ivh77md.fsf@assigned-by-dhcp.cox.net>
	<20070120213738.GA8973@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bill Lear <rael@zopyra.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 22 21:15:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H95ZZ-00071O-IG
	for gcvg-git@gmane.org; Mon, 22 Jan 2007 21:15:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751960AbXAVUPR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 Jan 2007 15:15:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751964AbXAVUPQ
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Jan 2007 15:15:16 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:59469 "EHLO
	fed1rmmtao08.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751960AbXAVUPP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jan 2007 15:15:15 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070122201514.GFTU16632.fed1rmmtao08.cox.net@fed1rmimpo02.cox.net>;
          Mon, 22 Jan 2007 15:15:14 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id ELFX1W00t1kojtg0000000; Mon, 22 Jan 2007 15:15:32 -0500
To: "Shawn O. Pearce" <spearce@spearce.org>
In-Reply-To: <20070120213738.GA8973@spearce.org> (Shawn O. Pearce's message of
	"Sat, 20 Jan 2007 16:37:38 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37443>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Junio C Hamano <junkio@cox.net> wrote:
>> Funny thing is, at least in recent enough git, I think we set up
>> redirection to force output from hook scripts to stderr, but I
>> do not remember when it happened.  Let's see...
>> 
>> 	...goes and looks...
>> 
>> That was supposed to have been fixed with commit cd83c74c (Dec
>> 30, 2006), but this indicates the fix is not working at all when
>> your login shell is tcsh.
>
> Don't tell us tcsh is doing something ugly like opening the tty for
> stdout/stderr instead of using the ones it inherited from its parent.
> 'cause that's just useless!

It turns out that this was a stupidity on the part of the tester
(i.e. me).

I let the distro to install a version of git in /usr/bin/, and
my .cshrc is not set up to add /home/junio/git-active/bin (I
have $HOME/git-{master,next,pu,maint}/bin and git-active is a
symlink to git-master right now -- usually it points at
git-next), for non-interactive session like invoking
receive-pack.  But my bash startup does.  The breakage I was
seeing was _NOT_ because of differences between tcsh and bash,
but because the fix is fairly recent.

I forced the master version of receive-pack to be used on the
remote side using --receive-pack command line parameter, and
things seem to work fine with either tcsh or bash.

So, no, there might be valid reasons to hate tcsh, but this is
not one of them.
