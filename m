From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: Scripted clone generating an incomplete, unusable .git/config
Date: Thu, 11 Nov 2010 18:39:10 +0100
Message-ID: <m2eiarwyip.fsf@igel.home>
References: <AANLkTik7-QzrMKDpV=W4dqpuguZsAr5yrMELmHu5NZMd@mail.gmail.com>
	<20101111103742.GA16422@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dun Peal <dunpealer@gmail.com>, Git ML <git@vger.kernel.org>,
	Stefan Naewe <stefan.naewe@atlas-elektronik.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 11 18:39:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGb7F-00032L-Uo
	for gcvg-git-2@lo.gmane.org; Thu, 11 Nov 2010 18:39:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754973Ab0KKRjN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Nov 2010 12:39:13 -0500
Received: from mail-out.m-online.net ([212.18.0.10]:37396 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753944Ab0KKRjM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Nov 2010 12:39:12 -0500
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 2BFB71C0048F;
	Thu, 11 Nov 2010 18:39:14 +0100 (CET)
Received: from igel.home (ppp-88-217-125-207.dynamic.mnet-online.de [88.217.125.207])
	by mail.mnet-online.de (Postfix) with ESMTP id 7C8291C000AF;
	Thu, 11 Nov 2010 18:39:10 +0100 (CET)
Received: by igel.home (Postfix, from userid 501)
	id 46B9CCA2A0; Thu, 11 Nov 2010 18:39:10 +0100 (CET)
X-Yow: Let me do my TRIBUTE to FISHNET STOCKINGS...
In-Reply-To: <20101111103742.GA16422@burratino> (Jonathan Nieder's message of
	"Thu, 11 Nov 2010 04:37:42 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2.90 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161275>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Hi,
>
> Dun Peal wrote:
>
>>   $ python -c "import os; os.popen('git clone git@git.domain.com:repos/repo.git')"
>>   [...]
>>   $ cat repo/.git/config
>>   [branch "master"]
>>           remote = origin
>>           merge = refs/heads/master
>
> It looks like you've probably figured it out already, but for
> completeness:
>
> Most likely the clone is terminating when Python exits, perhaps due to
> SIGPIPE.  It doesn't look like a bug to me; I suspect you meant to use
> os.system(), which is synchronous, instead.  You might be able to get
> a better sense of what happened with GIT_TRACE=1 or strace.

I think it would be a bug in python not wait(2)ing for the subprocess
during the implicit close when exiting.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
