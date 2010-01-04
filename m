From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] grep: do not do external grep on skip-worktree entries
Date: Mon, 4 Jan 2010 00:31:25 -0500
Message-ID: <20100104053125.GA5083@coredump.intra.peff.net>
References: <7vzl4zy5z3.fsf@alter.siamese.dyndns.org>
 <20100102115041.GA32381@do>
 <7vtyv4cpna.fsf@alter.siamese.dyndns.org>
 <fcaeb9bf1001021115j7b23264n42cfba7855c2253e@mail.gmail.com>
 <7v7hs09tpi.fsf@alter.siamese.dyndns.org>
 <87ljgfgbl0.fsf@catnip.gol.com>
 <fc339e4a1001021847hf1e1a7fq894de7908839ff77@mail.gmail.com>
 <877hrzga16.fsf@catnip.gol.com>
 <alpine.LFD.2.00.1001031124420.3630@localhost.localdomain>
 <7v3a2mzzg4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Miles Bader <miles@gnu.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 04 06:31:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NRfXR-0007cy-JA
	for gcvg-git-2@lo.gmane.org; Mon, 04 Jan 2010 06:31:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753025Ab0ADFba (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jan 2010 00:31:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752954Ab0ADFb3
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jan 2010 00:31:29 -0500
Received: from peff.net ([208.65.91.99]:59054 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752923Ab0ADFb3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jan 2010 00:31:29 -0500
Received: (qmail 12433 invoked by uid 107); 4 Jan 2010 05:36:13 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 04 Jan 2010 00:36:13 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 04 Jan 2010 00:31:25 -0500
Content-Disposition: inline
In-Reply-To: <7v3a2mzzg4.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136092>

On Sun, Jan 03, 2010 at 12:49:15PM -0800, Junio C Hamano wrote:

> Linus Torvalds <torvalds@linux-foundation.org> writes:
> 
> > Which means that if you put /usr/xpg4/bin before other paths in your PATH, 
> > you'll totally break such systems, because now you get the (inferior) 
> > tools in xpg4 before the preferred tools in /usr/local. Or - this also 
> > happens - people end up installing their own versions in $HOME/bin, 
> > because the system admin is uncaring or incompetent.
> 
> The build allows you to define SANE_TOOL_PATH ("the tools found in here
> are saner than the ones in /usr/bin or /bin" is what it means) and we
> insert it just in front of /usr/bin or /bin in the original PATH (see
> git_brokne_path_fix in git-sh-setup.sh).
> 
> I would call this the right thing (TM) or the best workaround we could do
> under the constraints, depending on the mood.

I agree that Solaris default tools are insane, but is there any reason
to munge the PATH for a single feature like external grep? Why not
EXTERNAL_GREP=/usr/xpg4/bin/grep (or /usr/local/bin/grep) in the
Makefile? Why not GIT_EXTERNAL_GREP=$HOME/bin/grep in the environment?

Obviously we still need SANE_TOOL_PATH for systems where the /usr/bin is
so crappy as to be unusable for our scripts. But surely we can do better
for individual tools where the user might have some more specific
preference about which tool he uses.

-Peff
