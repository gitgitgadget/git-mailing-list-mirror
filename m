From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: fsck --full is Ok, but clones are not, "missing commits"?!
Date: Thu, 17 Apr 2008 10:41:08 -0500
Message-ID: <48076F94.7030206@nrlssc.navy.mil>
References: <200804161626.44174.brian.foster@innova-card.com>	 <a537dd660804160804t252d2900j33e30a01dc58979c@mail.gmail.com>	 <480619AE.8010506@viscovery.net>	 <200804171643.15504.brian.foster@innova-card.com> <a537dd660804170753i4dcfd189m45a9581294ce5091@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Brian Foster <brian.foster@innova-card.com>
X-From: git-owner@vger.kernel.org Thu Apr 17 17:58:41 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JmWFN-00019Q-I6
	for gcvg-git-2@gmane.org; Thu, 17 Apr 2008 17:42:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762212AbYDQPlP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Apr 2008 11:41:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761815AbYDQPlP
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Apr 2008 11:41:15 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:42069 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760565AbYDQPlO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Apr 2008 11:41:14 -0400
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id m3HFf9OZ017671;
	Thu, 17 Apr 2008 10:41:09 -0500
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 17 Apr 2008 10:41:09 -0500
User-Agent: Thunderbird 2.0.0.9 (X11/20071031)
In-Reply-To: <a537dd660804170753i4dcfd189m45a9581294ce5091@mail.gmail.com>
X-OriginalArrivalTime: 17 Apr 2008 15:41:09.0081 (UTC) FILETIME=[74DBF490:01C8A0A1]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-5.0.0.1023-15848003
X-TM-AS-Result: : Yes--5.068000-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNTY3LTE1MDY2OC03MDA5?=
	=?us-ascii?B?NzQtNzAwMDc1LTEzOTAxMC03MDgyNTctNzA3NzUwLTcwMTQ1NS03?=
	=?us-ascii?B?MDIwNDQtNzA3MzYxLTcwOTU4NC03MTE5NTMtNzAyMTg3LTcwMjAy?=
	=?us-ascii?B?MC03MDA2MTgtNzA3MTE5LTcwMDA1Ny03MDE1OTAtNzAxNzQ2LTcw?=
	=?us-ascii?B?NzQ1MS03MTAyMjQtNzAyNjA5LTcxMTg2My03MDA3MjYtNzAxNDUw?=
	=?us-ascii?B?LTcwMTA0NS03MDEwMTktNzA1NjA4LTE0ODAzOS0yMDA0MA==?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79797>

Brian Foster wrote:

>  before trying the copying suggestion, I played some
>  more with `filter-branch'.  I had no success at all.
>  as one example, with `--branches' instead of `--all'
>  (one of Brandon's suggestions) produced:
> 
> 	$ git filter-branch --tag-name-filter cat -- --branches
> 	Which ref do you want to rewrite?
> 	$

That's strange. Are there any branches in this repository? Yes, looking at
your earlier email:

  at toplevel of a (not-bare) clone, with  info/grafts  in-place,
  and a happy `fsck -full' (same machine so same git version):

	$ git filter-branch --tag-name-filter cat -- --all  # at not-bare toplevel
	Rewrite 7df30811617517bc4d5ec7c190a435667228320c (168/168)
	Ref 'refs/heads/master' was rewritten
	Ref 'refs/remotes/origin/HEAD' was rewritten
  [snip]

Looks like there is a single branch named 'master'.


The command within git-filter-branch.sh that is being called is

   git rev-parse --no-flags --revs-only --symbolic-full-name --default HEAD --branches

In a trim git repository for example this command returns:

   refs/heads/master
   refs/heads/next

Referring to two branches 'master' and 'next'. These are the references
that exist in .git/refs/heads/*.

I'd be interested to see what this command returns in your repo. You can compare
this output to the output you get using --all and also relate that to the
directory structure beneath .git/refs/

-brandon


p.s. It's more polite to keep the people you are responding to in the cc list.
     Take a look at how Hannes did it (the email to which this one is replying).
     Usually it's enough to select 'Reply All'.
