From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [RFC/PATCH] branch: name detached HEAD analogous to status
Date: Mon, 23 Feb 2015 10:21:29 -0500
Message-ID: <54EB4579.3000103@xiplink.com>
References: <71fc137d8015f6e81ab91cfcbcad4ec0fa0dc3e6.1424626271.git.git@drmicha.warpmail.net> <xmqqa905wy43.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Feb 23 16:20:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YPuoJ-0005HL-LW
	for gcvg-git-2@plane.gmane.org; Mon, 23 Feb 2015 16:20:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752454AbbBWPUd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2015 10:20:33 -0500
Received: from smtp90.ord1c.emailsrvr.com ([108.166.43.90]:47030 "EHLO
	smtp90.ord1c.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752440AbbBWPUc (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Feb 2015 10:20:32 -0500
Received: from smtp4.relay.ord1c.emailsrvr.com (localhost.localdomain [127.0.0.1])
	by smtp4.relay.ord1c.emailsrvr.com (SMTP Server) with ESMTP id 7F37F1803CC;
	Mon, 23 Feb 2015 10:20:31 -0500 (EST)
Received: by smtp4.relay.ord1c.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 4A94D180171;
	Mon, 23 Feb 2015 10:20:31 -0500 (EST)
X-Sender-Id: mbranchaud@xiplink.com
Received: from [10.10.1.32] ([UNAVAILABLE]. [192.252.130.194])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA)
	by 0.0.0.0:465 (trex/5.4.2);
	Mon, 23 Feb 2015 15:20:31 GMT
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
In-Reply-To: <xmqqa905wy43.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264264>

On 15-02-22 02:21 PM, Junio C Hamano wrote:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> "git status" carefully names a detached HEAD "at" resp. "from" a rev or
>> ref depending on whether the detached HEAD has moved since. "git branch"
>> always uses "from", which can be confusing, because a status-aware user
>> would interpret this as moved detached HEAD.
>>
>> Make "git branch" use the same logic and wording.
> 
> Yeah, otherwise the user would wonder why sometimes the object name
> after that "from" matches "git rev-parse HEAD" and sometimes does
> not.
> 
> In order to make sure that it will be easy for us to maintain that
> these two commands will keep using the same logic and wording after
> this "fix" is applied, should this patch do a bit more?  Or is it
> worth doing that for such a small piece of code to be shared?
> 
> The following is a tangent and I do not think it is likely we would
> do anything about it, but I wonder what value we give the end users
> by showing the "from" information, both in "status" and "branch" in
> the first place.  When I am on a detached HEAD, I'd be doing one of
> these three things:
> 
>  (1) I am on some kind of sequencing machinery (e.g. "rebase -i",
>      "cherry-pick A..B", or "bisect").  It does not matter to me at
>      all if I am at the same commit at which I started the sequenced
>      operations or the sequencing machinery has moved me one or more
>      commits along its planned course of action, or where the
>      original point the sequencing machinery detached the HEAD at.
>      I suspect that I would not use "git status" or "git branch" in
>      this mode anyway.
> 
>  (2) I am sight-seeing, starting with e.g. "git checkout v2.0.0",
>      and moving around with "git checkout $some_other_commit".  I'd
>      always see that I am "at" the commit I last checked out, so the
>      distinctions would not be even shown to me.
> 
>  (3) I am experimenting to fix or enhance an existing thing that is
>      meant to eventually hit a concrete branch, but I do not know if
>      the experiment would pan out. "git checkout $topic~$n" would be
>      to start from near the tip of that $topic ($n may often be 0
>      but not always) and then I would "git commit" my experiments.
>      When I assess my progress, I'd be interested in what I have
>      that is not in $topic and vice versa since I started that
>      experiment, so

I find it very useful, because I often work on HEADs detached from remote
branches ("git checkout origin/foo").  If I'm sight-seeing, I like the
reminder of which remote branch I checked out, especially because I often
have several working tress going at the same time.  I also often make trivial
changes, like typo fixes, on such detached HEADs, and here too I appreciate
the reminder of which remote branch I should push HEAD to.

		M.
