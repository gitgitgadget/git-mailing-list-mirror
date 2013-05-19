From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [RFC/PATCH 1/2] Doc rebase: Describe rebase as excluding merge commits
Date: Sun, 19 May 2013 23:41:58 +0100
Organization: OPDS
Message-ID: <3E0A16E68BA845B5A1FFA22E066E59B1@PhilipOakley>
References: <1368964329-1600-1-git-send-email-philipoakley@iee.org> <1368964329-1600-2-git-send-email-philipoakley@iee.org> <20130519180804.GE3362@elie.Belkin>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "GitList" <git@vger.kernel.org>
To: "Jonathan Nieder" <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 20 00:42:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UeCIq-0002T3-H1
	for gcvg-git-2@plane.gmane.org; Mon, 20 May 2013 00:42:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753886Ab3ESWl6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 May 2013 18:41:58 -0400
Received: from out1.ip03ir2.opaltelecom.net ([62.24.128.239]:19736 "EHLO
	out1.ip03ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753755Ab3ESWl5 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 May 2013 18:41:57 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AvUPAK9UmVFOl3xU/2dsb2JhbABagwgwiHq4OAQBAwF9F3SCGgUBAQQBCAEBLh4BASELAgMFAgEDDgcBAgklFAEECBIGBxcGCgkIAgECAwGHagMJCgiyLg2IboxKgW1qgnphA4hnhgGEf4Frgw+KdIUjgxA7
X-IronPort-AV: E=Sophos;i="4.87,704,1363132800"; 
   d="scan'208";a="424471222"
Received: from host-78-151-124-84.as13285.net (HELO PhilipOakley) ([78.151.124.84])
  by out1.ip03ir2.opaltelecom.net with SMTP; 19 May 2013 23:41:55 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224928>

From: "Jonathan Nieder" <jrnieder@gmail.com>
Sent: Sunday, May 19, 2013 7:08 PM
> Philip Oakley wrote:
>
>> Describe rebase in the description section.
>
> It already does that. :)  I think you mean "start with a summary",
> which is a valuable improvement.
Yes.

>
>> Include a softer paraphrased version from the crytic, well-loved,
>> but sometimes parodied, Name description, and tell users that merge
>> commits are excluded by default.
>
> I don't really follow this paragraph.  Are you saying "The NAME line
> is cryptic, but let's copy it anyway, since it is better than 
> nothing"?

I was keeping the 'cryptic/esoteric' NAME line, because it is commented 
on in a few blogs [1]. It is accurate but let's not spoil those blogs...

The fundamental reason for the update was to introduce 'somewhere'  in 
the text the "excluding merge commits by default" note, and I couldn't 
find an easy way of updating the NAME line, and then realised a softer 
introduction wiould kill two birds with one stone.
>
> [...]
>> --- a/Documentation/git-rebase.txt
>> +++ b/Documentation/git-rebase.txt
>> @@ -16,6 +16,10 @@ SYNOPSIS
>>
>>  DESCRIPTION
>>  -----------
>> +'git rebase' will transfer local commits, excluding merge commits
>> +by default, to the head of the branch's upstream, or onto a new base
>> +if given.
>> +
>
> Not about this patch, but some day it would be nice to standardize on
> one tense for the DESCRIPTION sections of manpages.  Some git commands
> use the imperative ("Reply local commits, excluding merge commits, on
> top of ..."), some use the present indicative ("Replays local commits,
> excluding merge commits, ..."), and some use the future ("Will replay
> local commits, excluding merge commits, ...").
>
> The traditional tense for Unix manpages is the present indicative.
> But you are right to match the rest of the description here.
>
>>  If <branch> is specified, 'git rebase' will perform an automatic
>>  `git checkout <branch>` before doing anything else.  Otherwise
>>  it remains on the current branch.
>
> The description has become very long by now.  I wonder if it's
> possible to break it into chunks, like so?
>
> DESCRIPTION
> -----------
> <brief description of the purpose of the command, including some token
> mention of *why* a user would want to use it (e.g., "so that the 
> patches
> apply cleanly to their new base").>
>
> It proceeds using the following steps:
>
> 1. If <branch> is specified, ...
> 2. Decides which commits will need to be applied.
>     These are plain, non-merge commits that are ancestors of HEAD but
>     not of <upstream>.
> 3. Checks out <upstream>.  (<Explanation that technically it
>     detaches HEAD at this step.>)
> 4. Reapplies the commits listed on step (2), one by one, in order.
>     If merge failures are encountered, the program will exit and allow
>     the user to resolve them and resume or cancel the rebase.  See
>     the RESPONDING TO MERGE CONFLICTS section below for details.
> 5. Once all of the commits from step (2) have been applied, updates
>     <branch> to point to the new HEAD.
>
> The result is an updated <branch> that ...
>
> OPTIONS
> -------
> ...
>
> EXAMPLES
> --------
> Assume the following history exists and the current branch is "topic":
> ...
>
> Description of specific options like "--preserve-merges" and "--onto"
> could move out of the DESCRIPTION section and to the OPTIONS section.
>
> What do you think?

It's probably something I'd need help on (to ensure correctness). I'll 
have a go based on your suggestions in the next few days.

>
> Thanks,
> Jonathan
> --

[1] http://steveko.wordpress.com/2012/02/24/10-things-i-hate-about-git/ 
section 3 'update'. 
