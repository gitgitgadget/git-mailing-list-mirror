From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH (v2) 2/2] rebase -i: teach --onto A...B syntax
Date: Thu, 7 Jan 2010 22:10:55 +0100
Message-ID: <201001072210.55727.j6t@kdbg.org>
References: <7vljgei7rs.fsf@alter.siamese.dyndns.org> <20100107200509.6117@nanako3.lavabit.com> <7vtyux3bx1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Cc: Nanako Shiraishi <nanako3@lavabit.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 07 22:11:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSze3-0000hc-Vf
	for gcvg-git-2@lo.gmane.org; Thu, 07 Jan 2010 22:11:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754043Ab0AGVLs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jan 2010 16:11:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753611Ab0AGVLs
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jan 2010 16:11:48 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:29578 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753535Ab0AGVLr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jan 2010 16:11:47 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id B19782C400C;
	Thu,  7 Jan 2010 22:11:43 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id CE4CD19F610;
	Thu,  7 Jan 2010 22:10:55 +0100 (CET)
User-Agent: KMail/1.9.10
In-Reply-To: <7vtyux3bx1.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136386>

On Donnerstag, 7. Januar 2010, Junio C Hamano wrote:
> I was tempted to suggest having a common helper function, 
> but as Dscho mentioned "rebase -i" implementation does not share much with
> "rebase" (even though it shares the external command line interface from
> the end user's point of view), and I don't see a readily available place
> (other than in git-sh-setup) to do so.
>
> Ideas?

1. Split git-rebase--merge.sh and git-rebase--am.sh backends off of 
git-rebase.sh. Have git-rebase.sh dispatch to 
git-rebase--{am,merge,interactive}.sh as appropriate.

2. Unify command line parsing from git-rebase--*.sh in git-rebase.sh. The 
git-rebase--*.sh can now simply refer to shell variables that were set by 
command line switches (the backends must be invoked using the . (dot) 
command).

3. Place common functionality like the one above in git-rebase.sh.

-- Hannes
