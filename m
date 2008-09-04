From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Peculiar behavior of git 1.5.6
Date: Thu, 04 Sep 2008 01:35:10 -0700
Message-ID: <7vljy85mwx.fsf@gitster.siamese.dyndns.org>
References: <48BF759B.9090309@lwfinger.net> <48BF97B3.5060309@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Larry Finger <Larry.Finger@lwfinger.net>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Sep 04 10:36:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KbAKJ-0000Rx-AF
	for gcvg-git-2@gmane.org; Thu, 04 Sep 2008 10:36:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752970AbYIDIfU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Sep 2008 04:35:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752387AbYIDIfT
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Sep 2008 04:35:19 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:65303 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752336AbYIDIfS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Sep 2008 04:35:18 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id DFD5072295;
	Thu,  4 Sep 2008 04:35:16 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id C8B6E72292; Thu,  4 Sep 2008 04:35:12 -0400 (EDT)
In-Reply-To: <48BF97B3.5060309@viscovery.net> (Johannes Sixt's message of
 "Thu, 04 Sep 2008 10:09:23 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 66AB6492-7A5C-11DD-9C77-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94907>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Larry Finger schrieb:
>> On one of my systems, I found strange behavior for git-1.5.6.GIT. On the
>> first pull of the linux-2.6 tree, I got a message that one file was not
>> uptodate. When I investigated any possible differences with git-diff,
>> there were none. A subsequent git-pull worked fine. I lost the console
>> output for linux-2.6, but the same thing happened for Linville's
>> wireless-testing, as shown below:
>> 
>> finger@sonylap:~/wireless-testing> git --version
>> git version 1.5.6.GIT
>> finger@sonylap:~/wireless-testing> git pull
>> error: Entry 'drivers/bluetooth/bt3c_cs.c' not uptodate. Cannot merge.
>> fatal: merging of trees 294e21019bac11cb782e8d1893d02ce98ed816a4 and
>> 810d24221c9c532475af90d1b7ba9ca381dc3696 failed
>> Merge with strategy recursive failed.
>> finger@sonylap:~/wireless-testing> git diff > tmp
>> finger@sonylap:~/wireless-testing> cat tmp
>> finger@sonylap:~/wireless-testing> git pull
>> Removed Documentation/usb/auerswald.txt
>> Auto-merged MAINTAINERS
>> ...
>> 
>> Is this a bug in git, an incompatibility between my version and that of
>> the server at kernel.org, or something else?
>
> I guess you had touched the timestamp of drivers/bluetooth/bt3c_cs.c in
> some way without modifying its contents, which made 'git pull' think it is
> modified.
>
> The 'git diff' that you did next corrected this behind your back, so that
> the subsequent 'git pull' did not see any modification anymore. (BTW, if
> you had used 'git status' instead of 'git diff' you would have observed
> the same behavior.)

That still does not explain the symptom --- shouldn't "git pull" or
underlying "git merge"  have first refreshed the index?

1.5.6 is before the C rewrite of git-merge, so it is somewhat surprising
that if there were such bugs, but 1.5.6.GIT does not tell us much...
