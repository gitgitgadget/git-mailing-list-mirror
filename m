From: David Aguilar <davvid@gmail.com>
Subject: Re: Staging commits with visual diff tools?
Date: Sun, 31 May 2015 19:25:17 -0700
Message-ID: <20150601022515.GA66417@gmail.com>
References: <alpine.DEB.2.10.1505262147230.3709@alice>
 <20150531015956.GA64502@gmail.com>
 <alpine.DEB.2.10.1505311029210.3664@alice>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: John Lee <jjl@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 01 04:25:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzFPs-00027p-AX
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jun 2015 04:25:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756519AbbFACZW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 May 2015 22:25:22 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:35549 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754529AbbFACZU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 May 2015 22:25:20 -0400
Received: by padjw17 with SMTP id jw17so26307706pad.2
        for <git@vger.kernel.org>; Sun, 31 May 2015 19:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Ml3C9A9k1IR+FIfBkydBIG5KcQvlFBdaKAovcnWzOOs=;
        b=M/F6lpsOVSE81CzAgRwE4h0S+0zDt3pVe/Osurl9X1O8P6Rw8RXYMFcm1iU6zzC5dX
         83W/AYTdphqKd9/Nn5TrL7D7stf+x7e+hrSk2nZu5m3rlLzuMlstbioUicDGUnsEI3Bg
         dk8H09yhmO/l+bBqTH86d8NyF5cerBEYSbw5xNc1pKyLB+JUft/mP34QyII9tF5vyaFo
         q9qxJhtxXmcEbyqlc43NP5q9m4zT0FbMtoYS1iYTgWZBsNBQALRpjJ6k7fiV3JuiPjgV
         ir/aZIIxjZWrXLfQEkm8XPMVRrVM91Ih2b1+DBxuU3kqpHPcq/GnAkAF4Ok6c5tZmqf4
         MkcA==
X-Received: by 10.66.102.37 with SMTP id fl5mr36785203pab.88.1433125520181;
        Sun, 31 May 2015 19:25:20 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPSA id q4sm12500398pdo.42.2015.05.31.19.25.18
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 31 May 2015 19:25:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.10.1505311029210.3664@alice>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270373>

On Sun, May 31, 2015 at 10:36:52AM +0100, John Lee wrote:
> On Sat, 30 May 2015, David Aguilar wrote:
> 
> >On Tue, May 26, 2015 at 09:50:49PM +0100, John Lee wrote:
> >>Hi
> >>
> >>Does anybody have code to stage commits using a the visual
> >>diff/merge tools supported by git-difftool?  Is there support in git
> ...
> >I'm a g/vim user, so git-cola is finely tuned for keyboard
> >usage.  If we implement these feature in Git, we should consider
> >providing the same workflows/hotkeys as cola.
> 
> Just to be clear I'm not planning on contributing my script back to
> git, it will just be a standalone script in a separate repo.
> 
> I'll give git-cola a try, thanks.  I just ran it and see it supports
> e.g. right click to stage and launching difftools -- does it also
> support launching a difftool to edit the index?

If you have stuff staged and use ctrl-d (or right-click->difftool),
git cola will run, "git difftool --staged -- <path>".

difftool will already point back to your worktree whenever
possible through the GIT_EXTERNAL_DIFF machinery that it uses.

After changes are made in the worktree you select files, lines,
or hunks and stage them.  Doing it in one step could be as
simple as having a script to automatically call "git add" after
difftool, or "ctrl-s" in cola to stage the whole file.

A not as simple (but potentially quite helpful) use case is a
tool that does a 3-way merge between HEAD, index, and worktree,
and writes the result back to the worktree (or index?).
The mergetool--lib backend could be leveraged for that feature.

Were you thinking of something like this, or something else?
Can you describe your use case a bit more?

It seems like we have most of the use cases covered with stock
git, but I'm not sure if I'm missing something.

cheers,
-- 
David
