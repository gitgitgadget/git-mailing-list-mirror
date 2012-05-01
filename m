From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitweb-lib.sh: Set up PATH to use perl from /usr/bin
Date: Tue, 01 May 2012 10:53:50 -0700
Message-ID: <7v8vhbaitt.fsf@alter.siamese.dyndns.org>
References: <201205011323.45190.tboegi@web.de> <4FA00E09.2090708@in.waw.pl>
 <7vsjfjalx6.fsf@alter.siamese.dyndns.org> <4FA0176B.50300@in.waw.pl>
 <20120501170810.GA22444@sigill.intra.peff.net> <4FA02274.6070601@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	Junio C Hamano <gitster@pobox.com>, jnareb@gmail.com,
	git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue May 01 19:54:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPHGx-00067m-2N
	for gcvg-git-2@plane.gmane.org; Tue, 01 May 2012 19:53:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758397Ab2EARxy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 May 2012 13:53:54 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56242 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758379Ab2EARxx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 May 2012 13:53:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DE1BB6783;
	Tue,  1 May 2012 13:53:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=0L32m7Tcgyv1
	3mqnHSvCeOaXTWY=; b=YIyS4E05f5W3BtvHrjSqVlHPGn53dcuAWN15SPa63YAa
	b1yUKsMrmjIfpzpLRDV05t9TT03Rg3soxJQqsUI7k2RJojfxYRvgRAokVjTn44W1
	oNh8v17b2BjycGCN67knHrkKTS/e0xhIbLGyDIf8cy7jpXEs3HEVO6XdPE65g7g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=WJXkbA
	SHfzNEHWGJ5ORFWshC67oYOZVBVjZVXKG7zNMKgPNQKAp8mRtreMHMpKhDtbd/cU
	I8HLTR7kQFHu8GD9oW6kubrYlaulXVGI1nIZbOY6JrOKHvQFM7vOwpqedfD67HI7
	k6+CUqroPzeKRaurcdi325x+k0AcROtf59xck=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D46406782;
	Tue,  1 May 2012 13:53:52 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 52AF56780; Tue,  1 May 2012
 13:53:52 -0400 (EDT)
In-Reply-To: <4FA02274.6070601@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of "Tue, 01 May 2012 19:50:44 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9CE66F26-93B6-11E1-B08C-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196714>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> Thanks for all answers,
>> I think the patch we want is just:
>>=20
>> diff --git a/t/gitweb-lib.sh b/t/gitweb-lib.sh
>> index 21d11d6..ae2dc46 100644
>> --- a/t/gitweb-lib.sh
>> +++ b/t/gitweb-lib.sh
>> @@ -69,7 +69,7 @@ gitweb_run () {
>>  	# written to web server logs, so we are not interested in that:
>>  	# we are interested only in properly formatted errors/warnings
>>  	rm -f gitweb.log &&
>> -	perl -- "$SCRIPT_NAME" \
>> +	"$PERL_PATH" -- "$SCRIPT_NAME" \
>>  		>gitweb.output 2>gitweb.log &&
>>  	perl -w -e '
>>  		open O, ">gitweb.headers";
>>=20
>> no? Torsten, does that fix your problem?
> Yes, it does.
>
> Should we go for that solution ?

Sounds good.
