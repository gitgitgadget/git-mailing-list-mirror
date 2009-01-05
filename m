From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git-branch --print-current
Date: Sun, 4 Jan 2009 18:18:32 -0800
Message-ID: <20090105021832.GA20973@spearce.org>
References: <quack.20090101T1928.lthzliaqtdf@roar.cs.berkeley.edu> <402731c90901012026j470f35ffj1eaa189a837054f3@mail.gmail.com> <quack.20090103T1818.lth7i5bg6f7@roar.cs.berkeley.edu> <20090104033839.GD21154@genesis.frugalware.org> <quack.20090103T2026.lth3afzg0hx@roar.cs.berkeley.edu> <7vzli73b1g.fsf@gitster.siamese.dyndns.org> <9b18b3110901040535m1f67cb7er95823d31443ee971@mail.gmail.com> <7v1vvitwio.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: demerphq <demerphq@gmail.com>, Karl Chen <quarl@cs.berkeley.edu>,
	Miklos Vajna <vmiklos@frugalware.org>,
	David Aguilar <davvid@gmail.com>,
	Git mailing list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 05 03:19:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LJf4N-0006tA-FW
	for gcvg-git-2@gmane.org; Mon, 05 Jan 2009 03:19:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751989AbZAECSf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Jan 2009 21:18:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751729AbZAECSf
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Jan 2009 21:18:35 -0500
Received: from george.spearce.org ([209.20.77.23]:41281 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751105AbZAECSe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Jan 2009 21:18:34 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 032A738210; Mon,  5 Jan 2009 02:18:32 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7v1vvitwio.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104556>

Junio C Hamano <gitster@pobox.com> wrote:
> demerphq <demerphq@gmail.com> writes:
> 
> > The version im using, from git version 1.6.0.4.724.ga0d3a produces the
> > following error:
> >
> > cut: ./HEAD: No such file or directory
> >
> > when in the .git/refs directory.
> 
> Personally, I think you are nuts to be in .git/refs and want to use that
> information for anything useful, but if it is an easy enough fix, a patch
> would be useful.

I agree, its nuts to be there.  But this also does show up in 1.6.1.
What's odd is the output of rev-parse --git-dir is wrong:

  $ cd .git/refs
  $ git rev-parse --git-dir
  .

Its *not* ".", its "..", I'm *in* the directory.  This throws off
a lot of the other operations we do in __git_ps1, like detecting
the repository state by checking MERGE_HEAD or rebase-apply.

I think we should fix rev-parse --git-dir if we can, not the bash
completion code.

-- 
Shawn.
