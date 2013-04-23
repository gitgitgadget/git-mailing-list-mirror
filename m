From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/7] am: suppress error output from a conditional
Date: Tue, 23 Apr 2013 10:29:11 -0700
Message-ID: <7vmwspi2ag.fsf@alter.siamese.dyndns.org>
References: <1366725724-1016-1-git-send-email-artagnon@gmail.com>
	<1366725724-1016-2-git-send-email-artagnon@gmail.com>
	<CANiSa6i+jsZUBgeQcQq2C=d009dU=i6+g35-HoofedaEJRmzTg@mail.gmail.com>
	<CALkWK0mTGFiuYhsJMf0x9YrO2ke21YmhzhiQQmqLqG61=pVFdw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin von Zweigbergk <martinvonz@gmail.com>,
	Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 23 19:29:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUh1v-0007c2-IJ
	for gcvg-git-2@plane.gmane.org; Tue, 23 Apr 2013 19:29:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756798Ab3DWR3Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Apr 2013 13:29:16 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33263 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756695Ab3DWR3O (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Apr 2013 13:29:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 85AD619010;
	Tue, 23 Apr 2013 17:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xtXxDq1NmcmNLmB+XjWj4dwpuSw=; b=xOVLyY
	LBO6htEC7ZfCNSeZqebI4Ts9pczkxVXfPKmhNCChL/TcAxg6P9lUSLktdp4tWMFo
	7h+qj4HTK5p7Qzh0rGiwAm4LUbzueVhRbmrQ7LwqIbU2Sl1iKM4Oz+LV59NoUmr6
	26N5dOSbzdVwWd0m11dc8fQjF4ZInsws175HI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xSGNFnwbC0wQ/w5NT1EDFvlyulHxeLY3
	rQIRn43kwU4t8r+k49mgsBvRva/XrL9gFAUUMpFoOJvBmUnvpeDhMiK/ALEc3vdF
	629xRlmpyM7h3r9jAb4OBJjHulKV3t2gqTyXp6OKubXk6OFwDFvPJH+yYKpV9zLH
	G47cDMJPj4w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 796CD1900E;
	Tue, 23 Apr 2013 17:29:13 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0D1941900C;
	Tue, 23 Apr 2013 17:29:12 +0000 (UTC)
In-Reply-To: <CALkWK0mTGFiuYhsJMf0x9YrO2ke21YmhzhiQQmqLqG61=pVFdw@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Tue, 23 Apr 2013 22:01:25 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 50A575B4-AC3B-11E2-9BA4-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222197>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Martin von Zweigbergk wrote:
>> On Tue, Apr 23, 2013 at 7:01 AM, Ramkumar Ramachandra
>> <artagnon@gmail.com> wrote:
>>> When testing if the $dotest directory exists, and if $next is greater
>>> than $last
>>
>> When can that happen? If one edits the todo?
>
> When git-rebase.sh creates a $dotest directory with just an autostash file :)
>
> Like I said in my cover letter, I really wrote [7/7] first, and kept
> modifying things until all the tests passed.  So, I can't really
> justify these changes independent of [7/7].

That explains a lot of mystery ;-)

Perhaps all of these "oops, 7/7 breaks this and that so let's work
them around" can be avoided if the series did not store the object
name of the stash that records the local changes as a plain text
file inside a $dotest/ directory, and instead used a dedicated ref
somewhere under refs/ hierarchy, no?
