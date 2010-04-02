From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: are hashes calculated from data
Date: Fri, 2 Apr 2010 02:49:25 -0400
Message-ID: <z2i32541b131004012349na7af3571j67c3a33e3e3ba78@mail.gmail.com>
References: <g2veaacf13c1004011931w70695d1emdceeb977397aee0d@mail.gmail.com> 
	<o2q32541b131004011950u6023ef29ocac1d80f2847ef6f@mail.gmail.com> 
	<buozl1mbi0o.fsf@dhlpc061.dev.necel.com> <y2j32541b131004012148w283911f8pf04a21fc307f68ed@mail.gmail.com> 
	<20100402061015.GC14999@m62s10.vlinux.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Miles Bader <miles@gnu.org>,
	Raymond Auge <raymond.auge@liferay.com>,
	Git Mailing List <git@vger.kernel.org>
To: Peter Baumann <waste.manager@gmx.de>
X-From: git-owner@vger.kernel.org Fri Apr 02 08:49:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NxahU-0004ts-QE
	for gcvg-git-2@lo.gmane.org; Fri, 02 Apr 2010 08:49:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759189Ab0DBGts convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 Apr 2010 02:49:48 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:64658 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758193Ab0DBGtq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Apr 2010 02:49:46 -0400
Received: by gwb19 with SMTP id 19so15138gwb.19
        for <git@vger.kernel.org>; Thu, 01 Apr 2010 23:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=lc6bvkVpUDpoBHsz1T5dhiDj1/1AzpTqonGh6DKBexM=;
        b=i38FwjUIo6M0uO85h1hI+ZfB2mS2J0UHjubU5cV3MI6AEni/9yaeIad16JK50Dz0gW
         I7w299fchqBtccVTB31IlDB5eN44gcLQIbHQ5/Ps+HtGmxNaMnSuJUFNPVp5V1qmOBHE
         9CP2ApRKvsRNQ7kqMaz9TpKJDMlXhwYwHONjw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=ZDmcNQdPXQoHzkYvwhKwqpS96gF6lAK5UNxGBc6IYmPvFVhvdLv5calFlDnE0dvNMD
         aPJWiSB/MZsxKthB6iHPJKM+WmToMhzP+G4idJrBi1AcSV0DmcmPf1A9B9tWMBBJnXbh
         SVR2AtwHoAlRH5OYdd9u63+erxjKD863eNVWU=
Received: by 10.150.152.4 with HTTP; Thu, 1 Apr 2010 23:49:25 -0700 (PDT)
In-Reply-To: <20100402061015.GC14999@m62s10.vlinux.de>
Received: by 10.150.207.15 with SMTP id e15mr2696029ybg.124.1270190985166; 
	Thu, 01 Apr 2010 23:49:45 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143781>

On Fri, Apr 2, 2010 at 2:10 AM, Peter Baumann <waste.manager@gmx.de> wr=
ote:
> On Fri, Apr 02, 2010 at 12:48:44AM -0400, Avery Pennarun wrote:
>> =A0 =A0 =A0 =A0# configure your git-svn so that all its branches are=
 under remotes/svn/*
>> =A0 =A0 =A0 =A0git fetch origin
>> =A0 =A0 =A0 =A0git svn fetch --fetch-all
>> =A0 =A0 =A0 =A0for each branch in remotes/svn/*
>> =A0 =A0 =A0 =A0 =A0 =A0git checkout remotes/svn/$branch =A0 # detach=
es HEAD
>> =A0 =A0 =A0 =A0 =A0 =A0git merge --no-ff origin/$branch
>> =A0 =A0 =A0 =A0 =A0 =A0git svn dcommit =A0 # replaces merge commit
>> =A0 =A0 =A0 =A0 =A0 =A0git checkout origin/$branch
>> =A0 =A0 =A0 =A0 =A0 =A0git merge remotes/svn/$branch
>> =A0 =A0 =A0 =A0 =A0 =A0git push origin HEAD:$branch
>> =A0 =A0 =A0 =A0git push origin refs/remotes/svn/*:refs/heads/svn/*
>
> If I understand you correctly, this will commit only the the merge to=
 svn
> and won't show all the commits the developer made (because of the --n=
o-ff).
> From a SVN standpoint isn't it the same as doing the following?
>
> =A0 =A0 =A0 =A0git checkout remotes/svn/$branch =A0 =A0 =A0 =A0# to d=
eatch the HEAD
> =A0 =A0 =A0 =A0git merge --squash =A0origin/$branch
> =A0 =A0 =A0 =A0git svn dcommit
>
> I asked because in my workflow I can't to afford lossing the single c=
ommits.

No, not quite the same.

When git-svn replaces your merge commit with a new commit (as part of
the 'git svn dcommit' step) the new commit *stays* a merge commit in
git.  That means it has two parents: the svn parent commit, and the
commit that you merged from in the first place.

So what happens is that svn will see only a single commit, but your
git history remains intact and git push/pulling will continue working
as you expect.

If you really need svn to see every individual commit, then you're out
of luck.  The only way to do it is to rebase every time you want to
commit to svn.  git-svn then replaces every single one of your commits
(essentially another rebase, so it can add the git-svn: tags to the
commit message) which makes push/pulling between git repos impossible.

So those are your two choices.  Personally, I like my way as a
transition plan, because the git repo keeps the precise history
(including forks and merges), while the svn keeps *working* for the
stragglers who want to keep using it.

Have fun,

Avery
