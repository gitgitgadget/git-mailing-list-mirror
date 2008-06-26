From: Michael J Gruber <michaeljgruber+gmane@fastmail.fm>
Subject: Re: update-index --assume-unchanged doesn't make things go fast
Date: Thu, 26 Jun 2008 10:47:09 +0200
Message-ID: <g3vl2l$qn7$1@ger.gmane.org>
References: <32541b130806250944x717cf609x7aa520c77a7c6911@mail.gmail.com>	 <g3tvqd$2jj$1@ger.gmane.org> <32541b130806251102l6e71a050o82fbd4f272d1d23f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 26 10:48:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBn9Y-0002YM-Da
	for gcvg-git-2@gmane.org; Thu, 26 Jun 2008 10:48:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756703AbYFZIra (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jun 2008 04:47:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756595AbYFZIra
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jun 2008 04:47:30 -0400
Received: from main.gmane.org ([80.91.229.2]:35934 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755762AbYFZIr2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jun 2008 04:47:28 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KBn8X-00076x-J9
	for git@vger.kernel.org; Thu, 26 Jun 2008 08:47:25 +0000
Received: from whitehead.math.tu-clausthal.de ([139.174.44.12])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 26 Jun 2008 08:47:25 +0000
Received: from michaeljgruber+gmane by whitehead.math.tu-clausthal.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 26 Jun 2008 08:47:25 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: whitehead.math.tu-clausthal.de
User-Agent: Thunderbird 2.0.0.14 (X11/20080421)
In-Reply-To: <32541b130806251102l6e71a050o82fbd4f272d1d23f@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86418>

Avery Pennarun venit, vidit, dixit 25.06.2008 20:02:
> On 6/25/08, Michael J Gruber <michaeljgruber+gmane@fastmail.fm> wrote:
>>> 4) My idea is to eventually --assume-unchanged my whole repository,
>>> then write a cheesy daemon that uses the Win32 dnotify-equivalent to
>>> watch for files that get updated and then selectively
>>> --no-assume-unchanged files that it gets notified about.  That would
>>> avoid the need to ever synchronously scan the whole repo for changes,
>>> thus making my git-Win32 experience much faster and more enjoyable.
>>> (This daemon ought to be possible to run on Linux as well, for similar
>>> improvements on gigantic repositories.  Also note that TortoiseSVN for
>>> Windows does something similar to track file status updates, so this
>>> isn't *just* me being crazy.)
>>  Looks like users on slow NFS would profit, too. Hate to say it, but hg
>> feels faster on (slow) NFS than git. Yet I use git, for other reasons ;)
> 
> Hmm, can you do dnotify over NFS?
> 
> I'd like to know how hg goes any faster.  As far as I can see, git is
> going as fast as can be without some kind of daemon or other magic.
> (Except for my point #3, which seems relatively minor.)

I haven't done any measurements, maybe I should; getting consistent 
results would require setting up an isolated NFS environment, though.

The thing is that hg is very careful about serializing and minimizing 
disk I/O, whereas git is very clever about delegating stuff to the 
kernel and processing data efficiently. In my work environment I have to 
keep my repos on NFS. For heavy history rewriting I resort to /tmp or 
/dev/shm temporarily. But git status is kinda slow on NFS. I don't know 
about [di]?notify over NFS.

Michael
