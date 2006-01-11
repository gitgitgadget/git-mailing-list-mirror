From: Andreas Ericsson <ae@op5.se>
Subject: Re: reverting back both working copy and commits
Date: Wed, 11 Jan 2006 20:28:17 +0100
Message-ID: <43C55C51.90305@op5.se>
References: <7ac1e90c0601110832u6fc3a3bcwb7e584445610e53f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 11 20:34:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ewldu-000820-EQ
	for gcvg-git@gmane.org; Wed, 11 Jan 2006 20:28:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932356AbWAKT2T (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jan 2006 14:28:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932438AbWAKT2T
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jan 2006 14:28:19 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:56735 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S932356AbWAKT2S
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jan 2006 14:28:18 -0500
Received: from [192.168.1.19] (1-2-9-7a.gkp.gbg.bostream.se [82.182.116.44])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 6C0076BD03; Wed, 11 Jan 2006 20:28:17 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Bahadir Balban <bahadir.balban@gmail.com>
In-Reply-To: <7ac1e90c0601110832u6fc3a3bcwb7e584445610e53f@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14499>

Bahadir Balban wrote:
> Hi,
> 
> I made some commits that later on I wanted to cancel. I did:
> 
> % git-branch master-2006-get-rid-of-commits
> 
> % git-reset --hard [sha1id]
> 
> where sha1id is the id of commit I want to revert back to. After this,
> git-log points at the right commit (the one with [sha1id]) as the last
> commit made. However, the working copy is left in the original state,
> i.e with the unwanted changes.. How do I also revert the working
> sources into an earlier state.
> 

The branch where you do the reset is the one being reset, so you should 
have simply done the reset in the original branch without creating a new 
one. If you're nervous you're gonna screw up you can do this;

git checkout <branch-with-unwanted-commit>
git tag anchor
git reset --hard <commit-ish>

If you find you've landed on the wrong commit you can undo the change with

git reset --hard anchor

which will restore the branch to wherever you were prior to the first 
reset. Making an anchor tag is useful if you do several resets. You can 
use ORIG_HEAD to undo a single reset.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
