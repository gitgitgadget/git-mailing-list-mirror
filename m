From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH 0/3] merge -Xindex-only
Date: Tue, 9 Jul 2013 14:08:21 +0200
Message-ID: <878v1gey16.fsf@linux-k42r.v.cablecom.net>
References: <cover.1373219466.git.trast@inf.ethz.ch>
	<51DAD8F2.5070008@alum.mit.edu>
	<87k3l1gip1.fsf@linux-k42r.v.cablecom.net>
	<51DBDB6F.7090105@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git discussion list <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Jul 09 14:08:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UwWia-0008FS-7M
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jul 2013 14:08:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753465Ab3GIMIY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jul 2013 08:08:24 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:45643 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752553Ab3GIMIX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jul 2013 08:08:23 -0400
Received: from CAS22.d.ethz.ch (172.31.51.112) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 9 Jul
 2013 14:08:18 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (129.132.153.233) by
 CAS22.d.ethz.ch (172.31.51.112) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Tue, 9 Jul 2013 14:08:21 +0200
In-Reply-To: <51DBDB6F.7090105@alum.mit.edu> (Michael Haggerty's message of
	"Tue, 09 Jul 2013 11:44:15 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229950>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Since you've already implemented a way to merge into the index (even an
> alternative index) without touching the working copy, I'll just cross my
> fingers and hope for the appearance of an option that makes merge leave
> HEAD, MERGE_HEAD, etc. untouched.

The most annoying part is probably where to put the output, since
merging is more or less defined to do one of:

- update HEAD and return 0
- update MERGE_HEAD and return 1

I'm not sure how much flexibility is worth having.  Would it be
sufficient if you had an option, e.g. -Xresult-ref=refs/heads/foo, that
changes it to:

- update refs/heads/foo and return 0
- return 1, not updating any refs

That would mean that it would only work for noninteractive use.  In the
conflicting case, the driving script would need to remember what it
wanted to merge so as have the information when finally committing.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
