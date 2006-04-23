From: David Woodhouse <dwmw2@infradead.org>
Subject: git-clone --reference problem?
Date: Sun, 23 Apr 2006 17:34:40 +0100
Message-ID: <1145810080.16166.223.camel@shinybook.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sun Apr 23 18:34:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FXhXb-0001SF-6l
	for gcvg-git@gmane.org; Sun, 23 Apr 2006 18:34:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751421AbWDWQeS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 23 Apr 2006 12:34:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751423AbWDWQeS
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Apr 2006 12:34:18 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:28101 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751421AbWDWQeS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Apr 2006 12:34:18 -0400
Received: from shinybook.infradead.org ([81.187.2.165])
	by pentafluge.infradead.org with esmtpsa (Exim 4.61 #1 (Red Hat Linux))
	id 1FXhXM-0000w3-VC
	for git@vger.kernel.org; Sun, 23 Apr 2006 17:34:17 +0100
To: git@vger.kernel.org
X-Mailer: Evolution 2.6.0 (2.6.0-1.dwmw2.1) 
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19070>

Should I expect cloning with alternates using '--reference' to be
transitive?

Using '--reference clone1 --reference linux-2.6' for the second clone
works OK, but surely it ought to work with just '--reference clone1'? 

It doesn't work -- it can't find the objects which are in the original
linux-2.6 tree....

 (linux-2.6 contains a current copy of linus' tree)

shinybook /shiny/git $ git-clone --reference linux-2.6 git://git.infradead.org/mtd-2.6.git clone1
Checking files out...
 100% (19552/19552) done
shinybook /shiny/git $ git-clone --reference clone1 git://git.infradead.org/mtd-2.6.git clone2
error: refs/reference-tmp/refs/tags/v2.6.13-rc7 does not point to a valid commit object!
error: refs/reference-tmp/refs/tags/v2.6.13-rc2 does not point to a valid commit object!
error: refs/reference-tmp/refs/tags/v2.6.14 does not point to a valid commit object!
   < ..... >
error: refs/reference-tmp/refs/tags/v2.6.14-rc1 does not point to a valid commit object!
error: refs/reference-tmp/refs/tags/v2.6.15-rc2 does not point to a valid commit object!
error: refs/reference-tmp/refs/tags/v2.6.13-rc6 does not point to a valid commit object!
error: refs/reference-tmp/refs/tags/v2.6.13-rc4 does not point to a valid commit object!
error: Could not read 7e6684741b15e98dd52bd0dbcb08a4eb69857c23
error: Could not read 7e6684741b15e98dd52bd0dbcb08a4eb69857c23
error: Could not read 7260448207915a170bb812f8639a90a30329adce
error: Could not read 7260448207915a170bb812f8639a90a30329adce
error: Could not read acf8d9bd83be879328c558400d94ee61fc229672
error: Could not read acf8d9bd83be879328c558400d94ee61fc229672
error: Could not read c7270e76718f635bed33afe6c4751a270b2d031b
error: Could not read c7270e76718f635bed33afe6c4751a270b2d031b
error: Could not read 0a8763981774041f3fee0a71e016dcaa096fa3f8
error: Could not read 0a8763981774041f3fee0a71e016dcaa096fa3f8
error: Could not read 4a47136ddde07488a5741e6be267b8f5bddc407b
error: Could not read 4a47136ddde07488a5741e6be267b8f5bddc407b
error: Could not read 6cad1d2664ec091ba5a6f3e3e552cf550ec8c2e0
error: Could not read 6cad1d2664ec091ba5a6f3e3e552cf550ec8c2e0
   < ..... >
error: Could not read a0d4c65cd5642e7f7bbd2f806a69d20b2e43edc4
error: Could not read 611dd7a56906343db81c9fe340be0eb78c4ec260
error: Could not read 611dd7a56906343db81c9fe340be0eb78c4ec260
error: Could not read 227b4665ae0105348868d7a0a577209c8d16c6e3
error: Could not read 227b4665ae0105348868d7a0a577209c8d16c6e3
error: Could not read 9f19a4bfe0d0f0d203113d34d7455ceb82ff8341
error: Could not read 9f19a4bfe0d0f0d203113d34d7455ceb82ff8341
Checking files out...
error: git-checkout-index: unable to read sha1 file of .gitignore (27fd37621255799602d74e94d670ff7a1658d40a)
error: git-checkout-index: unable to read sha1 file of COPYING (ca442d313d86dc67e0a2e5d584b465bd382cbf5c)
error: git-checkout-index: unable to read sha1 file of CREDITS (787564bc248b1d6125fc42f3932966b60aa2f7f4)
error: git-checkout-index: unable to read sha1 file of Kbuild (2d4f95e4b89f7f81da6cb94b07e8449b3689ba37)
error: git-checkout-index: unable to read sha1 file of Makefile (fc8e08c419f09e81252f3aa41cb7f47524c0af60)
error: git-checkout-index: unable to read sha1 file of README (05e055530bbb687599dd732d6753c77ffa281ae5)
   < .....> 

-- 
dwmw2
