From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] tests: turn on test-lint-shell-syntax by default
Date: Tue, 15 Jan 2013 12:38:44 -0800
Message-ID: <7vk3re2ncb.fsf@alter.siamese.dyndns.org>
References: <201301120650.46479.tboegi@web.de>
 <7vvcb37xfe.fsf@alter.siamese.dyndns.org> <50F28BB5.9080607@web.de>
 <20130113173207.GC5973@elie.Belkin> <7v4nikiu81.fsf@alter.siamese.dyndns.org>
 <50F5B83E.9060800@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	kraai@ftbfs.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Jan 15 21:39:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvDHo-0001MI-7P
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jan 2013 21:39:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755388Ab3AOUir convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Jan 2013 15:38:47 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62245 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754929Ab3AOUiq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Jan 2013 15:38:46 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 613B4A64F;
	Tue, 15 Jan 2013 15:38:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=REd5U89xrlwp
	PSD6Tt/LtdPfGig=; b=MXrJST2APJpeW29NAuDJf4H0DUCpC8/gZX/+6TrpTtQf
	7/afL0gbXNUHVuoDkuLZZVThNLA+SzpLv52E8LNZmqqYZrHL1OBEjFPStwzzIYBr
	4O3515UKHe6UsECNzBEq4nexAmGvyKx2Oklx4q5B4PehegxpGpTU/wKxGmIN2gA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=hwBUJx
	5loil0okv4oIOSr3nt/xFuJiz30e/jQ3p/VN4ilIGKhyJpMJfB/pN8+GvrhDCxPR
	+T0XpsD5KhmaCYKqvlopqDN3BmQ3Do7GKT0rNyV0jPxalZ9LqJkrDAUjXzRmvfFJ
	xxMbW0BNJhYD7fS3pMelMoOSGspFUepfdWIyA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 56763A64E;
	Tue, 15 Jan 2013 15:38:46 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B7D8AA64D; Tue, 15 Jan 2013
 15:38:45 -0500 (EST)
In-Reply-To: <50F5B83E.9060800@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of "Tue, 15 Jan 2013 21:12:46 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8ED24CFC-5F53-11E2-9C3F-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213673>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> What do we think about something like this for fishing for which:
>
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -644,6 +644,10 @@ yes () {
>                 :
>         done
>  }
> +which () {
> +       echo >&2 "which is not portable (please use type)"
> +       exit 1
> +}
>
>
> This will happen in runtime, which might be good enough ?

	if (
		which frotz &&
                test $(frobonitz --version" -le 2.0
	   )
        then
		test_set_prereq FROTZ_FROBONITZ
	else
		echo >&2 "suitable Frotz/Frobonitz combo not available;"
                echo >&2 "some tests may be skipped"
	fi

I somehow think this is a lost cause.
