From: "Panagiotis Vossos" <pavossos@gmail.com>
Subject: git-svn: regression with funny chars in svn repo url
Date: Tue, 1 Apr 2008 21:11:46 +0300
Message-ID: <d06901f0804011111o1da8a197ob6a9aaccb3e1e9a0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 01 20:12:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JgkyH-0002kO-U9
	for gcvg-git-2@gmane.org; Tue, 01 Apr 2008 20:12:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758146AbYDASLu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Apr 2008 14:11:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757996AbYDASLu
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Apr 2008 14:11:50 -0400
Received: from ti-out-0910.google.com ([209.85.142.186]:44483 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757835AbYDASLt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Apr 2008 14:11:49 -0400
Received: by ti-out-0910.google.com with SMTP id 28so760674tif.23
        for <git@vger.kernel.org>; Tue, 01 Apr 2008 11:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=+Da6A/xomZOrijbNEjT18zZjHp7f0qpC3eaevfUapYo=;
        b=QWiTzC9ZkJnE/jqjuQj6k9MjFufkGJXsTFBzL3rKCJ6an1AXH21AtbDEVbz6bq2K1OH08eUU0DNaBla9ym7116hCKCRQ/SNXrqb8vs3VKk9dapJ/2ERDF2jC2m0dXbzPZtChkgiy2E4Md9PfTlVKeWhwB31ViqUl4ulFPVDnN40=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=K6AMstypq37JckfF07vcloKfGXJDWlVQtkNSa1fuQSn3w2YyOz0qsbrf36i+2fCNpiZiE2gSkxrbZjSRfm+5rStijlxGM7Un6c0plVf5sztIKbasoyfAIQErMeK0z53o7WaAf3VAcz9NpJOpkdOFQxrO2Lv9/O0tr8JMxHqI8qE=
Received: by 10.150.203.8 with SMTP id a8mr4331660ybg.56.1207073506082;
        Tue, 01 Apr 2008 11:11:46 -0700 (PDT)
Received: by 10.150.134.8 with HTTP; Tue, 1 Apr 2008 11:11:46 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78659>

I keep a copy of the gtk+ svn repository on my machine and I have
noticed the following bug with git-svn:

~/gitproj/gtk+$ which git-svn
/usr/local/bin/git-svn

~/gitproj/gtk+$ ls -l /usr/local/bin/git-svn
lrwxrwxrwx 1 root staff 39 2008-03-30 07:45 /usr/local/bin/git-svn ->
../encap/git-1.5.4_20080328/bin/git-svn

~/gitproj/gtk+$ git-svn --version
git-svn version 1.5.4.5 (svn 1.4.6)

~/gitproj/gtk+$ git-svn rebase
Apache got a malformed URI: REPORT request failed on
'/svn/gtk+/!svn/vcc/default': Unusable URI: it does not refer to this
repository at /usr/local/bin/git-svn line 3821


This bug did not exist in a previous version:

vozzer@kermit:~/gitproj/gtk+$ ls -l
/usr/local/encap/git-1.5.3_20071207/bin/git-svn
-rwxr-xr-x 1 root staff 119648 2007-12-08 10:53
/usr/local/encap/git-1.5.3_20071207/bin/git-svn
vozzer@kermit:~/gitproj/gtk+$
/usr/local/encap/git-1.5.3_20071207/bin/git-svn --version
git-svn version 1.5.3.7.8.g8e742 (svn 1.4.6)
vozzer@kermit:~/gitproj/gtk+$
/usr/local/encap/git-1.5.3_20071207/bin/git-svn rebase


        M       gtk/gtk-builder-convert
        M       ChangeLog
r19608 = af3d481e25db0e168a33b94e14480d72af5effe4 (gtk-2-12)
[snipped]

, proceeds normally.  I have included the output of `git-svn
--version' above for both versions,
but also take note of the encap directories for approximate dates: the
working version was
built from a fresh checkout on 2007-12-07, the non-working version was
built from
yesterdays checkout.

For reference, the url for the gtk+ svn repo is:

http://svn.gnome.org/svn/gtk+/trunk

I initialized the git-svn repo with the usual '-T trunk -t tags -b
branches' args.

regards,
panagiotis.

ps. please cc me when replying, I have not subscribed to the list.
