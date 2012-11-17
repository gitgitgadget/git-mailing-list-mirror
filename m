From: Peter Alfredsen <peter.alfredsen@gmail.com>
Subject: git-credential-gnome-keyring fails at multilib
Date: Sat, 17 Nov 2012 15:05:27 +0100
Message-ID: <CADNdRzH+Fw+LsHF4LHWm9GsKJnbHjm2SgtKvSePmpwZyT7ptMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=14dae934102d5c02bd04ceb1609f
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 17 15:05:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZj1n-0000e6-CZ
	for gcvg-git-2@plane.gmane.org; Sat, 17 Nov 2012 15:05:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751823Ab2KQOFf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Nov 2012 09:05:35 -0500
Received: from mail-ie0-f174.google.com ([209.85.223.174]:46834 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751741Ab2KQOF2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Nov 2012 09:05:28 -0500
Received: by mail-ie0-f174.google.com with SMTP id k13so4921825iea.19
        for <git@vger.kernel.org>; Sat, 17 Nov 2012 06:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=yqdYYUAKKSvXzY8kVZ2rmmpIEm5Zk+PPROKpvf3i7wc=;
        b=tfEpEeVMkbWJRsch7GbDrvpB+XzqpLBVhlm+Gg2yg+cVX+H8ZUlcj9v7XUdCJAwBdX
         MB0l5l1Zzb0nqAvQfUukoAnvEfkltMYwGGjZFyLe0dzDzsUfC8WcweTbqCd23SxKCodg
         b9Rwy+weaUIZDvreWPA946RAbVlYIxFB12rrYVcnORpja05KfYFe6UiHptnBoD432lqZ
         3WTsg7ti1vJlXyM+L8S87MWC0W4KlkNX+poUglFcGCAdZSsH73xbfgBxazgl58whKMa3
         cjEQAxxSeloPfyO0r/VLepRi/0yA6mM+GKL6FiHStilXKOIc2ZrxRSY21SwbTfu7Lfkr
         MkVQ==
Received: by 10.50.195.168 with SMTP id if8mr1657975igc.71.1353161128018; Sat,
 17 Nov 2012 06:05:28 -0800 (PST)
Received: by 10.64.59.9 with HTTP; Sat, 17 Nov 2012 06:05:27 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209953>

--14dae934102d5c02bd04ceb1609f
Content-Type: text/plain; charset=UTF-8

Downstream bug report: https://bugs.gentoo.org/443634

The git-credential-gnome-keyring Makefile doesn't allow overriding its
variables, making for spectacular link failure if you use CFLAGS for
aught but decoration.

gcc -g -O2 -Wall   -I/usr/include/gnome-keyring-1
-I/usr/include/glib-2.0 -I/usr/lib32/glib-2.0/include   -o
git-credential-gnome-keyring.o -c git-credential-gnome-keyring.c
gcc -o git-credential-gnome-keyring -Wl,--as-needed
-Wl,--hash-style=gnu -m32 git-credential-gnome-keyring.o
-lgnome-keyring -lglib-2.0
/usr/lib/gcc/x86_64-pc-linux-gnu/4.7.2/../../../../x86_64-pc-linux-gnu/bin/ld:
i386:x86-64 architecture of input file
`git-credential-gnome-keyring.o' is incompatible with i386 output
/usr/lib/gcc/x86_64-pc-linux-gnu/4.7.2/../../../../x86_64-pc-linux-gnu/bin/ld:
git-credential-gnome-keyring.o: file class ELFCLASS64 incompatible
with ELFCLASS32
/usr/lib/gcc/x86_64-pc-linux-gnu/4.7.2/../../../../x86_64-pc-linux-gnu/bin/ld:
final link failed: File in wrong format
collect2: error: ld returned 1 exit status

Attached patch fixes it.

/Peter

--14dae934102d5c02bd04ceb1609f
Content-Type: application/octet-stream; 
	name="git-1.8.0-gnome-keyring-multilib.patch"
Content-Disposition: attachment; 
	filename="git-1.8.0-gnome-keyring-multilib.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_h9mt2kru0

ZGlmZiAtTnJVNSBnaXQtMS44LjAub3JpZy9jb250cmliL2NyZWRlbnRpYWwvZ25vbWUta2V5cmlu
Zy9NYWtlZmlsZSBnaXQtMS44LjAvY29udHJpYi9jcmVkZW50aWFsL2dub21lLWtleXJpbmcvTWFr
ZWZpbGUKLS0tIGdpdC0xLjguMC5vcmlnL2NvbnRyaWIvY3JlZGVudGlhbC9nbm9tZS1rZXlyaW5n
L01ha2VmaWxlCTIwMTItMTEtMTcgMTQ6NDU6MDYuNTM2NjQxMzgxICswMTAwCisrKyBnaXQtMS44
LjAvY29udHJpYi9jcmVkZW50aWFsL2dub21lLWtleXJpbmcvTWFrZWZpbGUJMjAxMi0xMS0xNyAx
NDo0NTo0MC44ODM0NDI5MzkgKzAxMDAKQEAgLTEsMTEgKzEsMTEgQEAKIE1BSU46PWdpdC1jcmVk
ZW50aWFsLWdub21lLWtleXJpbmcKIGFsbDo6ICQoTUFJTikKIAotQ0MgPSBnY2MKLVJNID0gcm0g
LWYKLUNGTEFHUyA9IC1nIC1PMiAtV2FsbAorQ0MgPz0gZ2NjCitSTSA/PSBybSAtZgorQ0ZMQUdT
ID89IC1nIC1PMiAtV2FsbAogCiAtaW5jbHVkZSAuLi8uLi8uLi9jb25maWcubWFrLmF1dG9nZW4K
IC1pbmNsdWRlIC4uLy4uLy4uL2NvbmZpZy5tYWsKIAogSU5DUzo9JChzaGVsbCBwa2ctY29uZmln
IC0tY2ZsYWdzIGdub21lLWtleXJpbmctMSkK
--14dae934102d5c02bd04ceb1609f--
