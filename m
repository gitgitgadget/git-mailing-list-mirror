From: Wincent Colaiuta <win@wincent.com>
Subject: Re: bug? - git-checkout treeish paths  ignores deleted files
Date: Tue, 9 Oct 2007 03:52:15 +0200
Message-ID: <3B0685AB-0725-4473-8AE6-359F93851C10@wincent.com>
References: <470AD21E.6070906@gmail.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 09 03:52:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1If4HF-0004hv-Gf
	for gcvg-git-2@gmane.org; Tue, 09 Oct 2007 03:52:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751911AbXJIBwl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Oct 2007 21:52:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751469AbXJIBwl
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Oct 2007 21:52:41 -0400
Received: from wincent.com ([72.3.236.74]:35265 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751336AbXJIBwk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Oct 2007 21:52:40 -0400
Received: from [192.168.0.129] (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id l991qZvP016659;
	Mon, 8 Oct 2007 20:52:37 -0500
In-Reply-To: <470AD21E.6070906@gmail.com>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60350>

El 9/10/2007, a las 2:58, Mark Levedahl escribi=F3:

> Shouldn't   "git checkout topic path"  make the directory tree =20
> rooted at path identical to what is on branch topic? It doesn't.
>
> Try this:
>
> mkdir test
> cd test
> git init
> touch a b
> git add a b
> git commit -m 'base'
> git checkout -b topic
> git rm a
> git commit -m 'removed a'
> git checkout master
> git checkout topic .
>
> ...and the result is...
> ls
> a   b
>
> instead of
> b

No, the behaviour is correct.

- first you removed the file on the topic branch; at the same time =20
you removed it from your working tree
- then you switched back to the master branch and so the file was =20
added back to your working tree
- then you switched back to the topic branch, and seeing as the file =20
"a" is not being tracked in the topic branch Git doesn't touch it

In general, Git only meddles with stuff that you've told it to track. =20
This is actually a good thing in most cases because it makes some =20
workflows involving dirty trees or trees with untracked content =20
somewhat more convenient.

Cheers,
Wincent
