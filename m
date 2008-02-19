From: Dane Jensen <careo@fastmail.fm>
Subject: Re: [Bug] Segfault in git status
Date: Tue, 19 Feb 2008 15:18:51 -0800
Message-ID: <746D851F-CE49-4867-BB0B-D09615463244@fastmail.fm>
References: <F8D3F7F0-3A98-4576-BD89-6E5C682B351C@fastmail.fm> <7vfxvpn3da.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 20 00:19:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRbkJ-0003VT-IE
	for gcvg-git-2@gmane.org; Wed, 20 Feb 2008 00:19:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751833AbYBSXS5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2008 18:18:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751368AbYBSXS5
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Feb 2008 18:18:57 -0500
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:39049 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751261AbYBSXS4 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Feb 2008 18:18:56 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 6098D9291D;
	Tue, 19 Feb 2008 18:18:55 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Tue, 19 Feb 2008 18:18:55 -0500
X-Sasl-enc: rYloFuncoLc9l0AgrM074kLP6FMYjp1PTqLza0s1YqH+ 1203463135
Received: from [192.168.1.146] (unknown [208.71.31.193])
	by mail.messagingengine.com (Postfix) with ESMTP id DE2512F0C9;
	Tue, 19 Feb 2008 18:18:54 -0500 (EST)
In-Reply-To: <7vfxvpn3da.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74473>


On Feb 18, 2008, at 5:26 PM, Junio C Hamano wrote:

> Dane Jensen <careo@fastmail.fm> writes:
>
>> This was in OS X 10.5.2 with git compiled from cf5c51e. Falling back
>> to 1.5.4.2 cleared it up, so with the help of git bisect I've  
>> narrowed
>> the bug down to cf55870.
>
> Do you have this issue only on OSX?  Do you have the issue on
> any commit, or a particular commit?

It's not with any particular commit. It occurs with a fresh clone or  
at any other point, regardless of any changes I've made, what branch  
I'm on, or anything else I could think of testing.

> What does the change between HEAD, index and the work tree
> involve in the commit that causes the problem?  Can you make
> repository available to the public for diagnosis (if it is "Only
> on OSX", I may not be able to help much with, but never hurt to
> ask)?

Unfortunately not. I'll try to see if I can't cook up a test case that  
reproduces it however.

> Just to double check, can you see if reverting the commit (and
> another commit that immediately follows) fixes the issue for
> you?
>
> A patch to do the revert for cf5c51e is attached.

The patch does indeed fix it.

Additionally, now that I see the output of a successful run right  
after a failed one, it appears that git-status is dying before listing  
untracked files. It will output the "Changed but not updated:"  
section, but then die before getting to "Untracked files:".

-Dane
