From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 26/27] struct ref_update: Add type field
Date: Wed, 02 Apr 2014 10:44:47 -0700
Message-ID: <xmqqbnwjvd68.fsf@gitster.dls.corp.google.com>
References: <1395683820-17304-1-git-send-email-mhagger@alum.mit.edu>
	<1395683820-17304-27-git-send-email-mhagger@alum.mit.edu>
	<xmqq8urozuk0.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brad King <brad.king@kitware.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Vicent Marti <tanoku@gmail.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Apr 03 13:06:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WVeTQ-0000xS-Qn
	for gcvg-git-2@plane.gmane.org; Thu, 03 Apr 2014 12:02:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932727AbaDBRov (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Apr 2014 13:44:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62992 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932671AbaDBRou (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Apr 2014 13:44:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DA6A778C55;
	Wed,  2 Apr 2014 13:44:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XNFjebl7L1GoJjf3nVJP/Jg3Oeo=; b=tXykSp
	LY5ZW9vpSLFN9G23CA8UAwfYWyrFVGg19pB4GAFYTTZDTssisRHnr1W6P+tjsNAy
	dEwXQlABtqy+NKtfQ+TbRfYf/rAgl1gA7DTjPq+TBlZt5RvKcaNCExKh7pr/oI1v
	ehdo7TNz/dRo/mUc8VvZvFFsAf+ZtgQi5JTXo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PVWcHFZsj4XSBu7Jh1ZeY4EWcJWW/pmF
	5q6VOUMqbiHsxm3g5IHqupjWIJ1hCMN4scKjORr2zDpshG3UFnR7oWfjBim3gY6u
	950dV6Yqg2omkS29nKpFEkCgUiyOlZUPXoG/0IdG73jSqs02k4QXaGMyxwQ1SmTv
	iFvudythOC4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C569B78C53;
	Wed,  2 Apr 2014 13:44:49 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 19B4478C4E;
	Wed,  2 Apr 2014 13:44:49 -0400 (EDT)
In-Reply-To: <xmqq8urozuk0.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Tue, 01 Apr 2014 13:03:27 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 7CAEAABA-BA8E-11E3-A0CD-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245704>

Junio C Hamano <gitster@pobox.com> writes:

> I wonder if ref-transaction-commit can shrink its parameter list by
> accepting a single pointer to one ref_update?

Disregard this one.  I was fooled into thinking that the function is
called with parameters such as update->old_sha1, update_flags,
update->type when looking at the hunk starting at l.3437; the called
function there is not ref-transaction-commit.

Sorry, and thanks.

>> @@ -3437,7 +3436,7 @@ int ref_transaction_commit(struct ref_transaction *transaction,
>>  					       (update->have_old ?
>>  						update->old_sha1 : NULL),
>>  					       update->flags,
>> -					       &types[i], onerr);
>> +					       &update->type, onerr);
>>  		if (!update->lock) {
>>  			ret = 1;
>>  			goto cleanup;
