From: Boaz Harrosh <bharrosh@panasas.com>
Subject: Re: Recovering from commit --amend in rebase --interactive
Date: Tue, 01 Jun 2010 12:48:58 +0300
Message-ID: <4C04D78A.2090103@panasas.com>
References: <alpine.DEB.2.00.1006011022030.2352@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Peter Krefting <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Tue Jun 01 11:49:10 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJO5t-0005TP-IH
	for gcvg-git-2@lo.gmane.org; Tue, 01 Jun 2010 11:49:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755614Ab0FAJtE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jun 2010 05:49:04 -0400
Received: from daytona.panasas.com ([67.152.220.89]:65050 "EHLO
	daytona.int.panasas.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751879Ab0FAJtC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jun 2010 05:49:02 -0400
Received: from fs2.bhalevy.com ([172.17.33.31]) by daytona.int.panasas.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 1 Jun 2010 05:49:00 -0400
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.9) Gecko/20100430 Fedora/3.0.4-2.fc12 Thunderbird/3.0.4
In-Reply-To: <alpine.DEB.2.00.1006011022030.2352@ds9.cixit.se>
X-OriginalArrivalTime: 01 Jun 2010 09:49:00.0430 (UTC) FILETIME=[A957EAE0:01CB016F]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148104>

On 06/01/2010 12:27 PM, Peter Krefting wrote:
> Hi!
> 
> I am a frequent user of rebase --interactive, and sometimes I do change a 
> commit to "edit", which presents me with an already committed change, which 
> I can fix up, and do "git commit --amend" on.
> 
> However, sometimes I get conflicts during rebase. In some cases I have 
> already seen that conflict, so rerere handles it for me. I am still dropped 
> out of rebase to manually add the fixes, though.
> 
> The problem now is that is way too easy to just do a "git commit --amend" 
> like in the case above, and thus overwriting the previous commit 
> unintentionally.
> 

The prints are clear enough.

If stop do to "edit" then it prints ... you do:
git commit --amend
git rebase --continue

If stop do to merge-conflict it prints ... you do:
git add ... (Note no commit command)
git rebase --continue

You should be getting used to it after a while, I promise you

> Is there an easy way of working around the issue?
> 
> 
> Last time this happened to me, I *did* notice my mistake as I entered the 
> editor, since it came up with the previous commit's message. However, as the 
> commit message file was in a good shape, I found no way to break out of the 
> amend. 

What?!? no, why. Just empty out the message at editor and save. It will abort
any commit and do nothing. 
(For example with kwrite, ctrl-a, delete, ctrl-s, exit)

It does not matter if the commit as entered some default text for you or
not. When editor is done if file is empty (or all comments) then it will
abort and do nothing. Do not worry. The original commit is un affected.
The message is just extracted from the original commit put to a tmp file
and enter into editor. (its just a commit -c after all)

> I ended up using "git reflog" to find out what I overwrote, then "git 
> diff $commitid > savedpatch" to remember what the change that I mistakenly 
> amended was, then "git checkout $commitid" and "git apply savedpatch" and 
> "git add" on the changed files. What I am wondering if there is an easier 
> way of recovering?
> 

Boaz
