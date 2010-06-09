From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH next 2/2] Remove python 2.5'isms
Date: Thu, 10 Jun 2010 00:40:54 +0200
Message-ID: <201006100040.54375.johan@herland.net>
References: <nduJYSHPH3U3cC4hTqPaVi-iLDqB7pemU3zevJMNRmyDsRKmtq_gVu-G9W-She7bPSFG9LafRk0@cipher.nrlssc.navy.mil>
 <nduJYSHPH3U3cC4hTqPaVieVkcHeedXMjA92T_KB9XTSNMZ0NeKHomHE5LPZ65BzOnHb--wYKXY@cipher.nrlssc.navy.mil>
 <AANLkTikmdsJwy06WuRwpLEKzZE45VZcvPDDxnW1OCb8K@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: 7BIT
Cc: Sverre Rabbelier <srabbelier@gmail.com>, davvid@gmail.com,
	Brandon Casey <drafnel@gmail.com>
To: git@vger.kernel.org, Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Thu Jun 10 00:50:07 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMU61-0000xX-Rf
	for gcvg-git-2@lo.gmane.org; Thu, 10 Jun 2010 00:50:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756970Ab0FIWt6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jun 2010 18:49:58 -0400
Received: from smtp.getmail.no ([84.208.15.66]:37150 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756316Ab0FIWt6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jun 2010 18:49:58 -0400
Received: from get-mta-scan02.get.basefarm.net ([10.5.16.4])
 by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L3R001E3R06DX10@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Thu, 10 Jun 2010 00:40:54 +0200 (MEST)
Received: from get-mta-scan02.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id D4C531EA56F5_C101876B	for <git@vger.kernel.org>; Wed,
 09 Jun 2010 22:40:54 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan02.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id A9D1C1EA3FEF_C101876F	for <git@vger.kernel.org>; Wed,
 09 Jun 2010 22:40:54 +0000 (GMT)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L3R003G9R064Y30@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Thu, 10 Jun 2010 00:40:54 +0200 (MEST)
User-Agent: KMail/1.13.3 (Linux/2.6.33-ARCH; KDE/4.4.4; x86_64; ; )
In-reply-to: <AANLkTikmdsJwy06WuRwpLEKzZE45VZcvPDDxnW1OCb8K@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148824>

On Wednesday 09 June 2010, Sverre Rabbelier wrote:
> On Wed, Jun 9, 2010 at 23:24, Brandon Casey <casey@nrlssc.navy.mil> wrote:
> > The following python 2.5 features were worked around:
>
> Thanks for fixing this, although it makes me sad to see the code
> uglify the way it has :P. I guess that's the pain of backwards
> compatibility.

I agree with Sverre's painful acceptance, but I believe something must be 
done with the s/hashlib/sha/ changes.

On my Python v2.6.5. I get the following:

>>> import sha
__main__:1: DeprecationWarning: the sha module is deprecated; use the 
hashlib module instead

This is added to the output of every python program that imports sha. I 
believe we should really try to use the hashlib module when available, and 
only fall back to sha when necessary. Please use something like this 
instead:

  # hashlib is only available in python >= 2.5 
  try: 
      import hashlib 
      _digest = hashlib.sha1 
  except ImportError: 
      import sha
      _digest = sha.sha 

so that we don't get the hideous DeprecationWarning.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
