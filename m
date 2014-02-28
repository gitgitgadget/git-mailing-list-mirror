From: Junio C Hamano <gitster@pobox.com>
Subject: Re: `git stash pop` UX Problem
Date: Fri, 28 Feb 2014 09:45:59 -0800
Message-ID: <xmqqeh2nw2p4.fsf@gitster.dls.corp.google.com>
References: <1lho9x8.1qh70zkp477M%lists@haller-berlin.de>
	<vpqmwhexidi.fsf@anie.imag.fr> <85fvn40ws9.fsf@stephe-leake.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stephen Leake <stephen_leake@stephe-leake.org>
X-From: git-owner@vger.kernel.org Fri Feb 28 18:46:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJRVx-0004U9-S2
	for gcvg-git-2@plane.gmane.org; Fri, 28 Feb 2014 18:46:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753552AbaB1RqQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Feb 2014 12:46:16 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60395 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753545AbaB1RqN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Feb 2014 12:46:13 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 33E5E6E1CA;
	Fri, 28 Feb 2014 12:46:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mFEp2a0Qnpweez+sOo6+ZN/MBDw=; b=QZK37P
	f7MyWv2hqaKelxjXH6J1FIEXRfovHO+V23vwUbhj5m+OWcEKFPPhB/9yLkVNsAxh
	ytIzs2j7mzRIfManiaQ2fIgRw3fQotcaX9vfN1gYHHNQ8N7JpDHgvGBsVceuiiFB
	Owjp0fYOrhVUb8k2QjRmiOuumTAWiBqX9gz5Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ew96PTOaL5rYZT7Qgz83HQLXgUUkqIet
	UnVlfEvhy0U+2HQDcfXgmsC7GxC7FwcHu6EUwyKNP0WA7tiT/Mtos67pLiNnKXmY
	oe6x3IbGZBIyv2VwKwTa3uPUTEnTR3qEyw9slcK/vYwedO0PCzvfZZM/+piwGzrO
	q64Kc34gK7o=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1BE396E1C9;
	Fri, 28 Feb 2014 12:46:12 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C61F86E1C2;
	Fri, 28 Feb 2014 12:46:05 -0500 (EST)
In-Reply-To: <85fvn40ws9.fsf@stephe-leake.org> (Stephen Leake's message of
	"Thu, 27 Feb 2014 20:57:10 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 32C52332-A0A0-11E3-84A0-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242994>

Stephen Leake <stephen_leake@stephe-leake.org> writes:

> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>> lists@haller-berlin.de (Stefan Haller) writes:
>>
>>> Your intention was clearly to drop the stash, it just wasn't dropped
>>> because of the conflict. Dropping it automatically once the conflict
>>> is resolved would be nice.
>>
>> Your intention when you ran "git stash pop", yes. Your intention when
>> you ran "git add", I call that guessing.
>
> You might be adding other files for other reasons. But if you add a file
> that does resolve a conflict caused by 'git stash pop', it is not
> guessing.

The only thing you know for sure is that the user has consumed _one_
part of the stashed change, no?  What if the stash had changes for
more than one path?

At the time of "git add $path", can you reliably tell if the
conflict to the $path the user is resolving came from a previous
"git stash pop", not from any other mergy operations, e.g. "git
stash apply" or "git apply -3"?
