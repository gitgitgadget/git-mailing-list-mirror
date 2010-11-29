From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 1/4] mailinfo.c: convert_to_utf8(): added a
 target_charset parameter
Date: Mon, 29 Nov 2010 12:23:08 -0800
Message-ID: <7vsjyj3mmr.fsf@alter.siamese.dyndns.org>
References: <1290971417-4474-1-git-send-email-r0bertz@gentoo.org>
 <1290971417-4474-2-git-send-email-r0bertz@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "ZHANG\, Le" <r0bertz@gentoo.org>
X-From: git-owner@vger.kernel.org Mon Nov 29 21:23:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNAFv-0001H6-Qk
	for gcvg-git-2@lo.gmane.org; Mon, 29 Nov 2010 21:23:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753325Ab0K2UXT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Nov 2010 15:23:19 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:47347 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752147Ab0K2UXS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Nov 2010 15:23:18 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id CC15E3775;
	Mon, 29 Nov 2010 15:23:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=K0CTkBWMr0eDxH8+bVjcgrH3x7Y=; b=sE4mhhtERB9poucWlqGeM4L
	/f77i0yYCHmeFB65EA3SIeIXq/eyJ7tKJY2m0xiV3PYEEAuz+h5GtTY3nKjTQeTG
	UDoQSfoELvNuTVk9DylBd9u5LF/v6GV+xLRH8DU3ZdRUNbEbPuV7mrXY8b3G5Axl
	/C7RF5D182txzMP0/T8s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=odx+iGpOBv/V66VRl/zBQZmwOYfw+jLvW7YV8MQHssbEJWwlQ
	3TOYSmDEHpoz2VLViZBab4XOjsvDYRZ0fSnvwlHaNjYMguStqoSTfxVvnpVHECa/
	KOJpqhMDFjkuovB6Vk2zDjMo3tUMInPiu++d3HSXZrjjUPKsHlrW7K/pJw=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id AB0593749;
	Mon, 29 Nov 2010 15:23:30 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id AE2A93748; Mon, 29 Nov 2010
 15:23:27 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 87FEF17C-FBF6-11DF-9B04-CDEAE6EC64FC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162421>

"ZHANG, Le" <r0bertz@gentoo.org> writes:

> This is required for my recode-patch patch which needs a seperate patch_charset variable.
>
> Signed-off-by: ZHANG, Le <r0bertz@gentoo.org>
> ---

Thanks.

Please describe what the new parameter means.  Is it used to convert the
contents in "line" from "charset" to "target_charset"?  Perhaps it is a
good time to rename the function to "convert_to()", its "charset"
parameter to "from_charset", and name the new parameter "to_charset", in
order to reduce confusion?

It is not just _your_ patch but will help other/later patches, so you may
want to phrase the proposed commit log message a bit differently (and with
a narrower page width, like 68-74 chars per line).  Perhaps like...

    mailinfo.c: Allow convert_to_utf8() to specify both src/dst charset

    The convert_to_utf8() function actually converts to whatever charset
    "metainfo_charset" variable contains, which is not necessarily UTF-8.
    Rename it to convert_to(), and give an extra parameter "to_charset" to
    specify what charset to re-encode to.  Also rename its "charset"
    parameter to "from_charset" to clarify which is which.
