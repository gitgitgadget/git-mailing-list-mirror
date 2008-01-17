From: Nicholas Wourms <nwourms@gmail.com>
Subject: Re: Git Cygwin - unable to create any repository - help!
Date: Thu, 17 Jan 2008 13:53:44 -0500
Message-ID: <478FA438.9010909@gmail.com>
References: <20080114202932.GA25130@steel.home> <20080115200437.GB3213@steel.home> <a5eb9c330801151212y30cf4f63r9c294ba33da2b8f@mail.gmail.com> <200801160002.51048.robin.rosenberg.lists@dewire.com> <20080116071832.GA2896@steel.home> <a5eb9c330801160742j645ee50p72ee0a93adf8f94f@mail.gmail.com> <20080116183124.GA3181@steel.home> <a5eb9c330801161048x4b5a88dcsebd7cf9754f72ba6@mail.gmail.com> <20080116191737.GD3181@steel.home> <a5eb9c330801161344i1da447c7sb447bf6274d408e8@mail.gmail.com> <20080116234527.GA3499@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Paul Umbers <paul.umbers@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <junkio@cox.net>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 17 20:08:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFa64-0005AO-4P
	for gcvg-git-2@gmane.org; Thu, 17 Jan 2008 20:08:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752061AbYAQTHr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jan 2008 14:07:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751790AbYAQTHr
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jan 2008 14:07:47 -0500
Received: from mail.clemson.edu ([130.127.28.87]:63292 "EHLO CLEMSON.EDU"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751278AbYAQTHq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jan 2008 14:07:46 -0500
X-Greylist: delayed 817 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Jan 2008 14:07:46 EST
Received: from [130.127.121.188] (130-127-121-188.generic.clemson.edu [130.127.121.188])
	(authenticated bits=0)
	by CLEMSON.EDU (8.13.6/8.13.1) with ESMTP id m0HIriT2021206
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 17 Jan 2008 13:53:47 -0500 (EST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9b3pre) Gecko/2008011403 Lightning/0.6a1 Thunderbird/3.0a1pre Mnenhy/0.7.5.0
In-Reply-To: <20080116234527.GA3499@steel.home>
X-Proofpoint-Virus-Version: vendor=fsecure engine=4.65.5502:2.3.11,1.2.37,4.0.164 definitions=2008-01-17_04:2008-01-16,2008-01-17,2008-01-17 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 ipscore=0 phishscore=0 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx engine=3.1.0-0708230000 definitions=main-0801170081
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70906>

Alex Riesen wrote:
> Paul Umbers, Wed, Jan 16, 2008 22:44:10 +0100:
>> Here's the log from the latest strace.
> 
> Something is fishy here (aside from the horrible selection of
> information in the trace output):
> 

That is a matter of opinion. Besides, Cygwin's strace was designed first and
foremost with debugging the Cygwin dll in mind. Perhaps the choice of name for
the utility was a poor one, since it implies that it ought to be the same as
the official strace.

As for the matter at hand:

First, *you must* make sure you inspect every directory in your PATH for other
copies of cygwin1.dll. Sometimes, without telling you, other software packages
will distribute the cygwin1.dll. Often times this is an older version of that
dll. If there are any these found outside of the Cygwin installation tree, you
must remove them from your PATH.

Secondly, reinstalling Cygwin by rerunning setup is not enough. Cygwin is
pretty self-contained and non-invasive (contrary to the popular FUD spread by
MinGWists), but it does have 2 Registry keys which should be axed if you want a
clean install. They are:

HKEY_CURRENT_USER\Software\Cygnus Solutions
HKEY_LOCAL_MACHINE\Software\Cygnus Solutions

Lastly, has the user actually tried reporting this problem to
"cygwin@cygwin.com"? That is the proper list for reporting problems with
official cygwin packaged applications. Both the maintainer of the "git" Cygwin
package and the core Cygwin developers monitor that list, so you are much more
likely to get a solution to your problem there. Nevertheless, it does seem that
in this case it might be a problem with git's handling of failures to create
hard links. But do keep this in mind for future reference.

Cheers,
Nicholas
