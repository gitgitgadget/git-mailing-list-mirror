From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH try 2] t1301-shared-repo.sh: don't let a default ACL 
 interfere with the test
Date: Tue, 14 Oct 2008 23:30:05 -0700
Message-ID: <7vmyh64bgy.fsf@gitster.siamese.dyndns.org>
References: <1224022020.2699.4.camel@mattlaptop2.local>
 <1224022216.2699.5.camel@mattlaptop2.local>
 <7vzll66c5u.fsf@gitster.siamese.dyndns.org> <48F589EC.6050307@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matt McCutchen <matt@mattmccutchen.net>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Oct 15 08:31:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kpzur-0005ho-6C
	for gcvg-git-2@gmane.org; Wed, 15 Oct 2008 08:31:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751074AbYJOGaP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2008 02:30:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751091AbYJOGaP
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Oct 2008 02:30:15 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:41163 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750861AbYJOGaN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Oct 2008 02:30:13 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 5AF018B62E;
	Wed, 15 Oct 2008 02:30:12 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 1A6578B62B; Wed, 15 Oct 2008 02:30:07 -0400 (EDT)
In-Reply-To: <48F589EC.6050307@viscovery.net> (Johannes Sixt's message of
 "Wed, 15 Oct 2008 08:13:00 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B88C5C30-9A82-11DD-81B4-4F5276724C3F-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98238>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Junio C Hamano schrieb:
> ...
>>> +# Remove a default ACL from the test dir if possible.
>>> +setfacl -k . 2>/dev/null
>>> +
>> 
>> Makes me wonder why this is _not_ inside test-lib.sh where it creates the
>> test (trash) directory.  That way, you would cover future tests that wants
>> to see a saner/simpler POSIX permission behaviour, wouldn't you?
>
> But that would also paper over unanticipated bad interactions with strange
> ACLs that people might set, wouldn't it? By not placing this into
> test-lib.sh there is a higher chance that such an interaction is revealed,
> and we can react on it (educate users or fix the code).

What do you exactly mean by "educate users or fix the code"?  For example,
by not putting this setfacl in test-lib.sh, t1301 revealed that with a
default ACL higher up, "git init --shared" would not work as expected.

Then what?

 - Do you mean, by "educate users", that we teach users not to play fun
   games with ACL in a git controled working tree?

 - Do you mean, by "fix the code", that we teach adjust_shared_perm() to
   deal with ACL?
