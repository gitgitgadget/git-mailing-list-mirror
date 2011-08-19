From: Elias Pipping <pipping@lavabit.com>
Subject: git diff --word-diff=plain
Date: Fri, 19 Aug 2011 21:16:52 +0200 (CEST)
Message-ID: <20110819.211652.1683659708096792687.pipping@lavabit.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
 boundary="--Next_Part(Fri_Aug_19_21_16_52_2011_774)--"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 19 21:49:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QuV3r-0002hf-Sl
	for gcvg-git-2@lo.gmane.org; Fri, 19 Aug 2011 21:49:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756153Ab1HSTsx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Aug 2011 15:48:53 -0400
Received: from karen.lavabit.com ([72.249.41.33]:36483 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755928Ab1HSTsw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Aug 2011 15:48:52 -0400
X-Greylist: delayed 1688 seconds by postgrey-1.27 at vger.kernel.org; Fri, 19 Aug 2011 15:48:52 EDT
Received: from d.earth.lavabit.com (d.earth.lavabit.com [192.168.111.13])
	by karen.lavabit.com (Postfix) with ESMTP id 637D315754F
	for <git@vger.kernel.org>; Fri, 19 Aug 2011 14:20:44 -0500 (CDT)
Received: from localhost (91-65-137-66-dynip.superkabel.de [91.65.137.66])
	by lavabit.com with ESMTP id 4EEFQ5JKRMXC
	for <git@vger.kernel.org>; Fri, 19 Aug 2011 14:20:44 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=lEirCjdrwHpfdWgaAtu6RGGPF88P5oB4c2AOfZEkCo/A268d7Oray/LAoc+i9KupTlKXFXBAA3KmtipeES/owChxqp+CsEUWHPYgieyy8UeQXa36jp15Qig4j6AOvvx24FdvYmcMNEQRvGSJmcM+ytv0560YBXXJ8USyRQku81U=;
  h=Date:Message-Id:To:Subject:From:X-Mailer:Mime-Version:Content-Type:Content-Transfer-Encoding;
X-Mailer: Mew version 6.3.51 on Emacs 23.3 / Mule 6.0 (HANACHIRUSATO)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179720>

----Next_Part(Fri_Aug_19_21_16_52_2011_774)--
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hello,

I mean to use `git --no-pager diff --word-diff=plain --no-index` as a
`wdiff`-replacement. I'm not sure if I should call it a bug but I've
come across a situation in which the output of GNU wdiff is by far
more helpful than that of the aforementioned git command.

I've attached the two files less and BSD-2. Here are the differences
that wdiff reveals:

% wdiff less BSD-2
                          [-Less License-]
[-                          -------------]
[--]
[-Less-]Copyright [-(C) 1984-2005  Mark Nudelman-] {+(c) <YEAR>, <OWNER>+}
{+All rights reserved.+}

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice,
   this list of conditions and the following disclaimer.
2. Redistributions in binary form must reproduce the above copyright
   [-notice-]
   {+notice, this list of conditions and the following disclaimer+} in the
   documentation and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE [-AUTHOR ``AS IS''-] {+COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"+}
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
ARE DISCLAIMED. IN NO EVENT SHALL THE [-AUTHOR-] {+COPYRIGHT OWNER OR CONTRIBUTORS+} BE
LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
POSSIBILITY OF SUCH DAMAGE.
%

That's hardly any difference. Note that the file BSD-2 has an empty
line just before the first bullet point. This will cause git to treat
anything after that line as different for some reason. The resulting
diff is thus hardly useful:

% git --no-pager diff --word-diff=plain --no-index less BSD-2
diff --git a/licences/less b/licences/BSD-2
index 7e4887b..a995d54 100644
--- a/licences/less
+++ b/licences/BSD-2
@@ -1,27 +1,23 @@
[-Less License-]
[-                          -------------]

[-Less-]Copyright [-(C) 1984-2005  Mark Nudelman-]{+(c) <YEAR>, <OWNER>+}
{+All rights reserved.+}

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:[-1. Redistributions of source code must retain the above copyright-]
[-   notice, this list of conditions and the following disclaimer.-]
[-2. Redistributions in binary form must reproduce the above copyright-]
[-   notice in the documentation and/or other materials provided with -]
[-   the distribution.-]

[-THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY-]
[-EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE-]
[-IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR -]
[-PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR BE LIABLE-]
[-FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR -]
[-CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT -]
[-OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR -]
[-BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, -]
[-WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE -]
[-OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN -]
[-IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.-]{+1. Redistributions of source code must retain the above copyright notice,+}
{+   this list of conditions and the following disclaimer.+}
{+2. Redistributions in binary form must reproduce the above copyright+}
{+   notice, this list of conditions and the following disclaimer in the+}
{+   documentation and/or other materials provided with the distribution.+}

{+THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"+}
{+AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE+}
{+IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE+}
{+ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE+}
{+LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR+}
{+CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF+}
{+SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS+}
{+INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN+}
{+CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)+}
{+ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE+}
{+POSSIBILITY OF SUCH DAMAGE.+}
%


Best regards,

Elias Pipping

----Next_Part(Fri_Aug_19_21_16_52_2011_774)--
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename=BSD-2

Copyright (c) <YEAR>, <OWNER>
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice,
   this list of conditions and the following disclaimer.
2. Redistributions in binary form must reproduce the above copyright
   notice, this list of conditions and the following disclaimer in the
   documentation and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
POSSIBILITY OF SUCH DAMAGE.

----Next_Part(Fri_Aug_19_21_16_52_2011_774)--
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename=less

                          Less License
                          ------------

Less
Copyright (C) 1984-2005  Mark Nudelman

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions
are met:
1. Redistributions of source code must retain the above copyright
   notice, this list of conditions and the following disclaimer.
2. Redistributions in binary form must reproduce the above copyright
   notice in the documentation and/or other materials provided with 
   the distribution.

THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY
EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR 
PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR BE LIABLE
FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR 
CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT 
OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR 
BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, 
WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE 
OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN 
IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.


----Next_Part(Fri_Aug_19_21_16_52_2011_774)----
