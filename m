From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Recording the current branch on each commit?
Date: Mon, 28 Apr 2014 03:50:27 -0500
Message-ID: <535e165364bc5_338911e930cdf@nysa.notmuch>
References: <535C47BF.2070805@game-point.net>
 <CALKQrgfmBByMwMhxu3HkJqJGWy2Rwvij6Hi1_4npjfsxcSgpaQ@mail.gmail.com>
 <535D4085.4040707@game-point.net>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Git mailing list <git@vger.kernel.org>
To: Jeremy Morton <admin@game-point.net>,
	Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon Apr 28 11:01:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WehQy-0002h9-45
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 11:01:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753865AbaD1JBD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 05:01:03 -0400
Received: from mail-ob0-f178.google.com ([209.85.214.178]:51812 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751502AbaD1JBB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 05:01:01 -0400
Received: by mail-ob0-f178.google.com with SMTP id wn1so7023398obc.9
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 02:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=xooqQcVDfHyxHU8o8t7hUsuz3/mTQNufrnw0yC/OpGk=;
        b=e4O3GiBWYBr9M+igoWmz52nqLYQV3svnMnroVz0I3UK4s+qcsD2NWj6kmAOShZT27E
         MvdCxuQuCRLbKZKRK66gubtJWocM4OGkLYIGWucWMhDzCJYJgSXCmBtMFooghxYX/iFS
         mpdOrfZdpIGRkmbIkNJT7uCNnez/qhCe/Qn87YemILnY8p7xd8rghwBA0RSM9FzvouXP
         JiyAxtXccHUeDJk64JUfVHVqLg9mlyvZKZGRXREwQd3ap+hIgX04HS0P+v22QRlW/WY6
         tz/fKs7VEPt0yUGkioWvJQ+Fx0Dbt1Rfc74d7CPbwm8bcP5tGlGOQMfF4eS/A+6S4s0c
         R6ig==
X-Received: by 10.182.142.229 with SMTP id rz5mr21580264obb.12.1398675660638;
        Mon, 28 Apr 2014 02:01:00 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id h1sm35461177obr.15.2014.04.28.02.00.58
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Apr 2014 02:00:59 -0700 (PDT)
In-Reply-To: <535D4085.4040707@game-point.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247251>

Jeremy Morton wrote:
> On 27/04/2014 10:09, Johan Herland wrote:
> > On Sun, Apr 27, 2014 at 1:56 AM, Jeremy Morton<admin@game-point.net>  wrote:
> >> Currently, git records a checksum, author, commit date/time, and commit
> >> message with every commit (as get be seen from 'git log').  I think it would
> >> be useful if, along with the Author and Date, git recorded the name of the
> >> current branch on each commit.
> >
> > This has been discussed multiple times in the past. One example here:
> > http://thread.gmane.org/gmane.comp.version-control.git/229422
> >
> > I believe the current conclusion (if any) is that encoding such
> > information as a _structural_ part of the commit object is not useful.
> > See the old thread(s) for the actual pro/con arguments.
> 
> As far as I can tell from that discussion, the general opposition to 
> encoding the branch name as a structural part of the commit object is 
> that, for some people's workflows, it would be unhelpful and/or 
> misleading.

s/some people's workflows/most workflows/

> Well fair enough then - why don't we make it a setting that 
> is off by default, and can easily be switched on?  That way the people 
> for whom tagging the branch name would be useful have a very easy way to 
> switch it on.  I know that for the workflows I personally have used in 
> the past, such tagging would be very useful.  Quite often I have been 
> looking through the Git log and wondered what feature a commit was "part 
> of", because I have feature branches.  Just knowing that branch name 
> would be really useful, but the branch has since been deleted... and in 
> the case of a ff-merge (which I thought was recommended in Git if 
> possible), the branch name is completely gone.

I still don't see why you would need that information, but if you really need
it, you can write a commit hook that stores that information in the message,
it's very trivial. Also, you can store that information in notes.

> You can go back through the history and find "Merge branch
> 'pacman-minigame'", but how do you know which commit was the *start* of that
> branch, if they are not tagged with the branch name?

By recording the start of the branch.

[1] https://github.com/felipec/git/commits/fc/tail

-- 
Felipe Contreras
