From: "Stefan Pfetzing" <stefan.pfetzing@gmail.com>
Subject: Makefile checks for DarwinPorts / Fink
Date: Fri, 21 Jul 2006 16:58:21 +0200
Message-ID: <f3d7535d0607210758m4410cddfw16329ce473404fd8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Jul 21 16:58:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G3wSS-0002kb-Lo
	for gcvg-git@gmane.org; Fri, 21 Jul 2006 16:58:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750778AbWGUO6X (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 21 Jul 2006 10:58:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750804AbWGUO6X
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Jul 2006 10:58:23 -0400
Received: from wx-out-0102.google.com ([66.249.82.198]:5283 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750778AbWGUO6W (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Jul 2006 10:58:22 -0400
Received: by wx-out-0102.google.com with SMTP id s13so464022wxc
        for <git@vger.kernel.org>; Fri, 21 Jul 2006 07:58:21 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=g4SYmuSs2HR1QW6mVwfeVzw79uQwySYnESxNMh5J4SWvvPFnNRUbr1ilUz37Qi/W8IGygUvzYj9nZFF7eH3yUjZ9xIlNmBi1MhAGdd2IF1Fu7R0rteFrwAVMiI2f96LZzK/DMk3rqDLk829WaDElzuqPhRu4BXaiMB/2YhjfM7A=
Received: by 10.70.128.10 with SMTP id a10mr1174098wxd;
        Fri, 21 Jul 2006 07:58:21 -0700 (PDT)
Received: by 10.70.28.9 with HTTP; Fri, 21 Jul 2006 07:58:21 -0700 (PDT)
To: "Git Mailing List" <git@vger.kernel.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24056>

Hi,

while I was updating the DarwinPorts Portfile for git, I saw some
really suspicious lines in the Makefile of Git for DarwinPorts/Fink.

--- snip ---
        ## fink
        ifeq ($(shell test -d /sw/lib && echo y),y)
                ALL_CFLAGS += -I/sw/include
                ALL_LDFLAGS += -L/sw/lib
        endif
        ## darwinports
        ifeq ($(shell test -d /opt/local/lib && echo y),y)
                ALL_CFLAGS += -I/opt/local/include
                ALL_LDFLAGS += -L/opt/local/lib
        endif
--- snap ---

IMHO, Git should definetely not include /sw/include and /sw/lib, just
if it *exists*.

Think of a situation, when somebody has Fink and DarwinPorts installed
on one machine (possible). Then if you would build Git from
DarwinPorts, the git Makefile would link against Fink libraries! IMHO
the DarwinPorts / Fink build process should set LDFLAGS and CFLAGS
accordingly.

Also, maybe you want to create a DarwinPorts / Fink independent Mac OS
X pkg which contains Git and its deps.

I know this just appends to CFLAGS/LDFLAGS, but if for example
DarwinPorts has broken build-deps, then the Fink stuff would get
sucked in, and you would not notice. (on a box with both, DP and Fink
installed)

bye

Stefan

  --
       http://www.dreamind.de/
Oroborus and Debian GNU/Linux Developer.
