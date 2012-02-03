From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 03/13] parseopt: make OPT_INTEGER support hexadecimal
 as well
Date: Fri, 03 Feb 2012 14:59:29 -0800
Message-ID: <7vaa4zmsku.fsf@alter.siamese.dyndns.org>
References: <1328276078-27955-1-git-send-email-pclouds@gmail.com>
 <1328276078-27955-4-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 03 23:59:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RtS6S-0002tZ-GE
	for gcvg-git-2@plane.gmane.org; Fri, 03 Feb 2012 23:59:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752283Ab2BCW7c convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Feb 2012 17:59:32 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38842 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750732Ab2BCW7b convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Feb 2012 17:59:31 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5E60C6AC1;
	Fri,  3 Feb 2012 17:59:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=k6lbTgZFp/cm
	jc7NwAoy0h/TXk0=; b=Xt+cWnZ7h0SdH/Jhs5QhwQjMxBGJabGs++0l5PLUcMSA
	qTS4vb3h5g35mhGJ8dmDHgvCvfMfiEkcsx5uI6AodDGf8b3qU9Z+NSoX912bx7h5
	tPZw7CbJZqV5kt4KSC+7gUsqQamSuZDvn1xhnbNvP1p1i746GxY4+BP0Ae2UIS0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=jnzzLN
	VtE7/F1h7IF8bjNr5GYM5kvKxVK7e3AUi+yXthirOqFIdRCW0TN6kEQsqhNORgr3
	IgKVuszAnpsTtK+cWo2mNaHcC+HG/nH1E9Egp79FQv6fjICZLnbwmv5y5N8cQIzA
	duHkpwB2mgJZi23e5jpxd8m+4htVuIZNW7GXk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5682E6ABF;
	Fri,  3 Feb 2012 17:59:31 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DEB3C6ABE; Fri,  3 Feb 2012
 17:59:30 -0500 (EST)
In-Reply-To: <1328276078-27955-4-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Fri, 3 Feb
 2012 20:34:28 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BB308606-4EBA-11E1-9D89-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189821>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> -		*(int *)opt->value =3D strtol(arg, (char **)&s, 10);
> +		if (!prefixcmp(arg, "0x") || !prefixcmp(arg, "0X"))
> +			*(int *)opt->value =3D strtol(arg + 2, (char **)&s, 16);
> +		else
> +			*(int *)opt->value =3D strtol(arg, (char **)&s, 10);

Can't you just do "strtol(arg, (char **)&s, 0)" instead?
