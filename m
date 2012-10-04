From: Marco Craveiro <marco.craveiro@gmail.com>
Subject: Re: Ignore on commit
Date: Thu, 4 Oct 2012 22:20:53 +0100
Message-ID: <CAKRNd4wbT_boRyFOOL_95FBW4ws8Zzz2ubVCfXuRSevzPdhW9g@mail.gmail.com>
References: <CAKRNd4w4Z-LS9O5ffkbTSZ0Guv4KCmWR=AtW3EpxQ2sSgazG=Q@mail.gmail.com>
	<506DEC50.7090402@obry.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: pascal@obry.net
X-From: git-owner@vger.kernel.org Fri Oct 05 00:46:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJtk6-0005yD-Op
	for gcvg-git-2@plane.gmane.org; Fri, 05 Oct 2012 00:18:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753881Ab2JDWCr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2012 18:02:47 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:61740 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933719Ab2JDVUy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2012 17:20:54 -0400
Received: by mail-ob0-f174.google.com with SMTP id uo13so989201obb.19
        for <git@vger.kernel.org>; Thu, 04 Oct 2012 14:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=OeaOoOZjTRlzUrF1WFBlAEY8EoqfiTRk4bZ2uQ+LWsc=;
        b=e0wS6Zt8mWYbR+b9oRileQTSX1zN0pORn+7EHdm5VDcYHixhJ66//O7nnr3wu+gl8Q
         vNBv+YDyySPAvKQI9SFWn42WwuAy8mTF8+pl0VCJbQ1Nh32p6gUQAUFGFcjWw0m6V/z+
         fheIsHcjdLyc/OIYXhpE8ZIJe8vZFz7JKr8mEF1G6xpmYR79owQ/ZsBW+Djy097BqMtt
         X3LGLboYfyLqDM7sBdOikxTyEsWO0KB87LDwrv79N35wmeCGiD+dz+InMJAyaP49Oe+h
         iLGsJplLDJTsV0xMBBPypF94F0T7g1t9ZvyRCFF4K5he3TWnTvBQxwPvzqB+xsX9bHZ4
         cuVA==
Received: by 10.182.86.165 with SMTP id q5mr5561094obz.23.1349385653990; Thu,
 04 Oct 2012 14:20:53 -0700 (PDT)
Received: by 10.76.102.20 with HTTP; Thu, 4 Oct 2012 14:20:53 -0700 (PDT)
In-Reply-To: <506DEC50.7090402@obry.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207024>

<ignore on commit>
> I'm not sure to follow everything... But looks like:
>
>    $ git add -p
>
> or
>
>    $ git add -i
>
> should do what you want, no?
>
> You select the hunks to commit, let over the "hacks" and then
>
>    $ git commit

Similar but not quite; the idea is that you know that there is some
code (I'm just talking about files here, so lets ignore hunks for the
moment) which is normally checked in but for a period of time you want
it ignored. So you don't want it git ignored but at the same time you
don't want to see these files in the list of modified files. The
changelist concept allows you to "move" the files out of the way from
the main modified section until you are ready to commit them. Perhaps
an imaginary git status would help:

# Changes to be committed:
#   (use "git reset HEAD <file>..." to unstage)
#
#	modified:   some_staged_file.h
#
# Changes not staged for commit:
#   (use "git add <file>..." to update what will be committed)
#   (use "git checkout -- <file>..." to discard changes in working directory)
#
#	modified:   some_modified_file.h
#
# Changes ignored on commit:
#
#	modified:   some_other_modified_file.h

Such that if you now did a git add -A, some_modified_file.h would then
be staged but some_other_modified_file.h would stay put. Of course the
name "ignored on commit" makes little sense in git terms, but I'm
using it here as its the svn term. Its a "modified but temporarily
ignored" or something.

Cheers

Marco
-- 
So young, and already so unknown -- Pauli

blog: http://mcraveiro.blogspot.com
