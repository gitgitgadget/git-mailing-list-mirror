From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] branch: show rebase/bisect info when possible instead
 of "(no branch)"
Date: Sun, 03 Feb 2013 13:58:40 -0800
Message-ID: <7v1ucx83fz.fsf@alter.siamese.dyndns.org>
References: <1359461574-24529-1-git-send-email-pclouds@gmail.com>
 <1359870520-22644-1-git-send-email-pclouds@gmail.com>
 <vpqpq0hnlb1.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org, Jonathan Niedier <jrnieder@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sun Feb 03 22:59:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U27ap-00044K-OP
	for gcvg-git-2@plane.gmane.org; Sun, 03 Feb 2013 22:59:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753881Ab3BCV6u convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Feb 2013 16:58:50 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41317 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753879Ab3BCV6q convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 3 Feb 2013 16:58:46 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7E4F9C410;
	Sun,  3 Feb 2013 16:58:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=yYcgRAkxmS6Q
	orV86VCbEGVPm7Y=; b=MSZcsCjV5O3zmWr4zd74e4r/c1SOlO+a6PMf1DTaa5z1
	3RXQVpBLo4qTrTitMwDuhFceRSuYOfhKfiVeyVxJ5ZLWyjpYcITzSbHDkHyZ3AGC
	af1VN+AXXUG1NED7pGg2Pv3VjG/fmUnqlZY58M4n/BZVOLhrEUyXJwM5k/mif9Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=R4X3Fe
	igvjxUDxpkZKiyDzRa3UrwMs/2OOKzqHX74nSBn3p0lXSotpdn9gg49prBg6hfPn
	5nNIWkMP2Ev1MZ9TowrW48cunKwJajZHDarZS9KVbEBExAg0v2qS0Nef5t/LkKyP
	R8OpYSRYclNTNYdYV4lkqZmkjuP9SuyVIlApA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 72DCFC40F;
	Sun,  3 Feb 2013 16:58:45 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 65251C40E; Sun,  3 Feb 2013
 16:58:44 -0500 (EST)
In-Reply-To: <vpqpq0hnlb1.fsf@grenoble-inp.fr> (Matthieu Moy's message of
 "Sun, 03 Feb 2013 22:23:46 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E0E52458-6E4C-11E2-8D6E-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215337>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:
>
>> --- a/t/t6030-bisect-porcelain.sh
>> +++ b/t/t6030-bisect-porcelain.sh
>> @@ -164,7 +164,7 @@ test_expect_success 'bisect start: existing ".gi=
t/BISECT_START" not modified if
>>  	cp .git/BISECT_START saved &&
>>  	test_must_fail git bisect start $HASH4 foo -- &&
>>  	git branch > branch.output &&
>> -	test_i18ngrep "* (no branch)" branch.output > /dev/null &&
>> +	test_i18ngrep "* (bisecting other)" branch.output > /dev/null &&
>
> I'd have spelled it (no branch, bisecting other) to make it clear tha=
t
> we're on detached HEAD, and avoid confusing old-timers. But maybe you=
r
> version is enough, I'm not sure.

Yeah, I do not think "bisecting other" alone makes much sense.

What does "other" refer to when you start your bisection at a
detached head?  I personally think "other" has _any_ value in that
message, because "(no branch, bisecting)" gives the same amount of
information, especially because "other" does not say which branch it
refers to at all.
