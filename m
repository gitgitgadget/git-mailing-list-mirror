From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] Add a new lstat and fstat implementation based on Win32 API
Date: Tue, 04 Sep 2007 10:53:07 +0200
Message-ID: <86tzqag6bw.fsf@lola.quinscape.zz>
References: <46DACD93.9000509@trolltech.com> <46DACE0D.5070501@trolltech.com>
	<46DBBC1E.4010407@eudaptics.com> <46DBFA2A.7050003@trolltech.com>
	<Pine.LNX.4.64.0709031428080.28586@racer.site>
	<46DC5ED4.8050202@trolltech.com> <46DD0C16.70101@eudaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 04 10:53:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISUA1-0000iq-Ei
	for gcvg-git@gmane.org; Tue, 04 Sep 2007 10:53:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753760AbXIDIxT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Sep 2007 04:53:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753764AbXIDIxT
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Sep 2007 04:53:19 -0400
Received: from main.gmane.org ([80.91.229.2]:45358 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752263AbXIDIxS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2007 04:53:18 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1ISU9p-0003pZ-HE
	for git@vger.kernel.org; Tue, 04 Sep 2007 10:53:13 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 04 Sep 2007 10:53:13 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 04 Sep 2007 10:53:13 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Cancel-Lock: sha1:VPJBNs4GxICKz7OADv10pgjCSCg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57543>

Johannes Sixt <j.sixt@eudaptics.com> writes:

> Marius Storm-Olsen schrieb:
>> Johannes Schindelin wrote:
>>> To make it easier on others, I just uploaded it into the "teststat"
>>> branch on 4msysgit.git (subject to removal in a few days).
>>
>> Ok, I've updated the patch in the 4msysgit.git repo, 'teststat' branch.
>> RFC, and please test.
>
> Thanks a lot! I've pushed it out in mingw.git's master.
>
> The reason that t4200-rerere.sh fails is that we now store UTC in
> st_mtime. However, for the garbage-collection we compare this entry
> to a local time stamp. Therefore, I've pushed out a fixup patch at
> the top of mingw.git's devel branch that converts mtime to local
> time
> (http://repo.or.cz/w/git/mingw.git?a=commitdiff;h=1b62ecb31068af06c2fa7664f06c6c36316aac2c). Would
> you kindly conduct the performance test with this patch? I'm afraid
> that this makes us substantially slower.

Wouldn't it make more sense to convert local time to mtime?  That's
one conversion per second at most rather than one conversion per file.

-- 
David Kastrup
