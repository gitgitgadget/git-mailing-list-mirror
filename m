From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 18/22] tests: use test_i18n* functions to suppress false positives
Date: Fri, 27 May 2016 12:51:06 -0700
Message-ID: <xmqq37p3qnyt.fsf@gitster.mtv.corp.google.com>
References: <1464031661-18988-1-git-send-email-vascomalmeida@sapo.pt>
	<1464031661-18988-19-git-send-email-vascomalmeida@sapo.pt>
	<xmqqd1o7sa30.fsf@gitster.mtv.corp.google.com>
	<5748A13A.6070608@sapo.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Vasco Almeida <vascomalmeida@sapo.pt>
X-From: git-owner@vger.kernel.org Fri May 27 21:51:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b6Nn3-0005BD-60
	for gcvg-git-2@plane.gmane.org; Fri, 27 May 2016 21:51:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755870AbcE0TvO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 May 2016 15:51:14 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52651 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754558AbcE0TvL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 May 2016 15:51:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 0DF4A1D371;
	Fri, 27 May 2016 15:51:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=6+6Mb4kGWiEy
	Ag+3yySl+RTiouQ=; b=h/K1p6nC4GQFtTcIroiEdjWKUBpRMbz/DNejvj/yujsc
	dk72do+ZhfDLIdDfjxO+RdIJO9P1RSmlbdph4WlEXH8r3PwW8/vepFq7PnGt1YdA
	n6UWDUYyJS5B3JUWAUtQ9U8YQ7h+Pb2R5gPJTobaslXXitGihDIGevGfmqPbXNg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=lxKM7p
	/eXs1VeDp4ZtNrzcwy6dkVxbjDwCrr5FrTLetE6/Fwp54oevGunpOZS8/rDl4F9p
	3HmNcJSu9BJ0YwgGkcqP2JSv72BGWMo+we9C0Gn3sLUXB/AFBqCXojbRFmWO1cRX
	D+kozPukmZcra2g+OHP0OWn180yJAnRluKYqQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 03C081D370;
	Fri, 27 May 2016 15:51:09 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6F3EB1D36F;
	Fri, 27 May 2016 15:51:08 -0400 (EDT)
In-Reply-To: <5748A13A.6070608@sapo.pt> (Vasco Almeida's message of "Fri, 27
	May 2016 19:34:18 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5B032702-2444-11E6-BA9E-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295789>

Vasco Almeida <vascomalmeida@sapo.pt> writes:

> =C3=80s 17:08 de 27-05-2016, Junio C Hamano escreveu:
>> Vasco Almeida <vascomalmeida@sapo.pt> writes:
>>=20
>>> diff --git a/t/t1307-config-blob.sh b/t/t1307-config-blob.sh
>>> index 3c6791e..4079fef 100755
>>> --- a/t/t1307-config-blob.sh
>>> +++ b/t/t1307-config-blob.sh
>>> @@ -64,7 +64,7 @@ test_expect_success 'parse errors in blobs are pr=
operly attributed' '
>>> =20
>>>  	# just grep for our token as the exact error message is likely to
>>>  	# change or be internationalized
>>> -	grep "HEAD:config" err
>>> +	test_i18ngrep "HEAD:config" err
>>>  '
>>=20
>> It is unfortunate that the gettext-poison mechanism is too dumb to
>> notice that it is clobbering a format string with placeholders and
>> leave them intact, which is what the comment above this change is
>> wishing for.  I do not think we will be granting that wish any time
>> soon, so perhaps remove the two lines while we are at it?
>>=20
> Yes, that was more or less what I thought when read that comment, but
> forgot about it after.
> I'll remove that comment in the next re-roll. Also, because it can be
> deceiving for someone not entirely sure how does gettext poison,
> translations and tests work together when test are run.
>
> For the record, test are run under C locale, so translations don't
> matter in tests. Under GETTEXT_POISON build, all strings interpolated=
 by
> gettext (for instance _("a message from git") in C language) are
> replaced by garbage string "# GETTEXT POISON #".

Yes, for the record (as I know you know I know you know this), if we
ever granted the wish the comment expressed, we do not have to use
test_i18ngrep but instead can use grep, following the reasoning in
the comment "Even when running under poison locale, we must have
HEAD:config in the output".

It is unfortunate that poison locale is not that smart.  If it were,
we can lose a lot of test_i18ngrep, not only from here.
