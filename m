From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: crlf with git-svn driving me nuts...
Date: Thu, 17 Apr 2008 22:53:57 +0400
Message-ID: <20080417185357.GO3133@dpotapov.dyndns.org>
References: <20080416200107.GG3133@dpotapov.dyndns.org> <32541b130804161320w42c68bc2p9d838dc127a57027@mail.gmail.com> <20080416203923.GH3133@dpotapov.dyndns.org> <320075ff0804161447u25dfbb2bmcd36ea507224d835@mail.gmail.com> <20080416223739.GJ3133@dpotapov.dyndns.org> <320075ff0804161607p3f9e983ehb75aae4e0bfe8837@mail.gmail.com> <20080417004645.GK3133@dpotapov.dyndns.org> <320075ff0804170007k5171eb72n68882679f62fa238@mail.gmail.com> <20080417094342.GM3133@dpotapov.dyndns.org> <320075ff0804170309h4232463fk984f362e6cf0a259@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Nigel Magnay <nigel.magnay@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 17 21:18:32 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JmZG0-00068f-Vn
	for gcvg-git-2@gmane.org; Thu, 17 Apr 2008 20:54:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752242AbYDQSyH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Apr 2008 14:54:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752569AbYDQSyG
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Apr 2008 14:54:06 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:55013 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751603AbYDQSyF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Apr 2008 14:54:05 -0400
Received: by nf-out-0910.google.com with SMTP id g13so125984nfb.21
        for <git@vger.kernel.org>; Thu, 17 Apr 2008 11:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        bh=z2m2P3owWjTC5QZ/EUd//8eT2XItFGjP2QUVPddeelU=;
        b=eIpvgiqp+bqnqQ5mPTGQqTSckiqgTdXGXCc+A6Hq9b6Pc4NF+KuFGwD+DyvmIQF+GVWhuuEh601g0wF2+UOS/QKkCdvytfLD2OfZ0CVhbJHKhIv9UVKI7ZrIPvCsoX0mVqvEkLrSWH5RFaIxqppEbXoHItnqMebPZPmvW1byiOA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=OlPnN8BLsh/YFvCNPJNMxrCDWsS06OUi0sUV0YSrg0QF2K5jt0a4HlHUTxxH8ixoHtvsH/9cEpT1eSvBmtRQG1ji8XhB+yUxd5sCoPPUM2lfvflLmFOQiT9gdjBRDBUWbF2CHhg8WdDHatQlIDqFaLXlWjeuP1luDvs5n4YcqMs=
Received: by 10.82.107.3 with SMTP id f3mr2919661buc.0.1208458442113;
        Thu, 17 Apr 2008 11:54:02 -0700 (PDT)
Received: from localhost ( [85.141.148.116])
        by mx.google.com with ESMTPS id z40sm15786841ikz.4.2008.04.17.11.54.00
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 17 Apr 2008 11:54:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <320075ff0804170309h4232463fk984f362e6cf0a259@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79809>

On Thu, Apr 17, 2008 at 11:09:12AM +0100, Nigel Magnay wrote:
>
> Maybe it isn't so bad - all
> svn projects probably *ought* to be using eol=native, but it isn't
> default; 

If you want to have native EOL for each platform then you have to do
this conversion, but it should be applied to only to text files.  So,
the question is how can a VCS know what file is text and what is not.
CVS considers everything what you check-in as text by default. If you
want to put a binary file, you have to use -kb flag, otherwise your file
may be damaged. People tend to be forgetful and some lose their data in
this way. So team SVN team decided to stay on the safe side and put
everything as is, because if you forget to set eol=native, you do not
lose anything and you can set eol=native later. Unfortunately, now SVN
users forget to set eol=native a way too often. So, IMHO, Git approach
based on heuristic is much better when most of stored files are text.

> so maybe it's just easier to coax those projects into fixing
> their svn repos (but of course it's not really an issue for them, so
> it might be a bit of a hard sell).

If they care about support different platforms then it _is_ issue
for them too. On the other hand, if everyone uses Windows with CRLF,
you can do that with Git too just by setting autocrlf=false.

> 
> Yes, in the sense that git is primarily a *nix tool, so it treats LF
> as canon

and perhaps even more important, it is written in C and where LF has
always been considered as EOL since the first Hello-World program was
written in C:

   printf("Hello world!\n");
-----------------------^^

So, naturally LF is considered as EOL inside of Git. Actually, CVS does
so, and even SVN does if you set eol=native.

> and CRLF as somehow 'stupid' (I.E you could make an equally
> valid argument for the reverse position, it just depends on your
> perspective ;-)) ;

There is no good technical reason to have two symbols as the end-of-line
marker instead of one. Most programs on Windows just remove CR when read
from a file and then adding it back before LF when writing it back. So,
CR is clearly redundant.

Dmitry
