From: Toby Corkindale <toby.corkindale@rea-group.com>
Subject: Re: diff/Checking out by date specification
Date: Mon, 30 Jun 2008 14:38:17 +1000
Organization: REA Group
Message-ID: <48686339.60205@rea-group.com>
References: <486843C3.30402@rea-group.com> <20080630032744.GA18930@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 30 06:39:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDBAw-0005hR-8j
	for gcvg-git-2@gmane.org; Mon, 30 Jun 2008 06:39:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751124AbYF3Eil (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jun 2008 00:38:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751222AbYF3Eil
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jun 2008 00:38:41 -0400
Received: from mel-nat68.realestate.com.au ([210.50.192.68]:19221 "EHLO
	mel-nat68.realestate.com.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750878AbYF3Eil (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Jun 2008 00:38:41 -0400
Received: from [192.168.52.7] ([192.168.52.7]) by mel-nat68.realestate.com.au with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 30 Jun 2008 14:38:14 +1000
User-Agent: Thunderbird 2.0.0.14 (X11/20080505)
In-Reply-To: <20080630032744.GA18930@sigill.intra.peff.net>
X-OriginalArrivalTime: 30 Jun 2008 04:38:14.0863 (UTC) FILETIME=[1C256DF0:01C8DA6B]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86870>

Jeff King wrote:
> On Mon, Jun 30, 2008 at 12:24:03PM +1000, Toby Corkindale wrote:
> 
>> `man git-rev-parse` seems to indicate that one can look at the state of  
>> the repository by date (absolute or relative), and use this for diff or  
>> checkout, etc.
>> It includes examples such as "{yesterday}" and "{1979-02-26 18:30:00}".
> 
> It's a little bit more complex than that. The branch@{time} syntax means
> "what was in _my_ branch at that time". And if you just cloned, your
> branch doesn't go back very far.
> 
> If you want to say "find commits that happened before time T", you want
> --until or --since (or their aliases --before and --after).
> 
> Would the documentation patch below have helped with the confusion?

Ah, I see.
Thanks, yes, that would have made the issue clearer.

I think it would be good if you could give a couple of examples, such as:
How would I go about checking out the code at the state it was in at, 
say, 2008-01-01?
Or how one can get a diff between 2008-01-01 and 2008-01-08?

(I note that "git-diff --until=2008-01-08 --since=2008-01-01" fails, as 
does "git-checkout --until=2008-01-08")

thanks for the quick response!
-Toby


> 
> -- >8 --
> doc/rev-parse: clarify reflog vs --until for specifying revisions
> 
> The rev-parse manpage introduces the branch@{date} syntax,
> and mentions the reflog specifically. However, new users may
> not be familiar with the distinction between the reflog and
> the commit date, so let's help them out with a "you may be
> interested in --until" pointer.
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  Documentation/git-rev-parse.txt |    5 ++++-
>  1 files changed, 4 insertions(+), 1 deletions(-)
> 
> diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
> index 9e273bc..59e95ad 100644
> --- a/Documentation/git-rev-parse.txt
> +++ b/Documentation/git-rev-parse.txt
> @@ -184,7 +184,10 @@ blobs contained in a commit.
>    second ago\}' or '\{1979-02-26 18:30:00\}') to specify the value
>    of the ref at a prior point in time.  This suffix may only be
>    used immediately following a ref name and the ref must have an
> -  existing log ($GIT_DIR/logs/<ref>).
> +  existing log ($GIT_DIR/logs/<ref>). Note that this looks up the state
> +  of your *local* ref at a given time; e.g., what was in your local
> +  `master` branch last week. If you want to look at commits made during
> +  certain times, see `--since` and `--until`.
>  
>  * A ref followed by the suffix '@' with an ordinal specification
>    enclosed in a brace pair (e.g. '\{1\}', '\{15\}') to specify


-- 
Toby Corkindale
Software developer
w: www.rea-group.com
REA Group refers to realestate.com.au Ltd (ASX:REA)

Warning - This e-mail transmission may contain confidential information.
If you have received this transmission in error, please notify us
immediately on (61 3) 9897 1121 or by reply email to the sender. You
must destroy the e-mail immediately and not use, copy, distribute or
disclose the contents.
