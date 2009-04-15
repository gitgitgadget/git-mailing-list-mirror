From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: git-new-workdir not working right?
Date: Wed, 15 Apr 2009 13:22:48 +0100 (BST)
Message-ID: <alpine.LNX.2.00.0904151310140.11773@reaper.quantumfyre.co.uk>
References: <81bfc67a0904132109k45f09f79s21ce3132ade02001@mail.gmail.com> <alpine.LNX.2.00.0904141540410.29027@reaper.quantumfyre.co.uk> <81bfc67a0904150331t6787fcfbjd391013a8235ece0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811584-1688424811-1239798168=:11773"
Cc: git@vger.kernel.org
To: Caleb Cushing <xenoterracide@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 15 14:24:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lu4Ac-0008Jd-TI
	for gcvg-git-2@gmane.org; Wed, 15 Apr 2009 14:24:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759327AbZDOMXR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Apr 2009 08:23:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759033AbZDOMXQ
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Apr 2009 08:23:16 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:33086 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758474AbZDOMXP (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Apr 2009 08:23:15 -0400
Received: from neutron.quantumfyre.co.uk (quantumfyre.force9.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id B5995131D6C
	for <git@vger.kernel.org>; Wed, 15 Apr 2009 13:23:13 +0100 (BST)
Received: (qmail 32173 invoked by uid 103); 15 Apr 2009 13:22:48 +0100
Received: from quantumfyre.force9.co.uk by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-2.05st 
 (clamdscan: 0.94.2/9237. spamassassin: 3.2.1. perlscan: 2.05st.  
 Clear:RC:1(212.159.54.234):. 
 Processed in 0.038716 secs); 15 Apr 2009 12:22:48 -0000
Received: from quantumfyre.force9.co.uk (212.159.54.234)
  by quantumfyre.force9.co.uk with SMTP; 15 Apr 2009 13:22:48 +0100
X-X-Sender: jp3@reaper.quantumfyre.co.uk
In-Reply-To: <81bfc67a0904150331t6787fcfbjd391013a8235ece0@mail.gmail.com>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116608>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811584-1688424811-1239798168=:11773
Content-Type: TEXT/PLAIN; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Wed, 15 Apr 2009, Caleb Cushing wrote:

> On Tue, Apr 14, 2009 at 10:47 AM, Julian Phillips
> <julian@quantumfyre.co.uk> wrote:
>> Works fine for me.  Are you sure you didn't have a typo in your original
>> git-new-workdir invocation?  If so, could you supply:
>>
>>  1) the complete output of running git-new-workdir
>>  2) the output of "git rev-parse --git-dir" run in path/to/repo/.git
>>
>> Also, you shouldn't need to supply the .git, so "git new-workdir
>> path/to/repo newworkdirname" should also work, have you tried that?
>>
>
> git-new-workdir portage/ test
> /home/port/portdev/.bin/git-new-workdir: line 58: cd:
> /home/port/portdev/tree/portage
> .git: No such file or directory
> /home/port/portdev/tree/test
> cp: cannot stat `/home/port/portdev/tree/HEAD': No such file or directory
> fatal: Not a git repository (or any of the parent directories): .git
>
> git-new-workdir portage/.git/ test
> /home/port/portdev/.bin/git-new-workdir: line 58: cd:
> /home/port/portdev/tree/portage/.git
> .: No such file or directory
> /home/port/portdev/tree/test
> cp: cannot stat `/home/port/portdev/tree/HEAD': No such file or directory
> fatal: Not a git repository (or any of the parent directories): .git
>
> git rev-parse --git-dir portage/
> fatal: Not a git repository (or any of the parent directories): .git
>
> cd portage/
> /home/port/portdev/tree/portage
> slave-iv portage $ git rev-parse --git-dir .
> .git
> .
>
> git-new-workdir . ../test/ << seems to work too.
>

*sighs* oh yes, that old chestnut ...

You're exporting CDPATH, this variable shouldn't be exported.  This is 
likely to cause random shell scripts to break.

Alternatively, Putting "unset CDPATH" at the beginning of git-new-workdir 
should fix it.

This has come up a number of times in the past on the git list.  See, for 
example:

http://thread.gmane.org/gmane.comp.version-control.git/52177/focus=52268

-- 
Julian

  ---
English literature's performing flea.
 		-- Sean O'Casey on P.G. Wodehouse
---1463811584-1688424811-1239798168=:11773--
