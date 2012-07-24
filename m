From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3 4/7] Remove obsolete LONG_USAGE which breaks xgettext
Date: Tue, 24 Jul 2012 13:08:09 -0500
Message-ID: <20120724180808.GG2939@burratino>
References: <cover.1343112786.git.worldhello.net@gmail.com>
 <e3481427da5efcb60053bb4cd5bcc7e4567100f0.1343112786.git.worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 24 20:08:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StjWz-0002cH-WB
	for gcvg-git-2@plane.gmane.org; Tue, 24 Jul 2012 20:08:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933694Ab2GXSIU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jul 2012 14:08:20 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:56856 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933690Ab2GXSIO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2012 14:08:14 -0400
Received: by yhmm54 with SMTP id m54so6969494yhm.19
        for <git@vger.kernel.org>; Tue, 24 Jul 2012 11:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=6PMS0+33jXFil8omYII2oKvhDOcQxTe7oAhrXe3IqNY=;
        b=jpzhU3Jcge8thwkmW2w3pmi9I3Se3GN2ezrfYQ4EQMMUwXn8IfuAdtbDzB+eUGbEkL
         aPLmL7SeG9h9kZ48V6jVkYVfBGh/ksHAuQwpjj71lQadl3nZ+KXL24eHVLxK/YgdnV9s
         U1R49VM2HRDHRq9BmBmkJyB+doTvdp0GzZI3JB7RtCxNdFtTqfzn9+p4MuCZBhvWSIe7
         9FuOVnBK++Ti1PzgC6gyWnHUCU69g5BhSsyLLXiEIsg8WQ78ipQk22suYbdQPvpMNkdQ
         xbhy5RE17SBMZOsGRbYxqHvo3WYSpYjvoDf3EdoR2jtfvHn/Aw3Slyo4du5BdZe/d6kL
         XCbA==
Received: by 10.42.99.75 with SMTP id v11mr17145691icn.41.1343153293512;
        Tue, 24 Jul 2012 11:08:13 -0700 (PDT)
Received: from burratino (cl-1372.chi-02.us.sixxs.net. [2001:4978:f:55b::2])
        by mx.google.com with ESMTPS id k5sm2544362igq.12.2012.07.24.11.08.12
        (version=SSLv3 cipher=OTHER);
        Tue, 24 Jul 2012 11:08:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <e3481427da5efcb60053bb4cd5bcc7e4567100f0.1343112786.git.worldhello.net@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202049>

Hi,

Jiang Xin wrote:

> The obsolete LONG_USAGE variable
[...]

It's a shame to lose the information that was in the LONG_USAGE
message, though.  Maybe it could be incorporated into the OPTIONS_SPEC
before the opening "--", or maybe it could be used to clarify the
description in git-rebase(1).

Cc-ing Martin who carried out the parseoptification for advice.  Patch
left unsnipped below for reference.

Thanks and hope that helps,
Jonathan

[...]
> --- a/git-rebase.sh
> +++ b/git-rebase.sh
> @@ -3,31 +3,6 @@
>  # Copyright (c) 2005 Junio C Hamano.
>  #
>  
> -USAGE='[--interactive | -i] [--exec | -x <cmd>] [-v] [--force-rebase | -f]
> -       [--no-ff] [--onto <newbase>] [<upstream>|--root] [<branch>] [--quiet | -q]'
> -LONG_USAGE='git-rebase replaces <branch> with a new branch of the
> -same name.  When the --onto option is provided the new branch starts
> -out with a HEAD equal to <newbase>, otherwise it is equal to <upstream>
> -It then attempts to create a new commit for each commit from the original
> -<branch> that does not exist in the <upstream> branch.
> -
> -It is possible that a merge failure will prevent this process from being
> -completely automatic.  You will have to resolve any such merge failure
> -and run git rebase --continue.  Another option is to bypass the commit
> -that caused the merge failure with git rebase --skip.  To check out the
> -original <branch> and remove the .git/rebase-apply working files, use the
> -command git rebase --abort instead.
> -
> -Note that if <branch> is not specified on the command line, the
> -currently checked out branch is used.
> -
> -Example:       git-rebase master~1 topic
> -
> -	A---B---C topic                   A'\''--B'\''--C'\'' topic
> -       /                   -->           /
> -  D---E---F---G master          D---E---F---G master
> -'
> -
>  SUBDIRECTORY_OK=Yes
>  OPTIONS_KEEPDASHDASH=
>  OPTIONS_SPEC="\
> -- 
> 1.7.12.rc0.17.gcb766d3
> 
