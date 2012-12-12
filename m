From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: (bug?) Inconsistent workdir file timestamps after initial clone.
Date: Wed, 12 Dec 2012 10:48:54 -0500
Message-ID: <50C8A766.30303@xiplink.com>
References: <50C79D1F.1080709@xiplink.com> <7vy5h47003.fsf@alter.siamese.dyndns.org> <50C7AE84.2060400@xiplink.com> <7vr4mw6x3p.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 12 16:48:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TioYG-0001kr-65
	for gcvg-git-2@plane.gmane.org; Wed, 12 Dec 2012 16:48:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754527Ab2LLPse (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2012 10:48:34 -0500
Received: from smtp138.ord.emailsrvr.com ([173.203.6.138]:45418 "EHLO
	smtp138.ord.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754485Ab2LLPs3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2012 10:48:29 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp18.relay.ord1a.emailsrvr.com (SMTP Server) with ESMTP id A81B3303E2;
	Wed, 12 Dec 2012 10:48:28 -0500 (EST)
X-Virus-Scanned: OK
Received: by smtp18.relay.ord1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 5DC20303DA;
	Wed, 12 Dec 2012 10:48:28 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <7vr4mw6x3p.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211361>

On 12-12-11 05:30 PM, Junio C Hamano wrote:
> Marc Branchaud <marcnarc@xiplink.com> writes:
> 
>> My point is that the initial checkout into an empty working directory should
>> create all files with the same timestamp.
>>
>> Or, to be a bit more precise, whenever git-checkout *creates* files in the
>> work dir, *all* the created files should have the *same* timestamp (i.e. the
>> current time measured at the start of the checkout's execution, not some
>> bizarro other time specified by some arcane heuristic).
> 
> My knee-jerk reaction is that it is insane to do so, but what other
> SCM does such a thing?

I'm lucky enough to just care about git these days.

> Even "tar xf" wouldn't do that, I think.

"tar xf" uses the timestamps that are stored in the tar file.  I see this as
an argument against git's exact-current-time-per-file approach: even the tar
guys understand that it's insane.

>>> While not including files that can be rebuilt from the source may be
>>> the ideal solution, I've seen projects hide rules to rebuild such a
>>> "generated but needs special tools to build" and/or a "generated but
>>> normal developers do not have any business rebuilding" file (in your
>>> case, Makefile.in) in their Makefiles from the normal targets (like
>>> "make all") for this exact reason, when they choose to distribute
>>> such files by including in their commits.
>>
>> I prefer to use the third-party code as-is, without hacking it, to have
>> smooth upgrades in the future.
> 
> Then perhaps take the complaints to that third-party upstream, not
> here?

Well, I thought that while I wait for some dozen-or-so projects to accept
changes to their builds, it might be nice for git to solve this problem for
me.  It is, after all, an effect of the way git operates.

		M.
