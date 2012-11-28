From: Ivan Kanis <ivan.kanis@googlemail.com>
Subject: git fetch pack freezes
Date: Wed, 28 Nov 2012 15:12:49 +0100
Message-ID: <87624pizoe.fsf@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 28 15:13:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdiO2-0001du-Oe
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 15:13:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755342Ab2K1OM6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2012 09:12:58 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:47349 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755104Ab2K1OM4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2012 09:12:56 -0500
Received: by mail-we0-f174.google.com with SMTP id d7so4493292wer.19
        for <git@vger.kernel.org>; Wed, 28 Nov 2012 06:12:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:face:date:message-id:user-agent:mime-version
         :content-type;
        bh=xgw5tbZas+f3RnbzzhSBWiRbKq14LGQXXAGbTHZ2GPY=;
        b=0kyuTkFSw+fEqLujm7gpiz/xLiHD2cDcT2yDztQJOMoKF0x2ayPjxagpPnlh5wPcAY
         0itCo5dRhOT/wd0v/8uVHOt/KPn7fRnW1kVds5lzgr1A6Q1JsBHTbm00QACmhR23hYo2
         fqwqy0Aliyasp5bhHeJmm4yK8983pQI/yvTGZCquq0z1aMwEx0If0GVBAtTdAwTY0YPN
         QfIGAaQz6iS0659r2n7W7qSpsTXh/0h3TESpGSDMxGkm6PDHgpb3cl1J0D+I0tvMP6Ox
         WmMlvupVY+YO+OEtIwisQvEwu9Tson5DH1iI5DlMUz3TImUfWF8eRZtxgsaR7XPvvJJH
         dMBg==
Received: by 10.180.87.225 with SMTP id bb1mr8949344wib.20.1354111975625;
        Wed, 28 Nov 2012 06:12:55 -0800 (PST)
Received: from yan ([46.218.71.241])
        by mx.google.com with ESMTPS id gz3sm7175275wib.2.2012.11.28.06.12.51
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 28 Nov 2012 06:12:52 -0800 (PST)
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAAXNSR0IArs4c6QAAAB5QTFRF
 IBkXUxMTOCwoTC4qcUY8iFxQmmper31txpaJ/v/8aKZ1oAAAAcVJREFUOMt100tu2zAQAFDCXnUZ
 oAcIqG68LZULVLQBbwuSiffm6AIRRyeotAySJoVu2+FPpJWWC3/4NKOZocSW/yxWfnJ2+Bdwzhj7
 8gleWVy7DXC2rkMNr2V/zRbghXIwthf3VbIA9Ffc71vZCSFyCEsBggtNS8ludwvfmhYA0Vn9o4DP
 zMWxR7+cPWzAYFzwM0ModtdmcDbDS6i/hT7L+RZof5yCXGrYe5jn2YO6BYMjgY+51tCIAqHgBLwR
 pwLnGuRjAKyBJkuN4yd4U92uCY1vUr2D/c5b8DuxyQwfOHUeaLqDJhnkkuGXbB56h2C1IVBdgncc
 bBi6feroa9B6jUDojnQPQKupbyXyeeCE1oT7Oqrt+SnfY3mkiyGA/3AmD3H5g32CcBx6hY8pRkwJ
 9PpcjRGobUfprFnhAa1vepwcgMOhwG+pdSgKHFU9HAvoAH6XUl7lDUCCq5Qb6GMbVm3Aj++qDYCt
 wdBc/YHgOFCmS3mjDMRcSE2qY4E3Q3PVIQRQmeodNH4QEbRUFZzW+VotzwX4yTcRTySOML1qjcE5
 hTirVqDHkMAP0PjAywp3d18JZtqzvr9zDYD+GaSKtE6Zlr/DLPNFmOcvBAAAAABJRU5ErkJggg==
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210732>

Hello,

