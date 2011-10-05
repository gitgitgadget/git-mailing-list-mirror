From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] get_sha1_hex(): do not read past a NUL character
Date: Wed, 05 Oct 2011 13:37:40 -0700
Message-ID: <7v39f76up7.fsf@alter.siamese.dyndns.org>
References: <4E7C857D.8000304@alum.mit.edu>
 <1316785116-21831-1-git-send-email-mhagger@alum.mit.edu>
 <7vaa9vulsw.fsf@alter.siamese.dyndns.org>
 <201110052111.52701.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>, <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Oct 05 22:37:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBYDs-0008AE-NX
	for gcvg-git-2@lo.gmane.org; Wed, 05 Oct 2011 22:37:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757877Ab1JEUho (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Oct 2011 16:37:44 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36762 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756743Ab1JEUhn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Oct 2011 16:37:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BE2265185;
	Wed,  5 Oct 2011 16:37:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5VNPjaJQimah4VxTQRyrvNNkymA=; b=i4My9l
	IGhp/wzejvxgjfHvVLtoa1DCie5cAOdUKoHZ1ZvjfhQ4TIEJUJhFwQ0qvo5MonYd
	N10Dl32r2JIwLzGG0udHv6cGkOxhVqF8O9o4RcBoE1m0IMLX1+JwFvvjfrxs5Oxr
	dqgrt1JrYCKOr2lzbTMlA3EPdctQennkAgO/Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eSWExWRfvB4X9abc4Z4cwklIJiTEmWZL
	lE9pgyiqQbrutJ+X8HXO0Tlhw9lGzYY11/sji6FpJbeRngIciq8EbqYOknr8ojoP
	1/d1qXHOk50j2SahGAjQSZE/0eGDwrBM1T/09B/uFsy9fVgPS8dsjZ6hDZJO127o
	ceyNG2lEf50=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B4D0C5184;
	Wed,  5 Oct 2011 16:37:42 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4A8945183; Wed,  5 Oct 2011
 16:37:42 -0400 (EDT)
In-Reply-To: <201110052111.52701.trast@student.ethz.ch> (Thomas Rast's
 message of "Wed, 5 Oct 2011 21:11:52 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DFAE8060-EF91-11E0-BAC5-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182882>

Thomas Rast <trast@student.ethz.ch> writes:

> Junio C Hamano wrote:
>> Michael Haggerty <mhagger@alum.mit.edu> writes:
>> 
>> > Previously, get_sha1_hex() would read one character past the end of a
>> > null-terminated string whose strlen was an even number less than 40.
>> > Although the function correctly returned -1 in these cases, the extra
>> > memory access might have been to uninitialized (or even, conceivably,
>> > unallocated) memory.
>> >
>> > Add a check to avoid reading past the end of a string.
>> 
>> Makes sense; thanks.
>
> Has this fixed patch ever made it to pu?  I'm still seeing the same
> breakage in the automated valgrind runs.

I do not think so.

I was under the impression that Michael wanted to include this in the
early part of a re-roll of check-ref-format series.

I'll do the rebase myself. Thanks.
