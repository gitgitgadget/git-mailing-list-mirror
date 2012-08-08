From: Ben Blamey <blamey.ben@gmail.com>
Subject: Bug Report: Git sometimes "locks" file when running "git difftool"
Date: Wed, 8 Aug 2012 13:38:16 +0100
Message-ID: <CAN=DmE0q=+_oCACxtbKPs8hTjBfHzX=SnATNyS3Q_VwL0pYY3w@mail.gmail.com>
References: <CAN=DmE3J6G=5qtc87D+WK8-xH34nasQMT5KfgFoSoNgYpgJxnQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 08 14:38:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sz5Wv-0006PY-MO
	for gcvg-git-2@plane.gmane.org; Wed, 08 Aug 2012 14:38:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758064Ab2HHMiS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Aug 2012 08:38:18 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:34317 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757995Ab2HHMiR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2012 08:38:17 -0400
Received: by yhmm54 with SMTP id m54so674246yhm.19
        for <git@vger.kernel.org>; Wed, 08 Aug 2012 05:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=6rZjiQhzKFhVISZTQE773E4apNP57aJ+R95zJ9QR5C0=;
        b=IhPVJUqC50/ly4l+TAWMA5iwtNt2THjAZz4pdODW5opiN7zrsY2vCy6y9HKB/xd9dV
         42LW/1bkiU2AdUNJx1Ip3HPEn6XJ+i7TpuY/Bn2VBg0mriFU+vBuDXJppECmlnZMpku1
         4zvXNAOSnZdC3CvMfFYO9qiWxJNDgvtbR7BdHSW2OxX6DBKz5TrJcNifXvg7a+YEzLpQ
         VuZL6xIz4KyprF2H5BROUgRrQ130BGpCkfUVgeSNlZpLfzI3pdHH9EJHPHZ7qM3K/5v6
         tQQYkipwEP/a5M7sJBrOPCj2E8Ootxys80sR2pTtc7u6fQ/ZyWygVk8TBdeHcvACpvWN
         yv1w==
Received: by 10.50.95.136 with SMTP id dk8mr796619igb.8.1344429496513; Wed, 08
 Aug 2012 05:38:16 -0700 (PDT)
Received: by 10.50.88.66 with HTTP; Wed, 8 Aug 2012 05:38:16 -0700 (PDT)
In-Reply-To: <CAN=DmE3J6G=5qtc87D+WK8-xH34nasQMT5KfgFoSoNgYpgJxnQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203089>

Hi,

I'm using git for windows, PortableGit-1.7.11-preview20120710 (I've
just upgraded from PortableGit-1.7.6-preview20110709, which also had
the problem), on windows 7 (SP1). I find it handy when running "git
difftool" to make changes to the file in the difftool (I personally
use diffmerge http://www.sourcegear.com/diffmerge/ ) - especially if
files are very long, and you can remove spurious new lines, etc. etc.
with ease minimizing the number of changes you are going to make in
your commit. This is usually no problem.

The problem is that, I have found that sometimes files seem to be
locked, and whilst the diff program is open, I cannot write to the
file - neither from the difftool nor from, say, another text editor.
When I close diffmerge, the file is writable again. Logging off and on
again and the problem persists.

Diffmerge says:
"Could not open this file for writing. Try to override file
permissions?" [I click 'Yes'] "Error! Cannot open file."

Notepad++ says:
"Save failed    Please check whether if this file is opened in another program"

Other programs give similar errors.

I've tried running the command both as an administrator and as a
normal user, and there seems to be nothing wrong with
permissions/ownership on the file. Using the "Process Explorer"
Sysinternals tool, I can see that git.exe has a file handle open - and
I guess the mode it has opened the file is preventing writes - thing
is - it doesn't always seem to do this. Makes me wonder if the file
handle isn't being closed properly in these circumstances? If this is
by-design, it is not happening consistently, because 99% of the time I
can edit no problem.

Thanks,
Ben Blamey
