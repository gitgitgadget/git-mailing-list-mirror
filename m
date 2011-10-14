From: Junio C Hamano <gitster@pobox.com>
Subject: Re: url.<base>.insteadOf with empty value
Date: Fri, 14 Oct 2011 10:57:42 -0700
Message-ID: <7v8von1mnd.fsf@alter.siamese.dyndns.org>
References: <54556728-92C0-4992-9831-0D582C383235@jetbrains.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>
To: Kirill Likhodedov <Kirill.Likhodedov@jetbrains.com>
X-From: git-owner@vger.kernel.org Fri Oct 14 19:57:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REm10-0001mG-DA
	for gcvg-git-2@lo.gmane.org; Fri, 14 Oct 2011 19:57:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752557Ab1JNR5p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Oct 2011 13:57:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55654 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751091Ab1JNR5p (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Oct 2011 13:57:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 16CAE6398;
	Fri, 14 Oct 2011 13:57:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OGK7URS/5PBZHuHiuULPGuyl4ts=; b=l+9cmV
	JYZhLVIaN1aFlcjstHQct76iUmfojG5lukX99vhiQoS0PUpFsgGonDCObR+/FPdS
	zSk/4WaykENYjo6sWyLVz5v0PQhas0pJPFO2BhZtbn8iUrEdRVPcggLeHbNCPjhT
	9H63jHiQbo2HNdKKsHkoVyP0Gvh6AXFpzKO1k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DI/BR0KPdYCmsUjlDqVhPiD8TqRCPvMK
	p0Y280rEjee63kPowjA52mtANVm7Uq4oaPwf0jjohp7PTINjSSNMiuVfC5CLaqU4
	lY5GL7LK/FQ1y9hxyXQ1jnGakpcSJted9hMqbDr0fBikGMiZiRouFkUYGYRg2Z8H
	Xut3wKdj4EA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0ED866397;
	Fri, 14 Oct 2011 13:57:44 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9A2976396; Fri, 14 Oct 2011
 13:57:43 -0400 (EDT)
In-Reply-To: <54556728-92C0-4992-9831-0D582C383235@jetbrains.com> (Kirill
 Likhodedov's message of "Fri, 14 Oct 2011 13:03:53 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0424CAB4-F68E-11E0-8F29-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183587>

Kirill Likhodedov <Kirill.Likhodedov@jetbrains.com> writes:

> If I don't specify any value for url.<base>.insteadOf or url.<base>.pushInsteadOf, Git substitutes all urls for remotes defined in .git/config
>
> Probably that's because any url starts with empty string and thus has to be substituted. 
> But it might be a bit confusing, because on the other hand if no value is given to the property insteadOf, user may expect this property to be ignored.
>
> Please check if current Git behavior is correct. 
>
> If it is not a bug, I'd suggest to add a note to man git-config about this.

Please assume that what the documentation says is clear enough for whoever
wrote it and need no further clarification, so you would need to help them
understand what additional things you may want the documentation to say,
by clarifying "add a note" and "about this" a bit.

The "insteadOf" replacement is meant to apply for any URL we use. I would
be surprised if it did not affect pushURL; it would be a bug if it didn't.

On the other hand, the rewrite done by "pushinsteadof" is meant to apply
only when remote.<any>.url is used for pushing.  See t/t5516-fetch-push.sh
part of the patch for 1c2eafb (Add url.<base>.pushInsteadOf: URL rewriting
for push only, 2009-09-07). It would clarify what the intended interaction
among these configuration variables.

Thanks.
