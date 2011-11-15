From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH, v2] tag: implement --[no-]strip option
Date: Mon, 14 Nov 2011 23:17:36 -0800
Message-ID: <7vy5vhx3an.fsf@alter.siamese.dyndns.org>
References: <1321307019-5557-1-git-send-email-kirill@shutemov.name>
 <4EC209C7.6090805@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Kirill A. Shutemov" <kirill@shutemov.name>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Nov 15 08:17:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQDH5-0004wc-Aj
	for gcvg-git-2@lo.gmane.org; Tue, 15 Nov 2011 08:17:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752877Ab1KOHRj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Nov 2011 02:17:39 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54617 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752736Ab1KOHRi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Nov 2011 02:17:38 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 19E592579;
	Tue, 15 Nov 2011 02:17:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ht9S40Bl9+P27UkSoLuGP6fPXOU=; b=dtiXgA
	speuRoePcnaw8OLdWbHw/7ZIo/Somgp/OAhv3XwJQedmHS0FHdPV3UrM8Fh+l29z
	qItU4nAQtKMUFooqTDeu7tzg2M7YRnUuUuViE4zAbKw4HEv1Bkv0OslTg4iw1vlL
	oGhdwlj4W5MmkB6qYYYqDxGz9mv/oyEj7OEBg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=I/kNTPIbLaFOIXc989TwZbPoYSou6GWy
	NaNgHtI8axFrtAS2SN5zVIbiaxEXDxYPXNTdVDQxDG/kSzK5cszjMhOSUF0n7vsz
	MJzToejj1+D2/Q4fwqbA4wXKhVnwLsKwcKB73crBIJ2LI4L9PvOo5wa5vvfZE/Ar
	BARBuBjjeOE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 126E92578;
	Tue, 15 Nov 2011 02:17:38 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 943962577; Tue, 15 Nov 2011
 02:17:37 -0500 (EST)
In-Reply-To: <4EC209C7.6090805@viscovery.net> (Johannes Sixt's message of
 "Tue, 15 Nov 2011 07:42:15 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E5969B24-0F59-11E1-BCCB-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185437>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Am 11/14/2011 22:43, schrieb Kirill A. Shutemov:
>> From: "Kirill A. Shutemov" <kirill@shutemov.name>
>> 
>> --strip::
>> 	Remove from tag message lines staring with '#', trailing spaces
>
> s/staring/starting/
>
>> 	from every line and empty lines from the beginning and end.
>> 	Enabled by default. Use --no-strip to overwrite the behaviour.
>> 
>> --no-strip is useful if you want to take a tag message as-is, without
>> any stripping.
>
> I would like to know why this is useful. Tag messages are for human
> consumption. What benefit is it that whitespace is not stripped? Why are
> lines starting with '#' so important that they need to stay in the tag
> message?

A conversion from foreign SCM comes to mind, but that is somewhat an
unfair comment, given that I know by heart how stripspace works and the
above documentation patch incorrectly describes what it does.

Besides stripping "# comment", stripspace collapses consecutive blank
lines, removes trailing blank lines and trailing whitespaces at the end of
lines.
