From: Andreas Jacobsen <andreas@andreasjacobsen.com>
Subject: Segfault in git merge-tree (1.8.2.2)
Date: Mon, 6 May 2013 15:02:10 +0200
Message-ID: <CADEJa-5prhhY-fUHgkk91M8HKWRG3enODS_h7Mq0dgo7V9sYsQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 06 15:02:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZL3X-0003MJ-RD
	for gcvg-git-2@plane.gmane.org; Mon, 06 May 2013 15:02:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753032Ab3EFNCL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 May 2013 09:02:11 -0400
Received: from mail-ve0-f171.google.com ([209.85.128.171]:35586 "EHLO
	mail-ve0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752863Ab3EFNCL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 May 2013 09:02:11 -0400
Received: by mail-ve0-f171.google.com with SMTP id oy12so3140843veb.2
        for <git@vger.kernel.org>; Mon, 06 May 2013 06:02:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-received:date:message-id:subject:from:to
         :content-type:x-gm-message-state;
        bh=ywi0kfT9/4U67QqWUWDIPl2n1MoUjRxLSMgFrCakJRU=;
        b=KsBFiISRLxM3j0Ie/NSyg93a/lfEBLQzYGk2wM00AgZYIsp9+WIcJtfyoagagEPctt
         prYIa0eYZYIjsRADlzZkmnkXWEmjhAh91M5W7Fifbp4A4Bgn24YWEHxbhF3N7Sviqbl1
         q5hl5JKrsg6qOGSaQNDI+d04VZyY+6tK3r2Zny2dtt8N6F7Xg4WVwcyPGThqVITC0TfH
         bTeEobmE0Gz033dArFdulUX4cJCUURORFDseMXPRWRWyLPCMqBKPKIRe0vJgjvSSIGT+
         Ng+yzjDt226zkc5aunvgOOA7YAcMtNz6pG14dicRIXH9qYnHEOKGBWuujZbsSL6mqDQk
         kyNA==
X-Received: by 10.58.34.44 with SMTP id w12mr6596634vei.54.1367845330183; Mon,
 06 May 2013 06:02:10 -0700 (PDT)
Received: by 10.58.252.135 with HTTP; Mon, 6 May 2013 06:02:10 -0700 (PDT)
X-Gm-Message-State: ALoCoQlMJLcnOofTndcKs/Tc03409NE8ZnpI1hifB5uIkyP55AVHfukbALRbeJA7xvlO3vZZHKNu
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223447>

Hi,

I'm getting a segfault in git merge-tree using v1.8.2.2 on MacOS
10.8.3. I can't share the repo, but I can build patches and check if
they fix the problem :)

Here's a bt:

(gdb) run
Starting program:
/usr/local/Cellar/git/1.8.2.2/libexec/git-core/git-merge-tree
027058e6ac8d03e029c4e1455bf90f63cd20e65b FETCH_HEAD master
Reading symbols for shared libraries +++++.............................. done

Program received signal EXC_BAD_ACCESS, Could not access memory.
Reason: KERN_INVALID_ADDRESS at address: 0x0000000000000000
0x000000010003e532 in threeway_callback ()
(gdb) bt
#0  0x000000010003e532 in threeway_callback ()
#1  0x00000001000da03b in traverse_trees ()
#2  0x000000010003e46b in threeway_callback ()
#3  0x00000001000da03b in traverse_trees ()
#4  0x000000010003e46b in threeway_callback ()
#5  0x00000001000da03b in traverse_trees ()
#6  0x000000010003e46b in threeway_callback ()
#7  0x00000001000da03b in traverse_trees ()
#8  0x000000010003e46b in threeway_callback ()
#9  0x00000001000da03b in traverse_trees ()
#10 0x000000010003e46b in threeway_callback ()
#11 0x00000001000da03b in traverse_trees ()
#12 0x000000010003e46b in threeway_callback ()
#13 0x00000001000da03b in traverse_trees ()
#14 0x000000010003e46b in threeway_callback ()
#15 0x00000001000da03b in traverse_trees ()
#16 0x000000010003e46b in threeway_callback ()
#17 0x00000001000da03b in traverse_trees ()
#18 0x000000010003e46b in threeway_callback ()
#19 0x00000001000da03b in traverse_trees ()
#20 0x000000010003e46b in threeway_callback ()
#21 0x00000001000da03b in traverse_trees ()
#22 0x000000010003e46b in threeway_callback ()
#23 0x00000001000da03b in traverse_trees ()
#24 0x000000010003df02 in cmd_merge_tree ()
#25 0x0000000100000e99 in handle_internal_command ()
#26 0x0000000100000c59 in main ()

-Andreas
