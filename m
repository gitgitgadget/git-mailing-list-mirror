From: Petr Baudis <pasky@suse.cz>
Subject: Re: Closing the merge window for 1.6.0
Date: Tue, 15 Jul 2008 19:28:21 +0200
Message-ID: <20080715172821.GL32184@machine.or.cz>
References: <7vzlokhpk7.fsf@gitster.siamese.dyndns.org> <20080714085555.GJ32184@machine.or.cz> <alpine.DEB.1.00.0807141256310.8950@racer> <20080714124109.25414.qmail@06d015ec9c6744.315fe32.mid.smarden.org> <alpine.LFD.1.10.0807141351540.12484@xanadu.home> <7v3amcgujd.fsf@gitster.siamese.dyndns.org> <20080715092023.GO10151@machine.or.cz> <20080715150626.GA2925@dpotapov.dyndns.org> <alpine.DEB.1.00.0807151623120.8950@racer> <alpine.LFD.1.10.0807151213000.12484@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Gerrit Pape <pape@smarden.org>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Jul 15 19:29:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIoLD-0003vM-MR
	for gcvg-git-2@gmane.org; Tue, 15 Jul 2008 19:29:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761957AbYGOR2Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2008 13:28:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761946AbYGOR2Z
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jul 2008 13:28:25 -0400
Received: from w241.dkm.cz ([62.24.88.241]:53076 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761940AbYGOR2Y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2008 13:28:24 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id B0EC41E4C022; Tue, 15 Jul 2008 19:28:21 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0807151213000.12484@xanadu.home>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88583>

On Tue, Jul 15, 2008 at 12:26:48PM -0400, Nicolas Pitre wrote:
> Anyway this is all hand waving until someone can come with some evidence 
> that git 1.4.4 is actually used by a significant amount of people, and 
> that those people depend on dumb transfer protocols.

That will be hard to produce. :-) _My_ personal story is that I have
Git-1.4.4.4 installed system-wide on repo.or.cz and follow git#next
locally, and quite panicked when I was inspecting some repositories
as root (using the system-wide Git) and these error messages popped up.
This may become a similar experience for others on multi-user systems
where people want to share work but don't realize that one of them has
Git installed locally and the other one doesn't. We can save them the
head-slapping and a bit of wasted life.

Out of interest, I did a simple statistics of HTTP user agents on
repo.or.cz; the dumb access does not seem very widely used overally,
it turns out. The stats begin at 19/May/2008:10:54:32 +0200. Here is the
breakdown, counting unique clients only:

# zgrep '"GET /r/.*/info/packs' /var/log/apache2/repo-access.log* | egrep -v bot\|slurp\|Gecko\|Opera |
	cut -d " " -f 1,12- | sed 's/\.g[a-f0-9]*\(\.dirty\)*"/"/' | sort -u |
	cut -d ' ' -f 2 | sort | uniq -c | sort -rn | head -n 50
   1501 "git/1.5.4.3"	<- Ubuntu Hardy (heh.. is just that it?)
    278 "git/1.5.5.1"	<- RHEL5 (ditto)
    151 "git/1.5.2.5"	<- Ubuntu Gutsy
    133 "git/1.5.5.3"	<- ? (maybe Gentoo ~x86 for some time)
    125 "git/1.5.4.5"	<- OpenSUSE 11.0, FC9, Gentoo x86, Dapper backports
    104 "git/1.5.6"	<- Debian Lenny
     94 "git/1.5.5"
     66 "git/1.5.3.7"
     63 "git/1.5.5.4"
     63 "git/1.5.5.1015"
     55 "git/1.5.2.4"	<- OpenSUSE 10.3
     51 "Mozilla/4.0 (compatible;)"	<- huh?
     42 "git/1.5.3.8"
     37 "git/1.5.5.GIT"
     37 "git/1.5.3.5.2229"
     34 "git/1.5.6.1"
     33 "git/1.5.3.6"	<- Feisty backports
     31 "git/1.5.4.1"
     30 "git/1.5.6.2"
     20 "git/1.5.6.GIT"
     18 "git/1.5.3"
     17 "git/1.5.2.2"
     17 "git/1.4.4.4"
     15 "git/1.5.6.1.1071"
     14 "git/1.5.3.3"
     13 "git/1.5.4.4"
     13 "git/1.5.4"
     11 "git/1.5.6.1062"
     11 "git/1.5.5.2"
     10 "git/1.5.5.1.316"

(I also got two 1.4.4.2 (feisty?) fetches from one client. No older
Git versions.)

So wrt. keeping backwards compatibility, this is not _very_ convincing,
I admit. ;-)

-- 
				Petr "Pasky" Baudis
GNU, n. An animal of South Africa, which in its domesticated state
resembles a horse, a buffalo and a stag. In its wild condition it is
something like a thunderbolt, an earthquake and a cyclone. -- A. Pierce
