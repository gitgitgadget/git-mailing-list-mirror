From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-p4.py: Make submit working on bare repository
Date: Wed, 13 Apr 2016 14:47:37 -0700
Message-ID: <xmqqfuupji4m.fsf@gitster.mtv.corp.google.com>
References: <CAPig+cQA4sJ2RneG8zRsUx+bDPAMYVtmhFjZx5SOGDqnsKNUaQ@mail.gmail.com>
	<1455919074-5683-1-git-send-email-aidecoe@aidecoe.name>
	<xmqq7fi0b9rt.fsf@gitster.mtv.corp.google.com>
	<87fuwnd4u7.fsf@freja.aidecoe.name>
	<xmqqbn7aa522.fsf@gitster.mtv.corp.google.com>
	<877fhwd1g0.fsf@freja.aidecoe.name>
	<xmqqegc33oal.fsf@gitster.mtv.corp.google.com>
	<CAE5ih7_vBMsi+zRZRTCaO56VrOYZUR0NQ0CSSE+Do48xkJ_BwA@mail.gmail.com>
	<871t83cfi7.fsf@freja.aidecoe.name>
	<CAE5ih7-rBuipoAGEnK60iidi1nYA9xWZQV6jRMHTVQe6f=cQag@mail.gmail.com>
	<87si0cpnpn.fsf@freja.aidecoe.name>
	<CAE5ih7-q_PwF-T6nsu=FyyN9wO6o0Jcfkg=gKy5mhOXRGFZ+VA@mail.gmail.com>
	<xmqqtwj6mmtu.fsf@gitster.mtv.corp.google.com>
	<87d1pt5k53.fsf@freja.aidecoe.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Luke Diamand <luke@diamand.org>, Git Users <git@vger.kernel.org>
To: Amadeusz =?utf-8?B?xbtvxYJub3dza2k=?= <aidecoe@aidecoe.name>
X-From: git-owner@vger.kernel.org Wed Apr 13 23:47:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqSdV-0006Mg-EX
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 23:47:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754258AbcDMVrl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Apr 2016 17:47:41 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56225 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754235AbcDMVrk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Apr 2016 17:47:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 48D031212F;
	Wed, 13 Apr 2016 17:47:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=7Tx32BUFTvXk
	6h6SDfLiME8uUb8=; b=YsO9s8Ld/JUIVUbEhLiWlDjE3YqVx2EsTwNbuY9GhGz2
	v8R5+2bHRt80ZDaUYffUTVR5WcNftW7SPPQMJjz+4DI6wPwQjkw4Jy3lLF88mC0p
	ivMcNXt01wJx9tXmSID+733yFkTWONn6FR33MeON5S+dtdOVI9IK07IXTqBZENI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=QWiXGa
	XQ5LY43GhwkMiA0ynKvNVoLR9p0lSeBCgmtbcWwn7QfNNtTP4XFLQ5OG2DIHRulD
	Ax/JBIogShu6RhZfR8pfb3yevWDzUSkuC6dS1//UkT3cg/2rQYQc/taST5t0GTcg
	cVOaCq8MtfWatGqcDldsptGBb4AfOXZnPvxyo=
Received: from pb-smtp2. (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 413C71212E;
	Wed, 13 Apr 2016 17:47:39 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A973E1212D;
	Wed, 13 Apr 2016 17:47:38 -0400 (EDT)
In-Reply-To: <87d1pt5k53.fsf@freja.aidecoe.name> ("Amadeusz =?utf-8?B?xbtv?=
 =?utf-8?B?xYJub3dza2kiJ3M=?=
	message of "Wed, 13 Apr 2016 21:27:52 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 57579C32-01C1-11E6-ADAB-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291491>

Amadeusz =C5=BBo=C5=82nowski <aidecoe@aidecoe.name> writes:

>> Has anything happened to this topic after this?  I am wondering if I
>> should discard the topic az/p4-bare-no-rebase without prejudice.
>
> Sorry, I haven't got time to take a loot at this, but I'll return to
> that soon, OK? I'll prepare a patch with an option to skip rebase rat=
her
> than do it only for bare repos.

No hurries.

With or without an option, I think the documentation needs to
clarify when it is safe to omit rebase and why.
