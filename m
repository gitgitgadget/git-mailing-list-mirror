From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How to use git attributes to configure server-side checks?
Date: Fri, 17 Feb 2012 11:59:55 -0800
Message-ID: <7vy5s1s01w.fsf@alter.siamese.dyndns.org>
References: <4E7A3BDE.3040301@alum.mit.edu>
 <7vy5xh1whq.fsf@alter.siamese.dyndns.org> <4F3E9F86.3070802@alum.mit.edu>
 <7vd39dtg5t.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	git discussion list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 17 21:00:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RyTyP-0003IN-Qb
	for gcvg-git-2@plane.gmane.org; Fri, 17 Feb 2012 21:00:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752199Ab2BQT77 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Feb 2012 14:59:59 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59061 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752119Ab2BQT76 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Feb 2012 14:59:58 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 97A3F749F;
	Fri, 17 Feb 2012 14:59:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KKntFdGyxrF4nSsb6zwWp8A+8WM=; b=QtCvwB
	z9qf/0TXkWrRldN9bqvAscTZIEByHNpCXGezBPb55RF0v6mpo4Z1Rbjnf6bHe5bI
	/tDJncX4Iv46xwPOnunLnwYHf31w+IkOpl+m+qQMvH9F1BMN3P8wTxMt6dcbei5W
	GwKAMhqB8NDcSrumiUMQf7OcJUz10REml94jA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wmzXesRk++cacguBtkOyXjEC18nfwZhF
	2nEBc34DKWF1HYfgf7bFOwcTUkn3X6Z5jdZxCMnrDvMsGg55Yn67C7B8tREmyMqS
	r33qdAAyp58lBVdrLm9AiLSV1UwsH0EXAXs65hChG0CPKl5FLUiAxn/w3ae7kQGB
	SRJeY2KeZ6c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 903F0749E;
	Fri, 17 Feb 2012 14:59:57 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 11726749D; Fri, 17 Feb 2012
 14:59:56 -0500 (EST)
In-Reply-To: <7vd39dtg5t.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri, 17 Feb 2012 11:26:38 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F74367DE-59A1-11E1-AF23-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190977>

Junio C Hamano <gitster@pobox.com> writes:

> Michael Haggerty <mhagger@alum.mit.edu> writes:
>
>> I was just alerted by Scott Chacon's blog [1] to the fact that one can
>> set GIT_INDEX_FILE to an arbitrary filename, thereby causing the index
>> to be read/written from that file instead of $GIT_DIR/index.
>
> That's very old fashioned.  For almost five years, the preferred way to
> say that has been "git read-tree --index-output=file" ;-)

Ah, I take that back.

There is any benefit to be had by using "read-tree --index-output" in the
way used in your check-attr example.  Setting up a single GIT_INDEX_FILE
and using it throughout as you did is indeed much more preferrable.

> But what you outlined should work.
