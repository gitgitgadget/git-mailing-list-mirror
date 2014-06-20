From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: The different EOL behavior between libgit2-based software and
 official Git
Date: Fri, 20 Jun 2014 08:56:01 +0200
Message-ID: <53A3DB01.7090904@web.de>
References: <1403146778624-7613670.post@n2.nabble.com> <53A285A1.3090804@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	Yue Lin Ho <yuelinho777@gmail.com>, git@vger.kernel.org,
	msysGit <msysgit@googlegroups.com>,
	=?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Fri Jun 20 08:56:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wxsk7-0005KU-Gm
	for gcvg-git-2@plane.gmane.org; Fri, 20 Jun 2014 08:56:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934323AbaFTG4H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jun 2014 02:56:07 -0400
Received: from mout.web.de ([212.227.17.12]:51768 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752794AbaFTG4F (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jun 2014 02:56:05 -0400
Received: from [192.168.209.26] ([78.72.74.102]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0MJkt6-1WyzCg2Dn2-0019KJ; Fri, 20 Jun 2014 08:56:02
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <53A285A1.3090804@web.de>
X-Provags-ID: V03:K0:VUCdHPPTdStm41gpE552uI2KzMAFPOWXv/jw6ykM0jPGj+GfQQA
 iwJWA9Z7SmtJTBPX788Bd8jlcN0nLFn0Gpzc1zGGSrPXmWoJ9uQrqPZUk7gA2S3GfFS+7oi
 gsNKUYF2wirqlbqWqxlDQ4/mLNFfbJkLwU2FmldzGQPcnM0Wqxi1ZvWSAivRl6/zAXEH97x
 lpwn2u6Sie7KwhCkVsEiw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252216>

Hm,
I feeled puzzled here.
Even if I wouldn't recommend to use core.autocrlf, and prefer to use .gitattributes,
the CRLF conversion should work under Git, but it doensn't seem to do so.

Clone this repo:
origin  https://github.com/YueLinHo/TestAutoCrlf.git
Try to see if LF or CRLF can be converted into CRLF,
when core.autocrlf is true.


Neither msysgit nor Git under Linux produces CRLF (?)

Git under Mac OS produces the CRLF:
both Git 2.0.0  and the latest msygit code base (7e872d24a9bd03),
compiled under Mac OS

What do I miss ?

git --version
git version 2.0.0
tb@Linux:~/EOL_Test/TestAutoCrlf$ t=MIX-more_LF.txt  &&  rm -f $t &&  git -c core.eol=CRLF checkout $t  && od -c  $t
0000000   L   i   n   e       1  \n   l   i   n   e       (   2   )  \r
0000020  \n   l   i   n   e       3   .  \n   t   h   i   s       i   s
0000040       l   i   n   e       4  \n   l       i       n       e    
0000060   N   o   .       5  \n   L   i   n   e       N   u   m   b   e
0000100   r       6  \n

=============================================
$ git --version
git version 1.9.2.msysgit.0.1206.g7e872d2

tb@msgit ~/EOL_test/TestAutoCrlf (master)
$  t=MIX-more_LF.txt  &&  rm -f $t &&  git -c core.eol=CRLF checkout $t  && od -c  $t
0000000   L   i   n   e       1  \n   l   i   n   e       (   2   )  \r
0000020  \n   l   i   n   e       3   .  \n   t   h   i   s       i   s
0000040       l   i   n   e       4  \n   l       i       n       e
0000060   N   o   .       5  \n   L   i   n   e       N   u   m   b   e
0000100   r       6  \n

=============================================
tb@mac:~/EOL_Test/TestAutoCrlf> git --version
git version 2.0.0.622.g9478935
tb@mac:~/EOL_Test/TestAutoCrlf> t=MIX-more_LF.txt  &&  rm -f $t &&  git -c core.eol=CRLF checkout $t  && od -c  $t
0000000    L   i   n   e       1  \r  \n   l   i   n   e       (   2   )
0000020   \r  \n   l   i   n   e       3   .  \r  \n   t   h   i   s    
0000040    i   s       l   i   n   e       4  \r  \n   l       i       n
0000060        e       N   o   .       5  \r  \n   L   i   n   e       N
0000100    u   m   b   e   r       6  \r  \n                            

==============================================
tb@mac:~/EOL_Test/TestAutoCrlf> t=MIX-more_LF.txt  &&  rm -f $t &&  ~/projects/git/tb.msygit/git -c core.eol=CRLF checkout $t  && od -c  $t
0000000    L   i   n   e       1  \r  \n   l   i   n   e       (   2   )
0000020   \r  \n   l   i   n   e       3   .  \r  \n   t   h   i   s    
0000040    i   s       l   i   n   e       4  \r  \n   l       i       n
0000060        e       N   o   .       5  \r  \n   L   i   n   e       N
0000100    u   m   b   e   r       6  \r  \n                            
