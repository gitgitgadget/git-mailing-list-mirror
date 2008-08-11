From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-bisect: weird usage of read(1)
Date: Mon, 11 Aug 2008 11:59:52 -0700
Message-ID: <7v7ianxtqv.fsf@gitster.siamese.dyndns.org>
References: <38b2ab8a0808110657y24ac9526wca4acea3bddaec00@mail.gmail.com>
 <alpine.DEB.1.00.0808111615260.24820@pacific.mpi-cbg.de.mpi-cbg.de>
 <38b2ab8a0808110718x2f63608ga3d2d77e317ce4eb@mail.gmail.com>
 <3f4fd2640808110859r148550d2h833dae05b9e6544e@mail.gmail.com>
 <20080811164945.GI32184@machine.or.cz> <48A0705B.3030107@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Petr Baudis <pasky@suse.cz>, Reece Dunn <msclrhd@googlemail.com>,
	Francis Moreau <francis.moro@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Mon Aug 11 21:01:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KScdf-0000zX-4g
	for gcvg-git-2@gmane.org; Mon, 11 Aug 2008 21:01:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754010AbYHKTAG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Aug 2008 15:00:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752302AbYHKTAF
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Aug 2008 15:00:05 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:39862 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754010AbYHKTAE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Aug 2008 15:00:04 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 7B90655C84;
	Mon, 11 Aug 2008 15:00:02 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 0070655C7E; Mon, 11 Aug 2008 14:59:54 -0400 (EDT)
In-Reply-To: <48A0705B.3030107@lsrfire.ath.cx> (=?utf-8?Q?Ren=C3=A9?=
 Scharfe's message of "Mon, 11 Aug 2008 19:01:15 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B3E85856-67D7-11DD-9B56-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91975>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> Petr Baudis schrieb:
>> On Mon, Aug 11, 2008 at 04:59:32PM +0100, Reece Dunn wrote:
>>>>> On Mon, 11 Aug 2008, Francis Moreau wrote:
>>>>>>               case "$(read yesno)" in [Nn]*) exit 1 ;; esac
>>> does not work as expected. Replacing this with
>>>
>>>                case "$(read yesno; echo $yesno)" in [Nn]*) exit 1 ;=
; esac
>>>
>>> would work as intended, as Mikael has pointed out.
>>=20
>>   Wouldn't it be more elegant to
>>=20
>> 	case "$(head -n 1)" in [Nn]*) exit 1 ;; esac
>
> Only if head is a built-in, otherwise you fork needlessly.  Not that
> this is a performance critical part, but I wouldn't call it "elegant"=
=2E
>
> What's wrong with the following variant, already used a few lines up =
in
> the file?
>
> 	read yesno
> 	case "$yesno" in [Nn]*) exit 1 ;; esac

That's the right way to spell it.  Sorry, I must have been too tired
when I did this.
