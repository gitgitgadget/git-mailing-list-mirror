From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [RFC/PATCH] Teach git mergetool to use custom commands defined at config time
Date: Sat, 16 Feb 2008 23:37:31 +0100
Message-ID: <CD749541-1B3B-4EA7-82A5-0DFC67B953BE@zib.de>
References: <20080216185349.GA29177@hashpling.org>
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Charles Bailey <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Sat Feb 16 23:38:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQVfi-0006PH-34
	for gcvg-git-2@gmane.org; Sat, 16 Feb 2008 23:38:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752437AbYBPWhk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Feb 2008 17:37:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752531AbYBPWhk
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Feb 2008 17:37:40 -0500
Received: from mailer.zib.de ([130.73.108.11]:63653 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751739AbYBPWhj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Feb 2008 17:37:39 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m1GMavjZ028858;
	Sat, 16 Feb 2008 23:37:17 +0100 (CET)
Received: from [192.168.178.21] (brln-4db92f3f.pool.einsundeins.de [77.185.47.63])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m1GMaYC1022063
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sat, 16 Feb 2008 23:36:35 +0100 (MET)
In-Reply-To: <20080216185349.GA29177@hashpling.org>
X-Mailer: Apple Mail (2.753)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74083>


On Feb 16, 2008, at 7:53 PM, Charles Bailey wrote:

> Currently git mergetool is restricted to a set of commands defined
> in the script. You can subvert the mergetool.<tool>.path to force
> git mergetool to use a different command, but if you have a command
> whose invocation syntax does not match one of the current tools then
> you would have to write a wrapper script for it.
>
> [...]
>
> This is a preliminary patch which aims to make it easier to use
> a.n.other 3-way merge tool with git-mergetool without either hacking
> the source or writing a wrapper script for the tool.

Why not just add the tools you have in mind to git mergetool?  If
everyone did that eventually we would have direct support for a
rather long list of tools.  This would be the easiest solution
for the end user: He could just choose the preferred tool and use
it.  The invocation of each merge tool would be coded in
mergetool.  The exact command line could be fine tuned and would
be reviewed by other git developers.

...

> git config --global mergetool.tortoise.cmd 'TortoiseMerge.exe \
> /base:"$BASE" /theirs:"$REMOTE" /mine:"$LOCAL" /merged:"$path"'
>
> git config --global mergetool.p4.cmd 'p4merge.exe "$BASE" "$REMOTE" \
> "$LOCAL" "$path"'
>
> git config --global mergetool.p4win.cmd 'P4WinMrg "$BASE" "$REMOTE" \
> "$LOCAL" "$path"'


If you just integrated these tools directly I could use them
right away instead of first reading the documentation of the
custom mechanism and then looking up how to configure the right
command line for the tool I want to use.  If the tools were
directly integrated I could for example just say "git mergetool
--tool=p4".

That does not mean I am opposed to adding a mechanism for
handling custom tools.  But easier for the end user would be
if the tools were directly integrated.

		Steffen
