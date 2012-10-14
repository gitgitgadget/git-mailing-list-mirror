From: "Lauri Alanko" <la@iki.fi>
Subject: Re: A design for subrepositories
Date: Sun, 14 Oct 2012 13:19:28 +0300
Message-ID: <20121014131928.25943ezwa6fveyls.lealanko@webmail.helsinki.fi>
References: <20121013163322.685276teuhqhjc82.lealanko@webmail.helsinki.fi>
	<7vd30m2sbr.fsf@alter.siamese.dyndns.org>
	<20121014002304.14167k2j2ctspiuw.lealanko@webmail.helsinki.fi>
	<7vzk3p1xh3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; DelSp="Yes"; format="flowed"
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 14 12:19:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNLIU-0006Yd-Hj
	for gcvg-git-2@plane.gmane.org; Sun, 14 Oct 2012 12:19:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752200Ab2JNKTi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Oct 2012 06:19:38 -0400
Received: from smtp-rs1-vallila2.fe.helsinki.fi ([128.214.173.75]:56972 "EHLO
	smtp-rs1-vallila2.fe.helsinki.fi" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752175Ab2JNKTh convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Oct 2012 06:19:37 -0400
Received: from webmail.helsinki.fi (webmail1-vallila2.fe.helsinki.fi [128.214.173.135])
	by smtp-rs1.it.helsinki.fi (8.14.4/8.14.4) with ESMTP id q9EAJSgM031530;
	Sun, 14 Oct 2012 13:19:29 +0300
Received: from scan-proxy1-1.it.helsinki.fi (scan-proxy1-1.it.helsinki.fi
	[128.214.2.137]) by webmail.helsinki.fi (Horde Framework) with HTTP; Sun,
	14 Oct 2012 13:19:28 +0300
In-Reply-To: <7vzk3p1xh3.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
User-Agent: Internet Messaging Program (IMP) 4.2.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207650>

Quoting "Junio C Hamano" <gitster@pobox.com>:

>> If the
>> submodules ever get reorganized and foo is moved to ./bar, then it is
>> impossible to check out older versions or alternate branches, since
>> the submodule is no longer where it is expected to be at the origin.
>
> Isn't that exactly what the "module name" vs "module path" mapping
> in .gitmodules file is meant to address?

Yes, and as I showed after the part you quoted, it is possible to  
refer to a module by name, although it looks like such a hack that I  
can't imagine it's currently something that git-submodule is intended  
to support.

>> But still, "git submodule update" only looks at the modules in the
>> currently checked-out tree. If we have other branches or old tags that
>> refer to other submodules, there's no simple way to fetch those, too.

> Didn't I already suggest you to think about how you can improve
> existing "git submodule" to suit your use case better?

Yes, and I listed three possible ways. Two of them seem technically  
unattractive, whereas one of them (submodules as ref directories)  
seems like a huge change that could introduce incompatibilities. That  
is why a separate tool seems like a cleaner choice.

If you want enhancements to git-submodule, at least deign to comment  
on the issues above.

There is actually a fourth alternative: extend the git protocol so  
that a remote repository could be queried for its list of submodules.  
But this seems particularly icky: git is at its core such a low-level  
framework. Nested repositories are such a high-level concept that  
something is wrong if the core needs specialized support for it. The  
ref directories approach, on the other hand, is completely transparent  
to standard tools.


Lauri
