From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] add a Makefile switch to avoid gettext translation in
 shell scripts
Date: Mon, 23 Jan 2012 14:01:15 -0800
Message-ID: <7v1uqq84es.fsf@alter.siamese.dyndns.org>
References: <CALxABCZME-g++HxMsD4Nrn1J6s27vN7M_KQSVT3PeLWBqP7qJg@mail.gmail.com>
 <CACBZZX4TsL-tj04PmUwGNWjXO+JY-8unAv-aRKOGvgB71qdYCg@mail.gmail.com>
 <CALxABCadHdvR02Br9e6STy0w+EPoycUKr62RiSUSP_EPF-TH3g@mail.gmail.com>
 <CACBZZX4tB6DGV-1tiuOamq7ACPk0a-=1Pb9Vk1SgyDqAq-EFOw@mail.gmail.com>
 <CALxABCbaBmP6k5TYrYLCYm8oiv=9cF=N7_opSTKUnbkz5b-cwg@mail.gmail.com>
 <20120119195222.GA5011@blimp.dmz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	=?utf-8?B?w4Z2YXIgQXJuZmo=?= =?utf-8?B?w7Zyw7A=?= Bjarmason 
	<avarab@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 23 23:01:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RpRx6-0005M6-71
	for gcvg-git-2@lo.gmane.org; Mon, 23 Jan 2012 23:01:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753090Ab2AWWBT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jan 2012 17:01:19 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62335 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751353Ab2AWWBS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jan 2012 17:01:18 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E8B0E767E;
	Mon, 23 Jan 2012 17:01:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=upj3S4nZXtnp1k9cg6LEVdsm9pU=; b=edQtpB
	Y5So7yeQy+sFjVFovSvu/AsoRWU5dUmk5PjrJcQ6pKm26EFU2mxiI7DeLYpgcs4q
	If3awnD5q92pu0CKYoPTNXWKJRiLQ4bZdZyzUxGWK0umP2tR01Rijix6GMae71I0
	Jiz84M/nEp82cN3o9BxdJoDi5ZDf0raYP/DNk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=l0jU9szqBLa5snghJcmseAKxMaB1NtRH
	njNRJFlO6yT1SFdDrWsp4/KjiMP9X3xrNBWbAxun9eDV6sYKUuTjjMxkRMdEtthF
	mtfX4Sswlo7F17KmCMQk8Er0cOxMrS+21iUSMwASovXRwol5m9F0H3zvpnJHL+tj
	vHMSxxHtUAI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DB061767D;
	Mon, 23 Jan 2012 17:01:17 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6E4C1767C; Mon, 23 Jan 2012
 17:01:17 -0500 (EST)
In-Reply-To: <20120119195222.GA5011@blimp.dmz> (Alex Riesen's message of
 "Thu, 19 Jan 2012 20:52:22 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C661ACF4-460D-11E1-90AA-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189014>

Alex Riesen <raa.lkml@gmail.com> writes:

> Some systems have gettext.sh (GNU gettext) installed, but it is either broken
> or misconfigured in such a way so its output is not usable.
> For instance, on this particular system, a Cygwin installations gettext
> produces no output whatsoever.
>
> In case the users of these systems are unable or not interested in fixing
> them, setting the new Makefile switch should help:
>
>     USE_FALLTHROUGH_GETTEXT_SCHEME=yes
>
> This will replace the translation routines with fallthrough versions, which
> currently used only for regression testing.
>
> Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
> ---

I'll split this into two, the first one only to restructure the code and
the guts of this one that avoids the autodetection.

Also I'd rename this so that:

	$ make USE_GETTEXT_SCHEME=fallthrough
	$ make USE_GETTEXT_SCHEME=gnu

could be used to avoid extra and unnecessary runtime overhead when the
person building git knows what is on the system.
