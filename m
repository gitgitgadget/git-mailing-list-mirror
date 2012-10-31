From: kevin molcard <kev2041@gmail.com>
Subject: Fwd: Re: [git-users] Git clone fails with "bad pack header", how
 to get remote log
Date: Wed, 31 Oct 2012 15:17:33 +0100
Message-ID: <509132FD.5000803@gmail.com>
References: <20121029211854.b58c791d30a6c8d68665e574@domain007.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 31 15:17:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTZ79-0001jU-QY
	for gcvg-git-2@plane.gmane.org; Wed, 31 Oct 2012 15:17:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935649Ab2JaORj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Oct 2012 10:17:39 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:51693 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935624Ab2JaORi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Oct 2012 10:17:38 -0400
Received: by mail-wi0-f178.google.com with SMTP id hr7so1254265wib.1
        for <git@vger.kernel.org>; Wed, 31 Oct 2012 07:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:x-forwarded-message-id:content-type
         :content-transfer-encoding;
        bh=DNIHvkDAYgYct6JMa+c7D6mTxg50oWbODuJ6h6qhCKU=;
        b=X7d27GSkNMb+i3y4aJbMOP1MTr67aeM0zAYY9/NJ88ZURyPBXQecS+SwoF74x27nJ7
         gfRCqPOw5k5wQn+juhtoYgYQIfZNXRLF5oN2hrXsK5qN+7uMv87Zy4/y8+q7WvEPXrsk
         TCAtqiS/9Tmc3oZUqoz3EdavJ/eT6KBVabUCKMkoF3bawlaL+sPscNMuSGQPfEaPaZ/b
         RBkEF5vdjU1tto+JbW1GHwzkEQJAqgV9Rrv7IhFiYxJ65GfbdxMklGyDiCDc0nXj1LlP
         Nvqr3GyG+/4gDQNGhvV4/KDjPohHOX2kP/8LY/CWshTiwPm4NiTyFkvvelIb7ck/O9vO
         PW2w==
Received: by 10.180.104.97 with SMTP id gd1mr2993248wib.4.1351693057552;
        Wed, 31 Oct 2012 07:17:37 -0700 (PDT)
Received: from md009.arturia.lan (mey38-2-82-228-181-124.fbx.proxad.net. [82.228.181.124])
        by mx.google.com with ESMTPS id fp6sm18163785wib.0.2012.10.31.07.17.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 31 Oct 2012 07:17:36 -0700 (PDT)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:16.0) Gecko/20121005 Thunderbird/16.0
In-Reply-To: <20121029211854.b58c791d30a6c8d68665e574@domain007.com>
X-Forwarded-Message-Id: <20121029211854.b58c791d30a6c8d68665e574@domain007.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208823>

Hi all,
I am forwarding a reply I got from a message I sent to git user mailing 
list because of a "bad pack header error" (more information below).
I will forward another email where I give all the git versions of my system.

Any clue on this would be much appreciated.

Thanks in advance
Kevin


-------- Original Message --------
Subject: 	Re: [git-users] Git clone fails with "bad pack header", how to 
get remote log
Date: 	Mon, 29 Oct 2012 21:18:54 +0400
From: 	Konstantin Khomoutov <flatworm@users.sourceforge.net>
To: 	git-users@googlegroups.com
CC: 	Kevin Molcard <kev2041@gmail.com>, git@vger.kernel.org



On Mon, 29 Oct 2012 09:52:54 -0700 (PDT)
Kevin Molcard <kev2041@gmail.com> wrote:

> I have a problem with my build system.
>
> I have a remote server with a relatively large repository (around 12
> GB, each branch having a size of 3 GB).
>
> I have also 2 build servers (Mac, Windows) that are cloning the repo
> from the remote.
>
> Sometimes (very often when several git clone are sent at the same
> time), I have the following error:
>
>     remote: internal server error
>     fatal: protocol error: bad pack header
>
> I know that it happens when the remote is compressing objects (thanks
> to `--progress -v` flags) because the last line of the log before the
> erro is:
>     remote: Compressing objects:  93% (17959/19284)   [K
>
>  * So I have 2 questions, does anybody what is the problem and what
> should I do?
>  * Is there a way to get a more precise log from the remote to debug
> this problem?

This reminds me of a bug fixed in 1.7.12.1 [1]:

* When "git push" triggered the automatic gc on the receiving end, a
   message from "git prune" that said it was removing cruft leaked to
   the standard output, breaking the communication protocol.

In any case, bugs should be reported to the main Git list (which is
git at vger.kernel.org), not here.
I'm Cc'ing the main Git list so you'll get any responses from there, if
any.

Kevin, please answer to this message (keeping all the Ccs -- use "Reply
to group" or "Reply to all" in your MUA) and describe exactly what Git
versions on which platforms your have.

1. https://raw.github.com/git/git/master/Documentation/RelNotes/1.7.12.1.txt
