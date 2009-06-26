From: Andreas Ericsson <ae@op5.se>
Subject: Re: git svn's performance on cloning mono's branches/tags...
Date: Fri, 26 Jun 2009 12:57:45 +0200
Message-ID: <4A44A9A9.6030008@op5.se>
References: <3ace41890906251739r45b3eae9oe1b7e32886defc0f@mail.gmail.com>	 <4A445959.6090403@op5.se> <3ace41890906260259o3be005fq6be9d0e2c3f9af66@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Hin-Tak Leung <hintak.leung@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 26 12:57:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MK981-0002gP-OV
	for gcvg-git-2@gmane.org; Fri, 26 Jun 2009 12:57:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755480AbZFZK5s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jun 2009 06:57:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754963AbZFZK5r
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jun 2009 06:57:47 -0400
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:33379 "HELO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754704AbZFZK5q (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Jun 2009 06:57:46 -0400
Received: from source ([209.85.220.215]) by na3sys009aob110.postini.com ([74.125.148.12]) with SMTP
	ID DSNKSkSprL4sBD5T0jDKT6BF4wHADvxPQtTU@postini.com; Fri, 26 Jun 2009 03:57:50 PDT
Received: by mail-fx0-f215.google.com with SMTP id 11so476549fxm.5
        for <git@vger.kernel.org>; Fri, 26 Jun 2009 03:57:47 -0700 (PDT)
Received: by 10.86.49.13 with SMTP id w13mr3614267fgw.38.1246013867801;
        Fri, 26 Jun 2009 03:57:47 -0700 (PDT)
Received: from clix.int.op5.se ([212.112.174.166])
        by mx.google.com with ESMTPS id e20sm182004fga.10.2009.06.26.03.57.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 26 Jun 2009 03:57:47 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <3ace41890906260259o3be005fq6be9d0e2c3f9af66@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122290>

Hin-Tak Leung wrote:
> On Fri, Jun 26, 2009 at 6:15 AM, Andreas Ericsson<ae@op5.se> wrote:
>> Hin-Tak Leung wrote:
>>> (I'm not on list so please CC) - I am trying to git svn clone mono's
>>> repository, and for some strange reason it is doing a complete check
>>> out from revision 1 all the way to each branch/tag . Is this normal or
>>> am I doing anything wrong? I have git svn clone a few other things
>>> recently (R, ghostscript) and I don't remember git doing this, but R
>>> is quite a normal svn layout and I think I only have ghostcript trunk
>>> (no branch/tag).
>>>
>>> What I did was this: I started out with just git-svn clone trunk
>>> (which generated the first two [now-commented out] lines), then I
>>> thought I also want 2.4 branch so I added the next commented-out
>>> section, and ran 'git svn fetch --all'. Then I thought I like the
>>> whole thing - so I commented out most of it and added the 4 lines as
>>> blow - which is also my current git config.
>>>
>>> The problem is that it seems to treat every tag as a branch,
>> This is normal. SVN makes no real distinction between tags and branches,
>> so git-svn has no way of detecting which is which. SVN also allows
>> committing to "tags", so it doesn't make sense for git to store what
>> SVN calls tags as git tags.
>>
>> As for your other questions, I don't know.
>>
>> --
>> Andreas Ericsson                   andreas.ericsson@op5.se
>> OP5 AB                             www.op5.se
>> Tel: +46 8-230225                  Fax: +46 8-230231
>>
>> Considering the successes of the wars on alcohol, poverty, drugs and
>> terror, I think we should give some serious thought to declaring war
>> on peace.
>>
> 
> I guess my question is two-fold:
> 1) what is the correct/recommended way of adding tags/branches *after*
> already cloning trunk?
> 

I don't know.

> 2) the current way of cloning svn repository is quite inefficient -
> for every tag/branch, it does:
> r1 -> rX branch 1
> r1 -> rN tag 1
> r1 -> rY branch 2
> r1 -> rM tag 2
> r1 -> rZ branch 3
> etc
> 
> but I think it is possible to track branches to the point where it
> branches off (when 'svn copy' happens), rather than all the way to r1?

This isn't really a question, but a statement with a question mark.

> And in that sense tags are just very short branches.
> 

Often, yes, but they *can* be committed to. SVN's inability to keep
immutable tags is one of the reasons I never looked at it to replace
CVS at $dayjob. But I digress..

> The current behavior is quite bandwith consuming for projects with a
> long history and lots of tags, like mono...
> 

Hmm. I've cloned many subversion repositories to git, and I've never
seen the issues you're seeing. Perhaps because I always cloned the
entire repository the first time, or because I normally do such things
over a high-capacity connection, or because I just fire it up and
forget about it until it's done.

What happens if you ignore the already-cloned svn tree and just do
a new import without trying to continue the old one? Not that I'll
actually do anything about it, as I don't have any problems with it,
but I'm curious even so ;-)

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
