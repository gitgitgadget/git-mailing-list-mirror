From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [1.8.0] Provide proper remote ref namespaces
Date: Sun, 06 Feb 2011 09:09:26 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1102060900570.12104@xanadu.home>
References: <AANLkTi=yFwOAQMHhvLsB1_xmYOE9HHP2YB4H4TQzwwc8@mail.gmail.com>
 <201102050218.44325.johan@herland.net>
 <20110205214045.GA15668@dpotapov.dyndns.org>
 <201102060104.37146.johan@herland.net>
 <AANLkTikmD8qZOE+hi1=aeeVJx2qQpzdm0tV1mLsx1tfB@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jeff King <peff@peff.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 06 15:09:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pm5J0-0002j5-9F
	for gcvg-git-2@lo.gmane.org; Sun, 06 Feb 2011 15:09:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752697Ab1BFOJ2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Feb 2011 09:09:28 -0500
Received: from relais.videotron.ca ([24.201.245.36]:64813 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752633Ab1BFOJ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Feb 2011 09:09:27 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MR-MRZ22.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0LG7009BS8NQSY70@VL-MR-MRZ22.ip.videotron.ca> for
 git@vger.kernel.org; Sun, 06 Feb 2011 09:09:27 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <AANLkTikmD8qZOE+hi1=aeeVJx2qQpzdm0tV1mLsx1tfB@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166146>

On Sun, 6 Feb 2011, Dmitry Potapov wrote:

> To me, the proper handling ambiguity means that when I do "git fetch" I
> immediately see warning about tag clashes.

Fair enough.

> So, I agree with you that
> current behavior is not good, but I disagree with you about having many
> namespaces, because it postpones detection of the conflict until I try
> to use.

No.  The later does not prevent the former.

> And well, git may detect ambiguity when I say "git show v1.0",
> but if I look at my branch in gitk and see "v1.0" and may say to someone
> that I use "v1.0" but that person looks at his tree and sees "v1.0" as
> something different.

If gitk is smart enough to see that two tags have the same name then it 
should scope them so they are not ambiguous anymore, unless of course 
they are referring to the same thing in which case they are not 
ambiguous from the start.

> So, if there is two different tags with the same name, it is better to
> report the problem as soon as possible, i.e. during "git fetch", and
> then there is no reason to have separate namespaces for tags.

Of course there is a reason.  What if your fetch brings in hundreds of 
tags (this is common for some projects) and then you want to remove that 
fetched branch from your repository?  How do you determine which tag 
came from that remote repository and which tags are to be kept?  Without 
a separate namespace this is practically impossible.


Nicolas
