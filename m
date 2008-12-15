From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH] modify/delete conflict resolution overwrites untracked
	file
Date: Tue, 16 Dec 2008 00:02:05 +0100
Message-ID: <20081215230205.GA19538@localhost>
References: <20081210201259.GA12928@localhost> <20081215004651.GA16205@localhost> <7v63lm1c76.fsf@gitster.siamese.dyndns.org> <7vmyeyyuuh.fsf@gitster.siamese.dyndns.org> <20081215095949.GA7403@localhost> <7vskopwxej.fsf@gitster.siamese.dyndns.org> <7vej09w0hy.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, johannes.schindelin@gmx.de, raa.lkml@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 16 00:03:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCMT7-0007P2-8Y
	for gcvg-git-2@gmane.org; Tue, 16 Dec 2008 00:03:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752087AbYLOXB7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Dec 2008 18:01:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752176AbYLOXB7
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Dec 2008 18:01:59 -0500
Received: from postman.fh-hagenberg.at ([193.170.124.96]:55756 "EHLO
	mail.fh-hagenberg.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751960AbYLOXB7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Dec 2008 18:01:59 -0500
Received: from darc.dyndns.org ([84.154.98.216]) by mail.fh-hagenberg.at over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 16 Dec 2008 00:01:56 +0100
Received: from drizzd by darc.dyndns.org with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1LCMRx-0005Xt-To; Tue, 16 Dec 2008 00:02:05 +0100
Content-Disposition: inline
In-Reply-To: <7vej09w0hy.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-OriginalArrivalTime: 15 Dec 2008 23:01:57.0263 (UTC) FILETIME=[212BC1F0:01C95F09]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103216>

On Mon, Dec 15, 2008 at 02:13:13PM -0800, Junio C Hamano wrote:
> You can do a merge inside a dirty work tree, and the merge will fail
> without clobbering your work tree files that are dirty when it needs to be
> able to overwrite to do its job.  The set of "dirty files" in this
> sentence of course includes paths that are modified since HEAD, but it
> also includes also paths that do not exist in HEAD (i.e. "new files").
> 
> But we already caution users that you need to know what you are doing when
> working in such a dirty work tree.  Namely, after a failed merge, your
> next "git reset --hard" will blow away your local modifications.  And
> local modifications in this context includes the files you could have
> added to the index but you haven't.

I strongly disagree. With the suggested behavior I would have to
double-check every single untracked file in my tree for conflicts before
trying a throw-away merge followed by git reset --hard, for example. The
file could even be ignored! Whatever happened to git reset doesn't touch
untracked files?

I would even prefer breaking t6023 (until we can properly implement this
feature) in order to avoid that.
