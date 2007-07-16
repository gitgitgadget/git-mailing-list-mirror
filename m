From: David Kastrup <dak@gnu.org>
Subject: Re: "git clone" executed as root on solaris 10 shreds UFS (it ispossible to create hardlinks for directories as root under solaris)
Date: Mon, 16 Jul 2007 21:57:04 +0200
Organization: Organization?!?
Message-ID: <85644knmun.fsf@lola.goethe.zz>
References: <20070716100803.GA24036@cip.informatik.uni-erlangen.de> <20070716134529.GC26675@cip.informatik.uni-erlangen.de> <469B821E.85E5EDA9@eudaptics.com> <20070716154559.GD19073@lavos.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 16 21:57:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAWhB-0008Ob-0m
	for gcvg-git@gmane.org; Mon, 16 Jul 2007 21:57:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762201AbXGPT5V (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Jul 2007 15:57:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762052AbXGPT5V
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jul 2007 15:57:21 -0400
Received: from main.gmane.org ([80.91.229.2]:53435 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761806AbXGPT5U (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jul 2007 15:57:20 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IAWh0-0007I3-CS
	for git@vger.kernel.org; Mon, 16 Jul 2007 21:57:14 +0200
Received: from dslb-084-061-090-188.pools.arcor-ip.net ([84.61.90.188])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 16 Jul 2007 21:57:14 +0200
Received: from dak by dslb-084-061-090-188.pools.arcor-ip.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 16 Jul 2007 21:57:14 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: dslb-084-061-090-188.pools.arcor-ip.net
X-Face: 2FEFf>]>q>2iw=B6,xrUubRI>pR&Ml9=ao@P@i)L:\urd*t9M~y1^:+Y]'C0~{mAl`oQuAl
 \!3KEIp?*w`|bL5qr,H)LFO6Q=qx~iH4DN;i";/yuIsqbLLCh/!U#X[S~(5eZ41to5f%E@'ELIi$t^
 Vc\LWP@J5p^rst0+('>Er0=^1{]M9!p?&:\z]|;&=NP3AhB!B_bi^]Pfkw
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Cancel-Lock: sha1:JWWcyXfd3CkHxcyMlvmlsZ0voy0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52710>

bdowning@lavos.net (Brian Downing) writes:

> On Mon, Jul 16, 2007 at 04:35:10PM +0200, Johannes Sixt wrote:
>> It tries to remove a *file* that is in the way and create the directory
>> in its place. But since your unlink() behaves incorrectly (it is
>> supposed to *fail* for directories), the logic does not quite work as
>> expected - it mistakes the directory for a file.
>
> http://www.opengroup.org/onlinepubs/007908799/xsh/unlink.html
>
> | The path argument must not name a directory unless the process has
> | appropriate privileges and the implementation supports using unlink() on
> | directories.

Isn't it funny?  The problem with the git code is that the path
argument must not name a directory _if_ the process has appropriate
privileges and the implementation supports using unlink() on
directories.

Failure is not an option, it is a requirement.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
