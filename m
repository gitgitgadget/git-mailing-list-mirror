From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [FIXED PATCH] Make rebase save ORIG_HEAD if changing current
 branch
Date: Mon, 07 Jul 2008 15:33:25 -0700
Message-ID: <7vk5fx1g0a.fsf@gitster.siamese.dyndns.org>
References: <1215379370-34265-1-git-send-email-benji@silverinsanity.com>
 <7v7iby9ucx.fsf@gitster.siamese.dyndns.org>
 <803A3528-2451-4C5D-A48D-5E0C37B8E90E@silverinsanity.com>
 <7vbq1a8ay3.fsf@gitster.siamese.dyndns.org>
 <7vod591hlp.fsf@gitster.siamese.dyndns.org>
 <m3tzf1e3ze.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Brian Gernhardt <benji@silverinsanity.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 08 00:34:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFzI7-0000LG-Qu
	for gcvg-git-2@gmane.org; Tue, 08 Jul 2008 00:34:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754019AbYGGWdl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jul 2008 18:33:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754003AbYGGWdl
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jul 2008 18:33:41 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:41024 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753949AbYGGWdk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jul 2008 18:33:40 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id BF2AB26087;
	Mon,  7 Jul 2008 18:33:37 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 0D5C326086; Mon,  7 Jul 2008 18:33:33 -0400 (EDT)
In-Reply-To: <m3tzf1e3ze.fsf@localhost.localdomain> (Jakub Narebski's message
 of "Mon, 07 Jul 2008 15:14:49 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: BDF2C27E-4C74-11DD-951B-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87662>

Jakub Narebski <jnareb@gmail.com> writes:

>> @@ -289,10 +299,10 @@ notation is used.  E.g. "`{caret}r1 r2`" means commits reachable
>>  from `r2` but exclude the ones reachable from `r1`.
>>  
>>  This set operation appears so often that there is a shorthand
>> -for it.  "`r1..r2`" is equivalent to "`{caret}r1 r2`".  It is
>> -the difference of two sets (subtract the set of commits
>> -reachable from `r1` from the set of commits reachable from
>> -`r2`).
>> +for it.  When you have two commits `r1` and `r2` (named according
>> +to the syntax explained in SPECIFYING REVISIONS above), you can ask
>> +for commits that are reachable from r2 but not from r1 by
>> +"`{caret}r1 r2`" and it can be written as "`r1..r2`".
>
> I'm not sure if the last part is improvement, and it wouldn't be better
> to say rather than r1..r2 / ^r1 r2 are "commits that are reachable from
> r2, excluding those commits which are reachable from r1" (which translates
> into set difference / subtracting set of commits.

I tried to make it easier to understand by people without having to know
what a set difference is, and that was the reason I did not use "subtract"
nor "difference", as I saw somebody was quoting the above part in #git was
wondering what it was talking about.
