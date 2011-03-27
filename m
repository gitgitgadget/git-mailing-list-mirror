From: David Gilman <davidgilman1@gmail.com>
Subject: Reproducible crash in git merge
Date: Sun, 27 Mar 2011 11:54:32 -0500
Message-ID: <AANLkTimxHn_fwMKh9cbp9i5LkShUi=HK44nv2KJ7ENaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 27 18:55:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q3tFB-00048X-RP
	for gcvg-git-2@lo.gmane.org; Sun, 27 Mar 2011 18:55:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754039Ab1C0Qyx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Mar 2011 12:54:53 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:56975 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753936Ab1C0Qyw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Mar 2011 12:54:52 -0400
Received: by iyb14 with SMTP id 14so2288661iyb.19
        for <git@vger.kernel.org>; Sun, 27 Mar 2011 09:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:from:date:message-id:subject:to
         :content-type;
        bh=f0iCNFYL6fsOvQkzfx78BHOFChDM5noYgvZYaPOjLvU=;
        b=Bb0Y6L49aXb/XWsmEJ2FVa5UKCeO7LQHDdXYzXmcQe7/fVVYbgf62+K0likxEWEXm+
         sVbqYk4GESTbkSCdXvsIHBgh4FzArPMbk+xhRjnMFsobS6xfEPw1seiI7eQur089q7Yp
         XXm4vSe+O9opvK2thKLeW/54RJZ2Q7ncdwKas=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=gXHPdI7Tw8MD4qREDlWkD6tnxQt9HiHDMWB9jGYALdhuWxjeMWNnBGesh/yPVEDGyx
         eqy8gpdWI9MIBwgM9Odd+qs4xsp7Hrac2F178NtsXmpLp4y4VkI/Qc9748MlnYhXpHq6
         wf79JH42HogrzwFLVm+SJXWCcHkG3XQO7lhTE=
Received: by 10.42.224.9 with SMTP id im9mr4612136icb.455.1301244892114; Sun,
 27 Mar 2011 09:54:52 -0700 (PDT)
Received: by 10.231.180.220 with HTTP; Sun, 27 Mar 2011 09:54:32 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170084>

I can get git merge to crash during a git pull.  I'm using git
1.7.3.2.  The repo (afaict) is fine and had worked previously.
Unfortunately I can't share the repo itself because of its contents.
Here's the crash log that MacOS X generated for the crash.

Process:         git-merge [39769]
Path:            /opt/local/libexec/git-core/git-merge
Identifier:      git-merge
Version:         ??? (???)
Code Type:       X86 (Native)
Parent Process:  git [39768]

Date/Time:       2011-03-27 11:42:49.676 -0500
OS Version:      Mac OS X 10.5.8 (9L31a)
Report Version:  6
Anonymous UUID:  2A93C147-AB28-4ECD-B290-8F2DE59A5B4B

Exception Type:  EXC_BAD_ACCESS (SIGBUS)
Exception Codes: 0x000000000000000a, 0x0000000001200000
Crashed Thread:  0

Thread 0 Crashed:
0   libSystem.B.dylib             	0xffff0e35 __memcpy + 1685
(cpu_capabilities.h:246)
1   libz.1.dylib                  	0x0015ba3f inflate + 943
2   git-merge                     	0x000e4b57 git_inflate + 39
3   git-merge                     	0x000d0ead read_object + 445
4   git-merge                     	0x000d0fa8 read_sha1_file_repl + 40
5   git-merge                     	0x000973c7 write_entry + 183
6   git-merge                     	0x000979d6 checkout_entry + 582
7   git-merge                     	0x000e2b33 unpack_trees + 1923
8   git-merge                     	0x000422c0 checkout_fast_forward + 512
9   git-merge                     	0x00043588 cmd_merge + 2504
10  git-merge                     	0x00002a3d handle_internal_command + 317
11  git-merge                     	0x000030f3 main + 1251
12  git-merge                     	0x00002226 start + 54

Thread 0 crashed with X86 Thread State (32-bit):
  eax: 0xffff0e1d  ebx: 0x0015b6a7  ecx: 0x0000001c  edx: 0xffffdfc0
  edi: 0x0169ad80  esi: 0x0120200f  ebp: 0xbfffc4f8  esp: 0xbfffc4f0
   ss: 0x0000001f  efl: 0x00010286  eip: 0xffff0e35   cs: 0x00000017
   ds: 0x0000001f   es: 0x0000001f   fs: 0x00000000   gs: 0x00000037
  cr2: 0x01200000

Binary Images:
    0x1000 -   0x110fef +git-merge ??? (???)
<e000e885c1cd2341cf81fe9283f5178a>
/opt/local/libexec/git-core/git-merge
  0x153000 -   0x164feb +libz.1.dylib ??? (???)
<14e90988b3fb4386b8fed7b6b13e5dc7> /opt/local/lib/libz.1.dylib
  0x169000 -   0x261ff4 +libiconv.2.dylib ??? (???)
<56e0608768d0bcfc4a75df4b5a299ad0> /opt/local/lib/libiconv.2.dylib
  0x26e000 -   0x398fe7 +libcrypto.1.0.0.dylib ??? (???)
<84a173ed04723f87b43fc6a5bccba7df>
/opt/local/lib/libcrypto.1.0.0.dylib
  0x3f8000 -   0x43afeb +libssl.1.0.0.dylib ??? (???)
<d053cde8a9ea10bbe9af6e3436a112f9> /opt/local/lib/libssl.1.0.0.dylib
0x8fe00000 - 0x8fe2db43  dyld 97.1 (???)
<458eed38a009e5658a79579e7bc26603> /usr/lib/dyld
0x900b4000 - 0x9021bff3  libSystem.B.dylib ??? (???)
<c8f52e158bf540cc000146ca8a705958> /usr/lib/libSystem.B.dylib
0x911e7000 - 0x911eefe9  libgcc_s.1.dylib ??? (???)
<a9ab135a5f81f6e345527df87f51bfc9> /usr/lib/libgcc_s.1.dylib
0x964b8000 - 0x964bcfff  libmathCommon.A.dylib ??? (???)
/usr/lib/system/libmathCommon.A.dylib
0xffff0000 - 0xffff1780  libSystem.B.dylib ??? (???) /usr/lib/libSystem.B.dylib
