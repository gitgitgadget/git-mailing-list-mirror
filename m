From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Weird shallow-tree conversion state, and branches of shallow trees
Date: Sun, 15 Apr 2007 10:54:11 +0200
Organization: At home
Message-ID: <evsp0k$qoo$1@sea.gmane.org>
References: <20070412005336.GA18378@curie-int.orbis-terrarum.net> <Pine.LNX.4.64.0704141019290.18655@racer.site> <20070415000330.GG3778@curie-int.orbis-terrarum.net> <Pine.LNX.4.63.0704141655390.31807@qynat.qvtvafvgr.pbz> <20070415020139.GB2689@curie-int.orbis-terrarum.net> <20070415043146.GB2229@spearce.org> <fcaeb9bf0704142257x3761ef2cie3996420b3bcd24a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 15 10:50:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hd0RZ-0005KA-Jl
	for gcvg-git@gmane.org; Sun, 15 Apr 2007 10:50:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752403AbXDOIum (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Apr 2007 04:50:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752450AbXDOIum
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Apr 2007 04:50:42 -0400
Received: from main.gmane.org ([80.91.229.2]:41955 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752403AbXDOIul (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Apr 2007 04:50:41 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Hd0RP-0000ut-AH
	for git@vger.kernel.org; Sun, 15 Apr 2007 10:50:35 +0200
Received: from host-89-229-25-173.torun.mm.pl ([89.229.25.173])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 15 Apr 2007 10:50:35 +0200
Received: from jnareb by host-89-229-25-173.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 15 Apr 2007 10:50:35 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-25-173.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44490>

Nguyen Thai Ngoc Duy wrote:

> On 4/15/07, Shawn O. Pearce <spearce@spearce.org> wrote:
>> > The tree that goes out to users is NOT git or CVS. What you point to
>> > here is impossible unless we forced all of the users to migrate to git
>> > (a truly herculean task if there was ever one).
>> > It's a tarball or an rsync of an automatically managed CVS checkout.
>> > (Tarballs go onto the release media, and are also widely used by those
>> > that sneaker-net their trees to machines for security reasons).
>> > Alternatively, the users browse the viewcvs, and pull something from
the
>> > Attic. Regardless of where they get the file from, the problem is that
>> > the file doesn't contain any markers to help the developers merge it
>> > back again.
>>
>> Git won't do this for you.  We specifically don't mangle source[*1*].
>>
>> What you could do is create a program that mangles the files before
>> delivery.  You would probably want to do something like:
>>
>>   $Id: 7fbf239:path/to/file$
>>
>> where 7fbf239 is the earliest commit that introduced that particular
>> version of path/to/file, even if that is months old.  That would
>> be most like what CVS would do.  8 char abbreviated commits should
>> be reasonably stable, and not too long to read or copy and paste.
>> A format like the above would also be easy to grab and copy into
>> a Git command line.
>>
>> If we had a Git library that could access the repository, this would
>> a pretty easy program to write.  You are basically blaming each path
>> in the current HEAD commit on the parent, until you cannot blame
>> anyone else for that path.  You do this blame on the entire tree,
>> and then output the munged structure (or only the files you want
>> munged).
>>
>> Its good we have a GSoC project working on libification!  ;-)
>>
>> [*1*] Yes, I'm ignoring the nutso crlf support that's now in...  Even
>>       though I work on Windows, the only true line ending is LF.  ;-)
> 
> Can we add an attribute like Subversion's svn:keywords? If the
> attribute is set, we expand keywords when checkout and remove
> expansion in memory before doing any git operations. It's some kind of
> I/O filter for working directory access.

There was some talk about keyword expansion, and it is doable IIRC.
Check out threads containing:
  Message-ID: <20070301175200.GA21433@informatik.uni-freiburg.de>
  http://permalink.gmane.org/gmane.comp.version-control.git/41108
(with some inane totally irrelevant subject)  

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
