From: "David A. Wheeler" <dwheeler@dwheeler.com>
Subject: Re: Change "pull" to _only_ download, and "git update"=pull+merge?
Date: Tue, 19 Apr 2005 18:39:04 -0400
Message-ID: <42658888.60007@dwheeler.com>
References: <Pine.LNX.4.21.0504191245160.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@ucw.cz>,
	Martin Schlemmer <azarah@nosferatu.za.org>,
	David Greaves <david@dgreaves.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 20 00:36:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DO1Jv-0006bI-4G
	for gcvg-git@gmane.org; Wed, 20 Apr 2005 00:35:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261711AbVDSWjk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Apr 2005 18:39:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261709AbVDSWjf
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Apr 2005 18:39:35 -0400
Received: from cujo.runbox.com ([193.71.199.138]:56988 "EHLO cujo.runbox.com")
	by vger.kernel.org with ESMTP id S261708AbVDSWjT (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Apr 2005 18:39:19 -0400
Received: from [10.9.9.110] (helo=snoopy.runbox.com)
	by greyhound.runbox.com with esmtp (Exim 4.34)
	id 1DO1N9-0001wk-OG; Wed, 20 Apr 2005 00:39:11 +0200
Received: from [129.246.254.178] (helo=[129.246.80.140])
	by snoopy.runbox.com with asmtp (uid:258406) (Exim 4.34)
	id 1DO1N9-0003uj-Gu; Wed, 20 Apr 2005 00:39:11 +0200
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.21.0504191245160.30848-100000@iabervon.org>
X-Sender: 258406@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Daniel Barkalow wrote:
 >See, I don't think you ever want to just pull. You want to
 >pull-and-do-something, but the something could be any operation...

In a _logical_ sense that's true; I'd only want to pull data if I intended
to (possibly) do something with it.  But as a _practical_ matter,
I can see lots of reasons for doing a pull as a separate operation.
One is disconnected operation; I may want to pull the data now, to
prepare for disconnectino, and then work later while disconnected.
Another is using lots of data compared to the pipesize; if I have a
dial-in modem, or I want the history of the linux kernel since 0.0.1,
I might want to "pull" & go away/go to sleep for the night. I might
use cron/at to automatically "pull" at 3am from some interesting branches.
The next day, I could then "pull" again to update just what changed,
and/or do the operation I intended to do if the operation auto-pulls the
missing data.

>I'm actually getting suspicious that the right thing is to hide "pull" in the id scheme. That is, instead of saying "linus" to refer to the
>"linus" head that you currently have, you say "+linus" to refer to the
>head Linus has on his server currently, and this will cause you to
>download anything necessary to perform the operation with the resulting value.
>  
>
That's an interesting idea.  I'll have to think about that.

What command would you suggest for the common case
of "update with current track?"  I've proposed "git update [NAME]".
"git merge" with update-from-current-track as default seems unclear, and
I worry that I might accidentally press RETURN too soon & merge with
the wrong thing.  And I like the idea of "git update" doing the same thing
(essentially) as "cvs update" and "svn update"; LOTS of people "know"
what update does, so using the same command name for one of the most
common operations smooths transition (GNU Arch's "tla update"
is almost, though not exactly, the same too.)

I still think it's important to have a very simple command that updates
your current branch with a tracked branch (because it's common to stay
in sync with a master branch), and a way to just download the data without
doing things with it YET (because you want to do things in stages).
The commands "update" and "pull" come to mind when thinking that way,
though as long as the commands are simple & clear that's a good thing
(I think it's a GOOD idea to use the same commands as CVS and
Subversion when the results are essentially the same, just because so many
people are already familiar with them, but only where it makes sense.)

--- David A. Wheeler

