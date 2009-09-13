From: Nelson Elhage <nelhage@MIT.EDU>
Subject: Re: [PATCH] git-push: Accept -n as a synonym for --dry-run.
Date: Sat, 12 Sep 2009 23:40:31 -0400
Message-ID: <20090913034031.GO4275@mit.edu>
References: <1252800302-26560-1-git-send-email-nelhage@mit.edu> <7vfxar5zsi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 13 05:40:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmfxA-0007Qe-Sc
	for gcvg-git-2@lo.gmane.org; Sun, 13 Sep 2009 05:40:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754953AbZIMDkd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Sep 2009 23:40:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754921AbZIMDkc
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Sep 2009 23:40:32 -0400
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:59945 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754852AbZIMDkb (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 Sep 2009 23:40:31 -0400
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id n8D3eWts024998;
	Sat, 12 Sep 2009 23:40:32 -0400 (EDT)
Received: from LUNATIQUE.MIT.EDU (LUNATIQUE.MIT.EDU [18.208.0.153])
	(authenticated bits=0)
        (User authenticated as nelhage@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id n8D3eVRR013800
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Sat, 12 Sep 2009 23:40:32 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7vfxar5zsi.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128330>

On Sat, Sep 12, 2009 at 07:44:29PM -0700, Junio C Hamano wrote:
> Sign-off?

Signed-off-by: Nelson Elhage <nelhage@mit.edu>

(I can resend the entire patch, but I'll resend with a new commit
message if appropriate after any discussion plays itself out).

> 
> Indeed -n is used in many places for --dry-run, but it is not _the_
> standard way.
> 
> commit, push (as you identified), reflog, and send-email have --dry-run
> but -n is not a synonym for it.  Some of them even use -n as a shorthand
> for a more often used option than --dry-run.

Can you point to an example of a git command supporting --dry-run, and
using -n for something else? I personally would find that confusing,
since -n is a common alias for dry-run both inside and outside of git
(c.f. make, rsync, libtool). I guess patch(1) has that property, but
none of your examples from git use -n to mean something else.

In fact, reflog already supports '-n' to mean dry-run, it's just not
documented. I'll send along a documentation patch to fix that.

I got the claim that -n was "standard" from parse-options.h, which
defines OPT__DRY_RUN, which defines both -n and --dry-run switches at
the same time. Given the number of commands that treat them as
synonymous, I think it would be a win for UI consistency to make them
synonymous everywhere.

> 
> So the justification should be more like "push does not any other option
> that deserves a short-and-sweet -n better, it will not have any such
> option in the future, and --dry-run is very often used that it deserves to
> use -n as its short-hand."
> 
> I tend to agree with the first two points, but I am not sure about the
> third point.  Do people dry-push that often?

I personally use --dry-run almost every time I push, which is what
inspired this patch. Especially now that the push.default can change
the behavior of push from repo to repo, I want to be sure I know what
I'm about to push. The recent 'git push --confirm' thread suggests I
am not the only person with this concern.
