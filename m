From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] status: display the SHA1 of the commit being currently processed
Date: Mon, 17 Jun 2013 09:33:51 -0700
Message-ID: <7vvc5cg0i8.fsf@alter.siamese.dyndns.org>
References: <1371471004-9069-1-git-send-email-Mathieu.Lienard--Mayor@ensimag.imag.fr>
	<alpine.DEB.2.00.1306171357440.7683@perkele.intern.softwolves.pp.se>
	<c878cf98bff28ea8b72fb6d33fd9ca85@ensibm.imag.fr>
	<alpine.DEB.2.00.1306171452340.7683@perkele.intern.softwolves.pp.se>
	<0b88af05ea8d4723a870476036992abc@ensibm.imag.fr>
	<51BF26F9.1080900@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mathieu =?utf-8?Q?Li=C3=A9nard--Mayor?= 
	<mathieu.lienard--mayor@ensimag.fr>,
	Peter Krefting <peter@softwolves.pp.se>, git@vger.kernel.org,
	Jorge Juan Garcia Garcia 
	<Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Jun 17 18:34:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UocNX-0005p3-9v
	for gcvg-git-2@plane.gmane.org; Mon, 17 Jun 2013 18:34:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751455Ab3FQQd6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Jun 2013 12:33:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55410 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750723Ab3FQQd5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Jun 2013 12:33:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1D9C428711;
	Mon, 17 Jun 2013 16:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=cJEtuVP2Nopt
	m0xDYKMIcby53ck=; b=UfFdVm9gjq9kFkamHGccUUkmUSSarZqSsWXTqL9zru7l
	vM9WGwPiKpDN0R+nldGwTAkIrDU0qZUFglYV0WVQSEZoEwdwOCZVXWfVLDr+ysFT
	2br3QjGUzpINNf1+nhbdHzNSbIXO1XeejrdqnBOEGf0ozt4UioiyAq+KTRbk8pY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=DnbRxJ
	fv4RPbBAropoKcsUUOFQT9gPCGpeLd6VO/6mTRp+fj5lfsc8yUB+InF1xWRk86PF
	qAUBZVeHaUy5VwHUCCQZX08bwS2ckTyexs+qowAGSTAJ6UC8bwiiRPDwcYeG+udO
	VH1NVwnEk6QLSN2MGNcuTTHug+HvEgHjOFk0Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 123C628710;
	Mon, 17 Jun 2013 16:33:57 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6EE2D2870B;
	Mon, 17 Jun 2013 16:33:56 +0000 (UTC)
In-Reply-To: <51BF26F9.1080900@viscovery.net> (Johannes Sixt's message of
	"Mon, 17 Jun 2013 17:10:49 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B491FAB0-D76B-11E2-9958-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228081>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Am 6/17/2013 15:57, schrieb Mathieu Li=C3=A9nard--Mayor:
>> Le 2013-06-17 15:54, Peter Krefting a =C3=A9crit :
>>> Mathieu Li=C3=A9nard--Mayor:
>>>
>>>> Actually, at first I dealt with it this way:
>>>>
>>>> status_printf_ln(s, color,
>>>>                 _("Splitting %s while rebasing branch '%s' on '%s'=
=2E"),
>>>>          stopped_sha ? stopped_sha : _("a commit"),
>>>>          ....);
>>>>
>>>> Would this be more suitable for translators ?
>>>
>>> Not really, the text surrounding "a commit" might need to be
>>> inflected differently depending on whether it is a SHA-1 or the "a
>>> commit" string. Word order might also be different.
>> Okay, I'll use what you suggested then.
>
> That's not a good idea. Do we already use "%1$" style formats elsewhe=
re?

In the template, we obviously don't.

But my understanding is that the reordering using printf() is the
mechanism we suggest l10n folks to use when the order of parameters
given to printf does not match the preferred word order in the
message in their language.
