From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Problem with large files on different OSes
Date: Wed, 27 May 2009 19:30:28 +0200
Message-ID: <200905271930.30496.jnareb@gmail.com>
References: <submission.1M9Gk0-0000N8-MQ@mail.cs.st-andrews.ac.uk> <alpine.LFD.2.01.0905270942580.3435@localhost.localdomain> <submission.1M9Mpl-0001CW-M0@mail.cs.st-andrews.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Christopher Jefferson <caj@cs.st-andrews.ac.uk>
X-From: git-owner@vger.kernel.org Wed May 27 19:30:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9Mxg-000066-0Z
	for gcvg-git-2@gmane.org; Wed, 27 May 2009 19:30:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756789AbZE0Rae (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2009 13:30:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754997AbZE0Rad
	(ORCPT <rfc822;git-outgoing>); Wed, 27 May 2009 13:30:33 -0400
Received: from mail-fx0-f168.google.com ([209.85.220.168]:53850 "EHLO
	mail-fx0-f168.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754554AbZE0Rad (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2009 13:30:33 -0400
Received: by fxm12 with SMTP id 12so3080709fxm.37
        for <git@vger.kernel.org>; Wed, 27 May 2009 10:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=jQgqMXQmM6vgfJOnJLf6HY057FmgsptiOSNUqUBo3TU=;
        b=XPoGaIh98cA8BNXm0e0jbohiE1bwRaYRO8O5JauF86Qmr1UCrz6JrOOytSq3P1KFOh
         bXzh2gToKURv8tDKjxI3PDYDT1CZL2eQ5oefcBKUQGzm9uGlbSdhGxlyHV9xIS65aK+k
         iMto7B1ZUsIRwV8KrgJQH2z+3+jMNcEGaiuFs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=nkbXABKcmKkDss6bbhV1iXh52Vx8AEwRYLF8T//2ehl8zb5snUwvzDH9aJ9ShcrrOj
         atfb/x8SrXdtI8gwRO/ECLjkhyKqbAgwR2gScabPMpwyobdlCGIgzLqiZW+8WNEVyvVs
         Cduc9pYgTj95ct2y0zlwv5Rgs7NP2Uh+utqOQ=
Received: by 10.86.68.1 with SMTP id q1mr493312fga.10.1243445433908;
        Wed, 27 May 2009 10:30:33 -0700 (PDT)
Received: from ?192.168.1.13? (abvl57.neoplus.adsl.tpnet.pl [83.8.209.57])
        by mx.google.com with ESMTPS id 4sm3218363fge.28.2009.05.27.10.30.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 27 May 2009 10:30:32 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <submission.1M9Mpl-0001CW-M0@mail.cs.st-andrews.ac.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120081>

On Wed, 27 May 2009, Christopher Jefferson wrote:
> On 27 May 2009, at 17:59, Linus Torvalds wrote:
>> On Wed, 27 May 2009, Linus Torvalds wrote:
>>>
>>> I'll see if I can make us handle the "big file without diff" case  
>>> better by chunking.
 
>> So "don't do it then" or "make sure you are 64-bit and have lots of
>> memory if you do it" may well be the right solution.
> 
> Thank you for that description of the problem, I can see how hard it is.
> 
> Perhaps it might be useful to think about how to codify "don't do it  
> then" in a reasonably simple, automatic way?
> 
> I've been trying to write a pre-commit hook (I think that's the right  
> place?) which would refuse commits larger than some file size (512MB  
> as a random number I decided), but am having trouble getting it to  
> work right, and generally. Would such a thing be easy, and would that  
> be the right place to put it?
> 
> While I wouldn't suggest this become default, providing such a hook,  
> and describing why you might want to use it, would seem to avoid the  
> accidental part of the problem.

Hmmm... this is another issue (beside checking for portability of
filenames) that would be neatly solved if there was 'pre-add' hook,
rather than trying to use 'pre-commit' hook for that.  It should not,
I think, be that hard to add it...

-- 
Jakub Narebski
Poland
