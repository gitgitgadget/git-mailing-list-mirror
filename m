From: "Nikita V. Youshchenko" <yoush@debian.org>
Subject: git apply fails because of 'index xxxxxxx..yyyyyyy' line?
Date: Tue, 12 Feb 2008 21:55:30 +0300
Message-ID: <1358330.RVoaTMz8tR@yoush.homelinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 12 19:56:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JP0Ir-0005Gh-R7
	for gcvg-git-2@gmane.org; Tue, 12 Feb 2008 19:56:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763588AbYBLSzs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2008 13:55:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763441AbYBLSzr
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Feb 2008 13:55:47 -0500
Received: from main.gmane.org ([80.91.229.2]:58546 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763368AbYBLSzq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2008 13:55:46 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JP0I9-0003H5-V1
	for git@vger.kernel.org; Tue, 12 Feb 2008 18:55:41 +0000
Received: from ppp85-140-98-91.pppoe.mtu-net.ru ([85.140.98.91])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 12 Feb 2008 18:55:41 +0000
Received: from yoush by ppp85-140-98-91.pppoe.mtu-net.ru with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 12 Feb 2008 18:55:41 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: ppp85-140-98-91.pppoe.mtu-net.ru
User-Agent: KNode/0.10.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73682>

Hello

I was playing with 'git quiltimport' feature, trying to import a large quilt
patchset (coming from vendor) into a local git repository containing linux
kernel tree.

Some of quilt patches in the patchset have been created by picking single
git commits, likely with 'git show XXXXXX > file.patch.

And I found that such patches fail to apply with 'git apply' (which is
internally used by 'git quiltimport'). Git complains:

fatal: patch with only garbage at line 3

However, if I edit patch file and add a space before the
'index XXXXXXX..YYYYYYY' in the header, then patch applies cleanly!

Also, some patches did not apply with error message that looked like

error: removal patch leaves file contents
error: arch/arm/mm/mmu.c: patch does not apply

But these patches applied cleanly after I addeed a space before
'deleted file mode XXXXXX' lines.

Finally, some patches fauled to apply, with error message

fatal: patch with only garbage at line 3

but applied cleanly after I added a space before
'dissimilarity index XX%' line.

The mentioned addition of spaces do not modify patches themselves. But it
makes 'git apply' happy.

I'm confused.
Could someone please comment on this?
Isn't it a bug in 'git apply'?
