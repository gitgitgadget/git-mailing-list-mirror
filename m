From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: git-update-server-info crashes on hera.kernel.org:/pub/scm/libs/klibc/klibc.git
Date: Sat, 03 Dec 2005 23:12:02 -0800
Message-ID: <439296C2.8020809@zytor.com>
References: <43921DAE.7060606@zytor.com>	<7vzmnhtmi1.fsf@assigned-by-dhcp.cox.net> <43928C39.8050105@zytor.com> <7v64q5tkhi.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 04 08:12:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eio2q-0004HY-6T
	for gcvg-git@gmane.org; Sun, 04 Dec 2005 08:12:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751325AbVLDHMK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Dec 2005 02:12:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751326AbVLDHMK
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Dec 2005 02:12:10 -0500
Received: from terminus.zytor.com ([192.83.249.54]:52672 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751325AbVLDHMJ
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 4 Dec 2005 02:12:09 -0500
Received: from [172.27.0.18] (c-67-180-238-27.hsd1.ca.comcast.net [67.180.238.27])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id jB47C2vp025398
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 3 Dec 2005 23:12:03 -0800
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v64q5tkhi.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: ClamAV version 0.87.1, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-0.8 required=5.0 tests=AWL,BAYES_00,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13184>

Junio C Hamano wrote:
> "H. Peter Anvin" <hpa@zytor.com> writes:
> 
> 
>>FWIW, I invoked this as:
>>
>>hpa@hera:~(0)$ GIT_DIR=/pub/scm/libs/klibc/klibc.git git-update-server-info
>>Segmentation fault
> 
> 
> Trusting that I *won't* be able to write into that repository, I
> tried to run that and after getting an error ("cannot update
> info/refs file", which I wanted to see) I seem to be getting the
> same segfault.  GDB session reveals the binary is heavily
> optimized or inlined, so it is hard to see what it is doing
> though.
> 
> But there is one thing that is mysterious about your repository,
> and by mirroring that peculiarity with the copy in my home
> directory, I managed to reproduce the problem with my copy.  Why
> does the objects/info/alternates in that repository point at
> itself?  I suspect if you remove that file you will be OK.
> 
> update-server-info simply dying, instead of complaining about
> it, is a bug nevertheless, and removal of the
> unnecessary/possibly wrong alternate is only a workaround, but I
> hope that would unblock you in the meantime..
> 

Removing that file did indeed work.  I have no idea where it comes from, 
though; although I would guess it comes from another repository that I 
merged with (which had my original repository set as an alternate.)

	-hpa
