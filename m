From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 02/13] Use current "detached HEAD" message
Date: Sat, 24 Aug 2013 20:49:16 -0700
Message-ID: <20130825034916.GB2882@elie.Belkin>
References: <282216171.1090748.1377328932833.JavaMail.ngmail@webmail08.arcor-online.net>
 <1667680014.1090850.1377329140347.JavaMail.ngmail@webmail08.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, wking@tremily.us
To: Thomas Ackermann <th.acker@arcor.de>
X-From: git-owner@vger.kernel.org Sun Aug 25 05:50:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VDRLg-0006lB-EA
	for gcvg-git-2@plane.gmane.org; Sun, 25 Aug 2013 05:50:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755505Ab3HYDtW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Aug 2013 23:49:22 -0400
Received: from mail-pb0-f53.google.com ([209.85.160.53]:48926 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755400Ab3HYDtV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Aug 2013 23:49:21 -0400
Received: by mail-pb0-f53.google.com with SMTP id up15so2157363pbc.12
        for <git@vger.kernel.org>; Sat, 24 Aug 2013 20:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=uNWDZw6sfqKgGi0+517PNk4jyJMgXe1hpdkFpB2omSo=;
        b=qpvKwE0Kp/QfVBuJKEWsqagnXd0U9ToCngXDQwZuDVJ9DB7oeUCjNDMX/ZHUPN2hoW
         EM4LUYZFVVajP2ahBZfdSPNum8811ys3WbeB8jDJnJpTE3hnnpA+1pHlIwvmwxcREQIb
         wIX2RjvLVj8fxa8J2HaZcbdkdgG9Ne41W9P+qB7PvBlXqWEGqTX5yDq21htDls6JJA1v
         ODaq23nU8OVmg3zFVjPuD5fju3PESlSwlt4xblw/Ay3DnpdBsWUQmU5JrGUSJ8s3deh0
         fxytItsBc48W+vMI/pMprjjERQpXZTvekexXdM3IjhBYTW6+qKjv8oTlx9msdGg7ovZ/
         aibQ==
X-Received: by 10.67.30.70 with SMTP id kc6mr7123825pad.32.1377402560707;
        Sat, 24 Aug 2013 20:49:20 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPSA id ib9sm9356312pbc.43.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 24 Aug 2013 20:49:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1667680014.1090850.1377329140347.JavaMail.ngmail@webmail08.arcor-online.net>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232904>

Thomas Ackermann wrote:

> --- a/Documentation/user-manual.txt
> +++ b/Documentation/user-manual.txt
> @@ -312,10 +312,17 @@ referenced by a tag:
>  
>  	------------------------------------------------
>  	$ git checkout v2.6.17
> -	Note: moving to "v2.6.17" which isn't a local branch
> -	If you want to create a new branch from this checkout, you may do so
> -	(now or later) by using -b with the checkout command again. Example:
> -	  git checkout -b <new_branch_name>
> +	Note: checking out 'v2.6.17'.
> +
> +	You are in 'detached HEAD' state. You can look around, make experimental
> +	changes and commit them, and you can discard any commits you make in this
> +	state without impacting any branches by performing another checkout.
> +
> +	If you want to create a new branch to retain commits you create, you may
> +	do so (now or later) by using -b with the checkout command again. Example:
> +
> +	  git checkout -b new_branch_name
> +
>  	HEAD is now at 427abfa... Linux v2.6.17

I wonder if this longer wall of text (added in 13be3e31, 2010-01-29)
is too aggressive.

It is the only piece of advice that I explicitly disable in
~/.gitconfig, so I haven't looked at it again for a while.  Since
then, the usual stream of questions about how to recover from people
who accidentally detached HEAD has still been showing up in #git, so I
don't think the message succeeded in its purpose.

That might be partly because it is too long to digest at a glance.

When I see this message, what I actually take in is

                  $ git checkout v1.7.3
 Hmm, capital --->Note: checking out 'v1.7.3'.
 heading before
 lowercase        You are in 'detached HEAD' state. You ...
 sentence.
                                                            ... checkout.

                  If you want ...
                  do so (now or later) by using -b               .... Example:

                    git ...

                  HEAD is ...
 Phew, I can ---->$
 type commands
 again.

Whereas I think the message is just meant to convey the following:

      $ git checkout v2.6.17
      note: checking out a tag for inspection and discardable experiments on top

      To create a new branch to save your changes:

            git checkout -b my-branch-based-on-v2.6.17

      HEAD is now at 427abfa... Linux v2.6.17
      $

>  ------------------------------------------------
>  
> @@ -326,7 +333,7 @@ and git branch shows that you are no longer on a branch:
>  $ cat .git/HEAD
>  427abfa28afedffadfca9dd8b067eb6d36bac53f
>  $ git branch
> -* (no branch)
> +* (detached from v2.6.17)

	grep "no branch" Documentation/user-manual.txt

finds two other instances of that message, which this branch doesn't
touch.  One is about a bisection, where (no branch) is pretty close
to the actual message ('(no branch, bisect started on master)').
The other is about submodules.  Here's a patch for potential squashing
in that corrects it.

Thanks,
Jonathan

diff --git i/Documentation/user-manual.txt w/Documentation/user-manual.txt
index 3e226190..b76219ee 100644
--- i/Documentation/user-manual.txt
+++ w/Documentation/user-manual.txt
@@ -3647,7 +3647,7 @@ working on a branch.
 
 -------------------------------------------------
 $ git branch
-* (no branch)
+* (detached from d266b98)
   master
 -------------------------------------------------
 
