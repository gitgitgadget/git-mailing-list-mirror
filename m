From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-p4.py: Make submit working on bare repository
Date: Tue, 12 Apr 2016 16:25:33 -0700
Message-ID: <xmqqtwj6mmtu.fsf@gitster.mtv.corp.google.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Amadeusz =?utf-8?B?xbtvxYJub3dza2k=?= <aidecoe@aidecoe.name>,
	Git Users <git@vger.kernel.org>
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Wed Apr 13 01:25:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aq7gk-00030I-0b
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 01:25:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934423AbcDLXZh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Apr 2016 19:25:37 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:57171 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933934AbcDLXZg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Apr 2016 19:25:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2CFFC551CF;
	Tue, 12 Apr 2016 19:25:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=CE4QXGavtapY
	NpGW9ft4YRw/umM=; b=rE1RUysM+Kxwo2chuh7vXMsoC3/XXYTglG3/cXb2rVQC
	db0KUAwJfEYQMGkrpjd9hkP6jGzytdXuPUWNR71NPkysjG+CFBhW4/LTZEGD6sFP
	QRNbpUOzeou4c0QzsFA2jgy24Ulp1+1709KBdN4DZPo07h58bXr2vr5nBUjQGKE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=xIOygz
	Jdl89LoPMSarTPgn/SheLdhbkRxMjQZaBkD5BesnYTACNmCGDTYWxvdxCH86aiSx
	5Wv58wnAMkTA3LOBEzuONjgTJXOMOxjbbvFiLt8Aog61m7vhsI2hNzFWbaX0iP5u
	utvh80uwMq78RhV+s/ASXU6mjC3xDNaGiQ+S0=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2386C551CE;
	Tue, 12 Apr 2016 19:25:35 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 921D7551CB;
	Tue, 12 Apr 2016 19:25:34 -0400 (EDT)
In-Reply-To: <CAE5ih7-q_PwF-T6nsu=FyyN9wO6o0Jcfkg=gKy5mhOXRGFZ+VA@mail.gmail.com>
	(Luke Diamand's message of "Mon, 29 Feb 2016 15:29:02 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: DB3DD2DA-0105-11E6-8002-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291325>

Luke Diamand <luke@diamand.org> writes:

> On 28 February 2016 at 20:46, Amadeusz =C5=BBo=C5=82nowski <aidecoe@a=
idecoe.name> wrote:
>
>>
>> True. For now I have these cases covered by wrapper scripts. The min=
imum
>> I need from git-p4 is just not to fail on git submit from bare
>> repository which is covered by patch I have submitted. If I get my
>> solution enough testing, I'd think of transforming it into patch for
>> git-p4.py as well.
>
> Could you change the patch to add a command-line option to suppress
> the rebase? I think this would be a bit more obvious: instead of
> having some special magical behaviour kick-in on a bare repo, git-p4
> just does what it's told on the command-line.
>
> It means that if we find another situation where we don't want to
> rebase, we don't have an ever-growing list of special-case
> circumstances, which could become hard to make sense of in future.
> Instead, the user (who hopefully knows better) just tells git-p4 what
> to do.

Has anything happened to this topic after this?  I am wondering if I
should discard the topic az/p4-bare-no-rebase without prejudice.

Thanks.
