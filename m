From: "Elijah Newren" <newren@gmail.com>
Subject: Unable to clone an ssh repository (with ugly installation-specific workaround)
Date: Mon, 11 Feb 2008 19:22:48 -0700
Message-ID: <51419b2c0802111822k4600e06bp4167a09b30bf947a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_17549_18020323.1202782968253"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 12 03:23:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOknt-0005UZ-5t
	for gcvg-git-2@gmane.org; Tue, 12 Feb 2008 03:23:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752182AbYBLCWv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2008 21:22:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751461AbYBLCWu
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Feb 2008 21:22:50 -0500
Received: from wa-out-1112.google.com ([209.85.146.182]:32320 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751430AbYBLCWu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2008 21:22:50 -0500
Received: by wa-out-1112.google.com with SMTP id v27so2503631wah.23
        for <git@vger.kernel.org>; Mon, 11 Feb 2008 18:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type;
        bh=k/GkPX/6dkcv62UnlGPflTkWTxfi1fC7nV/Wj3oqM+g=;
        b=iD2cnbFk8LTqVGHKRPqG3LHlE89de2ZSvbW/NiY/y63RiEhViz1OUBk+kvt4f6Xon+1ZixYJ6kJDrv0Rngi5rsAxBHGPLbaPFjV4H9bX7JNfiRcyhztvfeid75Wiwf+j9N3yJ3WVBPI2laXy7KQQ/nMD56dR+bzY6TbqFSiL8yc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type;
        b=jyIj2Ai9k9nniZcj80ni4du6GHlXFWmaW/TC/cRY1NTBvRoI6jUh9EL6V+U54ubCt6jRTDrMG04oJ5UUFmtqASPSjOCaLObuwJt4MEEPH/fkZMWY0Bsib6Ox5IimqQQb/C+Q8KiTEIg7d5yrvwYKeA2vTU83gwfr2Kcc2LXOrWw=
Received: by 10.114.171.1 with SMTP id t1mr825181wae.83.1202782968260;
        Mon, 11 Feb 2008 18:22:48 -0800 (PST)
Received: by 10.114.205.19 with HTTP; Mon, 11 Feb 2008 18:22:48 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73619>

------=_Part_17549_18020323.1202782968253
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

I'm pretty sure this worked before, but with git-1.5.4, when trying to
clone a repository via ssh from a machine that does not have git
installed in a standard system path, I get the following:

$ git clone -u /home/enewren/software/install/linux/git/bin/git-upload-pack
ssh://enewren@remote/var/scratch/enewren/votd
Initialized empty Git repository in /home/newren/devel/votd/.git/
remote: fatal: exec pack-objects failed.
remote: aborting due to possible repository corruption on the remote side.
fatal: early EOF
fatal: index-pack failed
fetch-pack from 'ssh://enewren@remote/var/scratch/enewren/votd' failed.

I tried doing a local clone of the same repository (worked fine), a
'git fsck -full' on the relevant repository (reported no errors), and
a few other things.  After a bit of digging, I found a really ugly
hack that works around my problem.  After recompiling git on the
remote machine with the attached patch, the clone operation succeeded.


Thanks,
Elijah

------=_Part_17549_18020323.1202782968253
Content-Type: text/x-patch; name=ugly-hack.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fcjtllzu0
Content-Disposition: attachment; filename=ugly-hack.patch

LS0tIGdpdC0xLjUuNC9leGVjX2NtZC5jfgkyMDA4LTAyLTAxIDIxOjA5OjAxLjAwMDAwMDAwMCAt
MDcwMAorKysgZ2l0LTEuNS40L2V4ZWNfY21kLmMJMjAwOC0wMi0xMSAxNzozNToxMS4wOTI3OTYw
MDAgLTA3MDAKQEAgLTY5LDcgKzY5LDcgQEAKIAljb25zdCBjaGFyICp0bXA7CiAKIAlzdHJidWZf
aW5pdCgmY21kLCAwKTsKLQlzdHJidWZfYWRkZigmY21kLCAiZ2l0LSVzIiwgYXJndlswXSk7CisJ
c3RyYnVmX2FkZGYoJmNtZCwgIi9ob21lL2VuZXdyZW4vc29mdHdhcmUvaW5zdGFsbC9saW51eC9n
aXQvYmluL2dpdC0lcyIsIGFyZ3ZbMF0pOwogCiAJLyoKIAkgKiBhcmd2WzBdIG11c3QgYmUgdGhl
IGdpdCBjb21tYW5kLCBidXQgdGhlIGFyZ3YgYXJyYXkK
------=_Part_17549_18020323.1202782968253--
