From: Kaz Kylheku <kkylheku@gmail.com>
Subject: Tracked file suddenly disappeared just prior to commit.
Date: Thu, 12 Nov 2009 12:10:05 -0800
Message-ID: <3f43f78b0911121210h4771984cqed561ca5d8c2d859@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 12 21:16:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8g5M-0004aj-2n
	for gcvg-git-2@lo.gmane.org; Thu, 12 Nov 2009 21:16:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754254AbZKLUPx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Nov 2009 15:15:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754420AbZKLUPw
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Nov 2009 15:15:52 -0500
Received: from mail-yw0-f202.google.com ([209.85.211.202]:39503 "EHLO
	mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754445AbZKLUPw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Nov 2009 15:15:52 -0500
Received: by ywh40 with SMTP id 40so657160ywh.33
        for <git@vger.kernel.org>; Thu, 12 Nov 2009 12:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=h/GIYj+Au67ixAjzvYIqZt2eWA576sjPe5CB26JKnGQ=;
        b=QEt6pyEhXmpiFen1eMDnPieNG69MxvNYwIZgjWYHAQ2S+zTDTKF054CZsbw0LdW9AG
         +qrN9VRxfZ2Q29aWb3g3yLZrrlgtrdt6SOxKrFJIWr/nvWdsvODH7IxSxpVMoHe/zbLl
         kGlqaiEJXcwVUSpYaiAPu4omVLlccdu/5aJV0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=fxRlmaeniJihCTv+gbEXSR8n19K8vnlHS6e/QsUToQa6kGY2rvVbvCOLwaxsIjRsUh
         2UO7ylGRqdHukBwRnhQeGtLv5VhSw3/3U7T4ILleVasNwkCE2RgJ7VNZjw69d9akoXF7
         2N4Btsm5fU6AUknFGPZxQjLDG2My9LLROr5v0=
Received: by 10.150.129.25 with SMTP id b25mr6009575ybd.308.1258056605622; 
	Thu, 12 Nov 2009 12:10:05 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132797>

I am running git 1.6.5rc2 on a somewhat dated system (RH EL 4, i686).

The working copy is on an NFS mount from ``Big File Server used by Lots of
People''.

I ran ``git diff > diffs'' to capture some work. I was then editing the
ChangeLog file, making comments based on the diffs.  I had modified two files:
a C source file and its corresponding header. I spent maybe ten minutes doing
up the ChangeLog entry for these changes.

Then I quit the editor and ran ``git commit -a''.

In the commit comment, I saw git's shocking report that the C file had been
deleted! Apparently, I am about to commit a deletion of the file I hacked on!
So I emptied the comment to abort the commit.  I listed the
directory and surely enough, the file was gone.

For a split second I thought that I lost the changes, but then I realized I had
the diff in the "diffs" file, so I recovered with a ``git checkout'', followed
by a patch. Phew!

How could that have happened? I haven't seen issues like this with the
NFS server at all. The file hadn't been recently created, and it hadn't been
touched for 12 hours since I made the changes.

Could another user have deleted the file as a prank?  In this insecure
environment, you can impersonate another user to get around
directory permissions. It can't be logically ruled out that someone
was messing with my working copy.

I checked my bash history as well as the command history in Vim, but could find
no traces of any accidental delete command, or any command which might lead to
deletion. It all points to either git, the NFS server, or a prankster.

Strange!
