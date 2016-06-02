From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 28/39] i18n: config: unfold error messages marked for translation
Date: Thu, 02 Jun 2016 10:36:18 -0700
Message-ID: <xmqq7fe7v6gd.fsf@gitster.mtv.corp.google.com>
References: <1464799289-7639-1-git-send-email-vascomalmeida@sapo.pt>
	<1464799289-7639-29-git-send-email-vascomalmeida@sapo.pt>
	<xmqqzir4yfcq.fsf@gitster.mtv.corp.google.com>
	<574FFC49.9040409@sapo.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Sunshine <sunshine@sunshineco.com>
To: Vasco Almeida <vascomalmeida@sapo.pt>
X-From: git-owner@vger.kernel.org Thu Jun 02 19:36:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8WXj-0005JE-Q3
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jun 2016 19:36:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753468AbcFBRgX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Jun 2016 13:36:23 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60298 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751963AbcFBRgW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Jun 2016 13:36:22 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1DCF31E7BE;
	Thu,  2 Jun 2016 13:36:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=3Zcp/R3+eHmT
	1shipXHnpVZBPjE=; b=s8NpIivn/MrgjX02BMLh2Efl2gMspSD3AXhfxqlqYKDk
	2XR0o0AbEL/fIctOAlV2nYhA+X4DXhOP3WLHAjzmZoFjD9+yF+rZQFfEo4+6AwOP
	wETew6EPV377Y5BtysXkO4JaVNtwhj0RVW7EfUC6JyyqUb6R2YTcl2k+/bIHAM8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=s24KQa
	O0J1rAwEAB5QwDKiRqwwkX4b0miWaZDA4BGFfNt+OAGiKElzBqZRCKbeGa2rJwdT
	aQ4VVnOR8U3WK1TyUKpzVF5mZJ3ES/2Weah2Mp+L2KpMWEP2MMqqtDgafJ3Wdz/2
	wVkr2y8p4/DvJ4GDcUYcp2ynErHd/XykeM0QQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 148411E7BD;
	Thu,  2 Jun 2016 13:36:21 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 89D021E7BC;
	Thu,  2 Jun 2016 13:36:20 -0400 (EDT)
In-Reply-To: <574FFC49.9040409@sapo.pt> (Vasco Almeida's message of "Thu, 2
	Jun 2016 09:28:41 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 84C4EB0E-28E8-11E6-8C71-89D312518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296218>

Vasco Almeida <vascomalmeida@sapo.pt> writes:

> =C3=80s 17:43 de 01-06-2016, Junio C Hamano escreveu:
>> Vasco Almeida <vascomalmeida@sapo.pt> writes:
>>=20
>>> Introduced in 473166b ("config: add 'origin_type' to config_source
>>> struct", 2016-02-19), Git can inform the user about the origin of a
>>> config error, but the implementation does not allow translators to
>>> translate the keywords 'file', 'blob, 'standard input', and
>>> 'submodule-blob'. Moreover, for the second message, a reason for th=
e
>>> error is appended to the message, not allowing translators to trans=
late
>>> that reason either.
>>=20
>> Good intentions.
>>=20
>>> @@ -417,6 +417,7 @@ static int git_parse_source(config_fn_t fn, voi=
d *data)
>>>  	int comment =3D 0;
>>>  	int baselen =3D 0;
>>>  	struct strbuf *var =3D &cf->var;
>>> +	char error_msg[128];
>>> =20
>>>  	/* U+FEFF Byte Order Mark in UTF8 */
>>>  	const char *bomptr =3D utf8_bom;
>>> @@ -471,10 +472,38 @@ static int git_parse_source(config_fn_t fn, v=
oid *data)
>>>  		if (get_value(fn, data, var) < 0)
>>>  			break;
>>>  	}
>>> +
>>> +	switch (cf->origin_type) {
>>> +	case CFG_BLOB:
>>> +		xsnprintf(error_msg, sizeof(error_msg),
>>> +			  _("bad config line %d in blob %s"),
>>> +			  cf->linenr, cf->name);
>>=20
>> Use xstrfmt() intead, perhaps?  That would be cleaner.
>>=20
> Wouldn't that create a memory leak?

Yes, I didn't mean to suggest "use xstrfmt() instead of xsnprintf()
without changing anything else".  It was merely to suggest that you
do not have to have 128-byte limit if you used xstrfmt(); having to
free the result was too obvious that I left it unsaid, and as expected,
you noticed the need to do so, which is good ;-)
