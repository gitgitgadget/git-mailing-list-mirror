From: Thomas Glanzmann <thomas@glanzmann.de>
Subject: Re: "git clone" executed as root on solaris 10 shreds UFS (it is
	possible to create hardlinks for directories as root under solaris)
Date: Mon, 16 Jul 2007 14:35:10 +0200
Message-ID: <20070716123510.GI24036@cip.informatik.uni-erlangen.de>
References: <20070716100803.GA24036@cip.informatik.uni-erlangen.de> <20070716104342.GB24036@cip.informatik.uni-erlangen.de> <86ejj8aakq.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
	Junio C Hamano <gitster@pobox.com>
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Mon Jul 16 14:35:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAPnI-00007M-Az
	for gcvg-git@gmane.org; Mon, 16 Jul 2007 14:35:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753520AbXGPMfN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Jul 2007 08:35:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752792AbXGPMfN
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jul 2007 08:35:13 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:55309 "EHLO
	faui03.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751968AbXGPMfL (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Jul 2007 08:35:11 -0400
Received: by faui03.informatik.uni-erlangen.de (Postfix, from userid 31401)
	id 79C333F42E; Mon, 16 Jul 2007 14:35:10 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <86ejj8aakq.fsf@lola.quinscape.zz>
User-Agent: Mutt/1.5.15 (2007-05-02)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52667>

Hello David,

> Does it help to say export CDPATH="" in your root shell?

no. The problem is triggered by "git-checkout-index -a -f" so my CDPATH has
absolutly _nothing_ todo with it:

        (faui04a) [/var/tmp] mkdir -p test-4/.git
        (faui04a) [/var/tmp] cd test-4
        (faui04a) [/var/tmp/test-4] gcp -a ~/work/repositories/public/easix.git/* .git/
        (faui04a) [/var/tmp/test-4] git-read-tree HEAD
        (faui04a) [/var/tmp/test-4] git-checkout-index -a -f
        (faui04a) [/var/tmp/test-4] git status
        fatal: /usr/bin/git-status cannot be used without a working tree.
        (faui04a) [/var/tmp/test-4] rm .git/config
        (faui04a) [/var/tmp/test-4] git status
        # On branch master
        # Changed but not updated:
        #   (use "git add/rm <file>..." to update what will be committed)
        #
        #       deleted:    profiles/icpc
        #       deleted:    profiles/sithglan
        #       deleted:    sources/boot.msg
        #       deleted:    sources/busybox-config
        #       deleted:    sources/config
        #       deleted:    sources/easix.logo.16
        #       deleted:    sources/easixdm
        #       deleted:    sources/f2
        #       deleted:    sources/home-faumachine.tar.gz
        #       deleted:    sources/home-icpc.tar.gz
        #       deleted:    sources/home-simigern.tar.gz
        #       deleted:    sources/home-sithglan.tar.gz
        #       deleted:    sources/home-sitowert.tar.gz
        #       deleted:    sources/linuxrc
        #       deleted:    sources/rc.local
        #
        no changes added to commit (use "git add" and/or "git commit -a")
        (faui04a) [/var/tmp/test-4] cd ..
        (faui04a) [/var/tmp] rm -rf test-4
        rm: Unable to remove directory test-4: File exists
        (faui04a) [/var/tmp]

                Thomas
