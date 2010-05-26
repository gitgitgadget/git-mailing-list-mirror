From: Sam Vilain <sam@vilain.net>
Subject: Re: Apology/Bug report: git-send-email sends everything on Ctrl+C
Date: Wed, 26 May 2010 20:51:58 +1200
Message-ID: <4BFCE12E.4070009@vilain.net>
References: <4BFCB9D0.3010400@vilain.net>  <4BFCC4B5.6070408@vilain.net> <1274861112.2074.2.camel@wpalmer.simply-domain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Will Palmer <wmpalmer@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 26 10:52:18 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OHCLT-0001Kw-Hi
	for gcvg-git-2@lo.gmane.org; Wed, 26 May 2010 10:52:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933727Ab0EZIwF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 May 2010 04:52:05 -0400
Received: from bertrand.catalyst.net.nz ([202.78.240.40]:48034 "EHLO
	mail.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751721Ab0EZIwD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 May 2010 04:52:03 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.catalyst.net.nz (Postfix) with ESMTP id 1054132D63;
	Wed, 26 May 2010 20:52:00 +1200 (NZST)
X-Virus-Scanned: Debian amavisd-new at catalyst.net.nz
Received: from mail.catalyst.net.nz ([127.0.0.1])
	by localhost (bertrand.catalyst.net.nz [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Y2hRWzizP0kK; Wed, 26 May 2010 20:51:58 +1200 (NZST)
Received: from [IPv6:2404:130:0:1000:21d:7dff:fe90:5fe0] (unknown [IPv6:2404:130:0:1000:21d:7dff:fe90:5fe0])
	(Authenticated sender: samv)
	by mail.catalyst.net.nz (Postfix) with ESMTPSA id E7DCA32BF9;
	Wed, 26 May 2010 20:51:58 +1200 (NZST)
User-Agent: Mozilla-Thunderbird 2.0.0.19 (X11/20090103)
In-Reply-To: <1274861112.2074.2.camel@wpalmer.simply-domain>
X-Enigmail-Version: 0.95.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147785>

Will Palmer wrote:
>> I think I must have actually hit Ctrl-Z, not Ctrl-C.  So, it's all my
>> fault and I apologize profusely.
>>     
> I'd consider anything that can make "accidentally sending 100+ patches"
> possible to be a bug. How does "it was Ctrl-Z, not Ctrl-C" make a
> difference here?

This was what I did;

on git.git next or so; I was thinking "hmm, how does git send-email
format the cover letter for editing by the user?  I know, I'll just check":

 $ git send-email --compose HEAD~5..

(tab around a bit, I think I hit ctrl+z because my history has "jobs" in
it just after that command)

(poke around in the git-send-email source a bit)

(inspect the file it produced, oh look, HEAD~5.. matches an awful lot of
commits)

(close edit window without changes)

(notice hundreds of e-mail headers being spewed out)

Ctrl+C.  nothing (it's in the background)

Ctrl+C again.  argh!  What MTA am I running?

 $ sudo /etc/init.d/postfix stop
 $ sudo /etc/init.d/exim4 stop
 $ cat .git/config

Oh no, it's going to a mail server I don't have root on.  It was fully
configured so it didn't need to ask any questions, just fire away.  Why
did I test that on my git.git checkout?

Quick, find a friendly sysadmin and mailq | grep sam.vilain | cut -d" "
-f1 | sudo xargs -n1 postsuper -d

Hard to know what could have possibly stopped this from happening.  PEBKAC.

Sam
