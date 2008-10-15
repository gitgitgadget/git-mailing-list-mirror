From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH try 2] t1301-shared-repo.sh: don't let a default ACL 
 interfere with the test
Date: Wed, 15 Oct 2008 00:57:33 -0700
Message-ID: <7v7i8a47f6.fsf@gitster.siamese.dyndns.org>
References: <1224022020.2699.4.camel@mattlaptop2.local>
 <1224022216.2699.5.camel@mattlaptop2.local>
 <7vzll66c5u.fsf@gitster.siamese.dyndns.org> <48F589EC.6050307@viscovery.net>
 <7vmyh64bgy.fsf@gitster.siamese.dyndns.org> <48F59928.5040502@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matt McCutchen <matt@mattmccutchen.net>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Oct 15 09:58:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kq1HS-000526-4x
	for gcvg-git-2@gmane.org; Wed, 15 Oct 2008 09:58:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752268AbYJOH5m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2008 03:57:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752211AbYJOH5m
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Oct 2008 03:57:42 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:44346 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752069AbYJOH5l (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Oct 2008 03:57:41 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 66A786C072;
	Wed, 15 Oct 2008 03:57:39 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 6EEFE6C06E; Wed, 15 Oct 2008 03:57:35 -0400 (EDT)
In-Reply-To: <48F59928.5040502@viscovery.net> (Johannes Sixt's message of
 "Wed, 15 Oct 2008 09:18:00 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F0080E78-9A8E-11DD-937C-1E1F86D30F62-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98256>

Johannes Sixt <j.sixt@viscovery.net> writes:

>>> But that would also paper over unanticipated bad interactions with strange
>>> ACLs that people might set, wouldn't it? By not placing this into
>>> test-lib.sh there is a higher chance that such an interaction is revealed,
>>> and we can react on it (educate users or fix the code).
>> 
>> What do you exactly mean by "educate users or fix the code"?  For example,
>> by not putting this setfacl in test-lib.sh, t1301 revealed that with a
>> default ACL higher up, "git init --shared" would not work as expected.
>> 
>> Then what?
>> 
>>  - Do you mean, by "educate users", that we teach users not to play fun
>>    games with ACL in a git controled working tree?
>
> Correct. In the case of a shared repository we can educate users not to
> play with ACLs.
>
>>  - Do you mean, by "fix the code", that we teach adjust_shared_perm() to
>>    deal with ACL?
>
> Correct in principle, but we need not go this route in the case of shared
> repositories because we better educate users.

If that is the case what difference does your suggestion of not putting it
in test-lib.sh make?  We discourage users from playing ACL games, and we
protect ourselves from such by making sure the trash directory used for
running tests are not contaminated with ACL.  Wouldn't it make more sense
to do so for all the tests, so that future test writers do not have to
worry about it?
