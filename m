From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: Rewriting references to existing commits in commit messages with filter-branch
Date: Mon, 11 Mar 2013 14:11:14 +0100
Message-ID: <87y5dut72l.fsf@pctrast.inf.ethz.ch>
References: <E1UF1Ag-0006m3-5k@smtp.tt-solutions.com> <87haki2la2.fsf@gmx.li>
	<loom.20130311T131746-169@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>
To: Vadim Zeitlin <vz-git@zeitlins.org>
X-From: git-owner@vger.kernel.org Mon Mar 11 14:11:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UF2W9-0004UA-Mc
	for gcvg-git-2@plane.gmane.org; Mon, 11 Mar 2013 14:11:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752853Ab3CKNLT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Mar 2013 09:11:19 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:47409 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752063Ab3CKNLS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Mar 2013 09:11:18 -0400
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Mon, 11 Mar
 2013 14:11:12 +0100
Received: from pctrast.inf.ethz.ch.ethz.ch (129.132.153.233) by
 CAS21.d.ethz.ch (172.31.51.111) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Mon, 11 Mar 2013 14:11:15 +0100
In-Reply-To: <loom.20130311T131746-169@post.gmane.org> (Vadim Zeitlin's
	message of "Mon, 11 Mar 2013 12:23:45 +0000 (UTC)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217874>

Vadim Zeitlin <vz-git@zeitlins.org> writes:

> Lawrence Mitchell <wence <at> gmx.li> writes:
>
>> Vadim Zeitlin wrote:
>> 
>> [...]
>> 
>> > git filter-branch --msg-filter svnmsg2git --tag-name-filter cat -- --all
>> 
>> git rev-list lists by default in chronological order.  Do you
>> want to pass --topo-order as one of the rev-list options?
>
>  Thanks, this looked like a good idea but reading git-filter-branch code it
> seems to already do it, at
> https://github.com/git/git/blob/master/git-filter-branch.sh#L269 you can see
> that it does "git rev-list --reverse --topo-order ...".

Try overring that with --date-order (you may have to patch the source).
--topo-order doesn't order by dates.  --date-order does somewhat
(respecting topology), which in the absence of clock skew should do what
you are looking for.

Note that you cannot *remove* --topo-order and use the default, which is
to only respect dates and not topology; that would break filter-branch.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
