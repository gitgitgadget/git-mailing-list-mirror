From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [WIP/RFH/PATCH 3/3] t/lib-git-svn: adjust config to apache 2.4
Date: Thu, 09 Apr 2015 11:33:23 +0200
Message-ID: <55264763.6050703@drmicha.warpmail.net>
References: <cover.1428505184.git.git@drmicha.warpmail.net> <0631c09d394dedb803a100e81ce4052a57b4e73e.1428505184.git.git@drmicha.warpmail.net> <20150408202615.GA12154@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Thu Apr 09 11:33:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yg8q6-0008W9-PO
	for gcvg-git-2@plane.gmane.org; Thu, 09 Apr 2015 11:33:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964813AbbDIJda (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Apr 2015 05:33:30 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:48004 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933344AbbDIJd0 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Apr 2015 05:33:26 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 44D4F2047D
	for <git@vger.kernel.org>; Thu,  9 Apr 2015 05:33:21 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute3.internal (MEProxy); Thu, 09 Apr 2015 05:33:25 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=4oalkMXOXiOi26T/UPXOqPb7Kww=; b=KkqgDz
	NK/TId6EBzzR7eFqKLAfkzeigYDl0EPtTJnshdTQyA6KFOwPrUx9pFyNlB7HiYG/
	/UcpBmpQxgEtb9v1BCGiQu4A5iQNMY9tnkqy4Wj/4tU7RuuNir64919yYPAU8KUy
	bylMLGEeRLvw+1q8F2b9yFbW3jtJb9OQkUrok=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=4oalkMXOXiOi26T
	/UPXOqPb7Kww=; b=cJjpDXgEiOxXYOsJk5EcQVEj/3NwfA0X3HxNxq8QxMoNOKU
	ArQbb4XGL+Onr6EahWwnAiP4AUt0zltUfkcWd48Yj6WDXZkWW2+GmMP5rIFbyR5D
	FxW6VKDbZiWxFumXWkzrUTi5qwUphBDO726tqPn1nBrJSFOHw5e3r9KlKrKc=
X-Sasl-enc: Ev8USIFiCe7iWgRq1aA4p2lOx4o02XmL2z+/MgeZ4bY3 1428572004
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id BE9EB6800DE;
	Thu,  9 Apr 2015 05:33:24 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
In-Reply-To: <20150408202615.GA12154@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266988>

Eric Wong venit, vidit, dixit 08.04.2015 22:26:
> Michael J Gruber <git@drmicha.warpmail.net> wrote:
>> The current config is tailored to apache 2.2. Apache 2.4 fails to start
>> with it.
>>
>> Adjust the config to apache 2.4.
>>
>> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
>> ---
> 
> 1/3 and 2/3 tested fine on Debian stable (wheezy).
> You can add my Tested-by to 1/3 and my S-o-b to 2/3.

Thanks, that's good to know.

> ...but not this one.
> 
>> Notes:
>>     This is WIP and RFH. Apache does not start without mpm, and the lock
>>     mechanism has changed. It will run with these changes, but svn fails to
>>     connect.
>>     
>>     Again, I'm wondering who is running these tests at all, but also:
>>     Why do we leverage lib-httpd so little from lib-git-svn?
> 
> I'm only testing on Apache 2.2 (from Debian stable (wheezy)).

So debian stable has apache 2.2? That explains why many don't see these
problems.

> I doubt anybody here, myself included, likes dealing with SVN,
> and would rather ignore the tests than try to fix them.
> 
> lib-git-svn predates lib-httpd, and it isn't very interesting work
> to port and cleanup.

I agree with everything above. But if (and that's a big if) the tests
don't run for anyone I'd rather remove them if there's no way to port them.

>> +LoadModule mpm_prefork_module $SVN_HTTPD_MODULE_PATH/mod_mpm_prefork.so
> 
> I think you need an IfModule guard around this?
> 
> I have no mod_mpm_prefork.so file with the apache2-mpm-prefork
> (2.2.22-13+deb7u4) package on Debian wheezy.

Sure, the changes in 3/3 are for apache 2.4 only and should be guarded
by a version check the same way as the ones in lib-httpd.

I'm just trying to figure out how to run them at all first.

So, before 3/3, t9118 and such do run the web server and test git-svn
against that for you?

Michael
