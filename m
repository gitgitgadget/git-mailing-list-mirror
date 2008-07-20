From: Petr Baudis <pasky@suse.cz>
Subject: Re: [RFC variant 2 of 2] "needs update" considered harmful
Date: Sun, 20 Jul 2008 13:29:57 +0200
Message-ID: <20080720112957.GE32184@machine.or.cz>
References: <7vtzelf4mf.fsf@gitster.siamese.dyndns.org> <7v7ibhdmii.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 20 13:31:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKX86-0002xw-E3
	for gcvg-git-2@gmane.org; Sun, 20 Jul 2008 13:31:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756141AbYGTLaA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jul 2008 07:30:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755863AbYGTLaA
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jul 2008 07:30:00 -0400
Received: from w241.dkm.cz ([62.24.88.241]:38642 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754556AbYGTLaA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jul 2008 07:30:00 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 912AC393B31D; Sun, 20 Jul 2008 13:29:57 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7v7ibhdmii.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89185>

On Sun, Jul 20, 2008 at 12:48:21AM -0700, Junio C Hamano wrote:
> "git update-index --refresh", "git reset" and "git add --refresh" have
> reported paths that have local modifications as "needs update" since the
> beginning of git.
> 
> Although this is logically correct in that you need to update the index at
> that path before you can commit that change, it is now becoming more and
> more clear, especially with the continuous push for user friendliness
> since 1.5.0 series, that the message is suboptimal.  After all, the change
> may be something the user might want to get rid of, and "updating" would
> be absolutely a wrong thing to do if that is the case.
> 
> I prepared two alternatives to solve this.  Both aim to reword the message
> to more neutral "locally modified".
> 
> This patch is a more straightforward variant that changes the message not
> only for Porcelain commands ("add" and "reset") but also changes the
> output from the plumbing command "update-index".
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

I believe this is a good thing. Scripts need to be modified for the
reorganization anyway, and I'm not sure if there are any actually
depening on this particular string. I think having inconsistent error
messaging is worse in long term.

FWIW, looking at Cogito,

	cg-Xlib: git-update-index --refresh | sed 's/needs update$/locally modified/'

is the only reference to this. ;-)

-- 
				Petr "Pasky" Baudis
As in certain cults it is possible to kill a process if you know
its true name.  -- Ken Thompson and Dennis M. Ritchie
