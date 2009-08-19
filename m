From: Chris Packham <judge.packham@gmail.com>
Subject: Re: New to Git / Questions about single user / multiple projects
Date: Wed, 19 Aug 2009 16:14:14 +1200
Message-ID: <a038bef50908182114s26d3685r9757fa77b9f41211@mail.gmail.com>
References: <a2db4dd50908181852s1e2c64fen8b883faf76b3136d@mail.gmail.com>
	 <eafc0afe0908181924x60e5dd23vd37711db880ead84@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Rob (gmail)" <robvanb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 19 06:14:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdcZ4-0001un-EA
	for gcvg-git-2@lo.gmane.org; Wed, 19 Aug 2009 06:14:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750801AbZHSEON (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Aug 2009 00:14:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750793AbZHSEON
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Aug 2009 00:14:13 -0400
Received: from mail-vw0-f172.google.com ([209.85.212.172]:36008 "EHLO
	mail-vw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750763AbZHSEON (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Aug 2009 00:14:13 -0400
Received: by vws2 with SMTP id 2so3541893vws.4
        for <git@vger.kernel.org>; Tue, 18 Aug 2009 21:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=HUyzwuZrfKeXJKz27gX3c1QuFdN4sn5XIB8kFx0yvnI=;
        b=rBdoCeNp/2/zMLZqpLTYm0W4yEgTCJIeG0D3wlqxG/+uxvR00HWxtQEamxWjmFRoXr
         Fb8YosZ2DuEK3wZsNKNOTrfvL5D/J0Q+b7yLdJ8HtPB//AmhLudYLBxsRMAeXI4hTlJh
         GwKdjTKCJJSwHPfYqafwjwoedWw1ZFge3zets=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=OvOM/iH01hS2Ps21g2XEVQ5xRR+mBr0RfLUvcGQ20h9clYeHTTq+A0Z6bovc4x48/9
         qms6N4GicFKFeTA6fPEeTXZ7k3J9PB8lDDvq0bj7vyE1p4UPQXdLQIXJ3cZ4nbPeISSP
         4/hpcY+qSqg8zzd1aZXDSRZPP1eHU2/gRS3Og=
Received: by 10.220.12.148 with SMTP id x20mr8145993vcx.86.1250655254159; Tue, 
	18 Aug 2009 21:14:14 -0700 (PDT)
In-Reply-To: <eafc0afe0908181924x60e5dd23vd37711db880ead84@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126503>

My $0.02

On Wed, Aug 19, 2009 at 1:52 PM, Rob (gmail)<robvanb@gmail.com> wrote:
> Q1:
> Can I create a single repository (project?) for all my code, knowing
> that there are multiple small, unrelated projects. Or should I create
> a new repository for each project ?

Thats entirely up to you. I prefer keeping lots of little repositories
for unrelated projects. That way I can use cool things like git
archive to generate tarballs if/when I need to. Although I do use the
single repository method sometimes when I'm feeling lazy. One thing
git has over some other VCSes is the ability to track changes past
renames. That way you can start off lazy and just have a fairly flat
code structure and then as you start to group code into logical sets
you can move them into directories without any danger of losing
history (one tip though, do the moving as a commit on its own this
makes the re-name detection work a lot better).

As Changsheng pointed out. You can also have the best of both worlds
and use git submodules to tie together multiple repositories. Although
I've always though of submodules as more of a build tool when you want
to track components of a larger system i.e. a linux distro might track
the kernel, kde, gnome ... and use a submodule setup to track known
stable points where those components work together.

>
> Q2:
> After initalizing my repository, and comitting the 1st batch of code:
> When further working on the code, will the command "git add ." add all
> changed and new files ? Or do I specifically need to list the new
> files ?

You can use 'git add -u' which adds any locally modified (but not
completely new) files to the index (its basically the first half of
'git commit -a'). For the new files either 'git add .' or list the
files.

> Q3: Can I run 'git add x' in any subdirectory, or do I need to issue
> if from the root of the project ?

Yes all the git commands work from subdirectories (well except
init/clone) . This is actually really useful if you want to get the
history of a component in a large code base without getting a lot of
irrelevant changes in other components.
