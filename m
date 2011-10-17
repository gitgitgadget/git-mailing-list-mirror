From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: regression in git-gui since 2c5c66b... Merge branch 'jp/get-ref-dir-unsorted
Date: Mon, 17 Oct 2011 06:07:34 -0400
Message-ID: <4E9BFE66.5070906@gmail.com>
References: <4E9B1E32.7030101@gmail.com> <7vfwispi8u.fsf@alter.siamese.dyndns.org> <4E9B8719.1090203@gmail.com> <4E9BA39B.709@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Oct 17 12:07:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFk6h-0000GS-8k
	for gcvg-git-2@lo.gmane.org; Mon, 17 Oct 2011 12:07:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752266Ab1JQKHi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Oct 2011 06:07:38 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:51495 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750961Ab1JQKHh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Oct 2011 06:07:37 -0400
Received: by qabj40 with SMTP id j40so338153qab.19
        for <git@vger.kernel.org>; Mon, 17 Oct 2011 03:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=hSpifb21ovzw8pR4FN0qtNgoiOHkLwT4RN9g4R7HIzQ=;
        b=otEtX0xiX7NG+9+0Tgu9M4imvfCuv8rcC4A65YSyw6r+qd1hAsrtmLHx11bnFjsTfp
         EA4eHcY4oOZD/zVJvKWl1n+AOWvwCCFXzWGL6+A87acG7FMtyEzabVgWMxPIikpsxlME
         phODvbFj3CKWvv+YmJ33lOeY6efrSqn1tZR4k=
Received: by 10.224.106.197 with SMTP id y5mr15037131qao.60.1318846057176;
        Mon, 17 Oct 2011 03:07:37 -0700 (PDT)
Received: from mark-laptop.lan (pool-173-73-114-154.washdc.fios.verizon.net. [173.73.114.154])
        by mx.google.com with ESMTPS id dn1sm3096378qab.10.2011.10.17.03.07.35
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 17 Oct 2011 03:07:36 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:7.0) Gecko/20110927 Thunderbird/7.0
In-Reply-To: <4E9BA39B.709@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183789>

On 10/16/2011 11:40 PM, Michael Haggerty wrote:

> Please bear with me because I don't use git-gui so I don't really know
> what to expect.
>
> When I check out 2c5c66b and run the above script (actually, the script
> listed below) what I see in git-gui is:
>
> * In the "Unstaged Changes" window, "sub" is listed (not "sub/a").
>
> * When I click on "sub", then in the "Untracked, not staged" window,
> "Git Repository (subproject)" appears.
>
> I see the exact same thing when I run the same test script on the
> version before merge 2c5c66b.
>
> What do you see?
>
> What do you expect to see?
>
> What versions of git, exactly, are you testing (what version do you
> consider "good"; presumably it is version 2c5c66b that you consider "bad")?
>
> Are you certain that you are using the same git version for all commands
> ("git", "git-gui", and "git-new-workdir")?  Please especially note that
> git-new-workdir is not part of a default git install, and therefore it
> would be easy to accidentally use a different version of this script
> than of the other commands.
>
> Michael
>
> #!/bin/bash
>
> SRC=$(cd $(dirname $0); pwd)
> GIT=$SRC/git
> GIT_NEW_WORKDIR=$SRC/contrib/workdir/git-new-workdir
> GITGUI=$SRC/git-gui/git-gui
>
> rm -rf super sub
> mkdir super sub
> cd sub
> $GIT init
> touch a
> $GIT add a
> $GIT commit -m 'file' a
> $GIT pack-refs --all
> cd ../super
> $GIT init
> $GIT_NEW_WORKDIR ../sub sub
> $GITGUI&
Michael,

Thanks for looking....

Your modification of my script does not show the error for me, unless I 
have *installed* a version of git with the failure: I suspect git-gui 
invokes installed components, and not what is in the build directory, so 
having a good version of git installed with the bad version in the build 
directory does not show the error. And yes, I am quite sure that all of 
the git commands I am running are from the one version.

What I expect to see is what you saw: the "sub" directory listed under 
Unstaged Changes. What I get when I have installed version 2c5c66b (or 
current master) is the file "sub/a" listed under Unstaged Changes, in 
other words git-gui no longer recognizes that sub is a submodule.

Mark
