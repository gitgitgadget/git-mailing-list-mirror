From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: msysgit, help: teach git help to open html from /doc/git/html/
Date: Sun, 12 Aug 2007 12:49:53 +0200
Message-ID: <F4A816A8-4139-45BD-9A86-EFB1DFE251E7@zib.de>
References: <51772B53-642F-4D52-9CF3-906A21FC0D6F@zib.de> <fcaeb9bf0708111710m1eca7a82t71d471e40e84ef93@mail.gmail.com> <fcaeb9bf0708111716y29d6a719r995304b96c1b3eb2@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Marius Storm-Olsen <marius@trolltech.com>
X-From: git-owner@vger.kernel.org Sun Aug 12 12:50:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKB1O-0001ve-3b
	for gcvg-git@gmane.org; Sun, 12 Aug 2007 12:50:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934524AbXHLKuG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Aug 2007 06:50:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934527AbXHLKuF
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Aug 2007 06:50:05 -0400
Received: from mailer.zib.de ([130.73.108.11]:42440 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934524AbXHLKuD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Aug 2007 06:50:03 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l7CAnTnT024506;
	Sun, 12 Aug 2007 12:49:41 +0200 (CEST)
Received: from [192.168.178.32] (brln-4db1ff88.pool.einsundeins.de [77.177.255.136])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l7CAnQjZ026814
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sun, 12 Aug 2007 12:49:27 +0200 (MEST)
In-Reply-To: <fcaeb9bf0708111716y29d6a719r995304b96c1b3eb2@mail.gmail.com>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55673>


On Aug 12, 2007, at 2:16 AM, Nguyen Thai Ngoc Duy wrote:

> On 8/11/07, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
>> This reminds me a patch I made before:
>>
>> http://thread.gmane.org/gmane.comp.version-control.git/49217/ 
>> focus=49575
>
> And the second patch:
>
> http://article.gmane.org/gmane.comp.version-control.git/49216
>
>> With a little modification you can use ShellExecute to open html if
>> there is no suitable program to open it. The last commit on
>> mingw.git's mob branch does that (not based on my mentioned patch
>> though).

So we have three approached now:

1) Nguyen's approach using '--html'/core.help=html to explicitly
choose html as the format of choice. The core.htmlprogram is used
and a printf style format string can be used to specify required
command line parameters.

2) Junio's light-weight core.helpcmd, which gets passed the string
that would normally be passed to 'man'. Helpcmd needs to figure
out how to do the right thing. Most likely helpcmd would be a
small shell script that does the mapping to a file or url for
displaying the help. But it can also be a more complex thing,
for example load a Windows chm file and jump to a specific anchor,
or whatsoever.

3) Steffen's msysgit specific code path to display always locally
installed html pages on Windows, and never display 'man' pages.


 From my perspective, (3) would be the fastest way to get a useful
git help in msysgit. It only needs to be applied and shipped. But
it provides no benefit for git.git on other architectures.

(2) is a very light-weight extension to core git, yet capable of
providing everything we need, or can think of in the future. It
makes sense to me to delegate the details how to find the help,
based on the git command, to an external helper.

Maybe I work a bit more on Junio's approach later the day. I would
like to see a useful help system in msysgit before advertising it
to a larger audience that has no git experience.

	Steffen
