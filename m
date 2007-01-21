From: Liraz Siri <liraz.siri@gmail.com>
Subject: git merge bug: creating new files in one branch in a directory that
 is renamed in another
Date: Sun, 21 Jan 2007 10:20:27 +0200
Message-ID: <45B3224B.3020800@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sun Jan 21 09:22:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H8Xxu-0001X4-Em
	for gcvg-git@gmane.org; Sun, 21 Jan 2007 09:22:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751287AbXAUIWF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 21 Jan 2007 03:22:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751281AbXAUIWF
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Jan 2007 03:22:05 -0500
Received: from nf-out-0910.google.com ([64.233.182.187]:15000 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751287AbXAUIWE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jan 2007 03:22:04 -0500
Received: by nf-out-0910.google.com with SMTP id o25so971680nfa
        for <git@vger.kernel.org>; Sun, 21 Jan 2007 00:22:01 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:disposition-notification-to:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=dVEcZi6YrMY8jYabSH5Uqe8WXXlDGRLBEidWCCBnONmfXncxq3+9JXN/oXKLZbz1oPfz4AnyQAOF7NFkKGhFv44YX3jT3kx3B8W7DEZefdCDxIX4BRAOC6HVaRKsEb4oFiEl1ToCUTD9j6/1Ve5O+1QAiGVcVXvmbiqGk4BrB2A=
Received: by 10.49.41.18 with SMTP id t18mr4695864nfj.1169367721507;
        Sun, 21 Jan 2007 00:22:01 -0800 (PST)
Received: from ?10.0.0.253? ( [88.152.176.182])
        by mx.google.com with ESMTP id k23sm10940994nfc.2007.01.21.00.22.00;
        Sun, 21 Jan 2007 00:22:01 -0800 (PST)
User-Agent: Thunderbird 1.5.0.9 (X11/20061206)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37310>

Hey all,

I'm running a few tests to figure out when git does the right thing on
merges, and I've discovered that git does not do the right thing if you
are creating new files in one branch in a directory that is renamed in
another.

Merging edits of files in dir/ in one branch and renaming dir/ to
newdir/ in another branch works, but if you create files in the renamed
dir/ then after the merge they will still remain in dir/, rather than
newdir/.

Here is some example output from a test merge:

$ git-merge XXX HEAD fork
Trying really trivial in-index merge...
fatal: Merge requires file-level merging
Nope.
Merging HEAD with 68aaa44a864cde7a1b83a65a8d5c70cc6c42ac7b
Merging:
85ba656 liraz renamed t to t2
68aaa44 created t/newfile
found 1 common ancestor(s):
9e42cd6 xxx
Merge made by recursive.
 t/newfile |    1 +
 t2/liraz1 |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)
 create mode 100644 t/newfile


Cheers,
Liraz
