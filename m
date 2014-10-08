From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH/RFC 0/5] add "unset.variable" for unsetting previously set variables
Date: Wed, 08 Oct 2014 07:46:41 +0200
Message-ID: <vpqzjd7kta6.fsf@anie.imag.fr>
References: <1412256292-4286-1-git-send-email-tanayabh@gmail.com>
	<xmqqvbo2meg5.fsf@gitster.dls.corp.google.com>
	<5433CBC3.5010202@gmail.com>
	<xmqq1tqjkexe.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
	Tanay Abhra <tanayabh@gmail.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 08 07:47:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xbk5d-0000SR-Mr
	for gcvg-git-2@plane.gmane.org; Wed, 08 Oct 2014 07:47:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751336AbaJHFq7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Oct 2014 01:46:59 -0400
Received: from mx2.imag.fr ([129.88.30.17]:58527 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751067AbaJHFq6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Oct 2014 01:46:58 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id s985kfJR002775
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 8 Oct 2014 07:46:41 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s985kf1o026531;
	Wed, 8 Oct 2014 07:46:41 +0200
In-Reply-To: <xmqq1tqjkexe.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Tue, 07 Oct 2014 09:44:29 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 08 Oct 2014 07:46:42 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s985kfJR002775
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1413352005.09183@pOCxd6q4Pr8itmPCDPXluA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Jakub Nar=C4=99bski <jnareb@gmail.com> writes:
>
>> Junio C Hamano wrote:
>>
>>>   - "[config] safe =3D section.variable" will list variables that c=
an
>>>     be included with the config.safeInclude mechanism.  Any variabl=
e
>>>     that is not marked as config.safe that appears in the file
>>>     included by the config.safeInclude mechanism will be ignored.
>>
>> Why user must know which variables are safe, why it cannot be left t=
o
>> Git to know which configuration variables can call external scripts?
>
> That's a fallback to let them take responsibility for variables we
> do not mark as "safe"; and having that fallback mechanism lets us
> keep the set of variables we by default mark as safe to the absolute
> minimum.

Perhaps this would need a way to say "this value is safe for this
variable" too. I don't have a real use-case, but one could say somethin=
g
like "I'm OK with the file overriding core.editor, but the only values =
I
accept are nano, vim and emacs".

It doesn't seem to be a prerequisite to implement the safeInclude
feature, but we should live room in the namespace for the day we want t=
o
add it.

I don't have really good idea for it. The first I could think of was

[config "safe"]
    core.editor =3D nano
    core.editor =3D vim
    core.editor =3D emacs

but it's not accepted by the current parser, hence not backward
compatible.

Emacs has such mechanism for -*- ... -*- local variables in files for
example.

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
