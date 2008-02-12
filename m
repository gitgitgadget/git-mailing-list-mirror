From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] pack-objects: Add runtime detection of online CPU's
Date: Tue, 12 Feb 2008 13:21:47 +0100
Message-ID: <47B18F5B.7020106@op5.se>
References: <47B156CD.1010209@op5.se> <36ca99e90802120318y5099b06cta3f8488dc758f6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Nicolas Pitre <nico@cam.org>
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Tue Feb 12 13:22:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOu9n-0001Lg-3j
	for gcvg-git-2@gmane.org; Tue, 12 Feb 2008 13:22:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752727AbYBLMWA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2008 07:22:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752207AbYBLMV7
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Feb 2008 07:21:59 -0500
Received: from mail.op5.se ([193.201.96.20]:39000 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752183AbYBLMV7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2008 07:21:59 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id ABB3B1F08859;
	Tue, 12 Feb 2008 13:21:57 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -3.262
X-Spam-Level: 
X-Spam-Status: No, score=-3.262 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, AWL=1.137, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zT+wFL3VUdlD; Tue, 12 Feb 2008 13:21:56 +0100 (CET)
Received: from clix.int.op5.se (unknown [192.168.1.28])
	by mail.op5.se (Postfix) with ESMTP id 6E7B41F08857;
	Tue, 12 Feb 2008 13:21:54 +0100 (CET)
User-Agent: Thunderbird 2.0.0.9 (X11/20071115)
In-Reply-To: <36ca99e90802120318y5099b06cta3f8488dc758f6@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73656>

Bert Wesarg wrote:
> Hi,
> 
> On Feb 12, 2008 9:20 AM, Andreas Ericsson <ae@op5.se> wrote:
>> +#ifdef THREADED_DELTA_SEARCH
>> +# ifdef _SC_NPROCESSORS_ONLN
>> +       long ncpus;
>> +
>> +       if ((ncpus = (long)sysconf(_SC_NPROCESSORS_ONLN)) > 0)
>> +               return (int)ncpus;
>> +# else
> I can't find the right pointer, but for linux it would be more usable
> to use sched_getaffinity(). Than you can do thinks like this:
> 
> $ taskset 0x3 git gc ...
> 
> and you will get 2 cpus, even 4 are online.
> 

Since you can do roughly the same by saying "git pack-objects --threads=2",
I'd rather not add a GNU/Linux specific hack for this.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
