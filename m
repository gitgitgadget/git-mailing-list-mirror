From: "Jelle Geerts" <jellegeerts@gmail.com>
Subject: Automatic cherry-pick failure
Date: Sat, 12 Jul 2008 13:55:07 +0200
Message-ID: <bf2cff050807120455p2394481bg181debddb86961dd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 12 13:56:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHdi9-0002gV-Gg
	for gcvg-git-2@gmane.org; Sat, 12 Jul 2008 13:56:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752269AbYGLLzR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jul 2008 07:55:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752279AbYGLLzR
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jul 2008 07:55:17 -0400
Received: from yw-out-2324.google.com ([74.125.46.31]:45337 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752215AbYGLLzQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jul 2008 07:55:16 -0400
Received: by yw-out-2324.google.com with SMTP id 9so2075196ywe.1
        for <git@vger.kernel.org>; Sat, 12 Jul 2008 04:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=I6FzMfKwVYtVigSVWSLqWqu7c6IbM7MJRfUBJiVYnc8=;
        b=h7Mz1F5/cahKe+2lFGa/234eFpL8MlJWcbDbJJOyx1d8ed6C4qWlzpC3AL9rG1p+NB
         NYuY1i3kpkCZH8TPf47JUwhaF8KE6YEHYXYlq8hXXfkML5qJVDbneAjtfT6Ix7FDDGQP
         gVSUcLB6RUsPbGM6S59xTlNlsRryPK5TNS06w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=mugS9WmlU7q+N4KW1RLCuXLXF9GxHG7JqgU0Xq5/WPnjNf0bn+t8wTFEa/lYwHw7/6
         uB8SRU6WmdejmNq/ckBFDXeO5vgbNEQZ2I4nycby4BJJhIfcFgdT/m8cPt9BUmRCOI1q
         gDFqN+nl/hND1HnnJpuj8MpG3dlZdPn6Ky6cI=
Received: by 10.150.191.10 with SMTP id o10mr17432629ybf.56.1215863707085;
        Sat, 12 Jul 2008 04:55:07 -0700 (PDT)
Received: by 10.151.84.4 with HTTP; Sat, 12 Jul 2008 04:55:07 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88234>

Hello,

When I tried to `git rebase -i', I changed the first line in the editor from
'pick' to 'edit'. After the editor exited, git complained:
  error: Untracked working tree file 'DESIGN.TXT' would be overwritten by merge.
But this file is tracked, so first I did `git rebase --abort'.
I had to use `git config --bool core.ignorecase true' to get around the error.
It's because I use Git with Cygwin on an NTFS partition. Only thing I is that
'core.ignorecase' is undocumented.

After getting around the Cygwin specific workaround, I reran rebase. Again, I
edited the first line from 'pick' to 'edit'. All went well. Then I made the
amendment to the commit with `git commit --amend --author="me <me@somewhere>"'.
Now, when I typed `git rebase --continue' I got this:
  error: Entry 'code/src/sys_main.cc' not uptodate. Cannot merge.
  fatal: merging of trees e3249e935c9ccd790c372aac82b8e097044b1ffe and
ac79e613ed0fe912e0da2c5ccf52f6a540533cb8 failed
  Automatic cherry-pick failed.  After resolving the conflicts,
  mark the corrected paths with 'git add <paths>', and
  run 'git rebase --continue'
  Could not apply 5c03af9... commit test

I'm not sure what I have to do now, can someone help me with this?

-- Jelle
