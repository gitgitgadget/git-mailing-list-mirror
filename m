From: Kevin Ballard <kevin@sb.org>
Subject: Re: Newbie .gitignore problem
Date: Wed, 22 Sep 2010 12:44:38 -0700
Message-ID: <069C161A-4498-4D4F-BEC4-800BC2A4989A@sb.org>
References: <AANLkTin=BwgjqWQ3NfNdL9a1fUnVnFMrmAsmnZjHS=gL@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: Jonathan Gossage <jgossage@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 22 21:44:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OyVFJ-0004Nb-IK
	for gcvg-git-2@lo.gmane.org; Wed, 22 Sep 2010 21:44:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755406Ab0IVTon (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Sep 2010 15:44:43 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:61207 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752038Ab0IVTom convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Sep 2010 15:44:42 -0400
Received: by pwj6 with SMTP id 6so66583pwj.19
        for <git@vger.kernel.org>; Wed, 22 Sep 2010 12:44:42 -0700 (PDT)
Received: by 10.114.60.5 with SMTP id i5mr760125waa.146.1285184682272;
        Wed, 22 Sep 2010 12:44:42 -0700 (PDT)
Received: from [10.8.0.89] ([69.170.160.74])
        by mx.google.com with ESMTPS id r37sm18160197wak.23.2010.09.22.12.44.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 22 Sep 2010 12:44:40 -0700 (PDT)
In-Reply-To: <AANLkTin=BwgjqWQ3NfNdL9a1fUnVnFMrmAsmnZjHS=gL@mail.gmail.com>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156832>

Git tracks symlinks the same way it tracks files. It'll record the contents of the symlink (the path it points to) as a blob, and then record the symlink itself with a special mode to indicate that it is a symlink. This means that if your symlink points outside of the repository, nothing pointed to by it will even be examined by git. And if it symlinks another dir in the repo, but the contents of that dir are excluded via your gitignore, anything inside the dir will still be excluded. With this in mind, it appears from your diagram that dir2 is likely to be pointing outside of the repository, and so dir4 is never even seen by git.

-Kevin Ballard

On Sep 22, 2010, at 9:41 AM, Jonathan Gossage wrote:

> I am having a problem specifying .gitignore filters properly
> I have a directory structure as follows:
> 
>           repo-root
>                |
>                -------------------------------------------------------------------
>                |                    |
>           |
>               dir1               dir2  (symlink)
>              dir3
>                                     |
>                 ---------------------------------------------------
>                |                                                   |
>           many directories and files                  dir4
> 
> My problem is that I want to exclude all files and sub-directories in dir2
> except for dir4 from control by Git.
> I tried a number of variations on the following .gitignore file in dir2 but
> either everything was excluded or everything was included. I tested using
> git add -uall -n
> 
> The final .gitignore file was
> *
> */*
> !dir4
> 
> 
> How should I go about tackling this. The .gitignore man pages were
> unclear to me.
> 
> Jonathan Gossag--
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> e
