From: Petr Baudis <pasky@suse.cz>
Subject: Re: excerpts from tomorrow's "What's cooking" draft
Date: Wed, 11 Nov 2009 22:07:27 +0100
Message-ID: <20091111210727.GN12890@machine.or.cz>
References: <7vbpj9s8vk.fsf@alter.siamese.dyndns.org>
 <20091111184215.GG27518@vidovic>
 <alpine.LFD.2.00.0911111408380.16711@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Junio C Hamano <junio@pobox.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Wed Nov 11 22:07:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8KPg-0005Uh-3n
	for gcvg-git-2@lo.gmane.org; Wed, 11 Nov 2009 22:07:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759222AbZKKVHY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Nov 2009 16:07:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759048AbZKKVHY
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Nov 2009 16:07:24 -0500
Received: from w241.dkm.cz ([62.24.88.241]:56110 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758794AbZKKVHX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Nov 2009 16:07:23 -0500
Received: by machine.or.cz (Postfix, from userid 2001)
	id 1B56986201F; Wed, 11 Nov 2009 22:07:28 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0911111408380.16711@xanadu.home>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132703>

On Wed, Nov 11, 2009 at 02:50:22PM -0500, Nicolas Pitre wrote:
> On Wed, 11 Nov 2009, Nicolas Sebrecht wrote:
> 
> > A bit OT, I've noticed the following output today:
> > 
> >   % git clone git://repo.or.cz/girocco.git
> >   Initialized empty Git repository in /home/nicolas/dev/official_packages/girocco/.git/
> >   remote: Counting objects: 3017, done.
> >   g objects: 100% (994/994), done.
> >   remote: Total 3017 (delta 1911), reused 2988 (delta 1896)
> >   Receiving objects: 100% (3017/3017), 403.99 KiB | 309 KiB/s, done.
> >   Resolving deltas: 100% (1911/1911), done.
> >   %
> > 
> > Notice the "g " at the begining at the 3th line. This is reproducible.
> 
> I get much worse:
> 
> Initialized empty Git repository in /home/nico/git/girocco/.git/
> remote: Counting objects: 3017, done.
> remote: Compressing objects:   5% (50/994)   Receiving objects:   3% (91/3017)
> remote: Compressing objects:  15% (150/994) Receiving objects:   7% (212/3017)
> remote: Compressing oReceiving objects:  14% (423/3017), 76.00 KiB | 135 KiB/s
> remote: Compressing objects:  35Receiving objects:  16% (483/3017), 76.00 KiB |
> remote: Compressing objects:  38% (378/994)Receiving objects:  17% (513/3017), 7
> remote: Compressing objectReceiving objects:  20% (604/3017), 76.00 KiB | 135 Ki
> remote: Compressing objects:  48% (47Receiving objects:  22% (664/3017), 76.00 K
> remote: Compressing objects:  5Receiving objects:  23% (694/3017), 76.00 KiB | 1
> remote: Compressing objects:  Receiving objects:  25% (755/3017), 76.00 KiB | 13
> remote: Compressing objects:  84% (835/99Receiving objects:  26% (785/3017), 76.
> remote: Compressing objeReceiving objects:  33% (996/3017), 76.00 KiB | 135 KiB/
> remote: Compressing objects:  94% (Receiving objects:  36% (1087/3017), 76.00 Ki
> remote: Compressing objects:  97% (965/994)   Receiving objects:  39% (1177/3017
> g objects: 100% (994/994), done.
> remote: Total 3017 (delta 1911), reused 2988 (delta 1896)
> Receiving objects: 100% (3017/3017), 403.99 KiB | 335 KiB/s, done.
> Resolving deltas: 100% (1911/1911), done.
> 
> According to strace, data from sideband channel #2 (prefixed with 
> "remote: ") pertaining to object compression is printed way after pack 
> data has already started to arrive locally.  This is really weird.
> 
> And this occurs only when fetching from repo.or.cz and not from 
> git.kernel.org for example.  So there is something to investigate on the 
> server side.  Pasky: anything you changed in your git installation 
> lately?

Yes, but nothing should have changed in git-daemon, that's the only part
of the infrastructure that uses system-wide git (which it perhaps
shouldn't). I cannot reproduce this problem, though. I have changed
git-daemon to use my local git version (about one week old master), does
this still happen for you?

-- 
				Petr "Pasky" Baudis
A lot of people have my books on their bookshelves.
That's the problem, they need to read them. -- Don Knuth
