From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] for-each-ref: add split message parts to %(contents:*).
Date: Thu, 01 Sep 2011 09:00:39 -0700
Message-ID: <7vbov4xnfc.fsf@alter.siamese.dyndns.org>
References: <4E5CB0D0.7000905@drmicha.warpmail.net>
 <1314781909-19252-1-git-send-email-mgorny@gentoo.org>
 <7vy5y9xkd0.fsf@alter.siamese.dyndns.org>
 <20110831232201.GA29296@sigill.intra.peff.net>
 <20110901093450.57512480@pomiocik.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org, Michael J Gruber <git@drmicha.warpmail.net>
To: =?utf-8?B?TWljaGHFgiBHw7Nybnk=?= <mgorny@gentoo.org>
X-From: git-owner@vger.kernel.org Thu Sep 01 18:00:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qz9h8-0003PP-IS
	for gcvg-git-2@lo.gmane.org; Thu, 01 Sep 2011 18:00:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932550Ab1IAQAm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 1 Sep 2011 12:00:42 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56821 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932452Ab1IAQAl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Sep 2011 12:00:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F33AB41B2;
	Thu,  1 Sep 2011 12:00:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=abno9KLWCniH
	29AcFeA3XgIdKso=; b=dM9Min1HGU2qP24M4JqQzJGDao10BbCQnq9diedWv+eV
	MqWvOjsXutsl46gIQmka99ZJ4jDGvlV8pK1BDPIXvkYbpBSM801cSz2deh+n9ft9
	Tr4T657X2c7ZxmCQ7I23aeuLOTUIzGJmQjg1sZToFyqLNaJdqNcNW1HeU/vYfGs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=JuDWON
	DFL9Sq6+fQw8eGrub1BASu+BjVn2OBjosqRrQ82F735nnyq2Db+1HTFDukN9IM4E
	wQTnU0L0FKbmpOO8Scj4jIDjT0Enpot0W0mgDAN8UcKlAprJRyOJoSDq9Yw9sK4S
	nBai8Jyp7grc5xJOQMuPon6UVdcwq5F54VYCE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E794041B0;
	Thu,  1 Sep 2011 12:00:40 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 605C141AF; Thu,  1 Sep 2011
 12:00:40 -0400 (EDT)
In-Reply-To: <20110901093450.57512480@pomiocik.lan> (=?utf-8?Q?=22Micha?=
 =?utf-8?Q?=C5=82_G=C3=B3rny=22's?= message of "Thu, 1 Sep 2011 09:34:50
 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8A34B3F0-D4B3-11E0-ABDF-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180537>

Micha=C5=82 G=C3=B3rny <mgorny@gentoo.org> writes:

> On Wed, 31 Aug 2011 19:22:01 -0400
> Jeff King <peff@peff.net> wrote:
>
>> On Wed, Aug 31, 2011 at 03:54:35PM -0700, Junio C Hamano wrote:
>>=20
>> > > +The complete message in a commit and tag object is `contents`.
>> > > +Its first line is `contents:subject`, the remaining lines
>> > > +are `contents:body` and the optional GPG signature
>> > > +is `contents:signature`.
>> >=20
>> > To match the parsing of commit objects, I would prefer to see
>> > "subject" to mean "the first paragraph" (usually the first line
>> > alone but that is purely from convention), but that probably is a
>> > separate topic.
>>=20
>> Good idea. I suspect pretty.c:format_subject can be reused here.
>
> Should I fix regular 'subject' and 'body' as well, or just
> the 'contents:' variants?

I thought you made them synonyms...
