From: Peter Baumann <peter.baumann@gmail.com>
Subject: [BUG] t4102-apply-rename.sh isn't umask aware
Date: Tue, 1 Nov 2005 12:03:10 +0100
Message-ID: <802d21790511010303l1a91071ci@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Tue Nov 01 12:04:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EWtv8-0006SA-B7
	for gcvg-git@gmane.org; Tue, 01 Nov 2005 12:03:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750716AbVKALDM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 Nov 2005 06:03:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750741AbVKALDL
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Nov 2005 06:03:11 -0500
Received: from xproxy.gmail.com ([66.249.82.199]:41879 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750716AbVKALDL convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 1 Nov 2005 06:03:11 -0500
Received: by xproxy.gmail.com with SMTP id i30so1256771wxd
        for <git@vger.kernel.org>; Tue, 01 Nov 2005 03:03:10 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=dE9FzKdGLbDoMj7e9ruF8GynJ512s6SQR+QKQy4/zh8waLbHqmdgMgFdFKclgrl6RT3T2Kldm8WRMhfKC1kuZQgLH7o+t0AGaV3h+NIt318emMVHZDziRsQBLoo2iFUr1pFf7gpyPMquK5dSNpskI02gNXm/UFEINxgo+cZT7M8=
Received: by 10.65.22.10 with SMTP id z10mr977054qbi;
        Tue, 01 Nov 2005 03:03:10 -0800 (PST)
Received: by 10.64.21.6 with HTTP; Tue, 1 Nov 2005 03:03:10 -0800 (PST)
To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10931>

xp:~/src/git/t rm -fR trash
xp:~/src/git/t umask
0027
xp:~/src/git/t ./t4102-apply-rename.sh
mv: cannot stat `.git/hooks': No such file or directory
*   ok 1: setup
*   ok 2: apply
* FAIL 3: validate
        test -f bar && ls -l bar | grep "^-..x..x..x"
* failed 1 among 3 test(s)


Setting umask to 0022  fixed the problem.

xp:~/src/git/t rm -fR trash
xp:~/src/git/t umask
0022
xp:~/src/git/t ./t4102-apply-rename.sh
mv: cannot stat `.git/hooks': No such file or directory
*   ok 1: setup
*   ok 2: apply
*   ok 3: validate
* passed all 3 test(s)

Regards

  Peter
