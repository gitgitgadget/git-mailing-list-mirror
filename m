From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Why is ident_is_sufficient different on Windows?
Date: Wed, 06 Feb 2013 12:52:39 -0800
Message-ID: <7vbobxb1wo.fsf@alter.siamese.dyndns.org>
References: <991CBC1C-912C-4DD6-B911-93F6B41D895E@quendi.de>
 <7vmwvhb2fm.fsf@alter.siamese.dyndns.org>
 <7vip65b25c.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Max Horn <max@quendi.de>
X-From: git-owner@vger.kernel.org Wed Feb 06 21:53:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3BzN-0001ia-EH
	for gcvg-git-2@plane.gmane.org; Wed, 06 Feb 2013 21:53:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758516Ab3BFUwm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2013 15:52:42 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63442 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758121Ab3BFUwl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2013 15:52:41 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 467C4B060;
	Wed,  6 Feb 2013 15:52:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ALaZfbwlSgAOeSZEj8e6FW1ncFM=; b=BPRQud
	VaKWEangPDdEghed0vyoRgjtgskDXBO3fQSJJAAzZDf7fYS7WaWoVXEEjnTD968Q
	9SqDxwIIlqB8ccwQoVfoZ9lARRzzjP9dMgYaWpdxqUA+gmngtLfkxu5JnJh/vIAR
	wt+fHDu+EAF8vAQr1YDguMIkpzBMLF8bOBWpE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TyDS0IGNnzT7nQBlj87tVvvrSScLnXgA
	Ln/T3XdwMRGZAehy6dJV4c4MJXiUuGQjBoHytmiCi4d/r6FPimjVFqceVVwBhnPN
	c5Zuy//jTRlG0YwuHHvRoi863CyyeED8fS/tNY2xiSY/EY/LqEjgHDBW4B7zMVEy
	JpMzqj+5N1A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 381E0B05F;
	Wed,  6 Feb 2013 15:52:41 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B3859B05C; Wed,  6 Feb 2013
 15:52:40 -0500 (EST)
In-Reply-To: <7vip65b25c.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 06 Feb 2013 12:47:27 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2599007A-709F-11E2-B231-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215641>

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> I suspect somebody from the Windows camp saw a patch I posted
>> without the ifdef, noticed that there is a problem to expect
>> IDENT_NAME_GIVEN to be set on Windows for some reason, and resulted
>> in a reroll of the function in that shape.
>>
>> I didn't find anything in the list archive, though.  So I am
>> stumped.
>
> The only thing I can think of is that on Unix we can guess name from
> GECOS, which could be considered sufficiently your name, while on
> Windows we probably do not get anything useful there.

http://thread.gmane.org/gmane.comp.version-control.git/137312/focus=137345

These days, we encourage setting user.name explicitly even on a
system on which it is likely that we will see a good GECOS value, so
removing the ifdef and always check with ALL may not hurt anybody.
I dunno.
