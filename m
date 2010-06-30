From: Will Palmer <wmpalmer@gmail.com>
Subject: Re: purpose of -r flag for git-svn fetch
Date: Wed, 30 Jun 2010 09:40:35 +0100
Message-ID: <1277887235.2498.31.camel@wpalmer.simply-domain>
References: <AANLkTil_iADth0dvcar-nkqjRcmK4p1Sc3UcBmXJ9nQn@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Bradley Wagner <bradley.wagner@hannonhill.com>
X-From: git-owner@vger.kernel.org Wed Jun 30 10:40:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTsqh-0007Ct-TC
	for gcvg-git-2@lo.gmane.org; Wed, 30 Jun 2010 10:40:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752340Ab0F3Ikq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jun 2010 04:40:46 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:63579 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751907Ab0F3Ikp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jun 2010 04:40:45 -0400
Received: by gwb15 with SMTP id 15so232087gwb.19
        for <git@vger.kernel.org>; Wed, 30 Jun 2010 01:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=027e5IYIVhpQc36hJT37KLebJiWWwTazzWqGzA/vA58=;
        b=c4jahF0/w/j5J22oXrE4ZMNo+dQY/rTgUD7q05oTjMAhzX8Cxcw6e3XqgqICycxHC3
         lFNNFcf3wfplumiBX9IiPr1B0wWttFjlm+AlPqjltQHKD2U+6rNAQn0aUwymUWXR1R0S
         Nf1q9l6FrTUaoCm85Q84Gl9VrMHfD8zN3RCoc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=bhyPLv+chp+5QBr9wVftioyzLHZjoUJdBogfOpNzLMBoZOrvp1Svh3o129w2Sb3fxz
         qP+Bi/e+aeJYCF0AAKxcTydtXKVU5bRIMmEeU4Wm87PXY7/6PnvUEqbi6TgbsqODZKXR
         yRVNNYeZQ+t5KpwTMDDewnOzzRebD2IjJwE0k=
Received: by 10.91.190.11 with SMTP id s11mr6425246agp.50.1277887244244;
        Wed, 30 Jun 2010 01:40:44 -0700 (PDT)
Received: from [192.168.2.64] ([193.164.118.24])
        by mx.google.com with ESMTPS id q26sm698755ybk.2.2010.06.30.01.40.37
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 30 Jun 2010 01:40:41 -0700 (PDT)
In-Reply-To: <AANLkTil_iADth0dvcar-nkqjRcmK4p1Sc3UcBmXJ9nQn@mail.gmail.com>
X-Mailer: Evolution 2.28.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149953>

On Tue, 2010-06-29 at 22:29 -0400, Bradley Wagner wrote:
> I've tried doing git-svn fetch in batches because it takes too long to
> do it all at once.
> 
>     git svn -r1:5000 fetch
>     git svn -r5000:10000 fetch
>     git svn -r10000:15000 fetch
> 
> Strangely, after this is done if I look in the history with "git log",
> I only see commits on master branch up through the 5000th revision of
> the SVN repository. Someone told me to then call git-svn rebase to fix
> it. What does "-r" actually do when invoked on consecutive calls to
> "git-svn fetch" and why does git-svn rebase appear to fix it?

The keyword here is "fetch". "fetch" only retrieves data into the
remote-tracking branch (often called refs/remotes/git-svn), without
updating your local branches. "git svn rebase", on the other hand,
rebases your currently-checked-out branch to be based on the git-svn
remote ref. (note that "git svn rebase" does a "git svn fetch"
behind-the-scenes first, and is actually just "git svn fetch" followed
by a normal "git rebase")

The concepts are the same as if you were using the regular git commands
"fetch" and "rebase", so the man pages for those may offer some insight.

> 
> I posted this question to Stackoverflow before realizing that this
> list is a better audience for it:
> http://stackoverflow.com/questions/3144683/master-branch-missing-revisions-after-sequential-git-svn-fetch-calls
> 
> Thanks!
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
