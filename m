From: Andrew Wong <andrew.kw.w@gmail.com>
Subject: Re: Apply commits from one branch to another branch (tree structure
 is different)
Date: Fri, 14 Mar 2014 17:57:13 -0400
Message-ID: <CADgNjan7iDOgzXd4Ue69tM9CztM8OmHqzD6yEW7e6v8oM_yBxQ@mail.gmail.com>
References: <CAD6G_RTZaaYBP0MrmRYhce2v+A+WwvY=97Do3LoWW-SYzkHM2g@mail.gmail.com>
	<CADeaMWpw4gx00QpUJ7u49sQvu7KbhvhH14TMdHXBRXq4wCNDZA@mail.gmail.com>
	<CAD6G_RSmpfhTr_qtdaChR9TqMZgn8BAuSNDmK5B3HJDZMyoM1Q@mail.gmail.com>
	<CADgNjan2SQXXfYfMP0sk5tqY_=c68=y0dfANF_KFaPQpzNG3yA@mail.gmail.com>
	<CAD6G_RTzbJGc10doV_ZbC5bd=Zpr6rPbNXni+Yo7cxD38DCLMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, Brandon McCaig <bamccaig@gmail.com>
To: Jagan Teki <jagannadh.teki@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 14 22:57:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WOa6S-0005eh-It
	for gcvg-git-2@plane.gmane.org; Fri, 14 Mar 2014 22:57:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756014AbaCNV5P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2014 17:57:15 -0400
Received: from mail-wg0-f48.google.com ([74.125.82.48]:36786 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754820AbaCNV5O (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2014 17:57:14 -0400
Received: by mail-wg0-f48.google.com with SMTP id l18so2692216wgh.19
        for <git@vger.kernel.org>; Fri, 14 Mar 2014 14:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=sFxtj2O7lUhBNlLZvQ3RrLmpLJb14mpvjArYPj9tZ3U=;
        b=TJxc8ywH9kt6zUY0reUXtbEDgVTyh+G5Nypea2IWWWExIgzy+Z63OU+7b8rJU/eJej
         sbgmccMB6pyYkyHQZrtWxbfm6Zxmr/v9RuNc6CoyHK/zvoLs/wUj+tRBBU6wn7tA3Dv+
         qTdfwqCCvj8ov7dp2XnRz9TGDEtdKNWOIjQrbtekE7rKdg1XWcgRW0HfyA0F2P77LEaD
         +0YWUFeZaOA7pBJfeYZCF/kacOHfNKinhKcYwzpQgGrG+5TbeQRrEUde+6rZBjgHBaWW
         fF8pWKk4rLwZMATcab+EfOfU6k52ks6Rau0+14ovqE+imILLF7Ukcy/WmV35lnL72Y3H
         xv/Q==
X-Received: by 10.180.89.136 with SMTP id bo8mr187101wib.52.1394834233388;
 Fri, 14 Mar 2014 14:57:13 -0700 (PDT)
Received: by 10.194.81.65 with HTTP; Fri, 14 Mar 2014 14:57:13 -0700 (PDT)
In-Reply-To: <CAD6G_RTzbJGc10doV_ZbC5bd=Zpr6rPbNXni+Yo7cxD38DCLMQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244117>

On Fri, Mar 14, 2014 at 4:57 PM, Jagan Teki <jagannadh.teki@gmail.com> wrote:
> Mr.J> git cherry-pick -X subtree=foo
> cc70089614de16b46c08f32ea61c972fea2132ce
> 14e9c9b20e3bf914f6a38ec720896b3d67f94c90
> error: could not apply cc70089... AAAAAAAAAAAAAAAAA
> hint: after resolving the conflicts, mark the corrected paths
> hint: with 'git add <paths>' or 'git rm <paths>'
> hint: and commit the result with 'git commit'
> Mr.J> ls
> foo
> Mr.J> gs
> # On branch branch2
> # Unmerged paths:
> #   (use "git add/rm <file>..." as appropriate to mark resolution)
> #
> #    deleted by us:      foo/foo_v2/test.txt
> #
> no changes added to commit (use "git add" and/or "git commit -a")

Does the foo_v2/test.txt file already exist in branch2 before you try to apply?
i.e. does foo/test.txt exist in branch2?

What might be happening is: the commit modifies foo_v2/test.txt on
branch1, but foo/test.txt doesn't exist on branch2. So even when you
use the subtree option, there's no foo/test.txt on branch2 to
"receive" the changes of foo_v2/test.txt. This is an actual conflict
that git doesn't know what to do, so you have resolve it. This
probably means one of two things for you:

1. You _want_ foo/test.txt on branch2, then:
        git add foo/foo_v2/test.txt    # get the entire test.txt file
from that commit on branch1
        git mv foo/foo_v2/test.txt foo/test.txt    # move/rename the
file to the right location
2. You _don't_ want foo/test.txt on branch2, then:
        git rm foo/foo_v2/test.txt    # just remove it

And then run "git cherry-pick --continue" to continue with the cherry-pick.
