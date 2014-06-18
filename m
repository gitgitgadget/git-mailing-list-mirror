From: "Jason Pyeron" <jpyeron@pdinc.us>
Subject: Importing history to show up in a blame
Date: Wed, 18 Jun 2014 16:09:33 -0400
Organization: PD Inc
Message-ID: <24554E1EBCD64D04B2B2B5E1A6280DF1@black>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0007_01CF8B0F.B14679F0"
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 18 22:09:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxMAs-0001ka-7G
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jun 2014 22:09:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754895AbaFRUJe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2014 16:09:34 -0400
Received: from mail.pdinc.us ([67.90.184.27]:47688 "EHLO mail.pdinc.us"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754633AbaFRUJd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2014 16:09:33 -0400
Received: from black (nsa1.pdinc.us [67.90.184.2])
	(authenticated bits=0)
	by mail.pdinc.us (8.12.11.20060308/8.12.11) with ESMTP id s5IK9WlV019974
	for <git@vger.kernel.org>; Wed, 18 Jun 2014 16:09:33 -0400
X-Mailer: Microsoft Office Outlook 11
Thread-Index: Ac+LMTgqdLOqqagMTGmM5rWAOB1LmQ==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.4913
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252054>

This is a multi-part message in MIME format.

------=_NextPart_000_0007_01CF8B0F.B14679F0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

The only way I have found so far to do this is to merge the branch on to a tmp
branch and then back!

The only other way I found seems real bad:
http://stackoverflow.com/questions/16473363/tell-git-blame-to-use-imported-histo
ry

And the way below does not work if there are edits already on master (that is
non-identical files).

Is there a better way?

-Jason

jpyeron@black /tmp/foo
$ git --version
git version 1.8.4.21.g992c386

jpyeron@black /tmp/foo
$ git init history
Initialized empty Git repository in /tmp/foo/history/.git/

jpyeron@black /tmp/foo
$ cd history

jpyeron@black /tmp/foo/history
$ #make source.txt and commit ...

jpyeron@black /tmp/foo/history
$ git checkout --orphan HISTORICAL
Switched to a new branch 'HISTORICAL'

jpyeron@black /tmp/foo/history
$ # import each historical version and commit ...

jpyeron@black /tmp/foo/history
$ git log  --oneline --graph && git blame source.txt && sha1sum.exe source.txt
* 2889460 v6 - latest
* 62e4a90 v5
* bfdf128 v4
* 416d32a v3
* 241a7dc v2
* 7ef41ad v1
^7ef41ad (Jason Pyeron 2014-06-18 13:47:57 -0400 1) 1 the
241a7dc5 (Jason Pyeron 2014-06-18 13:48:53 -0400 2) 2 quick
62e4a90e (Jason Pyeron 2014-06-18 13:50:44 -0400 3) 3 brown
bfdf1285 (Jason Pyeron 2014-06-18 13:49:55 -0400 4) 4 fox
416d32a4 (Jason Pyeron 2014-06-18 13:49:34 -0400 5) 5 jumped
416d32a4 (Jason Pyeron 2014-06-18 13:49:34 -0400 6) 6 over
416d32a4 (Jason Pyeron 2014-06-18 13:49:34 -0400 7) 7 the
416d32a4 (Jason Pyeron 2014-06-18 13:49:34 -0400 8) 8 lazy
28894602 (Jason Pyeron 2014-06-18 13:51:03 -0400 9) 9 dogs
cd49f005ab64dac61b2d420a7903fcd02b5f373f *source.txt

jpyeron@black /tmp/foo/history
$ git checkout master
Switched to branch 'master'

jpyeron@black /tmp/foo/history
$ git log  --oneline --graph && git blame source.txt && sha1sum.exe source.txt
* f25b132 import of latest source
^f25b132 (Jason Pyeron 2014-06-18 13:45:56 -0400 1) 1 the
^f25b132 (Jason Pyeron 2014-06-18 13:45:56 -0400 2) 2 quick
^f25b132 (Jason Pyeron 2014-06-18 13:45:56 -0400 3) 3 brown
^f25b132 (Jason Pyeron 2014-06-18 13:45:56 -0400 4) 4 fox
^f25b132 (Jason Pyeron 2014-06-18 13:45:56 -0400 5) 5 jumped
^f25b132 (Jason Pyeron 2014-06-18 13:45:56 -0400 6) 6 over
^f25b132 (Jason Pyeron 2014-06-18 13:45:56 -0400 7) 7 the
^f25b132 (Jason Pyeron 2014-06-18 13:45:56 -0400 8) 8 lazy
^f25b132 (Jason Pyeron 2014-06-18 13:45:56 -0400 9) 9 dogs
cd49f005ab64dac61b2d420a7903fcd02b5f373f *source.txt

jpyeron@black /tmp/foo/history
$ git checkout HISTORICAL
Switched to branch 'HISTORICAL'

jpyeron@black /tmp/foo/history
$ git branch historymerge

jpyeron@black /tmp/foo/history
$ git checkout historymerge
Switched to branch 'historymerge'

jpyeron@black /tmp/foo/history
$ git merge master
Merge made by the 'recursive' strategy.

jpyeron@black /tmp/foo/history
$ git checkout master
Switched to branch 'master'

jpyeron@black /tmp/foo/history
$ git merge historymerge
Updating f25b132..5a9408a
Fast-forward

jpyeron@black /tmp/foo/history
$ git branch -d historymerge
Deleted branch historymerge (was 5a9408a).

jpyeron@black /tmp/foo/history
$ git log --oneline --graph && git blame source.txt && sha1sum.exe source.txt
*   5a9408a Merge branch 'master' into historymerge
|\
| * f25b132 import of latest source
* 2889460 v6 - latest
* 62e4a90 v5
* bfdf128 v4
* 416d32a v3
* 241a7dc v2
* 7ef41ad v1
^7ef41ad (Jason Pyeron 2014-06-18 13:47:57 -0400 1) 1 the
241a7dc5 (Jason Pyeron 2014-06-18 13:48:53 -0400 2) 2 quick
62e4a90e (Jason Pyeron 2014-06-18 13:50:44 -0400 3) 3 brown
bfdf1285 (Jason Pyeron 2014-06-18 13:49:55 -0400 4) 4 fox
416d32a4 (Jason Pyeron 2014-06-18 13:49:34 -0400 5) 5 jumped
416d32a4 (Jason Pyeron 2014-06-18 13:49:34 -0400 6) 6 over
416d32a4 (Jason Pyeron 2014-06-18 13:49:34 -0400 7) 7 the
416d32a4 (Jason Pyeron 2014-06-18 13:49:34 -0400 8) 8 lazy
28894602 (Jason Pyeron 2014-06-18 13:51:03 -0400 9) 9 dogs
cd49f005ab64dac61b2d420a7903fcd02b5f373f *source.txt




--
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
-                                                               -
- Jason Pyeron                      PD Inc. http://www.pdinc.us -
- Principal Consultant              10 West 24th Street #100    -
- +1 (443) 269-1555 x333            Baltimore, Maryland 21218   -
-                                                               -
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
This message is copyright PD Inc, subject to license 20080407P00.

------=_NextPart_000_0007_01CF8B0F.B14679F0
Content-Type: application/octet-stream;
	name="history.bundle"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="history.bundle"

IyB2MiBnaXQgYnVuZGxlCjI4ODk0NjAyMGMzM2VhNzJlYjY1ODFmNzY0ZGZjOTAzYTY2NDU1YTQg
cmVmcy9oZWFkcy9ISVNUT1JJQ0FMCjVhOTQwOGFlNDRiZDRjMWI4OGFhYjQ0MzNlYTM5YjcyMGQ3
NWYzYjUgcmVmcy9oZWFkcy9tYXN0ZXIKNWE5NDA4YWU0NGJkNGMxYjg4YWFiNDQzM2VhMzliNzIw
ZDc1ZjNiNSBIRUFECgpQQUNLAAAAAgAAABSaEnicnYwxbsQgEEV7TkG31UYzMGAsraLUK0XKFQYY
YkcyWJgt9vZxIuUCqf4v3nuji+hcEhabS4wlCGYmJ8ahzRwilOyTiZKRQdTOXerQJoSZPBhI1gpP
RqJ3Acvk6SzNYNl7co7pjy/GRbSGeOIcYKbCyGTIphysiECkkgxOpPgxltb1nY9W9cdT+jm3r/33
vO15renlcbxqJLBoEILVVyAAldq2rWPIP1T1Lv1TdOxc06IvGx9n5qLXOppe1mO0/tx+CPUNt5hc
BuQFgEt4nFvFdI9xgqmGmVGqSaKlQap5WpJRSmqyZZKpmYWRqVGahUlKUmKKUbKRUaKBkXGS0cRe
XRZDYwuzifvMJUG0sYKugYmBARdXmZmCrkJOYklqcQkXAA2mF1eVDXicnctNCsIwEEDhfU6RCyiZ
nyYpiLh25RWSzAQr2JY0Fby94hFcvW/zelO1BBlEAVKq2VUSjwROBFgoc43RJ2RkV8yams7d5ioV
MA6F8gjqRTEMgXxwGTggYRgFky9s0t7vS7PXtC2zvb21fXN6rD9cVpnmcty3swV2BECR2R4cO2fK
8nxOvesfq3kN5gOR6z8wlQ14nJ3LQQrCMBBA0X1OkQsoM800k4CIa1deIclksIJtSVPB2ysewdV/
m99brdaJhxTHkjUO6guyFwiCjjQxRi8ogSBQNmtqde6W0IsbEikJR1BPlHlwSULE4LKwZxw5qpq0
9/vS7DVty2xv79q+OT3WHy6rTHM57tvZIoFDdBxHewACMGV5Pqfe6x+reZH5AE7APueVDXicnY1B
DsIgEADvvIIPaNjuAiUxxrMnvwDLEmvSllBq4u9tfIKnmctkehPRWEYJzqALQUAweE6BIUayzhYk
YEAveciqxiZL1wNB9JltyXb0YypEjpJknyw7EyEUJz7lYFTc+3Nt+h63ddGPj7QDl1f9ya3maeHz
vl01kEE4Hp70yZAxitd5nnqXP1L1RvUFy8Y/0ZUNeJydi0sKwzAMBfc+hS/QYkXGcqCUrLvqFWRL
pinkg+MUevuGHKGrNwPzWlW1CtgnChwEo4TIipT6nAITiiMpnYCQQjYrV52bJS0eWPjIJGoXczqF
PfQaCwfNAdULGN7ba6n2wdsy2+dX6zG393rCsMo45+u+3S14hwBIiPbivHMmL9M0tqZ/XM2nMz+3
0UExlQp4nJ3LSwrCQAyA4f2cIhdQEpN5FKS4duUV5hGxQjtlOhW8veIRXP3f5u9NFTwJqYZBgnVF
IiPbXDSnUxR2KbDVNHjUu4l7f9QG17jVBW5vbd+cn+sPl7VMSz7u2wgkyETsvIcDCqLJdZ6n3vWP
1bzIfACGNTHn5AOFJnicu8e4i3GC3sQ4PWZTU7OJ/RbKQEpB18DEwICLKzO3IL+oRCE/TSEnsSS1
uEShOL+0KDmVCwCkthBRpgJ4nDM0MDAzMVEozi8tSk7VK6koYbj7P/GW5uViDiVZTkP9Oz4T1not
WwMAAUYOprAEeJwzVCjJSOUyUigszUzO5jJWSCrKL8/jMlFIy6/gMlXIKs0tSE3hMlPIL0st4jIH
q7VQyEmsquSyVEjJTy/mAgBrnxMapgJ4nDM0MDAzMVEozi8tSk7VK6koYbCRuuu1fPKZ9bHSJw0+
O7TWZRx7OwsAAi0P/Wp4eJxzcJhgzZqcWFLMBQAQxAMGpgJ4nDM0MDAzMVEozi8tSk7VK6koYdCf
vTtr4zeL0B3qyeW9W4/+OGsqHAsACVsPvL0DeJwzVCjJSOUyUigszUzO5jJWKEpN4TJRSMuv4DJV
yCrNLQByzRTyy1KLuMzBKi0UchKrKrksFZITS7gAJH0RuKYCeJwzNDAwMzFRKM4vLUpO1SupKGF4
bbhu4m0XlycdS8+mn+/TfXFtyZdcABkXEb+wBHicM1QoyUjlMlIoLM1MzuYyVihKTeEyUcjNz8tO
reQyVcgqzS0Aipgp5JelFnGZgxVbKOQkVlVyWSokJ5ZwAQBqyBL+pgJ4nDM0MDAzMVEozi8tSk7V
K6koYZgw79K69x/1p0qU5ypOqxY4Ypup9xMAD40PkL4BeJwzVCjJSOUyUigszUzO5jJWKC/KLEkt
KlZIyskH8gGO2QmupgJ4nDM0MDAzMVEozi8tSk7VK6koYZh/83Lh17NMH6cfsC4VtrmkqOJefBIA
FswP0LYBeJwzVCjJSOUyUigvyixJLSpWSMrJT87mAgBPRQc0YrymS1ItUvPJcMTnBggxIgfc2U0=

------=_NextPart_000_0007_01CF8B0F.B14679F0--
