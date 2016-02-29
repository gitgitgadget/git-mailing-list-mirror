From: "jarek z." <yaras6@gmail.com>
Subject: Invalid initial git gui message encoding
Date: Mon, 29 Feb 2016 18:50:04 +0100
Message-ID: <CABvS4Ohe3fKG6qcDHtryLR3Mokt44m4AM6oP0p3PisvxndO+oA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: patthoyts@users.sourceforge.net
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Feb 29 18:50:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaRxT-0001jQ-Ey
	for gcvg-git-2@plane.gmane.org; Mon, 29 Feb 2016 18:50:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753279AbcB2RuG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 12:50:06 -0500
Received: from mail-ig0-f171.google.com ([209.85.213.171]:33749 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751346AbcB2RuF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 12:50:05 -0500
Received: by mail-ig0-f171.google.com with SMTP id y8so1057235igp.0
        for <git@vger.kernel.org>; Mon, 29 Feb 2016 09:50:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc;
        bh=jHuT3LjUIIfbFcYmISiFtsMmJrhK0OcAn6Pjv73pUOY=;
        b=Evz6azhWOSsKUgJaXQN6cOA+j9yVUjXGY8HaM2nx0bC50O1lI9b1rqidHwBuRBMswm
         IRQ+Tr5eAx/N8LYS2EEXz+vWI32WUzCaIf5BrWyoeHQUGrLOQgHouGBACw03WY8Ran8q
         86uZ01edInKHjz3qxn+Qt0QR2bIqW1DTHu6g1Iwr9FhPZXXwcXoS4P+bYFlrcU4dnBtF
         rdD/WB5hUahMTZq5OI+6b7Q7PlhV+z6z1H/MRm2WLvfdwRJyD6ySRtrpfWJihQeubV4O
         HdpmiSn90HlF3cbBycUY2ERGJRB/MA92VNFHKMxeH1hwY1xTv70usc3a3QwB6Q07B8Sy
         ROtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to:cc;
        bh=jHuT3LjUIIfbFcYmISiFtsMmJrhK0OcAn6Pjv73pUOY=;
        b=VDIiamRdKmfKPiKgJ/JMUwrvDiNVi3f7UC2XssLQvw18Ktg+hTPUn7ex0FnbqSOK/6
         HGmTCUqWfH+32BiAPq0cecmapsEZZ5CFbLGKMJzSkJHcwGN5XJ9EahDk/UFFCPQKKe2l
         /aS7Naj7Gu0cZZ+HFyEOkQaHSye+CTqoRUR5TbbXftRm2Z3UiYF6OXi4lfeO7e88xE/9
         Q6pJXWgQ9Z6lcyG1kbPZ1BJKAnhIqHOKFAF4VN9QrZBH3Wv8GY0c34m8lLQ735Gm9SyH
         YPKE7dNqEovQMZqMeh5nhaDevzhNTgyH6baNlT1imSLilbOf75DG1mi/HUhmUcRMzvP9
         QqFw==
X-Gm-Message-State: AD7BkJKBnbdgFyK0JPVMweEci7SGXV/K3OCUQwrlwRJt02VHwepiiRYjVE91RCO8XXmykieRc7K2uzehkVlnqQ==
X-Received: by 10.50.50.201 with SMTP id e9mr11695609igo.10.1456768204580;
 Mon, 29 Feb 2016 09:50:04 -0800 (PST)
Received: by 10.36.211.202 with HTTP; Mon, 29 Feb 2016 09:50:04 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287853>

Hello.

Working with Git for Windows on git gui I noticed an issue on reading
initial message to git gui message prompt after squash or cherry-pick
conflict. When system encoding is not set to UTF-8 (and on my Windows
it is cp1250) squash/cherry pick conflict message gets invalid
encoding.

This issue and test case is more widely described on
https://github.com/git-for-windows/git/issues/664 . After I set
encoding to UTF-8 using fconfigure, the problem seems to be fixed.

I tried it also on Linux, but I cannot reproduce this problem as its
default encoding is utf-8. I verified it using simple tcl script:
"puts [encoding system]". On Windows I get:

$ tclsh enc.tcl
cp1250

on Linux:

$ tclsh enc.tcl
utf-8

It may be not a big issue for Linux, but I think it is worth to have
it merged in case of somebody had other encoding than UTF-8. This fix
has been already merged into Git for Windows.

As stated in Documentation/SubmittingPatches, this patch is based on
git://repo.or.cz/git-gui.git.

BTW. Is there any example of writing regression tests for git-gui?

Signed-off-by: yaras <yaras6@gmail.com>
---
 git-gui.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/git-gui.sh b/git-gui.sh
index 11048c7..1ed5185 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -1616,11 +1616,13 @@ proc run_prepare_commit_msg_hook {} {
  if {[file isfile [gitdir MERGE_MSG]]} {
  set pcm_source "merge"
  set fd_mm [open [gitdir MERGE_MSG] r]
+ fconfigure $fd_mm -encoding utf-8
  puts -nonewline $fd_pcm [read $fd_mm]
  close $fd_mm
  } elseif {[file isfile [gitdir SQUASH_MSG]]} {
  set pcm_source "squash"
  set fd_sm [open [gitdir SQUASH_MSG] r]
+ fconfigure $fd_sm -encoding utf-8
  puts -nonewline $fd_pcm [read $fd_sm]
  close $fd_sm
  } else {
--
