From: Thomas Harning <harningt@gmail.com>
Subject: git svn segfaults in _Delta.so
Date: Wed, 10 Sep 2008 14:21:53 -0400
Message-ID: <E7387B42-6A3D-432B-8478-71A5E510D905@gmail.com>
Mime-Version: 1.0 (Apple Message framework v926)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 10 20:23:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdULV-0000Mo-Gm
	for gcvg-git-2@gmane.org; Wed, 10 Sep 2008 20:23:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751377AbYIJSWJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Sep 2008 14:22:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751208AbYIJSWI
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Sep 2008 14:22:08 -0400
Received: from yx-out-2324.google.com ([74.125.44.30]:49243 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750745AbYIJSWF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2008 14:22:05 -0400
Received: by yx-out-2324.google.com with SMTP id 8so1410885yxm.1
        for <git@vger.kernel.org>; Wed, 10 Sep 2008 11:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:from:to
         :content-type:content-transfer-encoding:mime-version:subject:date
         :x-mailer;
        bh=E+vQTMJ7278n4Ujrman08m1StHLPSLLVznWhqdITeHU=;
        b=hUj1TraF+XfGpph+N56OPwqPohXI+58bZRuTHgDEQGh83YYyw9fhh9ckapKM4Gj5dT
         7yxm0cKdmo1fYlwh/DVhHDGTnStw8wiYvx8y5+io4yg4tt77ucVC1FJilrqCIeXzbgZm
         druTvL2qDUg6+AzZ7PNJrfZbDLZf4VJEDS2UY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:from:to:content-type:content-transfer-encoding
         :mime-version:subject:date:x-mailer;
        b=S6G6IlLvnBJyK9h+EK4vqqijqupGlSpzagN1T9TO3YLHnmolq0sVtH6qEp14vacfil
         odFA+vIQIPPKGZVNEZb+pXYjHIuysRiwm/lmSmlbfyQKAaxMAzDe/26ompUswjSQ0Euf
         06+teVXiXGlXi+nBy0UNHRf93jlrlfqB5hHCs=
Received: by 10.66.250.1 with SMTP id x1mr6942687ugh.83.1221070921764;
        Wed, 10 Sep 2008 11:22:01 -0700 (PDT)
Received: from ?10.1.10.196? ( [75.149.208.122])
        by mx.google.com with ESMTPS id 28sm4836347ugc.25.2008.09.10.11.21.58
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 10 Sep 2008 11:22:00 -0700 (PDT)
X-Mailer: Apple Mail (2.926)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95544>

I just recently setup a new system and installed subversion 1.5.1 and  
the latest git from head.

On an existing repository (copied from the same system but slightly  
older software) running git svn rebase will cause it to segfault in  
_Delta.so (part of subversion's perl libraries).... even when there is  
nothing to do... it even seems to successfully do all the operations.   
I've built subversion and git with debugging enabled and cannot get  
any useful stack-trace. the stacktrace is:

#0  0x00007fbed7edd3a0 in ?? ()
#1  0x00007fbed99fa75d in ?? ()
#2  0x0000000000000001 in ?? ()
#3  0x00007fbed99fb217 in ?? ()
#4  0x00007fbed99e82d8 in ?? ()
#5  0x0000000000000001 in ?? ()
#6  0x000000000070e250 in cwd.17580 ()
#7  0x000000000070d7f8 in buffer.17586 ()
#8  0x0000000000f7f408 in ?? ()
#9  0x00007fbed99fb205 in ?? ()
#10 0x0000000000000000 in ?? ()


The only way I know that it is _Delta.so is that in 'dmesg' i get:
git-svn[1277]: segfault at 7f64fa7213a0 ip 7f64fa7213a0 sp  
7fff07a9a2b8 error 14 in _Delta.so[7f64fa92c000+22000]

In another machine w/ very similar software (slightly older by a month  
or so) I do not see these segfaults.  However it is running svn  
1.4.6  .. so it might be svn versions...  will report on status after  
downgrade
