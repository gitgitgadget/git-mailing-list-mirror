X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Francis Moreau" <francis.moro@gmail.com>
Subject: git-{fetch,pull} default behaviours (was Re: [PATCH] Explicitly add the default "git pull" behaviour to .git/config on clone)
Date: Fri, 8 Dec 2006 10:03:47 +0100
Message-ID: <38b2ab8a0612080103h14387513ta53e71fe715441f4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 8 Dec 2006 09:04:04 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=R/kAIj2oCWO4uBqKIkpcH2CQ59P+Dh00XMcb3t4p6fU0MGLrqDCMo+Zsfg2Z7K/MjyCyZp4pj4qxtY15pogR+AvqSA6prOky+dZn32jxxALLTghzusWb+wyvygxs7AYTUklSzYkcD0JL6UTlLpBhuFEk5rQCxZQSF4gaPYKgjOo=
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33674>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gsbe4-00084U-Na for gcvg-git@gmane.org; Fri, 08 Dec
 2006 10:03:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1425265AbWLHJDt (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 8 Dec 2006
 04:03:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1425261AbWLHJDt
 (ORCPT <rfc822;git-outgoing>); Fri, 8 Dec 2006 04:03:49 -0500
Received: from wx-out-0506.google.com ([66.249.82.227]:41085 "EHLO
 wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1425265AbWLHJDs (ORCPT <rfc822;git@vger.kernel.org>); Fri, 8 Dec
 2006 04:03:48 -0500
Received: by wx-out-0506.google.com with SMTP id h27so769952wxd for
 <git@vger.kernel.org>; Fri, 08 Dec 2006 01:03:47 -0800 (PST)
Received: by 10.90.115.9 with SMTP id n9mr3671542agc.1165568627396; Fri, 08
 Dec 2006 01:03:47 -0800 (PST)
Received: by 10.90.55.9 with HTTP; Fri, 8 Dec 2006 01:03:46 -0800 (PST)
To: andyparkins@gmail.com
Sender: git-owner@vger.kernel.org

Andy Parkins wrote:
> Without any specification in the .git/config file, git-pull will execute
> "git-pull origin"; which in turn defaults to pull from the first "pull"
> definition for the remote, "origin".
>
> This is a difficult set of defaults to track for a new user, and it's
> difficult to see what tells git to do this (especially when it is
> actually hard-coded behaviour).  To ameliorate this slightly, this patch
> explicitly specifies the default behaviour during a clone using the
> "branch" section of the config.
>
> For example, a clone of a typical repository would create a .git/config
> containing:
>   [remote "origin"]
>   url = proto://host/repo.git
>   fetch = refs/heads/master:refs/remotes/origin/master
>   [branch "master"]
>   remote = origin
>   merge = refs/heads/master
>
> The [branch "master"] section is such that there is no change to the
> functionality of git-pull, but that functionality is now explicitly
> documented.
>
> Signed-off-by: Andy Parkins <andyparkins@gmail.com>
> ---
> This is really to help newbies.  By explicitly documenting the default
> behaviour, it makes it clearer what is going on.  It also means no routing
> through documentation to find out what config option needs changing.
>

Well I would say that if you want newbies (like me) to understand
git-pull and git-fetch default behaviour, we should first fix their
documentations. I dunno if it's me but I really find it terrible to
read. A lot information are spread all across the doc and I haven't
found a logical organisation in it.

Just reading the synopsis of these two command at first glance does
not give a good view of the commands:

	git-fetch <options> <repository> <refspec> ...

For example, it doesn't say that all arguments are optional at first
look, does it ? How does it say that I can run 'git-fetch origin' ?

When reading git-fetch doc, you find some specific git-pull
documentation which is confusing. The same is true when reading
git-pull doc. Why not removing all remote stuffs from git-pull doc and
just give a link to git-fetch for example ? Why not stopping using
git-pull word in git-fetch doc ?

I'm not sure that putting the default behaviour documentation in git's
config file will help the very newbie that I am. I expect to understand
how a command works in its documentation not by reading some git's
internal config file. And my first feeling when reading them is "whoa
this command seems really complex to use..."

However maybe explaining the default behaviour by giving some examples
would make things much more easier to understand. For example

Examples
--------
	Running 'git-fetch' (without any arguments):
	This is equivalent to run "git-fetch origin"....

	Running 'git-fetch <repository>':
	...

	Running 'git-fetch <repository> <refspec>':
	....

	Running 'git-fetch <refspec>' (if possible):
	...

-- 
