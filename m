From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Rename ".dotest/" to ".git/rebase" and ".dotest-merge" to "rebase-merge"
Date: Sun, 20 Jul 2008 00:39:12 +0200
Organization: At home
Message-ID: <g5tqec$73f$1@ger.gmane.org>
References: <73fd69b50807151408i6a916da6p7b89fe81e65fc717@mail.gmail.com> <20080715212211.GL6244@leksak.fem-net> <487D1B3D.70500@lsrfire.ath.cx> <alpine.DEB.1.00.0807160245440.2841@eeepc-johanness> <20080716012619.GM8185@mit.edu> <7viqv5r637.fsf@gitster.siamese.dyndns.org> <4882454D.2080500@free.fr> <7vd4l9zgmp.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 20 00:40:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKL6R-0000Wv-M6
	for gcvg-git-2@gmane.org; Sun, 20 Jul 2008 00:40:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753049AbYGSWjT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jul 2008 18:39:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753382AbYGSWjS
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Jul 2008 18:39:18 -0400
Received: from main.gmane.org ([80.91.229.2]:53743 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753046AbYGSWjS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jul 2008 18:39:18 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KKL5A-0001XE-OC
	for git@vger.kernel.org; Sat, 19 Jul 2008 22:39:16 +0000
Received: from abwn89.neoplus.adsl.tpnet.pl ([83.8.237.89])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 19 Jul 2008 22:39:16 +0000
Received: from jnareb by abwn89.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 19 Jul 2008 22:39:16 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abwn89.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89141>

[This is git@vger.kernel.org only copy]

Junio C Hamano wrote:
> Olivier Marin <dkr+ml.git@free.fr> writes:
> 
>> It tries to apply patches even on a dirty tree which makes difficult
>> to automatically do a "git reset --hard" with --skip or --abort and
>> forces the user to clean the index by hand if last patch failed with
>> unmerged files.
>>
>> So, do some people still use "git am" with a dirty tree or will a
>> patch that make it work like "git rebase" be accepted?
> 
> Anything that changes "am" to require a clean working tree will NEVER be
> accepted.  I personally rely on the ability for it to run in a dirty tree,
> so does Linus.
> 
>       Side note.  Anything that changes "merge" to require a clean
>       working tree is also unacceptable.  Cf.
> 
>       http://thread.gmane.org/gmane.comp.version-control.git/9073/focus=9089
> 
>       Linus talks about "patch" in the paragraph second to the last one
>       in the message; back then he was talking about "git-applymbox" but
>       the same argument there applies to its newer incarnation "git-am".
> 
>       Side note #2.  It would have been nice if "rebase" were also
>       written in such a way that it can work in a dirty tree as long as
>       local changes did not interfere with the operation, but it is a
>       lot more involved.
> 
> When I looked at the "am --abort" patch briefly, I had an impression (by
> reading its test case) that it correctly refrained from doing the
> destructive "reset --hard".

I guess instead of "git reset --hard" we can use here "git stash save
&& git stash apply --index" to save state (perhaps as "git stash save
--no-reset"), and either "git stash drop" at the the end, or 
"git reset --hard && git stash pop --index" at '--abort'.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
