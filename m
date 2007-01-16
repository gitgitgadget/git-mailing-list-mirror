From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH] git-remote exclude
Date: Tue, 16 Jan 2007 10:26:48 +0000
Message-ID: <200701161026.49752.andyparkins@gmail.com>
References: <45AA44D6.6080605@gmail.com> <200701151155.26111.andyparkins@gmail.com> <7vodp00xag.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Jan 16 11:27:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6lWw-0000pX-GN
	for gcvg-git@gmane.org; Tue, 16 Jan 2007 11:27:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750726AbXAPK0z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 Jan 2007 05:26:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750783AbXAPK0z
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Jan 2007 05:26:55 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:1674 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750726AbXAPK0y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jan 2007 05:26:54 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1627813uga
        for <git@vger.kernel.org>; Tue, 16 Jan 2007 02:26:53 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=W1f6/3j4A/Jcytn8Cp/PEkJs7EK3EXyf0CcaMtGHlnJm+1CMmzCNDJ9ay55XTb3zNCcdbLEZkdd0qria+t7ubrq8xqQbjz+bXfLvOEW+07Ac6a6Qf3fZe3QbkwDwd/ceXFAmaCyTXwlQyY6DPvLh9wh4O7IqqCfIcYcoRDjaKVc=
Received: by 10.67.119.9 with SMTP id w9mr7129078ugm.1168943212652;
        Tue, 16 Jan 2007 02:26:52 -0800 (PST)
Received: from 360run094l ( [194.70.53.227])
        by mx.google.com with ESMTP id e33sm8368871ugd.2007.01.16.02.26.51;
        Tue, 16 Jan 2007 02:26:51 -0800 (PST)
To: git@vger.kernel.org
User-Agent: KMail/1.9.5
In-Reply-To: <7vodp00xag.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36923>

On Monday 2007 January 15 21:56, Junio C Hamano wrote:

> I do not think you are interested in "not these two but
> everything else".  You are interested in maint, master, next, pu
> and man.  You can get away by saying "not these two but
> everything else" only because you are implicitly trusting me not
> to publish insane number of random throw-away branches left and
> right.

Nope.  I think I'm right.  You're right that I'm trusting you not to publish 
an insane number of branches, but that holds for the glob-mode only, 
regardless of whether the NOT fetches are in place.  The sort of thing I 
imagine happening is that as maintainer you suddenly say - I think 1.5.0 is 
so good that we'll maintain it for longer than usual.  In which case we would 
suddenly get a branch for maint-1.5.0.  I would want that branch, but I still 
don't want man, html and todo.

>  - If there are new ones found in the future, please let me know
>    and I'll decide then.  or...
>  - If there are new ones found in the future, I would not want to
>    be bothered with them.  or...
>  - If there are new ones found in the future, I want them too.

 - If there is one that was there but now isn't, ask me if I want to remove
   it

> The choice between the last three will heavily depend on the
> nature of the project and also your work habit to a certain
> degree.

True; so all those should be possible to specify in the config.

> A remote could frequently throw in random small-topic branches
> that are short lived, and are totally uninteresting for somebody
> who wants to track the big picture branches.  You would say the

That's true.  However, if there were discipline in the naming, this wouldn't 
cause a major problem:

 fetch = refs/heads/export/*:refs/remotes/origin/*

Now, only the branches under export/ will be sent across automatically.  You 
can make whatever topic branches you want without polluting the automatic 
namespace.

> first if you primarily work in a particular area of the project,
> because you will always be interested in the primary integration
> and you may or may not be interested in a new topic.  You would

Again, in a project of that size, the branches could be conventionally stored 
in particular namespaces.

  fetch = refs/heads/topicA/*:refs/remotes/origin/topicA/*
  fetch = refs/heads/topicB/*:refs/remotes/origin/topicB/*

> If a single repository has 1000 branches, that is a sign that
> there is something wrong in the project's organization.  No
> single person should need to look at 1000 branches -- that goes
> directly against the distributed nature of git.  Humans do not
> scale well.

Without saying how those 1000 branches are organised, I think that it is an 
incorrect generalisation to say that something is wrong.  I have tens of 
thousands of files in my home directory.  I cannot possibly look at all those 
files; and yet it's not disorganised.

To me, one of git's strongest features is the ability to have hierarchically 
organised branch names.  It solves the scalability problem in one fell swoop.

> But you cannot optimize humans the same way.

No; but you can optimise them in a different way.  Trees are the way, as long 
as the number of choices at any level is within reasonable limits, then you 
can sort through thousands and thousands of items easily.

I actually think the way to go with this globbing stuff is to make it possible 
to specify more accurately what you want.  The weak area at the moment is the 
fact that it's not possible to do a non-recursive glob.  That is to say that

 fetch = refs/heads/*:refs/remotes/*

would grab x/foo, y/bar, and z/baz.  I know you keep your topic branches in 
places like jc/some-topic and js/some-other-topic.  If you ever pushed them, 
then the default glob would pull them all.  If we could have a non-recursive 
glob, then you could safely push them (making things all the more 
distributed) without impacting the master, maint, next, etc branch pulls.

> Helping this kind of project organization is what git inherited
> from BK as well.  The key to scaling is to limit the product of
> the level of details times the size of the area one person needs

All agreed.  However, limiting the detail is not necessarily the same as 
hiding the detail.  If those 1000 branches can be arranged in such a manner 
as to make 990 of them easily ignored, then that's just as good as hiding 
those 990.



Andy
-- 
Dr Andy Parkins, M Eng (hons), MIEE
andyparkins@gmail.com
