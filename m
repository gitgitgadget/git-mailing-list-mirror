From: Petr Baudis <pasky@suse.cz>
Subject: Re: What's cooking in git.git (topics)
Date: Tue, 1 Jul 2008 00:53:44 +0200
Message-ID: <20080630225344.GB12564@machine.or.cz>
References: <7vod6k6zg4.fsf@gitster.siamese.dyndns.org> <7v4p7xwsfp.fsf@gitster.siamese.dyndns.org> <7v3anb19n7.fsf@gitster.siamese.dyndns.org> <7vwskjazql.fsf@gitster.siamese.dyndns.org> <7vk5ggipuw.fsf@gitster.siamese.dyndns.org> <7vej6l3lp7.fsf@gitster.siamese.dyndns.org> <7vod5kd3im.fsf@gitster.siamese.dyndns.org> <7v3amv1e8n.fsf@gitster.siamese.dyndns.org> <1214834970.3382.4.camel@gaara.bos.redhat.com> <7vabh2vaav.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kristian H??gsberg <krh@redhat.com>, git@vger.kernel.org,
	akpm@linux-foundation.org, Stephen Rothwell <sfr@canb.auug.org.au>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 01 00:55:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDSGv-0007sN-G5
	for gcvg-git-2@gmane.org; Tue, 01 Jul 2008 00:54:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763569AbYF3Wxu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jun 2008 18:53:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753634AbYF3Wxu
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jun 2008 18:53:50 -0400
Received: from w241.dkm.cz ([62.24.88.241]:46220 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763569AbYF3Wxt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2008 18:53:49 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 006F82C4C03C; Tue,  1 Jul 2008 00:53:44 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vabh2vaav.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86959>

On Mon, Jun 30, 2008 at 03:15:52PM -0700, Junio C Hamano wrote:
> I do not recall if Cogito required to have .git/branches created by us or
> it can create it on demand if we don't.  If the latter, that would be
> great, otherwise remaining users would be in the latter camp as well, and
> we may have to make sure Cogito is really dead already (or wait for it to
> die), or Cogito gets updated for its remaining users to tolerate the
> initial lack of the directory (and wait for that version percolates down
> to the users).

Cogito is getting somewhat broken by removing of the git- plumbing from
$PATH anyway (you have to hack around it; and I'm not saying it's bad
thing).

But it is actually quite resilient against this kind of stuff (as it was
constructed to be able to run on very rudimental repositories dating
early to the dawn of time). All versions supporting .git/branches [*] will
autocreate the .git/branches directory if missing.

[*] .git/branches was actually called .git/remotes even earlier; yay,
how rich our history is. ;-)

> Some people rely on (or at least "like") the convenience of being able to
> create a single-liner file in .git/branches/ to easily add, and remove
> such a file to easily remove where they integrate from.  This is
> especially so when they have dozens of source repositories to fetch from.
> I do not think we want to remove support for .git/branches as a way to
> specify fetch sources (this is why I am CC'ing Andrew who I know uses
> branches, and Stephen who is also a heavy integrator even though I do not
> know if he is in branches camp or uses more modern style), but they now
> have to do an extra "mkdir .git/branches" after "git init" to continue
> their workflow if we adopt the change you are proposing here.  It is not a
> big deal, but it still is a backward incompatible change.

Now, I think it would be nice to keep backward compatibility here. I'm
still _regularly_ running into people who still use Cogito (and it's not
because they know me :-)) and are only now doing the switch, or only
planning to yet.

(On the other hand, using Git on repositories created by old Git
versions or Cogito can be quite a confusing experience for non-expert
users - things related to remote repositories behave differently to what
the documentation describes, obviously.  Maybe it _would_ be reasonable
option to do something radical when hitting old repository, like
"(Re-)clone me for non-confusing user experience, pretty please, or
git-config force_old_repo 1 if you know what are you doing.")

-- 
				Petr "Pasky" Baudis
The last good thing written in C++ was the Pachelbel Canon. -- J. Olson
