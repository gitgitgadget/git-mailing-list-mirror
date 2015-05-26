From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] git-new-workdir: add windows compatibility
Date: Tue, 26 May 2015 14:35:30 +0200
Organization: gmx
Message-ID: <1fb8315dfaffb91ec4925bcc458e12a2@www.dscho.org>
References: <CADBZQ5iAKsSrdvBnFcdPcm9psaJo5B-H1zqJj0aRc+xx6cCFMQ@mail.gmail.com>
 <xmqqfv6k7zp3.fsf@gitster.dls.corp.google.com>
 <cbfbf842705637b52cde9c6b61f89a75@www.dscho.org>
 <1432642835.17513.22.camel@mad-scientist.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Daniel Smith <dansmith65@gmail.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	Ralf Wildenhues <Ralf.Wildenhues@gmx.de>,
	Richard Hartmann <richih@net.in.tum.de>
To: paul@mad-scientist.net
X-From: git-owner@vger.kernel.org Tue May 26 15:24:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxEq8-0006DL-4j
	for gcvg-git-2@plane.gmane.org; Tue, 26 May 2015 15:24:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754216AbbEZNXH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 May 2015 09:23:07 -0400
Received: from mout.gmx.net ([212.227.15.18]:49368 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754189AbbEZNXD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 May 2015 09:23:03 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0MYfre-1Ybh5i1Qfa-00VSpP; Tue, 26 May 2015 14:35:32
 +0200
In-Reply-To: <1432642835.17513.22.camel@mad-scientist.net>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:rFYnthPARKsqyltJ865/K5BCXEFohfGOLvV6iCTCgxytbSmYFfy
 +dfUn+V8lWBuvGdvSLjACBBdBtLgfcQTPQmWuK08d8xleEnfJJGIXmKOMHe8VXli+Xbodxj
 wkdoMazza0csTKhD7LTbOKJcFrn9Lnt7BD9ujkYBp3/P1hIDsUokSroYgjdV1eHVSQooKyD
 ydwpYrI8hYeHZmGdouYZg==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269936>

Hi Paul,

On 2015-05-26 14:20, Paul Smith wrote:
> On Tue, 2015-05-26 at 11:53 +0200, Johannes Schindelin wrote:
>> The biggest problem with `mklink` is that it is only supported on
>> Windows Vista and later, while I really like to keep Windows XP
>> support in Git for Windows.
> 
> No, the biggest problem with mklink is that you have to have
> administrative privileges to use it... from wikipedia:
> 
> http://en.wikipedia.org/wiki/NTFS_symbolic_link

It is even worse than that, as you pointed out below: administrators *can* permit non-administrators to create and use of symbolic links.

However, from a maintainer's perspective (which is my role in this thread), the compatibility problem is an even worse problem than the permissions.

>> The default security settings in Windows Vista/Windows 7 disallow
>> non-elevated administrators and all non-administrators from creating
>> symbolic links. This behavior can be changed running "secpol.msc" the
>> Local Security Policy management console (under: Security Settings
>> \Local Policies\User Rights Assignment\Create symbolic links). It can
>> be worked around by starting cmd.exe with Run as administrator option
>> or the runas command.
> 
> Except even that is not so simple, as various StackOverflow questions
> and answers will show (I have to run so I can't look them up now).  I
> did try to get this to work a year or so ago, and although I'm in no way
> a Windows person (so maybe someone else would have better luck) I
> couldn't get it to work.

For what it is worth, I tried my hand a couple of years ago at the project to move git-new-workdir to use the `.git` *file* and alternates mechanisms, but that does not work because you really need a separate `.git/HEAD`.

Ciao,
Johannes
