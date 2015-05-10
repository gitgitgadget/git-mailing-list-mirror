From: David Aguilar <davvid@gmail.com>
Subject: Re: git difftool and proper path escaping on windows
Date: Sun, 10 May 2015 13:15:22 -0700
Message-ID: <F14B985A-C968-445A-A3F7-10AE425E7029@gmail.com>
References: <554CF2D9.3050608@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
To: Phil Susi <phillsusi@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 10 22:15:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YrXdR-0000l5-BP
	for gcvg-git-2@plane.gmane.org; Sun, 10 May 2015 22:15:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751892AbbEJUPc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 May 2015 16:15:32 -0400
Received: from mail-oi0-f53.google.com ([209.85.218.53]:36806 "EHLO
	mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751752AbbEJUPb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 May 2015 16:15:31 -0400
Received: by oift201 with SMTP id t201so91143101oif.3
        for <git@vger.kernel.org>; Sun, 10 May 2015 13:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:content-type:subject:from:date:to
         :message-id;
        bh=YD1xFyZgxNnnUIPNc8xbrgLxZoD6D+FQkJvwOnBacj0=;
        b=uhzuFqDFm9XJ+dDlEpkVlPmIWYrD0uxUfpLsawKRLPRqp2zgbU+BdtRFjRmS+MQdBq
         BFxKcb4K0C2KP1aklKQ5oCX9nectSFoUPpRIsqkoOiWtzDiZo8sq+/lSsP0zcsD8JBRE
         9gF93jGs20KzrM2Z9KYCdOzMTeMguU5uHFDcBHJ7ukSPKqWxF42KfdGwuzoq++AugZvJ
         4RdnXQrYplrYpde/+pL1UEXqBs/CRjhG25od0ATwIulrhdQybJy0dRVkc59iJYKTUgRo
         RSCB6oJGd7aOTFcjIM/05C0gsOmseL7nREBduESkmW2pb0QPcoB1sngAXPPqiDlXiYjl
         7y3g==
X-Received: by 10.182.80.68 with SMTP id p4mr5905420obx.46.1431288930976;
        Sun, 10 May 2015 13:15:30 -0700 (PDT)
Received: from [10.61.29.144] ([32.146.238.39])
        by mx.google.com with ESMTPSA id oo10sm7470132oeb.0.2015.05.10.13.15.29
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 May 2015 13:15:30 -0700 (PDT)
User-Agent: K-9 Mail for Android
In-Reply-To: <554CF2D9.3050608@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268748>

On May 8, 2015 10:31:05 AM PDT, Phil Susi <phillsusi@gmail.com> wrote:
>I'm trying to have git difftool run winmerge to compare files, but it 
>seems to be doing something silly with path translation.  My first 
>attempt was:
>
>git difftool -x /c/Program\ Files\ \(x86\)/WinMerge/WinMergeU.exe
>
>To which it responded:
>
>C:\Users\psusi\AppData\Local\Programs\Git/libexec/git-core\git-difftool--helper:
>  eval: line 61: syntax error near unexpected token `('
>
>C:\Users\psusi\AppData\Local\Programs\Git/libexec/git-core\git-difftool--helper:
>eval: line 61: `c:/Program Files (x86)/WinMerge/WinMergeU.exe "$LOCAL" 
>"$REMOTE
>
>
>My first thought was that my shell removed the backslash escapes and 
>then git tried to pass the remaining command to another shell.  So I 
>wrapped the path in single quotes, which should pass the escapes to
>git, 
>which should pass them to the shell, which should then be able to parse
>
>the spaces in parenthesis in the path, but instead I got this:
>
>Launch 'c:/Program/ Files/ /(x86/)/WinMerge/WinMergeU.exe'
>
>So it appears that git is replacing backslashes with forward slashes, 
>then trying to pass that to the shell, which doesn't work.  Any idea
>how 
>to fix or workaround this bug?


paths and executing external programs on windows is confusing and error-prone for a simple unix user such as myself. 

I think you might be able to work around the difficulties by making the tool available in your $PATH, that way you don't have to play shell quoting / escaping games. 

I hope that helps. if you discover a different solution, I'd be happy to document it so that windows users don't have to rediscover how to do it in the future.

let me know how it goes. 
cheers


-- 
David
