From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] gitweb: Add an option for adding more branch refs
Date: Wed, 27 Nov 2013 12:55:59 -0800
Message-ID: <xmqqob55sgww.fsf@gitster.dls.corp.google.com>
References: <1385566221-7977-1-git-send-email-krzesimir@endocode.com>
	<CAPig+cT=P3ZC9j-WwQjr7gu6RrNgLrXsPkiVmdy5OGYfu8mPqA@mail.gmail.com>
	<CAPig+cR3hoWmDPJyWP6HbpuDvRwgdNj5VwX8A20DCfRBK5OuSQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Krzesimir Nowak <krzesimir@endocode.com>,
	Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Nov 27 21:56:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vlm9k-0002Io-LW
	for gcvg-git-2@plane.gmane.org; Wed, 27 Nov 2013 21:56:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757807Ab3K0U4N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Nov 2013 15:56:13 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43640 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757715Ab3K0U4M (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Nov 2013 15:56:12 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B41655563C;
	Wed, 27 Nov 2013 15:56:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZPqdZNCJ8VtwoiKU3Hzd9jabaKs=; b=llpY9a
	lYx+dXM1MbVjVW7KDld/MQ7X9TMHHYLNPNok85Bdto/5tFZAhRzasTwAAxhm8Jd0
	G0LqSVfaIwYXIzeLVyLZ25wQzx93cEEbwOdpJIBbIOgEppnfSo24b/2jKI7jafvF
	LE6iKQ0m2drWHzFQlYi52EIJBNM7CNgOML9t0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=chxU2APLJSEBYgWzfJAgu0Eg8l4vaFgu
	PuYfeH0mH0cNnUB8Gek2mXK6ZorWFYKWAdnYT8aMxnLfV2C2KPHHBh7i0OuDZHBu
	5UhMu8AMDiRAsH1K7C3QF33fX+HK56sw6NfrP7TQ/iNqQqZm8jokC/Pqgd0pAsRt
	eQdfcgADSCU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9E6605563A;
	Wed, 27 Nov 2013 15:56:11 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AA63A55635;
	Wed, 27 Nov 2013 15:56:09 -0500 (EST)
In-Reply-To: <CAPig+cR3hoWmDPJyWP6HbpuDvRwgdNj5VwX8A20DCfRBK5OuSQ@mail.gmail.com>
	(Eric Sunshine's message of "Wed, 27 Nov 2013 15:38:11 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 579901E4-57A6-11E3-8744-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238464>

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Wed, Nov 27, 2013 at 3:34 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> On Wed, Nov 27, 2013 at 10:30 AM, Krzesimir Nowak
>> <krzesimir@endocode.com> wrote:
>>> Overriding an @additional_branch_refs configuration variable with
>>> value ('wip') will make gitweb to show branches that appear in
>>> refs/heads and refs/wip (refs/heads is hardcoded).

"branches" are by definition what are in refs/heads/ hierarchy, so 

  Allow @additional_branch_refs configuration variable to tell
  gitweb to show refs from additional hierarchies in addition to
  branches in the list-of-branches view.

would be more appropriate and sufficient.

>> Mentioning $ref in the error message would help the user resolve the
>> problem more quickly.
>>
>>> +               die_error(500, '"heads" specified in @additional_branch_refs') if ($ref eq 'heads');
>>
>> Rephrasing this as
>>
>>     "heads" disallowed in @additional_branch_refs
>>
>> would better explain the problem to a user who has only made a cursory
>> read of the documentation.
>
> The program could easily filter out the redundant 'heads', so does
> this really deserve a diagnostic?

True.

I was primarily worried about metacharacters in the specified
strings getting in the way of regexp matches the new code allows on
them, but that has been resolved with the use of \Q..\E; if that
automatic deduping is done, I do not immediately see any remaining
issues in the latest round of the patch.

Thanks.
