From: Brian Gernhardt <brian@gernhardtsoftware.com>
Subject: Re: git-grep Bus Error
Date: Sun, 8 Mar 2009 21:19:35 -0400
Message-ID: <5A3896E0-E4F2-4AD1-8106-1E2CC82D18F5@gernhardtsoftware.com>
References: <C36B091A-ABE9-4C74-9E59-4EBD50E3B9F5@gernhardtsoftware.com> <20090308234141.GJ12880@zoy.org> <7vtz63ijoz.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Sam Hocevar <sam@zoy.org>, Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 09 02:21:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LgUBW-0004Fv-Na
	for gcvg-git-2@gmane.org; Mon, 09 Mar 2009 02:21:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754161AbZCIBTk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Mar 2009 21:19:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754011AbZCIBTj
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Mar 2009 21:19:39 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:44356 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753980AbZCIBTj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Mar 2009 21:19:39 -0400
Received: by silverinsanity.com (Postfix, from userid 5001)
	id 5B1951FFC043; Mon,  9 Mar 2009 01:19:28 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [192.168.1.115] (cpe-74-74-137-205.rochester.res.rr.com [74.74.137.205])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTPSA id 996A41FFC043;
	Mon,  9 Mar 2009 01:19:27 +0000 (UTC)
In-Reply-To: <7vtz63ijoz.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112664>


On Mar 8, 2009, at 9:11 PM, Junio C Hamano wrote:

> Sam Hocevar <sam@zoy.org> writes:
>
>>   rm_so and rm_eo are ints on Linux but off_t's on Darwin, hence
>> probably int64_t's here. You should cast the arguments.
>
> That is a very good point.  In fact, "git grep -n -e 'printf.*%\.\*s'"
> reveals that many existing call sites to this form casts the precision
> argument explicitly to "int".
>
> Brian, would this patch help?

Yes, except that the code also depends on printf("%.*s", 0, str)  
working properly.  I just sent a patch which checks for zero width and  
performs the casts.

~~ Brian
