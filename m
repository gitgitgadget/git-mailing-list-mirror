From: walt <wa1ter@myrealbox.com>
Subject: Re: http protocol, cloning git.git, fails (too many open files)
Date: Sun, 13 Nov 2005 16:01:33 -0800
Organization: gmane
Message-ID: <1131926492.14637.5.camel@k9.localnet>
References: <86acg9ijwa.fsf@blue.stonehenge.com>
	 <7vmzk9e9km.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Nov 14 01:05:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EbRpi-0000N7-Dm
	for gcvg-git@gmane.org; Mon, 14 Nov 2005 01:04:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750802AbVKNAEJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 13 Nov 2005 19:04:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750804AbVKNAEJ
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Nov 2005 19:04:09 -0500
Received: from main.gmane.org ([80.91.229.2]:30914 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750802AbVKNAEI (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 13 Nov 2005 19:04:08 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1EbRo9-0008C8-EB
	for git@vger.kernel.org; Mon, 14 Nov 2005 01:02:49 +0100
Received: from adsl-69-234-227-15.dsl.irvnca.pacbell.net ([69.234.227.15])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 14 Nov 2005 01:02:49 +0100
Received: from wa1ter by adsl-69-234-227-15.dsl.irvnca.pacbell.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 14 Nov 2005 01:02:49 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: adsl-69-234-227-15.dsl.irvnca.pacbell.net
In-Reply-To: <7vmzk9e9km.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Evolution 2.4.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11756>

On Sat, 2005-11-12 at 15:21 -0800, Junio C Hamano wrote:
[...]
> However, one thing puzzles me.  I just tried to reproduce it by
> doing this:
> 
> 	$ rm -fr git-http
>         $ ulimit -n 16
>         $ git clone http://www.kernel.org/pub/scm/git/git.git git-http
> 
> and it did not fail on my Linux box...

I've never seen it on Linux, but I do see it on NetBSD every time
with ulimit -n 64 (the default):

> Could you please try with the patch Nick posted (which covers
> less) and then with Pasky's patch?

Neither patch fixes the 'too many open files' error, but Pasky's
patch produces this debugging output:

[...]
progress: 46 objects, 105660 bytes
error: Couldn't create temporary
file .git/objects/ee/baf3aaffa72996ac8bdbc8e9498814cd99f506.temp
for .git/objects/ee/baf3aaffa72996ac8bdbc8e9498814cd99f506: Too many
open files

progress: 48 objects, 108247 bytes
error: fd leakage in release: 9
error: fd leakage in release: 11
error: fd leakage in release: 3
error: fd leakage in release: 13
error: fd leakage in release: 6
error: fd leakage in release: 12
error: fd leakage in release: 14
error: fd leakage in release: 8
error: fd leakage in release: 16
error: fd leakage in release: 15
error: fd leakage in release: 10
error: fd leakage in release: 5
error: fd leakage in release: 21
error: fd leakage in release: 17
error: fd leakage in release: 22
error: fd leakage in release: 19
error: fd leakage in release: 20
error: fd leakage in release: 25
error: fd leakage in release: 26
error: Could not read e8700aa756a3296ede4403db349dc64586935139
Waiting for
http://www.kernel.org/pub/scm/git/git.git/objects/dd/d5823df728bf213425533dcd2e47d61cbccf9e
cg-fetch: objects fetch failed
cg-clone: fetch failed
