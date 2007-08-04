From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: Terminology question about remote branches.
Date: Sat, 4 Aug 2007 18:19:26 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708041804260.13596@beast.quantumfyre.co.uk>
References: <854pjfin68.fsf@lola.goethe.zz> <20070804120243.GB9716@coredump.intra.peff.net>
 <85tzrfh3yg.fsf@lola.goethe.zz> <8c5c35580708040607ya186edcg89fbc90587b64d68@mail.gmail.com>
 <85r6mjdyl8.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Lars Hjemli <lh@elementstorage.no>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Sat Aug 04 19:19:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHNHu-0006Cp-Le
	for gcvg-git@gmane.org; Sat, 04 Aug 2007 19:19:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932400AbXHDRTa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Aug 2007 13:19:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932215AbXHDRTa
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Aug 2007 13:19:30 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:32770 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932389AbXHDRT2 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Aug 2007 13:19:28 -0400
Received: from neutron.quantumfyre.co.uk (neutron.datavampyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id 15CB2B8D88
	for <git@vger.kernel.org>; Sat,  4 Aug 2007 18:19:27 +0100 (BST)
Received: (qmail 27491 invoked by uid 103); 4 Aug 2007 18:19:26 +0100
Received: from 192.168.0.7 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.91/3852. spamassassin: 3.2.1. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.7):. 
 Processed in 0.031031 secs); 04 Aug 2007 17:19:26 -0000
Received: from beast.quantumfyre.co.uk (192.168.0.7)
  by neutron.datavampyre.co.uk with SMTP; 4 Aug 2007 18:19:26 +0100
X-X-Sender: jp3@beast.quantumfyre.co.uk
In-Reply-To: <85r6mjdyl8.fsf@lola.goethe.zz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54885>

On Sat, 4 Aug 2007, David Kastrup wrote:

> "Lars Hjemli" <lh@elementstorage.no> writes:
>
>> The magic setup that makes this happen is the following lines in .git/config:
>>
>> [remote "origin"]
>>         url = git://git.kernel.org/pub/scm/git/git.git
>>         fetch = +refs/heads/*:refs/remotes/origin/*
>>
>> [branch "master"]
>>         remote = origin
>>         merge = refs/heads/master
>>
>>
>> Was this helpful?
>
> It would be helpful.  Except that nothing whatsoever can be found in
> .git/config concerning my local and my remote tracking branches.  So
> where is that information _really_ hidden away?

It really is in .git/config, _provided_ that your repo was created by 
1.5.0 or newer.  Older versions had a more distributed setup using files 
in .git/remotes/ and .git/branches/

> .git/FETCH_HEAD maybe?

Nope, that's just information about what got fetched last.  A purely 
temporary thing.

> It also appears that doing
>
> git-checkout --track -b mybranch origin
>
> on a git.git clone does _not_ create a tracking branch.  I can't
> figure out what I could specify as an origin to create a tracking
> branch that would get reflected in .git/FETCH_HEAD.

With pre 1.5 you didn't get remote tracking branches in a separate 
namespace.  The default was to have a local branch called origin which was 
the "remote tracking branch" for the master branch - but this wasn't 
enforced.  So with your repo the origin branch _is_ the remote tracking 
branch ... or at least the closet a pre 1.5 setup gets.

> What gives?

It would appear that your repo was created with an old version of git. 
Which also explains why you were talking about origin as a branch - which 
it used to be (a real local branch too ...), rather than as a remote - 
which it is now.

The whole remotes/tracking mechanism changed in 1.5.0 - now it's much more 
flexible (and probably more complicated too).

-- 
Julian

  ---
Ever notice that even the busiest people are never too busy to tell you
just how busy they are?
