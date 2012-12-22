From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: Pushing symbolic references to remote repositories?
Date: Sat, 22 Dec 2012 10:26:32 +0100
Message-ID: <m2ehiiv3nb.fsf@linux-m68k.org>
References: <CAD03jn5ACZyxJM9LEOSJov3BsT3W1N0sV3WYwcerJciMSpmSPA@mail.gmail.com>
	<CAJo=hJvqptfKqM+6J8Ddfb5qcqjAU8bB_JO9VB-XVsCCf64NUQ@mail.gmail.com>
	<7vip7vrof6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Dun Peal <dunpealer@gmail.com>, Shawn Pearce <spearce@spearce.org>,
	Git ML <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 22 10:27:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TmLMO-0005pB-1M
	for gcvg-git-2@plane.gmane.org; Sat, 22 Dec 2012 10:27:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751059Ab2LVJ0q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Dec 2012 04:26:46 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:59444 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750816Ab2LVJ0o (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Dec 2012 04:26:44 -0500
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3YT1YV6MHGz4KK22;
	Sat, 22 Dec 2012 10:26:38 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3YT1YV66yKzbbhf;
	Sat, 22 Dec 2012 10:26:38 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id S6_4erFQ417c; Sat, 22 Dec 2012 10:26:37 +0100 (CET)
X-Auth-Info: 5er4DH+fQF6hn7hNKHB32YReM/wdujzmwnh73SDPVh4=
Received: from linux.local (ppp-88-217-127-54.dynamic.mnet-online.de [88.217.127.54])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Sat, 22 Dec 2012 10:26:37 +0100 (CET)
Received: by linux.local (Postfix, from userid 501)
	id E6C9B1E541F; Sat, 22 Dec 2012 10:26:33 +0100 (CET)
X-Yow: I've got to get these SNACK CAKES to NEWARK by DAWN!!
In-Reply-To: <7vip7vrof6.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Fri, 21 Dec 2012 15:11:25 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.91 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212044>

Junio C Hamano <gitster@pobox.com> writes:

> I think that the only one and a half sensible use cases that
> unconditionally make sense to update symrefs across repositories are
> to update bare.git/HEAD symref:
>
>  - update bare.git/HEAD of a repository that is a local mirror of a
>    more authoritative repository with "git fetch --mirror", in which
>    case you do want to follow what branch is designated as the
>    primary by the project you are mirroring from;
>
>  - update bare.git/HEAD from outside by some means to change which
>    branch is the primary one for the project. Only because your
>    hosting site does not give you an easy way to do so, pushing from
>    another repository that happens to point its HEAD at a different
>    branch seems to be one plausible way to do so, but that does not
>    have to be the only way.

This is not limited to HEAD, any ref may want to be set up as a symref
at a remote repo.  For example, I want to set up a symref master ->
trunk at a repository I have no shell access to.  Without this I get
spurious error whenever I fetch from that remote (where master and trunk
are separate refs) into a local mirror which does have the symref:

>From git://repo.or.cz/emacs
   f0ae89f..5595931  master     -> master
error: Ref refs/heads/trunk is at 559593152b9de5a1c144729e0583fa7968abab22 but expected f0ae89f92326beb3f5a19e90c8f4fe0ab6197926
 ! f0ae89f..5595931  trunk      -> trunk  (unable to update local ref)

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
