From: Kirill Likhodedov <Kirill.Likhodedov@jetbrains.com>
Subject: git log doesn't allow %x00 in custom format anymore?
Date: Thu, 7 Oct 2010 15:25:29 +0400
Message-ID: <D9157D2F-31D5-44EF-8FB4-F0E62BBF8017@jetbrains.com>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 07 13:25:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3obU-0005tq-7o
	for gcvg-git-2@lo.gmane.org; Thu, 07 Oct 2010 13:25:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760321Ab0JGLZd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Oct 2010 07:25:33 -0400
Received: from mail.intellij.net ([213.182.181.98]:38204 "EHLO
	mail.intellij.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760313Ab0JGLZc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Oct 2010 07:25:32 -0400
Received: (qmail 8620 invoked by uid 89); 7 Oct 2010 11:25:29 -0000
Received: by simscan 1.1.0 ppid: 8586, pid: 8611, t: 0.0141s
         scanners: regex: 1.1.0 clamav: 0.96
/m: 52
Received: from unknown (HELO loki-mac-pro.labs.intellij.net) (Kirill.Likhodedov@jetbrains.com@172.26.240.110)
  by mail.intellij.net with ESMTPA; 7 Oct 2010 11:25:29 -0000
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158396>


Hello,

I've noticed that at least since Git 1.7.2.3 custom pretty format behaves strangely if there is a null-byte in the format:

Without null byte:
> git log --pretty=format:%H-%ct
Outputs something like:

ee5d714b95d133ff555bc8c7933dc752b5b277f5-1285954314
cb1b9dd688d9cf155257c94e749172820b56d87a-1285954240
b4c75be10b14d021003853e527e47ad88dc5a55b-1285833610
1963187da6a45f898e62e4e922faac6b9382b4e4-1285807494

With a null byte
> git log --pretty=format:%H%x00%ct
Ignores anything appearing after the null byte:

ee5d714b95d133ff555bc8c7933dc752b5b277f5
cb1b9dd688d9cf155257c94e749172820b56d87a
b4c75be10b14d021003853e527e47ad88dc5a55b
1963187da6a45f898e62e4e922faac6b9382b4e4

Other bytes behave fine. 

Using %x00 worked in Git 1.7.1 and stopped working in 1.7.2.3 (or even earlier).

Is it a bug or a feature (not allowing null bytes in the custom format anymore)?

If it is a feature, the documentation should have note about it. Now it's even proposing to use %x00:
            %x00: print a byte from a hex code

Thanks a lot.

----------------------------------
Kirill Likhodedov
JetBrains, Inc
http://www.jetbrains.com
"Develop with pleasure!"
