From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH 4/4] Implement git commit and status as a builtin commands.
Date: Tue, 06 Nov 2007 10:47:20 +0100
Message-ID: <47303828.3060106@op5.se>
References: <1194017589-4669-1-git-send-email-krh@redhat.com> <1194017589-4669-2-git-send-email-krh@redhat.com> <1194017589-4669-3-git-send-email-krh@redhat.com> <1194017589-4669-4-git-send-email-krh@redhat.com> <20071103150637.GA11172@atjola.homenet> <1194289073.13968.16.camel@hinata.boston.redhat.com> <20071105192347.GA29997@atjola.homenet> <Pine.LNX.4.64.0711052317170.4362@racer.site> <20071106091222.GE4435@artemis.corp> <4730314A.9010403@viscovery.net> <20071106092648.GG4435@artemis.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: Pierre Habouzit <madcoder@debian.org>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?ISO-8859-15?Q?Bj=F6r?= =?ISO-8859-15?Q?n_Steinbrink?=
X-From: git-owner@vger.kernel.org Tue Nov 06 10:47:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpL2B-0006Ng-0I
	for gcvg-git-2@gmane.org; Tue, 06 Nov 2007 10:47:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753773AbXKFJrd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Nov 2007 04:47:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753632AbXKFJrc
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Nov 2007 04:47:32 -0500
Received: from mail.op5.se ([193.201.96.20]:47222 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752064AbXKFJrc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Nov 2007 04:47:32 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 51E0317305AB;
	Tue,  6 Nov 2007 10:45:56 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id v3Q8oY3uvy6S; Tue,  6 Nov 2007 10:45:55 +0100 (CET)
Received: from nox.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id 9BD6617305A2;
	Tue,  6 Nov 2007 10:45:54 +0100 (CET)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <20071106092648.GG4435@artemis.corp>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63653>

Pierre Habouzit wrote:
> On Tue, Nov 06, 2007 at 09:18:02AM +0000, Johannes Sixt wrote:
>> Pierre Habouzit schrieb:
>>> Btw, I'm starting to work slowly on the diff_opt_parse conversion to the
>>> macro we discussed, and the need for new option parsing callbacks
>>> arised, and I've created a:
>>>  parse_opt_mask_{or,and,xor} commands that you declare this way:
>>>    OPT_MASK_OR('a', "all",         &mode, "...", MASK_ALL),
>>>    OPT_MASK_OR('i', "interactive", &mode, "...", MASK_INTERACTIVE),
>>>    ...
>>> And if you chose MASK_ALL/INTERACTIVE/.. to be single bits,
>>>    if (!!all + !!interactive ... > 1)
>>> becomes[0]:
>>>    if (mode & (mode - 1)) {
>>>    }
>> This goes too far, IMHO. That's unnecessary cleverness/microoptimization 
>> at the expense of readability.
> 
> The reason why I did that is not to be able to do mode & (mode - 1).

With a macro along the lines of

  #define IS_MULTI_FLAGGED(x) (x & (x - 1))

at least this particular construct becomes a lot more readable.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
