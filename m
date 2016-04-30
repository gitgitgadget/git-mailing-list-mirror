From: David Aguilar <davvid@gmail.com>
Subject: Re: using git-difftool -d when cherry-picking
Date: Fri, 29 Apr 2016 18:19:30 -0700
Message-ID: <20160430011930.GA26977@gmail.com>
References: <CAH9ve7x3GSVX1M3yuAY1VmM-WoFX36o-vihFQ3Jw-_SZ4Bh_og@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jan Smets <jan@smets.cx>
X-From: git-owner@vger.kernel.org Sat Apr 30 03:19:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awJZP-0007Bu-Sy
	for gcvg-git-2@plane.gmane.org; Sat, 30 Apr 2016 03:19:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752570AbcD3BTj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2016 21:19:39 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:34586 "EHLO
	mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752203AbcD3BTi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2016 21:19:38 -0400
Received: by mail-pf0-f178.google.com with SMTP id y69so54766163pfb.1
        for <git@vger.kernel.org>; Fri, 29 Apr 2016 18:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8KuANY+OIPPWYvEYeSa4T8/pQYuZd8kkC/b05i8cy0k=;
        b=Wcae5rQhUmhgOVzK6Kxj4yoQqqCFB1LTWmHlKTXaQprQlbAdU+bQqT8szzMNE22xsA
         yDVzdO/PzGN+XydpJZ/Gsthvyn5m0X5o/6pxxy/4ojY4QOtQ+rssNMSuOVLX77qgjS+l
         vh+injZayTtgrBcpFgTrBenUZwaU33xBukZO6tOgkWjfLvK0P6+SbTxeKddb62MOWyvw
         uK6YdpAgTZ24UoZlq/KFGzn1sg7zSwHFTwP5sP7Rdm7FFyUszp13AIFDwT3f0hIC9yEt
         PHuLtCmECXpK75m1PwmAmhKhmtJzqyByvjGZFLKM1QtkGoX4RvkecTXIgpxcaqM13WVE
         n3kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8KuANY+OIPPWYvEYeSa4T8/pQYuZd8kkC/b05i8cy0k=;
        b=fQuIfQ36z6UnP3jAh8Oed3FUHFKKN7ptR6tXqq0v5qf5jBHHw1op707tABge6P5IOP
         CDzcTWWqVB1s5Vky+wQ7He+JQ+G0nCQ+3Wlt3AAHsZnxd9LGs8My0rpQJXaZPGbu/VFZ
         MwrHFhftCquaaxMmVGrZ+sAj41Ma9M4WhnLY5zI/u599rI5xDc46L6KFMIabQCi4wNQP
         SSufBx8ROIoZDzxgxFVRZGSVSir835tRSktpifGE1XiAC6EXdYrVdZyqiNlHnsXD2AVy
         bpnHMPTJmrCC9qXcGIam7YrqwJypJBMgMLXNSnYi5pxosTVHN18IjsbvSoeql8VqnKPq
         TOtQ==
X-Gm-Message-State: AOPr4FVhbF7hizZ58fKLquFnNH9oZ7VhV8UJhkfj9TxM/+HAVQH2AOTwwPpTnW33g4g9zQ==
X-Received: by 10.98.49.134 with SMTP id x128mr33260912pfx.45.1461979178027;
        Fri, 29 Apr 2016 18:19:38 -0700 (PDT)
Received: from gmail.com (remote-11.disneyanimation.com. [198.187.190.11])
        by smtp.gmail.com with ESMTPSA id l81sm26567581pfj.21.2016.04.29.18.19.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Apr 2016 18:19:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAH9ve7x3GSVX1M3yuAY1VmM-WoFX36o-vihFQ3Jw-_SZ4Bh_og@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293119>

On Wed, Apr 27, 2016 at 11:12:25AM +0200, Jan Smets wrote:
> Hi
> 
> Please consider following example
> 
> #!/bin/bash
> rm -rf /tmp/gittest
> mkdir /tmp/gittest
> cd /tmp/gittest
> 
> git init
> 
> echo $RANDOM > testfile
> git add testfile
> git commit -m test -a
> 
> git branch X
> git checkout X
> echo $RANDOM > testfile
> git add testfile
> git commit -m test -a
> 
> git checkout master
> echo $RANDOM > testfile
> git add testfile
> git commit -m test -a
> 
> git cherry-pick X
> git diff --raw
> git difftool -d
> 
> 
> This emulates a merge conflict when using git-cerry-pick.
> 
> $ git diff --raw
> :000000 100644 0000000... 0000000... U  testfile
> :100644 100644 a04e026... 0000000... M  testfile
> 
> When executing git difftool with the -d option :
> 
> /usr/lib/git-core/git-difftool line 260: File exists
> 
> A possible solution is to build an unique list in @working_tree
> 
> The purpose is to edit/resolve the conflict in the difftool.


That could be useful.  git-mergetool is intended to be used when
merge conflicts exist, but it sounds like you may have already
found a possible solution by making @working_tree unique.  Have
you tested that to see if it skirts around the issue?

If you have a patch I'd be happy to help review and test it.
-- 
David
