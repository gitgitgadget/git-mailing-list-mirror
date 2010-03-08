From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/12] Support columinized output in
 tag/branch/ls-files/grep
Date: Mon, 08 Mar 2010 15:08:46 -0800
Message-ID: <7vmxyijts1.fsf@alter.siamese.dyndns.org>
References: <1267963785-473-1-git-send-email-pclouds@gmail.com>
 <4B9504C9.5000703@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Tue Mar 09 13:32:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NoyS2-0001Do-Tm
	for gcvg-git-2@lo.gmane.org; Tue, 09 Mar 2010 13:22:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755914Ab0CHXI4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Mar 2010 18:08:56 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:57775 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755723Ab0CHXIz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Mar 2010 18:08:55 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8B264A0A07;
	Mon,  8 Mar 2010 18:08:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=QaCY4FAGBnVU
	siIku3/uJmXB+Jk=; b=crQIDntXooh1EFadt9CTaDSBJD+jAMvn36LIwSO3tnk2
	qEYHlXwobG3v+aEwGRTyZBYeyvg80YOWGndkTZYM4+uauGHNsEL6SsdZfHqStJWe
	0Lp91zXuUThtv06Hl2CP4fppntBTCuCP0qIp2m+MZlnJAOMh0H5v7Q1KkJp0gGc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=R59nmJ
	vIoZbjbEIDN7diUdcVVHBTgm+rxiXc2yMGNU21j4rHDE6Xl6UcdHFo1C+j/pkdbB
	JtB2BQ9KU9Lt81KqMrb5+WFQghZvb4MfFI7rxhtjib0vT4Y6ch1urKchUccwZGr8
	0GUxlNt1LjEpDfzM4fs2kMzZBgRh8oQRxkUHQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5149BA0A05;
	Mon,  8 Mar 2010 18:08:51 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A4F35A0A01; Mon,  8 Mar
 2010 18:08:47 -0500 (EST)
In-Reply-To: <4B9504C9.5000703@lsrfire.ath.cx> (=?utf-8?Q?=22Ren=C3=A9?=
 Scharfe"'s message of "Mon\, 08 Mar 2010 15\:08\:09 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8F46A300-2B07-11DF-AF6A-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141812>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> Am 07.03.2010 13:09, schrieb Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Du=
y:
>> This adds support to show columnized output in the mentioned command=
s.
>
> That's a good idea.
>
> I'm not so sure about the interface, though.  Does the task really
> warrant adding a new git command?
>
> If a --column parameter is added, I think it should expose the full
> range of options, i.e. fill columns first (ls -C style), fill rows fi=
rst
> (ls -x style) as well as off (ls -1 style) and auto.
>
> Shouldn't the columnizer use utf8_width() instead of strlen(), like
> strbuf_add_wrapped_text() in utf8.c?

I agree with all the above.  Also I think it should not be able to chan=
ge
the behaviour of these commands so much without being explicitly asked
from the command line, especially for plumbing commands like ls-files.
IOW, introduction of the configuration variable without thinking things
through is a bad idea.
