From: Adam Piatyszek <ediap@users.sourceforge.net>
Subject: Re: Why does git track directory listed in .gitignore/".git/info/exclude"?
Date: Wed, 30 Jan 2008 13:35:05 +0100
Message-ID: <47A06EF9.60704@users.sourceforge.net>
References: <6bc632150801230554l3b24e1e4lb4641bf7c16857c0@mail.gmail.com> <6bc632150801230604p2589c893pa05bb6f27e482de8@mail.gmail.com> <alpine.LFD.1.00.0801231313590.2803@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: pradeep singh rautela <rautelap@gmail.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Jan 30 13:46:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JKCKV-0004YL-O8
	for gcvg-git-2@gmane.org; Wed, 30 Jan 2008 13:46:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754994AbYA3Mpm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jan 2008 07:45:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753343AbYA3Mpm
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jan 2008 07:45:42 -0500
Received: from ananke.et.put.poznan.pl ([150.254.29.121]:59809 "EHLO
	ananke.et.put.poznan.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751480AbYA3Mpl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jan 2008 07:45:41 -0500
Received: from hydrus.et.put.poznan.pl (hydrus.et.put.poznan.pl [150.254.11.145])
	by ananke.et.put.poznan.pl (8.13.8/8.13.8) with ESMTP id m0UCe2pQ026455;
	Wed, 30 Jan 2008 13:40:43 +0100 (CET)
	(envelope-from ediap@users.sourceforge.net)
Received: from [150.254.11.73] (pc1073.et.put.poznan.pl [150.254.11.73])
	by hydrus.et.put.poznan.pl (8.11.7p1+Sun/8.11.6) with ESMTP id m0UCZ5D06103;
	Wed, 30 Jan 2008 13:35:06 +0100 (MET)
User-Agent: Thunderbird 2.0.0.9 (X11/20071116)
In-Reply-To: <alpine.LFD.1.00.0801231313590.2803@woody.linux-foundation.org>
X-Enigmail-Version: 0.95.6
OpenPGP: id=1F115CCB
X-PMX-Version: 5.3.3.310218, Antispam-Engine: 2.5.2.313940, Antispam-Data: 2008.1.30.42651
X-PerlMx-Spam: Gauge=IIIIIII, Probability=7%, Report='__CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __SANE_MSGID 0, __USER_AGENT 0'
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72056>

* Linus Torvalds [23 I 2008 22:17]:
> On Wed, 23 Jan 2008, pradeep singh rautela wrote:
>> But i still would like to ask git gurus here.
>> Isn't it fine to include a directory name as
>>
>>    $directory_name/
>>     instead of
>>    $directory_name/*
> 
> Heh.
> 
> I think your problem is that "/" itself. By adding it, the exclude 
> information does *not* match the directory entry itself (because the 
> directory entry itself is called just "xen-3.1.0-src" - note no slash!), 
> and since you added it, it also doesn't match any names _under_ that 
> directory exactly.
> 
> So what you *should* have done is to just tell git to ignore the directory 
> named "xen-3.1.0-src", and you'd have been ok.
> 
> Using "xen-3.1.0-src/*" works too, but it is heavy-handed and unnecessary.

Hi Linus, Pradeep and All,

In my opinion, the exclude matching routine should convert "dir/" to 
"dir", especially that the "git status" command lists untracked 
directories with the trailing slash "/", e.g:

   ediap@lespaul ~/git/acm_ofdm $ git status
   # On branch master
   # Untracked files:
   #   (use "git add <file>..." to include in what will be committed)
   #
   #       ldpc13.bm
   #       results/

So, most newbies will try to add "dir/" to .gitignore or 
.git/info/exclude instead of "dir" in such a case.

Can you seen any drawbacks of such modification?

BR,
/Adam

-- 
.:.  Adam Piatyszek (ediap)  .:.....................................:.
.:.  ediap@users.sourceforge.net  .:................................:.
