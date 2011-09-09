From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: merge result
Date: Fri, 09 Sep 2011 15:00:17 +0200
Message-ID: <vpqmxed6fby.fsf@bauges.imag.fr>
References: <CAPgpnMRrSmVrXD__jxv3uNrek8up+scHp+_Kj8+=HX8tfweWzQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Lynn Lin <lynn.xin.lin@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 09 15:00:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R20hB-0001cL-Pj
	for gcvg-git-2@lo.gmane.org; Fri, 09 Sep 2011 15:00:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758869Ab1IINA1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Sep 2011 09:00:27 -0400
Received: from mx1.imag.fr ([129.88.30.5]:45470 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758817Ab1IINAY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Sep 2011 09:00:24 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id p89CxC97012738
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 9 Sep 2011 14:59:12 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1R20gr-0004JT-7N; Fri, 09 Sep 2011 15:00:17 +0200
In-Reply-To: <CAPgpnMRrSmVrXD__jxv3uNrek8up+scHp+_Kj8+=HX8tfweWzQ@mail.gmail.com>
	(Lynn Lin's message of "Fri, 9 Sep 2011 18:54:21 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 09 Sep 2011 14:59:12 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p89CxC97012738
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1316177957.09038@Oe0L1Z5dWXa2ONvi6cs/sQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181059>

Lynn Lin <lynn.xin.lin@gmail.com> writes:

> Hi All,
>    When I merge branch A back to master branch,if there are same
> commit(developer do double commit) both in master and A branch, there
> will be two same commit in master branch.

They cannot be the "same" commit. They are different commits (i.e.
different sha1 identifier, and probably different trees), even though
they may have the same commit message and represent the same diff.

>    1->2->3-4>5        Master
>        |
>        4->6->7          A

A more accurate drawing would be

    1->2->3-4>5        Master
        |
        4'->6->7          A

and after merging, you'd get

    1->2->3-4>5-->8  A, master
        |       /
        4'->6->7

with 8 having both 4 and 4' as ancestors. There's nothing wrong with it.
Git cannot remove either 4 or 4' without rewritting history, and "git
merge" does not rewrite history.

If you really really want to avoid this duplication in the history, then
learn about rebase (which is both powerfull and dangerous, you've been
warned).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
