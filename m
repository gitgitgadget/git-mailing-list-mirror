From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH] Respect crlf attribute even if core.autocrlf has not been set
Date: Fri, 25 Jul 2008 18:01:42 +0400
Message-ID: <20080725140142.GB2925@dpotapov.dyndns.org>
References: <7vej5kfs0w.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0807231817460.8986@racer> <488772BC.80207@workspacewhiz.com> <32541b130807231133x37083278u1badd82b5c48e57b@mail.gmail.com> <alpine.DEB.1.00.0807231956280.8986@racer> <FB7ABDC5-8505-4FD1-8082-9BB5013E73C6@orakel.ntnu.no> <alpine.DEB.1.00.0807232041570.8986@racer> <3B9933A6-9637-41AE-9133-9B6EA9204E6B@orakel.ntnu.no> <alpine.DEB.1.00.0807250159420.4140@eeepc-johanness> <E0666371-5C5E-4AA9-B67A-16C42477865B@orakel.ntnu.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Avery Pennarun <apenwarr@gmail.com>,
	Joshua Jensen <jjensen@workspacewhiz.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Eyvind Bernhardsen <eyvind-git@orakel.ntnu.no>
X-From: git-owner@vger.kernel.org Fri Jul 25 16:03:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMNsm-0003qs-JH
	for gcvg-git-2@gmane.org; Fri, 25 Jul 2008 16:02:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751028AbYGYOBw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2008 10:01:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751199AbYGYOBw
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jul 2008 10:01:52 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:2667 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750934AbYGYOBv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2008 10:01:51 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1641860fgg.17
        for <git@vger.kernel.org>; Fri, 25 Jul 2008 07:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=Cj+GfpHVMwv/xvHVlJ3Co9879WhP7VQORYufQ3rIWgo=;
        b=tDpiaBYDCeBX82kFs2geGIBJN7O55dNIGBWKgXVeBacofjh59doxQ+55nygqeRKT9J
         f0KnJhAYaoBQk7RHHZJiPY3JN4BLLikPlWk3vKwqg39Mc0jVOa+oQxgc3kXTmdgogiyI
         TOh3QaV7Ps0esiEbD8c/FkGuk0EYSXHCmWwYE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=eyg9k8qyY1mvEmL2Npx7rGA9hxiQ62EyOIbJFNaf7ST3lNlNg3NmmV+Hr9T3vYqkCT
         UYc1tgwdk8QgSyXYZHODR/ApIjCNQ28d25ztV3Q4UWlFBn1L/uUTA2MNR7JzjQZzSi3W
         QA+/EL1mc+VUdobx/Oc6tE1pYXJ7+zxvINqqU=
Received: by 10.86.26.1 with SMTP id 1mr70291fgz.35.1216994509143;
        Fri, 25 Jul 2008 07:01:49 -0700 (PDT)
Received: from localhost ( [85.141.237.39])
        by mx.google.com with ESMTPS id 4sm5887689fge.5.2008.07.25.07.01.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 25 Jul 2008 07:01:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <E0666371-5C5E-4AA9-B67A-16C42477865B@orakel.ntnu.no>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90051>

On Fri, Jul 25, 2008 at 02:30:16PM +0200, Eyvind Bernhardsen wrote:
> 
> Fair enough.  Did you read the rest of my email to see when I think  
> Git should mess with content?  I've thought about it, and being able  
> to do stuff like this in .gitattributes would work for me:
> 
> * eol=auto
> *.bat eol=crlf
> Makefile eol=lf
> bin/magic-binary eol=none
> 
> I.e. "detect line endings and do CRLF->LF conversion on all files  
> except *.bat (*->CRLF), Makefile (*->LF) and bin/magic-binary (do  
> nothing)".

I suppose "* eol=auto" means to convert CRLF->LF on checkin and
LF->native on checkout?

Also, perhaps, it should be also possible to explicitly specify:
*.txt eol=native
which is the same as 'auto' but without guessing whether it is text
or not.

> ...but "core.autocrlf" is not versioned and applies to _all_  
> repositories, and anyone who doesn't have the correct setting can mess  
> the repository up.

I think the real issue here is not as much about being or not being
versioned, but about forcing and not forcing anything on users.

If we had core.autocrlf=input as default then clueless users will not
checkin files with the incorrect ending. But there is an objection to
that -- you penalize those who always have good endings. And even the
fact that is merely default value that you can easily change to false
does not convince everyone.

The same can be said about your
* eol=auto
It forces conversion on everyone, even on those who do not need it.
Of course, you can say those projects that do not have the problem with
clueless users putting text files with incorrect end-of-lines will not
have lines like that in their .gitattribute. Yet, if I participate in
that project, why do I have to pay the price for this conversion just
because someone stupid can mess up line-endings?

> There's also no way of saying "this file should  
> have LF line endings, even with autocrlf=true".

Actually, there is

*.sh crlf=input

i.e. I want my shell files to have LF even I normally use CRLF for
all other files (on Windows).

> 
> One problem is that the autocrlf setting mixes "I want LF only in my  
> repositories" and "I like to have CRLFs in my working directory" into  
> one config variable.  Instead, I'd like to have a config setting that  
> specifies which line ending form I prefer: "when a text file is marked  
> eol=auto, convert LFs to CRLFs on checkout".

Following your style above, I believe it should be defined as
native-eol=crlf

but there are people who do not want to pay any price for conversion.
Currently, "core.autocrlf=false" means to do nothing about end-of-lines,
and even to ignore setting in .gitattributes. Should it be possible to
disable *any* conversion on checkin and checkout? Should this be that
value be the default, which most users use?

Dmitry
--
If you write a program that any idiot can use, only idiots will use it.
