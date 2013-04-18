From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: put THEIR commits AFTER my commits with a single rebase command
Date: Thu, 18 Apr 2013 08:31:05 +0200
Message-ID: <516F9329.4060405@viscovery.net>
References: <1928280357.20130418091807@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Ilya Basin <basinilya@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 18 08:31:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USiNH-0003lS-0x
	for gcvg-git-2@plane.gmane.org; Thu, 18 Apr 2013 08:31:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753045Ab3DRGbL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Apr 2013 02:31:11 -0400
Received: from so.liwest.at ([212.33.55.23]:20158 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752566Ab3DRGbJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Apr 2013 02:31:09 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.77)
	(envelope-from <j.sixt@viscovery.net>)
	id 1USiN7-0005nq-T5; Thu, 18 Apr 2013 08:31:06 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 810E31660F;
	Thu, 18 Apr 2013 08:31:05 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
In-Reply-To: <1928280357.20130418091807@gmail.com>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221612>

Am 4/18/2013 7:18, schrieb Ilya Basin:
> desired result:
> 
>          A---B---C origin/master
>         /
>     D---E---F---G---A'---B'---C' *master
> 
> 
> 
> Variant 1:
> 
>     git branch -f tmp
>     git reset --hard origin/master
>     git rebase tmp

Variant 1a:

   git reset --hard origin/master
   git rebase @{1}

> 
> This variant is bad, because 'git reset --hard' checks out some files
> and 'git rebase' rewrites them again before applying commits. It's a
redundant job.
>
> Variant 2:
> 
>     git branch -f tmp origin/master
>     git rebase --onto master master tmp
>     git branch -f master
>     git checkout master
> 
> Too many commands. I want to do this with just one command. And I want
> to stay be on branch master in case of rebase conflicts.

Perhaps this one:

   git merge origin/master
   git rebase ORIG_HEAD

-- Hannes