We are using git with the smart HTTP protocol. We are seeing the client
freeze with Jenkins poll. It stops the continuous build which is a bit
of a pain. It happens with the latest release 1.8.0 on the client side.
The server is using 1.7.0.4.

On the server we are seeing the following error message:

var/log/apache2/error.log.1:[Mon Nov 19 15:17:12 2012] [error] [client 192.168.50.15] fatal: git upload-pack: not our ref aa92ca2076c2421433f89ee0b0ae89cd36d27481 multi_ack_detailed side-band-64k thin-pack no-progress ofs-delta

The error is located in upload-pack.c:

                 * Hmph.  We may later want to allow "want" line that
                 * asks for something like "master~10" (symbolic)...
                 * would it make sense?  I don't know.
                 */
                o = lookup_object(sha1_buf);
                if (!o || !(o->flags & OUR_REF))
                        die("git upload-pack: not our ref %s", line+5);

It calls die with I believe is doing the right thing(TM).

On the client side I compiled git with debugging symbols. I then
attached the debugger to the process that gets hosed. I get the
following backtrace:

#0  0x00007fff85389af0 in read ()
#1  0x000000010f900913 in xread (fd=0, buf=0x7fff6f376e2c, len=4) at wrapper.c:142
#2  0x000000010f900a11 in read_in_full (fd=0, buf=0x7fff6f376e2c, count=4) at wrapper.c:171
#3  0x000000010f8a14e4 in safe_read (fd=0, buffer=0x7fff6f376e2c, size=4, return_line_fail=0) at pkt-line.c:140
#4  0x000000010f8a110e in packet_read_internal (fd=0, buffer=0x10f981eb0 "", size=1000, return_line_fail=0) at pkt-line.c:183
#5  0x000000010f8a1246 in packet_read_line (fd=0, buffer=0x10f981eb0 "", size=1000) at pkt-line.c:211
#6  0x000000010f7b5196 in get_ack (fd=0, result_sha1=0x7fff6f377450 "") at builtin/fetch-pack.c:227
#7  0x000000010f7b4074 in find_common (fd=0x7fff6f377668, result_sha1=0x7fff6f377450 "", refs=0x0) at builtin/fetch-pack.c:416
#8  0x000000010f7b32a5 in do_fetch_pack (fd=0x7fff6f377668, orig_ref=0x10fb007a0, sought=0x7fff6f377670, pack_lockfile=0x7fff6f377660)
    at builtin/fetch-pack.c:832
#9  0x000000010f7b2cbd in fetch_pack (my_args=0x10f973fe8, fd=0x7fff6f377668, conn=0x0, ref=0x10fb007a0, 
    dest=0x7fff6f377a78 "https://foo.visionobjects.com/git/a-project-name/", sought=0x7fff6f377670, pack_lockfile=0x7fff6f377660)
    at builtin/fetch-pack.c:1069
#10 0x000000010f7b2a25 in cmd_fetch_pack (argc=7, argv=0x7fff6f377890, prefix=0x0) at builtin/fetch-pack.c:1012
#11 0x000000010f77aa5b in run_builtin (p=0x10f971990, argc=7, argv=0x7fff6f377890) at git.c:306
#12 0x000000010f779ac7 in handle_internal_command (argc=7, argv=0x7fff6f377890) at git.c:467
#13 0x000000010f77a299 in run_argv (argcp=0x7fff6f377858, argv=0x7fff6f377850) at git.c:513
#14 0x000000010f7798fd in main (argc=7, argv=0x7fff6f377890) at git.c:588

The file descriptor being 0 in #6 seems a bit suspicious. I am not
familiar with the git protocol. Could I get some guidance on how to
troubleshoot some more so that I come up with a patch?
-- 
Ivan Kanis, Release Manager, Vision Objects,
Tel +33 2 28 01 49 50,  Fax +33 2 40 25 89 20
http://www.visionobjects.com

The essence of science: ask an impertinent question, and you are on
the way to a pertinent answer.
    -- Jacob Bronowski
