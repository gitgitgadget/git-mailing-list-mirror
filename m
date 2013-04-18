From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: Pushing/fetching from/into a shallow-cloned repository
Date: Thu, 18 Apr 2013 21:27:55 +0100
Organization: OPDS
Message-ID: <8BCCECD4CEEA4028AD97B851099F4C5E@PhilipOakley>
References: <20130418135233.87aa23896fa48dc2d87d80fb@domain007.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
To: "Konstantin Khomoutov" <kostix+git@007spb.ru>,
	<git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 18 22:28:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USvRR-0004sK-11
	for gcvg-git-2@plane.gmane.org; Thu, 18 Apr 2013 22:28:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936556Ab3DRU2R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Apr 2013 16:28:17 -0400
Received: from out1.ip01ir2.opaltelecom.net ([62.24.128.237]:61236 "EHLO
	out1.ip01ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S935906Ab3DRU2P (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Apr 2013 16:28:15 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Au4NAOtWcFFZ8Yje/2dsb2JhbABQgwaJJrdkBAEDgQYXdIIaBQEBBQgBAS4eAQEsAgMFAgEDFQELJRQBBBoGBwkBDQYBEggCAQIDAYgHvi2OLoNXYQOIT4V0mViDDDs
X-IronPort-AV: E=Sophos;i="4.87,503,1363132800"; 
   d="scan'208";a="426140003"
Received: from host-89-241-136-222.as13285.net (HELO PhilipOakley) ([89.241.136.222])
  by out1.ip01ir2.opaltelecom.net with SMTP; 18 Apr 2013 21:27:53 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221691>

From: "Konstantin Khomoutov" <kostix+git@007spb.ru>
Sent: Thursday, April 18, 2013 10:52 AM
> The git-clone manual page, both [1] and my local copy coming with
> Git for Windows 1.8.1, say about the --depth command-line option:
>
>   --depth <depth>
>
>     Create a shallow clone with a history truncated to the specified
>     number of revisions. A shallow repository has a number of
>     limitations (you cannot clone or fetch from it, nor push from nor
>     into it), but is adequate if you are only interested in the recent
>     history of a large project with a long history, and would want to
>     send in fixes as patches.
>
> But having done a shallow clone (--depth=1) of one of my repositories,
> I was able to record a new commit, push it out to a "reference" bare
> repository and then fetch back to another clone of the same repository
> just fine.  I have then killed my test commit doing a forced push from
> another clone and subsequently was able to do `git fetch` in my 
> shallow
> clone just fine.
>
> So I observe pushing/fetching works OK at least for a simple case like
> this one.
>
> Hence I'd like to ask: if the manual page is wrong or I'm observing
> some corner case?
> --
The manual is deliberately misleading.
The problem is that the depth is a movable feast that depends on how far 
the branches have progressed.
The DAG will be missing the historic merge bases, and in some scenarios 
can form disconnected runs of commits. The ref negotiation can also be a 
problem.

The git\Documentation\technical\shallow.txt has some extra details on 
issues.

Philip
