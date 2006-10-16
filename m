From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: VCS comparison table
Date: Tue, 17 Oct 2006 00:53:07 +0200
Organization: At home
Message-ID: <eh12fn$i9v$1@sea.gmane.org>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com> <egr3ud$nqm$1@sea.gmane.org> <45340713.6000707@utoronto.ca> <45340949.9070606@shadowen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Cc: bazaar-ng@lists.canonical.com
X-From: git-owner@vger.kernel.org Tue Oct 17 00:53:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZbKM-0003v1-QZ
	for gcvg-git@gmane.org; Tue, 17 Oct 2006 00:52:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161148AbWJPWww (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Oct 2006 18:52:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161150AbWJPWww
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Oct 2006 18:52:52 -0400
Received: from main.gmane.org ([80.91.229.2]:37820 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1161148AbWJPWwv (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Oct 2006 18:52:51 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GZbKD-0003t1-JX
	for git@vger.kernel.org; Tue, 17 Oct 2006 00:52:49 +0200
Received: from host-81-190-17-207.torun.mm.pl ([81.190.17.207])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 17 Oct 2006 00:52:49 +0200
Received: from jnareb by host-81-190-17-207.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 17 Oct 2006 00:52:49 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
Followup-To: gmane.comp.version-control.git
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-17-207.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28991>

Andy Whitcroft wrote:

> Aaron Bentley wrote:
> 
>>>> Git supports renames in its own way; it doesn't use file ids, nor
>>>> remember renames (the new "note" header for use e.g. by porcelains 
>>>> didn't pass if I remember correctly). But it does *detect* moving
>>>> _contents_, and even *copying* _contents_ when requested. And of
>>>> course it detect renames in merges.
>> 
>> You'll note we referred to that bevhavior on the page.  We don't think
>> what Git does is the same as supporting renames.  AIUI, some Git users
>> feel the same way.
> 
> In my experience there are two key features to rename support.  The
> first that files move about efficiently ie. we don't have to carry a
> different copy of the same file for each name it has had, this git
> handles nicely.  The second is the seemless following of history 'back',
> this git does not do trivially (when limited to specific files).  git
> log on a renamed file pretty much stops at the rename point and you have
> deal with it yourself.

Both git log and git diff follows renames (with -M) and even copies 
(with -C), but path _limiter_ doesn't follow renames. There is proposal
to add --follow option to git rev-list to follow specified paths. There was
a patch adding this option here on git mailing list (check archives), not
added because it was fairly intrusive and not complete solution IIRC.

I'd say that the second part is _partially_ supported, as we can follow
history of renamed file with pathlimit, detect that file was renamed, and
follow using previous name as pathlimit. For example if you know all the
names the file had through history, you can get whole history providing all
those names as pathlimit (well, unless there is some conflict like creating
new file with the same name as file before rename; something that all
file-id based solutions have problem with).
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
