From: =?ISO-8859-1?Q?Steve_Fr=E9cinaux?= <nudrema@gmail.com>
Subject: Re: [PATCH 2/2] Cached the git configuration, which is now noticibly
 faster on windows.
Date: Mon, 10 Nov 2008 09:38:11 +0100
Message-ID: <4917F2F3.8000408@gmail.com>
References: <1226114569-8506-1-git-send-email-thestar@fussycoder.id.au>	 <1226114569-8506-2-git-send-email-thestar@fussycoder.id.au>	 <ee77f5c20811072119y65738f54o7e6792fb405c142c@mail.gmail.com> <1226127130.8252.6.camel@therock.nsw.bigpond.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: David Symonds <dsymonds@gmail.com>, git@vger.kernel.org
To: Arafangion <thestar@fussycoder.id.au>
X-From: git-owner@vger.kernel.org Mon Nov 10 09:39:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzSJ0-0001XE-Ab
	for gcvg-git-2@gmane.org; Mon, 10 Nov 2008 09:39:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753989AbYKJIiP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Nov 2008 03:38:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753885AbYKJIiP
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Nov 2008 03:38:15 -0500
Received: from www.multitel.be ([193.190.194.194]:44779 "EHLO smtp.multitel.be"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753822AbYKJIiO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Nov 2008 03:38:14 -0500
Received: from localhost (localhost [127.0.0.1])
	by smtp.multitel.be (Postfix) with ESMTP id C01994E80D6;
	Mon, 10 Nov 2008 09:38:12 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at pop.multitel.be.multitel.be
Received: from smtp.multitel.be ([127.0.0.1])
	by localhost (pop.multitel.be [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Hge7qYXdq7q9; Mon, 10 Nov 2008 09:38:12 +0100 (CET)
Received: from [172.30.201.110] (ip-213-177-152-201.dsl-static.scarlet.be [213.177.152.201])
	by smtp.multitel.be (Postfix) with ESMTP id D1F014E80BA;
	Mon, 10 Nov 2008 09:38:11 +0100 (CET)
User-Agent: Mozilla-Thunderbird 2.0.0.17 (X11/20081018)
In-Reply-To: <1226127130.8252.6.camel@therock.nsw.bigpond.net.au>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100500>

Arafangion wrote:
> On Fri, 2008-11-07 at 21:19 -0800, David Symonds wrote:
> <snip>
>> _gitConfig = None
>> def gitConfig(key):
>>   if _gitConfig is None:
>>     lines = read_pipe("git config -l", ignore_error=True).readlines():
>>     _gitConfig = dict([l.strip().split('=', 1) for l in lines])
>>   return _gitConfig.get(key, None)
> 
> That certainly is better, if one can assume that git's configuration is
> small. (And relative to the memory usage of the script, it will
> definetly be small).

What about using git config --get-regexp to only get the p4-related 
settings ?

I don't really know the options used by git-p4, but something like this 
seems like a good candidate to address every trade-off concerns?

git-config --get-regexp '^(p4|user)\.'
