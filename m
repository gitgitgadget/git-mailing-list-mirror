From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: Git bundles for backup and cloning: the Zaphod Beeblebrox thread
Date: Mon, 18 Feb 2013 22:30:04 -0000
Organization: OPDS
Message-ID: <E937CF00A75848FA900526903E5B9834@PhilipOakley>
References: <kfrb11$ugv$2@ger.gmane.org>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="utf-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Git List" <git@vger.kernel.org>
To: "Alain Kalker" <a.c.kalker@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 18 23:30:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7ZE4-0000HA-Vw
	for gcvg-git-2@plane.gmane.org; Mon, 18 Feb 2013 23:30:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757390Ab3BRW35 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2013 17:29:57 -0500
Received: from out1.ip07ir2.opaltelecom.net ([62.24.128.243]:18935 "EHLO
	out1.ip07ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757108Ab3BRW34 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Feb 2013 17:29:56 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AgUFACSqIlFZ8rgm/2dsb2JhbABEhkmFPLQfgQQXc4IaBQEBBAEIAQEZFR4BASELAgMFAgEDDgcBBAIFIQICFAEECBIGBxcGEwgCAQIDAQqHZQMJCgiuZ4hHDYlagSOLNoEEe1QLaoFKMmEDjgqGR4J4iiaFFYJ6DQ
X-IronPort-AV: E=Sophos;i="4.84,690,1355097600"; 
   d="scan'208";a="63118239"
Received: from host-89-242-184-38.as13285.net (HELO PhilipOakley) ([89.242.184.38])
  by out1.ip07ir2.opaltelecom.net with SMTP; 18 Feb 2013 22:29:54 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216539>

From: "Alain Kalker" <a.c.kalker@gmail.com>
Sent: Sunday, February 17, 2013 7:28 PM
> From the current documentation for git-bundle(1), it may not be clear
> for
> users unfamilliar with Git, how to create a bundle which can be used
> for
> backup purposes, or, more generally, to clone to a completely new
> repository.
>
> Philip Oakley has posted a documentation patch some time ago, but
> Junio
> has pointed out several concerns.
> Ref: http://thread.gmane.org/gmane.comp.version-control.git/205887/
> focus=205897
>
> Here's my attempt to summarize the concerns, adding some of my own,
> and a
> possible solution.
>
> 1. "Missing HEAD syndrome"
> $ git bundle create <bundle> master
> -or-
> $ git bundle create <bundle> <branchname...>
> -or-
> $ git bundle create <bundle> --branches
> -then-
> $ git clone <bundle> <dir>
>
> will be unable to checkout any files due to a missing ref for HEAD.
> Though this can be fixed by going into <dir> and doing `git checkout
> <ref>`, this is not very user-friendly.
>
> 2. "Detached HEAD syndrome"
> $ git bundle create <bundle> HEAD
> $ git clone <bundle> <dir>
> will checkout files alright, but leaves one in a "detached HEAD"
> state.
>
> 3. "Exploding HEAD syndrome"
> $ git bundle create <bundle> --all
> will add the HEAD, but will add refs from refs/remotes/* too, which is
> not desirable when cloning, unless one sets up all the remotes (e.g.
> by
> restoring .git/config) as well.
>
> Finally, my solution for backing up only the local branches of a
> repository:
> $ git bundle create <bundle> --branches HEAD
> but this may not be very easy for new users to figure out on their own
> unless well documented (perhaps a new flag?)

Perhaps if you draft up a documentation patch that would fit in the
Examples section it could be discussed. The Example section allows that
the various caveats can stated and be covered.

It would also be worth linking to 'git rev-parse' under the
<git-rev-list-args> so folk would actually look it up.

It may be that the example(s) needs to include
    --branches[=pattern]
    --tags[=pattern]
rather than --all. to cover Junio's points.

The --all 'question/solution' has come up a number of times so it does 
look worth having something in the documentation. This would be 
something ;-)

>
> Any comments or suggestions (including HHGTTG references!) are very
> welcome.
>
> -Alain
Do use Reply-All - include any Cc's in replies.
