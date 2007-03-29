From: Tom Prince <tom.prince@ualberta.net>
Subject: Re: SEGV in git-merge recursive:
Date: Thu, 29 Mar 2007 12:32:19 +0400
Message-ID: <20070329083219.GA6421@hermes>
References: <20070329075010.GA3493@hermes> <81b0412b0703290118q3e602a7bx650ac41241855546@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 29 10:32:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWq3K-0000NN-AA
	for gcvg-git@gmane.org; Thu, 29 Mar 2007 10:32:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751240AbXC2IcL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 29 Mar 2007 04:32:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751260AbXC2IcL
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Mar 2007 04:32:11 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:10520 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751240AbXC2IcJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2007 04:32:09 -0400
Received: by ug-out-1314.google.com with SMTP id 44so453742uga
        for <git@vger.kernel.org>; Thu, 29 Mar 2007 01:32:08 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:date:from:to:cc:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:content-transfer-encoding:in-reply-to:user-agent:sender;
        b=eEySJCXbMZ+ItYzW5KqmEaUlgulkSbjjeTabaOljhoMDXArQ2Yv64vEjPnprdZ7ZgCujiiDypGyHMHBulT/T+APa5lsggX1HP/bL9Lip3wfgp4p6XIeAkcuAPe9yoc/5h4ivsenboF/VF1TEJTItMirQ4UjeHhccXtVzLrNW/IM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:from:to:cc:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:content-transfer-encoding:in-reply-to:user-agent:sender;
        b=SgE9Q62mMrkWSG42mSfkaPifeoZ3+FPl7xbkqtDPfLN9QvXXsk64UNn5of/RTTRmTk4tznhb/cxd6rIbt+67+BPevkbETVpZ1dQ8jBP4zofSQNMWPz9VjHiBi0mqSXAomZJPUxk5nBald+7aOnaJbD+psb8dzJxaTh3imjTOKOY=
Received: by 10.67.91.6 with SMTP id t6mr1035886ugl.1175157128563;
        Thu, 29 Mar 2007 01:32:08 -0700 (PDT)
Received: from hermes ( [80.240.215.209])
        by mx.google.com with ESMTP id e23sm1852780ugd.2007.03.29.01.32.07;
        Thu, 29 Mar 2007 01:32:07 -0700 (PDT)
Received: by hermes (nbSMTP-1.00) for uid 500
	(using TLSv1/SSLv3 with cipher DES-CBC3-SHA (168/168 bits))
	Tom; Thu, 29 Mar 2007 12:32:20 +0400 (MSD)
Mail-Followup-To: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <81b0412b0703290118q3e602a7bx650ac41241855546@mail.gmail.com>
User-Agent: Mutt/1.5.14 (2007-02-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43418>

On Thu, Mar 29, 2007 at 10:18:14AM +0200, Alex Riesen wrote:
> On 3/29/07, Tom Prince <tom.prince@ualberta.net> wrote:
> >I have been keeping my Maildir in git, a non-trivial merge that caus=
es a
> >segfault in git-merge-recursive.
>=20
> Can you try and get a stack trace? Do, for example, GIT_TRACE=3D1 git=
 merge=20
> ...
> ... find the call to git-merge-recursive and start that in gdb.
> Wait until it crash.


Here is the backtrace.

#0  0x0000000000402d29 in sha_eq (a=3D0xfefefefefefefeff <Address 0xfef=
efefefefefeff out of bounds>,
    b=3D0x563cdc "=EF=BF=BD6Cq=EF=BF=BD\234=EF=BF=BDw:0T=EF=BF=BD=EF=BF=
=BD\177=EF=BF=BD\023p\214Q,") at cache.h:259
#1  0x000000000040456e in merge (h1=3D0x553ca0, h2=3D0x553d20, branch1=3D=
0x7fff92e5c27b "HEAD",
    branch2=3D0x7fff92e5c3ee "merge", ca=3D0x5528a0, result=3D0x7fff92e=
5ab90) at merge-recursive.c:1115
#2  0x0000000000405d89 in main (argc=3D-1830435858, argv=3D0x8) at merg=
e-recursive.c:1362

I actually got this backtrace with the following script in git-merge-gd=
b

#!/bin/zsh

exec gdb -x =3D(print run $@) =3Dgit-merge-recursive
