From: Gabriel Filion <lelutin@gmail.com>
Subject: Re: unable to checkout branches and proper procedure for creating
 a 	new branch based off of another one
Date: Thu, 17 Jun 2010 01:04:26 -0400
Message-ID: <4C19ACDA.3010600@gmail.com>
References: <AANLkTilZ6zoByCngAGoCbgQ9yd424VcChpTKh_XLnogd@mail.gmail.com>	<AANLkTillFOvwAK_rHhUjhbjRupD1DnQpcMFB3QbExctt@mail.gmail.com> <AANLkTilasCQ1_F0z8NTaJzFNvgnFGImlGN5DcOh0O7VV@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Thomas Anderson <zelnaga@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 17 07:04:43 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OP7HM-0002Oz-Br
	for gcvg-git-2@lo.gmane.org; Thu, 17 Jun 2010 07:04:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751436Ab0FQFEd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jun 2010 01:04:33 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:60770 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751099Ab0FQFEc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jun 2010 01:04:32 -0400
Received: by qyk1 with SMTP id 1so1264422qyk.19
        for <git@vger.kernel.org>; Wed, 16 Jun 2010 22:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=7uC2i2Ny3q9XIOylgTWE9THLpkeLQnvFYaf8m9IaR08=;
        b=gxy9/qx+VDhH4oQQiwE6h4/+EnwAO0njJbVDdndB8BkKQqH+rUmW+x3u80vPkXQQ3H
         g4E7oBhZYtgKHLqxEELWVr60kSqowbV1MFWfAFqDB83woiVOzMYw1nj9Ci6PDIqJrm31
         oJzKz+t7XFah65A2tAT/cH7rAPwddA4UFv9u4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=kLwNlF9Uxp/JQyatxWMlsTxosSsSaMTCz7H/LoZwP7GCEd58Wa9xYyrMv99rEFt5sh
         yRjWVq2gxc/U9SZqdyH310YwxOFqKlSOX5W2CHSFt0l9pwf88x0vciDGvaUMgLlQrbVC
         cySjNsettN9SXQSiMQTyvn9FcxNj2+z8soqt0=
Received: by 10.224.71.214 with SMTP id i22mr5035722qaj.248.1276751071683;
        Wed, 16 Jun 2010 22:04:31 -0700 (PDT)
Received: from [192.168.2.205] (dsl-154-222.aei.ca [66.36.154.222])
        by mx.google.com with ESMTPS id f34sm24960384qco.11.2010.06.16.22.04.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 16 Jun 2010 22:04:30 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.9) Gecko/20100515 Iceowl/1.0b1 Icedove/3.0.4
In-Reply-To: <AANLkTilasCQ1_F0z8NTaJzFNvgnFGImlGN5DcOh0O7VV@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149290>

Hello,

On 2010-06-16 23:44, Thomas Anderson wrote:
> Also, directories that are present in the "branch" branch aren't
> present in the current working directory, despite my having switched
> over.  "git checkout origin/branch" adds the missing directories but
> "git checkout -b origin/branch" does not.  Which leaves me wondering
> what the latter is doing.
> 

Here's for a really short difference between both commands:

git checkout origin/branch
^-> tells git to change the working tree to look like the commit that is
pointed to by the remote branch named "branch" on the remote named "origin".
"origin" is automatically created by "git clone" and represents the
repository from which you cloned the code.

git checkout -b origin/branch
^-> this tells git to create a branch named "origin/master" from the
point in the history on which you currently are and then to switch to it
(checkout). In fact, your working tree will not be different as the
branch was started where you were, e.g. on the "default" branch. The
difference will be that commits made from now on will be placed on the
branch named "origin/branch".


The "branch" branch is there, but it is only referenced by the remote
"origin". I believe what you want to do is to execute the following command:

git branch branch origin/branch
^-> This one creates a local branch named "branch" that tracks the
"origin/branch" remote branch. It will not switch to it, though. You
need to do "git checkout branch" afterwards to have your worktree
adjusted. By doing the above command you effectively tell git that you'd
like to work on the top of the point "origin/branch". Your commits will
be local until they are pushed to origin, hence the need to have a local
branch that can possibly point to a different place in history.


Hope that was not too confusing :\ don't hesitate to ask for precisions ;)

> On Wed, Jun 16, 2010 at 10:32 PM, Thomas Anderson <zelnaga@gmail.com> wrote:
>> I guess what I was trying to do was checkout a remote branch.  Of
>> course, it's unclear to me what the difference between "git checkout
>> origin/branch" and "git checkout -b origin/branch" is.  The latter
>> creates a local branch and the former doesn't?  Does that mean that,
>> with the former, changes I commit and subsequently push will get
>> written to the remote default branch and not the remote "branch"
>> branch?
>>
>> And how do I check that files in the current working directory are
>> from the desired branch?  "git log" shows commits made to the default
>> branch - not to the "default" branch, which doesn't give me much
>> confidence...
>>
>> On Wed, Jun 16, 2010 at 9:41 PM, Thomas Anderson <zelnaga@gmail.com> wrote:
>>> Say there's a Git repository with two branches: default (which is the
>>> default branch) and branch.  I want to checkout branch and start
>>> working on that but am unsure of how to do it.  Here are the commands
>>> that I did:
>>>
>>> git clone git@github.com:username/repo.git
>>> cd repo
>>> git checkout branch
>>>
>>> But that gets me the following error:
>>>
>>> fatal: Not a git repository (or any of the parent directories): .git
>>>
>>> I do "git branch" and here's what I see:
>>>
>>> * default
>>>
>>> Where's "branch"?
>>>
>>> And let's say I wanted to create my own branch based on "branch".
>>> Let's say "branch-zelnaga".  How would I do that?  Do I just checkout
>>> that branch, create a new branch while the current working directory
>>> contains files from the desired branch and then push / commit as
>>> appropriate?
>>>
>>


-- 
Gabriel Filion
